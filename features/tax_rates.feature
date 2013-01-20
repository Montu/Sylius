Feature: Tax rates
    As a store owner
    I want to be able to configure tax rates
    In order to apply proper taxation to my merchandise

    Background:
        Given I am logged in as administrator
          And there are following tax categories:
            | name        |
            | Clothing    |
            | Electronics |
            | Food        |
          And the following tax rates exist:
            | category    | name            | amount |
            | Clothing    | Clothing Tax    | 20%    |
            | Electronics | Electronics Tax | 23%    |

    Scenario: Seeing index of all tax rates
        Given I am on the dashboard page
         When I follow "Tax rates"
         Then I should be on the tax rate index page
          And I should see 2 tax rates in the list

    Scenario: Seeing empty index of tax rates
        Given there are no tax rates
          And I am on the tax rate index page
         Then I should see "There are no tax rates configured"

    Scenario: Accessing the tax rate creation form
        Given I am on the dashboard page
         When I follow "Tax rates"
          And I follow "Create tax rate"
         Then I should be on the tax rate creation page

    Scenario: Submitting invalid form
        Given I am on the tax rate creation page
         When I press "Create"
         Then I should still be on the tax rate creation page
          And I should see "Please enter tax rate name"

    Scenario: Creating new tax rate
        Given I am on the tax rate creation page
          And I fill in "Name" with "EU VAT"
          And I fill in "Amount" with "30"
         When I press "Create"
         Then I should be on the page of tax rate "EU VAT"
          And I should see "Rate has been successfully created."

    Scenario: Created tax rates appear in the list
        Given I created tax rate "Food Tax" for category "Food" with amount 18%
          And I go to the tax rate index page
         Then I should see 3 tax rates in the list
          And I should see tax rate with name "Food Tax" in that list

    Scenario: Updating the tax rate
        Given I am on the page of tax rate "Clothing Tax"
          And I follow "Edit"
         When I fill in "Name" with "General Tax"
          And I press "Save changes"
         Then I should be on the page of tax rate "General Tax"

    Scenario: Deleting tax rate
        Given I am on the page of tax rate "Clothing Tax"
         When I follow "Delete"
         Then I should be on the tax rate index page
          And I should see "Rate has been successfully deleted."

    Scenario: Deleted tax rate disappears from the list
        Given I am on the page of tax rate "Electronics Tax"
         When I follow "Delete"
         Then I should be on the tax rate index page
          And I should not see tax rate with name "Electronics Tax" in that list

    Scenario: Displaying the tax rate details
        Given I am on the page of tax rate "Clothing Tax"
         Then I should see "20%"