package handlers

import (
	"database/sql"
	"encoding/json"
	"net/http"

	"dockergolangpg/backend/internal/models"
)

// GetUsers returns a handler for getting all users.
func GetUsers(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		rows, err := db.QueryContext(r.Context(), "SELECT id, username, email, created_at FROM users")
		if err != nil {
			http.Error(w, "Failed to query users", http.StatusInternalServerError)
			return
		}
		defer rows.Close()

		users := []models.User{}
		for rows.Next() {
			var user models.User
			if err := rows.Scan(&user.ID, &user.Username, &user.Email, &user.CreatedAt); err != nil {
				http.Error(w, "Failed to scan user", http.StatusInternalServerError)
				return
			}
			users = append(users, user)
		}

		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		json.NewEncoder(w).Encode(users)
	}
}
