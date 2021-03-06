require 'rails_helper'

feature 'Admin/People/AssetsDeclarations' do

  let!(:person) { create(:person, job_level: :temporary_worker) }
  let!(:councillor) { create(:person, job_level: :councillor) }
  let!(:administrator) { create(:administrator) }

  before { login_as administrator }

  feature "Create" do
    scenario 'Create a minimun person (with assets)', :js do

      visit new_admin_person_path
      fill_in :person_first_name, with: "Gordon"
      fill_in :person_last_name, with: "Freeman"
      select "Directive", from: :person_job_level
      fill_in :person_role, with: "Level 3 Research Associate"

      click_link 'Assets declarations'

      element = all(:css, "input[name*='[declaration_date]']").first
      fill_in element[:name], with: '01/01/2018'

      element = all(:css, "input[name*='[period]']").first
      fill_in element[:name], with: 'period_1'

      click_button 'Submit'

      click_link "Freeman, Gordon"

      expect(page).to have_content "Gordon Freeman"
      expect(page).to have_content "Level 3 Research Associate"

      expect(page).to have_content '2018-01-01'

    end

    scenario 'Create a person with Assets declarations', :js do

      visit new_admin_person_path
      fill_in :person_first_name, with: "Gordon"
      fill_in :person_last_name, with: "Freeman"
      select  "Directive", from: 'person_job_level'
      fill_in :person_role, with: "Level 3 Research Associate"

      click_link 'Assets declarations'

      element = all(:css, "input[name*='[declaration_date]']").first
      fill_in element[:name], with: '01/01/2018'

      within '#real_estate_properties' do

        element = all(:css, "input[name*='[kind']").first
        fill_in element[:name], with: 'kind_0'

        element = all(:css, "input[name*='[type]']").first
        fill_in element[:name], with: 'type_0'

        element = all(:css, "input[name*='[description]']").first
        fill_in element[:name], with: 'description_0'

        element = all(:css, "input[name*='[municipality]']").first
        fill_in element[:name], with: 'municipality_0'

        element = all(:css, "input[name*='[share]']").first
        fill_in element[:name], with: 'share_0'

        element = all(:css, "input[name*='[purchase_date]']").first
        fill_in element[:name], with: 'purchase_date_0'

        element = all(:css, "input[name*='[tax_value]']").first
        fill_in element[:name], with: 'tax_value_0'

        element = all(:css, "input[name*='[notes]']").first
        fill_in element[:name], with: 'notes_0'

      end

      within '#account_deposits' do
        element = all(:css, "input[name*='[kind']").first
        fill_in element[:name], with: 'kind_1'

        element = all(:css, "input[name*='[banking_entity]']").first
        fill_in element[:name], with: 'banking_entity_0'

        element = all(:css, "input[name*='[balance]']").first
        fill_in element[:name], with: 'balance_0'
      end

      within '#other_deposits' do
        element = all(:css, "input[name*='[kind]']").last
        fill_in element[:name], with: 'kind_2'

        element = all(:css, "input[name*='[description]']").first
        fill_in element[:name], with: 'description_1'

        element = all(:css, "input[name*='[amount]']").first
        fill_in element[:name], with: 'amount_1'

        element = all(:css, "input[name*='[purchase_date]']").first
        fill_in element[:name], with: 'purchase_date_1'
      end

      within '#vehicles' do
        element = all(:css, "input[name*='[kind]']").first
        fill_in element[:name], with: 'kind_3'

        element = all(:css, "input[name*='[model]']").first
        fill_in element[:name], with: 'model_0'

        element = all(:css, "input[name*='[purchase_date]']").first
        fill_in element[:name], with: '01/07/2018'
      end

      within '#other_personal_properties' do
        element = all(:css, "input[name*='[kind]']").first
        fill_in element[:name], with: 'kind_4'

        element = all(:css, "input[name*='[purchase_date]']").first
        fill_in element[:name], with: '01/08/2018'
      end

      within '#debts' do
        element = all(:css, "input[name*='[kind]']").first
        fill_in element[:name], with: 'kind_5'

        element = all(:css, "input[name*='[amount]']").first
        fill_in element[:name], with: '100000'

        element = all(:css, "input[name*='[comments]']").first
        fill_in element[:name], with: 'comments_0'
      end

      within '#tax_data' do
        element = all(:css, "input[name*='[tax]']").first
        fill_in element[:name], with: 'tax_0'

        element = all(:css, "input[name*='[fiscal_data]']").first
        fill_in element[:name], with: 'fiscal_data_0'

        element = all(:css, "input[name*='[amount]']").first
        fill_in element[:name], with: 'amount_4'

        element = all(:css, "input[name*='[comments]']").first
        fill_in element[:name], with: 'comments_4'
      end

      click_button 'Submit'

      click_link "Freeman, Gordon"

      expect(page).to have_content "Gordon Freeman"
      expect(page).to have_content "Level 3 Research Associate"

      expect(page).to have_content "2018-01-01"

      expect(page).to have_content "kind_0"
      expect(page).to have_content "type_0"
      expect(page).to have_content "description_0"
      expect(page).to have_content "municipality_0"
      expect(page).to have_content "share_0"
      expect(page).to have_content "purchase_date_0"
      expect(page).to have_content "tax_value_0"
      expect(page).to have_content "notes_0"

      expect(page).to have_content "kind_1"
      expect(page).to have_content "banking_entity_0"
      expect(page).to have_content "balance_0"

      expect(page).to have_content 'kind_2'
      expect(page).to have_content 'description_1'
      expect(page).to have_content 'amount_1'
      expect(page).to have_content 'purchase_date_1'

      expect(page).to have_content 'kind_3'
      expect(page).to have_content 'model_0'
      expect(page).to have_content '01/07/2018'

      expect(page).to have_content 'kind_4'
      expect(page).to have_content '01/08/2018'

      expect(page).to have_content 'kind_5'
      expect(page).to have_content '100000'
      expect(page).to have_content 'comments_0'

      expect(page).to have_content 'tax_0'
      expect(page).to have_content 'fiscal_data_0'
      expect(page).to have_content 'amount_4'
      expect(page).to have_content 'comments_4'
    end
  end

  context "Update" do
    scenario 'Update, add assets declarations with 2 real estate properties', :js do
      person = create(:person, first_name: "Red", last_name: "Richards", role: "Elastic Man", job_level: "director")

      visit admin_people_path

      within("#person_#{person.id}") do
        click_on "Edit"
      end

      click_link 'Assets declarations'

      element = all(:css, "input[name*='[declaration_date]']").first
      fill_in element[:name], with: '01/01/2018'

      within '#real_estate_properties' do

        element = all(:css, "input[name*='[kind']").first
        fill_in element[:name], with: 'kind_0'

        element = all(:css, "input[name*='[type]']").first
        fill_in element[:name], with: 'type_0'

        element = all(:css, "input[name*='[description]']").first
        fill_in element[:name], with: 'description_0'

        element = all(:css, "input[name*='[municipality]']").first
        fill_in element[:name], with: 'municipality_0'

        element = all(:css, "input[name*='[share]']").first
        fill_in element[:name], with: 'share_0'

        element = all(:css, "input[name*='[purchase_date]']").first
        fill_in element[:name], with: 'purchase_date_0'

        element = all(:css, "input[name*='[tax_value]']").first
        fill_in element[:name], with: 'tax_value_0'

        element = all(:css, "input[name*='[notes]']").first
        fill_in element[:name], with: 'notes_0'

      end

      within '#real-state-properties-add' do
        click_link 'Add'
      end

      within '#real_estate_properties' do

        element = all(:css, "input[name*='[kind']").last
        fill_in element[:name], with: 'kind_1'

        element = all(:css, "input[name*='[type]']").last
        fill_in element[:name], with: 'type_1'

      end

      within '#assets_declarations' do
        click_button 'Submit'
      end

      click_link "Richards, Red"

      expect(page).to have_content "kind_0"
      expect(page).to have_content "type_0"
      expect(page).to have_content "description_0"
      expect(page).to have_content "municipality_0"
      expect(page).to have_content "share_0"
      expect(page).to have_content "purchase_date_0"
      expect(page).to have_content "tax_value_0"
      expect(page).to have_content "notes_0"

      expect(page).to have_content "kind_1"
      expect(page).to have_content "type_1"
    end

    scenario 'Update, edit assets declarations (real state property)', :js do
      person = create(:person, first_name: "Red", last_name: "Richards", role: "Elastic Man", job_level: "director")
      declaration = AssetsDeclaration.create(person_id: person.id,
                                             declaration_date: '01/01/2018',
                                             period: 'position_1')
      declaration.add_real_estate_property('kind', 'type', 'description', 'municipality', 'share', 'purchase_date', 'tax_value', 'notes')

      visit admin_people_path

      within("#person_#{person.id}") do
        click_on "Edit"
      end

      click_link 'Assets declarations'

      element = all(:css, "input[name*='[declaration_date]']").first
      fill_in element[:name], with: '02/01/2018'

      within '#real_estate_properties' do

        element = all(:css, "input[name*='[kind']").first
        fill_in element[:name], with: 'kind_0'

        element = all(:css, "input[name*='[type]']").first
        fill_in element[:name], with: 'type_0'

        element = all(:css, "input[name*='[description]']").first
        fill_in element[:name], with: 'description_0'

        element = all(:css, "input[name*='[municipality]']").first
        fill_in element[:name], with: 'municipality_0'

        element = all(:css, "input[name*='[share]']").first
        fill_in element[:name], with: 'share_0'

        element = all(:css, "input[name*='[purchase_date]']").first
        fill_in element[:name], with: 'purchase_date_0'

        element = all(:css, "input[name*='[tax_value]']").first
        fill_in element[:name], with: 'tax_value_0'

        element = all(:css, "input[name*='[notes]']").first
        fill_in element[:name], with: 'notes_0'

      end

      within '#assets_declarations' do
        click_button 'Submit'
      end

      click_link "Richards, Red"

      expect(page).to have_content "kind_0"
      expect(page).to have_content "type_0"
      expect(page).to have_content "description_0"
      expect(page).to have_content "municipality_0"
      expect(page).to have_content "share_0"
      expect(page).to have_content "purchase_date_0"
      expect(page).to have_content "tax_value_0"
      expect(page).to have_content "notes_0"
    end

    scenario 'Update, add assets declarations with 2 account deposits', :js do
      person = create(:person, first_name: "Red", last_name: "Richards", role: "Elastic Man", job_level: "director")

      visit admin_people_path

      within("#person_#{person.id}") do
        click_on "Edit"
      end

      click_link 'Assets declarations'

      element = all(:css, "input[name*='[declaration_date]']").first
      fill_in element[:name], with: '01/01/2018'

      within '#account_deposits' do
        element = all(:css, "input[name*='[kind']").first
        fill_in element[:name], with: 'kind_1'

        element = all(:css, "input[name*='[banking_entity]']").first
        fill_in element[:name], with: 'banking_entity_0'

        element = all(:css, "input[name*='[balance]']").first
        fill_in element[:name], with: 'balance_0'
      end

      within '#account-deposit-add' do
        click_link 'Add'
      end

      within '#account_deposits' do
        element = all(:css, "input[name*='[kind']").last
        fill_in element[:name], with: 'kind_2'

        element = all(:css, "input[name*='[banking_entity]']").last
        fill_in element[:name], with: 'banking_entity_1'

        element = all(:css, "input[name*='[balance]']").last
        fill_in element[:name], with: 'balance_1'
      end

      within '#assets_declarations' do
        click_button 'Submit'
      end

      click_link "Richards, Red"

      expect(page).to have_content 'kind_1'
      expect(page).to have_content 'banking_entity_0'
      expect(page).to have_content 'balance_0'
      expect(page).to have_content 'kind_2'
      expect(page).to have_content 'banking_entity_1'
      expect(page).to have_content 'balance_1'

    end

    scenario 'Update, edit assets declarations (account deposits)', :js do
      person = create(:person, first_name: "Red", last_name: "Richards", role: "Elastic Man", job_level: "director")
      declaration = AssetsDeclaration.create(person_id: person.id,
                                             declaration_date: '01/01/2018',
                                             period: 'position_1')
      declaration.add_account_deposit('kind_0', 'banking_entity_0', 'balance_0')

      visit admin_people_path

      within("#person_#{person.id}") do
        click_on "Edit"
      end

      click_link 'Assets declarations'

      element = all(:css, "input[name*='[declaration_date]']").first
      fill_in element[:name], with: '02/01/2018'

      within '#account_deposits' do
        element = all(:css, "input[name*='[kind']").first
        fill_in element[:name], with: 'kind_1'

        element = all(:css, "input[name*='[banking_entity]']").first
        fill_in element[:name], with: 'banking_entity_1'

        element = all(:css, "input[name*='[balance]']").first
        fill_in element[:name], with: 'balance_1'
      end

      within '#assets_declarations' do
        click_button 'Submit'
      end

      click_link "Richards, Red"
      expect(page).to have_content 'kind_1'
      expect(page).to have_content 'banking_entity_1'
      expect(page).to have_content 'balance_1'
    end

    scenario 'Update, add assets declarations with 2 other deposits', :js do
      person = create(:person, first_name: "Red", last_name: "Richards", role: "Elastic Man", job_level: "director")

      visit admin_people_path

      within("#person_#{person.id}") do
        click_on "Edit"
      end

      click_link 'Assets declarations'

      element = all(:css, "input[name*='[declaration_date]']").first
      fill_in element[:name], with: '01/01/2018'

      within '#other_deposits' do
        element = all(:css, "input[name*='[kind]']").first
        fill_in element[:name], with: 'kind_0'

        element = all(:css, "input[name*='[amount]']").first
        fill_in element[:name], with: 'amount_0'

        element = all(:css, "input[name*='[description]']").first
        fill_in element[:name], with: 'description_0'

        element = all(:css, "input[name*='[purchase_date]']").first
        fill_in element[:name], with: 'purchase_date_0'
      end

      within '#other-deposit-add' do
        click_link 'Add'
      end

      within '#other_deposits' do
        element = all(:css, "input[name*='[kind]']").last
        fill_in element[:name], with: 'kind_1'

        element = all(:css, "input[name*='[description]']").last
        fill_in element[:name], with: 'description_1'

        element = all(:css, "input[name*='[amount]']").last
        fill_in element[:name], with: 'amount_1'

        element = all(:css, "input[name*='[purchase_date]']").last
        fill_in element[:name], with: 'purchase_date_1'
      end

      within '#assets_declarations' do
        click_button 'Submit'
      end

      click_link "Richards, Red"

      expect(page).to have_content 'kind_0'
      expect(page).to have_content 'description_0'
      expect(page).to have_content 'amount_0'
      expect(page).to have_content 'purchase_date_0'
      expect(page).to have_content 'kind_1'
      expect(page).to have_content 'description_1'
      expect(page).to have_content 'amount_1'
      expect(page).to have_content 'purchase_date_1'

    end

    scenario 'Update, edit assets declarations (other deposits)', :js do
      person = create(:person, first_name: "Red", last_name: "Richards", role: "Elastic Man", job_level: "director")
      declaration = AssetsDeclaration.create(person_id: person.id,
                                             declaration_date: '01/01/2018',
                                             period: 'position_1')
      declaration.add_other_deposit('kind_0', 'description_0', 'amount_0', 'purchase_date_0')

      visit admin_people_path

      within("#person_#{person.id}") do
        click_on "Edit"
      end

      click_link 'Assets declarations'

      element = all(:css, "input[name*='[declaration_date]']").first
      fill_in element[:name], with: '02/01/2018'

      within '#other_deposits' do
        element = all(:css, "input[name*='[kind']").first
        fill_in element[:name], with: 'kind_1'

        element = all(:css, "input[name*='[description]']").first
        fill_in element[:name], with: 'description_1'

        element = all(:css, "input[name*='[amount]']").first
        fill_in element[:name], with: 'amount_1'

        element = all(:css, "input[name*='[purchase_date]']").first
        fill_in element[:name], with: 'purchase_date_1'
      end

      within '#assets_declarations' do
        click_button 'Submit'
      end

      click_link "Richards, Red"
      expect(page).to have_content 'kind_1'
      expect(page).to have_content 'description_1'
      expect(page).to have_content 'amount_1'
      expect(page).to have_content 'purchase_date_1'
    end

    scenario 'Update, add assets declarations with 2 vehicles', :js do
      person = create(:person, first_name: "Red", last_name: "Richards", role: "Elastic Man", job_level: "director")

      visit admin_people_path

      within("#person_#{person.id}") do
        click_on "Edit"
      end

      click_link 'Assets declarations'

      element = all(:css, "input[name*='[declaration_date]']").first
      fill_in element[:name], with: '01/01/2018'

      within '#vehicles' do
        element = all(:css, "input[name*='[kind]']").first
        fill_in element[:name], with: 'kind_0'

        element = all(:css, "input[name*='[model]']").first
        fill_in element[:name], with: 'model_0'

        element = all(:css, "input[name*='[purchase_date]']").first
        fill_in element[:name], with: '01/07/2018'
      end

      within '#vehicle-add' do
        click_link 'Add'
      end

      within '#vehicles' do
        element = all(:css, "input[name*='[kind]']").last
        fill_in element[:name], with: 'kind_1'
      end

      within '#assets_declarations' do
        click_button 'Submit'
      end

      click_link "Richards, Red"

      expect(page).to have_content 'kind_0'
      expect(page).to have_content 'model_0'
      expect(page).to have_content '01/07/2018'

      expect(page).to have_content 'kind_1'

    end

    scenario 'Update, edit assets declarations (vehicles)', :js do
      person = create(:person, first_name: "Red", last_name: "Richards", role: "Elastic Man", job_level: "director")
      declaration = AssetsDeclaration.create(person_id: person.id,
                                             declaration_date: '01/01/2018',
                                             period: 'position_1')
      declaration.add_vehicle('Other', '1/2/2016', '1/3/2017')

      visit admin_people_path

      within("#person_#{person.id}") do
        click_on "Edit"
      end

      click_link 'Assets declarations'

      element = all(:css, "input[name*='[declaration_date]']").first
      fill_in element[:name], with: '02/01/2018'

      within '#vehicles' do
        element = all(:css, "input[name*='[kind]']").first
        fill_in element[:name], with: 'kind_3'

        element = all(:css, "input[name*='[model]']").first
        fill_in element[:name], with: 'model_0'

        element = all(:css, "input[name*='[purchase_date]']").first
        fill_in element[:name], with: '01/07/2018'
      end

      within '#assets_declarations' do
        click_button 'Submit'
      end

      click_link "Richards, Red"

      expect(page).to have_content 'kind_3'
      expect(page).to have_content 'model_0'
      expect(page).to have_content '01/07/2018'
    end

    scenario 'Update, add assets declarations with 2 other_personal properties', :js do
      person = create(:person, first_name: "Red", last_name: "Richards", role: "Elastic Man", job_level: "director")

      visit admin_people_path

      within("#person_#{person.id}") do
        click_on "Edit"
      end

      click_link 'Assets declarations'

      element = all(:css, "input[name*='[declaration_date]']").first
      fill_in element[:name], with: '01/01/2018'

      within '#other_personal_properties' do
        element = all(:css, "input[name*='[kind]']").first
        fill_in element[:name], with: 'kind_0'

        element = all(:css, "input[name*='[purchase_date]']").first
        fill_in element[:name], with: '01/07/2018'
      end

      within '#other-personal-property-add' do
        click_link 'Add'
      end

      within '#other_personal_properties' do
        element = all(:css, "input[name*='[kind]']").last
        fill_in element[:name], with: 'kind_1'
      end

      within '#assets_declarations' do
        click_button 'Submit'
      end

      click_link "Richards, Red"

      expect(page).to have_content 'kind_0'
      expect(page).to have_content '01/07/2018'

      expect(page).to have_content 'kind_1'

    end

    scenario 'Update, edit assets declarations (vehicles)', :js do
      person = create(:person, first_name: "Red", last_name: "Richards", role: "Elastic Man", job_level: "director")
      declaration = AssetsDeclaration.create(person_id: person.id,
                                             declaration_date: '01/01/2018',
                                             period: 'position_1')
      declaration.add_other_personal_property('Other', '1/3/2017')

      visit admin_people_path

      within("#person_#{person.id}") do
        click_on "Edit"
      end

      click_link 'Assets declarations'

      element = all(:css, "input[name*='[declaration_date]']").first
      fill_in element[:name], with: '02/01/2018'

      within '#other_personal_properties' do
        element = all(:css, "input[name*='[kind]']").first
        fill_in element[:name], with: 'kind_3'

        element = all(:css, "input[name*='[purchase_date]']").first
        fill_in element[:name], with: '01/07/2018'
      end

      within '#assets_declarations' do
        click_button 'Submit'
      end

      click_link "Richards, Red"

      expect(page).to have_content 'kind_3'
      expect(page).to have_content '01/07/2018'
    end

    scenario 'Update, add assets declarations with 2 debts', :js do
      person = create(:person, first_name: "Red", last_name: "Richards", role: "Elastic Man", job_level: "director")

      visit admin_people_path

      within("#person_#{person.id}") do
        click_on "Edit"
      end

      click_link 'Assets declarations'

      element = all(:css, "input[name*='[declaration_date]']").first
      fill_in element[:name], with: '01/01/2018'

      within '#debts' do
        element = all(:css, "input[name*='[kind]']").first
        fill_in element[:name], with: 'kind_5'

        element = all(:css, "input[name*='[amount]']").first
        fill_in element[:name], with: '100000'

        element = all(:css, "input[name*='[comments]']").first
        fill_in element[:name], with: 'comments_0'
      end

      within '#debt-add' do
        click_link 'Add'
      end

      within '#debts' do
        element = all(:css, "input[name*='[kind]']").last
        fill_in element[:name], with: 'kind_6'
      end

      within '#assets_declarations' do
        click_button 'Submit'
      end

      click_link "Richards, Red"

      expect(page).to have_content 'kind_5'
      expect(page).to have_content '100000'
      expect(page).to have_content 'comments_0'

      expect(page).to have_content 'kind_6'

    end

    scenario 'Update, edit assets declarations (debts)', :js do
      person = create(:person, first_name: "Red", last_name: "Richards", role: "Elastic Man", job_level: "director")
      declaration = AssetsDeclaration.create(person_id: person.id,
                                             declaration_date: '01/01/2018',
                                             period: 'position_1')
      declaration.add_debt('kind', '1', 'comments')

      visit admin_people_path

      within("#person_#{person.id}") do
        click_on "Edit"
      end

      click_link 'Assets declarations'

      element = all(:css, "input[name*='[declaration_date]']").first
      fill_in element[:name], with: '02/01/2018'

      within '#debts' do
        element = all(:css, "input[name*='[kind]']").first
        fill_in element[:name], with: 'kind_5'

        element = all(:css, "input[name*='[amount]']").first
        fill_in element[:name], with: '100000'

        element = all(:css, "input[name*='[comments]']").first
        fill_in element[:name], with: 'comments_0'
      end

      within '#assets_declarations' do
        click_button 'Submit'
      end

      click_link "Richards, Red"

      expect(page).to have_content 'kind_5'
      expect(page).to have_content '100000'
      expect(page).to have_content 'comments_0'
    end

    scenario 'Update, add assets declarations with 2 tax datum', :js do
      person = create(:person, first_name: "Red", last_name: "Richards", role: "Elastic Man", job_level: "director")

      visit admin_people_path

      within("#person_#{person.id}") do
        click_on "Edit"
      end

      click_link 'Assets declarations'

      element = all(:css, "input[name*='[declaration_date]']").first
      fill_in element[:name], with: '01/01/2018'

      within '#tax_data' do
        element = all(:css, "input[name*='[tax]']").first
        fill_in element[:name], with: 'tax_0'

        element = all(:css, "input[name*='[fiscal_data]']").first
        fill_in element[:name], with: 'fiscal_data_0'

        element = all(:css, "input[name*='[amount]']").first
        fill_in element[:name], with: 'amount_4'

        element = all(:css, "input[name*='[comments]']").first
        fill_in element[:name], with: 'comments_4'
      end

      within '#tax-data-add' do
        click_link 'Add'
      end

      within '#tax_data' do
        element = all(:css, "input[name*='[tax]']").last
        fill_in element[:name], with: 'tax_1'
      end

      within '#assets_declarations' do
        click_button 'Submit'
      end

      click_link "Richards, Red"

      expect(page).to have_content 'tax_0'
      expect(page).to have_content 'fiscal_data_0'
      expect(page).to have_content 'amount_4'
      expect(page).to have_content 'comments_4'

      expect(page).to have_content 'tax_1'

    end

    scenario 'Update, edit assets declarations (tax data)', :js do
      person = create(:person, first_name: "Red", last_name: "Richards", role: "Elastic Man", job_level: "director")
      declaration = AssetsDeclaration.create(person_id: person.id,
                                             declaration_date: '01/01/2018',
                                             period: 'position_1')
      declaration.add_tax_data('tax_0', 'fiscal_data_0', 'amount_4','comments_4')

      visit admin_people_path

      within("#person_#{person.id}") do
        click_on "Edit"
      end

      click_link 'Assets declarations'

      element = all(:css, "input[name*='[declaration_date]']").first
      fill_in element[:name], with: '02/01/2018'

      within '#tax_data' do
        element = all(:css, "input[name*='[tax]']").first
        fill_in element[:name], with: 'tax_0'

        element = all(:css, "input[name*='[fiscal_data]']").first
        fill_in element[:name], with: 'fiscal_data_0'

        element = all(:css, "input[name*='[amount]']").first
        fill_in element[:name], with: 'amount_4'

        element = all(:css, "input[name*='[comments]']").first
        fill_in element[:name], with: 'comments_4'
      end

      within '#assets_declarations' do
        click_button 'Submit'
      end

      click_link "Richards, Red"

      expect(page).to have_content 'tax_0'
      expect(page).to have_content 'fiscal_data_0'
      expect(page).to have_content 'amount_4'
      expect(page).to have_content 'comments_4'
    end

    scenario "Create an initial declaration", :js do
      person = create(:person, first_name: "Red", last_name: "Richards", role: "Elastic Man", job_level: "director")

      visit edit_admin_person_path(person)

      click_link "Assets declarations"
      fill_in "Declaration date", with: "01/01/2018"
      fill_in "Period", with: "Inicial"
      click_button "Submit"

      visit edit_admin_person_path(person)
      click_link "Assets declarations"

      within("#assets_declarations .tabs") do
        expect(page).to have_content "Initial"
      end
    end
  end

  context "Errors" do

    scenario 'Show errors on empty form (with assets and assets)', :js do
      visit new_admin_person_path

      click_link 'Assets declarations'

      fill_in :person_assets_declarations_attributes_0__period, with: "period"

      click_button 'Submit'

      expect(page).to have_content("Declaration date can't be blank")
    end
  end

end