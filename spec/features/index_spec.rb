describe 'index page' do
  before :each do
    Post.create(title: 'Test', text: 'Text')
  end
  it 'should list the translations that the model has' do
    visit('/admin/posts')
    page.should have_content('EN')
  end
end
