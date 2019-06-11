Feature: Allows an user to look at a glance your cholesterol-vldl data
    Eu, como usuário cadastrado
    Devo conseguir visualizar os meus valores de colesterol-vldl na minha página inicial
    De forma a conseguir acompanhar minha situação atual de saúde

Background:
    Given I am an registered user with "joao@example.org" email address
    And I have a registered profile with "joao@example.org" email address


Scenario: I should be able to see my latest cholesterol-vldl registered on my main profile page
    Given I have at least one Cholesterol-vldl registered
    And I am on My profile page
    Then I should see a Cholesterol-vldl widget with the most recent register