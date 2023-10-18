import { schema } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'

export default class StoreValidator {
  constructor(protected ctx: HttpContextContract) {}

  public schema = schema.create({
    brand: schema.string({ trim: true }),
    model: schema.string({ trim: true }),
    photo: schema.string({ trim: true }),
    value: schema.number()
  })
}
