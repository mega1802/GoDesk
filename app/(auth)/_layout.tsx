import { Stack } from "expo-router";
import React from "react";

const Layout = () => {
  return (
    <Stack>
      <Stack.Screen name="login" options={{ headerShown: false }} />
      <Stack.Screen
        name="registration/[customerLeadId]"
        options={{
          headerTitle: "Register Organization",
          headerBackTitle: "Login",
        }}
      />
      <Stack.Screen
        name="forgot_password"
        options={{
          headerShown: false,
        }}
      />
    </Stack>
  );
};

export default Layout;
