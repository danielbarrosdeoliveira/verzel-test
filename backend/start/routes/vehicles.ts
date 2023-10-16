import Route from '@ioc:Adonis/Core/Route'

Route.get('/vehicles', 'Vehicles/Main.index')
Route.get('/vehicles/:id', 'Vehicles/Main.show')
Route.post('/vehicles', 'Vehicles/Main.store').middleware('auth')
Route.put('/vehicles/:id', 'Vehicles/Main.update').middleware('auth')
Route.delete('/vehicles/:id', 'Vehicles/Main.destroy').middleware('auth')
