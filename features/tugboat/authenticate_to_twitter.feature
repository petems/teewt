Feature: config
  In order to use the app
  As a user
  I should be able to authenticate to twitter

  @vcr
  Scenario: Authenticating to Twitter
        Given a '.teewt' config with data:
"""
---
authentication:
  consumer_key: mocked
  consumer_secret: mocked
  access_token: mocked
  access_token_secret: mocked
"""
    When I run `teewt verify`
    Then the exit status should not be 1
    And the output should contain "Authentication with Twitter was successful."
