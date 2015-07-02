require 'sinatra'

get '/:query' do |n|
    send_file 'AcceptanceTesting\MockGeorge.html'
end    