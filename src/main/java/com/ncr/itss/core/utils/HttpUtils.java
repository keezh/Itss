package com.ncr.itss.core.utils;

import org.apache.commons.httpclient.params.DefaultHttpParams;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.config.CookieSpecs;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.config.Registry;
import org.apache.http.config.RegistryBuilder;
import org.apache.http.cookie.*;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.cookie.BestMatchSpecFactory;
import org.apache.http.impl.cookie.BrowserCompatSpec;
import org.apache.http.impl.cookie.BrowserCompatSpecFactory;
import org.apache.http.protocol.HttpContext;
import org.apache.http.util.EntityUtils;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

/**
 * @author kee
 */
public class HttpUtils {
    /**
     * 发送get请求
     *
     * @return
     * @throws IOException
     */
    public static String get(String url) throws IOException {
        DefaultHttpParams.getDefaultParams().setParameter("http.protocol.cookie-policy", CookieSpecs.BROWSER_COMPATIBILITY);
        CookieSpecProvider easySpecProvider = new CookieSpecProvider() {
            @Override
            public CookieSpec create(HttpContext context) {
                return new BrowserCompatSpec() {
                    @Override
                    public void validate(Cookie cookie, CookieOrigin origin)
                            throws MalformedCookieException {
                    }
                };
            }
        };

        BasicCookieStore cookieStore = new BasicCookieStore();

        Registry<CookieSpecProvider> registry = RegistryBuilder
                .<CookieSpecProvider>create()
                .register(CookieSpecs.BEST_MATCH, new BestMatchSpecFactory())
                .register(CookieSpecs.BROWSER_COMPATIBILITY,
                        new BrowserCompatSpecFactory())
                .register("easy", easySpecProvider).build();

        RequestConfig requestConfig = RequestConfig.custom()
                .setCookieSpec("easy").setSocketTimeout(10000)
                .setConnectTimeout(10000).build();

        CloseableHttpClient httpclient = HttpClients.custom()
                .setDefaultCookieSpecRegistry(registry)
                .setDefaultRequestConfig(requestConfig)
                .setDefaultCookieStore(cookieStore)

                .build();

        HttpGet httpGet = new HttpGet(url);

        String result = null;
        try (CloseableHttpResponse response = httpclient.execute(httpGet)) {

            HttpEntity entity = response.getEntity();
            InputStream inputStream = entity.getContent();
            result = parse(inputStream);

            EntityUtils.consume(entity);
        } catch (
                IOException e
                )

        {
            e.printStackTrace();
        }

        return result;
    }


    public static void main(String[] args) {
        String url = "";
        try {
            List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();

            System.out.println("get(url) = " + post(url, nameValuePairs));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    /**
     * 发送post请求
     * List<NameValuePair> nvps = new ArrayList<NameValuePair>();
     * nvps.add(new BasicNameValuePair("username", "vip"));
     * nvps.add(new BasicNameValuePair("password", "secret"));
     */
    public static String post(String url, List<NameValuePair> nameValuePairList) throws IOException {
        CloseableHttpClient httpclient = HttpClients.createDefault();

        HttpPost httpPost = new HttpPost(url);
        String result = null;

        CloseableHttpResponse response = null;
        try {

            httpPost.setEntity(new UrlEncodedFormEntity(nameValuePairList, "utf-8"));
            response = httpclient.execute(httpPost);
            HttpEntity entity = response.getEntity();
            InputStream inputStream = entity.getContent();
            result = parse(inputStream);

            EntityUtils.consume(entity);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            assert response != null;
            response.close();
        }
        return result;
    }

    /**
     * 发送post请求
     */
    public static String post(String url, StringEntity stringEntity) throws IOException {
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost(url);
        String result = null;
        CloseableHttpResponse response = null;
        try {
            httpPost.setEntity(stringEntity);
            response = httpclient.execute(httpPost);
            HttpEntity entity = response.getEntity();
            InputStream inputStream = entity.getContent();
            result = parse(inputStream);

            EntityUtils.consume(entity);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            assert response != null;
            response.close();
        }
        return result;
    }

    /**
     * 将流转换为字符串
     *
     * @param inputStream
     * @return
     */
    private static String parse(InputStream inputStream) {
        String result = null;
        BufferedReader reader = null;
        try {
            reader = new BufferedReader(new InputStreamReader(inputStream,"utf-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        StringBuilder sb = new StringBuilder();
        String line;
        try {
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        result = sb.toString();
        return result;
    }

}
