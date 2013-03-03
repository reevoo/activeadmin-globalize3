module ActiveAdmin::Globalize3
  module ActiveRecordExtension

    module Methods
      def translation_names
        self.translations.map(&:locale).map do |locale|
          I18n.t("active_admin.globalize3.language.#{locale}")
        end.uniq.sort
      end

      def reject(attributes)
        exists = attributes['id'].present?
        blank = attributes.reject{|k,_| k == "locale" or k == "id" }.values.map(&:blank?).reduce(:&)
        reject = !exists and blank
      end
    end

    def active_admin_translates(*args, &block)
      translates(*args.dup)
      args.extract_options!

      if block
        translation_class.instance_eval &block
      end
      translation_class.attr_accessible :locale
      translation_class.attr_accessible *args

      attr_accessible :translations_attributes
      accepts_nested_attributes_for :translations, allow_destroy: true, reject_if: :reject

      include Methods
    end

  end
end

