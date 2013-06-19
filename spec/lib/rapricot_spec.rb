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

  it "should allow content to be an array" do
    [:p, [[:span, "foo"], [:span, "bar"]]].rapricot.should ==
      "<p><span>foo</span><span>bar</span></p>"
  end

  it "should allow multiple children without array wrapping" do
    [:p, [:span, "foo"], [:span, "bar"]].rapricot.should ==
      "<p><span>foo</span><span>bar</span></p>"
  end

  describe "css selector style tags" do
    it "should allow id and class from a css style selector" do
      ['div#foo.bar.baz', "words"].rapricot.should ==
        "<div id=\"foo\" class=\"bar baz\">words</div>"
    end

    it "should merge id and class from string with existing attributes" do
      ['div#foo.bar.baz', {"style" => "width: 20px"}, "words"].rapricot.should ==
        "<div style=\"width: 20px\" id=\"foo\" class=\"bar baz\">words</div>"
    end

    it "should give id and class from attributes a higher priority than from string" do
      ['div#foo.bar.baz', {"id" => "butterfly"}, "words"].rapricot.should ==
        "<div id=\"butterfly\" class=\"bar baz\">words</div>"
    end

    it "should give id and class from attributes a lower priority than from string if nil" do
      ['div#foo.bar.baz', {"id" => nil}, "words"].rapricot.should ==
        "<div id=\"foo\" class=\"bar baz\">words</div>"
    end

    it "should allow id without class from a css style selector" do
      ['div#foo', "words"].rapricot.should ==
        "<div id=\"foo\">words</div>"
    end

    it "should allow class without id from a css style selector" do
      ['div.bar.baz', "words"].rapricot.should ==
        "<div class=\"bar baz\">words</div>"
    end
  end
end
