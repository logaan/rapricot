require 'spec_helper'

describe "rapricot" do
  it "should render void elements" do
    [:img, {src: "a.img"}].rapricot.should == "<img src=\"a.img\">"
  end
  it "should render normal elements" do
    [:html].rapricot.should == "<html></html>"
  end
  it "should render nested elements" do
    # why are there extra spaces?
    [:html, [:head]].rapricot.should == "<html><head></head></html>"
  end
  it "should render elements correctly" do
    #should the escape characters be shown in output?
    [:input, {type: "text", name: "email", value: "email"}].rapricot.should == "<input type=\"text\" name=\"email\" value=\"email\">"
  end
end
