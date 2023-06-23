require 'sinatra'
require 'sinatra/reloader'
require 'redis'
require 'mysql2'

redis = Redis.new

mysql = Mysql2::Client.new(:host => '127.0.0.1', :username => 'app', :password => 'P@ssw0rd' , :database => 'sample')

get '/' do
    erb :index
end

post '/vote' do
    if !params[:candidate].empty? && !params[:voter].empty?
        insert_statement = mysql.prepare("insert into votes (candidate, voter) values (? ,?)")
        result = insert_statement.execute(params[:candidate], params[:voter])

        redis.sadd(params[:candidate], params[:voter])
    end

    cursor = 0
    candidates = []
    loop{
        cursor , keys = redis.scan(cursor, :match => "candidate:*")
        candidates += keys
        break if cursor == "0"
    }
    # メモリにデータが残っていない場合
    if candidates.length == 0
        select_statement = mysql.prepare("select candidate, voter from votes")
        result = select_statement.execute()
        counts = {}
        candidates = []
        result.each { |element|
            redis.sadd(element["candidate"],element["voter"])
            candidates += [elemnt["candidate"]]
        }
    end

    counts = {}
    candidates.each { |candidate|
        counts[candidate] = redis.scard(candidate)
    }
    counts = counts.sort.to_h
    counts.to_json
end