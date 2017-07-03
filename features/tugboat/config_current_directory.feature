Feature: config
  In order to easily load Twitter config
  As a user
  I should be able to load teewt config from a .teewt in the current directory

  Scenario: Read config from current directory
    Given a '.teewt' config with data:
"""
---
authentication:
  consumer_key: foo
  consumer_secret: foo
  access_token: foo
  access_token_secret: foo
"""
    When I run `teewt config`
    Then the exit status should not be 1
    And the output should contain "consumer_key: foo"
    And the output should contain "consumer_secret: foo"
    And the output should contain "access_token: foo"
