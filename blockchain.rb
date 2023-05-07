###########################
#	Improved version of "Build your own blockchain from scratch in 20 lines of Ruby!"	
#		from https://github.com/openblockchains/awesome-blockchains/tree/master/blockchain.rb
#  
#   and inspired by
#     Let's Build the Tiniest Blockchain In Less Than 50 Lines of Python by Gerald Nash
#     see https://medium.com/crypto-currently/lets-build-the-tiniest-blockchain-e70965a248b
#
#	Now, Blockchain with prompt transactions, transactions counter for each block, 
#											 ledger, proof of work and dynamic variable name. 
#
#	This Blockchain can be set as a loop for infinite using of the Blockchain.
#
#
#  to run use:
#    $ ruby ./blockchain.rb
#
#
#

require 'digest'    							# For hash checksum digest function SHA256
require 'pp'        							# For pp => pretty printer
# require 'pry'                     # For on the fly debugging
require_relative 'block'					# class Block
	# method Transactions

require_relative 'transaction'
LEDGER = []
require "socket"

require 'sinatra'


require 'mongo'


#####
## Blockchain building, one block at a time.
##  This will create a first block with fake transactions
## 	and then prompt user for transactions informations and set it in a new block.
## 	
## Each block can take multiple transaction
## 	when a user has finish to add transaction, 
##  the block is added to the blockchain and writen in the ledger

get "/blocks" do
	content_type :json
	response = {ledger: LEDGER}
	status 200
	response.blocks.to_json
end
def get_data
	transactions_block ||= []
	blank_transaction = Hash[from: "", to: "",
													 what: "", qty: "" ,vote: ""]

		$client.puts "" 
		$client.puts "Enter your name for the new transaction"
		from = $client.gets.chomp
		$client.puts "" 
		$client.puts "What do you want to send ?"
		what = $client.gets.chomp
		$client.puts "" 
		$client.puts "How much quantity ?"
		qty  = $client.gets.chomp
		$client.puts "" 
		$client.puts "Who do you want to send it to ?"
		to 	 = $client.gets.chomp
		$client.puts ""
		$client.puts "Who do u want to vote"
		vote = $client.gets.chomp

		transaction = Hash[from: "#{from}", to: "#{to}", 
											 what: "#{what}", qty: "#{qty}", vote: "#{vote}"]
		transactions_block << transaction

		$client.puts "" 
		return transactions_block
end



def create_first_block
	i = 0
	instance_variable_set( "@b#{i}", 
												 Block.first( 
													{ from: "Jerry", to: "Guille", what: "Tulip Bloemendaal Sunset", qty: 10, vote:"x" },
													{ from: "Jerry", to: "David", what: "Tulip Semper Augustus", qty: 7 ,vote: "x"} )
											 )
	LEDGER << @b0
	pp @b0
	p "============================"

end
	
	$cont= 1
	
def add_block
	i = $cont

		instance_variable_set("@b#{i}", Block.next( (instance_variable_get("@b#{i-1}")), get_data))
		LEDGER << instance_variable_get("@b#{i}")
		p "============================"
		pp instance_variable_get("@b#{i}")
		p "============================"
		i += 1
		$cont = i
	
end

def launcher
	puts "==========================="
	puts ""
	puts "Welcome to Simple Blockchain In Ruby !"
	puts ""

	puts "This program was created by Anthony Amar for and educationnal purpose"
	puts ""

	puts "Wait for the genesis (the first block of the blockchain)"
	puts ""

	puts "" 
	puts "" 
	puts "==========================="
	create_first_block
	port = ENV.fetch("PORT", 3001).to_i
	server  = TCPServer.new('192.168.0.24', port)
	loop {
	  $client  = server.accept
	  puts "Hola"
	  $client.puts "Hello"

		add_block
	  
	  $client.close
	}

end

launcher
