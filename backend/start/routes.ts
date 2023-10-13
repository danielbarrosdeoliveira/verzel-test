import type { HttpContextContract } from "@ioc:Adonis/Core/HttpContext";

import Route from "@ioc:Adonis/Core/Route";
import User from "App/Models/User";

Route.get("/", async () => {
  return "Hello World";
});

Route.post(
  "/get-token",
  async ({ request, response, auth }: HttpContextContract) => {
    const username = request.input("username");
    const password = request.input("password");

    await User.findBy("username", username);

    const token = await auth.use("api").attempt(username, password);

    return response.ok(token);
  }
);

Route.get("/auth", async ({ auth, response }: HttpContextContract) => {
  const userAuth = await auth.use("api").authenticate();

  if (userAuth) {
    return response.ok(userAuth);
  }
});
