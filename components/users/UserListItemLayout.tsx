import { View, Text, Pressable, Image } from "react-native";
import React from "react";
import { router } from "expo-router";
import { UserDetailsModel } from "@/models/users";
import Feather from "@expo/vector-icons/Feather";

interface UserListItemLayoutProps {
  userDetailsModel: UserDetailsModel;
}

const getUserStatusTextTheme = (status?: string): string => {
  switch (status) {
    case "ACTIVE":
      return "bg-primary-200 text-primary-950";
    case "ONBOARDED":
      return "bg-yellow-100 text-yellow-500";
    case "TERMINATED":
      return "bg-red-100 text-red-500";
    default:
      return "bg-gray-100 text-gray-500";
  }
};

const UserListItemLayout = ({ userDetailsModel }: UserListItemLayoutProps) => {
  console.log(userDetailsModel.orgDepartmentDetails);
  return (
    <Pressable
      onPress={() =>
        router.push({
          pathname: "/users/user_details/[userId]",
          params: {
            userId: userDetailsModel.id as string,
          },
        })
      }
      className="px-4 py-2"
    >
      <View className="bg-white shadow px-3 py-3 rounded-lg w-full">
        <View className="flex">
          <View className="flex-row justify-between w-full">
            <View className="flex-row items-center">
              {/* <Image
                source={{
                  uri: "https://images.unsplash.com/photo-1445053023192-8d45cb66099d?q=80&w=2340&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                }}
                width={35}
                height={35}
                className="rounded-full"
              /> */}
              <View className="flex justify-center items-center bg-gray-100 rounded-full w-16 h-16">
                <Feather name="user" size={24} color="#9ca3af" />
              </View>
              <View className="ms-2">
                <Text className="font-bold">
                  {userDetailsModel.firstName ?? "-"}{" "}
                  {userDetailsModel.lastName ?? ""}
                </Text>
                <Text className="mt-[1px] text-[13px] text-gray-500">
                  {userDetailsModel.mobile ?? "-"}
                </Text>
              </View>
            </View>
            <View>
              <View
                className={`${getUserStatusTextTheme(userDetailsModel.statusDetails?.key)} px-4 py-3 rounded-lg`}
              >
                <Text
                  className={`${getUserStatusTextTheme(userDetailsModel.statusDetails?.key)} text-center font-semibold`}
                >
                  {userDetailsModel.statusDetails?.key ?? "-"}
                </Text>
              </View>
            </View>
          </View>
          <View className="mt-3 w-full">
            <View className="flex-row justify-between items-center">
              <View className="flex">
                <Text className="text-gray-500 text-md">Department</Text>
                <Text className="mt-[2px] font-semibold text-gray-900 text-md">
                  {userDetailsModel.departmentDetails?.name ?? "-"}
                </Text>
              </View>
              <View className="flex items-end">
                <Text className="text-gray-500 text-md">Designation</Text>
                <Text className="mt-[2px] font-semibold text-gray-900 text-md">
                  {userDetailsModel.designationDetails?.name ?? "-"}
                </Text>
              </View>
            </View>
          </View>
          <View className="border-[1px] border-gray-300 mt-3 mb-3 border-dashed w-full h-[1px]" />
          <View className="w-full">
            <View className="flex-row justify-between items-center">
              <View className="flex">
                <Text className="text-gray-500 text-md">Raised Tickets</Text>
                <Text className="mt-[2px] font-semibold text-gray-900 text-md">
                  {userDetailsModel.ticketDetails?.raisedTicketCount ?? "-"}
                </Text>
              </View>
              <View className="flex items-end">
                <Text className="text-gray-500 text-md">
                  Last Ticket Status
                </Text>
                <Text className="mt-[2px] font-semibold text-gray-900 text-md">
                  {userDetailsModel.ticketDetails?.lastTicketStatus ?? "-"}
                </Text>
              </View>
            </View>
          </View>
        </View>
      </View>
    </Pressable>
  );
};

export default UserListItemLayout;
