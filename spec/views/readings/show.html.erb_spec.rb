require 'spec_helper'

describe "readings/show" do
  before(:each) do
    @reading = assign(:reading, stub_model(Reading,
      :title => "Title",
      :content => "Content",
      :author => "Author",
      :summary => "Summary",
      :rating => 1,
      :library => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Content/)
    rendered.should match(/Author/)
    rendered.should match(/Summary/)
    rendered.should match(/1/)
    rendered.should match(//)
  end
end
