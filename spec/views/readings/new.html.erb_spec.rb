require 'spec_helper'

describe "readings/new" do
  before(:each) do
    assign(:reading, stub_model(Reading,
      :title => "MyString",
      :content => "MyString",
      :author => "MyString",
      :summary => "MyString",
      :rating => 1,
      :library => nil
    ).as_new_record)
  end

  it "renders new reading form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => readings_path, :method => "post" do
      assert_select "input#reading_title", :name => "reading[title]"
      assert_select "input#reading_content", :name => "reading[content]"
      assert_select "input#reading_author", :name => "reading[author]"
      assert_select "input#reading_summary", :name => "reading[summary]"
      assert_select "input#reading_rating", :name => "reading[rating]"
      assert_select "input#reading_library", :name => "reading[library]"
    end
  end
end
