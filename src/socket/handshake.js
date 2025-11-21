require("dotenv").config();
const TokenService = require("../api/v1/services/token");
const { prisma } = require("../configs/prisma");
const tokenService = new TokenService(process.env.secretKey);

const socketAuth = async (socket, next) => {
  try {
    const token =
      socket.handshake.auth?.token ||
      socket.handshake.headers?.authorization?.replace("Bearer ", "");
    if (!token) {
      throw next(new Error("No Token Provided"));
    }
    const decode = tokenService.verify_access_token(token);
    if (!decode) {
      throw next(new Error("Invalid Token"));
    }
    const user = await prisma.user.findUnique({
      where: {
        id: decode.id,
      },
    });
    if (!user) {
      throw next(new Error("User not found:"));
    }
    socket.user = user;
    next();
  } catch (error) {
    console.log("Error:", error);
    next(error);
  }
};
module.exports = socketAuth;
