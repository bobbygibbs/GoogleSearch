require 'minitest/spec'
require 'open-uri'
require 'json'
require 'rake'
require 'find'

#Pwd = Dir.pwd.gsub /\//, "\\\\" <= Though a simpler implementation, does not account for calls originating externally
#Pwd = File.expand_path(File.dirname(File.dirname(File.dirname(__FILE__)))).gsub /\//, "\\\\"
Port = 44974
Address = 'http://localhost:' << Port.to_s << '/'
response = nil
extension = nil
#iis = nil

#%x(msbuild)
#%x(copy GoogleSearch\\bin\\Debug\\GoogleSearch.dll TestEnvironment\\Bin)

#Find.find("C:\\") do |path|
#    if path.match(/iisexpress.exe$/)
        # Format path to execute
#        iis = ((path.gsub /\//, "\\\\").gsub /\\/, "\\\\").gsub /\w+\s\w+/, '"\0"'
#        break
#    end
#end

Given(/I search on Google.com$/) do    
    #begin
        #timeout(1, NameError) {%x(start #{iis} /path:\"#{Pwd}\\TestEnvironment\" /port:#{Port})}
    #rescue NameError => ex
        # This is expected; Starting the web server leaves a hanging process even 
        # though the server itself is running in a different thread, so we can safely
        # timeout this call and continue.
    #end
    
    response = open('http://google.com/') {|f| f.status[0]}.to_i
    extension = 'Test/Google/'
    
    assert_equal response, 200
end

Given(/I search on the mock-up of Google.com$/) do
    #begin
        #timeout(1, NameError) {%x(start #{iis} /path:\"#{Pwd}\\TestEnvironment\" /port:#{Port})}
    #rescue NameError => ex
        # See above
    #end
    
    begin
        response = open(Address)
    rescue OpenURI::HTTPError => error
        response = error.io
    end
    extension = 'Test/MockGoogle/'
    
    refute_equal response.status[0].to_i, 404
end

When(/I search for (\w+)$/) do |n|
    begin
        response = open(Address + extension + n)
    rescue OpenURI::HTTPError => error
        #%x(taskkill /IM IISExpress.exe /F)
        response = error.io
    end
    
    assert_equal response.status[0].to_i, 200
end

Then(/the first result I get back should be (.*)$/) do |n|
    #%x(taskkill /IM IISExpress.exe /F)
    
    content = response.read()
    
    assert content.include? n
end