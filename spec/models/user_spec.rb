require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  describe 'has many friendships' do
    it { should have_many(:friendships) }
    it { should have_many(:pending_friendships) }
  end
end
