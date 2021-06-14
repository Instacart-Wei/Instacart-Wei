batch_size = 10 #TODO: change this based on progress
sleep_time = 1
num_batches = 10 #TODO: change this

fails = []
while fails.size == 0 and num_batches > 0
	# Fetch last few records
	ebt_cards = Credit.where(card_product_type: nil)
		.where(credit_card_type: "EBT")
		.last(batch_size)

	ebt_cards.each do |card|
        begin
			card.card_product_type = 3
			card.save!
		rescue => e
			fails << {card: card, error: e}
		end
	end

	# Avoid hitting DB too hard
	sleep sleep_time
	num_batches -= 1
end

if fails.size > 0
	puts "Error occur:"
	fails.each |fail_item|
		puts fail_item
	end
end








[
  [0] 71823173,
  [1] 71823181,
  [2] 71823221,
  [3] 71823233,
  [4] 71823243,
  [5] 71823248,
  [6] 71823511,
  [7] 71823513,
  [8] 71830972,
  [9] 71831036
]
