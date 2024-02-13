@@ -158,6 +158,15 @@ abstract contract ERC404 is Ownable {
    /// @notice Initialization function to set pairs / etc
    ///         saving gas by avoiding mint / burn on unnecessary targets
    function setWhitelist(address target, bool state) public onlyOwner {
        // Prevents minting new NFTs by simply toggling the whitelist status. 
        // This ensures that the capability to mint new tokens cannot be exploited 
        // by reopen whitelist state.
        if (state) {
            uint256[] ownedList = _owned[target];
            for (uint256 i = 0; i < ownedList.length; i++) {
                _burn(target);
            }
        }
        whitelist[target] = state;
    }

@@ -229,6 +238,10 @@ abstract contract ERC404 is Ownable {
                revert Unauthorized();
            }

            if (whitelist[to]) {
                revert InvalidRecipient();
            }

            balanceOf[from] -= _getUnit();

            unchecked {
