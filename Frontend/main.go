package main

import (
	"fmt"
	"html/template"
	"net/http"
)

func index(w http.ResponseWriter, r *http.Request) {
	template, err := template.ParseFiles("src/Pagina.html")
	if err != nil {
		fmt.Fprintf(w, "PAGINA NO ENCONTRADA")
	} else {
		template.Execute(w, nil)
	}
}

func main() {
	http.HandleFunc("/", index)
	http.Handle("/static/", http.StripPrefix("/static/", http.FileServer(http.Dir("static"))))
	fmt.Println("SERVIDOR DE HTML FUNCIONANDO")
	http.ListenAndServe(":42013", nil)
}
