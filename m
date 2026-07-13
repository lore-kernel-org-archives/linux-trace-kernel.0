Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394AB34CFDE
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Jul 2026 04:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783918451; cv=none; b=Cq6qHvGihQUiqnzsJ0zIhMUL7P4gqmit/vlOsIMsiHepQZrz4jBmHig9UDQJVON0ggjiUrkd02A77qG1gc86zpSz2OBCHY/eb6/D/yzn7GdnNLZT5O1NNfJ4hDo2u72QpL7qdMr3nmETVN2ArjOFWhyUSniCygQs855a5aGJHKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783918451; c=relaxed/simple;
	bh=aWyuivC0uBr2raUrYrGhB6xX3JmGBmcCaiXVvYEGVQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YJf56hqkthRigcfzpbM1zu6b3FZ9DVZmBAn3MZ6irW0a9jbW+OFFP0EaX0/Pagc+Mvm9L1/B3U7Z32H8JKgbwscjhxbxfoC+9HwGxxfW70uEKH7MmZTUHzJFAzCCpFHXcWtZqE7XjM/QvMx9ISIADZXBIBZ9m1FBDsXbcnvu664=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVFZFK3V; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVFZFK3V"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ceb096e675so13602975ad.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Jul 2026 21:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783918449; x=1784523249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sFT84HfE6g23Y0JSEsGGMWs+C5GZdiRx3RFEfHBMGN4=;
        b=TVFZFK3VZffAe1yuSIkedDFa3KTAXLhI/6j7UIyHz1n/fUko7w9Aitw2+qYxV+i6yz
         fDGaKoD9D0pg6l/b752JMBlS/15cbk0fngiH3B1ectkCsfRC8ZCc3erik8yifqdbGEEn
         uXFW42hgVapJqCdY8A8wMKS89eSnQEWTpYHJ5wsmQ8qMInOR85b2FiPmAtNhbvcenERE
         YA7IsDaSNQLt55ggtafDHYACH/H7Jy8Nt5TtPbhjmRy6ivcwnRJP8jCKYnqgXUjCimiL
         znr4eeTtpx403DOfQV6RrduRxmMOtucMoJw8e09xPY4ljHe6vEYQJ+5lRB53oSynyzfy
         efhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783918449; x=1784523249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sFT84HfE6g23Y0JSEsGGMWs+C5GZdiRx3RFEfHBMGN4=;
        b=l6WqysqTLnPy5siE2lUdQbZgEeE3Ng8oz6gh3J57Zyh+5WagwnuWamytN4PqTlNls8
         XRRANhe3eRj6gUhycM4XKX2XHvJGNJfT76KUsyAeXgtQc9JkqTjbx5gir7ePdNGjWrDS
         QL+ddISH8M9h8YHDUW6YjJ7jlMYPOVlFbbiEAx2vUSJv+TFZh9SrrQsy1n3A0QWIBVu4
         /vPc4h3b1Lcq43x5M/rtt8rwWi5Cp5/gKhDSaPyRDMBrlC4zgwjy3aw9Zd5ALosxfiFW
         LnPt6CClk3RptAJsI5pkwOVqmWgRJ8F/XCDfevcSCkoEcn47SxSKmxXnL6QspL6UJcMe
         IaxA==
X-Forwarded-Encrypted: i=1; AHgh+RoDPKToN/EPIsBTcVLXRWrjnB1G73QBRkrC0K0N7vplYcZnPS5fSm1zH/xMlrXSBrMxru/LTPmpoL5ehMM7mayNP9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/5AaqETGj2DJGdkkHDGHztiDvVPIzdiWFhDY0S7tnSt3hmHSz
	C268FcElqL+fovs3uF3TNOuB782ipii5Gs6zfO5FslbR73KmM5PzSEDz
X-Gm-Gg: AfdE7cnvfBn+X71j7WcfQoWx9vcYvx10Rj4Y7EgsI6f7mJZ+FmQuFV2p0k/nysL8iYu
	iaNS6F1gLHSD4meCPnxGDTaBOpEsXClIggDqV7Mg/XyRUY6SdbfaOg+gRJiPKq9mvaT8dQWpYZU
	9hDcNqBfoBDg3sOzCnWDVWTrhe0AW3y2PlFrLpZWm6qSEO2+7zkMalmvMgvepN2LjO8PLcFNO4E
	JHExXLS/mjyxKIdl0/4QSPdDviE6AAu/syrkP6hUo2Wl1o9SWWLnnrtik9m6ecAo/0Nfo6Qypn2
	MF77RVzqR2XeIA8Ey3ziHmP9o3ucub0xi2GTXJrDZMsDYxrYuA2b502+a1UOMQIHHXFJ2m4Ou/Y
	VRMJafRn4r5txkuEQ1kuhCl/2apQ7DeK/i+10TjBx+oJp+Q8rQB9V6VwTNtzm92YSC8lbG4n0Bg
	hnALPOOkH+6Vxw2LqpDXWXz2bVLwk=
