import React from 'react';
import {
      AppRegistry,
      StyleSheet,
      NativeModules,
      NativeAppEventEmitter,
      TouchableHighlight,
      UIManager,
      Dimensions,
      Text,
      View
} from 'react-native';
import MapView from './MapView';


const { width, height } = Dimensions.get('window');



class index extends React.Component {



    componentDidMount() {
        this.subscription = NativeAppEventEmitter.addListener(
            'EventReminder',
            (reminder) => {
                console.log('接收到iOS发送的事件', reminder);
            }
        );
        console.log('componentDidMount this.subscription', this.subscription);
    }



    componenntWillUnmount() {
        this.subscription && this.subscription.remove();
    }



    onAddEvent = () => {
        NativeModules.CalendarManager.addEvent('秦真', {
            location: '上海',
            time: new Date().getTime(),
            description: '随便说点什么！'
        });
    }



    onFindEvents = () => {
        // NativeModules.CalendarManager.findEvents((error, result) => {
        //     if (error) {
        //         console.error('findEvents', error);
        //     } else {
        //         console.log('result', result);
        //     }
        // });

        NativeModules.CalendarManager.findEvents(result => {
            if (result) {
                alert(result.length + '条记录');
            }
        })
    }



    // 下面两种方法都可以
    // 方法1
    // onFindEventWithPromise = async() => {
    //     try {
    //         var events = await NativeModules.CalendarManager.findEvents2();
    //         console.log('resolve', events);
    //     } catch(e) {
    //         console.log('reject', e);
    //     }
    // }
    // 方法2
    onFindEventWithPromise = () => {
        NativeModules.CalendarManager.findEvents2().then(result => {
            console.log('resolve', result);
            alert('调用成功，请在Debug模式下查看，Chrome 控制台输出');
        }, error => {
            console.log('reject', error);
        });
    }


    render() {
        console.log('UIManager', UIManager)
        var region = {
            latitude: 37.48,
            longitude: -122.16,
            latitudeDelta: 0.1,
            longitudeDelta: 0.1
        };
        return (
            <View style={styles.container}>

                <Text style={styles.week}>常量导出：{NativeModules.CalendarManager.firstDayOfTheWeek} － {NativeModules.CalendarManager.lastDayOfTheWeek}</Text>

                <Text style={styles.week}>枚举导出: {NativeModules.CalendarManager.statusBarAnimationSlide} － {NativeModules.CalendarManager.statusBarAnimationFade}</Text>

                <TouchableHighlight style={styles.btn} onPress={this.onAddEvent}>
                    <Text style={styles.btnText}>调用原生带参方法</Text>
                </TouchableHighlight>

                <TouchableHighlight style={styles.btn} onPress={this.onFindEvents}>
                    <Text style={styles.btnText}>调用原生带回调函数方法</Text>
                </TouchableHighlight>

                <TouchableHighlight style={styles.btn} onPress={this.onFindEventWithPromise}>
                    <Text style={styles.btnText}>调用原生带回调函数方法(Promise)</Text>
                </TouchableHighlight>

                <TouchableHighlight style={styles.btn} onPress={() => NativeModules.CalendarManager.VCOpenRN({name:'A'})}>
                    <Text style={styles.btnText}>调用返回事件</Text>
                </TouchableHighlight>

                <MapView
                    style={styles.mapView}
                    pitchEnabled={false}
                    region={region}
                    onRegionChange={this.onChange}
                />

                <TouchableHighlight style={styles.btn} onPress={this.goNative}>
                    <Text style={styles.btnText}>前往原生界面</Text>
                </TouchableHighlight>

            </View>
        );
    }


    goNative = (e) => {
        // NativeModules.RootViewController.goToNative();
        NativeModules.AppDelegate.toNative();
    }


    onChange = (event: Event) => {
        console.log('onChange ', event.nativeEvent.region);
        // region: {
        //     latitude: 37.47166620156466
        //     latitudeDelta: 0.1000111518249724
        //     longitude: -122.1606300675163
        //     longitudeDelta: 0.1575168790815269
        // }
    }


}


const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#F5FCFF',
    },
    btn: {
        height: 45,
        width: width - 40,
        marginVertical: 5,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor:'green',
        borderRadius: 5
    },
    btnText: {
        color: '#FFF'
    },
    week: {
        fontSize:16,
        color: 'purple'
    },
    mapView: {
        width,
        height: 200,
        borderWidth: 1,
        borderColor: 'gray'
    }
});


export default index;