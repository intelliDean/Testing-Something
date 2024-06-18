import './App.css';
import contractABI from "./abi.json"
const ethers = require('ethers');
function App() {

    const contractAddress = "0x97D9bcE273974455Bfc3A51E8Fd956D4209066A3";

    async function requestAccount() {
        await window.ethereum.request({
            method: 'eth_requestAccounts'
        });
    }
    async function withdraw() {
        if (typeof window.ethereum !== 'undefined') {
            await requestAccount();
            const provider = new ethers.BrowserProvider(window.ethereum);
            const signer = provider.getSigner();
            const contract = new ethers.Contract(contractAddress, contractABI, await signer);

            try {
                const transaction = await contract.withdraw();
                await transaction.wait();
                document.getElementById("but").style.display = "none";
                 document.getElementById("dis").textContent = "Successful Withdrawal";

            } catch (err) {
                console.error('Error:', err);
            }
        }
    }
    return (
        <div className="App">
            <header className="App-header">
                <div>
                    <button id={"but"} onClick={() => withdraw()}>Withdraw</button>
                </div>
                <h1 id={"dis"}></h1>
            </header>
        </div>
    );
}

export default App;
