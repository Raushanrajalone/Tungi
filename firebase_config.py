import firebase_admin
from firebase_admin import credentials, firestore

def initialize_firebase():
    cred = credentials.Certificate("serviceAccountKey.json")
    firebase_app = firebase_admin.initialize_app(cred)
    return firestore.client()

# Initialize Firestore DB
db = initialize_firebase()

def get_firestore():
    return db