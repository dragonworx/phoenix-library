const aws = require('aws-sdk');
const sharp = require('sharp');
const env = require('./environment');
const log = require('./log');
const Rect = require('./rect');

const IMAGE = {
  FULL: 'full',
  PREVIEW: 'preview',
  THUMB: 'thumb',
};
const {
  STORAGE_ENDPOINT,
  STORAGE_URL,
  STORAGE_KEY,
  STORAGE_SECRET,
  PHOENIX_ENV,
} = env(['STORAGE_ENDPOINT', 'STORAGE_KEY', 'STORAGE_SECRET', 'PHOENIX_ENV']);

const storage = new aws.S3({
  accessKeyId: STORAGE_KEY,
  secretAccessKey: STORAGE_SECRET,
  endpoint: new aws.Endpoint(STORAGE_ENDPOINT)
});

module.exports = {
  imageUrl(exerciseId, type, index = 1) {
    return `${STORAGE_URL}${this.imageKey(exerciseId, type, index)}`;
  },
  imageKey(exerciseId, type, index = 1) {
    return `phoenix_lib/${PHOENIX_ENV}/excelsior/${exerciseId}_${index}_${type}.png`;
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
        ACL: 'public-read',
        CacheControl: 'max-age=86400',
      };
      storage.putObject(params, (err, data) => {
        if (err) {
          reject(err);
        } else {
          resolve(data);
        }
      });
    });
  },
  async uploadImage(exerciseId, index, type, buffer, resizeOptions = {}) {
    log(`Uploading #${exerciseId}/${index} type: ${type} ${buffer.length} bytes (options: ${JSON.stringify(resizeOptions)})`);
    const image = sharp(buffer);
    const metadata = await image.metadata();
    const { width, height, minWidth, minHeight, maxWidth, maxHeight } = resizeOptions;
    const { width: imgWidth, height: imgHeight } = metadata;
    const rect = new Rect(imgWidth, imgHeight);
    rect.ensureWidth(width);
    rect.ensureHeight(height);
    rect.ensureMaxWidth(maxWidth);
    rect.ensureMaxHeight(maxHeight);
    rect.ensureMinWidth(minWidth);
    rect.ensureMinHeight(minHeight);
    const pngBuffer = await image.resize(rect.width, rect.height).png().toBuffer();
    const imageKey = this.imageKey(exerciseId, type, index);
    await this.upload(pngBuffer, imageKey);
    return imageKey;
  },
  deleteImages(exerciseId) {
    return new Promise((resolve, reject) => {
      const params = {
        Bucket: 'masstorage',
        Delete: {
          Objects: [
            { Key: this.imageKey(exerciseId, IMAGE.FULL) },
            { Key: this.imageKey(exerciseId, IMAGE.PREVIEW) },
            { Key: this.imageKey(exerciseId, IMAGE.THUMB) },
          ],
          Quiet: false
        }
      };
      storage.deleteObjects(params, (err, data) => {
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