X-Received: by 2002:a17:903:b07:b0:2c9:ff29:3f91 with SMTP id d9443c01a7336-2ce9e7a5613mr78426635ad.6.1783918449548;
        Sun, 12 Jul 2026 21:54:09 -0700 (PDT)
Received: from mo-Inspiron-5559.. ([2001:fb1:db:5c33:ea21:9586:4d37:987d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm92010215ad.57.2026.07.12.21.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 21:54:08 -0700 (PDT)
From: Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	woradorn.laon@gmail.com
Subject: [PATCH v4] tracing: Use seq_buf for string concatenation
Date: Mon, 13 Jul 2026 11:52:49 +0700
Message-ID: <20260713045249.69942-1-woradorn.laon@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for removing the strlcat API[1],
replace the string concatenation logic with a struct seq_buf,
which tracks the current position and the remaining space internally.

Use seq_buf_str() to NUL-terminate before passing to early_enable_events().

Link: https://github.com/KSPP/linux/issues/370 [1]

Signed-off-by: Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>
---
v1 -> v2: 
	- Fixed WARN_ON when booting with empty trace_event.
v2 -> v3: 
	- Addressed Sashiko's concern about the compound literal backing buffer.
	- Replaced the compund literal with an explicit declared buffer and pointed
	seq_buf.buffer to it. This guarantees the backing storage is placed in 
	`.init.data` and reclaimed after boot.
v3 -> v4:
	- Removed typecast a const char* to non const.

v1: https://lore.kernel.org/all/20260620175441.223342-1-woradorn.laon@gmail.com
v2: https://lore.kernel.org/all/20260622094623.18469-1-woradorn.laon@gmail.com
v3: https://lore.kernel.org/all/20260623145147.12145-1-woradorn.laon@gmail.com
Sashiko: https://sashiko.dev/#/patchset/20260622094623.18469-1-woradorn.laon%40gmail.com

 kernel/trace/trace_events.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c46e623e7e0d..4f5a0e73a89b 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -22,6 +22,7 @@
 #include <linux/sort.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/seq_buf.h>
 
 #include <trace/events/sched.h>
 #include <trace/syscall.h>
@@ -4501,13 +4502,20 @@ extern struct trace_event_call *__start_ftrace_events[];
 extern struct trace_event_call *__stop_ftrace_events[];
 
 static char bootup_event_buf[COMMAND_LINE_SIZE] __initdata;
+static struct seq_buf bootup_event_seq __initdata = {
+	.buffer = bootup_event_buf,
+	.size = sizeof(bootup_event_buf),
+};
 
 static __init int setup_trace_event(char *str)
 {
-	if (bootup_event_buf[0] != '\0')
-		strlcat(bootup_event_buf, ",", COMMAND_LINE_SIZE);
+	if (seq_buf_used(&bootup_event_seq) > 0)
+		seq_buf_puts(&bootup_event_seq, ",");
+
+	seq_buf_puts(&bootup_event_seq, str);
 
-	strlcat(bootup_event_buf, str, COMMAND_LINE_SIZE);
+	if (seq_buf_has_overflowed(&bootup_event_seq))
+		return -ENOMEM;
 
 	trace_set_ring_buffer_expanded(NULL);
 	disable_tracing_selftest("running event tracing");
@@ -4766,6 +4774,7 @@ static __init int event_trace_enable(void)
 	 */
 	__trace_early_add_events(tr);
 
+	seq_buf_str(&bootup_event_seq);
 	early_enable_events(tr, bootup_event_buf, false);
 
 	trace_printk_start_comm();
@@ -4794,6 +4803,7 @@ static __init int event_trace_enable_again(void)
 	if (!tr)
 		return -ENODEV;
 
+	seq_buf_str(&bootup_event_seq);
 	early_enable_events(tr, bootup_event_buf, true);
 
 	return 0;
-- 
2.43.0

