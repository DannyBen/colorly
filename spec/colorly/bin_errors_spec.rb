require 'spec_helper'

describe 'bin/colorly error handling' do
  it "errors gracefully" do
    expect(`bin/colorly not-found.rb`).to match_approval('bin/error')
  end
end
