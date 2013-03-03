module ActiveAdmin
  module Globalize3
    module FormBuilderExtension
      extend ActiveSupport::Concern

      def translated_inputs(name = "Translations", &block)
        form_buffers.last << template.content_tag(:div, class: "activeadmin-translations") do
          template.content_tag(:ul, class: "available-locales") do
            I18n.available_locales.map do |locale|
              template.content_tag(:li) do
                classes = ""
                classes << "untranslated " unless object.translations.find {|t| t.locale == locale}
                classes << "active " if locale == I18n.default_locale
                template.content_tag(:a, locale, href:".locale-#{locale}", class: classes)
              end
            end.join.html_safe
          end <<
          I18n.available_locales.sort.map do |locale|
            translation = object.translations.find { |t| t.locale.to_s == locale.to_s }
            translation ||= object.translations.build(locale: locale)
            fields = proc do |form|
              form.input(:locale, as: :hidden)
              form.input(:id, as: :hidden)
              block.call(form)
            end
            inputs_for_nested_attributes(
              name: name,
              for: [:translations, translation ],
              class: "inputs locale locale-#{translation.locale}",
              &fields
            )
          end.join.html_safe
        end
      end

      module ClassMethods
      end
    end
  end
end
