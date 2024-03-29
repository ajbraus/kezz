require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe ReadingsController do

  # This should return the minimal set of attributes required to create a valid
  # Reading. As you add validations to Reading, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ReadingsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all readings as @readings" do
      reading = Reading.create! valid_attributes
      get :index, {}, valid_session
      assigns(:readings).should eq([reading])
    end
  end

  describe "GET show" do
    it "assigns the requested reading as @reading" do
      reading = Reading.create! valid_attributes
      get :show, {:id => reading.to_param}, valid_session
      assigns(:reading).should eq(reading)
    end
  end

  describe "GET new" do
    it "assigns a new reading as @reading" do
      get :new, {}, valid_session
      assigns(:reading).should be_a_new(Reading)
    end
  end

  describe "GET edit" do
    it "assigns the requested reading as @reading" do
      reading = Reading.create! valid_attributes
      get :edit, {:id => reading.to_param}, valid_session
      assigns(:reading).should eq(reading)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Reading" do
        expect {
          post :create, {:reading => valid_attributes}, valid_session
        }.to change(Reading, :count).by(1)
      end

      it "assigns a newly created reading as @reading" do
        post :create, {:reading => valid_attributes}, valid_session
        assigns(:reading).should be_a(Reading)
        assigns(:reading).should be_persisted
      end

      it "redirects to the created reading" do
        post :create, {:reading => valid_attributes}, valid_session
        response.should redirect_to(Reading.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved reading as @reading" do
        # Trigger the behavior that occurs when invalid params are submitted
        Reading.any_instance.stub(:save).and_return(false)
        post :create, {:reading => {}}, valid_session
        assigns(:reading).should be_a_new(Reading)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Reading.any_instance.stub(:save).and_return(false)
        post :create, {:reading => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested reading" do
        reading = Reading.create! valid_attributes
        # Assuming there are no other readings in the database, this
        # specifies that the Reading created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Reading.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => reading.to_param, :reading => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested reading as @reading" do
        reading = Reading.create! valid_attributes
        put :update, {:id => reading.to_param, :reading => valid_attributes}, valid_session
        assigns(:reading).should eq(reading)
      end

      it "redirects to the reading" do
        reading = Reading.create! valid_attributes
        put :update, {:id => reading.to_param, :reading => valid_attributes}, valid_session
        response.should redirect_to(reading)
      end
    end

    describe "with invalid params" do
      it "assigns the reading as @reading" do
        reading = Reading.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Reading.any_instance.stub(:save).and_return(false)
        put :update, {:id => reading.to_param, :reading => {}}, valid_session
        assigns(:reading).should eq(reading)
      end

      it "re-renders the 'edit' template" do
        reading = Reading.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Reading.any_instance.stub(:save).and_return(false)
        put :update, {:id => reading.to_param, :reading => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested reading" do
      reading = Reading.create! valid_attributes
      expect {
        delete :destroy, {:id => reading.to_param}, valid_session
      }.to change(Reading, :count).by(-1)
    end

    it "redirects to the readings list" do
      reading = Reading.create! valid_attributes
      delete :destroy, {:id => reading.to_param}, valid_session
      response.should redirect_to(readings_url)
    end
  end

end
