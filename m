Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046357;
	b=Wglz04ekwxiX4xwsEUJS7BhxJvTpqBssi7+MHANnBuO5ncHaq8CJPD8gkrYkubty0o8y
	 uN4KqqHEusXhIYm/lv14o24yIZ60TWLldjBbBlKBIv6xd6gIw5EHtWAgrlDIQBabRzdU1
	 zYQUWkWhgmyxLXEHmuR9ZEpPcqCHGB6uCFLfcFiGQRFS3S8T8yahDnuD+6jmJjdmDV/km
	 oFsdlctIWdsdXNI+MsvSNrKRYab4lsE/J+Qke3gSq4bqiN96DNmkj96KuS/vkliwJJ6sJ
	 ucb4wEQ9Imx98XtvYWfl0DNGjzGCRhRcTA65vDQN8qW1t0IILnlETF81ReWxlLRBuLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zYHw9i1ZC99ijVtSzd1tMuXGmwLLIqBi0BtOpLZ+XZ8=;
	b=E8YdA2nciAhYEU/wV0Z84FgnFR+nQnRfLHFHlUF+zrvD+2Lu5haUKwEP6ROm0C84Auay
	 JeZ5yfjP9uEtyPy1Er/QwbH9Aub6gCXqz+lJ+qgGhWMtdt4/YS+ltuYeTpAmnnVmHChue
	 wSs+Bn8vBqKFE5BHqa/ODBHPyxWtwzYV5AQhT5b7PkPN6gr/wTObzCZe+ssw797fZ9Fl8
	 RROkLKWC8WQ/zWYkbZ5fmdcKxQfhMmqzZc6FqoloRTqQWzpA3wjmhZGA6X40KWNRq/v17
	 iDbe8OjxTTenv265OehYIhVKv3+xUFQY2GWiDZMcyED6DeBPN417WsRq/cf4rFUdOeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ucYlb/Gi";
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE0F606A33A
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Nov 2026 10:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACE0F606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ucYlb/Gi
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so13258695e9.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 07 Nov 2026 02:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794046355; x=1794651155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zYHw9i1ZC99ijVtSzd1tMuXGmwLLIqBi0BtOpLZ+XZ8=;
        b=ucYlb/GiDfxsWgg9M/Iz4Q+U/thZllsvDF7Z2ByNB3WxUi+ecuFDfrXCf9XpYZRCIO
         gbBRiBGqxjSlT+fGQJZlOnszjgl229YjhCllryN5bm19UqZhLKqY1EmyogvbzhGA6xPI
         85tT+rMqC2jPdYXMZJC/cs0PsrdyFHyQyCtVLpnDAtn1BmKGCUNrq+H9D4j4MF02M4ko
         4tgh40wFRA9D4AdMQudpkuJF8e8QlEElefGu+Dg+Ov/Ar6df0JBcMvotWUN21ZxfJSAz
         dYsCsOewknBbupnSrxrUD/nQAwgDDor9t29imyxnLqvil1kfUBNxFQVRDwIyHaRw+oXC
         uoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794046355; x=1794651155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zYHw9i1ZC99ijVtSzd1tMuXGmwLLIqBi0BtOpLZ+XZ8=;
        b=2i+6cvsJueJd2E1kHNIpqXjbSFdp3dA2On76hnAtnVWvMYknWDXorsyQSQO28H3IIh
         DtEhPfmFyAvNUhTJmmnUnD/WLvuIx/mtTW8Hkw2itqnt52zrgtiCsMELO938wnTQfoZq
         zEPLXOLez2ddRsMdUpitoT44IQgZUfr0QqQQ9kup4o3RWiAtCNqIY9PIzRDedlR/PSWN
         PDkbBDhHkYmPqTCneZhlmuzBwO8bxDUCBe3P9ck7tCpxbK1C1p/Ejp0PWILOXlW0n5rZ
         tmojYYlSL9q6M9dAYil/WOE2mkGRN16e5i10nIWJ8pTTvuE34NwaTKC+ozyQv2esdeVb
         otZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzBeN1WDK9syYXAq7bgv56Ad1fXXlwg+eUgtNew/tS0vb10zdMKUjwxjy2OTVnjgxFEscsDKp1OwBH41BxokIw7oUE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Yf4S8A2SjQGMEIIpw3hQhBOWtnLZ3qYum62AuoHJqMFwTnnFo
	U9jrZi59yIE4/VAp6DGYYr8ac+jVM7IMSBUHsQmnTZ+tBbStwzLECjySS+A2tg==
X-Gm-Gg: AYBFou18Tvux6mObDEpKuf8H9Xs2v7kXxi9EiAqtJlB2VkRWzlZ3Zgg8H+SOTDk+8Gr
	pr63D5qTqNbusd89gVS4AVt6pqeWN1biG+6rDSD5ul/Suj2udHqa3HunIo5CKfon88yFjAqHtLl
	BhpIPWroucVI7Qnj1rXX1tYOf3IZXKDofIcRRmxJM0nILbVaA5ZzFsJfHbeHm0O1Ry8nsHsfQVe
	G7e9GCeYoygOSe1fqy98hRF/u5sBr9Hl+dCowCYVy0uDfgF+Warb3a1kyV/+Q/58bfByHH00K7p
	5CgvK4K0cNCjDBY4VDc5njyEFklx9IKZBCqQh6QFuzOEo0Bub3IVM+1CGTPVoz8xVsXW9TAv+KM
	4TTBIpzQvtvsAjJDLOtVCaLo8zeADa54K3huT6YQ10yNxaTmjDoKPTHTVUVGCTFMdRq8RPwv9Jy
	UVvcmX8KXpmRUi/NyAjGsMqIH67QWuKFHPkeOxKcwZls9qyHSPN90D2re35qoyBXa3ulHmQ+pDT
	gWUEelLGYLDNMuxQAZyaTzVcjEGMTGzZ73q6dtJDWlKoGhsARfjDgnXPHysdNd97SKfuMWI/CVo
	hEERizZK/bdS+r/LjAAZW6Uf9yj9JtuwXvThxlSPuVuS7J/gEgqlmOu7QNVCN9sW5sg9/OQ2w/V
	2wsLDDLbkl6hv9w==
