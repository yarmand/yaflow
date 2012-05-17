require 'spec_helper'

describe "shootings/edit" do
  before(:each) do
    @shooting = assign(:shooting, stub_model(Shooting,
      :yammer_url => "",
      :status => "",
      :progression => ""
    ))
  end

  it "renders the edit shooting form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => shootings_path(@shooting), :method => "post" do
      assert_select "input#shooting_yammer_url", :name => "shooting[yammer_url]"
      assert_select "input#shooting_status", :name => "shooting[status]"
      assert_select "input#shooting_progression", :name => "shooting[progression]"
    end
  end
end
