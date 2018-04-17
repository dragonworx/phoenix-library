const PDFDocument = require('pdfkit');
const path = require('path');
const log = require('./log');

const x = (t) => {
  return 585/*595.28*/ * t;
};

const y = (t) => {
  return 830/*841.89*/ * t;
};

const MARGIN = {
  LEFT: x(0.05),
  TOP: y(0.035),
  RIGHT: x(0.915),
  BOTTOM: y(0.935),
};

const marginX = t => {
  return MARGIN.LEFT + ((MARGIN.RIGHT - MARGIN.LEFT) * t);
};

const marginY = t => {
  return MARGIN.TOP + ((MARGIN.BOTTOM - MARGIN.TOP) * t);
};


class PrintedClass {
  constructor(cls) {
    this.cls = cls;
    const doc = new PDFDocument({
      size: 'A4',
      // margins: {
      //   // by default, all are 72
      //   top: MARGIN.TOP,
      //   bottom: MARGIN.BOTTOM,
      //   left: MARGIN.LEFT,
      //   right: MARGIN.RIGHT
      // },
      layout: 'portrait',
      info: {
        Title: cls.name,
        Author: 'Excelsior Studios Erina',
        Subject: '',
        Keywords: '',
        CreationDate: 'DD/MM/YYYY', // the date the document was created (added automatically by PDFKit)
        ModDate: 'DD/MM/YYYY' // the date the document was last modified
      }
    });

    doc.font(path.resolve(__dirname, "../static/fonts/Roboto-Regular.ttf"));

    this.doc = doc;

    this.createFooter();
  }

  createFooter () {
    this.doc
      // .moveTo(0, 0)
      .image(path.resolve(__dirname, 'print/bg.png'))
      .moveTo(0, 0)
      .fontSize(24)
      // .moveTo(76, 27)
      // .text('Phoenix Pilates');
      // .rect(MARGIN.LEFT, MARGIN.TOP, MARGIN.RIGHT, MARGIN.BOTTOM)
      // .fill('red')
      // .rect(marginX(0), marginY(0), marginX(1), marginY(1))
      // .fill('blue');
      .text(this.cls.name);
    log(this.doc.x + ':' + this.doc.y);
  }

  ref () {
    // Embed a font, set the font size, and render some text
    doc
      .font(path.resolve(__dirname, "../static/fonts/Roboto-Regular.ttf"))
      .fontSize(25)
      .text(cls.name, 10, 10);

    //Add another page
    doc
      .addPage()
      .fontSize(25)
      .text("Here is some vector graphics...", 100, 100);

    // Draw a triangle
    doc
      .save()
      .moveTo(100, 150)
      .lineTo(100, 250)
      .lineTo(200, 250)
      .fill("#FF3300");

    // Apply some transforms and render an SVG path with the 'even-odd' fill rule
    doc
      .scale(0.6)
      .translate(470, -380)
      .path("M 250,75 L 323,301 131,161 369,161 177,301 z")
      .fill("red", "even-odd")
      .restore();

    // Add some text with annotations
    // doc
    //   .addPage()
    //   .fillColor("blue")
    //   .text("Here is a link!", 100, 100)
    //   .underline(100, 100, 160, 27, "#0000FF")
    //   .link(100, 100, 160, 27, "http://google.com/");
  }
}

module.exports = PrintedClass;
