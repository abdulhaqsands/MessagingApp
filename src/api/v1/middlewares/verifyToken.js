require("dotenv").config(); // <--- this loads the .env file

const { prisma } = require("../../configs/prisma");
const TokenService = require("../services/token");

const secretKey = process.env.secretKey; // must match key in .env
if (!secretKey) {
  throw new Error("secretKey environment variable is missing");
}
const token = new TokenService(secretKey);

const verify_token = async (req, res, next) => {
  const access_token = req.headers.authorization;
  if (!access_token)
    return res.status(404).json({ message: "Unauthorized User" });

  const payload = token.verify_access_token(access_token);
  if (!payload)
    return res.status(401).json({ message: "Access token Expired" });

  const user = await prisma.user.findFirst({
    where: { id: payload.id, role: payload.role },
  });

  if (!user) return res.status(400).json({ message: "User not found" });

  req.user = { user };
  next();
};

module.exports = verify_token;
