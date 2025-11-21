const { prisma } = require("../../../../configs/prisma");
const Helper = require("../helper");
const helper = new Helper();

class UserService {
  create_user = async ({ email, password, role }) => {
    const create_user_detail = await prisma.user.create({
      data: { email, password, role },
    });
    return create_user_detail;
  };

  login_details = async ({ email, password, role, fcm_token }) => {
    const exist_user = await prisma.user.findFirst({
      where: { email, role },
    });

    if (!exist_user) {
      throw new Error("Unauthorized User");

      // const err = new Error("Unauthorized User");
      // err.statusCode = 401; // HTTP status
      // throw err;
    }
    if (exist_user.password !== password) {
      throw new Error("Ivalid Email or Password");
      // const err = new Error("Invalid Username or Password");
      // err.statusCode = 401;
      // throw err;
    }

    const { access_token, refresh_token } = await helper.create_session({
      user: exist_user,
      fcm_token,
    });

    return { exist_user, access_token, refresh_token };
  };
}

module.exports = UserService;
