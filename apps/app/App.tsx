import { useEffect, useState } from "react";
import { View, Text } from "react-native";

export default function App() {
  const [banner, setBanner] = useState("");

  useEffect(() => {
    fetch("/.netlify/functions/health")
      .then((res) => res.ok)
      .then((ok) => setBanner(ok ? "Health OK" : "Health FAIL"))
      .catch(() => setBanner("Health FAIL"));
  }, []);

  return (
    <View>{banner ? <Text testID="health-banner">{banner}</Text> : null}</View>
  );
}
