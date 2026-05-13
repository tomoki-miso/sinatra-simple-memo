# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require_relative 'models/memo'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end

  def read_memos
    response = settings.db.exec('SELECT * FROM memos ORDER BY id DESC;')
    response.to_a.map do |row|
      Memo.new(row['id'], row['title'], row['content'])
    end
  end

  def read_memo(id)
    response = settings.db.exec_params('SELECT * FROM memos WHERE id = $1;', [id]).first
    Memo.new(response['id'], response['title'], response['content'])
  end

  def post_memo(title, content)
    settings.db.exec_params('INSERT INTO memos(title, content) VALUES ($1, $2);', [title, content])
  end

  def edit_memo(title, content, id)
    settings.db.exec_params('UPDATE memos SET title = $1, content = $2 WHERE id = $3;', [title, content, id])
  end

  def delete_memo(id)
    settings.db.exec_params('DELETE FROM memos WHERE id = $1;', [id])
  end
end

configure do
  schema_sql = File.read(File.expand_path('db/schema.sql', __dir__))
  set :db, PG.connect(dbname: 'postgres')
  settings.db.exec(schema_sql)
end

get '/' do
  redirect '/memos'
end

get '/memos/new' do
  erb :new
end

get '/memos' do
  @memos = read_memos
  erb :index
end

get '/memos/:id' do
  @memo = read_memo(params[:id])
  erb :detail
end

get '/memos/:id/edit' do
  @memo = read_memo(params[:id])
  erb :edit
end

post '/memos' do
  post_memo(params[:title], params[:content])

  redirect '/memos'
end

delete '/memos/:id' do
  delete_memo(params[:id])
  redirect '/memos'
end

patch '/memos/:id' do
  edit_memo(params[:title], params[:content], params[:id])
  redirect '/memos'
end

not_found do
  'Not Found!'
end

error do
  'Internal Server Error'
end
