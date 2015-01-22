# encoding: utf-8

module ChinaSMS
  module Service
    module Jianzhou
      extend self

      URL = "http://www.jianzhou.sh.cn/JianzhouSMSWSServer/http/sendBatchMessage"

      MESSAGES = {
        '-1'  => '余额不足',
        '-2'  => '账号或密码错误',
        '-3'  => '连接服务商失败',
        '-4'  => '超时',
        '-5'  => '其它错误，一般为网络问题，IP 受限等',
        '-6'  => '短信内容为空',
        '-7'  => '目标号码为空',
        '-8'  => '用户通道设置不对，需要设置三个通道',
        '-9'  => '捕获未知异常',
        '-10' => '超过最大定时时间限制',
        '-11' => '目标号码在黑名单里',
        '-12' => '消息内容包含禁用词语',
        '-13' => '没有权限使用该网关',
        '-14' => '找部到对应的 Channel ID',
        '-17' => '没有提交权限，客户端账号无法使用接口提交',
        '-18' => '提交参数名称不正确或缺少参数',
        '-19' => '必须为 POST 提交',
        '-20' => '超速提交（一般为每秒一次提交）'
      }

      def to(phone, content, options)
        res = Net::HTTP.post_form(URI.parse(URL), account: options[:username], password: options[:password], destmobile: phone, msgText: content)
        puts res.body
        result res.body
      end

      def result(code)
        {
          success: (code.to_i > 0),
          code: code,
          message: MESSAGES[code]
        }
      end
    end
  end
end