X-Received: by 2002:a05:600c:4fc9:b0:4a1:fcfa:2a07 with SMTP id 5b1f17b1804b1-4b6e007beefmr92278545e9.30.1794046354653;
        Sat, 07 Nov 2026 02:12:34 -0800 (PST)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e3283ec3sm51270025e9.12.2026.11.07.02.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 02:12:34 -0800 (PST)
From: David Carlier <devnexen@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] tracing/eprobe: Install the trigger for every instance that enables the eprobe
Date: Sat,  7 Nov 2026 10:12:32 +0000
Message-ID: <20261107101233.151434-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The eprobe trigger lives in the instance of the enabling file, but it is
only added when the eprobe is first enabled and only removed when the
last file goes away. A second instance then records nothing, and the
first instance's trigger is left behind once the eprobe is disabled
there, so the eprobe can be deleted while that trigger still uses it.

Add and remove the trigger for each file. The file is never NULL here,
so warn if it is and drop the dead perf paths.

Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
Cc: stable@vger.kernel.org

Signed-off-by: David Carlier <devnexen@gmail.com>
---
Changes in v2:
- WARN and return -EINVAL on a NULL file, drop the dead !file paths (Masami)
- v1: https://lore.kernel.org/linux-trace-kernel/20261031203915.491866-1-devnexen@gmail.com/

 kernel/trace/trace_eprobe.c | 56 ++++++++++++-------------------------
 1 file changed, 18 insertions(+), 38 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 998e6390937a..474be2f5ccd9 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -644,37 +644,32 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 {
 	struct trace_probe *tp;
 	struct trace_eprobe *ep;
-	bool enabled;
 	int ret = 0;
 	int cnt = 0;
 
+	if (WARN_ON_ONCE(!file))
+		return -EINVAL;
+
 	tp = trace_probe_primary_from_call(call);
 	if (WARN_ON_ONCE(!tp))
 		return -ENODEV;
-	enabled = trace_probe_is_enabled(tp);
 
 	/* This also changes "enabled" state */
-	if (file) {
-		ret = trace_probe_add_file(tp, file);
-		if (ret)
-			return ret;
-	} else
-		trace_probe_set_flag(tp, TP_FLAG_PROFILE);
-
-	if (enabled)
-		return 0;
+	ret = trace_probe_add_file(tp, file);
+	if (ret)
+		return ret;
 
+	/* The trigger lives in the instance of the file, add it for each file */
 	for_each_trace_eprobe_tp(ep, tp) {
 		ret = enable_eprobe(ep, file);
 		if (ret)
 			break;
-		enabled = true;
 		cnt++;
 	}
 
 	if (ret) {
 		/* Failed to enable one of them. Roll back all */
-		if (enabled) {
+		if (cnt) {
 			/*
 			 * It's a bug if one failed for something other than memory
 			 * not being available but another eprobe succeeded.
@@ -687,10 +682,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 					break;
 			}
 		}
-		if (file)
-			trace_probe_remove_file(tp, file);
-		else
-			trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
+		trace_probe_remove_file(tp, file);
 	}
 
 	return ret;
@@ -702,33 +694,21 @@ static int disable_trace_eprobe(struct trace_event_call *call,
 	struct trace_probe *tp;
 	struct trace_eprobe *ep;
 
+	if (WARN_ON_ONCE(!file))
+		return -EINVAL;
+
 	tp = trace_probe_primary_from_call(call);
 	if (WARN_ON_ONCE(!tp))
 		return -ENODEV;
 
-	if (file) {
-		if (!trace_probe_get_file_link(tp, file))
-			return -ENOENT;
-		if (!trace_probe_has_single_file(tp))
-			goto out;
-		trace_probe_clear_flag(tp, TP_FLAG_TRACE);
-	} else
-		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
+	if (!trace_probe_get_file_link(tp, file))
+		return -ENOENT;
 
-	if (!trace_probe_is_enabled(tp)) {
-		for_each_trace_eprobe_tp(ep, tp)
-			disable_eprobe(ep, file->tr);
-	}
+	for_each_trace_eprobe_tp(ep, tp)
+		disable_eprobe(ep, file->tr);
 
- out:
-	if (file)
-		/*
-		 * Synchronization is done in below function. For perf event,
-		 * file == NULL and perf_trace_event_unreg() calls
-		 * tracepoint_synchronize_unregister() to ensure synchronize
-		 * event. We don't need to care about it.
-		 */
-		trace_probe_remove_file(tp, file);
+	/* Synchronization is done in below function. */
+	trace_probe_remove_file(tp, file);
 
 	return 0;
 }
-- 
2.55.0

