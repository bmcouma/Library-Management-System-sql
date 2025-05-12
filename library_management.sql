-- ================================================================
-- Library Management System
-- A relational schema to manage books, authors, members, and loans
-- ================================================================

-- -------------------
-- Table: authors
-- Stores author details
-- -------------------
CREATE TABLE authors (
    author_id      INT             AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each author
    name           VARCHAR(100)    NOT NULL,                   -- Author's full name
    bio            TEXT                                    -- Optional biography of the author
);

-- -------------------
-- Table: books
-- Stores book details with FK to authors
-- -------------------
CREATE TABLE books (
    book_id        INT             AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each book
    title          VARCHAR(200)    NOT NULL,                   -- Title of the book
    author_id      INT             NOT NULL,                   -- FK to authors.author_id
    isbn           VARCHAR(13)     UNIQUE,                     -- Unique ISBN for each book
    published_year YEAR,                                       -- Year the book was published
    genre          VARCHAR(50),                                -- Genre of the book
    CONSTRAINT fk_books_author
        FOREIGN KEY (author_id)
        REFERENCES authors(author_id)
        ON DELETE RESTRICT                                      -- Prevent deleting authors with linked books
);

-- -------------------
-- Table: members
-- Stores library member records
-- -------------------
CREATE TABLE members (
    member_id      INT             AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each member
    full_name      VARCHAR(100)    NOT NULL,                   -- Member's full name
    email          VARCHAR(100)    NOT NULL UNIQUE,            -- Unique email address for contact
    join_date      DATE            NOT NULL DEFAULT CURRENT_DATE -- Date the member joined the library
);

-- -------------------
-- Table: loans
-- Records book loans linking members and books
-- -------------------
CREATE TABLE loans (
    loan_id        INT             AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each loan
    book_id        INT             NOT NULL,                   -- FK to books.book_id
    member_id      INT             NOT NULL,                   -- FK to members.member_id
    loan_date      DATE            NOT NULL DEFAULT CURRENT_DATE, -- Date the book was loaned
    return_date    DATE,                                       -- NULL until the book is returned
    CONSTRAINT fk_loans_book
        FOREIGN KEY (book_id)
        REFERENCES books(book_id)
        ON DELETE CASCADE,                                    -- Remove loans if the book is deleted
    CONSTRAINT fk_loans_member
        FOREIGN KEY (member_id)
        REFERENCES members(member_id)
        ON DELETE CASCADE                                     -- Remove loans if the member is deleted
);

-- ================================================================
-- End of Library Management System Schema
-- ================================================================