module MyModule::SubscriptionService {
    use aptos_framework::signer;
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin;
    use aptos_framework::timestamp;

    /// Struct representing a subscription plan
    struct SubscriptionPlan has store, key {
        monthly_fee: u64,        // Monthly subscription fee in APT
        total_revenue: u64,      // Total revenue collected
        subscriber_count: u64,   // Number of active subscribers
    }

    /// Struct representing a user's subscription
    struct UserSubscription has store, key {
        plan_owner: address,     // Address of the subscription plan owner
        expiry_time: u64,        // Timestamp when subscription expires
        is_active: bool,         // Whether subscription is currently active
    }

    /// Function to create a new subscription plan with monthly fee
    public fun create_subscription_plan(owner: &signer, monthly_fee: u64) {
        let plan = SubscriptionPlan {
            monthly_fee,
            total_revenue: 0,
            subscriber_count: 0,
        };
        move_to(owner, plan);
    }

    /// Function for users to subscribe to a plan by paying monthly fee
    public fun subscribe_to_plan(
        subscriber: &signer, 
        plan_owner: address
    ) acquires SubscriptionPlan, UserSubscription {
        let subscriber_addr = signer::address_of(subscriber);
        let plan = borrow_global_mut<SubscriptionPlan>(plan_owner);
        
        // Transfer monthly fee from subscriber to plan owner
        let payment = coin::withdraw<AptosCoin>(subscriber, plan.monthly_fee);
        coin::deposit<AptosCoin>(plan_owner, payment);
        
        // Update plan revenue and subscriber count
        plan.total_revenue = plan.total_revenue + plan.monthly_fee;
        plan.subscriber_count = plan.subscriber_count + 1;
        
        // Calculate expiry time (30 days from now in seconds)
        let current_time = timestamp::now_seconds();
        let expiry_time = current_time + (30 * 24 * 60 * 60); // 30 days
        
        // Create or update user subscription
        if (exists<UserSubscription>(subscriber_addr)) {
            let subscription = borrow_global_mut<UserSubscription>(subscriber_addr);
            subscription.plan_owner = plan_owner;
            subscription.expiry_time = expiry_time;
            subscription.is_active = true;
        } else {
            let subscription = UserSubscription {
                plan_owner,
                expiry_time,
                is_active: true,
            };
            move_to(subscriber, subscription);
        }
    }
}