@api @api_roles @roles_list
Feature: List roles via the REST API
  In order to know what roles exists programatically
  As a Developer
  I want to list all the roles

  Scenario: List roles when none have been created
    Given a 'registration' named 'bobo' exists
      And there are no roles 
     When I 'GET' the path '/roles' 
     Then the inflated response should be '1' items long 

  Scenario: List roles when one has been created
    Given a 'registration' named 'bobo' exists
    Given a 'role' named 'webserver' exists
     When I 'GET' the path '/roles'
     Then the inflated response should include '^http://.+/roles/webserver$'

  Scenario: List roles when two have been created
    Given a 'registration' named 'bobo' exists
      And a 'role' named 'webserver' exists
      And a 'role' named 'db' exists
     When I 'GET' the path '/roles'
     Then the inflated response should be '3' items long
      And the inflated response should include '^http://.+/roles/role_test$'
      And the inflated response should include '^http://.+/roles/webserver$'
      And the inflated response should include '^http://.+/roles/db$'

  Scenario: List roles when none have been created with a wrong private key
    Given a 'registration' named 'bobo' exists
      And there are no roles 
     When I 'GET' the path '/roles' using a wrong private key
     Then I should get a '401 "Unauthorized"' exception

