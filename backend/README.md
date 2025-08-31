# ToletKoi Backend

## Tech Stack
- Node.js (Express.js)
- MySQL
- Redis (Bull queue)
- JWT Auth
- Multer + Sharp (uploads)
- Nodemailer + PHP fallback
- Socket.io (notifications)
- Stripe, SSLCOMMERZ (payments)
- PM2, Nginx (deployment)

## Setup
```sh
git clone <repo>
cd backend
npm install
cp .env.example .env
# Edit .env for DB, Redis, email, payment
npm run dev # or pm2 start ecosystem.config.js
```

## Main Scripts
- `server.js` — Main API
- `worker.js` — Email queue worker

## API
- Auth: `/api/auth/register`, `/api/auth/login`
- Users: `/api/users/...`
- Roles: `/api/roles/...`
- Ads: `/api/ads/...`
- Products: `/api/products/...`
- Blogs: `/api/blogs/...`
- Payments: `/api/payments/...`
- Search: `/api/search?q=...`

## Email Queue
- Uses Bull (Redis)
- Fallback to PHP mailer if nodemailer fails

## Payments
- Stripe & SSLCOMMERZ supported

## Deployment
- Use PM2 + Nginx (see `ecosystem.config.js`, `nginx.sample.conf`)

## Testing
- All endpoints documented in Postman collection

---
See full technical documentation for details.
