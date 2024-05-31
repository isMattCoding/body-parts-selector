require 'rails_helper'

RSpec.feature "UserJourneys", type: :feature do
  before do
    Capybara.default_driver = :selenium
  end
  scenario "User can complete a new questionnaire", js: true do
    visit root_path
    expect(page).to have_text("Questionnaires")
    expect(page).to have_link("New Body")

    click_link "New Body"
    expect(page).to have_text("Questionnaire de santé")

    find('a[data-turbo-frame="questionnaire_perso_front_modal"]').click
    modal = find('div.body-symptoms-modal')
    expect(modal).to have_selector('svg.zoom-body-selector')

    within(modal) do
      find('path.front-thigh-right').click
    end

    expect(modal).to have_selector('path.front-thigh-right.active-body-part')

    click_button "Continuer"
    expect(page).not_to have_selector('div.body-symptoms-modal')
    expect(page).to have_selector('path.front-thigh-right.active-body-part')
  end

end
