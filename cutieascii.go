package main

import (
	"flag"
	"fmt"
	"math/rand"
	"os"
	"strings"
)

const (
	version = "0.1.0"
	Reset   = "\033[0m"
	Bold    = "\033[1m"
	Red     = "\033[31m"
	Green   = "\033[32m"
	Yellow  = "\033[33m"
	Blue    = "\033[34m"
	Magenta = "\033[35m"
	Cyan    = "\033[36m"
)

func main() {

	showVersion := flag.Bool("v", false, "Show Version")

	flag.Parse()

	if *showVersion {
		fmt.Println("Cutieascii version:", version)
		os.Exit(0)
	}

	content, err := os.ReadFile("kaoscii/allmojis")
	if err != nil {
		fmt.Println("Error reading file:", err)
		return
	}

	displayRandomEmoji(string(content))
}

func displayRandomEmoji(content string) {
	// divide content into separate emojis by double newlines
	emojis := strings.Split(content, "\n\n")

	var validEmojis []string
	for _, emoji := range emojis {
		cleanedEmoji := strings.TrimSpace(emoji)
		if cleanedEmoji != "" {
			validEmojis = append(validEmojis, cleanedEmoji)
		}
	}

	if len(validEmojis) == 0 {
		fmt.Println("No valid emojis found.")
		return
	}

	// select a random emoji
	randomIndex := rand.Intn(len(validEmojis))

	colors := []string{Yellow, Red, Green, Blue, Magenta, Cyan}
	color := colors[rand.Intn(len(colors))]

	fmt.Println(Bold + color + validEmojis[randomIndex])
}
