import Artist from 0x01

transaction() {

// Sign with diferents accounts and diferents pixels patrons
prepare(account: AuthAccount) {
    let printerBorrowed = account
      .getCapability<&Artist.Printer>(/public/ArtistPicturePrinter)
      .borrow()
      ?? panic("Couldn't borrow printer reference.")
    
    let PicturesBorrowed = account
      .getCapability<&Artist.Collection>(/public/Artist_PicturesCollection)
      .borrow()
      ?? panic("Couldn't borrow collection reference.")

    

    let canvasToAdd = Artist.Canvas(
      width: printerBorrowed.width,
      height: printerBorrowed.height,
      pixels: "****  * * * *   * * *   *"
    )

    PicturesBorrowed.deposit(picture: <- printerBorrowed.print(canvas: canvasToAdd)!)

    
  }

  execute {
    
    log("Execute")
    

  }
}