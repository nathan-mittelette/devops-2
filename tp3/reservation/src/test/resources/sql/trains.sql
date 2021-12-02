create sequence car_id_seq
    increment by 50;



create sequence train_id_seq
    increment by 50;



create sequence travel_id_seq
    increment by 50;



create sequence seat_id_seq
    increment by 50;



create sequence booking_id_seq
    increment by 50;



create sequence ticket_id_seq
    increment by 50;



create sequence passenger_id_seq
    increment by 50;



create sequence invoice_id_seq
    increment by 50;



create table agency
(
    agency_id       varchar(255) not null
        constraint pk_agency
            primary key,
    agency_name     varchar(255),
    agency_url      varchar(255),
    agency_timezone varchar(255),
    agency_lang     varchar(255)
);



create table routes
(
    route_id         varchar(255) not null
        constraint pk_routes
            primary key,
    agency_id        varchar(255)
        constraint fk_routes_agency
            references agency,
    route_short_name varchar(255),
    route_long_name  varchar(255),
    route_desc       varchar(255),
    route_type       integer,
    route_url        varchar(255),
    route_color      varchar(255),
    route_text_color varchar(255)
);



create table calendar
(
    service_id bigint,
    monday     boolean,
    tuesday    boolean,
    wednesday  boolean,
    thursday   boolean,
    friday     boolean,
    saturday   boolean,
    sunday     boolean,
    start_date date,
    end_date   date
);



create index idx_calendar_start_date
    on calendar (start_date desc);

create index idx_calendar_end_date
    on calendar (end_date desc);

create index idx_calendar_service_id
    on calendar (service_id desc);

create table calendar_dates
(
    service_id     bigint,
    date           date,
    exception_type integer
);



create table stops
(
    stop_id        varchar(255) not null
        constraint pk_stops
            primary key,
    stop_name      varchar(255),
    stop_desc      boolean,
    stop_lat       double precision,
    stop_lon       double precision,
    zone_id        varchar(255),
    stop_url       varchar(255),
    location_type  integer,
    parent_station varchar(255)
);



create index idx_stop_names
    on stops (stop_name desc);

create table trips
(
    route_id      varchar(255)
        constraint fk_trips_routes
            references routes,
    service_id    integer,
    trip_id       varchar(255) not null
        constraint pk_trips
            primary key,
    trip_headsign integer,
    direction_id  varchar(255),
    block_id      varchar(255),
    shape_id      varchar(255),
    trip_motor    varchar(255)
);



create table stop_times
(
    trip_id             varchar(255)
        constraint fk_stop_times_trips
            references trips,
    arrival_time        time,
    departure_time      time,
    stop_id             varchar(255)
        constraint fk_stop_times_stops
            references stops,
    stop_sequence       integer,
    stop_headsign       varchar(255),
    pickup_type         integer,
    drop_off_type       integer,
    shape_dist_traveled varchar(255)
);



create table transfers
(
    from_stop_id      varchar(255),
    to_stop_id        varchar(255),
    transfer_type     varchar(255),
    min_transfer_time varchar(255)
);



create table train
(
    train_id bigint not null
        constraint pk_train
            primary key
);



create table car
(
    car_id                   bigint not null
        constraint pk_car
            primary key,
    car_type                 varchar(3)
        constraint check_car_type_valid
            check ((car_type)::text = ANY ((ARRAY ['VU'::character varying, 'VTU'::character varying])::text[])),
    car_class                varchar(3)
        constraint check_car_class_valid
            check ((car_class)::text = ANY
                   ((ARRAY ['A'::character varying, 'B'::character varying, 'AB'::character varying])::text[])),
    number_seat_first_class  integer
        constraint check_car_number_seat_first_class_valid
            check (number_seat_first_class = ANY (ARRAY [0, 58])),
    number_seat_second_class integer
        constraint check_car_number_seat_second_class_valid
            check (number_seat_second_class = ANY (ARRAY [0, 88])),
    train_id                 bigint
        constraint fk_train
            references train
);



create table seat
(
    seat_id bigint not null
        constraint pk_seat
            primary key,
    seat_number integer,
    car_id  bigint
        constraint fk_car
            references car
);



create table travel
(
    travel_id          bigint       not null
        constraint pk_travel
            primary key,
    price_first_class  double precision,
    price_second_class double precision,
    trip_id            varchar(255) not null
        constraint fk_trip
            references trips,
    train_id           bigint
        constraint fk_train
            references train
);



create table passenger
(
    passenger_id bigint generated by default as identity
        constraint pk_passenger
            primary key,
    firstname    varchar(255),
    lastname     varchar(255),
    birthdate    varchar(255),
    email        varchar(255),
    phone_number varchar(255)
);



create table booking
(
    booking_id        bigint not null
        constraint pk_booking
            primary key,
    booking_number    varchar(10),
    travel_id         bigint
        constraint fk_travel
            references travel,
    passenger_id      bigint
        constraint fk_passenger
            references passenger,
    date              date,
    departure_station varchar(255)
        constraint fk_stop_d_booking
            references stops,
    arrival_station   varchar(255)
        constraint fk_stop_a_booking
            references stops
);



create table ticket
(
    ticket_id     bigint not null
        constraint pk_ticket
            primary key,
    ticket_number varchar(16),
    paid_price    varchar(16),
    seat_id       bigint
        constraint fk_seat
            references seat,
    passenger_id  bigint
        constraint fk_passenger
            references passenger,
    booking_id    bigint
        constraint fk_booking
            references booking
);



create table invoice
(
    invoice_id  bigint not null
        constraint pk_invoice
            primary key,
    total_price varchar(16),
    booking_id  bigint
        constraint fk_booking
            references booking
);



INSERT INTO TRAIN
VALUES (1);

INSERT INTO CAR
VALUES (1, 'VTU', 'A', 58, 0, 1);

INSERT INTO SEAT
VALUES (1, 1, 1);
