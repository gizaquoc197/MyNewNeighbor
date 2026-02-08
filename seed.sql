-- seed.sql
-- Re-run safety strategy: WIPE + INSERT
-- This script TRUNCATES all tables (dev/demo only) and re-inserts deterministic demo data.

BEGIN;

-- Wipe in dependency-safe order
TRUNCATE TABLE
  messages,
  conversation_members,
  conversations,
  activity_requests,
  event_rsvps,
  events,
  organization_followers,
  activities,
  hidden_recommendations,
  blocks,
  connections,
  organizations,
  users
RESTART IDENTITY CASCADE;

-- ---------- Users (fixed UUIDs so other rows can reference them) ----------
INSERT INTO users (id, email, full_name) VALUES
  ('11111111-1111-1111-1111-111111111111', 'alice@example.com', 'Alice Nguyen'),
  ('22222222-2222-2222-2222-222222222222', 'bob@example.com',   'Bob Tran'),
  ('33333333-3333-3333-3333-333333333333', 'cathy@example.com', 'Cathy Le'),
  ('44444444-4444-4444-4444-444444444444', 'dan@example.com',   'Dan Pham');

-- ---------- 2–3 organizations ----------
INSERT INTO organizations (id, name, description) VALUES
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Houston Runners Club', 'Weekly runs & meetups'),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'Foodies United',       'Try restaurants together'),
  ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'Volunteer Squad',     'Local service projects');

-- followers (so org pages look alive)
INSERT INTO organization_followers (user_id, org_id) VALUES
  ('11111111-1111-1111-1111-111111111111', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb'),
  ('22222222-2222-2222-2222-222222222222', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'),
  ('33333333-3333-3333-3333-333333333333', 'cccccccc-cccc-cccc-cccc-cccccccccccc'),
  ('44444444-4444-4444-4444-444444444444', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa');

-- ---------- 3–5 events ----------
INSERT INTO events (id, org_id, title, description, starts_at, ends_at, location, created_by) VALUES
  ('e1111111-1111-1111-1111-111111111111', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
   'Saturday 5K Run', 'Casual pace, all welcome',
   now() + interval '2 days', now() + interval '2 days 2 hours',
   'Memorial Park', '11111111-1111-1111-1111-111111111111'),

  ('e2222222-2222-2222-2222-222222222222', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
   'Ramen Night', 'Try a new ramen spot',
   now() + interval '4 days', now() + interval '4 days 2 hours',
   'Downtown', '22222222-2222-2222-2222-222222222222'),

  ('e3333333-3333-3333-3333-333333333333', 'cccccccc-cccc-cccc-cccc-cccccccccccc',
   'Park Cleanup', 'Bring gloves if you have them',
   now() + interval '7 days', now() + interval '7 days 3 hours',
   'Buffalo Bayou Park', '33333333-3333-3333-3333-333333333333'),

  ('e4444444-4444-4444-4444-444444444444', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
   'Dessert Crawl', 'Low-key dessert tasting',
   now() + interval '9 days', now() + interval '9 days 2 hours',
   'Midtown', '22222222-2222-2222-2222-222222222222');

-- event RSVPs (so future GET endpoints have results)
INSERT INTO event_rsvps (user_id, event_id, status) VALUES
  ('22222222-2222-2222-2222-222222222222', 'e1111111-1111-1111-1111-111111111111', 'going'),
  ('33333333-3333-3333-3333-333333333333', 'e1111111-1111-1111-1111-111111111111', 'interested'),
  ('11111111-1111-1111-1111-111111111111', 'e3333333-3333-3333-3333-333333333333', 'going'),
  ('44444444-4444-4444-4444-444444444444', 'e2222222-2222-2222-2222-222222222222', 'going');

-- ---------- 2–3 activities ----------
INSERT INTO activities (id, title, description, location, starts_at, ends_at, created_by) VALUES
  ('d1111111-1111-1111-1111-111111111111',
   'Coffee Chat', 'Meet and chat',
   'Local cafe',
   now() + interval '1 day', now() + interval '1 day 1 hour',
   '11111111-1111-1111-1111-111111111111'),

  ('d2222222-2222-2222-2222-222222222222',
   'Study Session', 'Quiet coworking',
   'Library',
   now() + interval '3 days', now() + interval '3 days 2 hours',
   '22222222-2222-2222-2222-222222222222'),

  ('d3333333-3333-3333-3333-333333333333',
   'Pick-up Basketball', 'Friendly game',
   'Community Center',
   now() + interval '5 days', now() + interval '5 days 2 hours',
   '44444444-4444-4444-4444-444444444444');

-- activity requests
INSERT INTO activity_requests (user_id, activity_id, status) VALUES
  ('33333333-3333-3333-3333-333333333333', 'd1111111-1111-1111-1111-111111111111', 'requested'),
  ('11111111-1111-1111-1111-111111111111', 'd2222222-2222-2222-2222-222222222222', 'requested');

-- connections (unordered uniqueness handled by schema)
INSERT INTO connections (user_id_1, user_id_2, status) VALUES
  ('11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222', 'accepted'),
  ('11111111-1111-1111-1111-111111111111', '44444444-4444-4444-4444-444444444444', 'pending');

-- blocks / hidden (optional but useful for later recommendation tests)
INSERT INTO blocks (blocker_user_id, blocked_user_id) VALUES
  ('22222222-2222-2222-2222-222222222222', '33333333-3333-3333-3333-333333333333');

INSERT INTO hidden_recommendations (user_id, hidden_user_id) VALUES
  ('11111111-1111-1111-1111-111111111111', '33333333-3333-3333-3333-333333333333');

-- conversations tied to an event + a direct chat
INSERT INTO conversations (id, event_id, activity_id, created_by) VALUES
  ('f1111111-1111-1111-1111-111111111111', 'e1111111-1111-1111-1111-111111111111', NULL, '11111111-1111-1111-1111-111111111111'),
  ('f2222222-2222-2222-2222-222222222222', NULL, NULL, '22222222-2222-2222-2222-222222222222');

INSERT INTO conversation_members (conversation_id, user_id) VALUES
  ('f1111111-1111-1111-1111-111111111111', '11111111-1111-1111-1111-111111111111'),
  ('f1111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222'),
  ('f2222222-2222-2222-2222-222222222222', '22222222-2222-2222-2222-222222222222'),
  ('f2222222-2222-2222-2222-222222222222', '44444444-4444-4444-4444-444444444444');

INSERT INTO messages (conversation_id, sender_user_id, body) VALUES
  ('f1111111-1111-1111-1111-111111111111', '11111111-1111-1111-1111-111111111111', 'Hey! Want to join the Saturday run?'),
  ('f1111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222', 'Yep — what time does it start?'),
  ('f2222222-2222-2222-2222-222222222222', '22222222-2222-2222-2222-222222222222', 'Welcome to the neighborhood!');

COMMIT;
