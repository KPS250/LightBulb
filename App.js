import React, {Component} from 'react';
import {
  StyleSheet,
  Text,
  View,
  Button,
  Image,
  TouchableOpacity,
  NativeModules,
  requireNativeComponent,
} from 'react-native';

//const BulbView = requireNativeComponent('BulbView');

export default class App extends Component {
  constructor(props) {
    super(props);
    this._onStatusChange = this._onStatusChange.bind(this);
    this.state = {
      bulbOn: false,
    };
  }

  render() {
    return (
      <View style={styles.container}>
        <TouchableOpacity onPress={() => this.turnOn()}>
          <Image
            source={
              this.state.bulbOn
                ? require('./assets/bulb_on.png')
                : require('./assets/bulb_off.png')
            }
          />
        </TouchableOpacity>
        {/*<BulbView
          style={styles.bottom}
          isOn={this.state.bulbOn}
          onStatusChange={this._onStatusChange}
        />*/}
      </View>
    );
  }

  _onStatusChange = e => {
    this.setState({bulbOn: e.nativeEvent.isOn});
  };

  turnOn = () => {
    if (this.state.bulbOn) {
      this.setState({bulbOn: false});
      NativeModules.Bulb.turnOff();
      NativeModules.Bulb.toast();
    } else {
      this.setState({bulbOn: true});
      NativeModules.Bulb.turnOn();
      NativeModules.Bulb.toast();
    }
    NativeModules.Bulb.getLocation(this.location);
  };

  location =(x, loc) => {
    // eslint-disable-next-line no-alert
    alert(loc);
  };
}

const styles = StyleSheet.create({
  container: {
    //flex:1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'yellow',
  },
  top: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  bottom: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'blue',
    height: 100,
    width: 200,
  },
});
