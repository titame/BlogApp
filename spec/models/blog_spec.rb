require 'spec_helper'

describe Blog do
  it "has a valid factory" do
    expect(create(:blog)).to be_valid
  end

  it "is invalid without title and description" do
    expect(build(:invalid_blog)).to_not be_valid
  end

  it "is invalid with title length less than 3" do
    expect(build(:blog, title: "ab")).to_not be_valid
  end

  it "is invalid with title length more than 15" do
    expect(build(:blog, title: "LongestTitleIsHere")).to_not be_valid
  end

end
