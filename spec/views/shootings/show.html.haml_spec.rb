require 'spec_helper'

describe "shootings/show" do
  before(:each) do
    @shooting = assign(:shooting, stub_model(Shooting,
      :yammer_url => "",
      :status => "",
      :progression => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
  end
end
