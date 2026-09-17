Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30C333BBC5
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Sep 2026 01:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610142; cv=none; b=dtrkMpgiuK2ja6+2SM3naDKnM5d+3YE+Td6uD3CPjTc37czrHN9jeDhh/Wyiefw+vl4GlrSzEESEtWF21hduaEwYgqlac5h0pxH2O9AD0jvU9C5TBdG30I6ZukvNd+piCNJlF1IK6i22tDaw5L+40HYN+7ybiQmxR6Rv9OpLYhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610142; c=relaxed/simple;
	bh=huK5NMhjr2x4b93vE/ihBE517KG4j4GmxK1igWLRb1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ec/FBs7+FBpWCmG2R2TQi/r7pJRBKWN8ZfYmHKfl+lcILlq5ymh+RjBUeLtWUu1E7jd4GYvvHNsHnaE0p0apbgbMw1MqZHl2JeHhQYBD5w0R95/TCDzTmwdAGCUC9llq0TfLdUc+6u65bSURTRec+uXtktLzIDvRShHZeJc9+SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cu199noT; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cu199noT"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398cb5615deso301861a91.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Sep 2026 18:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789610140; x=1790214940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZOaFj+S59FnHr3BU64MfuAR/RqO/6DiqpgAbb7s87UA=;
        b=cu199noTMhkr1q20tQxO2VyEuUnE8Me0EupXHJzGpCzS0W4FE2vRq44PEXAw3GmlWC
         mCR2mwZMkPeGwZuo4tzbFcrr7g4v6BVj4gK5QyXl3MS2iUvsuHhe3szx5ctTL8LoV5ng
         Xw5+e6Db7LWXvuYeQciDCUeAxmmAtzgp7cfaEJi+XcHiMkjV96LA1zaM4B4Xoyfh5SF+
         TO9Qos1Sg/At6FVaMDgD/ito0xwfQq2hiv3BRA3EzxCNHCukO8lbvNrI+hmSC1maDaus
         k2jCc5MEyPXYMOJ52jJjqLB3pGLZKb2V0dNiSdlw9ko6QjOb5ZdoLq8Yij8qbtg3qJvq
         izjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789610140; x=1790214940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZOaFj+S59FnHr3BU64MfuAR/RqO/6DiqpgAbb7s87UA=;
        b=YRt7WJVjHkRyRqIpKbv2KhC9OyDqgqq4J4y2iXCLSIvfV+DcfkrbCSLHtJKh1CBxUB
         XyPPwCxv/iJJSe8hNJmVF2pUG1vPCFA2HrEJE9pgtl4xUzxwVvESGL+P0aFeqgxpb/r0
         sId1oGlcRd1T+z4+fsbNzkc7F9ou49X5APgBeYTSG+nXIxCy2BN701GvF/EAkkIcY9Vi
         plKxdMocSDB6pDYEzfR1W3jUOPBsCx4mxqMcSJiXDempgpWZwTOEP9/YIOq/1PDYFwAC
         lVR7VQAQu70wD3NSU2YHYtDDCjtPFJkcCRx6ZYUTqtoNcCczgfuhd14Td7tR9dceECC/
         ThDg==
X-Forwarded-Encrypted: i=1; AKwUvBxTEJOnOaM0VAYUOVb/mUKmFT6C+DJVEyB4JbXrFGbapbec2Nc1IGV5m7lx+JVfw8qKTAnc8NTmkiXTwsbEyjX5vh0=@vger.kernel.org
X-Gm-Message-State: AFuF++n70L5gwTr7N32KADMlki/xcM38IdirDIFUTHNOkL4OZtPV5m0e
	0oGNR0mmu+ARTEP4e+MVBKfIB7WsQ/8Tv+57JbvCchCxdiAoEZOfZXk=
X-Gm-Gg: AYBFou1gk13Kls1dfSmkEw73I6UGi+NvPs257lA1B9fG2uWXoCk8GN4Jxfjg9auy1KQ
	puRgcD3H870f5fVqneDZVAsZI9eZICtVU7B02DiQz5NrE5lEp1xiI4GBbmymACPNqLORkR0PYwN
	ClJXiurODKiTxGmrlPFy5Ux7vVls+ZhCembUu8lYEtwzxOAVJXq+IbBxg+0HYj5H8ImbLyRYb5y
	7Eg6+ZN2XqK+jIWZrMfnTFn0DqwdBFCFaComC5CqPeDoDkf2Ml/xdKCimjZt5KbdLqPu5KgPYsL
	orbpTYY1ue4eEZxZUj7rxdifLj7Hn/O9/kaeJuSsIjD1/PqW/AO8JrX4jHpomI87auhcfOWZpGR
	mgphQWWrKlgUMNcKrgfjpp/dkT01Wm/rDfXt0aUHUG1IAa1N8H9p/ABqXayvzyoh/hPm8HGM/kl
	IKpGMGIHn4YQBXNp7l5FOnG4MBJRZF8OQERpNndJt9m17w0KJVH5xj6wAQK1p/5U9Kd5FHS29LR
	9jzKcCBjItz5dwWmT9rvHg45AM=
