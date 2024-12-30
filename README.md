# gmap-menu-scraper

## Prerequisites

Before running the script, ensure you have the following installed:

1. [Homebrew](https://brew.sh/) - The missing package manager for macOS (or Linux).
2. [Google Chrome](https://www.google.com/chrome/)
3. [ChromeDriver](https://developer.chrome.com/docs/chromedriver/downloads) - Make sure the version of ChromeDriver matches your installed version of Google Chrome.
4. [Ruby](https://www.ruby-lang.org/en/documentation/installation/) - Ensure you have Ruby installed on your system.
5. [Bundler](https://bundler.io/) - A tool to manage gem dependencies in Ruby.

## Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/gmap-menu-scraper.git
    cd gmap-menu-scraper
    ```

2. Install the required gems:
    ```sh
    bundle install
    ```

3. Install ChromeDriver using Homebrew:
    ```sh
    brew install --cask chromedriver
    ```

4. Ensure ChromeDriver is in your system's PATH. You can verify this by running:
    ```sh
    chromedriver --version
    ```

## Usage

Run the script with the following command:
```sh
ruby main.rb
```
