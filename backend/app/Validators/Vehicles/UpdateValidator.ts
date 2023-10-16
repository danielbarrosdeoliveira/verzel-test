import { schema, CustomMessages } from '@ioc:Adonis/Core/Validator'

export default class UpdateValidator {
  public schema = schema.create({
    brand: schema.string.optional(),
    model: schema.string.optional(),
    value: schema.number.optional(),
    photo: schema.file.optional({
      size: '2mb',
      extnames: ['jpg', 'jpeg', 'png']
    })
  })

  public messages: CustomMessages = {
    'file.size': 'The file size must be under {{ options.size }}',
    'file.extname': 'The file must have one of {{ options.extnames }} extension names'
  }
}
