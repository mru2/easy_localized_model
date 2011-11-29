require 'spec_helper'

module EasyLocalizedModel
  describe LocalizationHash do
    
    it "should inherit Hash" do
      Hash.try_convert({:foo => :bar}).should== {:foo => :bar}
      LocalizationHash.try_convert({:foo => :bar}).should== {:foo => :bar}
      LocalizationHash.new({:foo => :bar}).class.should== LocalizationHash
      LocalizationHash.new({:foo => :bar}).should== {:foo => :bar}
    end
    
  end
  
  describe Localization do
    
    it "should work" do
      Localization.new("foo").get.should== "foo"
      Localization.new({:en => "foo", :fr => "bar"}).get.should== {:en => "foo", :fr => "bar"}
      Localization.new({:en => "foo", :fr => "bar"}).get(:en).should== "foo"
      
      l = Localization.new("foo")
      l.get.should== "foo"
      l.set({:en => "foo", :fr => "bar"})
      l.get.should == {:en => "foo", :fr => "bar"}
      l.set("foofoo", :en)
      l.get.should == {:en => "foofoo", :fr => "bar"}
      l.set({:it => "barbar"}, :en)
      l.get.should == {:en => "foofoo", :fr => "bar", :it => "barbar"}
    end
    
  end
end
    