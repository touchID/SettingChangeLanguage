import json
import time
import os
import requests
import logging
from datetime import datetime
from threading import Thread
from functools import partial
from flask import Flask, request, jsonify

app = Flask(__name__)

# 配置日志
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# 个人 翻译账号id
APP_ID = "20200518000460588"
SECURITY_KEY = "R1X8spgtcFtVIXbZsD6T"
# 公司 翻译账号id
APP_ID1 = "20200527000472923"
SECURITY_KEY1 = "eY3TqjB98VorUkJMNbRG"

# mac写入路径
realPathForMac = "/Volumes/Untitled/code/SettingChangeLanguage/SettingChangeLanguage/Resources/Localizables/"
# win写入路径
realPathForWin = "D:\\apache-tomcat-9.0.27\\Localizables\\"
# num
num = 0

FILE_UPLOAD_DIC = "/Volumes/Untitled/upload/"  # 上传文件的默认url前缀，根据部署设置自行修改

# 缓存文件路径
CACHE_FILE = "translation_cache.json"

# 读取缓存文件
def read_cache():
    if os.path.exists(CACHE_FILE):
        with open(CACHE_FILE, 'r', encoding='utf-8') as f:
            return json.load(f)
    return {}

# 写入缓存文件
def write_cache(cache):
    with open(CACHE_FILE, 'w', encoding='utf-8') as f:
        json.dump(cache, f, ensure_ascii=False, indent=4)

# 模拟 JobService
class JobService:
    @staticmethod
    def push(task):
        thread = Thread(target=task)
        thread.start()

# 模拟 JiGuangPushUtil
class JiGuangPushUtil:
    @staticmethod
    def pushNotice(alias, tag, content):
        logger.info(f"推送通知: {content}")

# 模拟 LCWriteUdidData
class LCWriteUdidData:
    @staticmethod
    def writeDataHubData(data, filePath, fileName):
        logger.info(f"写入数据到 {filePath}/{fileName}")

# 模拟 TransApi
class TransApi:
    def __init__(self, app_id, security_key):
        self.app_id = app_id
        self.security_key = security_key

    def getTransResult(self, query, from_lang, to_lang):
        # 这里只是模拟，实际需要调用百度翻译 API
        url = "http://api.fanyi.baidu.com/api/trans/vip/translate"
        salt = "1435660288"
        sign = self.app_id + query + salt + self.security_key
        import hashlib
        sign = hashlib.md5(sign.encode()).hexdigest()
        params = {
            "q": query,
            "from": from_lang,
            "to": to_lang,
            "appid": self.app_id,
            "salt": salt,
            "sign": sign
        }
        response = requests.get(url, params=params)
        return response.text

    @staticmethod
    def convert(result):
        return result

# 模拟 HttpGet
class HttpGet:
    @staticmethod
    def get(url, params):
        response = requests.get(url, params=params)
        return response.text

def baidutranslate(query, lang):
    isBaidu = False
    if isBaidu:
        api = TransApi(APP_ID1, SECURITY_KEY1)#公司
        api = TransApi(APP_ID, SECURITY_KEY)#个人
        desc = ""
        if lang.lower() == "zh":
            desc = TransApi.convert(api.getTransResult(query, "auto", "zh"))  # 中文
        elif lang.lower() == "cht":
            desc = TransApi.convert(api.getTransResult(query, "auto", "cht"))  # 繁体中文
        elif lang.lower() == "en":
            desc = TransApi.convert(api.getTransResult(query, "auto", "en"))  # 英文
        elif lang.lower() == "fra":
            desc = TransApi.convert(api.getTransResult(query, "auto", "fra"))  # 法语
        elif lang.lower() == "spa":
            desc = TransApi.convert(api.getTransResult(query, "auto", "spa"))  # 西班牙语
        else:
            desc = TransApi.convert(api.getTransResult(query, "auto", "zh"))  # 中文
        try:
            jobj = json.loads(desc)
            desc_ = jobj.get("trans_result")
            if desc_:
                temp = desc_[0]
                return temp.get("dst")
        except Exception as e:
            time.sleep(1)
            logger.info(f"翻译失败<<{query}>>为 baidu desc = {desc}")
            return ""

    # google fanyi
    try:
        if lang.lower() == "zh":
            return query
        desc = ""
        if lang.lower() == "zh":
            desc = "zh_cn"  # 中文
        elif lang.lower() == "cht":
            desc = "zh_tw"  # 繁体中文
        elif lang.lower() == "en":
            desc = "en"  # 英文
        elif lang.lower() == "fra":
            desc = "fr"  # 法语
        elif lang.lower() == "spa":
            desc = "es"  # 西班牙语
        else:
            desc = "zh_cn"  # 中文
        params = {
            "targetLang": desc,
            "text": query
        }
        result = HttpGet.get("http://18.162.56.208:8880/app/googleapitranslate.do", params)
        jobj = json.loads(result)
        desc_ = jobj.get("data")
        if desc_:
            newStr = desc_.replace("&#39;", "'")
            return newStr
    except Exception as e:
        time.sleep(1)
        logger.info(f"翻译失败<<{query}>>为 Google lang = {lang}")
        return ""

@app.route("/lcone/baidutranslate.do", methods=["GET"])
def baidutranslate_route():
    query = request.args.get("query")
    lang = request.args.get("lang")
    result = baidutranslate(query, lang)
    return result

