
# Tweeter: Rails 8 Modern Stack Exploration

A reactive Twitter clone built to demonstrate the capabilities of Rails 8, Hotwire, and the Solid stack. This application focuses on high-performance, single-page-application (SPA) behavior without the complexity of a heavy JavaScript framework.

## Technical Stack

* **Ruby on Rails 8.1**: Utilizing the latest framework features.
* **Hotwire**: Combining Turbo and Stimulus for reactive user interfaces.
* **Hybrid Action Cable**: Using **Redis** for high-speed local development and **Solid Cable** for robust, database-backed production messaging.
* **Solid Suite**: Using Solid Cache and Solid Queue for modern, database-backed infrastructure management.
* **Propshaft**: A modern, lightweight asset pipeline.
* **Import Maps**: JavaScript management without Node.js or bundling steps.
* **SQLite3**: Leveraged as a production-grade database with modern optimizations.

## Core Implementations

### Inline Content Portals

The application uses Turbo Frames to manage state transitions. By scoping individual tweets within unique frame IDs using `dom_id`, the application can swap tweet content for edit forms surgically. This pattern ensures that only the relevant piece of the DOM is updated during navigation, preserving the rest of the application state.

### Nested RESTful Architecture

Routing is designed around nested resources to ensure logical data relationships:

* Tweets serve as the primary resource.
* Likes and Retweets are nested under Tweets, ensuring all POST requests carry the necessary parent IDs (`params[:tweet_id]`) through the URL structure.

### Asynchronous Updates

With the inclusion of Turbo Streams and Action Cable, the application supports real-time updates. This allows content (like new tweets or updated like counts) to be pushed to the browser automatically when changes occur on the server.

## Installation

### Prerequisites

* Ruby 3.3+
* SQLite3
* Redis (for development Action Cable)

### Setup

1. Clone the repository:
```bash
git clone https://github.com/HadiAlhamed/ruby-rubyonrails-tweeter-hotwire-turboframe-websockets-realtime
cd tweeter

```


2. Install dependencies:
```bash
bundle install

```


3. Prepare the database:
```bash
bin/rails db:prepare

```


4. Launch the development environment:
```bash
bin/dev

```



## Development Features

* **Surgical DOM Replacement**: Using `turbo_stream.replace` and `turbo_stream.update` for precise UI changes.
* **Modern Debugging**: Integrated with the Ruby `debug` gem and `web-console`.

---
