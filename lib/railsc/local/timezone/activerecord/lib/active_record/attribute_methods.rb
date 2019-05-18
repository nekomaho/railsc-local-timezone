# frozen_string_literal: true

module ActiveRecord
  module AttributeMethods
    module LocalDBTimeInspection
      def attribute_for_inspect(attr_name)
        value = read_attribute(attr_name)
        if value.is_a?(Date) || value.is_a?(Time)
          %("#{value.to_s}")
        else
          super(attr_name)
        end
      end
    end

    prepend LocalDBTimeInspection
  end
end
