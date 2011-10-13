require 'spec_helper'

module EasyLocalizedModel
  
  describe Post do

    before :each do
      I18n.locale = :en

      @title_translations = {:en => "title", :fr => "titre"}
    
      @post = Post.new
    end
  
    it "should be saved and accessed" do
      @post.title = @title_translations
      @post.title.should== "title"
    end
  
    it "should be able to save and return a specific translation" do
      @post.title = @title_translations
      @post.title(:fr).should== "titre"
      @post.set_title "foofoo", :locale => :en
      @post.title.should== "foofoo"
    end

    it "should be able to merge translation hash" do
      new_translations = {:en => "title2", :it => "titolo2"}

      @post.title = @title_translations
      @post.title = new_translations

      @post.title(:en).should== "title2"
      @post.title(:fr).should== "titre"
      @post.title(:it).should== "titolo2"
    end


    it "should be able to handle strings" do
      @post.title = "foo"
      @post.title.should== "foo"
      @post.title(:fr).should== "foo" # switch to default locale
    

      @post.title = @title_translations
      @post.title.should== "title"
      @post.title(:fr).should== "titre"

      @post.title = "foo"
      @post.title.should== "foo"
      @post.title(:fr).should== "titre"
    end
  end

end
