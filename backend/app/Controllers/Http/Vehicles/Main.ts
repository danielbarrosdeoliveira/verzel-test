import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'

import { StoreValidator, UpdateValidator } from 'App/Validators/Vehicles'
import Vehicle from 'App/Models/Vehicle'

export default class MainsController {
  public async index({ response }: HttpContextContract) {
    const vehicles = await Vehicle.query().orderBy('value', 'asc')

    if (vehicles.length > 0) {
      return response.ok(vehicles)
    }

    return response.notFound({
      msg: 'Nenhum veículo cadastrado.'
    })
  }

  public async store({ request }: HttpContextContract) {
    const { brand, model, photo, value } = await request.validate(StoreValidator)

    const vehicle = await Vehicle.create({
      brand,
      model,
      photo,
      value
    })

    return vehicle
  }

  public async update({ request }: HttpContextContract) {
    const { id } = request.params()

    const vehicle = await Vehicle.findOrFail(id)

    const { brand, model, photo, value } = await request.validate(UpdateValidator)

    const updates: Partial<typeof vehicle> = {}

    if (brand) {
      updates.brand = brand
    }

    if (model) {
      updates.model = model
    }

    if (photo) {
      updates.photo = photo
    }

    if (value) {
      updates.value = value
    }

    vehicle.merge(updates)
    await vehicle.save()

    return vehicle
  }

  public async destroy({ request, response }: HttpContextContract) {
    const { id } = request.params()

    const vehicle = await Vehicle.findBy('id', id)

    if (!vehicle) {
      return response.notFound()
    }

    return response.finish()
  }
}
