import { SafeAreaView } from "react-native-safe-area-context";
import { Keyboard, KeyboardAvoidingView, Linking, Platform, Pressable, ScrollView, Text, TouchableWithoutFeedback, View } from "react-native";
import { VStack } from "@/components/ui/vstack";
import { Link, useRouter } from "expo-router";
import { useState ,useEffect} from "react";
import {
  GET_CUSTOMER_LEAD_DETAILS,
  GET_USER_DETAILS,
  LOGIN,
} from "@/constants/api_endpoints";
import api from "@/services/api";
import { ApiResponseModel, ErrorModel } from "@/models/common";
import SubmitButton from "@/components/SubmitButton";
import {
  AUTH_TOKEN_KEY,
  CUSTOMER_LEAD_ID,
  IS_LEAD,
  REFRESH_TOKEN_KEY,
} from "@/constants/storage_keys";
import { clearStorage, setItem } from "@/utils/secure_store";
import { CUSTOMER_LEAD_ACTIVE } from "@/constants/configuration_keys";
import { CustomerLeadDetailsModel } from "@/models/customers";
import Toast from "react-native-toast-message";
import PrimaryTextFormField from "@/components/fields/PrimaryTextFormField";
import { UserDetailsModel } from "@/models/users";
import React from "react";
import { useTranslation } from 'react-i18next';  // Import the translation hook
import AsyncStorage from '@react-native-async-storage/async-storage';

