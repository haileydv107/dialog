dialog --title "系統提示" --msgbox "歡迎使用TUI進行管理者操作" 8 40;
# 紀錄操作人員
dialog --stdout --title "系統提示" --form "操作人員記錄，請輸入以下資訊：" 10 40 3 \
"Username: " 1 1 "" 1 15 10 0 \
"Employee ID: " 2 1 "" 2 15 6 0 \
"Department: " 3 1 "MIS" 3 15 20 0 \
| tee temp.txt >> operator.txt;
## 加入操作時間
current_time=$(date)
echo $current_time | tee -a temp.txt >> operator.txt;

## 顯示本次登入資訊
username=$(cat temp.txt | sed -n "1p")
employee_id=$(cat temp.txt | sed -n "2p")
department=$(cat temp.txt | sed -n "3p")
timestamp=$(cat temp.txt | sed -n "4p")
dialog --title "系統提示" --msgbox "本次操作管理者：\n\n 使用者名稱：$username \n 員工編號：$employee_id \n 所屬部門：$department \n 登入時間：$timestamp" 10 50;

# 重新進入網頁設定
function webpage_setting() {
    dialog --stdout --title "請選擇欲使用的網頁呈現" --radiolist "請使用方向鍵、空白鍵及enter鍵進行選擇" 15 40 2 \
        1 "phpsysinfo" on  \
        2 "商業空間" off > html_option.txt;

    html_option=$(cat html_option.txt)
    case $html_option in
        1)
            source ./launch_phpsysinfo.sh
        ;;
        2)
            source ./installapache.sh
        ;;
    esac
}


# 呼叫主選單
menu
admin_action=$(cat action_main.txt)
#1->網站管理 / 2->資料庫管理
case $admin_action in
    1)
        dialog --stdout --title "即將進入網站管理" --menu "※提醒：請確認已將當前網頁模板移除！" 10 50 2 1 "立即移除當前模板" 2 "已確認，繼續" > action_web.txt;
        action_web=$(cat action_web.txt)
        case $action_web in
            1)
                source ./undeploy_php.sh
                source ./removeapache.sh
                dialog --stdout --title "系統訊息" --msgbox "已移除當前網頁模板，點選確認進行網頁設定下一步" 10 50;
                webpage_setting
                dialog --stdout --title "系統訊息" --msgbox "已完成設定，其餘操作請重新登入。" 10 50;
            ;;
            2)
                dialog --stdout --title "系統提示" --msgbox "您已進入網站管理，你可以在此設定網頁畫面" 8 50;
                dialog --stdout --title "請選擇欲使用的網頁呈現" --radiolist "請使用方向鍵、空白鍵及enter鍵進行選擇" 15 50 2 1 "phpsysinfo" on  2 "商業空間" off > html_option.txt;
                html_option=$(cat html_option.txt)
                case $html_option in
                1)
                    source ./launch_phpsysinfo.sh
                    dialog --stdout --title "系統訊息" --msgbox "已完成設定，其餘操作請重新登入。" 10 50;
                ;;
                2)
                    source ./installapache.sh
                    dialog --stdout --title "系統訊息" --msgbox "已完成設定，其餘操作請重新登入。" 10 50;
                ;;
                esac
        esac
    ;;
    2)
        user=`dialog --stdout --inputbox "請輸入管理者帳號" 8 40`;
        passwd=`dialog --stdout --passwordbox "請輸入密碼：" 8 40 [<init>]`;
        dialog --stdout --yesno "是否進入mariadb？" 8 40;
        if [ $? -eq 0 ]; then
            echo ""
            mysql -u$user -hlocalhost -p$passwd -Dadmin_parameters
        else
            echo "您已取消本次操作，請重新執行"
        fi  
    ;;
esac
