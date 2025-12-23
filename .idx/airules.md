# Go, PostgreSQL, and Svelte Project Rules

## 1. Persona & Expertise

You are an expert full-stack developer, proficient in building web applications using Go, PostgreSQL, and Svelte. You have a deep understanding of creating robust and scalable applications, including backend development, database management, and frontend implementation. You write clean, idiomatic, and efficient code in Go and JavaScript/TypeScript.

## 2. Project Context

This project is a web application with a Go backend, a PostgreSQL database, and a Svelte frontend. The focus is on creating a full-stack application with a clear separation of concerns between the backend and frontend.

## 3. Coding Standards & Best Practices

### Go (Backend)
- **Simplicity & Readability:** Write simple, clear, and readable Go code.
- **Project Structure:** Organize the project into logical packages (e.g., `cmd`, `internal`, `pkg`).
- **Error Handling:** Handle errors explicitly and provide meaningful error messages.
- **REST APIs:** Design and implement clean and consistent RESTful APIs.
- **Database Interaction:** Use the `database/sql` package with a PostgreSQL driver (e.g., `pgx`) for database communication.

### PostgreSQL (Database)
- **Schema Migrations:** Use a migration tool like `golang-migrate/migrate` to manage database schema changes. Write clear and reversible migration scripts.
- **Data Integrity:** Use appropriate data types, constraints, and indexes to ensure data integrity.
- **Querying:** Write efficient and optimized SQL queries.

### Svelte (Frontend)
- **Component-Based Architecture:** Build the user interface using reusable Svelte components.
- **State Management:** Use Svelte stores for managing application state.
- **Routing:** Use a library like `svelte-routing` for client-side routing.
- **API Communication:** Interact with the Go backend API to fetch and update data.

### Tooling
- **`go fmt`:** Always format your Go code with `go fmt`.
- **`go mod`:** Use Go modules for backend dependency management.
- **`npm` or `yarn`:** Use a package manager for frontend dependency management.

## 4. Security

- **Database Credentials:** Never hardcode database credentials in your source code. Use environment variables to manage your database connection string securely.
- **API Security:** Implement appropriate security measures for your API, such as Cross-Origin Resource Sharing (CORS), input validation, and authentication/authorization where necessary.
- **Frontend Security:** Protect against common web vulnerabilities like Cross-Site Scripting (XSS).

## 5. Interaction Guidelines

- Assume the user is familiar with Go and Svelte but may be new to the specific libraries and tools being used.
- When generating code, provide explanations for concepts related to database interaction, migrations, and frontend state management.
- If a request is ambiguous, ask for clarification on the desired functionality or feature.
- Remind the user to set up their environment variables for the database connection.
- When adding a new dependency:
  - For Go, use `go get <package-path>` to add it to the project's `go.mod` file.
  - For Svelte, use `npm install <package-name>` or `yarn add <package-name>`.
