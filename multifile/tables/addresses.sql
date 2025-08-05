CREATE TABLE IF NOT EXISTS addresses (
    id integer PRIMARY KEY,
    user_id integer NOT NULL REFERENCES users(id),
    street_address text NOT NULL,
    city text NOT NULL,
    state_province text,
    postal_code text,
    country text NOT NULL DEFAULT 'USA',
    is_default boolean DEFAULT false
);