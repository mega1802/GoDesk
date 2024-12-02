import { View, Text, Pressable, Image } from "react-native";
import React, { useEffect, useState } from "react";
import BottomSheet from "../BottomSheet";
import moment from "moment";
import * as Location from "expo-location";
import { isFormFieldInValid } from "@/utils/helper";
import { ErrorModel } from "@/models/common";
import MaterialCommunityIcons from "@expo/vector-icons/MaterialCommunityIcons";
import * as ImagePicker from "expo-image-picker";
import { Button, ButtonText } from "../ui/button";

interface CheckInOutProps {
  setIsModalVisible: any;
  bottomSheetRef: any;
}

const CheckInOut = ({ bottomSheetRef }: CheckInOutProps) => {
  const [currentTime, setCurrentTime] = useState(
    moment().format("DD/MM/YYYY hh:mm:ss A"),
  );
  const [pincode, setPincode] = useState<string | undefined>(undefined);
  const [errors, setErrors] = useState<ErrorModel[]>([]);

  const [cameraPermissionStatus, requestCameraPermission] =
    ImagePicker.useCameraPermissions();

  useEffect(() => {
    const timer = setInterval(() => {
      setCurrentTime(moment().format("DD/MM/YYYY hh:mm:ss A"));
    }, 1000);

    const fetchPincode = async () => {
      const { status } = await Location.requestForegroundPermissionsAsync();
      if (status !== "granted") {
        console.error("Permission to access location was denied");
        return;
      }

      const location = await Location.getCurrentPositionAsync({});
      const { latitude, longitude } = location.coords;

      const [address] = await Location.reverseGeocodeAsync({
        latitude,
        longitude,
      });
      setPincode(address.postalCode ?? "");
    };

    fetchPincode();

    return () => clearInterval(timer); // Cleanup timer on component unmount
  }, []);

  const requestCameraPermissions = async () => {
    if (cameraPermissionStatus?.granted) {
      return true;
    } else if (
      cameraPermissionStatus?.status === ImagePicker.PermissionStatus.DENIED
    ) {
      if (cameraPermissionStatus?.canAskAgain) {
        const permissionResponse = await requestCameraPermission();
        if (permissionResponse.granted) {
          return true;
        }
      }
      alert(
        "Sorry, we need a camera permission to access to your camera to capture selfie image for check in",
      );
      return false;
    } else if (
      cameraPermissionStatus?.status ===
      ImagePicker.PermissionStatus.UNDETERMINED
    ) {
      const permissionResponse = await requestCameraPermission();
      if (permissionResponse.granted) {
        return true;
      }
      alert(
        "Sorry, we need a camera permission to access to your camera to capture selfie image for check in",
      );
      return false;
    }
    alert(
      "Sorry, we need a camera permission to access to your camera to capture selfie image for check in",
    );
    return false;
  };

  const takePhoto = async () => {
    const permissionsGranted = await requestCameraPermissions();
    if (!permissionsGranted) return;

    let result = await ImagePicker.launchCameraAsync({
      allowsEditing: true,
      aspect: [4, 3],
      quality: 1,
      base64: true,
    });

    if (!result.canceled) {
      const asset = result.assets[0];
      const fileSize = (asset.base64?.length ?? 0) * (3 / 4) - 2;
      const uri = asset.uri;
    }
  };

  return (
    <BottomSheet initialHeight={500} ref={bottomSheetRef}>
      <View className="p-4 gap-4">
        <Text className="text-xl font-bold">Check In</Text>
        <View className="gap-5">
          <View className="">
            <Text className="text-lg font-semibold">Start at</Text>
            <Text className="text-md text-gray-700 mt-1">{currentTime}</Text>
          </View>
          <View className="">
            <Text className="text-lg font-semibold">Pincode</Text>
            <Text className="text-md text-gray-700 mt-1">{pincode ?? "-"}</Text>
          </View>
          <View className="flex-row justify-between">
            <View className="">
              <Text className="text-lg font-semibold">Selfie</Text>
              <Pressable
                onPress={() => {
                  takePhoto();
                }}
                className="mt-1"
              >
                <View
                  className={`${isFormFieldInValid("selfie", errors).length === 0 ? "border-primary-950" : "border-red-700"} border-[1px] border-dashed h-32 
                rounded-md mt-1 flex justify-center items-center w-32 `}
                >
                  <View className="flex justify-center items-center mt-3">
                    <View
                      className={`${isFormFieldInValid("selfie", errors).length === 0 ? "bg-primary-300" : "bg-red-300"} rounded-md p-2 bg-primary-300 w-auto`}
                    >
                      <MaterialCommunityIcons
                        name="camera-plus"
                        color={`${isFormFieldInValid("selfie", errors).length === 0 ? "#009c68" : "#b91c1c"}`}
                        size={18}
                      />
                    </View>
                  </View>
                </View>
              </Pressable>
            </View>
            {/* <Image
              source={require("../../assets/images/check_in_out.png")}
              className="w-[150px] h-[150px]"
            /> */}
          </View>
          <Button className="bg-primary-950 mt-4 h-12">
            <ButtonText>Check In</ButtonText>
          </Button>
        </View>
      </View>
    </BottomSheet>
  );
};

export default CheckInOut;
