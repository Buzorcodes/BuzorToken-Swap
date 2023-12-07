import FungibleToken from 0x05
import BuzorToken from 0x05

transaction() {

    // Define references
    let userVault: &BuzorToken.Vault{FungibleToken.Balance, FungibleToken.Provider, FungibleToken.Receiver, BuzorToken.CollectionPublic}?
    let account: AuthAccount

    prepare(acct: AuthAccount) {

      
        self.userVault = acct.getCapability(/public/Vault)
            .borrow<&BuzorToken.Vault{FungibleToken.Balance, FungibleToken.Provider, FungibleToken.Receiver, BuzorToken.CollectionPublic}>()

        self.account = acct
    }

    execute {
        if self.userVault == nil {
          
            let emptyVault <- BuzorToken.createEmptyVault()
            self.account.save(<-emptyVault, to: /storage/VaultStorage)
            self.account.link<&BuzorToken.Vault{FungibleToken.Balance, FungibleToken.Provider, FungibleToken.Receiver, BuzorToken.CollectionPublic}>(/public/Vault, target: /storage/VaultStorage)
            log("Empty vault created")
        } else {
            log("Vault already exist")
        }
    }
}
