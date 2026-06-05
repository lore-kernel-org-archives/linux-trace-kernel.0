Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F082030A
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Jun 2026 00:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780620016; cv=none; b=ctOqKPFRwiFX0n6nGUNihOp6weWxJKHMHg5ce2IqmFHkOinDP1XIa/JXayGfrnT/H9E+HZEyPDRnI3Dxlq2bVWgmRmVREdk9nR1rwcAX0XQismbcaFwlVN+y8iOnxnrZ3PJzdsZME6MEXBF1ub4j6ozy1JOH8fS07MwZXVEIqgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780620016; c=relaxed/simple;
	bh=DXmhiCsWIXm11W34j1sugunE1ds1B0syHhs7CqJXlWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kwfRCwGh4ILZ4COipVWI4aKUz/8B6Z+88TNPed0YHnpVxR4JF5xEKcMTNMqh6hzMS6/c00qezFX+qgTbJIIRNLovIOEgPC5vUlWMfKYT0tqdGqQzivVfyTtRdgZ2lgfILiq7q1mg9poBk4XWHbaurNQDubBevRQsdRi+aFafNvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=Q4fj5C8q; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="Q4fj5C8q"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9157d3f2098so176603085a.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 04 Jun 2026 17:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780620014; x=1781224814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mWrroz3+zH0jKSf35ivskF6g2ucZr//71hYihKdTdTw=;
        b=Q4fj5C8qXeOuckPllAudy80RTwrcreHalqOXJv5npHKH8lC9Nl1EVx4gknwGMjfx+O
         TPrpo7PR6TBnzOeixe/z7x39YRumuogR7FVjedRIvk+3NkvL5rz9npUZ28Byu1zXmqR4
         7Y8VaSGl6TsmOi8Iy4hGMkNKpN6Y2y7aAwXGaQlVJRUfQ0dJhJOGMFJ6l2lHYOQm0V1w
         hcAZyTC61aluS7rbV4SJhIkaiHUnLSCN31XClBtP9m7JOuCHlH6o6IFQuJ6aYlfWadVF
         KeifM0Jln1U+QiJJlPlyMBM8t5yo3OeNiidZbJvjpOznoKP9pgeKSFWdPvvP5KR0jXxt
         crug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780620014; x=1781224814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWrroz3+zH0jKSf35ivskF6g2ucZr//71hYihKdTdTw=;
        b=s+/81R224LI+WOvl478P/az+K9WEjRcHnzOtCKBG/Gwi6Kvm9kVRGo6CD5ge8vf436
         81a3i4YiDf+aNgYI3y8lpbDHNii9hzZvOaMN3dCxU89p+ev44FnjwAeQ8Srv6tsZ8p39
         RBUdrPj9+eMn2B4TscZcALW+5g7AasPDf62qCUGuQw3coLG0vXMcc3GDQS/XwjLiiLdR
         //arM8EZX+4uI05bgYlcGIvO2WVpwxOpp2lLt0VsVN6ggzst6nbjqjPR5k8Zno1uoZQc
         +nSXrpB/jxoxLCB/MMIocJC27K6/9EsUAn7EmK/6tuyGcSZyT/wA3uTm5zWEhghKgUDj
         mYdg==
X-Forwarded-Encrypted: i=1; AFNElJ96SdknM7RuxFaWHbVYDLGeMgC5nIaY6G9oMsZ5UnjT3oV15G80DIfFxyXjNaVT9ExYLQT0V2POoyqlrTS6x6/kIyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzryp3SWUg/Y0faMzHwFskjiLDnWJRrbMJQHCGSUZf6vULvQ/pT
	BYWyXvWfkqsZPI3blAfPCjQoYUP3McN7Bl2Zfc0fXbe16QIWQciHQqMdb4OWYTbTJZ4=
X-Gm-Gg: Acq92OF/2cZF9whBMJ1oCsln5H7c+UGhHN+SjLyY874GIMoiGznXpvhdv1mQZ44I21x
	IstjEOQqHXBiib/9mmQ5oYCamKa5YM4qTqUR2pgiUCNRgTPSCPYi9BWSPG0jd6WkKL+GZ3tb1Bp
	X2j0al7xmEiI7PyqGLlybp5gUmVVeAEAfkgV6SVFCOJO4YK0aSFyNaKyZPTQXGaX9X8Au7JkI3E
	2B1Lw62rPxWH6QrXVbrhfyW6igKHTcHt2LP07fYxV+2kvFQbIueDrPJXJcPwpw37y+biVpZlaPW
	QdJP4UwFOZbp53XUMNLSilkCnbJ9dq7QhjqQtWLnQf7/gKsir2ErI5wROZrv3iorTJUQVEYPYf+
	6v3tYLDn36M30MToJV2uY5wldnwBHiVuMnHKHSMD9USDJKLlhJMxtYH9DyFDtRxfth7O8owygUi
	QoLkj6/Og3oEujdPkm9VeAvUYRi6KfQacoVj6MPg==
X-Received: by 2002:a05:620a:254a:b0:915:9943:d760 with SMTP id af79cd13be357-915a9db892dmr272979485a.43.1780620013903;
        Thu, 04 Jun 2026 17:40:13 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8cecd06e4d6sm67196236d6.36.2026.06.04.17.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 17:40:13 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org (open list:TRACING),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: [PATCH] tracing: reject invalid preemptirq_delay_test CPU affinity
Date: Fri,  5 Jun 2026 00:40:06 +0000
Message-ID: <20260605004006.2041148-1-sam.moelius@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

preemptirq_delay_test accepts cpu_affinity as a module parameter and,
when it is non-negative, writes that CPU directly into a temporary
cpumask from the worker thread.  Values outside nr_cpu_ids can set a
bit outside the allocated cpumask before the test reports a normal
affinity error.

Validate the requested CPU before starting the worker thread, and
return -EINVAL for invalid affinity requests.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 kernel/trace/preemptirq_delay_test.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
index acb0c971a408..0f017799754a 100644
--- a/kernel/trace/preemptirq_delay_test.c
+++ b/kernel/trace/preemptirq_delay_test.c
@@ -14,6 +14,7 @@
 #include <linux/kthread.h>
 #include <linux/module.h>
 #include <linux/printk.h>
+#include <linux/cpumask.h>
 #include <linux/string.h>
 #include <linux/sysfs.h>
 #include <linux/completion.h>
@@ -152,6 +153,15 @@ static int preemptirq_run_test(void)
 	struct task_struct *task;
 	char task_name[50];
 
+	if (cpu_affinity > -1) {
+		unsigned int cpu = cpu_affinity;
+
+		if (cpu >= nr_cpu_ids || !cpu_possible(cpu)) {
+			pr_err("cpu_affinity:%d, invalid CPU\n", cpu_affinity);
+			return -EINVAL;
+		}
+	}
+
 	init_completion(&done);
 
 	snprintf(task_name, sizeof(task_name), "%s_test", test_mode);
-- 
2.43.0

