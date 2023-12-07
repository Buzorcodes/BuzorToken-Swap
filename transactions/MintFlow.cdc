
import FungibleToken from 0x05
import FlowToken from 0x05

transaction(amountToMint: UFix64) {
 
    let minter: &FlowToken.Minter

    
    let signer: AuthAccount


    prepare(signerAccount: AuthAccount) {
  
      
        self.signer = signerAccount
     
   
        self.minter = self.signer.borrow<&FlowToken.Minter>(from: /storage/FlowMinter)
            ?? panic("Minter resource not found")
    }

   
    execute {

        let newTokens <- self.minter.mintTokens(amount: amountToMint)

    
        self.signer.save(<-newTokens, to: /storage/FlowVault)

        
        log("Flow Token Minted successfully")
    }
}
