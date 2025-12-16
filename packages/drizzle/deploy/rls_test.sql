-- Deploy: rls_test
-- made with <3 @ constructive.io

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    user_id TEXT NOT NULL
);

GRANT ALL ON TABLE users TO authenticated;
GRANT USAGE, SELECT ON SEQUENCE users_id_seq TO authenticated;

-- Enable RLS on users table
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- Create policy that checks JWT claims
CREATE POLICY users_owner_policy ON users
FOR ALL
TO authenticated
USING (user_id = current_setting('jwt.claims.user_id', true));