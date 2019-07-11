require 'test_helper'

class DummyTable < ActiveRecord::Base
end

RSpec.describe ActiveRecord::AttributeMethods::LocalDBTimeInspection do
  describe '#attribute_for_inspect' do
    context '#attribute_for_inspect integration test' do
      subject { dummy.attribute_for_inspect(:date_time) }
      around do |e|
        travel_to('2016-2-29 10:00'.to_time){ e.run }
      end

      let!(:zone) { "Tokyo" }
      let!(:time_zone) { Time.zone = zone }
      let(:dummy) { DummyTable.create!(date_time: Time.current) }

      before do
        m = ActiveRecord::Migration.new
        m.verbose = false
        m.create_table :dummy_tables do |t|
          t.datetime :date_time
        end
      end

      after do
        m = ActiveRecord::Migration.new
        m.verbose = false
        m.drop_table :dummy_tables
      end

      it { is_expected.to eq '"2016-02-29 10:00:00 +0900"' }
    end

    context '#attribute_for_inspect inner condition' do
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
end
