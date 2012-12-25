STRIPE_API_KEY = ENV['STRIPE_SECRET']
STRIPE_PUBLISHABLE_KEY = ENV['STRIPE_PUBLISHABLE']
STRIPE_CLIENT_ID = ENV['STRIPE_CLIENT_ID']


STRIPE_PLAN_ID = "tinysale"
STRIPE_TRIAL_PERIOD = 1.month

StripeEvent.setup do
  subscribe 'charge.failed' do |event|
    # Define subscriber behavior based on the event object
    event.class #=> Stripe::Event
    event.type  #=> "charge.failed"
    event.data  #=> { ... }
  end

  subscribe 'customer.created', 'customer.updated' do |event|
    p event.inspect
  end

  subscribe do |event|
   p event.inspect
  end
end

StripeEvent.event_retriever = Proc.new { |params| p params }