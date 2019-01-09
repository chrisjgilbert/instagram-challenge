# frozen_string_literal: true

require 'rails_helper'

RSpec.feature "Comment on post", type: :feature do
  scenario "User can comment on post if signed in" do
    user = FactoryBot.create(:user)
    sign_in_and_post_photo(user)
    click_link "View Post"
    expect(page).to have_content "Comments: 0"
    add_post_comment
    expect(page).to have_content "this is a great post"
    expect(page).to have_content "Comments: 1"
  end

  scenario "User unable to comment on post if not signed in" do
    user = FactoryBot.create(:user)
    sign_in_and_post_photo(user)
    click_link "Sign Out"
    click_link "View Post"
    expect(page).to have_content "Sign In or Sign Up to comment!"
  end

  scenario "Post owner can delete comments" do
    user = FactoryBot.create(:user)
    sign_in_and_post_photo(user)
    click_link "View Post"
    expect(page).to have_content "Comments: 0"
    add_post_comment
    expect(page).to have_content "this is a great post"
    expect(page).to have_content "Delete"
  end
end