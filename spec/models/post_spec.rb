require 'spec_helper'

describe Post do
  it { should belong_to :user }
  it { should verify_presence_of :uid }
end
