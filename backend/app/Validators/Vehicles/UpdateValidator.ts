import { schema } from '@ioc:Adonis/Core/Validator'

export default class UpdateValidator {
  public schema = schema.create({
    brand: schema.string.optional({
      trim: true
    }),
    model: schema.string.optional({
      trim: true
    }),
    photo: schema.string.optional({
      trim: true
    }),
    value: schema.number.optional()
  })
}
