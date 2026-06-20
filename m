Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97492EC571
	for <linux-trace-kernel@vger.kernel.org>; Sat, 20 Jun 2026 18:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781978510; cv=none; b=qOgrwcSJy+Uzi2OwjDIL1JB4s/p+yw8ZFSawyKDqWE8v8t/+nqvC2E5FWgnkvxVqBIKI+hIuFy/H8n1ZJzl/juBNdgp7sMEhQOIthGXX6eq6ZExukO0DVVsI1gPHq9I6PNDb8Jxor4edo1PkwaIQAXWmJeoPHg9NXW3kgigdYOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781978510; c=relaxed/simple;
	bh=81qX+qAPsLCiqIdHPLg1+JhVNjcZxVE57fRIFw3hA+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YUNO7QpkzogKSspJELfY1c0QOrY5QD+PRnuk20QQcGstuPwDTqQzu0k097GhDi0aRgzkpjV1/aKcyh0dNordtFrfuYJS7US/tTQp1Hp+Wz9wb+GHuW9sTMpT107iL0x2JIdy41iL6H/sroyPOdO7dlzlc1oa7l6rhHdpBDCXT+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqZq5B9Y; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqZq5B9Y"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-30bf132969bso3674239eec.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 20 Jun 2026 11:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781978508; x=1782583308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TU1KHjg1xw4SOUVLZNaBDJ/t1F+t4VC9J/t07Bu+tLw=;
        b=YqZq5B9YZ/8aNQ543wv/K3X7t66V/M7Ou/RnXbYLPlYojaAqADP8dJqx+FsPSZwF7i
         qI1SoCkY47sDM2j/SZnXl4Qn56eFv/QioNgNWa4w/Fsic/QNpM0aQ7vH/CgSleihZNj2
         JsVti0YeWI3vJl5l8Hxia6R9/k76KmrwgCsWNMRALl6zYC/YzZxHPG1nv41z/3AzSEZt
         HGroct1CkP3LImxJrYRrWhY+muGyMR6H3bfMplC0RpngtMu8GScHsDteIuT5yqCsfJsk
         QI/9jMmUXdAcLd4gxiC8bfm6326Bet/50abc84PncZJ+VAk4vNuuXh8Lm7temN8yfCwL
         hDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781978508; x=1782583308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TU1KHjg1xw4SOUVLZNaBDJ/t1F+t4VC9J/t07Bu+tLw=;
        b=YnChymDGLxNEt9nTUkZn6pm4RkTDJkaRDR344w7UqNF93C4AZA2qjWOvhVAIo/hF2u
         XSy1D3vqb9a1w3K6KYslzfnGMVX47MJhVGVoRLWi5Zn+LoGGxnzxHHmLCTJTwO0zO2nK
         BMj7sVL9bljjxlJAuHMoR7AG1EbZIdKuaGNtYsyjd+1XXEmpSmF3NCdksWniM6sSptDp
         pmZ2woAH+cxN1bTq1rQMF9kL+TUFixPSL4yRcz2hacPRI8thPERzZEvOUMRyOU4FkkzW
         RwA05A3jH2Nmyg8HgJMu90q5IAEfNHtGXWe6GWgjKxk44G0RrcIJctd9ibq84TNTGq//
         9XdQ==
X-Forwarded-Encrypted: i=1; AFNElJ/zPAKSYA1evzDowF7+rENT3Kith8JYoOWbDiBncOMIWTIOhOS/MBRKRBF393DIpYCq+GJP48j6fKoqO2SfzcihtRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw41UEPQkfC4UzGbByHt3Xb1POwDSLPvH2zyhU/LmfaYfYN6b27
	nh0G/4SPF/lmCmaOCw2XafWIgEVZ+D94zgpuksuDzKO7QVCCSaJ8bjpB
