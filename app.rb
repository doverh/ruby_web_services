require 'sinatra'
require 'pg'
#require_relative 'pushmessage.rb'
# require_relative 'post.rb'


	#push = PushMessage.new

###################################################
#  Initialize Connection with AWS postgreSQL db   #
###################################################

	# load "./local_env.rb" if File.exists?("./local_env.rb")

	
	def connection()
  db_params = {host: ENV['dbhost'],
    port: ENV['dbport'],
    dbname: ENV['dbname'],
    user: ENV['dbuser'],
    password: ENV['dbpassword']
  }

  db = PG::Connection.new(db_params)
end

		
	
	get "/" do
	   erb :hello
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
    # v_input_answer = data_hash["input_answer"].to_i
    # v_tokens = params["tokens"].to_i - 1
    # v_question_id = params["question_id"]
    # date = Time.now.strftime("%d/%m/%Y %H:%M:%S")
    # db = connection()
    # db.exec("INSERT INTO answers (user_name, answer, date, question_id) VALUES ('#{v_email}', '#{v_answer}', '#{date}', '#{v_question_id}')")
    # #db.exec("UPDATE user_accounts SET tokens='#{v_tokens}' WHERE email = '#{v_email}'")
    # db.close
    # # session[:question_id] = ''
    # redirect '/start_game'=end
    "Post successful -thanks for the info!#{v_email}"  # feedback for Xcode console (successful POST)
end