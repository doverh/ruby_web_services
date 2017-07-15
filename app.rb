require 'sinatra'
require 'pg'
#require_relative 'pushmessage.rb'
# require_relative 'post.rb'


	#push = PushMessage.new

###################################################
#  Initialize Connection with AWS postgreSQL db   #
###################################################

	load "./local_env.rb" if File.exists?("./local_env.rb")

	
	def connection()
    db_params = {host: ENV['host'],
    port: ENV['port'],
    dbname: ENV['dbname'],
    user: ENV['user'],
    password: ENV['password']
    }

  db = PG::Connection.new(db_params)
end


enable 'sessions'
		
	
	get "/" do
	   db = connection
        if !db.nil?
           session[:result] = "Connect"
            # db.exec("INSERT INTO answers (user_name, answer, date, question_id) VALUES ('ruby@rubyapp.com', '1', '07/12/2017', '1')")
            # db.close
        else
            session[:result] = "Not Connected"    
        end
       erb :hello, :locals => {:result=> session[:result]}


    end

	
# 	post '/post_answer' do
#   		answer_hash = {"email"=>params[:email], "question_id"=>params[:question_id], "answer"=>params[:answer]}
#   		#email=params[:email]
  		
#   		send_answer(answer_hash)  # update/insert record with fcm_id
#   		"Post successful - thanks for the info!"  # feedback for Xcode console (successful POST)
# end


post '/submit_answer_app' do
    data_hash = {"email"=>params[:email], "input_answer"=>params[:input_answer], "tokens"=>params[:tokens], "question_id"=>params[:question_id]}

    #JSON TO BE IMPLEMENTED
    #email = JSON.parse(params[:email])
    
    #Assign Variables correct values
    v_email = data_hash["email"]
    v_answer = data_hash["input_answer"].to_i
    v_tokens = data_hash["tokens"].to_i - 1
    v_question_id = data_hash["question_id"]
    v_date = Time.now.strftime("%d/%m/%Y %H:%M:%S")
    db = connection()
    db.exec("INSERT INTO answers (user_name, answer, date, question_id) VALUES ('#{v_email}', '#{v_answer}', '#{v_date}', '#{v_question_id}')")
    #db.exec("UPDATE user_accounts SET tokens='#{v_tokens}' WHERE email = '#{v_email}'")
    db.close
    # # session[:question_id] = ''
    # redirect '/start_game'=end
    "Post successful -thanks for the info! #{v_email} , #{v_answer}"  # feedback for Xcode console (successful POST)
end

post '/submit_login' do
    data_hash = {"user"=>params[:user], "pass"=>params[:pass]}

    #Assign Variables correct values
    v_user = data_hash["user"]
    v_pass = data_hash["pass"]
    db = connection()
    result = db.exec("SELECT user_name from user_accounts where user_name = '#{v_user}' and password = '#{v_pass}'")
    #db.exec("UPDATE user_accounts SET tokens='#{v_tokens}' WHERE email = '#{v_email}'")
    db.close
     if result.count > 0
        results = "true"
     else
        results = "false"
    end   
    results
end