X-Received: by 2002:a17:90b:2f47:b0:39e:2f57:67c7 with SMTP id 98e67ed59e1d1-39e2f5848damr6369344a91.3.1789610140261;
        Wed, 16 Sep 2026 18:55:40 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:b6f9:c198:e14b:34c1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e390c2984sm386968a91.0.2026.09.16.18.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 18:55:39 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	namhyung@kernel.org,
	zanussi@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] tracing: Fix 64-bit and signed histogram fields on 32-bit kernels
Date: Thu, 17 Sep 2026 10:55:32 +0900
Message-ID: <20260917015532.103081-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DEFINE_HIST_FIELD_FN() reads a trace event field and widens it to the u64
the histogram uses as a key or a value:

	type *addr = (type *)(event + hist_field->field->offset);

	return (u64)(unsigned long)*addr;

unsigned long is 32 bits on a 32-bit kernel, so the intermediate cast
discards the upper half of a 64-bit field, and widens a signed field by
zero extension from 32 bits rather than sign extension from its own
width. Five of the eight instantiations are wrong there: s64, u64, s32,
s16 and s8.

The cast came in with commit 79e577cbce4c ("tracing: Support string type
key properly"), which also added hist_field_dynstring() and
hist_field_pstring(). Those convert a char * to u64 and do warn without
an unsigned long in between on 32-bit. DEFINE_HIST_FIELD_FN() converts an
integer and never a pointer, so it gains nothing from the cast and only
loses information.

Drop the intermediate cast and let the usual arithmetic conversions widen
*addr according to its own type. unsigned long is 64 bits on LP64, so the
two forms are identical there and 64-bit kernels are unaffected.

Cc: stable@vger.kernel.org
Fixes: 79e577cbce4c ("tracing: Support string type key properly")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260914054614.82A9B1F000FF@smtp.kernel.org/
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
Tested under QEMU on v7.3-rc3-82-g238650ef6c7c, four arms: i386 and
x86_64, each unfixed and fixed, defconfig plus FTRACE, HIST_TRIGGERS,
USER_EVENTS and DEVTMPFS.  A user_events record declares one field of
each of the eight types DEFINE_HIST_FIELD_FN() instantiates and
userspace writes known values -- s64 -4294967396, u64 0x123456789abc,
s32/s16/s8 -100, u32 4294967295, u16 65535, u8 255 -- so every
instantiation is exercised by one record with no timing dependence.  The
eight fields are read back both as histogram keys and as summed values.

i386 before, keys and values agreeing:

  { s64v: 4294967196, u64v: 1450744508, s32v: 4294967196 } hitcount: 1
  { u32v: 4294967295, s16v: 4294967196, u16v:      65535 } hitcount: 1
  { s8v: 4294967196, u8v:        255 } hitcount: 1
  { common_pid: 1 } hitcount: 1  s64v: 4294967196  u64v: 1450744508
  { common_pid: 1 } hitcount: 1  s32v: 4294967196  u32v: 4294967295
  { common_pid: 1 } hitcount: 1  s16v: 4294967196  u16v:      65535
  { common_pid: 1 } hitcount: 1  s8v: 4294967196  u8v:        255

i386 after, byte-identical to x86_64 both before and after:

  { s64v: 18446744069414584220, u64v: 20015998343868, s32v: 18446744073709551516 } hitcount: 1
  { u32v: 4294967295, s16v: 18446744073709551516, u16v:      65535 } hitcount: 1
  { s8v: 18446744073709551516, u8v:        255 } hitcount: 1
  { common_pid: 1 } hitcount: 1  s64v: 18446744069414584220  u64v: 20015998343868
  { common_pid: 1 } hitcount: 1  s32v: 18446744073709551516  u32v: 4294967295
  { common_pid: 1 } hitcount: 1  s16v: 18446744073709551516  u16v:      65535
  { common_pid: 1 } hitcount: 1  s8v: 18446744073709551516  u8v:        255

Five of the eight move: s64, u64, s32, s16 and s8.  u32, u16 and u8 are
identical in all four arms.

trace_events_hist.o is byte-identical between the two x86_64 arms and
differs between the two i386 arms.

 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8af97fd4ee2d..9079b81cb7b1 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -466,7 +466,7 @@ static u64 hist_field_unary_minus(struct hist_field *hist_field,
 {									\
 	type *addr = (type *)(event + hist_field->field->offset);	\
 									\
-	return (u64)(unsigned long)*addr;				\
+	return (u64)*addr;						\
 }
 
 DEFINE_HIST_FIELD_FN(s64);
-- 
2.53.0

