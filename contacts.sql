CREATE TABLE "contacts" (
	"id" serial NOT NULL PRIMARY KEY,
	"name" text NOT NULL,
	"email" text NOT NULL
);

INSERT INTO contacts (name, email) VALUES ('Elmo','elmo@sesamestreet.com');

INSERT INTO contacts (name, email) VALUES ('Oscar the Grouch','oscar@sesamestreet.com');

INSERT INTO contacts (name, email) VALUES ('Bert','bert@sesamestreet.com');

INSERT INTO contacts (name, email) VALUES ('Ernie','ernie@sesamestreet.com');