const router = require("express").Router();
const UserController = require("../../controllers/user");
const controller = new UserController();

router.post("/create", controller.createUser);
router.post("/login", controller.login_user);

module.exports = router;
