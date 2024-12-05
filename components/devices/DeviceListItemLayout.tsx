import { View, Text, Image, Pressable } from "react-native";
import React from "react";
import { router } from "expo-router";
import { getDeviceStatusColor } from "@/utils/helper";
import { AssetMasterListItemModel } from "@/models/assets";
import moment from "moment";
import Feather from "@expo/vector-icons/Feather";

interface DeviceListItemLayoutProps {
  data: AssetMasterListItemModel;
}

const DeviceListItemLayout = ({ data }: DeviceListItemLayoutProps) => {
  return (
    <View className="px-4 py-2">
      <View className="bg-white shadow-sm px-3 py-3 rounded-lg w-full">
        <Pressable
          onPress={() =>
            router.push({
              pathname: "/devices/device_details/[deviceId]",
              params: {
                deviceId: data.id as string,
              },
            })
          }
        >
          <View className="flex">
            <View className="w-full">
              <View className="flex-row justify-between items-center">
                <View className="flex">
                  <Text className="text-gray-500 text-md">Serial No.</Text>
                  <Text className="mt-[2px] font-semibold text-gray-900 text-md">
                    {data.serialNo ?? "-"}
                  </Text>
                </View>
                <View className="flex items-end">
                  <Text className="text-gray-500 text-md">Asset Type</Text>
                  <Text className="mt-[2px] font-semibold text-gray-900 text-md">
                    {data.assetTypeDetails?.name ?? "-"}
                  </Text>
                </View>
              </View>
            </View>
            {/* <View className="mt-3 w-full">
                <View className="flex-row justify-between items-center">
                  <View className="flex">
                    <Text className="text-gray-500 text-md">Model Name</Text>
                    <Text className="mt-[2px] font-semibold text-gray-900 text-md">
                      {item.assetModelDetails?.modelName ?? "-"}
                    </Text>
                  </View>
                  <View className="flex items-end">
                    <Text className="text-gray-500 text-md">Model Number</Text>
                    <Text className="mt-[2px] font-semibold text-gray-900 text-md">
                      {item.assetModelDetails?.modelNumber ?? "-"}
                    </Text>
                  </View>
                </View>
              </View> */}
            <View className="mt-3 w-full">
              <View className="flex-row justify-between items-center">
                <View className="flex">
                  <Text className="text-gray-500 text-md">
                    Unique Identifier
                  </Text>
                  <Text className="mt-[2px] font-semibold text-gray-900 text-md">
                    {data.uniqueIdentifier ?? "-"}
                  </Text>
                </View>
                <View className="flex">
                  <Text className="text-gray-500 text-md">Asset Status</Text>
                  <View
                    className={`mt-1 flex-row justify-center py-2 rounded-md ${getDeviceStatusColor(data.assetStatusDetails?.key)}`}
                  >
                    <Text
                      className={`font-medium ${getDeviceStatusColor(data.assetStatusDetails?.key)}`}
                    >
                      {data.assetStatusDetails?.value ?? "-"}
                    </Text>
                  </View>
                </View>
              </View>
            </View>
            {/* <View className="border-[.5px] border-gray-300 mt-3 mb-3 w-full h-[1px]" />
           <View className="w-full">
              <View className="flex-row justify-between items-center">
                <View className="flex">
                  <Text className="text-gray-500 text-md">Raised Tickets</Text>
                  <Text className="font-semibold text-gray-900 text-md">
                    11
                  </Text>
                </View>
                <View className="flex items-end">
                  <Text className="text-gray-500 text-md">
                    Last Ticket Status
                  </Text>
                  <Text className="font-semibold text-gray-900 text-md">
                    Raised
                  </Text>
                </View>
              </View>
            </View> */}
            <View className="border-[.5px] border-gray-300 mt-3 mb-3 w-full h-[1px]" />
            <View className="flex-row justify-between items-center w-full">
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
                  <Text className="mt-[1px] text-[13px] text-gray-500">
                    Assigned To
                  </Text>
                  <Text className="font-bold">
                    {(data.userAssignedToDetails?.firstName ?? "- ") +
                      (data.userAssignedToDetails?.lastName ?? "")}
                  </Text>
                </View>
              </View>
              <View className="flex items-end ms-2">
                <Text className="mt-[1px] text-[13px] text-gray-500">
                  Assigned At
                </Text>
                <Text className="font-bold">
                  {data.userAssignedToDetails?.createdAt
                    ? moment(data.userAssignedToDetails?.createdAt).format(
                      "DD-MM-YYYY",
                    )
                    : "-"}
                </Text>
              </View>
              {/* <View className="flex items-end">
                  <Text className="text-[13px] text-gray-500">Status</Text>
                  <View
                    className={`px-4 py-2 rounded-md ${getDeviceStatusColor(item.assetStatusDetails?.key)}`}
                  >
                    <Text
                      className={`font-medium ${getDeviceStatusColor(item.assetStatusDetails?.key)}`}
                    >
                      {item.assetStatusDetails?.value ?? "-"}
                    </Text>
                  </View>
                </View> */}
            </View>
          </View>
        </Pressable>
      </View>
    </View>
  );
};

export default DeviceListItemLayout;
