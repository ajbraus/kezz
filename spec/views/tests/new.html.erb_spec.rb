require 'spec_helper'

describe "tests/new" do
  before(:each) do
    assign(:test, stub_model(Test,
      :string => ""
    ).as_new_record)
  end

  it "renders new test form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tests_path, :method => "post" do
      assert_select "input#test_string", :name => "test[string]"
    end
  end
end
