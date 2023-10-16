import { schema, CustomMessages } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'

export default class StoreValidator {
  constructor(protected ctx: HttpContextContract) {}

  public schema = schema.create({
    brand: schema.string({ trim: true }),
    model: schema.string({ trim: true }),
    photo: schema.file({
      size: '2mb',
      extnames: ['jpg', 'jpeg', 'png']
    }),
    value: schema.number()
  })

  public messages: CustomMessages = {
    'file.size': 'The file size must be under {{ options.size }}',
    'file.extname': 'The file must have one of {{ options.extnames }} extension names'
  }
}
