# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'securerandom'

MEMOS_FILE = 'memos.json'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end

  def load_memos
    JSON.parse(File.read(MEMOS_FILE), symbolize_names: true)
  end

  def save_memos(memos)
    File.write(MEMOS_FILE, JSON.pretty_generate(memos))
  end

  def find_memo(id)
    load_memos.find { |memo| memo[:id] == id }
  end
end

get '/' do
  redirect '/memos'
end

get '/memos/new' do
  erb :new
end

get '/memos' do
  @memos = load_memos
  erb :index
end

get '/memos/:id' do
  @memo = find_memo(params[:id])
  erb :detail
end

get '/memos/:id/edit' do
  @memo = find_memo(params[:id])
  erb :edit
end

post '/memos' do
  memos = load_memos
  new_id = SecureRandom.uuid

  memos << {
    id: new_id,
    title: params[:title],
    content: params[:content]
  }

  save_memos(memos)

  redirect '/memos'
end

delete '/memos/:id' do
  id = params[:id].to_i
  memos = load_memos
  memos.delete_if { |memo| memo[:id] == id }
  save_memos(memos)
  redirect '/memos'
end

patch '/memos/:id' do
  id = params[:id].to_i
  memos = load_memos
  memo = memos.find { |m| m[:id] == id }
  memo[:title] = params[:title]
  memo[:content] = params[:content]
  save_memos(memos)
  redirect '/memos'
end

not_found do
  'Not Found!'
end
