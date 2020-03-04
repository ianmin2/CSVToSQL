
CREATE table quotes (
	quote_id	bigserial	PRIMARY KEY	NOT NULL,
	currency	money,
	time	datetime	default current_timestamp,
	player	bigint	references players(player_id)	not null,
);

CREATE table players (
	player_id	bigserial	PRIMARY KEY	NOT NULL,
	name	varchar(35),
);
