# coding: utf-8
require 'rails_helper'

feature 'Proposal ballots' do

  scenario 'Banner shows in proposal index' do
    create_featured_proposals

    visit proposals_path
    expect(page).to_not have_css("#next-voting")
    expect(page).to have_css("#featured-proposals")

    create_successful_proposals

    visit proposals_path

    expect(page).to have_css("#next-voting")
    expect(page).to_not have_css("#featured-proposals")
  end

  scenario 'Successful proposals do not show support buttons in index' do
    successful_proposals = create_successful_proposals

    visit proposals_path

    successful_proposals.each do |proposal|
      within("#proposal_#{proposal.id}_votes") do
        expect(page).to_not have_css(".supports")
        expect(page).to have_content "This proposal has reached the required supports"
      end
    end
  end

  scenario 'Successful proposals do not show support buttons in show' do
    successful_proposals = create_successful_proposals

    successful_proposals.each do |proposal|
      visit proposal_path(proposal)
      within("#proposal_#{proposal.id}_votes") do
        expect(page).to_not have_css(".supports")
        expect(page).to have_content "This proposal has reached the required supports"
      end
    end
  end

end

