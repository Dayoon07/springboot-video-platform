package com.e.d.model.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "WHYNOT_SUBSCRIPTIONS")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SubscriptionsEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "subscription_id", nullable = false)
	private long subscriptionId;
	
	@Column(name = "subscriber_id", nullable = false)
	private long subscriberId;
	
	@Column(name = "creator_id", nullable = false)
	private long creatorId;
	
	@Column(name = "subscribed_at", nullable = false)
	private String subscribedAt;
	
}
