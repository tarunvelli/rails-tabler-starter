require 'rails_helper'

RSpec.describe AppSettings, type: :model do
  describe 'callbacks' do
    describe '#clear_memoization' do
      let!(:app_settings) { create(:app_settings, settings: { "color_mode" => "DARK" }) }

      it 'clears memoization after save' do
        expect(AppSettings).to receive(:clear_memoization)
        app_settings.save
      end
    end
  end

  describe 'class methods' do
    describe '.clear_memoization' do
      it 'resets @global_settings to nil' do
        AppSettings.clear_memoization
        expect(AppSettings.instance_variable_get(:@global_settings)).to be_nil
      end
    end
  end

  describe 'dynamic methods' do
    let!(:app_settings) { create(:app_settings, settings: { "color_mode" => "DARK" }) }

    before do
      AppSettings.clear_memoization
    end

    it 'defines methods for each app setting' do
      %i[
        interface_layout login_layout multi_tenant_mode show_landing_page
        color_mode color_scheme theme_base font_family corner_radius
      ].each do |method|
        expect(AppSettings).to respond_to(method)
      end
    end

    describe 'returns configured value' do
      it 'returns the stored value when present' do
        expect(AppSettings.color_mode).to eq("DARK")
      end

      it 'returns default when not stored' do
        expect(AppSettings.color_scheme).to eq("BLUE")
      end
    end
  end
end
