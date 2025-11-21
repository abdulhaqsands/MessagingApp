const { Server } = require("socket.io");
const chatHandler = require("./chat/chat.handler");

let io;
const initSocket = (server) => {
  if (io) return io;
  io = new Server(server, {
    cors: "*",
    methods: ["GET", "POST"],
  });

  io.on("connection", (socket) => {
    console.log("User Connected to ", socket.user.id);

    socket.join(socket.user.id);
    chatHandler(io, socket);

    socket.on("disconnect", () => {
      console.log("User Disconnected: ", socket.user.id);
    });
  });
};
module.exports = initSocket;
