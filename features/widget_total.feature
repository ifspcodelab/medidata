Feature: Allows an user to look at a glance your cholesterol-total data
    Eu, como usuário cadastrado
    Devo conseguir visualizar os meus valores de cholesterol-total na minha página inicial
    De forma a conseguir acompanhar minha situação atual de saúde

Background:
    Given I am an registered user with "joao@example.org" email address
    And I have a registered profile with "joao@example.org" email address


Scenario: I should be able to see my latest cholesterol-total registered on my main profile page
    Given I have at least one Cholesterol-total registered
    And I am on My profile page
    Then I should see a Cholesterol-total widget with the most recent register