module ActiveAdmin::Globalize3
  module ActiveRecordExtension

    module Methods
      def locales
        self.translations.map(&:locale).uniq.sort
      end

      def reject_and_distroy(attributes)
        exists = attributes['id'].present?
        blank = attributes.reject{|k,_| k == "locale" or k == "id" }.values.map(&:blank?).reduce(:&)
        attributes.merge!({:_destroy => 1}) if exists and blank
        !exists and blank
      end
    end

    def active_admin_translates(*args, &block)
      ActiveSupport::Deprecation.warn "active_admin_translates is deprecated in favour of translates", caller
      translates(*args, &block)
    end

    def translates(*args, &block)
      super(*args.dup)
      args.extract_options!

      if block
        translation_class.instance_eval &block
      end
      translation_class.attr_accessible :locale
      translation_class.attr_accessible *args

      attr_accessible :translations_attributes
      accepts_nested_attributes_for :translations, allow_destroy: true, reject_if: :reject_and_distroy

      include Methods
    end

  end
end

