require 'spec_helper'

describe Post do
  it { should belong_to :user }
  it { should validate_presence_of :uid }
  it { should validate_presence_of :tag_list }
  it { should validate_uniqueness_of :link }
  it { should validate_presence_of :title }
end
