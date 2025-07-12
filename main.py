from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.security import HTTPBearer
from fastapi.middleware.cors import CORSMiddleware
import firebase_config
from firebase_admin import auth, firestore
from pydantic import BaseModel

# Initialize FastAPI
app = FastAPI(title="Flutter-Firebase Backend")

# CORS Setup (Allow Flutter app to connect)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # For development only
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Firebase Authentication
security = HTTPBearer()

async def verify_token(token: str = Depends(security)):
    try:
        decoded_token = auth.verify_id_token(token.credentials)
        return decoded_token
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid Firebase token",
            headers={"WWW-Authenticate": "Bearer"},
        )

# Data Models
class UserProfile(BaseModel):
    name: str
    age: int
    bio: str = None

# Routes
@app.get("/")
def home():
    return {"message": "Flutter-Firebase Backend is running!"}

@app.get("/protected")
async def protected_route(user: dict = Depends(verify_token)):
    """Example protected route that requires Firebase auth"""
    return {
        "uid": user["uid"],
        "email": user.get("email"),
        "message": "This data is protected!"
    }

@app.post("/create-profile")
async def create_profile(
    profile: UserProfile,
    user: dict = Depends(verify_token)
):
    """Save user profile to Firestore"""
    db = firebase_config.get_firestore()
    user_ref = db.collection("users").document(user["uid"])

    await user_ref.set({
        **profile.dict(),
        "email": user.get("email"),
        "created_at": firestore.SERVER_TIMESTAMP
    })

    return {"status": "success", "data": profile.dict()}

@app.get("/get-profile")
async def get_profile(user: dict = Depends(verify_token)):
    """Fetch user profile from Firestore"""
    db = firebase_config.get_firestore()
    doc = await db.collection("users").document(user["uid"]).get()

    if not doc.exists:
        raise HTTPException(404, detail="Profile not found")

    return doc.to_dict()