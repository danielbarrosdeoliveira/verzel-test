import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Application from '@ioc:Adonis/Core/Application'

import { StoreValidator } from 'App/Validators/Vehicles'
import Vehicle from 'App/Models/Vehicle'

export default class MainsController {
  public async index({ response }: HttpContextContract) {
    const vehicles = await Vehicle.query().orderBy('value', 'asc')

    if (vehicles.length > 0) {
      return response.ok(vehicles)
    }

    return response.notFound()
  }

  public async store({ request }: HttpContextContract) {
    const { brand, model, photo, value } = await request.validate(StoreValidator)

    const vehicle = await Vehicle.create({
      brand,
      model,
      photo: `${new Date().getTime()}.${photo.extname}`,
      value
    })

    await photo.move(Application.makePath('public/uploads'), {
      name: vehicle.photo
    })

    return vehicle
  }
}
