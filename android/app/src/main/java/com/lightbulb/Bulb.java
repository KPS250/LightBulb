package com.lightbulb;

import android.util.Log;
import android.widget.Toast;

import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;

public class Bulb extends ReactContextBaseJavaModule  {
    private Boolean isOn = false;
    private String location = "";

    public Bulb(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @ReactMethod
    public void getStatus(Callback successCallback) {
        successCallback.invoke(null, isOn);
    }

    @ReactMethod
    public void getLocation(Callback successCallback) {
        successCallback.invoke(null, location);
    }

    @ReactMethod
    public void turnOn() {
        isOn = true;
        System.out.println("Bulb is turn ON");
    }

    @ReactMethod
    public void turnOff() {
        isOn = false;
        System.out.println("Bulb is turn OFF");
    }

    @ReactMethod
    public void toast() {
        filllocation();
        Toast.makeText(this.getReactApplicationContext(), "Toast Aya", Toast.LENGTH_SHORT).show();
        System.out.println("Bulb is turn ON");
    }

    @ReactMethod
    public void filllocation() {
        GpsTracker gpsTracker = new GpsTracker(this.getReactApplicationContext());
        double latitude = gpsTracker.getLatitude();
        double longitude = gpsTracker.getLongitude();
        Log.d("LOC", latitude+"-"+longitude);
        location = latitude+"-"+longitude;
    }

    @Override
    public String getName() {
        return "Bulb";
    }

}