require 'rails'
require 'active_record'

RSpec.describe ActiveRecord::AttributeMethods::LocalDBTimeInspection do
  describe '#attribute_for_inspect' do
    class ParentDummy
      def attribute_for_inspect(attr_name)
        attr_name
      end
    end

    class Dummy < ParentDummy
      include ActiveRecord::AttributeMethods::LocalDBTimeInspection
    end

    context 'attr_name is Date type' do
      subject { dummy_class.attribute_for_inspect(date_type_attr) }
      let!(:dummy_class) { Dummy.new }
      let!(:date_type_attr) { Date.new(1900, 1, 1) }

      before do
        allow(dummy_class).to receive(:read_attribute).with(date_type_attr).and_return(date_type_attr)
      end

      it { is_expected.to eq '"1900-01-01"' }
    end

    context 'attr_name is Time type' do
      subject { dummy_class.attribute_for_inspect(time_type_attr) }
      let!(:dummy_class) { Dummy.new }
      let!(:zone) { "Tokyo" }
      let!(:time_zone) { Time.zone = zone }
      let(:time_type_attr) { Time.zone.parse('2020-01-01 15:59:59') }

      before do
        allow(dummy_class).to receive(:read_attribute).with(time_type_attr).and_return(time_type_attr)
      end

      it { is_expected.to eq '"2020-01-01 15:59:59 +0900"' }
    end

    context 'attr_name is not Date or Time type' do
      subject { dummy_class.attribute_for_inspect(integer_type_attr) }
      let!(:dummy_class) { Dummy.new }
      let(:integer_type_attr) { 5 }

      before do
        allow(dummy_class).to receive(:read_attribute).with(integer_type_attr).and_return(integer_type_attr)
      end

      it { is_expected.to eq 5 }
    end
  end
end
