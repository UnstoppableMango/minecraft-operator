import "./index.css";
import { JSX, useEffect, useState } from 'react';
import { listVersions, Version } from './versions';

export function App(): JSX.Element {
  const [loading, setLoading] = useState(true);
  const [versions, setVersions] = useState<Version[]>([]);
  const [error, setError] = useState<string>();

  useEffect(() => {
    if (loading && !versions.length) {
      listVersions()
        .then(setVersions)
        .then(() => setLoading(false))
        .catch(setError)
    }
  }, []);

  if (error) {
    return (
      <div>
        <span>Error: {error}</span>
      </div>
    )
  }

  return (
    <div className="w-svw p-8">
      <div className="w-1/3 h-1/3 bg-green-700">
        <span>Versions: {versions.map(x => x.value).join(', ')}</span>
      </div>
    </div>
  );
}

export default App;
