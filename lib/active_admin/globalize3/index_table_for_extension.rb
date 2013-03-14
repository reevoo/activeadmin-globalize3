require 'active_admin/views/components/status_tag'

module ActiveAdmin
  module Globalize3
    module IndexTableFor
      def translation_status
        column I18n.t("active_admin.globalize3.translations") do |obj|
          (translated_locales(obj) + untranslated_locales(obj)).join(" ").html_safe
        end
      end

      private
      def translated_locales(obj)
        obj.locales.map(&:to_s).map do |t|
          ActiveAdmin::Views::StatusTag.new.status_tag(t,:ok,:label => t)
        end
      end

      def untranslated_locales(obj)
        locales = I18n.available_locales - obj.locales
        if I18n.methods.include?(:fallbacks)
          locales = locales.reject {|l| I18n.fallbacks[l].last != l }
        end
        locales.map(&:to_s).map do |t|
          ActiveAdmin::Views::StatusTag.new.status_tag(t,:label => t)
        end
      end
    end
  end
end

