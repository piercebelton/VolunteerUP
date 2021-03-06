require 'rails_helper'

RSpec.feature "CreateEvents", type: :feature do

  before(:each) do
    @org = Organization.find_by_name("Red Cross")
    @user = User.find_by_email("a@yahoo.com")
    @user.user_organizations.create(organization: @org, is_creator: true)
    @new_desc = "This is a new description"
  end

  context "Creating an event" do
    Steps "I can create an event" do
      Given "I am on the sign in page" do
        visit '/users/sign_in'
      end
      And 'I can sign in with my account' do
        fill_in "user[email]", with: @user.email
        fill_in "user[password]", with: '123456'
        # fill_in "user[password_confirmation]", with: '123456'
        click_button "Log in"
        expect(page).to have_current_path(user_path(@user))
      end
      And "I am an organizer" do
        expect(page).to have_content("Org Dashboard")
      end
      Then "I can go to the Events Page" do
        visit '/events'
      end
      And "I can click the New Event button" do
        click_link 'New Event'
        expect(page).to have_content "New Event"
      end
      Then "I can fill in event information" do
        fill_in "event[name]", with: 'Adopt-A-Puppy'
        fill_in "event[description]", with: 'Puppy adoption'
        select '2017', from: 'event_start_time_1i'
        select 'January', from: 'event_start_time_2i'
        select '18', from: 'event_start_time_3i'
        select '01', from: 'event_start_time_4i'
        select '30', from: 'event_start_time_5i'
        select '2017', from: 'event_end_time_1i'
        select 'January', from: 'event_end_time_2i'
        select '18', from: 'event_end_time_3i'
        select '03', from: 'event_end_time_4i'
        select '30', from: 'event_end_time_5i'
        fill_in "event[street]", with: '704 J St'
        fill_in "event[city]", with: 'San Diego'
        select 'Animals', from: 'event_cause'
        select 'CA', from: 'event_state'
        fill_in "event[postal_code]", with: '92101'
        fill_in "event[country]", with: 'USA'
        fill_in "event[volunteers_needed]", with: '100'
        select @org.name, from: "event[organization_id]"
        click_button "Create Event"
      end
      And "I can see the success message and the correct event info" do
        @event = Event.find_by_name("Adopt-A-Puppy")
        expect(page).to have_content "#{@event.name} was successfully created"
        expect(page).to have_content @event.cause
        expect(page).to have_content @event.name
        expect(page).to have_content @event.description
        expect(page).to have_content @event.organization.name
        expect(page).to have_content @event.street
        expect(page).to have_content @event.city
        expect(page).to have_content @event.state
        expect(page).to have_content @event.postal_code
      end
      Then "I can edit the event" do
        click_link "Edit Event"
        fill_in "event[description]", with: @new_desc
        click_button "Update Event"
        expect(page).to have_content "#{@event.name} was successfully updated!"
        expect(page).to have_content @new_desc
      end
      Then "I can delete the event" do
        click_link "Edit Event"
        click_link "Delete Event"
        expect(page).to have_content 'Your event was successfully deleted.'
      end
    end
  end
end
