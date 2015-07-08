Feature: Google Search Results
    We want to confirm that our
    Google web searches return the
    expected pages as a result.
    
    Scenario: George produces Curious George
        Given I search on Google.com
        When I search for George
        Then the first result I get back should be Sheriff Woody
        
    # Scenario: Woody produces Sheriff Woody
    #     Given I search on Google.com
    #     When I search for Woody
    #     Then the first result I get back should be Sheriff Woody
        
    # Scenario: Rupert produces Rupert Bear
    #     Given I search on Google.com
    #     When I search for Rupert
    #     Then the first result I get back should be Rupert Bear
      
    # Scenario: Milhouse produces Milhouse Van Houten
    #     Given I search on Google.com
    #     When I search for Milhouse
    #     Then the first result I get back should be Milhouse Van Houten
        
    Scenario: George emulates Curious George
        Given I search on the mock-up of Google.com
        When I search for George
        Then the first result I get back should be Curious George
