require 'spec_helper'

describe "libraries/show" do
  before(:each) do
    @library = assign(:library, stub_model(Library,
      :name => "Name",
      :description => "Description",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Description/)
    rendered.should match(//)
  end
end
