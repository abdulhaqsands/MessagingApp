const { prisma } = require("./src/configs/prisma");

(async () => {
  try {
    await prisma.$connect();
    console.log("Database connected successfully!");
  } catch (err) {
    console.error("Database connection failed:", err);
  } finally {
    await prisma.$disconnect();
  }
})();
