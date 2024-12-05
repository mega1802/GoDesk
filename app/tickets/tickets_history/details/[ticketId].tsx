import { ScrollView, Text, View, Image, Pressable } from "react-native";
import React, { useEffect, useState } from "react";
import { router, useLocalSearchParams, useNavigation } from "expo-router";
import { TicketListItemModel } from "@/models/tickets";
import api from "@/services/api";
import { GET_TICKET_DETAILS } from "@/constants/api_endpoints";
import LoadingBar from "@/components/LoadingBar";
import TicketStatusComponent from "@/components/tickets/TicketStatusComponent";
import moment from "moment";

const TicketDetails = () => {
  const { ticketId } = useLocalSearchParams();

  const [ticketModel, setTicketModel] = useState<TicketListItemModel>({});

  const [isLoading, setIsLoading] = useState(true);

  const navigation = useNavigation();

  useEffect(() => {
    console.log("ticketModel", ticketModel);
    
    navigation.setOptions({
      headerLeftContainerStyle: {
        paddingStart: 10,
      },
    });

    api
      .get(GET_TICKET_DETAILS + `?ticketId=${ticketId}`)
      .then((response) => {
        setIsLoading(false);
        setTicketModel(response.data.data ?? {});
      })
      .catch((e) => {
        console.error(e);
        setIsLoading(false);
      });
  }, [ticketId, navigation]);

  return isLoading ? (
    <LoadingBar />
  ) : (
    <ScrollView>
      <View className="p-4">
        <View className="bg-white px-3 py-3 rounded-lg w-full">
          <View className="flex">
            <View className="flex-row justify-between w-full">
              <View>
                <Text className="font-bold text-gray-900">
                  {ticketModel?.ticketNo ?? "-"}
                </Text>
                <Text className="mt-[1px] text-[13px] text-gray-500">
                  Issue in {ticketModel.issueTypeDetails?.name ?? "-"}
                </Text>
              </View>
              <TicketStatusComponent
                statusKey={ticketModel.statusDetails?.key}
                statusValue={ticketModel.statusDetails?.value}
              />
            </View>
            <View className="border-[1px] border-gray-300 mt-3 mb-3 border-dashed w-full h-[1px]" />
            <View className="w-full">
              <View className="flex-row justify-between items-center">
                <View className="flex">
                  <Text className="text-gray-500 text-md">Raised by</Text>
                  <Text className="mt-[2px] font-semibold text-gray-900 text-md">
                    {ticketModel?.customerDetails?.firstName ?? "-"}{" "}
                    {ticketModel?.customerDetails?.lastName ?? ""}
                  </Text>
                </View>
                <View className="flex items-end">
                  <Text className="text-gray-500 text-md">Raised At</Text>
                  <Text className="mt-[2px] font-semibold text-gray-900 text-md">
                    {ticketModel.createdAt
                      ? moment(ticketModel.createdAt).fromNow()
                      : "-"}
                  </Text>
                </View>
              </View>
            </View>
            <View className="mt-3 w-full">
              <View className="flex-row justify-between items-center">
                <View className="flex">
                  <Text className="text-gray-500 text-md">Serial No</Text>
                  <Text className="mt-[2px] font-semibold text-gray-900 text-md">
                    {ticketModel?.assetInUseDetails?.serialNo ?? "-"}
                  </Text>
                </View>
                <View className="flex items-end">
                  <Text className="text-gray-500 text-md">Asset Type</Text>
                  <Text className="mt-[2px] font-semibold text-gray-900 text-md">
                    {ticketModel.assetInUseDetails?.assetMasterDetails
                      ?.assetTypeDetails?.name ?? "-"}
                  </Text>
                </View>
              </View>
            </View>
            <View className="mt-3 w-full">
              <Text className="text-gray-500 text-md">Description</Text>
              <Text className="mt-[2px] font-semibold text-gray-900 text-md">
                {ticketModel?.description ?? "-"}
              </Text>
            </View>
            <View className="mt-3 w-full">
              <Text className="text-gray-500 text-md">Issue Images</Text>
              {(ticketModel.ticketImages ?? []).length > 0 ? (
                ticketModel.ticketImages?.map((uri, index) => (
                  <Pressable
                    onPress={() => {
                      router.push({
                        pathname: "/image_viewer/[uri]",
                        params: {
                          uri: uri,
                        },
                      });
                    }}
                  >
                    <Image
                      source={{ uri: uri }}
                      className="mt-2 rounded-xl w-24 h-24"
                    />
                  </Pressable>
                ))
              ) : (
                <Text>-</Text>
              )}
            </View>
            <View className="mt-3 w-full">
              <View>
                <Text className="text-gray-500 text-md">Assinged To</Text>
                <Text className="mt-[2px] font-semibold text-gray-900 text-md">
                  {ticketModel?.lastAssignedToDetails?.firstName ??
                    "-" + (ticketModel?.lastAssignedToDetails?.lastName ?? "")}
                </Text>
              </View>
            </View>
            <View className="mt-3 w-full">
              <View>
                <Text className="text-gray-500 text-md">Assinged At</Text>
                <Text className="mt-[2px] font-semibold text-gray-900 text-md">
                  {ticketModel.lastAssignedToDetails?.assignedAt
                    ? moment(
                        ticketModel.lastAssignedToDetails?.assignedAt,
                      ).fromNow()
                    : "-"}
                </Text>
              </View>
            </View>
          </View>
        </View>
      </View>
    </ScrollView>
  );
};

export default TicketDetails;
