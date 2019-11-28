const OSS = require('ali-oss')
const fs = require('fs')
const path = require('path')
const os = require('os')

const client = new OSS({
  region: 'oss-cn-shanghai',
  accessKeyId: process.env.ALI_OSS_ID,
  accessKeySecret: process.env.ALI_OSS_KEY,
  bucket: 'demo-xnng'
})

const config = {
  localBasePath: '../dist',
  cloudBasePath: '/vue-admin'
}

const initLocalPath = path.resolve(__dirname, config.localBasePath)

async function uploadFileToAliOSS (currentPath = initLocalPath) {
  let currentDir = fs.readdirSync(currentPath)

  for (let i = 0; i < currentDir.length; i++) {
    let fsStatus = fs.statSync(path.join(currentPath, currentDir[i]))

    if (fsStatus.isDirectory()) {
      let nextPath = path.join(currentPath, currentDir[i])

      await uploadFileToAliOSS(nextPath)
    } else {
      let relativePath = path.relative(initLocalPath, currentPath)
      let cloudPath = path.join(
        config.cloudBasePath,
        relativePath,
        currentDir[i]
      )
      let localPath = path.join(currentPath, currentDir[i])

      await uploadFile(
        transtormPathToLinuxStyle(cloudPath),
        transtormPathToLinuxStyle(localPath)
      )
    }
  }
}

async function uploadFile (cloudPath, localPath) {
  let fileStream = fs.createReadStream(localPath)

  try {
    let result = await client.putStream(cloudPath, fileStream)
    console.log(`upload success: ${result.res.requestUrls[0]}`)
  } catch (error) {
    console.log(`upload fail：${error}`)
  }
}

function transtormPathToLinuxStyle (path) {
  if (os.platform() === 'win32') {
    return path.split('\\').join('/')
  } else {
    return path
  }
}

uploadFileToAliOSS()
