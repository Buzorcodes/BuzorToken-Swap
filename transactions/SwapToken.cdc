import SwapToken from 0x05

transaction(amount: UFix64) {


    let owner: AuthAccount

    prepare(acct: AuthAccount) {
        self.owner = acct
    }

    execute {
        // Call the SwapToken contract to swap tokens
        SwapToken.swapTokens(owner: self.owner, swapAmount: amount)
        log("Swap completed")
    }
}
