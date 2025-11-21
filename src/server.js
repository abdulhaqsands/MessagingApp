const express = require("express");

const http = require("http");

require("dotenv").config();
const PORT = process.env.PORT;
const v1_route = require("../src/api/v1/routers/main._router");
const initSocket = require("./socket");
const globalErrorHandler = require("../src/api/v1/middlewares/globalErrorHandling");

const app = express();
app.use(express.json());

app.use("/api/v1", v1_route);
// app.use(globalErrorHandler);

const server = http.createServer(app);
initSocket(server);

server.listen(PORT, () => {
  console.log("Server is runnign on ", PORT);
});
