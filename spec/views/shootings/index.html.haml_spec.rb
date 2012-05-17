require 'spec_helper'

describe "shootings/index" do
  before(:each) do
    assign(:shootings, [
      stub_model(Shooting,
        :yammer_url => "",
        :status => "",
        :progression => ""
      ),
      stub_model(Shooting,
        :yammer_url => "",
        :status => "",
        :progression => ""
      )
    ])
  end

  it "renders a list of shootings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
