import FungibleToken from 0x05
import BuzorToken from 0x05

transaction(receiver: Address, amount: UFix64) {

    prepare(signer: AuthAccount) {
       
        let minter = signer.borrow<&BuzorToken.Minter>(from: /storage/MinterStorage)
            ?? panic("You are not an allowed BuzorToken minter")
        
      \
        let receiverVault = getAccount(receiver)
            .getCapability<&BuzorToken.Vault{FungibleToken.Receiver}>(/public/Vault)
            .borrow()
            ?? panic("Error: Check your BuzorToken Vault status")
        
      
        let mintedTokens <- minter.mintToken(amount: amount)

        
        receiverVault.deposit(from: <-mintedTokens)
    }

    execute {
        log("Minted and deposited successfully")
        log(amount.toString().concat(" Tokens minted and deposited"))
    }
}
