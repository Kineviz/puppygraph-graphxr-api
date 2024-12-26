# PuppyGraph API

A FastAPI-based REST API service for interacting with PuppyGraph Database.

## Features

- Graph database schema retrieval
- Query execution with support for nodes, edges, and paths
- Sample queries management

## Prerequisites

- Python 3.11+
- Docker and Docker Compose (for containerized deployment)
- PuppyGraph Database instance

## Setting Up PuppyGraph Database

PuppyGraph provides a graph database solution with supply chain sample data.

### Prerequisites
- Docker and Docker Compose
- PostgreSQL client (for data loading)

### Installation Steps

1. Download the supply chain [dataset](https://raw.githubusercontent.com/izhanghongbo/puppygraph-graphxr-api/refs/heads/main/data/puppygraph.tar) package containing:
   ```
   |____docker-compose.yaml
   |____csv_data/
   |____postgres-schema.sql
   |____schema.json
   ```

2. Start PuppyGraph services:
   ```bash
   docker compose -f docker-compose.yaml up -d
   ```

3. Load sample data into PostgreSQL:
   ```bash
   docker exec -it postgres psql -h postgres -U postgres
   # Password: postgres123
   
   # At the psql prompt:
   \i /tmp/postgres-schema.sql
   ```

4. Configure PuppyGraph:
   - Visit http://localhost:8081/#/login
   - Login credentials:
     - Username: puppygraph
     - Password: puppyheap3
   - Upload the provided `schema.json` to configure the graph schema

## Installing the API Service

### Using Docker (Recommended)

1. Clone the repository
2. Find the docker-compose.yml file and edit the environment variables:
   ```yaml
   PUPPYGRAPH_USERNAME=puppygraph
   PUPPYGRAPH_PASSWORD=puppyheap3
   ```
3. Start the service using Docker Compose:
   ```bash
   docker-compose up -d
   ```

### Manual Installation

1. Create a virtual environment:
   ```bash
   python3 -m venv venv
   source venv/bin/activate  # Linux/Mac
   # or
   .\venv\Scripts\activate  # Windows
   ```

2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

3. Copy and configure environment variables:
   ```bash
   cp env-example .env
   ```

4. Start the service:
   ```bash
   uvicorn main:app --host 0.0.0.0 --port 8000 --reload
   ```

### 3. Using PuppyGraph

PuppyGraph provides an alternative graph database solution with supply chain sample data.

#### Prerequisites
- Docker and Docker Compose
- PostgreSQL client (for data loading)

#### Installation Steps

1. Download the supply chain dataset package containing:
   ```
   |____docker-compose.yaml
   |____csv_data/
   |____postgres-schema.sql
   |____schema.json
   ```

2. Start PuppyGraph services:
   ```bash
   docker compose -f docker-compose.yaml up -d
   ```

3. Load sample data into PostgreSQL:
   ```bash
   docker exec -it postgres psql -h postgres -U postgres
   # Password: postgres123
   
   # At the psql prompt:
   \i /tmp/postgres-schema.sql
   ```

4. Configure PuppyGraph:
   - Visit http://localhost:8081/#/login
   - Login credentials:
     - Username: puppygraph
     - Password: puppyheap3
   - Upload the provided `schema.json` to configure the graph schema

#### Visualization Options

1. **Using Grove** (as described in previous sections)

2. **Using GraphXR with PuppyGraph**
   - Visit https://alt.graphxr.kinevizlabs.com/
   - Connect using the PuppyGraph database credentials
   - Password: spaceheap3

The supply chain dataset demonstrates various relationships between customers, products, materials, and locations. For more information about this dataset and PuppyGraph, visit [PuppyGraph Introduction](https://gdotv.com/2024/07/10/puppygraph-introduction/).

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| PUPPYGRAPH_HOST | PuppyGraph database host | localhost:8182 |
| PUPPYGRAPH_USERNAME | Database username | puppygraph |
| PUPPYGRAPH_PASSWORD | Database password | puppyheap3 |
| SAMPLES_PATH | Path to samples configuration file | samples.yaml |

## API Endpoints

### Graph Operations

- `GET /api/v1/puppygraph/schema` - Retrieve graph schema
- `POST /api/v1/puppygraph/execute` - Execute graph queries
- `GET /api/v1/puppygraph/samples` - Get sample queries
- `GET /api/v1/puppygraph/graphs` - List available graphs

## Use Grove to interact with the API

After starting the service, you can use Grove to visualize and interact with your graph data:

### use a shared project:

1. Open the Grove interface at [GraphXR Grove](https://graphxr.kineviz.com/share/676d07a2a104b4a52eaa0cee/PuppyGraph-Grove?userID=5c020fe520f1ed00216552c3&groveProjectId=676d07a2a104b4a52eaa0cee&groveFileKey=puppy-graph&groveVersion=0&groveFullscreen=true&groveReadonly=true&groveBlockMode=hide)

2. In the server input field at the top, enter your API server URL:
   - For local development: `http://localhost:8000`
   - For remote server: Enter your server's URL

3. Select a graph from the dropdown menu

4. You can now:
   - View and select node categories
   - Explore relationships
   - Execute custom queries
   - Visualize query results in an interactive graph

The Grove interface provides an intuitive way to explore your graph data through a visual interface while using the API endpoints described above.

### use your own project:

1. create a new project https://graphxr.kineviz.com/  with a grove template
![Create Project](https://raw.githubusercontent.com/izhanghongbo/puppygraph-graphxr-api/refs/heads/main/images/project-new.jpg)

2. download the grove file [puppy-graph.grove](https://raw.githubusercontent.com/izhanghongbo/ultipa-graphxr-api/main/puppy-graph.grove)
3. open the grove tab and drag the code into the panel,you will see the grove's ui in the panel
![Grove](https://raw.githubusercontent.com/izhanghongbo/ultipa-graphxr-api/main/images/grove.jpg)

