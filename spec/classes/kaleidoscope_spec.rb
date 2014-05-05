require 'spec_helper'

describe 'kaleidoscope' do
  it do
    should contain_package('Kaleidoscope').with({
      :provider => 'compressed_app',
      :source   => 'http://cdn.kaleidoscopeapp.com/releases/Kaleidoscope-2.1.0-134.zip',
    })
  end
end
