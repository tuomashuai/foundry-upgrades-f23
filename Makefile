-include .env


deploy-BoxV1-sepolia:
	forge script script/DeployBox.s.sol:DeployBox --rpc-url $(SEPOLIA_RPC_URL) --private-key $(SEPOLIA_PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

upgrades-BoxV2-sepolia:
	forge script script/UpgradeBox.s.sol:UpgradeBox --rpc-url $(SEPOLIA_RPC_URL) --private-key $(SEPOLIA_PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
