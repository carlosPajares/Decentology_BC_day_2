import Artist from 0x01

// This transaction configure an accont to store ArtistPicturesCollection
// execute this transaction for signing with the rest of the account (0x02...0x05)

transaction {
  prepare(acct: AuthAccount) {

    // Create a empty Pictures Collection 
    let picturesCollection <- Artist.createPicturesCollection()

    // Store it in the account 
    acct.save<@Artist.Collection>(<-picturesCollection, to: /storage/Artist_PicturesCollection)

    log("Pictures Collection create")

    // Create a public Receiver capability to the Vault
    let ReceiverRef = acct.link<&Artist.Collection>(/public/Artist_PicturesCollection, target: /storage/Artist_PicturesCollection)


    log("Reference create")
  }

  post {

  }
}