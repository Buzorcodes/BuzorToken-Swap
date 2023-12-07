
import FungibleToken from 0x05
import BuzorToken from 0x05

pub fun main(account: Address) {

    let publicVault = getAccount(account)
        .getCapability(/public/Vault)
        .borrow<&BuzorToken.Vault{FungibleToken.Balance}>()
        ?? panic("Vault setup incomplete")

  
    log("Vault setup completed")
}
