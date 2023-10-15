import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import { StoreValidator } from 'App/Validators/Auth'

export default class AuthController {
  public async store({ request, auth }: HttpContextContract) {
    const { username, password } = await request.validate(StoreValidator)

    const token = await auth.attempt(username, password, {
      expiresIn: '7 days'
    })

    return token
  }

  public async destroy({ auth }: HttpContextContract) {
    await auth.logout()
  }
}
