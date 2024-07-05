Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA475145A11
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Jul 2024 21:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720214108; cv=none; b=ChiV1zZ7WotuavtNp4Gao5SdMs2vA8FTAIN7Roelwqlu2CNpp3AMFYh7OE6Vnm5U020JXxDtdb9Ty+oEmMPTWqldhCxnafkYuGQecOjRCQydaHVZstyu3FviU0wmax8VXglmGc1EdYREoMRkpaV4MJ0u2VXrols6yoJFi7P4dC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720214108; c=relaxed/simple;
	bh=jw8m2Q8SxhikYPSpGO5e6XgC5WWnQALTy43ul0xbcKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CwAIXI482SaiEkKw1VA8X1mtUFxQwqNQPK5hPwkhYQnlU60jzsHfG9b6bAK11egg6MO/o6BjKDf0GD7JA2ADKThG+WposqE/QMhgseZgygowWQh4DmlqLxcVhEOOlOc7F0xbz1YhoMrREiOyJWuz87OMTYuchsNe4ak5BkQQLgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aa3WSvXw; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aa3WSvXw"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52e9c6b5a62so2157950e87.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Jul 2024 14:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720214104; x=1720818904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uip5gtsGJN8be4BC5gcYviodP+GbV+3zApaZVxbcrG0=;
        b=aa3WSvXwKfk2cM5qh8zsVYPHpfpgTV90tdCC0tNLQkChiZboaoTTZEWNASP84VARuY
         rx9xlEUpapxJGQhfz9gdqfJ9JooIUyvX3L13mOQONe1xXqRWmCUa1hiX4I9qsyVjDIOp
         /xV6JoyfEBovzAWHyXOwDrHY+qfUXBJfr5EfugzgNaWRvEqOzV8ZEZzxoRDDgMQSONkC
         VJ0Rp7eAewCDjywtkjAzbI8LOAx+S+LLoBi1LvIy43V4xN7P8vv4/4yr9hEhDM2V1XS7
         srFestvnQ4DyoSMWMcyEfdBCkQoJsFS9Hm3P6BayHuZxdR1Wutp/eJLkUzLZ90K0DJOo
         XCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720214104; x=1720818904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uip5gtsGJN8be4BC5gcYviodP+GbV+3zApaZVxbcrG0=;
        b=ucA8cgjZFY23ZEXBT7rakDyc/q8j/2vdn2/vH2jm1QAO3fyQNPcHVRkpnFh139agWL
         6xpct91ddQ1+LxRIaNCczgrIMAZXbQqmZFFSVD/zW48NFgG0kS7eISvlbn1o9BOxlcZv
         0zMHL8joEq3/pyDRyrL3T7jLaEb3cYXVzBeHiQFS7h5abLfto4rCIDzwxVV1qyC2zTUU
         5FLVppPO6lhyklVbsbGwpFr3/podVxqOZEY7P56lbzkJ3tyryau0oJL0D7yLvxipBWde
         K+HDcziIxBZnTf6hDJ3VOhWhlwu+6n5mAmS3TQYj0yzkmrd/KUXIj5Umw7CoIteMmZuN
         lLtA==
X-Forwarded-Encrypted: i=1; AJvYcCXa/eE6tSSMTKK/pVofSU83XyzccAyDlq9PRM6A7/v6+/f8Pp2lGlS40zEtoSbgCZdaNBbr27jnnDvPjaA+iaIhuNPPm68Eyu2Z3j+2HuqECNmY
X-Gm-Message-State: AOJu0YxoMbldzF3mdxHe6BOFLNCdcfkVya6iFWA+wdFIAdA7+2Lc3rax
	RVrJHNiczgcmbqIYjcldZ1AxDJU3psE8o6atwfdRF4hNo/JeFpNRcdteJ9wMeug=
X-Google-Smtp-Source: AGHT+IF5Ap1gpOOKIeYhmDrnv6TWcHQ27uju4b+P8Pp6OHSdvTAizrxr2T6HxI9xOc7L/vWCVEbRCA==
X-Received: by 2002:a05:6512:3e19:b0:52c:86d6:e8d7 with SMTP id 2adb3069b0e04-52ea0636acemr5778613e87.13.1720214103948;
        Fri, 05 Jul 2024 14:15:03 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72b033f3a3sm682994666b.187.2024.07.05.14.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 14:15:03 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] pwm: Make info in traces about affected pwm more useful
Date: Fri,  5 Jul 2024 23:14:51 +0200
Message-ID: <20240705211452.1157967-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1550; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=jw8m2Q8SxhikYPSpGO5e6XgC5WWnQALTy43ul0xbcKU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmiGJMK+QFWU9D9g3FagOCuuzwOs8vNO0cfgd/4 u1BgUtRureJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZohiTAAKCRCPgPtYfRL+ TtWIB/47LiQT3BQPF/H6bE9LJozKnweLcc29sF5trcTNndjr5H8CUkx8w9HAnxYoEThOASjHdML Owm3rvh9J3a5DrMetpHDEAPKfBWb8lUvF5yw7CN8tHa2EdHyDx42jiiljw6JPxhi2JqfFXwpz10 mWfdFOzQPAix9qzPSCHdB9BB+sLUuhNjIeaeaxjeOkH/jIsKSEno8xrvzaiYgkxOE/RxoaGQPNE dS0xiZv5KsSQReNYqOnGM6Rr8mXK2vLCNrLtc1XfzS4JFv47oGCLzPm0STGwGaJ30XlYC+hF154 s/dVGZoOr4KVsb7yEq71+3sH0iokiACknr65DkyJOQxha9gU
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The hashed pointer isn't useful to identify the pwm device. Instead
store and emit chipid and hwpwm.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 include/trace/events/pwm.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/pwm.h b/include/trace/events/pwm.h
index 12b35e4ff917..8022701c446d 100644
--- a/include/trace/events/pwm.h
+++ b/include/trace/events/pwm.h
@@ -15,7 +15,8 @@ DECLARE_EVENT_CLASS(pwm,
 	TP_ARGS(pwm, state, err),
 
 	TP_STRUCT__entry(
-		__field(struct pwm_device *, pwm)
+		__field(unsigned int, chipid)
+		__field(unsigned int, hwpwm)
 		__field(u64, period)
 		__field(u64, duty_cycle)
 		__field(enum pwm_polarity, polarity)
@@ -24,7 +25,8 @@ DECLARE_EVENT_CLASS(pwm,
 	),
 
 	TP_fast_assign(
-		__entry->pwm = pwm;
+		__entry->chipid = pwm->chip->id;
+		__entry->hwpwm = pwm->hwpwm;
 		__entry->period = state->period;
 		__entry->duty_cycle = state->duty_cycle;
 		__entry->polarity = state->polarity;
@@ -32,8 +34,8 @@ DECLARE_EVENT_CLASS(pwm,
 		__entry->err = err;
 	),
 
-	TP_printk("%p: period=%llu duty_cycle=%llu polarity=%d enabled=%d err=%d",
-		  __entry->pwm, __entry->period, __entry->duty_cycle,
+	TP_printk("pwmchip%u.%u: period=%llu duty_cycle=%llu polarity=%d enabled=%d err=%d",
+		  __entry->chipid, __entry->hwpwm, __entry->period, __entry->duty_cycle,
 		  __entry->polarity, __entry->enabled, __entry->err)
 
 );

base-commit: 6ba37c70795abf1d59976b3a49acafac14b72a4f
-- 
2.43.0

