
import FungibleToken from 0x05
import BuzorToken from 0x05

pub fun main(account: Address) {

    let publicVault: &BuzorToken.Vault{FungibleToken.Balance, FungibleToken.Receiver, BuzorToken.CollectionPublic}? =
        getAccount(account).getCapability(/public/Vault)
            .borrow<&BuzorToken.Vault{FungibleToken.Balance, FungibleToken.Receiver, BuzorToken.CollectionPublic}>()

    if (publicVault == nil) {
        let newVault <- BuzorToken.createEmptyVault()
        getAuthAccount(account).save(<-newVault, to: /storage/VaultStorage)
        getAuthAccount(account).link<&BuzorToken.Vault{FungibleToken.Balance, FungibleToken.Receiver, BuzorToken.CollectionPublic}>(
            /public/Vault,
            target: /storage/VaultStorage
        )
        log("Vault setup completed")
        
        // Retrieve the newly created vault's balance and log it
        let retrievedVault: &BuzorToken.Vault{FungibleToken.Balance}? =
            getAccount(account).getCapability(/public/Vault)
                .borrow<&BuzorToken.Vault{FungibleToken.Balance}>()
        log("Vault Balance: \(retrievedVault?.balance ?? 0.0)")
    } else {
        log("Vault setup completed")
        
        let checkVault: &BuzorToken.Vault{FungibleToken.Balance, FungibleToken.Receiver, BuzorToken.CollectionPublic} =
            getAccount(account).getCapability(/public/Vault)
                .borrow<&BuzorToken.Vault{FungibleToken.Balance, FungibleToken.Receiver, BuzorToken.CollectionPublic}>()
                ?? panic("Vault capability not found")

        if BuzorToken.vaults.contains(checkVault.uuid) {
           
            log("Vault Balance: \(publicVault?.balance ?? 0.0)")
        log("BuzorToken vault")
        } else {
           
            log("Not BuzorToken vault")
        }
    }
}
