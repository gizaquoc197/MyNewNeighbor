import { useEffect, useState } from "react";
import { StyleSheet, Text, View } from "react-native";
import { StatusBar } from "expo-status-bar";

export default function App() {
  const [status, setStatus] = useState<string>("checking backend...");

  useEffect(() => {
    const baseUrl = process.env.EXPO_PUBLIC_API_BASE_URL;

    if (!baseUrl) {
      setStatus("API base URL not set");
      return;
    }

    fetch(`${baseUrl}/health`)
      .then(res => res.json())
      .then(data => setStatus(JSON.stringify(data)))
      .catch(() => setStatus("API not reachable"));
  }, []);

  return (
    <View style={styles.container}>
      <Text>My New Neighbor</Text>
      <Text>Backend status:</Text>
      <Text>{status}</Text>
      <StatusBar style="auto" />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#fff",
    alignItems: "center",
    justifyContent: "center",
  },
});