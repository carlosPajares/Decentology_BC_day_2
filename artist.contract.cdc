pub contract Artist {

  pub struct Canvas {

    pub let width: UInt8
    pub let height: UInt8
    pub let pixels: String

    init(width: UInt8, height: UInt8, pixels: String) {
      self.width = width
      self.height = height

      self.pixels = pixels
    }
  }

  pub resource Picture {

    pub let canvas: Canvas
    
    init(canvas: Canvas) {
      self.canvas = canvas
    }
  }

pub resource Collection {

        // Picture collection @[]
        pub let pictures: @[Picture]

        // add to the collection resource 
        pub fun deposit(picture: @Picture) {
            self.pictures.append(<- picture)
        }

        // init the resource 
        init() {
            self.pictures <- []
        }

        destroy() {
            destroy self.pictures
        }

    }

pub fun createEmptyPicturesCollection(): @Collection {
        return <-create Collection()
    }


  pub resource Printer {

    pub let width: UInt8
    pub let height: UInt8
    pub let prints: {String: Canvas}

    init(width: UInt8, height: UInt8) {
      self.width = width;
      self.height = height;
      self.prints = {}
    }

    pub fun print(canvas: Canvas): @Picture? {
      // Canvas needs to fit Printer's dimensions.
      if canvas.pixels.length != Int(self.width * self.height) {
        return nil
      }

      // Canvas can only use visible ASCII characters.
      for symbol in canvas.pixels.utf8 {
        if symbol < 32 || symbol > 126 {
          return nil
        }
      }

      // Printer is only allowed to print unique canvases.
      if self.prints.containsKey(canvas.pixels) == false {
        let picture <- create Picture(canvas: canvas)
        self.prints[canvas.pixels] = canvas

        return <- picture
      } else {
        return nil
      }
    }
  }

  init() {
    self.account.save(
      <- create Printer(width: 5, height: 5),
      to: /storage/ArtistPicturePrinter
    )
    self.account.link<&Printer>(
      /public/ArtistPicturePrinter,
      target: /storage/ArtistPicturePrinter
    )

    // Create the Pictures collection in the store of the contract account 
    self.account.save(
            <- self.createEmptyPicturesCollection(),
            to: /storage/Artist_PicturesCollection
        )

    // Create link to the Pictures Collection 
    self.account.link <&Collection> (
          /public/Artist_PicturesCollection,
          target: /storage/Artist_PicturesCollection
        )


  }
}
