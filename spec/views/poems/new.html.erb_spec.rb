require 'spec_helper'

describe "poems/new" do
  before(:each) do
    assign(:poem, stub_model(Poem,
      :title => "MyString",
      :body => "MyText",
      :user => nil
    ).as_new_record)
  end

  it "renders new poem form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => poems_path, :method => "post" do
      assert_select "input#poem_title", :name => "poem[title]"
      assert_select "textarea#poem_body", :name => "poem[body]"
      assert_select "input#poem_user", :name => "poem[user]"
    end
  end
end
