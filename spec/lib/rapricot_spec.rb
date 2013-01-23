require 'spec_helper'

describe "rapricot" do
  it "should render void elements" do
    [:img, {src: "a.img"}].rapricot.should == "<img src=\"a.img\">"
  end

  it "should render normal elements" do
    [:html].rapricot.should == "<html></html>"
  end

  it "should render nested elements" do
    [:html, [:head]].rapricot.should == "<html><head></head></html>"
  end

  it "should render elements correctly" do
    [:input, {type: "text", name: "email", value: "email"}].rapricot.should == "<input type=\"text\" name=\"email\" value=\"email\">"
  end

  it "should allow content to be a map" do
    [:p, [[:span, "foo"], [:span, "bar"]]].rapricot.should ==
      "<p><span>foo</span><span>bar</span></p>"
  end

  it "should allow attributes passed in as a string" do
    ['div#foo.bar.baz', "words"].rapricot.should ==
      "<div id=\"foo\" class=\"bar baz\">words</div>"
  end

  it "should allow attributes passed in as a string" do
    ['div#foo.bar.baz', {"style" => "width: 20px"}, "words"].rapricot.should ==
      "<div style=\"width: 20px\" id=\"foo\" class=\"bar baz\">words</div>"
  end
end
