var AtomicSwap = artifacts.require("./AtomicSwap.sol");
var MultiAtomicSwap = artifacts.require("./MultiAtomicSwap.sol");

const demo_swap_args = [
  "0x17dA6A8B86578CEC4525945A355E8384025fa5Af",
  "0xbe7d638280899e5ed4b57e414752e0a03c2134bd26f20b673fb0531d6c657d44"
]

const demo_multiswap_args = [
  ["0x17dA6A8B86578CEC4525945A355E8384025fa5Af"],
  ["1000000000"],
  ["0xbe7d638280899e5ed4b57e414752e0a03c2134bd26f20b673fb0531d6c657d44"]
]

module.exports = function(deployer) {
  deployer.deploy(AtomicSwap, ...demo_swap_args);
  // deployer.deploy(MultiAtomicSwap, ...demo_multiswap_args);
};
