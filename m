Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26787242D70
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Apr 2026 18:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776192771; cv=none; b=mZzdl+VMTBu2qAUdArYg5+9t47+WuLqiRAyDaIhgQjTrvSjEbSkYJPj4iEZ+VaV/2UkGwyspAKMIIT7Z15rX3YAWuMSqN8qCT28Cmfp5335GTcdR5x5DRQvBNdnsV7LPTq2Bat5zuNyhzkQkpFyp2oi2WZzP4fFP1TmABIrzWXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776192771; c=relaxed/simple;
	bh=iD0ZF7xWF+2sVtQwlST8KB8qH/3DKQ7tgMmKSda8tHM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=R9lJIXFrFPgJYmIRGOilF/irCyY1b05IGQtKWdaZTIhc5YahMvDCzljp1sxPWkbyylv5ROHRx7U+VeEKUlJTgEUcsG4nEDwu3PMGNmv6eQo4QOcwuJfzN6i0jtgvTQMSVe4CM9FuooamtIpy3xZdFMwMiBq9YWoUxinAc1DE2ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fcnOZnMP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcnOZnMP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776192769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dxnIBcIE5Kfe2JHvPjc6ftOkdYUyuSbi6e55M5bzZZE=;
	b=fcnOZnMPDpePUnSk41fbBZSeWTe+0YTxxewLDu0pkZXYSBv5RKI+Hsiidb4vgchusHfaeF
	oKdoZBkdwZrtBL13k87VLc8Irl/RKOBJsaNYWnUSdOD0R/PGX94tNFsJol/1OMYu+1nNHv
	/qnwu8Z4hXWFp37WzRP0rVmGFnodwHo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-KoDJyeAXOcKk_v5ALU7KTw-1; Tue, 14 Apr 2026 14:52:45 -0400
X-MC-Unique: KoDJyeAXOcKk_v5ALU7KTw-1
X-Mimecast-MFC-AGG-ID: KoDJyeAXOcKk_v5ALU7KTw_1776192765
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4836abfc742so44216585e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Apr 2026 11:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776192764; x=1776797564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dxnIBcIE5Kfe2JHvPjc6ftOkdYUyuSbi6e55M5bzZZE=;
        b=dGxqUe/AsRSB/50RJXC0ACTRrCjsdM47YZYjqNcwGT5+IjWkdvQ1ZYt3xwg4D8/NKR
         u+g0kp+42Y8uPWjD8WYM406+oVxwa5zzM0nvKuHJ3RV4h+vJEcBx4pU+XxAIkavos6u3
         diwHMLX5jyloakADkVtTjBoDTYZMTlU4QhzJ6G3WMmNTKulvNA2hy5InNjjPxS2WuvCF
         XBSfMNNs7n/lV/e3B79LJH7ynScCHpmoo+DTXyJKBpD2qPVVFV3KV1Xvq0A/0X2dL04e
         bBDPcHerrynCSSi/MeVb6x6bx5XqUxNsGwKRU/j4rU+mi1U6IVkOlJWXIZJP1oyMZE9F
         dvrA==
X-Forwarded-Encrypted: i=1; AFNElJ9iwBOHhw5O/7AYfd0ws0M7M/YqAaGZB6cAYEJ2xqJEZaYluJh1D7kr8KfOcrLFC+HNwH672KUmd8j3LHJp7v2nXT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhmQwRQxpcwe5bR+s8R9PeNhZjPrRCOkyol7etPIU51SMSYxlI
	oFTeXzC+HiYia/1v9BK1myrR72d1Hfp3PG8TFd3Uq/03vaHvuIYfO+Ls5F+QK1CuF4OIwGeMbSa
	3FnN2HFEO7WbX/99UH4ODTnvNBxHlLyrrDpw96UOQDMj26Gm3NabXQdDkfwc5oc6trmGdbUnilg
	==
