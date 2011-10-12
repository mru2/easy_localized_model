require 'spec_helper'

module EasyLocalizedModel

  describe FormHelper, :type => :helper do

    before :all do
      @post = Post.create(:title => {:en => "foo", :fr => "bar"}, :content => {:en => "foofoo", :fr => "barbar"})
    end
  
    after :all do
      @post.delete
    end
  
    before :each do
        I18n.locale = :en    
    end

    describe "text_field" do

      it "should work with an object" do
        helper.text_field_tag('title', @post.title).should== helper.text_field_tag('title', 'foo')
        I18n.locale = :fr
        helper.text_field_tag('title', @post.title).should== helper.text_field_tag('title', 'bar')

        I18n.locale = :en
        form_for @post, :url => '#' do |f|
          f.text_field(:title).should== "<input id=\"post_title\" name=\"post[title]\" size=\"30\" type=\"text\" value=\"foo\" />"
          f.text_field(:title, :locale => :fr).should== "<input id=\"post_title\" name=\"post[title]\" size=\"30\" type=\"text\" value=\"bar\" />"
          I18n.locale = :fr
          f.text_field(:title).should== "<input id=\"post_title\" name=\"post[title]\" size=\"30\" type=\"text\" value=\"bar\" />"          
        end
      end
     
    end

  end

end