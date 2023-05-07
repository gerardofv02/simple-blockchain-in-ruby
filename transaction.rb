require_relative 'blockchain'
def get_transactions_data

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
		# $client.puts "Do you want to make another transaction for this block ? (Y/n)"
		# new_transaction = $client.gets.chomp

		# if new_transaction == "y"
		# 	self
		# else
		# 	return transactions_block
		# 	break
		# end

end