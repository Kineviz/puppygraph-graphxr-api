from fastapi import APIRouter, HTTPException, Request
from typing import List
from pydantic import BaseModel
import os
from neo4j import GraphDatabase
import yaml
from neo4j.time import DateTime, Date, Time
from dotenv import load_dotenv

class ExecuteRequest(BaseModel):
    command: str
    graphName: str | None = None

# Load environment variables
load_dotenv()

router = APIRouter()

# Initialize Neo4j connection
uri = os.getenv('NEO4J_URI', 'bolt://puppygraph:7687')
username = os.getenv('NEO4J_USER', 'puppygraph')
password = os.getenv('NEO4J_PASSWORD', 'puppygraph123')

# Create connection
driver = GraphDatabase.driver(uri, auth=(username, password))

def _process_value(value):
    if isinstance(value, DateTime):
        return value.iso_format()
    elif isinstance(value, Date):
        return value.iso_format()
    elif isinstance(value, Time):
        return value.iso_format()
    elif isinstance(value, (list, tuple)):
        return [_process_value(item) for item in value]
    elif isinstance(value, dict):
        return {key: _process_value(val) for key, val in value.items()}
    else:
        return value

@router.get("/schema")
async def get_schema(request: Request):
    try:
        with driver.session() as session:
            node_labels = session.run("CALL db.labels()").data()
            rel_types = session.run("CALL db.relationshipTypes()").data()
            
            nodes = [label['label'] for label in node_labels]
            relationships = [rel['relationshipType'] for rel in rel_types]

            return {
                "categories": nodes,
                "relationships": relationships
            }
    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Error fetching schema: {str(e)}"
        )

@router.post("/execute")
async def execute(request: ExecuteRequest):
    try:
        command = request.command
        
        with driver.session() as session:
            result = session.run(command)
            graph_data = {
                "nodes": [],
                "edges": []
            }
            
            for record in result:
                for value in record.values():
                    if hasattr(value, 'labels'):
                        node = {
                            "id": value.element_id,
                            "category": list(value.labels)[0] if value.labels else "Node",
                            "properties": _process_value(dict(value._properties))
                        }
                        graph_data["nodes"].append(node)
                    elif hasattr(value, 'type'):
                        edge = {
                            "id": value.element_id,
                            "name": value.type,
                            "sourceId": value.start_node.element_id,
                            "targetId": value.end_node.element_id,
                            "properties": _process_value(dict(value._properties))
                        }
                        graph_data["edges"].append(edge)
                        
            return graph_data
            
    except Exception as e:
        print(f"Error executing query: {str(e)}")
        raise HTTPException(
            status_code=500,
            detail=f"Error executing query: {str(e)}"
        )

@router.get("/samples")
async def get_samples():
    try:
        config_path = os.getenv('SAMPLES_PATH', 'samples.yaml')
        with open(config_path, 'r') as file:
            config = yaml.safe_load(file)
            
        if not config or 'samples' not in config:
            return {"samples": []}
            
        return {"samples": config['samples']}
    except FileNotFoundError:
        raise HTTPException(
            status_code=404,
            detail="Configuration file not found"
        )
    except yaml.YAMLError:
        raise HTTPException(
            status_code=500,
            detail="Error parsing configuration file"
        )