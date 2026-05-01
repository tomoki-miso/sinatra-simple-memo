# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

MEMOS = JSON.parse(File.read('memos.json'), symbolize_names: true)

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

get '/' do
  redirect '/memos'
end

get '/memos/new' do
  erb :new
end

get '/memos' do
  @memos = MEMOS
  erb :index
end

get '/memos/:id' do
  id = params[:id].to_i
  @memo = MEMOS.find { |memo| memo[:id] == id }
  erb :detail
end

get '/memos/:id/edit' do
  id = params[:id].to_i
  @memo = MEMOS.find { |memo| memo[:id] == id }
  erb :edit
end

post '/memos' do
  new_id = MEMOS.empty? ? 1 : MEMOS.map { |memo| memo[:id] }.max + 1

  MEMOS << {
    id: new_id,
    title: params[:title],
    content: params[:content]
  }

  File.write('memos.json', JSON.pretty_generate(MEMOS))

  redirect '/memos'
end

delete '/memos/:id' do
  id = params[:id].to_i
  MEMOS.delete_if { |memo| memo[:id] == id }
  File.write('memos.json', JSON.pretty_generate(MEMOS))
  redirect '/memos'
end

patch '/memos/:id' do
  id = params[:id].to_i
  memo = MEMOS.find { |memo| memo[:id] == id }
  memo[:title] = params[:title]
  memo[:content] = params[:content]
  File.write('memos.json', JSON.pretty_generate(MEMOS))
  redirect '/memos'
end

not_found do
  'not Foud!'
end
