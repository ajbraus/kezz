require 'spec_helper'

describe "libraries/new" do
  before(:each) do
    assign(:library, stub_model(Library,
      :name => "MyString",
      :description => "MyString",
      :user => nil
    ).as_new_record)
  end

  it "renders new library form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => libraries_path, :method => "post" do
      assert_select "input#library_name", :name => "library[name]"
      assert_select "input#library_description", :name => "library[description]"
      assert_select "input#library_user", :name => "library[user]"
    end
  end
end
