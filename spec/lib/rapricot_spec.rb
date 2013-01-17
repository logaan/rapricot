require 'spec_helper'

describe Rapricot do
	include Rapricot
	it "should render void elements" do
		render([:img, {src: "a.img"}]).should == "<img src=\"a.img\">"
	end
	it "should render normal elements" do
		render([:html]).gsub("\n","").should == "<html></html>"
	end
	it "should render nested elements" do
		# why are there extra spaces?
		render([:html, [:head]]).gsub("\n", "").should == "<html>  <head>  </head></html>"
	end
	it "should render elements correctly" do
		#should the escape characters be shown in output?
		render([:input, {type: "text", name: "email", value: "email"}]).should == "<input type=\"text\" name=\"email\" value=\"email\">"
	end
end
