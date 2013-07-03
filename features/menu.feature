Feature: Menu
 
 Scenario: Open page from root page
  Given there is a page with the name "Sale birds" 
  And there is a page with the name "Sale ducks" and the parent "Sale birds" 
  When I am on the root page
  And I should see "Sale birds"  
  And I should not see "Sale ducks"
  And I follow "Sale birds"
  Then I should see "Sale ducks" 
