const router = require("express").Router();
const user_router = require("./user");

router.use("/user", user_router);

module.exports = router;
