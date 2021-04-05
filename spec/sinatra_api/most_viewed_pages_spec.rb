# frozen_string_literal: true

require 'support/spec_helper'
require 'rspec'

RSpec.describe 'App' do
  describe 'GET /most_viewed_webpages' do
    it 'should return unique most viewed webpages ordered' do
      get '/most_viewed_webpages'
      expect(last_response).to be_ok
      attributes = JSON.parse(last_response.body)
      require 'pry-byebug'; binding.pry
      expect(attributes.size).to eq(0)
      expect(attributes).to eq([])

    #   expect(first_attribute.fetch('uri')).to eq('/home')
    #   expect(first_attribute.fetch('ip')).to eq('127.0.0.1')
    #   expect(first_attribute.fetch('visits')).to eq(10)
    end
  end
end
