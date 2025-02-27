export interface Version {
  value: string;
}

function fetchMcVersions(): Promise<string> {
  return fetch('https://mcversions.net').then(x => x.text())
}

async function getOrCache(key: string, fn: () => Promise<string>): Promise<string> {
  let value = localStorage.getItem(key)
  if (!value) {
    value = await fn();
    localStorage.setItem(key, value);
  }

  return value;
}

function toVersions(rawhtml: string): Version[] {
  const html = new DOMParser().parseFromString(rawhtml, 'text/html');

  html.childNodes.forEach(x => {
    console.log(x.nodeName);
  });

  return [];
}

export function listVersions(): Promise<Version[]> {
  return getOrCache('mcversions.net', fetchMcVersions)
    .then(toVersions);
}
