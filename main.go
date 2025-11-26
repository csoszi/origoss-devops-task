package main

import (
	"fmt"
	"log"
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	if r.URL.Path != "/" {
		http.NotFound(w, r)
		return
	}

	w.Header().Set("Content-Type", "text/plain; charset=utf-8")
	
	fmt.Fprintf(w, "Hello, World!")
	
	log.Printf("Request received for path: %s", r.URL.Path)
}

func main() {
	http.HandleFunc("/", handler)

	port := ":8080"
	
	log.Printf("Starting server on http://localhost%s", port)
	
	err := http.ListenAndServe(port, nil)
	
	if err != nil {
		log.Fatal("Server failed to start:", err)
	}
}