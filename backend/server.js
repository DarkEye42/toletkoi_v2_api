
const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const helmet = require("helmet");
const http = require('http');
const { Server } = require('socket.io');
const env = require('./config/envConfig');
const app = express();
const server = http.createServer(app);
const io = new Server(server, { cors: { origin: '*' } });

app.use(helmet());
app.use(cors());
app.use(bodyParser.json());

// app.get("/", (req,res)=> res.json({ok:true, msg:"ToletKoi API"}));

// Landing page and admin message update
//app.use("/", require("./routes/landingRoutes"));

// Serve static UI files from /public
const path = require('path');
app.use(express.static(path.join(__dirname, 'public')));

// Landing page API
app.use("/api/v1/landing", require("./routes/landingRoutes"));

const apiVersion = "api/v1";

// API routes
app.use(`/${apiVersion}/auth`, require("./routes/authRoutes"));
app.use(`/${apiVersion}/users`, require("./routes/userRoutes"));
app.use(`/${apiVersion}/ads`, require("./routes/adsRoutes"));
app.use(`/${apiVersion}/products`, require("./routes/productRoutes"));
app.use(`/${apiVersion}/blogs`, require("./routes/blogRoutes"));
app.use(`/${apiVersion}/recommendations`, require("./routes/recommendRoutes"));
app.use(`/${apiVersion}/search`, require("./routes/searchRoutes"));
app.use(`/${apiVersion}/payments`, require("./routes/paymentRoutes"));
app.use(`/${apiVersion}/roles`, require("./routes/roleRoutes"));
app.use(`/${apiVersion}/postman_api`, require("./routes/postmanApiRoutes"));

// Socket.io notifications
io.on('connection', (socket) => {
	console.log('Socket connected:', socket.id);
	socket.on('notify', (data) => {
		// Example: send notification to user
		if (data.userId) io.to(data.userId).emit('notification', data);
	});
	socket.on('join', (userId) => {
		socket.join(userId);
	});
});
app.set('io', io);

// Error handler
const errorHandler = require('./middleware/errorHandler');
app.use(errorHandler);

const PORT = env.PORT || 3000;
server.listen(PORT, ()=> console.log("Server listening on", PORT));
