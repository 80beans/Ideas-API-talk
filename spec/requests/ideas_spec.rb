require 'spec_helper'

def ideas_api_uri
  "/api/v1/ideas?auth_token=#{@user.authentication_token}"
end

def idea_api_uri(idea)
  "/api/v1/ideas/#{idea.to_param}?auth_token=#{@user.authentication_token}"
end

describe "Ideas" do
  let(:json) { JSON.parse(response.body) }
  after { Idea.destroy_all }
  before(:all) do
    User.destroy_all
    @user = User.create!(
      :email => 'test@example.com',
      :password => 'secret',
      :password_confirmation => 'secret'
    )
  end

  context "given some ideas" do
    before do
      @stickers = Idea.create!(
        name: 'Stickers are awesome',
        description: 'Put more stickers on my laptop'
      )
      @pizza = Idea.create!(
        name: 'Hmm Pizza',
        description: "I'm getting hungry. We should have some."
      )
    end

    it "fetches all the ideas" do
      get ideas_api_uri
      json.length.should == 2
      json.first['name'].should == 'Stickers are awesome'
      json.second['name'].should == 'Hmm Pizza'
    end

    it "fetches the data of the pizza idea" do
      get idea_api_uri(@pizza)
      json['name'].should == 'Hmm Pizza'
      json['description'].should == "I'm getting hungry. We should have some."
    end
  end

  it "gets rid of a bad idea" do
    eddible_shoes = Idea.create!(name: 'Eddible shoes', description: 'Yum!')
    delete idea_api_uri(eddible_shoes)
    response.status.should == 204
    get ideas_api_uri
    json.should be_empty
  end

  it "adds a great new idea" do
    post ideas_api_uri, idea: {name: 'Hats', description: 'Need more'}
    response.status.should == 201
    get ideas_api_uri
    json.last['name'].should == 'Hats'
  end

  it "makes an existing idea even better" do
    beer = Idea.create!(name: 'Beer', description: 'Have one')
    put idea_api_uri(beer), idea: {description: 'Have a few'}
    get idea_api_uri(beer)
    json['name'].should == 'Beer'
    json['description'].should == 'Have a few'
  end
end