X-Gm-Gg: AeBDiesm7U8E3DSPYiO3a1gkPgwMLqSl9lBQBErCsTrBi982EF9ZzbMBMZTKn5gZFUe
	1g+t/ahsQg26V8k22c447AQBz/bcAaBEQnfJFN+P34DOhdQNl3cNgsmrVWH9NhMeGYNl7c2ZU4U
	0+7tVkSDRKBr/Cag7Zm60krCOsqvRRQ4EnXKqnaZbuVDH/ABOROsru2PlMO+vPH5B5fnmipfuUN
	rKnjJHiEZcFcJ0BZq5uVDnDxOTS25wpTRyzhd8qFGcOKNhVWw//F3WXL51nfbw86QfcF5q2upTl
	Rc+RnzzrO9I2PcAdOMhnGqyLbBNmIkRWdP632ZwMx5q8VoIlD4gM2dhlNTlpIypMMDrgDhntj7C
	knBdKR0ozhvh4qFw7J3cin+iVGNCV4/ccjv8=
X-Received: by 2002:a05:600c:628b:b0:487:1fbf:e0bb with SMTP id 5b1f17b1804b1-488d680851fmr246364345e9.6.1776192764459;
        Tue, 14 Apr 2026 11:52:44 -0700 (PDT)
X-Received: by 2002:a05:600c:628b:b0:487:1fbf:e0bb with SMTP id 5b1f17b1804b1-488d680851fmr246363955e9.6.1776192763960;
        Tue, 14 Apr 2026 11:52:43 -0700 (PDT)
Received: from localhost ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0964ed7sm3513105e9.4.2026.04.14.11.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 11:52:43 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tools/rtla: Fix --dump-tasks usage in timerlat
Date: Tue, 14 Apr 2026 21:52:18 +0300
Message-ID: <20260414185223.65353-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zvg3OP3tjIDmGSbuGJ2cpJPn7iXLv3xbrbLdJnA0EbE_1776192765
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Fix --dump-task to --dump-tasks in timerlat_hist usage string
and getopt_long table for consistency with timerlat_top.

Add missing --dump-tasks to timerlat_top usage synopsis.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
v2:
- Address comments of Crystal Wood.
---
 tools/tracing/rtla/src/timerlat_hist.c | 4 ++--
 tools/tracing/rtla/src/timerlat_top.c  | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 79142af4f566..3a15a85b7d72 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -694,7 +694,7 @@ static void timerlat_hist_usage(void)
 		"[-d s] [-D] [-n] [-a us] [-p us] [-i us] [-T us] [-s us] \\",
 		"         [-t [file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] [-H cpu-list]\\",
 		"	  [-P priority] [-E N] [-b N] [--no-irq] [--no-thread] [--no-header] [--no-summary] \\",
-		"	  [--no-index] [--with-zeros] [--dma-latency us] [-C [cgroup_name]] [--no-aa] [--dump-task] [-u|-k]",
+		"	  [--no-index] [--with-zeros] [--dma-latency us] [-C [cgroup_name]] [--no-aa] [--dump-tasks] [-u|-k]",
 		"	  [--warm-up s] [--deepest-idle-state n]",
 		NULL,
 	};
@@ -808,7 +808,7 @@ static struct common_params
 			{"filter",		required_argument,	0, '7'},
 			{"dma-latency",		required_argument,	0, '8'},
 			{"no-aa",		no_argument,		0, '9'},
-			{"dump-task",		no_argument,		0, '\1'},
+			{"dump-tasks",		no_argument,		0, '\1'},
 			{"warm-up",		required_argument,	0, '\2'},
 			{"trace-buffer-size",	required_argument,	0, '\3'},
 			{"deepest-idle-state",	required_argument,	0, '\4'},
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 64cbdcc878b0..e3a374005690 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -467,7 +467,8 @@ static void timerlat_top_usage(void)
 	static const char *const msg_start[] = {
 		"[-q] [-a us] [-d s] [-D] [-n] [-p us] [-i us] [-T us] [-s us] \\",
 		"	  [[-t [file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] [-H cpu-list]\\",
-		"	  [-P priority] [--dma-latency us] [--aa-only us] [-C [cgroup_name]] [-u|-k] [--warm-up s] [--deepest-idle-state n]",
+		"	  [-P priority] [--dma-latency us] [--aa-only us] [-C [cgroup_name]] [--dump-tasks] [-u|-k] [--warm-up s]\\",
+		"	  [--deepest-idle-state n]",
 		NULL,
 	};
 
-- 
2.53.0

