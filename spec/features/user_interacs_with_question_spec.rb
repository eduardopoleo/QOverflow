require 'spec_helper'

feature "User interacts with the questions" do
  scenario "user adds a question and then comment on it" do
    signin
    click_link "add-question"
    page.should have_content("What's your question?")
    fill_in "Title", with: "A very rare question?"
    fill_in "Description", with: "This is a very difficult question for me"
    click_button "Post Question!"
    page.should have_content("A very rare question?")
    fill_in "answer_description", with: "I actually know the answer for this!"
    click_button "Write Answer"
    page.should have_content("I actually know the answer for this!")
  end
end
