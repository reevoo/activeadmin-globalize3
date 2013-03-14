require 'active_admin/component'
module ActiveAdmin
  module Globalize3
    module FormBuilderExtension
      extend ActiveSupport::Concern

      def translated_inputs(name = "Translations", &block)
        form_buffers.last << template.content_tag(:div, class: "activeadmin-translations") do
          template.content_tag(:div, class: 'dropdown_menu') do
            [template.content_tag(:a, 'Locale', class: 'dropdown_menu_button', href: '#'),
            template.content_tag(:div, class: 'dropdown_menu_list_wrapper', style: 'display: none;') do
              template.content_tag(:ul, class: 'dropdown_menu_list') do
                I18n.available_locales.map do |locale|
                  classes = ""
                  classes << "untranslated " unless object.translations.find {|t| t.locale == locale} or fallback?(locale)
                  if I18n.methods.include?(:fallbacks)
                    classes << "fallback " if !object.translations.find {|t| t.locale == locale} and fallback?(locale)
                  end
                  classes << "active" if locale == I18n.default_locale
                  formated_locale = "#{locale}: #{I18n.t("active_admin.globalize3.#{locale}")}"
                  template.content_tag(:li) do
                    template.content_tag(:a, formated_locale, href:".locale-#{locale}", class: classes)
                  end
                end.join.html_safe
              end
            end].join.html_safe
          end <<
          I18n.available_locales.sort.map do |locale|
            translation = object.translations.find { |t| t.locale.to_s == locale.to_s }
            translation ||= object.translations.build(locale: locale)
            fallback_locale = fallback?(locale)
            fallback_warning = "<li class=\"fallback\">These translations will fallback to #{fallback_locale} if no translation is given</li>" if fallback_locale
            fields = proc do |form|
              form.input(:locale, as: :hidden)
              form.input(:id, as: :hidden)
              "#{fallback_warning}".html_safe <<
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

      def fallback?(locale) 
        if I18n.methods.include?(:fallbacks)
          I18n.fallbacks[locale].reject {|l| l==locale}.last
        else
          false
        end
      end

      module ClassMethods
      end
    end
  end
end
