import FungibleToken from 0x05
import FlowToken from 0x05

transaction() {


  let flowMinter: &FlowToken.Minter

  prepare(acct: AuthAccount) {
    
    self.flowMinter = acct.borrow<&FlowToken.Minter>(from: /storage/FlowMinter)
        ?? panic("FlowToken Minter is not available")
    log("FlowToken Minter is available")
  }

  execute {
    
  }
}
