import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Application from '@ioc:Adonis/Core/Application'
import Drive from '@ioc:Adonis/Core/Drive'

import { StoreValidator, UpdateValidator } from 'App/Validators/Vehicles'
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

  public async show({ response, request }: HttpContextContract) {
    const { id } = request.params()

    const vehicle = await Vehicle.findBy('id', id)

    if (!vehicle) {
      return response.notFound()
    }

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

    if (value) {
      updates.value = value
    }

    if (photo) {
      const vehiclePhoto = `${new Date().getTime()}.${photo.extname}`
      await photo.move(Application.makePath('public/uploads'), {
        name: vehiclePhoto
      })
      updates.photo = vehiclePhoto
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

    const vehiclePhoto = vehicle.$attributes.photo
    const vehiclePhotoExists = await Drive.exists(`/uploads/${vehiclePhoto}`)

    if (vehiclePhotoExists) {
      await Drive.delete(`/uploads/${vehiclePhoto}`)
    }

    if (vehiclePhotoExists) {
      await vehicle.delete()
    }

    return response.finish()
  }
}
