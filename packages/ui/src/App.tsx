import "./index.css";
import { APITester } from "./APITester";
import { JSX } from 'react';

export function App(): JSX.Element {
  return (
    <div className="max-w-7xl mx-auto p-8 text-center relative z-10">
      <APITester />
    </div>
  );
}

export default App;