X-Gm-Gg: AfdE7cmHlJn4LjRnGYw7IWu0GZRkHUprBvuzLciwknu4t2SjPO2Zs9chVYkiG36+2XV
	p8tA06zsGuMFBxhtpjMU7EOtBiBK4hOfz0rJHyGXs1QTOQal6cQrnNUlSW3Z6HomtBpQN0naJQc
	uUoepVe6YnRrs86C7LpVeCxXVIpjb4daHHckuafe/kQ2pg7NzvdUWwKlLpaaDWoopcQ7A7kCfLx
	B7rRrjIvYF7hJncP5xlbzsyJERZZ1nmoQkg/tX4YVi8d0ABZ8R3Uvu8Iq6N3Sl/IpLfebvwihfR
	lefGhqqxt7PBhwwLZXTi66GG06VWlu7vKsxeH4kbCGidHb1ui44sXoA0TqfnrHeY5WWWLtEyr17
	qLMYg8X6qj1/q8kwsNjt8NN58syCpaL3DczaSjcPV1KDquUZjha5hiTMul/ZDk7Ybmvo5M4EMbz
	Wz8QEn6fa8tsEx8WpKpx4w8u70IQ==
X-Received: by 2002:a05:7300:1826:b0:2f3:5266:fdfc with SMTP id 5a478bee46e88-30c071a7ff2mr5939362eec.33.1781978507455;
        Sat, 20 Jun 2026 11:01:47 -0700 (PDT)
Received: from mo-Inspiron-5559.. ([2001:fb1:da:4242:fb25:44f6:726:5eda])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba57db7sm4025121eec.7.2026.06.20.11.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 11:01:46 -0700 (PDT)
From: Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	woradorn.laon@gmail.com
Subject: [PATCH] tracing: Use seq_buf for string concatenation
Date: Sun, 21 Jun 2026 00:54:41 +0700
Message-ID: <20260620175441.223342-1-woradorn.laon@gmail.com>
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

The backing buffer bootup_event_buf allocation is unchanged.
Use seq_buf_str() to NUL-terminate before passing to early_enable_events().

Link: https://github.com/KSPP/linux/issues/370 [1]

Signed-off-by: Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>
---
 kernel/trace/trace_events.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c46e623e7e0d..15164723e028 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -22,6 +22,7 @@
 #include <linux/sort.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/seq_buf.h>
 
 #include <trace/events/sched.h>
 #include <trace/syscall.h>
@@ -4501,13 +4502,23 @@ extern struct trace_event_call *__start_ftrace_events[];
 extern struct trace_event_call *__stop_ftrace_events[];
 
 static char bootup_event_buf[COMMAND_LINE_SIZE] __initdata;
+static struct seq_buf bootup_event_seq;
+static bool bootup_event_seq_initialized;
 
 static __init int setup_trace_event(char *str)
 {
-	if (bootup_event_buf[0] != '\0')
-		strlcat(bootup_event_buf, ",", COMMAND_LINE_SIZE);
+	if (!bootup_event_seq_initialized) {
+		seq_buf_init(&bootup_event_seq, bootup_event_buf, COMMAND_LINE_SIZE);
+		bootup_event_seq_initialized = true;
+	}
+
+	if (seq_buf_used(&bootup_event_seq) > 0)
+		seq_buf_puts(&bootup_event_seq, ",");
 
-	strlcat(bootup_event_buf, str, COMMAND_LINE_SIZE);
+	seq_buf_puts(&bootup_event_seq, str);
+
+	if (seq_buf_has_overflowed(&bootup_event_seq))
+		return -ENOMEM;
 
 	trace_set_ring_buffer_expanded(NULL);
 	disable_tracing_selftest("running event tracing");
@@ -4766,7 +4777,7 @@ static __init int event_trace_enable(void)
 	 */
 	__trace_early_add_events(tr);
 
-	early_enable_events(tr, bootup_event_buf, false);
+	early_enable_events(tr, (char *)seq_buf_str(&bootup_event_seq), false);
 
 	trace_printk_start_comm();
 
@@ -4794,7 +4805,7 @@ static __init int event_trace_enable_again(void)
 	if (!tr)
 		return -ENODEV;
 
-	early_enable_events(tr, bootup_event_buf, true);
+	early_enable_events(tr, (char *)seq_buf_str(&bootup_event_seq), true);
 
 	return 0;
 }
-- 
2.43.0

