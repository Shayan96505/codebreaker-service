create table match
(
    match_id      CHAR(16) FOR BIT DATA not null,
    code_length   integer,
    criterion     integer,
    deadline      timestamp             not null,
    game_count    integer,
    pool          varchar(255)          not null,
    started       timestamp             not null,
    originator_id CHAR(16) FOR BIT DATA not null,
    winner_id     CHAR(16) FOR BIT DATA,
    primary key (match_id)
);
create table match_players
(
    matches_match_id CHAR(16) FOR BIT DATA not null,
    players_user_id  CHAR(16) FOR BIT DATA not null
);
create table user_profile
(
    user_id      CHAR(16) FOR BIT DATA not null,
    connected    timestamp             not null,
    created      timestamp             not null,
    display_name varchar(255)          not null,
    oauth_key    varchar(255)          not null,
    primary key (user_id)
);
create index IDXloyix2kr5uwndqrblb242x3gk on match (code_length);
create index IDXtjinb4htqg29y0b0ujxg1rnli on match (game_count);
create index IDXs836wyhyo3rv6hrin679fgoy3 on match (started, deadline);
create index IDXakmwux4w2swsj69pg3ignha1v on user_profile (created);
create index IDX7amnj5kvh6ct9ihfmqctn97s1 on user_profile (connected);
alter table user_profile
    add constraint UK_j35xlx80xoi2sb176qdrtoy69 unique (display_name);
alter table user_profile
    add constraint UK_6f815wi5o4jq8p1q1w63o4mhd unique (oauth_key);
alter table match
    add constraint FK75k7qj50d7mtu2vyrhh0tgdus foreign key (originator_id) references user_profile;
alter table match
    add constraint FKgu3dwiyrqwy4j943ely6vieo9 foreign key (winner_id) references user_profile;
alter table match_players
    add constraint FKa9j9ow3kfp95tmk7emm8phl5j foreign key (players_user_id) references user_profile;
alter table match_players
    add constraint FK9342tj6bgb4duaula6sq6brok foreign key (matches_match_id) references match;
