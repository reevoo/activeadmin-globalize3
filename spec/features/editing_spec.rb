require 'spec_helper'
describe "editing a translation" do
  before :each do
    post = Post.create(title: "Hello World", text: "This is some text")
    I18n.available_locales = [:af, :en, :it, :pt, :de]
  end

  it 'lets me see the translation for the default locale first' do
    visit '/admin/posts'
    click_link 'Edit'
    find(:field, 'Title', visible: true).value.should == "Hello World"
    find(:field, 'Text', visible: true).value.should == "This is some text"
  end

  it 'lets me edit the translation for the default locale first' do
    visit '/admin/posts'
    click_link 'Edit'
    find(:field, 'Title', visible: true).set "Heeloo Wooorld"
    find(:field, 'Text', visible: true).set "This has been edited"
    click_button('Update Post')
    Post.last.title.should == "Heeloo Wooorld"
    Post.last.text.should == "This has been edited"
  end

  it 'only adds translations to the database when there is content' do
    visit '/admin/posts'
    click_link 'Edit'
    click_button('Update Post')
    Post.last.translations.count.should == 1
  end
end
