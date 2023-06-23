import "HybridCustody"
import "MetadataViews"

pub fun main(addr: Address, name: String, desc: String, thumbnail: String): Bool {
    let acct = getAuthAccount(addr)
    let owned = acct.borrow<&HybridCustody.OwnedAccount>(from: HybridCustody.OwnedAccountStoragePath)
        ?? panic("no owned account found")
    let display = owned.resolveView(Type<MetadataViews.Display>())! as! MetadataViews.Display

    assert(display.name == name, message: "names do not match")
    assert(display.description == desc, message: "descriptions do not match")
    assert(display.thumbnail.uri() == thumbnail, message: "thumbnails do not match")

    return true
}