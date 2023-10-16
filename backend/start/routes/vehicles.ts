import Route from '@ioc:Adonis/Core/Route'

Route.get('/vehicles', 'Vehicles/Main.index')
Route.get('/vehicles/:id', 'Vehicles/Main.show')
Route.post('/vehicles', 'Vehicles/Main.store').middleware('auth')
