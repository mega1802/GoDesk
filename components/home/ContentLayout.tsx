import {
  FlatList,
  Pressable,
  Text,
  TouchableOpacity,
  View,
  Image,
} from "react-native";
import { VStack } from "@/components/ui/vstack";
import { HStack } from "@/components/ui/hstack";
import React, { useEffect, useRef, useState } from "react";
import { Button, ButtonText } from "@/components/ui/button";
import RecentTicketHistoryLayout from "@/components/common/RecentTicketHistoryLayout";
import { router } from "expo-router";
import { ServiceItemModel } from "@/models/ui/service_item_model";
import Ionicons from "@expo/vector-icons/Ionicons";
import { RoleModel, RoleModulePermissionsModel } from "@/models/rbac";
import { CheckInOutStatusDetailsModel, UserDetailsModel } from "@/models/users";
import AntDesign from "@expo/vector-icons/AntDesign";
import { getGreetingMessage } from "@/utils/helper";
import CheckIn from "./CheckInOut";
import api from "@/services/api";
import { GET_CHECK_IN_OUT_STATUS } from "@/constants/api_endpoints";
import CheckInOutModal from "./CheckInOut";
import { useTranslation } from 'react-i18next';
const ContentLayout = ({
  customerDetails,
  authorizedModules,
  roleDetails,
}: {
  customerDetails: UserDetailsModel;
  authorizedModules: RoleModulePermissionsModel[];
  roleDetails: RoleModel;
}) => {
  const [serviceTabs, setServiceTabs] = useState<ServiceItemModel[]>([]);

  const bottomSheetRef = useRef(null);
  const [isModalVisible, setIsModalVisible] = useState(false);
  const { t, i18n } = useTranslation();
  const [checkInOutStatusDetails, setCheckInOutStatusDetails] =
    useState<CheckInOutStatusDetailsModel>({});

  const [ticketsTabAdded, setTicketsTabAdded] = useState(false);
  const [customerTabsAdded, setCustomerTabsAdded] = useState(false);

  const toggleImagePicker = () => {
    setIsModalVisible(!isModalVisible);
    if (!isModalVisible) {
      bottomSheetRef.current?.show();
    } else {
      bottomSheetRef.current?.hide();
    }
  };

  useEffect(() => {
    if (customerDetails.id) {
      if (!ticketsTabAdded) {
        setServiceTabs((prev) => {
          prev.push({
            label: t('Tickets'),
            icon: <Ionicons name="ticket-outline" size={20} color="#39a676" />,
            path: "/tickets/tickets_history/list/[customerId]",
            params: {
              customerId: customerDetails.id ?? "",
            },
            code: "TICKETS",
          });
          return prev;
        });
        setTicketsTabAdded(true);
      }

      const userTypeKey = customerDetails?.userTypeDetails?.key;

      if (
        userTypeKey !== undefined &&
        customerDetails?.userTypeDetails?.key === "CUSTOMER" &&
        !customerTabsAdded
      ) {
        setServiceTabs((prev) => {
          return [
            ...prev,
            {
              label: t("Devices"),
              icon: <AntDesign name="laptop" size={20} color="#39a676" />,
              path: "/devices/devices_list",
              code: "DEVICES",
            },
            {
              label: t("Users"),
              icon: <AntDesign name="laptop" size={20} color="#39a676" />,
              path: "/users/users_list",
              code: "USERS",
            },
          ];
        });
        setCustomerTabsAdded(true);
      }
    }
  }, [customerDetails, roleDetails]);

  const fetchCheckInOutStatus = async () => {
    api
      .get(GET_CHECK_IN_OUT_STATUS)
      .then((response) => {
        console.log("checkInDetails", response.data.data);
        const data = response.data?.data;
        if (data) {
          setCheckInOutStatusDetails(data);
        }
      })
      .catch((e) => {
        console.error(e.response.data);
      });
  };

  useEffect(() => {
    fetchCheckInOutStatus();
  }, []);

  return (
    <View className="mt-2">
      <View className="px-4">
        <View className="w-full">
          <View className="flex-row justify-between items-center">
            <View className="">
              <Text className="text-xl font-bold">
                {getGreetingMessage()} 👋
              </Text>
              <Text className="color-primary-950 text-xl font-bold">
                {customerDetails.firstName ?? ""}{" "}
                {customerDetails.lastName ?? ""}
              </Text>
            </View>
            {checkInOutStatusDetails.value !== "Checked Out" && (
              <View className="">
                <Button
                  className="bg-primary-950 rounded-lg"
                  onPress={() => {
                    toggleImagePicker();
                  }}
                >
                  <ButtonText>
                  {checkInOutStatusDetails.value === "Checked In"
                    ? t('checkOut')
                    : t('checkIn')}
                </ButtonText>
                </Button>
              </View>
            )}
          </View>
        </View>
        <View className="mt-6 ps-4 pe-0 rounded-2xl bg-white">
          <View className="flex-row justify-between items-end">
            <VStack className="w-44 justify-evenly my-3">
              <VStack>
                <Text className="text-2xl font-medium">
                  {t('Having trouble with your Device')}
                  <Text className="text-primary-950"> Device?</Text>
                </Text>
              </VStack>
              <Button
                className="mb-4 mt-4 bg-gray-900 rounded-lg"
                onPress={() =>
                  router.push({
                    pathname: "/tickets/raise_ticket/[customerId]",
                    params: {
                      customerId: customerDetails.id ?? "",
                    },
                  })
                }
              >
                <ButtonText>{t('Raise Ticket')}</ButtonText>
                <AntDesign
                  name="arrowright"
                  className="ms-3"
                  color="white"
                  size={20}
                />
              </Button>
            </VStack>
            <Image
              source={require("../../assets/images/card_man.png")}
              className="w-[150px] h-[150px] me-4"
            />
          </View>
        </View>
        {serviceTabs && (
          <VStack className="mt-4">
            <Text className="text-[16px] font-bold">{t('Quick Actions')}</Text>
            <FlatList
              className="mt-2"
              data={serviceTabs}
              numColumns={3}
              renderItem={(item) => {
                const icon: any = item.item.icon;
                return (
                  <TouchableOpacity
                    onPress={() => {
                      const path: any = item.item.path;
                      if (path) {
                        router.push({
                          pathname: path,
                          params: item.item.params ?? {},
                        });
                      }
                    }}
                  >
                    <View className="px-2 py-3 bg-white my-2 me-5 rounded-lg flex justify-center items-center gap-2 w-28">
                      <View className=" w-10 h-10 p-1 bg-primary-100 rounded-full flex justify-center items-center ">
                        {icon}
                      </View>
                      <Text className="text-primary-900 font-semibold text-sm">
                        {item.item.label}
                      </Text>
                    </View>
                  </TouchableOpacity>
                );
              }}
            />
          </VStack>
        )}
        <HStack className="justify-between mt-4">
          <View className="flex-row items-center">
            <Text className="text-[16px] font-bold">{t('Recent Tickets')}</Text>
            <Ionicons
              name="ticket-outline"
              size={20}
              color="black"
              className="ms-2"
            />
          </View>
          <Pressable
            onPress={() =>
              router.push({
                pathname: "/tickets/tickets_history/list/[customerId]",
                params: {
                  customerId: customerDetails.id ?? "",
                },
              })
            }
          >
            <Text className="text-sm underline color-primary-950 font-medium">
              Show All
            </Text>
          </Pressable>
        </HStack>
      </View>
      <View className="mt-2">
        <RecentTicketHistoryLayout placing="home" />
      </View>
      <CheckInOutModal
        setIsModalVisible={setIsModalVisible}
        bottomSheetRef={bottomSheetRef}
        status={checkInOutStatusDetails.value}
        checkedInId={checkInOutStatusDetails.id}
        onClose={() => {
          setIsModalVisible(false);
          fetchCheckInOutStatus();
        }}
      />
    </View>
  );
};

export default ContentLayout;
