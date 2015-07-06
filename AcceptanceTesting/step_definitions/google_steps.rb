require 'minitest/spec'
require 'open-uri'
require 'json'
require 'rake'
require 'find'

Port = 44974
Address = 'http://localhost:' << Port.to_s << '/'
response = nil
extension = 'Test/Google/'

Given(/I search on Google.com$/) do
    %x(copy AcceptanceTesting\\TestEnvironment\\Web.Real.config AcceptanceTesting\\TestEnvironment\\Web.config)

    response = open('http://google.com/') {|f| f.status[0]}.to_i
    
    assert_equal response, 200
end

Given(/I search on the mock-up of Google.com$/) do
    %x(copy AcceptanceTesting\\TestEnvironment\\Web.Mock.config AcceptanceTesting\\TestEnvironment\\Web.config)

    begin
        response = open(Address)
    rescue OpenURI::HTTPError => error
        response = error.io
    end
    
    refute_equal response.status[0].to_i, 404
end

When(/I search for (\w+)$/) do |n|
    begin
        response = open(Address + extension + n)
    rescue OpenURI::HTTPError => error
        response = error.io
    end
    
    assert_equal response.status[0].to_i, 200
end

Then(/the first result I get back should be (.*)$/) do |n|
    
    content = response.read()
    
    assert content.include? n
end