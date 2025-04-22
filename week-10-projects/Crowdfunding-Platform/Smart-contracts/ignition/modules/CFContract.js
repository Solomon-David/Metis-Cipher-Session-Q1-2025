const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule( "CFContractModule", (m) => {
	const contract = m.contract("CFContract");
	return { contract };
});