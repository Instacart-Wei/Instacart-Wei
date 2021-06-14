batch_size = 10 #TODO: change this based on progress
sleep_time = 1
num_batches = 10 #TODO: change this

fails = []
while fails.size.zero? and num_batches.positive?
  # Fetch last few records
  ebt_cards = Credit.where(card_product_type: nil)
    .where(credit_card_type: 'EBT')
    .last(batch_size)

  ebt_cards.each do |card|
    begin
      card.card_product_type = 3
      card.save!
    rescue => e
      fails << { card: card, error: e }
    end
  end

  # Avoid hitting DB too hard
  sleep sleep_time
  num_batches -= 1
end

if fails.size.positive?
  puts 'Error occur during backfill:'
  fails.each do |fail_item|
    puts fail_item
  end
end
