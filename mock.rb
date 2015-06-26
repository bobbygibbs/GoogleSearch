require 'sinatra'

get '/:query' do |n|
    send_file 'TestEnvironment/MockGeorge.html'
end    