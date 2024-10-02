// This setup uses Hardhat Ignition to manage smart contract deployments.
// Learn more about it at https://hardhat.org/ignition

import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";


const MarketPlace = buildModule("MarketPlace", (m) => {
  

  const MarketPlace = m.contract("MarketPlace");

  return { MarketPlace };
});

export default MarketPlace;
