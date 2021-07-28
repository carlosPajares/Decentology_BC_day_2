import Artist from 0x01


pub fun showPicturesCollection (picturesBorrowed: &Artist.Collection) {

  if picturesBorrowed != nil {
    var nItem = 0
    while picturesBorrowed.pictures.length > nItem {
      display(canvas: picturesBorrowed.pictures[nItem].canvas)
      nItem = nItem + 1
    }   
  }
  
}


pub fun display(canvas: Artist.Canvas){    
  let frameTopBottomStyle: String = "+-----+"
  let frameSideStyle: String = "|"
  var counter: Int = 0
  let rowCount: Int  = Int(canvas.height)
  let rowWidth: Int  = Int(canvas.width)
  log(frameTopBottomStyle) //header


  while counter <= rowCount-1 { // loop rows
    log(frameSideStyle.concat(canvas.pixels.slice(from: (counter * rowCount), upTo: (counter * rowCount + rowWidth)).concat(frameSideStyle)))
    counter = counter + 1
  } 
  log(frameTopBottomStyle) //footer
}

pub fun main() {

  let pictures0x01 = getAccount(0x01)
  .getCapability<&Artist.Collection>(/public/Artist_PicturesCollection)
  .borrow() 
  ?? panic("The account 0x01 don't have a Pictures collection")
  showPicturesCollection(picturesBorrowed: pictures0x01)

  let pictures0x02 = getAccount(0x02)
  .getCapability<&Artist.Collection>(/public/Artist_PicturesCollection)
  .borrow() 
  ?? panic("The account 0x02 don't have a Pictures collection")
  showPicturesCollection(picturesBorrowed: pictures0x02)

  let pictures0x03 = getAccount(0x03)
  .getCapability<&Artist.Collection>(/public/Artist_PicturesCollection)
  .borrow() 
  ?? panic("The account 0x03 don't have a Pictures collection")
  showPicturesCollection(picturesBorrowed: pictures0x03)

  let pictures0x04 = getAccount(0x04)
  .getCapability<&Artist.Collection>(/public/Artist_PicturesCollection)
  .borrow() 
  ?? panic("The account 0x04 don't have a Pictures collection")
  showPicturesCollection(picturesBorrowed: pictures0x04)

  let pictures0x05 = getAccount(0x05)
  .getCapability<&Artist.Collection>(/public/Artist_PicturesCollection)
  .borrow() 
  ?? panic("The account 0x05 don't have a Pictures collection")
  showPicturesCollection(picturesBorrowed: pictures0x05)






}