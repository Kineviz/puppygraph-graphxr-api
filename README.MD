# GraphXR PuppyGraph Connector
A FastAPI-based service that enables GraphXR to connect and visualize graph data stored in PuppyGraph Database. This API service acts as a bridge between GraphXR and PuppyGraph, allowing interactive graph data exploration and visualization.

## Prerequisites

- Python 3.11+
- Docker and Docker Compose
- PuppyGraph Database instance

## Installation Guide

### Setting up PuppyGraph Database, puppygraph-graphxr-service, and GraphXR Application

1. Clone the repository

2. Start PuppyGraph and PostgreSQL using Docker Compose:
   ```bash
   docker compose -f docker-compose-all.yml up -d
   ```
   This command starts PuppyGraph, PostgreSQL service, and the GraphXR Application.
   It also loads the supply-chain dataset into PostgreSQL and configures the PuppyGraph instance to build a graph on top of the data.

   Note: To use your own dataset, modify the `docker-compose-all.yml` file accordingly.

For more details about the supply-chain dataset, visit: https://gdotv.com/2024/07/10/puppygraph-introduction/

### GraphXR Setup

1. Login to GraphXR Application
   - Navigate to http://localhost:9000
   - Enter the following credentials:
     ```
     Username: graphxr@kineviz.com
     Password: puppyheap3
     ```
   ![try graphxr](https://raw.githubusercontent.com/Kineviz/puppygraph-graphxr-api/refs/heads/main/images/try_graphxr.jpg)

2. Install Grove Plugin
   - Visit http://localhost:9000/admin
   - Select the Extensions tab
   - Click "Pull The Extension From GraphXR Manager Server"
   - Select the Grove plugin
   - Click the Install button
   ![install grove plugin](https://raw.githubusercontent.com/Kineviz/puppygraph-graphxr-api/refs/heads/main/images/install_grove_plugin.jpg)

3. Create a New Project
   - Return to the home page (http://localhost:9000)
   - Click the "+" button
   - Enter a project name
   - Ensure "Keep Neo4j Instance" is unchecked
   - Click the "Confirm" button
   ![create project](https://raw.githubusercontent.com/Kineviz/puppygraph-graphxr-api/refs/heads/main/images/project_new.jpg)

4. Configure Grove Extension
   - Open "Project" → "Extensions"
   - Select the installed Grove extension
   - Drag the [puppy-graph.grove](https://raw.githubusercontent.com/Kineviz/puppygraph-graphxr-api/main/puppy-graph.grove) file into the panel
   ![Grove](https://raw.githubusercontent.com/Kineviz/puppygraph-graphxr-api/main/images/grove_plugin_panel.jpg)

5. Final Interface
   ![Grove](https://raw.githubusercontent.com/Kineviz/puppygraph-graphxr-api/main/images/grove.jpg)
