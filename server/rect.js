module.exports = class Rect {
  constructor (width, height) {
    this._width = width;
    this._height = height;
  }

  get width () { return this._width; }
  get height () { return this._height; }

  set width (value) {
    const ratio = value / this.width;
    this._width = value;
    this._height = Math.round(this._height * ratio);
  }

  set height (value) {
    const ratio = value / this.height;
    this._height = value;
    this._width = Math.round(this._width * ratio);
  }

  ensureWidth (value) {
    if (typeof value === 'number') {
      this.width = value;
    }
  }

  ensureHeight (value) {
    if (typeof value === 'number') {
      this.height = value;
    }
  }

  ensureMaxWidth (value) {
    if (typeof value === 'number') {
      if (this.width > value) {
        this.width = value;
      }
    }
  }

  ensureMaxHeight (value) {
    if (typeof value === 'number') {
      if (this.height > value) {
        this.height = value;
      }
    }
  }

  ensureMinWidth (value) {
    if (typeof value === 'number') {
      if (this.width < value) {
        this.width = value;
      }
    }
  }

  ensureMinHeight (value) {
    if (typeof value === 'number') {
      if (this.height < value) {
        this.height = value;
      }
    }
  }
}