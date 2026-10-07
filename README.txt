ToletKoi Full Package v2
Generated: 2025-08-30T11:32:32.207408

Contents:
- database/toletkoi_schema_with_mock.sql  -- full schema + mock seed data
- backend/  -- Node/Express backend skeleton
- backend/postman/  -- Postman collection for API testing

Quick start (local):
1) Import SQL (creates db & tables + seed data):
   mysql -u root -p < database/toletkoi_schema_with_mock.sql
2) Edit backend/config/.env to set DB credentials.
3) Install dependencies and run server:
   cd backend
   npm install
   npm start
4) Test health: GET http://localhost:3000/
5) Use Postman collection in backend/postman/toletkoi_postman_collection_v2.json

Notes:
- Passwords in seed data are plain text for demo. Replace with hashed passwords in production.
- AI recommender is a simple score-based module using views & favorites. Replace with more advanced ML if required.
- File uploads (images) are represented as path strings in seed data; implement multipart uploads when building frontend.
