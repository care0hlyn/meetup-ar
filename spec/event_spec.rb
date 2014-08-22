require 'spec_helper'

describe Event do
	it { should validate_presence_of :description }
	it { should validate_presence_of :location }
	it { should validate_presence_of :start }
	it { should validate_presence_of :end }
end