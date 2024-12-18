import { View, Text, SafeAreaView, Pressable } from "react-native";
import React, { useState } from "react";
import MaterialIcons from "@expo/vector-icons/MaterialIcons";
import { ErrorModel } from "@/models/common";
import PrimaryTextFormField from "@/components/fields/PrimaryTextFormField";
import SubmitButton from "@/components/SubmitButton";
import api from "@/services/api";
import {
  CHANGE_PASSWORD,
  SEND_OTP_TO_EMAIL,
  VERIFY_EMAIL_OTP,
} from "@/constants/api_endpoints";
import Toast from "react-native-toast-message";
import { router } from "expo-router";
import { useTranslation } from 'react-i18next';
enum PasswordChangeStatus {
  none,
  otpSent,
  otpVerified,
}

const ForgotPassword = () => {
  const { t, i18n } = useTranslation();
  const [email, setEmail] = useState<string>("");
  const [otp, setOTP] = useState<string>("");
  const [userId, setUserId] = useState<string>("");
  const [password, setPassword] = useState<string>("");
  const [confirmPassword, setConfirmPassword] = useState<string>("");

  const [isLoading, setIsLoading] = useState(false);

  const [errors, setErrors] = useState<ErrorModel[]>([]);
  // can validate fields
  const [canValidateField, setCanValidateField] = useState(false);

  const [fieldValidationStatus, setFieldValidationStatus] = useState<any>({});

  const [passwordChangeStatus, setPasswordChangeStatus] =
    useState<PasswordChangeStatus>(PasswordChangeStatus.none);

  const setFieldValidationStatusFunc = (
    fieldName: string,
    isValid: boolean,
  ) => {
    if (fieldValidationStatus[fieldName]) {
      fieldValidationStatus[fieldName](isValid);
    }
  };

  const getButtonText = (): string => {
    switch (passwordChangeStatus) {
      case PasswordChangeStatus.none:
        return t('send OTP');
      case PasswordChangeStatus.otpSent:
        return "Verify OTP";
      case PasswordChangeStatus.otpVerified:
        return "Change Password";
    }
    return "";
  };

  const sendOTP = async () => {
    const validationPromises = Object.keys(fieldValidationStatus).map(
      (key) =>
        new Promise((resolve) => {
          // Resolve each validation status based on field key
          setFieldValidationStatus((prev: any) => ({
            ...prev,
            [key]: resolve,
          }));
        }),
    );

    setCanValidateField(true);

    // Wait for all validations to complete
    await Promise.all(validationPromises);

    const allValid = errors
      .map((error) => error.message?.length === 0)
      .every((status) => status === true);

    if (allValid) {
      setIsLoading(true);

      setErrors([]);

      api
        .get(SEND_OTP_TO_EMAIL + `?email=${email}`)
        .then(async (response) => {
          let loginData = response.data.data;
          console.log("loginData ", loginData);
          // setEmail("");
          if (loginData.userId) {
            setUserId(loginData?.userId);
            setOTP("");
            Toast.show({
              type: "success",
              text1: "OTP sent",
              text2:
                "OTP sent your entered email, please enter a otp to verify to change your password.",
            });
            setIsLoading(false);
            setPasswordChangeStatus(PasswordChangeStatus.otpSent);
          } else {
            Toast.show({
              type: "error",
              text1: "Invalid credentials",
              text2: "Enter a valid email",
            });
          }
        })
        .catch(async (e) => {
          // console.error(e);
          console.error(e.response);
          let errors = e.response?.data?.errors;
          if (errors) {
            console.error("errors -> ", errors);
            setErrors(errors);
          }
          setIsLoading(false);
          Toast.show({
            type: "error",
            text1: "Invalid credentials",
            text2: "Enter a valid email",
          });
        });
    }
  };

  const verifyOTP = async () => {
    const validationPromises = Object.keys(fieldValidationStatus).map(
      (key) =>
        new Promise((resolve) => {
          // Resolve each validation status based on field key
          setFieldValidationStatus((prev: any) => ({
            ...prev,
            [key]: resolve,
          }));
        }),
    );

    setCanValidateField(true);

    // Wait for all validations to complete
    await Promise.all(validationPromises);

    const allValid = errors
      .map((error) => error.message?.length === 0)
      .every((status) => status === true);

    if (allValid) {
      setIsLoading(true);

      setErrors([]);

      api
        .get(VERIFY_EMAIL_OTP + `?userId=${userId}&OTP=${otp}`)
        .then(async (response) => {
          let loginData = response.data.data;
          console.log("loginData ", loginData);
          Toast.show({
            type: "success",
            text1: "OTP verified successfully.",
          });
          setIsLoading(false);
          setPasswordChangeStatus(PasswordChangeStatus.otpVerified);
        })
        .catch(async (e) => {
          // console.error(e);
          console.error(e.response);
          let errors = e.response?.data?.errors;
          if (errors) {
            console.error("errors -> ", errors);
            setErrors(errors);
          }
          setIsLoading(false);
          Toast.show({
            type: "error",
            text1: "Invalid credentials",
            text2: "Enter a valid otp",
          });
        });
    }
  };

  const changePassword = async () => {
    const validationPromises = Object.keys(fieldValidationStatus).map(
      (key) =>
        new Promise((resolve) => {
          // Resolve each validation status based on field key
          setFieldValidationStatus((prev: any) => ({
            ...prev,
            [key]: resolve,
          }));
        }),
    );

    setCanValidateField(true);

    // Wait for all validations to complete
    await Promise.all(validationPromises);

    const allValid = errors
      .map((error) => error.message?.length === 0)
      .every((status) => status === true);

    if (allValid) {
      setIsLoading(true);

      setErrors([]);

      const formData = new FormData();

      formData.append("newPassword", password);
      formData.append("confirmPassword", password);

      api
        .put(CHANGE_PASSWORD + `?userId=${userId}`, formData, {
          headers: {
            "Content-Type": "multipart/form-data",
          },
        })
        .then(async (response) => {
          let loginData = response.data.data;
          console.log("loginData ", loginData);
          Toast.show({
            type: "success",
            text1: "Password changed successfully",
          });
          setIsLoading(false);
          setPasswordChangeStatus(PasswordChangeStatus.none);
          router.replace("/(auth)/login");
        })
        .catch(async (e) => {
          // console.error(e);
          console.error(e.response);
          let errors = e.response?.data?.errors;
          if (errors) {
            console.error("errors -> ", errors);
            setErrors(errors);
          }
          setIsLoading(false);
          Toast.show({
            type: "error",
            text1: "Invalid password",
          });
        });
    }
  };

  return (
    <SafeAreaView>
      <View className="h-full">
        <Pressable
          onPress={() => {
            router.back();
          }}
        >
          <View className=" flex-row px-4 items-center">
            <MaterialIcons className="mt-4" name="arrow-back-ios" size={20} color="#009c68" />
            <Text className="text-primary-950 text-xl mt-4">{t('Login')}</Text>
          </View>
        </Pressable>
        <View className="p-4">
          {passwordChangeStatus === PasswordChangeStatus.none ? (
            <View>
              <Text className="text-2xl font-bold ">
                 <Text className="text-primary-950">{t('forgot_password')} </Text>🤔
              </Text>
              <Text className="color-gray-400 text-md mt-1 pe-4 leading-6">
                {t('enter_email')}
              </Text>
            </View>
          ) : passwordChangeStatus === PasswordChangeStatus.otpSent ? (
            <View>
              <Text className="text-2xl font-bold ">
               {t('verify')} <Text className="text-primary-950">{t('otp')}</Text>
              </Text>
              <Text className="color-gray-400 text-md mt-1 pe-4 leading-6">
                {t('otp_sent')}
              </Text>
              
            </View>
          ) : (
            <View>
              <Text className="text-2xl font-bold ">
                {t('change')} <Text className="text-primary-950">{t('password')}</Text>
              </Text>
              <Text className="color-gray-400 text-md mt-1 pe-4 leading-6">
               {t('enter_valid_password')}
              </Text>
            </View>
          )}
          <View
            className={`mt-6 ${passwordChangeStatus === PasswordChangeStatus.none ? "block" : "hidden"}`}
          >
            <PrimaryTextFormField
              fieldName="email"
              label={t('email')}
              placeholder="customer@business.com"
              errors={errors}
              setErrors={setErrors}
              min={8}
              keyboardType="email-address"
              filterExp={/^[A-Za-z0-9!#$%&'*+/=?^_{|}~.-@]*$/}
              canValidateField={canValidateField}
              setCanValidateField={setCanValidateField}
              setFieldValidationStatus={setFieldValidationStatus}
              validateFieldFunc={setFieldValidationStatusFunc}
              onChangeText={(value) => {
                setEmail(value);
              }}
            />
          </View>
          <View
            className={`mt-6 ${passwordChangeStatus === PasswordChangeStatus.otpSent ? "block" : "hidden"}`}
          >
            <PrimaryTextFormField
              fieldName="OTP"
              label="OTP"
              placeholder="******"
              errors={errors}
              setErrors={setErrors}
              min={
                passwordChangeStatus === PasswordChangeStatus.otpSent ? 5 : 0
              }
              max={
                passwordChangeStatus === PasswordChangeStatus.otpSent ? 6 : 0
              }
              isRequired={
                passwordChangeStatus === PasswordChangeStatus.otpSent
                  ? true
                  : false
              }
              defaultValue={otp}
              keyboardType="numeric"
              filterExp={/^[0-9]*$/}
              canValidateField={canValidateField}
              setCanValidateField={setCanValidateField}
              setFieldValidationStatus={setFieldValidationStatus}
              validateFieldFunc={setFieldValidationStatusFunc}
              onChangeText={(value) => {
                setOTP(value);
              }}
            />
          </View>
          <View
            className={`mt-6 ${passwordChangeStatus === PasswordChangeStatus.otpVerified ? "block" : "hidden"}`}
          >
            <PrimaryTextFormField
              inputType="password"
              fieldName="newPassword"
              label={('new password')}
              placeholder="•••••••••"
              errors={errors}
              setErrors={setErrors}
              min={
                passwordChangeStatus === PasswordChangeStatus.otpVerified
                  ? 8
                  : 0
              }
              isRequired={
                passwordChangeStatus === PasswordChangeStatus.otpVerified
                  ? true
                  : false
              }
              keyboardType="visible-password"
              // filterExp={/^[A-Za-z0-9!#$%&'*+/=?^_{|}~.-@]*$/}
              canValidateField={canValidateField}
              setCanValidateField={setCanValidateField}
              setFieldValidationStatus={setFieldValidationStatus}
              validateFieldFunc={setFieldValidationStatusFunc}
              onChangeText={(value) => {
                setPassword(value);
              }}
            />
            <PrimaryTextFormField
              className="mt-4"
              inputType="password"
              fieldName="confirmPassword"
              label="Confirm Password"
              placeholder="•••••••••"
              errors={errors}
              setErrors={setErrors}
              min={
                passwordChangeStatus === PasswordChangeStatus.otpVerified
                  ? 8
                  : 0
              }
              isRequired={
                passwordChangeStatus === PasswordChangeStatus.otpVerified
                  ? true
                  : false
              }
              keyboardType="visible-password"
              // filterExp={/^[A-Za-z0-9!#$%&'*+/=?^_{|}~.-@]*$/}
              canValidateField={canValidateField}
              setCanValidateField={setCanValidateField}
              setFieldValidationStatus={setFieldValidationStatus}
              validateFieldFunc={setFieldValidationStatusFunc}
              onChangeText={(value) => {
                setConfirmPassword(value);
              }}
            />
          </View>
          <SubmitButton
            className="mt-6"
            btnText={getButtonText()}
            isLoading={isLoading}
            onPress={() => {
              switch (passwordChangeStatus) {
                case PasswordChangeStatus.none:
                  sendOTP();
                  return;
                case PasswordChangeStatus.otpSent:
                  verifyOTP();
                  return;
                case PasswordChangeStatus.otpVerified:
                  changePassword();
                  return;
              }
            }}
          />
        </View>
      </View>
    </SafeAreaView>
  );
};

export default ForgotPassword;
