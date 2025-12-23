package main

import (
	"database/sql"
	"log"
	"net/http"
	"os"

	"dockergolangpg/backend/internal/database"
	"dockergolangpg/backend/internal/handlers"

	_ "github.com/lib/pq"
)

func main() {
	// Connect to the database
	db, err := sql.Open("postgres", database.GetDSN())
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	// Create a new router
	router := http.NewServeMux()

	// Register handlers
	router.HandleFunc("/users", handlers.GetUsers(db))
	router.HandleFunc("/posts", handlers.GetPosts(db))

	// Get the port from the environment, with a fallback to 8080
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	// Start the server
	log.Printf("Server starting on port %s...", port)
	log.Fatal(http.ListenAndServe(":"+port, router))

}
