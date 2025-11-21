module.exports = (err, req, res, next) => {
  console.log("Global Error:", err.message);
  const statusCode = err.statusCode || 500;
  res.status(statusCode).json({
    status: "error",
    message: err.message || "Internal Server Error",
  });
};
