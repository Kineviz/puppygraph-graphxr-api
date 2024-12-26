from fastapi import APIRouter
from .puppygraph import router as puppygraph_router

api_router = APIRouter()
api_router.include_router(puppygraph_router, prefix="/puppygraph", tags=["puppygraph"])