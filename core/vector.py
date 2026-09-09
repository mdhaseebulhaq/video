from langchain_ollama import OllamaEmbeddings
from langchain_chroma import Chroma
import os

EMBEDDING_MODEL='nomic-embed-text'

VECTOR_DB_DIR='data/vectorstore'

def create_emd_vet(reg_chunk :list):
    print ('creating embeddings....')
    embeddings =OllamaEmbeddings(model =EMBEDDING_MODEL)
    vector_store = Chroma.from_documents(
        documents = reg_chunk,
        embedding = embeddings,
        persist_directory=VECTOR_DB_DIR
        
    )
    print("documents stored in chromDB")
    return vector_store
    
    
    