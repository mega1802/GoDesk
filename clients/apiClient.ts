import axios, { AxiosError } from "axios";
import { BASE_URL } from "@/config/env";
import { AUTH_TOKEN_KEY, REFRESH_TOKEN_KEY } from "@/constants/storage_keys";
import { getItem, setItem } from "@/utils/secure_store";

const apiClient = axios.create({
  baseURL: BASE_URL,
  headers: {
    "Content-Type": "application/json",
  },
});

apiClient.interceptors.request.use(
  async (config) => {
    // await setItem(
    //   AUTH_TOKEN_KEY,
    //   "eyJhbGciOiJIUzUxMiJ9.eyJwYXNzd29yZCI6IjB6bHBrRko0SVRWZWhXSDNSeXRVTVByRTl3VlNHcUdaUUF3djRSNnIvOEk9Iiwicm9sZSI6WyJGSUVMRF9FTkdJTkVFUiJdLCJpZCI6IjliYTA0OWQxLTFiNTEtNGNlMS05MzkyLTViYTUyZjE1NWY0OSIsInVzZXJPcmdEZXRhaWxzIjp7ImxlYWRJZCI6ImUwZmJlZmNiLTFiZWYtNDhhNy1hNmVmLTlmZThhZTczYzk3ZiIsIm9yZ0lkIjoiYjBiYzhiZTUtZTRlYi00NTAzLWE4MTMtMTNiOTdiNzZjNzczIiwib3JnRGVwYXJ0bWVudElkIjoiMjUxMWI0NGQtOTE1ZC00NTM1LTliNzgtMGVjNTkyYzBhMDFjIiwib3JnRGVzaWduYXRpb25JZCI6IjY1MWYwYjNjLWM3ZDAtNGQyNi05NzEwLWE0NGJiZGFlMWQyZCJ9LCJlbWFpbCI6ImJoYXJhdGlwYXJpdDRAZ21haWwuY29tIiwidXNlcm5hbWUiOiJNZWdoYSIsInN1YiI6ImJoYXJhdGlwYXJpdDRAZ21haWwuY29tIiwiaWF0IjoxNzM0Nzg2NzI5LCJleHAiOjE3MzQ4MTU1Mjl9.JZkTgC6-0hmndb2BnOuNeoOreEl7wtQjlhhRBrbeZTSZOkxatbOIEtdwAkNhDmUoF8auB3aCl7ceiOE-0hHgEQ");
    let token = await getItem(AUTH_TOKEN_KEY);
    if (token) {
      try {
        console.log("BASE_URL", BASE_URL);
        
        await axios.post(BASE_URL + `/login/validate?token=${token}`, {});
        // console.log(validateResponse);
      } catch (e) {
        if (e instanceof AxiosError) {
          console.error("token invalid", e.response?.data);
        }
        try {
          const refreshToken = await getItem(REFRESH_TOKEN_KEY);
          console.log("refreshToken", refreshToken);
          const response = await axios.post(BASE_URL + "/auth/refresh-token", {
            token: refreshToken,
          });
          const newToken = response.data.token;
          await setItem(AUTH_TOKEN_KEY, newToken);
          token = newToken;
        } catch (e) {
          console.error("Refresh token error");
          if (e && e instanceof AxiosError) {
            console.log(e.response?.data);
          }
        }
      }
      config.headers.Authorization = `Bearer ${token}`;
    }
    console.log("no token", token);
    
    return config;
  },
  (error) => {
    console.log("error ->>>>>>>>>>>>>>>>>>>", error);
    return Promise.reject(error);
  },
);

export default apiClient;
