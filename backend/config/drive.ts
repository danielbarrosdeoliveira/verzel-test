import Env from '@ioc:Adonis/Core/Env'
import { driveConfig } from '@adonisjs/core/build/config'

export default driveConfig({
  disk: Env.get('DRIVE_DISK'),
  disks: {
    local: {
      driver: 'local',
      visibility: 'public',
      root: 'public',
      serveFiles: true,
      basePath: '/public'
    }
  }
})
