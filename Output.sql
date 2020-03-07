CREATE table users (
	user_id	bigserial	PRIMARY KEY	NOT NULL,
	first_name	varchar(50)	NOT NULL,
	last_name	varchar(50)	,
	account_name	varchar(50)	,
	email	varchar(50)	UNIQUE NOT NULL,
	role	varchar(15)	,
	joined	DATETIME  WITH TIME ZONE	DEFAULT CURRENT_TIMESTAMP,
	active	bool	DEFAULT false,
	password	varchar(255)	NOT NULL,
	telephone	varchar(35)	
);

	message_is_delivered	bool	DEFAULT false,
	message_is_read	bool	DEFAULT false,
	message_visible	bool	DEFAULT true
);

	message_category	varchar(30)	,
	message_sent_at	datetime	DEFAULT CURRENT_TIMESTAMP,
	message_is_delivered	bool	DEFAULT false
);

CREATE table teams (
	team_id	bigserial	PRIMARY KEY	NOT NULL,
	team_name	varchar(35)	NOT NULL,
	team_description	text	,
	team_motto	varchar(50)	,
	team_active	bool	DEFAULT true,
	"10,2",
	team_created_at	datetime WITH TIME ZONE	DEFAULT CURRENT_TIMESTAMP
);

	event_name	varchar(100)	not null,
	event_description	text	,
	event_words	json	,
	event_added	datetime with time zone	DEFAULT CURRENT_TIMESTAMP,
	event_starts_at	datetime with time zone	not null,
	event_ends__at	datetime with time zone	not null,
	event_active	bool	default true
);

CREATE table words (
	word_id	bigserial	PRIMARY KEY	NOT NULL,
	varchar	35,
	word_type	json	,
	word_added	datetime with timezone	DEFAULT CURRENT_TIMESTAMP,
	word_active	bool	DEFAULT true
);

CREATE table tags (
	tag_id	bigserial	PRIMARY KEY	NOT NULL,
	tag_title	varchar(35)	not null,
	tag_description	text	,
	tag_added	datetime with time zone	default current_timestamp,
	tag_active	bool	default true
);

CREATE table word_bids (
	word_bid_id	bigserial	PRIMARY KEY	NOT NULL,
	escrow_id	NOT NULL,
	bid_time	datetime	default current_timestamp,
	bid_session	bigserial	references sessions(session_id)	NOT NULL,
	bid_active	bool	default true,
	bid_won	bool	,
CREATE table escrow (
	escrow_id	bigserial	PRIMARY KEY	NOT NULL,
	team_id	not null,
	numeric	"10,2",
	transacrion_type	varchar(23)	,
	transaction_user	bigint	references users(user_id)	,
	transaction_time	datetime with time zone	default current_timestamp,
	transaction_session	bigint	,
	initial_balance	numeric("10,2")	not null,
	numeric	"10,2"
);

CREATE table password_recovery (
	password_recovery_id	bigserial	PRIMARY KEY	NOT NULL,
	user	bigint	references user(user_id)	,
	active	bool	default true,
	used	bool	default false
);

CREATE table word_collections (
	word_collection_id	bigserial	PRIMARY KEY	NOT NULL,
	words	json	,
	datetime_with_time_zone
);

	bigserial(TRUE)	references event(not_null),
	collection	json	,
	active	bool	default true,
	added	datetime with time zone	default current_timestamp
);
