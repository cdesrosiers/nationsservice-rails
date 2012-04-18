require 'spec_helper'

describe "User pages" do

  subject { page }
  
  describe "profile" do
    
    let(:user) { FactoryGirl.create(:user) }
    
    before do
      sign_in user
      visit user_path(user)
    end
      
    it { should have_selector('title', text: "Nations' Service | #{user.name}") }
    
    describe "of user with an institution" do
      
      let(:institution) { Institution.find_by_name('City University of New York') }
      
      before do
        user.institution = institution
        user.save
        visit user_path(user)
      end
      
      it { should have_content("#{institution.name}") }
      
      describe "and a campus" do
        
        let(:campus) { institution.campuses.first }
        
        before do
          user.campus = campus
          user.save
          visit user_path(user)
        end
        
        it { should have_content("#{campus.name}") }
      end
    end
  end
  
  describe "index" do

    let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in user
      visit users_path
    end

    it { should have_selector('title', text: 'All users') }

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_link('Next') }
      it { should have_link('2') }

      it "should list each user" do
        User.all[0..2].each do |user|
          page.should have_selector('li', text: user.name)
        end
      end
      
      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('delete') }.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1',    text: 'Sign up') }
    it { should have_selector('title', text: 'Sign up') }
  end
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    
    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }
  end
  
  describe "signup" do

    before do
      visit signup_path
    end

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button "Create account" }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect do
          click_button "Create account"
        end.to change(User, :count).by(1)
      end
    end
  end
  
  describe "edit" do
    
    let(:user) { FactoryGirl.create(:user) }
    
    describe "non AJAX" do
      before do
        sign_in user  
        visit edit_user_path(user)
      end
      
      describe "page" do
        it { should have_selector('h1',    text: "Update your profile") }
        it { should have_selector('title', text: "Edit user") }
        it { should have_link('change', href: 'http://gravatar.com/emails') }
        
        describe "form pre-filled data" do
          
          it { should have_selector('label', text: 'Name') }
          it { should have_selector 'input[name="user[name]"][value="' + "#{user.name}" + '"]' }
          
          it { should have_selector('label', text: 'Email') }
          it { should have_selector 'input[name="user[email]"][value="' + "#{user.email}" + '"]' }
          
          it { should have_selector('label', text: 'Password') }
          it { should have_selector 'input[type="password"][name="user[password]"]' }
          
          it { should have_selector('label', text: 'Confirm Password') }
          it { should have_selector 'input[type="password"][name="user[password_confirmation]"]' }
          
          it { should have_selector('select[name="selected_institution[state]"]') }
          
          it { should have_selector('select[name="selected_institution[state]"]') }
          it { should have_xpath '//select[@name="selected_institution[state]"]/option[@value=""]', text: "Select a state" }
          
          describe "for user with selected institution" do
            let(:institution) { FactoryGirl.create(:institution) }
            let(:user_with_institution) { Factory(:user_with_institution, institution: institution) }
            
            before do
              sign_in user_with_institution
              visit edit_user_path(user_with_institution)
            end
            
            it { should have_xpath '//select[@name="selected_institution[state]"]/option[@value=""]', text: "Select a state"}
            it { should have_xpath '//select[@name="selected_institution[state]"]/option', count: 55}
            it { should have_xpath '//select[@name="selected_institution[state]"]/option[@value="' + "#{user_with_institution.institution.state}" + '"][@selected="selected"]' }
            
            it { should have_xpath '//select[@name="user[institution_id]"]/option[@value=""]', text: "Select an Institution"}
            it { should have_xpath '//select[@name="user[institution_id]"]/option', count: Institution.find_all_by_state(institution.state).count + 1 }
            it { should have_xpath '//select[@name="user[institution_id]"]/option[@value="' + "#{user_with_institution.institution.id}" + '"][@selected="selected"]' }
          
            describe "and campus" do
              let(:campus) { FactoryGirl.create(:campus, institution: institution) }
              let(:user_with_institution_and_campus) { Factory(:user_with_institution_and_campus, institution: institution, campus: campus) }
              
              before do
                sign_in user_with_institution_and_campus
                visit edit_user_path(user_with_institution_and_campus)
              end
              
              it { should have_xpath '//select[@name="user[campus_id]"]/option[@value=""]', text: "Select a Campus"}
              it { should have_xpath '//select[@name="user[campus_id]"]/option', count: institution.campuses.count + 1 }
              it { should have_xpath '//select[@name="user[campus_id]"]/option[@value="' + "#{user_with_institution_and_campus.campus.id}" + '"][@selected="selected"]' }
            end
          end
        end
      end
  
      describe "with invalid information" do
        
        before do
          fill_in "Password",         with: user.password
          click_button "Save changes"
        end
        
        it { should have_content('error') }
      end
      
      describe "with valid information" do
        let(:new_name)  { "New Name" }
        let(:new_email) { "new@example.com" }
        before do
          fill_in "Name",             with: new_name
          fill_in "Email",            with: new_email
          fill_in "Password",         with: user.password
          fill_in "Confirm Password", with: user.password
        end
        
        describe "without ajax" do
          before do
            click_button "Save changes"
          end
          
          it { should have_selector('title', text: new_name) }
          it { should have_selector('div.alert.alert-success') }
          it { should have_link('Sign out', :href => signout_path) }
          specify { user.reload.name.should  == new_name }
          specify { user.reload.email.should == new_email }
        end
      end
    end
  end
end