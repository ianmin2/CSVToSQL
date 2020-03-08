CREATE table users (
	user_id	bigserial	PRIMARY KEY	NOT NULL,
	first_name	varchar	NOT NULL,
	last_name	varchar	,
	username	varchar	,
	email	varchar	UNIQUE NOT NULL,
	user_role	varchar	,
	joined	timestamp	DEFAULT CURRENT_TIMESTAMP,
	active	bool	DEFAULT false,
	user_password	varchar(255)	NOT NULL,
	isteamleader	bool	,
	telephone	varchar(35)	
);

CREATE table internal_messaging (
	internal_messaging_id	bigserial	PRIMARY KEY	NOT NULL,
	originating_user	bigint	references users(user_id)	not null,
	originating_user	bigint	references users(user_id)	not null,
	terminating_user	bigint	references users(user_id)	not null,
	message_body	text	not null,
	message_category	varCHAR(30)	default message,
	message_sent_at	timestamp	DEFAULT CURRENT_TIMESTAMP,
	message_is_delivered	bool	DEFAULT false,
	message_is_read	bool	DEFAULT false,
	message_visible	bool	DEFAULT true
);

CREATE table third_party_messaging (
	third_party_messaging_id	bigserial	PRIMARY KEY	NOT NULL,
	sending_email	text	references users(email)	not null,
	receiving_email	text	not null,
	message_body	text	not null,
	message_category	varchar(30)	,
	message_sent_at	datetime	DEFAULT CURRENT_TIMESTAMP,
	message_is_delivered	bool	DEFAULT false
);

CREATE table teams (
	team_id	bigserial	PRIMARY KEY	NOT NULL,
	team_name	varchar(35)	NOT NULL,
	team_description	text	,
	team_motto	varchar(50)	,
	team_lead	bigint	references users(user_id)	not null,
	team_event	bigint	references teams(team_id)	not null,
	team_active	bool	DEFAULT true,
	team_starting_balance	numeric(10,2 )	,
	team_members	json	,
	team_created_at	timestamp	DEFAULT CURRENT_TIMESTAMP
);

CREATE table events (
	event_id	bigserial	PRIMARY KEY	NOT NULL,
	event_name	varchar(100)	not null,
	event_description	text	,
	event_words	json	,
	event_added	timestamp	DEFAULT CURRENT_TIMESTAMP,
	event_starts_at	timestamp	not null,
	event_ends__at	timestamp	not null,
	event_active	bool	default true
);

CREATE table words (
	word_id	bigserial	PRIMARY KEY	NOT NULL,
	word_title	varchar(35)	not null,
	word_type	json	,
	word_added	timestamp	DEFAULT CURRENT_TIMESTAMP,
	word_active	bool	DEFAULT true
);

CREATE table tags (
	tag_id	bigserial	PRIMARY KEY	NOT NULL,
	tag_title	varchar(35)	not null,
	tag_description	text	,
	tag_added	timestamp	default current_timestamp,
	tag_active	bool	default true
);

CREATE table word_bids (
	word_bid_id	bigserial	PRIMARY KEY	NOT NULL,
	escrow_reference	bigint	references escrow(escrow_id)	NOT NULL,
	bid_time	datetime	default current_timestamp,
	bid_session	bigint	references sessions(session_id)	NOT NULL,
	bid_active	bool	default true,
	bid_won	bool	
);

CREATE table escrow (
	escrow_id	bigserial	PRIMARY KEY	NOT NULL,
	team_reference	bigint	references teams(team_id)	not null,
	transaction_amount	numeric(10,2)	not null,
	transacrion_type	varchar(23)	,
	transaction_user	bigint	references users(user_id)	,
	transaction_reference	json	,
	transaction_time	timestamp	default current_timestamp,
	transaction_session	bigint	,
	initial_balance	numeric(10,2)	not null,
	revised_balance	numeric(10,2)	,
	transaction_active	bool	default true
);

CREATE table password_recovery (
	password_recovery_id	bigserial	PRIMARY KEY	NOT NULL,
	user	bigint	references user(user_id)	,
	recovery__key	text	not null,
	requested_at	timestamp	default current_timestamp,
	active	bool	default true,
	used	bool	default false
);

CREATE table word_collections (
	word_collection_id	bigserial	PRIMARY KEY	NOT NULL,
	collection_name	varchar(50)	not null,
	words	json	,
	timestamp
);

CREATE table event_word_collections (
	event_word_collection_id	bigserial	PRIMARY KEY	NOT NULL,
	event_collection_name	varchar(50)	not null,
	event_reference	bigint	references events(event_id)	not null,
	collection	json	,
	active	bool	default true,
	added	timestamp	default current_timestamp
);
