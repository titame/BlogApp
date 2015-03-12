require 'spec_helper'

describe Comment do
  it "has a valid factory" do
    expect(create(:comment)).to be_valid
  end

  it "is invalid without post" do
    expect(build(:invalid_comment)).to_not be_valid
  end
end
