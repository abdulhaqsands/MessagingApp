const { prisma } = require("../../../configs/prisma");
const TokenService = require("./token");

const secretKey = process.env.secretKey;
const tokenService = new TokenService(secretKey);

class Helper {
  create_session = async ({ user, fcm_token }) => {
    const access_token = tokenService.generate_access_token(user.id, user.role);
    const refresh_token = tokenService.generate_refresh_token(
      user.id,
      user.role
    );

    const sessionData = { refresh_token, user_id: user.id };
    if (fcm_token) sessionData.fcm_token = fcm_token;

    await prisma.user_Session.create({ data: sessionData });

    return { access_token, refresh_token };
  };
}

module.exports = Helper;