def googletTranslate(query, lang):
    desc = ""
    if lang.lower() == "zh":
        desc = "zh-CN"  # 中文
    elif lang.lower() == "cht":
        desc = "zh-TW"  # 繁体中文
    elif lang.lower() == "en":
        desc = "en"  # 英文
    elif lang.lower() == "fra":
        desc = "fr"  # 法语
    elif lang.lower() == "spa":
        desc = "es"  # 西班牙语
    else:
        desc = "zh-CN"  # 中文
    try:
        params = {
            "q": query,
            "langpair": f"auto|{desc}"
        }
        return HttpGet.get("https://api.mymemory.translated.net/get", params)
    except Exception as e:
        time.sleep(1)
        logger.info(f"翻译失败<<{query}>>为 baidu desc = {desc}")
        return ""

@app.route("/lcone/fanyi/baidutranslate.do", methods=["GET"])
def baidutranslate1_route():
    query = request.args.get("query")
    lang = request.args.get("lang")
    responce = {
        "code": 200,
        "msg": ""
    }
    cache = read_cache()
    if query not in cache:
        cache[query] = {}
        JobService.push(partial(fanyi_job_task, query))
    else:
        res = cache[query].get(lang)
        if res:
            logger.info(f"缓存里有该数据 翻译为 {res}")
            responce["data"] = res
            return jsonify(responce)
    write_cache(cache)
    return jsonify(responce)

def fanyi_job_task(query):
    try:
        cache = read_cache()
        if query:
            date = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            JiGuangPushUtil.pushNotice("alias", "1", f"你有新翻译'{query}'任务，请及时处理{date}")
    except Exception as e:
        logger.error(e)

@app.route("/lcone/fanyi/startJobYi.do", methods=["GET"])
def startJobYi_route():
    global num
    try:
        logger.info(f"定时执行翻译任务时间: {datetime.now()} >> {num}")
        num += 1
        cache = read_cache()
        for query in cache.keys():
            if not all(cache[query].values()):
                fanyiJob1(query, 1)
        date = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        JiGuangPushUtil.pushNotice("alias", "1", f"你的翻译任务已经执行完毕，请及时查看{date}")
        logger.info(f"结束翻译任务定时任务时间: {datetime.now()} >> {num}")
        return jsonify({"result": len(cache)})
    except Exception as e:
        logger.error(e)
        return jsonify({"result": 0})

@app.route("/lcone/fanyi/all.do", methods=["GET"])
def translateResult_route():
    responce = {
        "code": 200,
        "msg": ""
    }
    langStrings = ["zh", "cht", "en", "fra", "spa"]
    start = time.time()
    for lang in langStrings:
        writeYiResultWithLang(lang)
    endStart = time.time() - start
    logger.info(f"写入Localizable文件耗时：*********{endStart * 1000}毫秒")
    return jsonify(responce)

def writeYiResultWithLang(lang):
    responce = {
        "code": 200,
        "msg": ""
    }
    cache = read_cache()
    resultTempArr = []
    for query, translations in cache.items():
        tempString = f'"{query}" = "{translations.get(lang, "")}";'
        resultTempArr.append(tempString)
    if not lang:
        responce["code"] = -1000
        responce["msg"] = "query不能为空"
        return responce
    if not lang:
        responce["code"] = -1000
        responce["msg"] = "lang不能为空"
        return responce
    responce["data"] = resultTempArr
    filePath = "/Users/luchao/Desktop"
    if "windows" in str(request.user_agent).lower():
        filePath = realPathForWin
    else:
        filePath = realPathForMac
    # 获取当前路径
    filePath = os.path.abspath(os.path.dirname(__file__))

    if lang.lower() == "zh":
        filePath = f"{filePath}zh-Hans.lproj"
    elif lang.lower() == "cht":
        filePath = f"{filePath}zh-Hant.lproj"
    elif lang.lower() == "en":
        filePath = f"{filePath}en.lproj"
    elif lang.lower() == "fra":
        filePath = f"{filePath}fr.lproj"
    elif lang.lower() == "spa":
        filePath = f"{filePath}es.lproj"
    else:
        filePath = f"{filePath}zh-Hant.lproj"
    LCWriteUdidData.writeDataHubData(resultTempArr, filePath, "Localizable.strings")
    return responce

def fanyiJob1(query, isJob2):
    if not query:
        return
    try:
        start = time.time()
        result01 = baidutranslate(query, "zh")
        time.sleep(2)
        result02 = baidutranslate(query, "cht")
        time.sleep(2)
        result03 = baidutranslate(query, "en")
        time.sleep(2)
        result04 = baidutranslate(query, "fra")
        time.sleep(2)
        result05 = baidutranslate(query, "spa")
        time.sleep(2)
        logger.info(f"翻译结果: {result01}")
        logger.info(f"翻译结果: {result02}")
        logger.info(f"翻译结果: {result03}")
        logger.info(f"翻译结果: {result04}")
        logger.info(f"翻译结果: {result05}")
        if result01 and result02 and result03 and result04 and result05:
            try:
                cache = read_cache()
                cache[query] = {
                    "zh": result01,
                    "cht": result02,
                    "en": result03,
                    "fra": result04,
                    "spa": result05
                }
                write_cache(cache)
                endStart = time.time() - start
                logger.info(f"翻译耗时：*********{endStart * 1000}毫秒")
                if isJob2 == 1:
                    translateResult_route()
            except Exception as e:
                logger.error(e)
    except Exception as e:
        logger.error(e)

if __name__ == "__main__":
    app.run(debug=True)
