Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BDD3D6472
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jun 2026 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226486; cv=none; b=F/k/KIuJuhSvgKyW0K37rc9guKAT2K3oGHgBww4Gyla/CAOut6b6428r7Y5C7Esg/MCYLtLqA+DTk48Wtuqt3rpfNaj/W+stegZos/Ps+s/zmutaSMx+8/AMdSbVCbmcRiXsnpuQWoE1V2LzCyAiqlgPnexgXJcK5A5VRO3LqRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226486; c=relaxed/simple;
	bh=L90/AkyCB9U0geyi1lWA/eHf7voiXgf417DXWgwVaXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lt0qKVW+AMB4C92xKWbMxChh7lRYlIV3RD+dKkpyBDfPy7JwtBHLcJnqqo8RCMfhz1OTsV4hMYGls/CgHgt8yCglZpEtCH7F0kYoSLxVmUgTUMlNgfMHW/f8tzjRy0Fku/h+xNV77Zh+PRExA4mjvPHmvGRIQ3DiBSsk5uIH6g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRbupCAR; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRbupCAR"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1384ebe7a10so5869943c88.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jun 2026 07:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782226484; x=1782831284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IY3KFhICfndG+RHDKCrSaeQPMXM8dmxeDhVM/4MoFI4=;
        b=SRbupCARI7MYaWuFBF0iNPDW3bnl1Yvh5aNmuzOLlmacehSE3eZ1uu6844w0iwmcPl
         YifKmvZwdTMr9m/HJTG2dV+VtEZ3mVOHtJ5I0yNml/5T3W5PVnQcldvjX6LdzKEpc8sp
         sMssFA+3h8u0Lu9VaF7o5dEtipVvSCrxocqQT7RihS28qI7cRttyzwl0/usFYhD2+VkS
         6IpBZjxyEonjgrO8ECMEtlRx7OjmEvimsTku0/KUa6EmITpuzbDF3oUri4V9FBj1zwbo
         H+vHOSLgj6UDWHZb9LWhiF26YqGlYILI9eO+5bADxQZbAvuyi5eO2S+yoZzAf54etk40
         Km3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782226484; x=1782831284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IY3KFhICfndG+RHDKCrSaeQPMXM8dmxeDhVM/4MoFI4=;
        b=WZONPohO2gRq6wFuavtasMbIBZDHIUZCl+OJgluYW9JPjj5caQR/qoCqBbEdUPZE6o
         VUDhjwotEOnqYp3ZFSO66UO5cxnW852fI0Gdv0C5EjXEYXgjr+od6e6etYqVsC5JEluA
         5smiD7phcXkRz1yqCRwsv4mE3NPnS+mySRUszlCjo6hiZeqMtDfN2sSBGTTmttbjDcgJ
         CQM9aguT1jQN5A3tGhe0gmSTXuQYnc0qO2DoReZ3czaA43jzocPnIrmYbJXr4eTy2WbL
         9dDNY748PNzN3cIMvx7Qn49CTctEjqf9eK/rOc2Qm9GLSgdBx/3ojyjlQcQN/1BkbA/F
         natw==
X-Forwarded-Encrypted: i=1; AFNElJ8kItSARTKKnCv5CcfpxWbdNP2xx7TjNl2AqFCLE89D7eNd/FrPozyZPt//KA/t8Zfhtu7EqK5snl/q3RYh7kP7Ncs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu2OILzcIwvPb9xx0FnRSXAQ47ni60pdgPQbZkCHxH/VuBsf3p
	4HzQCUVv5H9GODmhvPApkcFch1Q4OWztpU0gGLqxG5Ef9HlR21/GqFxO
X-Gm-Gg: AfdE7cm0uZCs+KSY2kHsbnYch2bSa4x7daj4IqtEfpzcRJSzmKNjC+PcEw/qMPF9NrC
	/uXjYFbXzQPOZyHR5sE4xjOw9kMC2n96g6JD2P2LldccaGYFN0s/QhF9LBW4ntL9Qf53BDlbgIE
	kjVTERweXgDUNVLwQcvx3WtmJ3adY6vwTQU8d46t05a+FRgl7uc++jgnABIAREC56FmqyfVUJVM
	ClTKtUQuDzgUhsqpiCR6/RfkBHNvXZG1Dva17MCfa1PEcKs+sDd3LPy7un2JfFsGBQa8oyJu1+y
	frQPR1QTv6Lh2Q1DEQ75Dt0OtpBkxv+J1oUnQjzmOUUY7QE7RvIfk4Inb312jvI7qScmtgTsbwu
	wvdRGK+nXIsoh8Le/82HcI9sVysutsFdSsoS9Io4FHQs5XgiSIhbmpMpHX0kaUqnS9CBx8cxHYZ
	9WZd0pxW6FXgOQ8k0HPMSrk3lmjwSUpIc/Cx0AFQ==
X-Received: by 2002:a05:7022:90d:b0:12a:6fb7:87e3 with SMTP id a92af1059eb24-139c5e033b1mr2686422c88.31.1782226484332;
        Tue, 23 Jun 2026 07:54:44 -0700 (PDT)
Received: from mo-Inspiron-5559.. ([2001:fb1:d9:863a:37d9:e7c4:e450:11e4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139adca1b00sm12963863c88.2.2026.06.23.07.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:54:43 -0700 (PDT)
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
Subject: [PATCH v3] tracing: Use seq_buf for string concatenation
Date: Tue, 23 Jun 2026 21:51:47 +0700
Message-ID: <20260623145147.12145-1-woradorn.laon@gmail.com>
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

v1: https://lore.kernel.org/all/20260620175441.223342-1-woradorn.laon@gmail.com
v2: https://lore.kernel.org/all/20260622094623.18469-1-woradorn.laon@gmail.com
Sashiko: https://sashiko.dev/#/patchset/20260622094623.18469-1-woradorn.laon%40gmail.com

 kernel/trace/trace_events.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c46e623e7e0d..5ab630155ab6 100644
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
+	.size = COMMAND_LINE_SIZE,
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
@@ -4766,7 +4774,7 @@ static __init int event_trace_enable(void)
 	 */
 	__trace_early_add_events(tr);
 
-	early_enable_events(tr, bootup_event_buf, false);
+	early_enable_events(tr, (char *)seq_buf_str(&bootup_event_seq), false);
 
 	trace_printk_start_comm();
 
@@ -4794,7 +4802,7 @@ static __init int event_trace_enable_again(void)
 	if (!tr)
 		return -ENODEV;
 
-	early_enable_events(tr, bootup_event_buf, true);
+	early_enable_events(tr, (char *)seq_buf_str(&bootup_event_seq), true);
 
 	return 0;
 }
-- 
2.43.0

