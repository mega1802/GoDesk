import React from "react";
import { GestureHandlerRootView } from "react-native-gesture-handler";
import { Drawer } from "expo-router/drawer";

import Icon from "@expo/vector-icons/AntDesign";
import { TouchableOpacity } from "react-native";
import CustomDrawerContent from "@/components/home/CustomDrawerContent";

const Layout = () => {
  return (
    <GestureHandlerRootView style={{ flex: 1 }}>
      <Drawer
        drawerContent={(props: any) => <CustomDrawerContent {...props} />}
        screenOptions={(props: { navigation: { openDrawer: () => void } }) => ({
          headerStyle: {
            backgroundColor: "#f2f2f2",
            shadowColor: "#f2f2f2",
          },
          headerLeft: (_: any) => (
            <TouchableOpacity
              onPress={() => {
                props.navigation?.openDrawer();
              }}
            >
              <Icon name="bars" size={26} className="ps-3" />
            </TouchableOpacity>
          ),
          // headerRight: (_) => <TouchableOpacity>
          //   <Image source={{uri: user}} />
          // </TouchableOpacity>,
        })}
      >
        <Drawer.Screen
          name="home"
          options={{ title: "Home", headerTitle: "" }}
        />
        <Drawer.Screen
          name="settings/change_password"
          options={{ title: "Change Password", headerTitle: "" }}
        />
        {/* 
        <Drawer.Screen
          name="tickets_history/[customerId]"
          options={{ title: "Tickets History", drawerItemStyle: { height: 0 } }}
        />
        <Drawer.Screen
          name="raise_ticket/[customerId]"
          options={{ title: "Raise Ticket", drawerItemStyle: { height: 0 } }}
        />
        <Drawer.Screen
          name="ticket_history_details/[ticketId]"
          options={{ title: "Ticket Details", drawerItemStyle: { height: 0 } }}
        /> 
        */}
      </Drawer>
    </GestureHandlerRootView>
  );
};

export default Layout;
