require 'active_admin/views/components/status_tag'

module ActiveAdmin
  module Globalize3
    module IndexTableFor
      def translation_status
        column I18n.t("active_admin.globalize3.translations") do |obj|
          obj.translation_names.map do |t|
            ActiveAdmin::Views::StatusTag.new.status_tag(t,:ok,:label => t)
          end.join(" ").html_safe
        end
      end
    end
  end
end

