package handlers

import (
	"database/sql"
	"encoding/json"
	"net/http"

	"dockergolangpg/backend/internal/models"
)

// GetPosts returns a handler for getting all posts.
func GetPosts(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		rows, err := db.QueryContext(r.Context(), "SELECT id, user_id, title, content, created_at FROM posts")
		if err != nil {
			http.Error(w, "Failed to query posts", http.StatusInternalServerError)
			return
		}
		defer rows.Close()

		posts := []models.Post{}
		for rows.Next() {
			var post models.Post
			if err := rows.Scan(&post.ID, &post.UserID, &post.Title, &post.Content, &post.CreatedAt); err != nil {
				http.Error(w, "Failed to scan post", http.StatusInternalServerError)
				return
			}
			posts = append(posts, post)
		}

		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		json.NewEncoder(w).Encode(posts)
	}
}
