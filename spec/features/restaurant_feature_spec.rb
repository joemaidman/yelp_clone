require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      sign_up
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link "Add a restaurant"
    end

    context 'a user must be logged in to create restaurants' do
      scenario 'add link is not shown' do
        visit '/'
        expect(page).to have_content 'Sign in'
        expect(page).to have_content 'Sign up'
        expect(page).not_to have_content 'Sign out'
        expect(page).to have_content 'No restaurants yet'
        expect(page).not_to have_link 'Add a restaurant'
      end
    end

    scenario 'user cannot visit restaurant/new' do
      visit '/restaurants/new'
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet ')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      sign_up
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'an invalid restaurant' do
    scenario 'does not let you submit a name that is too short' do
      sign_up
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'kf'
      click_button 'Create Restaurant'
      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
    end
  end

  context 'viewing restaurants' do

    let!(:kfc){ Restaurant.create(name:'KFC') }

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do
    before {Restaurant.create name: 'KFC', description: 'Deep fried goodness', id: 1}
    scenario 'let a user edit a restaurant' do
      sign_up
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      fill_in 'Description', with: 'Deep fried goodness'
      click_button 'Update Restaurant'
      click_link 'Kentucky Fried Chicken'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(page).to have_content 'Deep fried goodness'
      expect(current_path).to eq '/restaurants/1'
    end
  end

  # context 'deleting restaurants' do
  #
  #   before {
  #     sign_up
  #     create_restaurant
  #   }
  #
  #   scenario 'removes a restaurant when a user clicks a delete link' do
  #     click_link 'Delete KFC'
  #     expect(page).not_to have_content 'KFC'
  #     expect(page).to have_content 'Restaurant deleted successfully'
  #   end
  #
  #   scenario 'does not remove a restaurant when another user clicks delete' do
  #     sign_out
  #     sign_up(email: "test2@example.com", password: "password")
  #     click_link 'Delete KFC'
  #     expect(page).to have_content 'KFC'
  #     expect(page).not_to have_content 'Restaurant deleted successfully'
  #   end
  #
  # end


end
