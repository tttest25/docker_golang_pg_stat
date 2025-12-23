package database

import (
	"log"
	"os"
)

// GetDSN returns the Data Source Name for the database connection.
// It fetches the DATABASE_URL from the environment variables.
// If the variable is not set, it logs a fatal error.
func GetDSN() string {
	dsn := os.Getenv("DATABASE_URL")
	if dsn == "" {
		log.Fatal("FATAL: DATABASE_URL environment variable is not set")
	}
	return dsn
}