const LoginScreen = () => {
  const [email, setEmail] = useState<string>("");
  const [password, setPassword] = useState<string>("");

  const [errors, setErrors] = useState<ErrorModel[]>([]);

  const [isLoading, setIsLoading] = useState(false);

  const router = useRouter();
  const { t, i18n } = useTranslation(); 
  const [selectedLanguage, setSelectedLanguage] = useState('en');
  // can validate fields
  const [canValidateField, setCanValidateField] = useState(false);

  const [fieldValidationStatus, setFieldValidationStatus] = useState<any>({});

  const login = async () => {
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

      let data = {
        email: email,
        password: password,
      };

      setErrors([]);

      api
        .post(LOGIN, data)
        .then(async (response) => {
          let loginData = response.data.data;
          console.log("loginData ", loginData);

          await setItem(AUTH_TOKEN_KEY, loginData.token);
          await setItem(REFRESH_TOKEN_KEY, loginData.refreshToken);
          await setItem(IS_LEAD, "false");

          if (loginData) {
            try {
              let leadResponse =
                await api.get<ApiResponseModel<UserDetailsModel>>(
                  GET_USER_DETAILS,
                );
              let data = leadResponse.data.data ?? {};
              console.log("customerData", data);

              if (data && data.id) {
                let leadStatus = data.statusDetails?.key;
                console.log("=+++_+_+_)+_+_+_+_", leadStatus);

                await setItem(CUSTOMER_LEAD_ID, data.id);

                if (leadStatus === CUSTOMER_LEAD_ACTIVE) {
                  await setItem(IS_LEAD, "false");
                  router.replace({ pathname: "/home" });
                } else {
                  let userType = data.userTypeDetails?.key;
                  if (userType === "CUSTOMER") {
                    await setItem(IS_LEAD, "true");
                    router.replace({
                      pathname: "/(auth)/registration/[customerLeadId]",
                      params: { customerLeadId: data.id },
                    });
                  } else {
                    await clearStorage();
                    Toast.show({
                      type: "error",
                      text1: "Account activation",
                      text2:
                        "Your account is not activated to login, please contact your admin",
                    });
                  }
                }
                setIsLoading(false);
              } else {
                const customerLeadResponse = await api.get<
                  ApiResponseModel<CustomerLeadDetailsModel>
                >(GET_CUSTOMER_LEAD_DETAILS);
                const customerData = customerLeadResponse.data?.data;
                if (customerData) {
                  const customerLeadStatus =
                    customerData.onBoardingStatusDetails?.key;
                  await setItem(CUSTOMER_LEAD_ID, customerData.id ?? "");
                  if (customerLeadStatus === CUSTOMER_LEAD_ACTIVE) {
                    await setItem(IS_LEAD, "false");
                    router.replace({ pathname: "/(root)/home" });
                  } else {
                    await setItem(IS_LEAD, "true");
                    Toast.show({
                      type: "error",
                      text1: "Complete Registration",
                    });
                    router.replace({
                      pathname: "/(auth)/registration/[customerLeadId]",
                      params: { customerLeadId: customerData.id ?? "" },
                    });
                  }
                } else {
                  await clearStorage();
                  Toast.show({
                    type: "error",
                    text1: "Invalid credentials",
                    text2: "Enter a valid email and password",
                  });
                }
                setIsLoading(false);
              }
            } catch (e) {
              console.error(e);
              const customerLeadResponse = await api.get<
                ApiResponseModel<CustomerLeadDetailsModel>
              >(GET_CUSTOMER_LEAD_DETAILS);
              const customerData = customerLeadResponse.data?.data;
              if (customerData) {
                const customerLeadStatus =
                  customerData.onBoardingStatusDetails?.key;
                await setItem(CUSTOMER_LEAD_ID, customerData.id ?? "");
                if (customerLeadStatus === CUSTOMER_LEAD_ACTIVE) {
                  await setItem(IS_LEAD, "false");
                  router.replace({ pathname: "/home" });
                } else {
                  await setItem(IS_LEAD, "true");
                  Toast.show({
                    type: "error",
                    text1: "Complete Registration",
                  });
                  router.replace({
                    pathname: "/(auth)/registration/[customerLeadId]",
                    params: { customerLeadId: customerData.id ?? "" },
                  });
                }
              } else {
                await clearStorage();
                Toast.show({
                  type: "error",
                  text1: "Invalid credentials",
                  text2: "Enter a valid email and password",
                });
              }
              setIsLoading(false);
            }
          } else {
            setIsLoading(false);
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
          await clearStorage();
          Toast.show({
            type: "error",
            text1: "Invalid credentials",
            text2: "Enter a valid email and password",
          });
        });
    }
  };
  useEffect(() => {
    const fetchLanguage = async () => {
      const storedLanguage = await AsyncStorage.getItem('language');
      if (storedLanguage) {
        setSelectedLanguage(storedLanguage);
        i18n.changeLanguage(storedLanguage); // Set language from AsyncStorage
      }
    };

    fetchLanguage();
  }, []);
  const setFieldValidationStatusFunc = (
    fieldName: string,
    isValid: boolean,
  ) => {
    if (fieldValidationStatus[fieldName]) {
      fieldValidationStatus[fieldName](isValid);
    }
  };

  return (
    <KeyboardAvoidingView
      className="flex-1"
      behavior={Platform.OS === "ios" ? "padding" : "height"}
    >
      <TouchableWithoutFeedback onPress={Keyboard.dismiss}>
        <View className="flex justify-between pb-14 h-full">
          <ScrollView>
            <View className="mt-2 p-4 h-full">
              <Text className="font-bold text-2xl text-primary-950">
              {t('welcome')} 👋
              </Text>
              <Text className="mt-1 text-md leading-6 color-gray-400 pe-4">
               {t('login_message')}
              </Text>
              <Text><Link href={'/data_storage/homescreen'} >language</Link></Text>
             
              <View className="gap-4 mt-4">
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
                  // customValidations={(value) => {
                  //   const customRE = /^[\w\.-]+@[a-zA-Z\d-]+(\.[a-zA-Z\d-]+)*\.[a-zA-Z]{2}$/;
                  //   if (!customRE.test(value)) {
                  //     return "Please enter a valid email";
                  //   }
                  //   return undefined;
                  // }}
                  onChangeText={(value) => {
                    setEmail(value);
                  }}
                />
                <PrimaryTextFormField
                  inputType="password"
                  fieldName="password"
                  label={t('password')}
                  placeholder="•••••••••"
                  errors={errors}
                  setErrors={setErrors}
                  min={8}
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
                <Pressable
                  onPress={() => {
                    router.push("/forgot_password");
                  }}
                >
                  <View className="flex-row justify-end items-end">
                    <Text className="font-semibold text-end text-primary-950 text-sm">
                      {t('forgot_password')}
                    </Text>
                  </View>
                </Pressable>
                <SubmitButton
                  btnText={t('Login')}
                  isLoading={isLoading}
                  onPress={login}
                />
                {Platform.OS === "ios" ? (
                  <Text className="mt-4 px-12 text-center text-sm">
                    {/* To register your organization contact GoDesk Workplace Admin */}
                    {/* <Text
                  onPress={() => {
                    Linking.openURL("https://workplace.godesk.co.in/login");
                  }}
                  className="font-bold text-primary-950"
                >
                  GoDesk Admin
                </Text> */}
                  </Text>
                ) : (
                  <Text className=" text-center text-sm">
                    {t('dont_have_account')}{" "}
                    <Link
                      href="/registration/null"
                      className="font-bold underline color-secondary-950"
                    >
                     {t('register_now')}
                    </Link>
                  </Text>
                )}
              </View>
            </View>
          </ScrollView>
          <Text className="px-12 text-center  text-sm">
          {t('loginAgreement')}{" "}
            <Text
              onPress={() => {
                Linking.openURL("https://godesk.co.in/Privacy_Policy.html");
              }}
              className="font-bold text-primary-950"
            >
              {t("terms_conditions")}
            </Text>{" "}
            {t('and')}{" "}
            <Text
              onPress={() => {
                Linking.openURL("https://godesk.co.in/Privacy_Policy.html");
              }}
              className="font-bold text-primary-950"
            >
              {t("privacy_policy")}
            </Text>
          </Text>
        </View>
      </TouchableWithoutFeedback>
    </KeyboardAvoidingView>
  );
};

export default LoginScreen;
