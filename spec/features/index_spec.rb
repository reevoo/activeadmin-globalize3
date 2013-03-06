describe 'index page' do
  before :each do
    Post.create(title: 'Test', text: 'Text')
  end

  it 'should list the translations that the model has with an OK class' do
    visit('/admin/posts')
    within('.status_tag.en.ok') do
      page.should have_content('EN')
    end
  end

  it 'should list the translations that are not completed' do
    visit('/admin/posts')
    within('.status_tag.it') do
      page.should have_content('IT')
    end
  end
end
