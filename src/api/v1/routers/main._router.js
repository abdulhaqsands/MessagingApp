const router = require("express").Router();
const globalErrorHandling = require("../middlewares/globalErrorHandling");
const user_router = require("./user");

router.use("/user", user_router);

router.get("/", (_, res) => {
  try {
    res.send("server working of v1 router -- Free Throw");
  } catch (error) {
    res.send(error.message);
  }
});
router.use(globalErrorHandling);

module.exports = router;
