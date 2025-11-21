const UserService = require("../../services/user");
const service = new UserService();

class UserController {
  createUser = async (req, res, next) => {
    try {
      const { email, password, role } = req.body;
      const data = await service.create_user({ email, password, role });
      return res
        .status(201)
        .json({ message: "User Created successfully", data });
    } catch (error) {
      console.log(error.message);
      next(error);
    }
  };

  login_user = async (req, res, next) => {
    try {
      const { email, password, role, fcm_token } = req.body;
      const data = await service.login_details({
        email,
        password,
        role,
        fcm_token,
      });
      return res.status(200).json({ message: "Login Successful", data });
    } catch (error) {
      console.log(error.message);
      next(error);
    }
  };
}

module.exports = UserController;
