require 'spec_helper'

describe "Micropost pages" do
  
  subject { page }
  let(:user) {FactoryGirl.create(:user)}
  before { sign_in user}
  
  describe "micropost creation" do
    before {visit root_path}
    
    describe "with invalid information" do
      it "should not create a micropost" do
        expect {click_button "Post"}.should_not change(Micropost, :count)
      end
      
      describe "error messages" do
        before {click_button "Post"}
        it{should have_content('error')}
      end
    end

    describe "with valid information" do
      before {fill_in 'micropost_content', with: "Lorem ipsum"}
      it "should create a micropost" do
        expect {click_button "Post"}.should change(Micropost, :count).by(1)
      end
    end

    describe "for microposts count" do
      it "should when more than 1" do
        2.times do
          user.microposts.create(content: "Lorem ipsum")
          visit root_path
        end
        page.should have_selector 'span', text: '2 microposts'
      end

      it "should when equal to 1" do
        1.times do
          user.microposts.create(content: "Lorem ipsum")
          visit root_path
        end
        page.should have_selector 'span', text: '1 micropost'
      end

      it "should when equal to 0" do
        page.should have_selector 'span', text: '0 micropost'
      end
      
    end

  end

  describe "micropost destruction" do
    before{FactoryGirl.create(:micropost, user:user)}

    describe "as correct user" do
      before {visit root_path}

      it "should delete a micropost" do
        expect {click_link "delete"}.should change(Micropost, :count).by(-1)
      end
    end
  end

  describe "pagination" do

    before do
      51.times {user.microposts.create(content: "Lorem ipsum")}
      visit root_path
    end

    it { should have_selector('div.pagination') }

    it "should list each micropost" do
      Micropost.paginate(page: 1).each do |micropost|
        page.should have_selector('li', text: micropost.content)
      end
    end
  end

  describe "as wrong user" do
    let(:user1){FactoryGirl.create(:user)}
    before do
      @micropost = user1.microposts.create(content: "Lorem ipsum")
      visit user_path(user1)
    end
    it "should not delete a micropost" do
      page.should have_selector('li', text: @micropost.content)
      page.should_not have_link('delete')
    end
  end
  
end

      
  