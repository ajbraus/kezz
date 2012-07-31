require 'spec_helper'

describe "readings/edit" do
  before(:each) do
    @reading = assign(:reading, stub_model(Reading,
      :title => "MyString",
      :content => "MyString",
      :author => "MyString",
      :summary => "MyString",
      :rating => 1,
      :library => nil
    ))
  end

  it "renders the edit reading form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => readings_path(@reading), :method => "post" do
      assert_select "input#reading_title", :name => "reading[title]"
      assert_select "input#reading_content", :name => "reading[content]"
      assert_select "input#reading_author", :name => "reading[author]"
      assert_select "input#reading_summary", :name => "reading[summary]"
      assert_select "input#reading_rating", :name => "reading[rating]"
      assert_select "input#reading_library", :name => "reading[library]"
    end
  end
end
