const aws = require('aws-sdk');
const sharp = require('sharp');
const env = require('./environment');
const log = require('./log');

const IMAGE = {
  FULL: 'full',
  THUMB: 'thumb',
};
const MASSTORAGE_BASE_URL = 'https://masstorage.sgp1.digitaloceanspaces.com/';
const { MASSTORAGE_KEY_ID, MASSTORAGE_SECRET } = env([ 'MASSTORAGE_KEY_ID', 'MASSTORAGE_SECRET' ]);

const s3 = new aws.S3({
  accessKeyId: MASSTORAGE_KEY_ID,
  secretAccessKey: MASSTORAGE_SECRET,
  endpoint: new aws.Endpoint("sgp1.digitaloceanspaces.com")
});

module.exports = {
  imageUrl (exerciseId, type) {
    return `${MASSTORAGE_BASE_URL}phoenix_lib/excelsior/${exerciseId}_${type}.png`;
  },
  imageKey (exerciseId, type) {
    return `phoenix_lib/excelsior/${exerciseId}_${type}.png`;
  },
  upload(buffer, key) {
    if (!key) {
      throw new Error('Key required to upload file');
    }
    return new Promise((resolve, reject) => {
      const params = {
        Bucket: 'masstorage',
        Key: key,
        Body: buffer,
        ACL: 'public-read'
      };
      s3.putObject(params, (err, data) => {
        if (err) {
          reject(err);
        } else {
          resolve(data);
        }
      });
    });
  },
  uploadImage(exerciseId, type, buffer, width, height) {
    log(`Uploading #${exerciseId} type: ${type} ${buffer.length} bytes`);
    const image = sharp(buffer);
    return image
      .metadata()
      .then(metadata => {
        return image
          .resize(width || metadata.width, height || metadata.height)
          .png()
          .toBuffer()
          .then(pngBuffer => this.upload(pngBuffer, this.imageKey(exerciseId, type)));
      });
  },
  deleteImages (exerciseId) {
    return new Promise((resolve, reject) => {
      const params = {
        Bucket: 'masstorage', 
        Delete: {
         Objects: [
            { Key: this.imageKey(exerciseId, IMAGE.FULL) }, 
            { Key: this.imageKey(exerciseId, IMAGE.THUMB) }, 
         ], 
         Quiet: false
        }
       };
       s3.deleteObjects(params, (err, data) => {
         if (err) {
           reject(err);
         } else {
           log('delete: ' + JSON.stringify(data), 'green');
           resolve(data);
         }
       });
    });
  }
};
