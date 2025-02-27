create database freelance_platform;

\c freelance_platform;

create table users (
    id serial primary key,
    username varchar(50) unique not null,
    email varchar(100) unique not null,
    password_hash text not null,
    role varchar(20) check (role in ('admin', 'client', 'freelancer')) not null,
    created_at timestamp default current_timestamp
);

create table freelancer_profiles (
    id serial primary key,
    user_id int unique not null references users(id) on delete cascade,
    skills text,
    experience_years int check (experience_years >= 0),
    hourly_rate decimal(10,2) check (hourly_rate >= 0)
);

create table clients (
    id serial primary key,
    user_id int unique not null references users(id) on delete cascade,
    company_name varchar(100),
    industry varchar(50)
);

create table projects (
    id serial primary key,
    client_id int not null references clients(id) on delete cascade,
    title varchar(255) not null,
    description text,
    budget decimal(10,2) check (budget >= 0),
    status varchar(20) check (status in ('open', 'in_progress', 'completed', 'cancelled')) default 'open',
    created_at timestamp default current_timestamp
);

create table bids (
    id serial primary key,
    freelancer_id int not null references freelancer_profiles(id) on delete cascade,
    project_id int not null references projects(id) on delete cascade,
    bid_amount decimal(10,2) check (bid_amount >= 0) not null,
    message text,
    status varchar(20) check (status in ('pending', 'accepted', 'rejected')) default 'pending',
    created_at timestamp default current_timestamp
);

create table contracts (
    id serial primary key,
    project_id int unique not null references projects(id) on delete cascade,
    freelancer_id int not null references freelancer_profiles(id) on delete cascade,
    start_date date not null,
    end_date date,
    payment decimal(10,2) check (payment >= 0) not null,
    status varchar(20) check (status in ('active', 'completed', 'cancelled')) default 'active'
);

create table payments (
    id serial primary key,
    contract_id int unique not null references contracts(id) on delete cascade,
    amount decimal(10,2) check (amount >= 0) not null,
    payment_date timestamp default current_timestamp
);

create table reviews (
    id serial primary key,
    reviewer_id int not null references users(id) on delete cascade,
    reviewed_id int not null references users(id) on delete cascade,
    rating int check (rating between 1 and 5) not null,
    comment text,
    created_at timestamp default current_timestamp
);

create table messages (
    id serial primary key,
    sender_id int not null references users(id) on delete cascade,
    receiver_id int not null references users(id) on delete cascade,
    content text not null,
    sent_at timestamp default current_timestamp
);

create table project_categories (
    id serial primary key,
    name varchar(100) unique not null
);

create table project_category_links (
    project_id int not null references projects(id) on delete cascade,
    category_id int not null references project_categories(id) on delete cascade,
    primary key (project_id, category_id)
);

create table user_statuses (
    id serial primary key,
    user_id int unique not null references users(id) on delete cascade,
    status varchar(20) check (status in ('active', 'suspended', 'deleted')) default 'active'
);

create table transactions (
    id serial primary key,
    user_id int not null references users(id) on delete cascade,
    amount decimal(10,2) check (amount >= 0) not null,
    transaction_date timestamp default current_timestamp,
    type varchar(20) check (type in ('deposit', 'withdrawal', 'payment')) not null
);

create table files (
    id serial primary key,
    user_id int not null references users(id) on delete cascade,
    filename varchar(255) not null,
    file_path text not null,
    uploaded_at timestamp default current_timestamp
);

create table notifications (
    id serial primary key,
    user_id int not null references users(id) on delete cascade,
    message text not null,
    is_read boolean default false,
    created_at timestamp default current_timestamp
);
