Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B972718DB26
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761704123; cv=none; b=nK2wLeB+ontAOW8VCuCntmdYzA+6QpASVzo3yGh2EpdmLO07+oYPHGbgIRqt5LA88kWPsM6I/N9YpUZKws0bOSIaWEOnI5VUcitU1o2WCmRC1AeLDzjkRWQCDJHscKH9e/Re850+QeQoTXsN4UOVCUsVOPec4Ae9mm56de6FOjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761704123; c=relaxed/simple;
	bh=CEvAhyPYCG+T++r8yJdAAsbzjdXegc+nM5rNng/jC1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YfPEdsnQyobfqe2DwgKyhHYQgG9scN8KK/L9UlWnQt6Z8xqwp2kzO8ID2Qb/0kz4TAZiTAIfBHlOjhuFG6maRlutpyi9/v0ccl01IR+5iprmfpbkg0/9bIhO+h/N10dpyYhuIZsPixaXFzpi1us6g6dK/DEl8wJQ4xHWVZz3R6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faZ2750Z; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faZ2750Z"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-78af743c232so6190530b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761704121; x=1762308921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ktlh/43BHkPq4CFdjDK0hsgcK6sJG2dQbSUlBR4d9/E=;
        b=faZ2750Zrl+eNv3NGWVEaGwepo6Zkz4kH2odDlkpwNMF9pJDYkx3DC666E4WWeCqY7
         CMzxrs00jWOJyeoYLi5SlTpjAw+ji2QH0SiG2YkfjGM5IbA/fdC68WORkSRRbQINHPRd
         JRzOek2lFeRKJgWRwBtGEGQ2mrrQOjrv25NDjWEVn8VzKGEjIzM6QDKV/IrJc0YkAOAS
         jC5TALIDom5EX54a/hrkHf0s1dUvL7YyrFcFMmL+rH45AxnSB47LwgSJg2pi/uW2RsIC
         Zf8Ue7ZWRrz3v5FVHUBBe3KMLI3FUAy++EDIHou9a8zcXqS5Da6IsMD1vfgLmAbl0ZIE
         pL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761704121; x=1762308921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ktlh/43BHkPq4CFdjDK0hsgcK6sJG2dQbSUlBR4d9/E=;
        b=dRGnWdve8DcJcWiLEd3rA4azjHPeFIwyCtNDYJV+2oWt0qDYEDbz+GKy0l/EKmUZVZ
         +76CaNFzoHJTOm4KgGRgQ5/uhpAlqMfoxlB2au5vmi+U5KozrM3JA8+d+z3fBieHn4HU
         zh/g8obaj1nPcqTbeaYsfxgUzKrbPDKI5jE8ZyYVivhfM0OTRnHWU8doEW8g4Lb66bSi
         AjZBXnQWA1RVhM9NDxP+rhKlMXtaDZieRPeV04wTyjsu1Q09NLcumaHT/7/a46aofa9b
         M0NRT+vdf4CmjuVl0v7k8E4XYTvX7zjN5WIIAGHQekf7qGxcJFFOt9s6erZRZqtOwJdT
         I9qg==
X-Forwarded-Encrypted: i=1; AJvYcCWTMs1DwDhVNuNCiavRnD0i/bIQzBocBwI+VqcGKF/rgpHupme6cPa9ucjjo7x7mxe5MDh9jRWdPSCjDQmM4oYcf3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaiz6n3qQtP/GXRxYlYUpqUm2nwOIDsVa8AAc5sQAN/AvLWpBZ
	+jurqjXjNWg/2yIhqKMPFvybm+lhVzWc6n92d9IY2fvlshCR5W2gcBcNyWWKWchkYxk=
X-Gm-Gg: ASbGncsKzB4vedlpOor+hjfIrv56dp+DjhncD8oWAVyAqQjJwSH35AN9qgdc6UVfIZA
	3wn/GQALJVQebPuVLRa47jwzR/GlxPgXmPY3ehRJtmklrLS8Nh/Ykl93FI4GxffBurXZt1PT0ER
	jiQ33vVMlNP1uQc+g8m6fOGMcY2Haxe0Q8ym6CvqiPUkFFqolAsXu07LNT5bGBNaRSp/RUdbUyc
	RqhTDZ/XwGo+JbAdscSeQTCP5hoZwgaBPQVB3aic6uQZgjBa31reNS1cco1pV7Sj0yjcLsyIw2l
	zF9c4tmscirUe53uX/FrycCe+KuQpO50QBUWm8P8SjQkhOzgeG4xLxu5YmqlHhEisvlk114mvCh
	KZca3w4q3PhfOQY4sO0O4kCnnqK1c/M6u4GLew9zEn0+GH9GMa9YTljWdrMXJCgnV/SWunZb5Bz
	6V
X-Google-Smtp-Source: AGHT+IH/g79Ujfibd+JTMvUkBpYFAQJiqZkOLBJGhObxS6FSqfhAX6RVRxRENNGWr6hg43128FBG8Q==
X-Received: by 2002:a05:6a20:7d8b:b0:344:a607:5548 with SMTP id adf61e73a8af0-346558e31a1mr1592301637.58.1761704120749;
        Tue, 28 Oct 2025 19:15:20 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b712d024aaasm12124442a12.26.2025.10.28.19.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 19:15:20 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	jolsa@kernel.org,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: fprobe: use ftrace if CONFIG_DYNAMIC_FTRACE_WITH_ARGS
Date: Wed, 29 Oct 2025 10:15:14 +0800
Message-ID: <20251029021514.25076-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, we will use ftrace for the fprobe if fp->exit_handler not exists
and CONFIG_DYNAMIC_FTRACE_WITH_REGS is enabled.

However, CONFIG_DYNAMIC_FTRACE_WITH_REGS is not supported by some arch,
such as arm. What we need in the fprobe is the function arguments, so we
can use ftrace for fprobe if CONFIG_DYNAMIC_FTRACE_WITH_ARGS is enabled.

Therefore, use ftrace if CONFIG_DYNAMIC_FTRACE_WITH_REGS or
CONFIG_DYNAMIC_FTRACE_WITH_ARGS enabled.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/trace/fprobe.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index ecd623eef68b..9fad0569f521 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -254,7 +254,11 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
 	return ret;
 }
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#if defined(CONFIG_DYNAMIC_FTRACE_WITH_ARGS) || defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
+#define FPROBE_USE_FTRACE
+#endif
+
+#ifdef FPROBE_USE_FTRACE
 /* ftrace_ops callback, this processes fprobes which have only entry_handler. */
 static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
 	struct ftrace_ops *ops, struct ftrace_regs *fregs)
@@ -295,7 +299,7 @@ NOKPROBE_SYMBOL(fprobe_ftrace_entry);
 
 static struct ftrace_ops fprobe_ftrace_ops = {
 	.func	= fprobe_ftrace_entry,
-	.flags	= FTRACE_OPS_FL_SAVE_REGS,
+	.flags	= FTRACE_OPS_FL_SAVE_ARGS,
 };
 static int fprobe_ftrace_active;
 
@@ -349,7 +353,7 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
 {
 	return false;
 }
-#endif
+#endif /* !FPROBE_USE_FTRACE */
 
 /* fgraph_ops callback, this processes fprobes which have exit_handler. */
 static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
@@ -599,7 +603,7 @@ static int fprobe_module_callback(struct notifier_block *nb,
 	if (alist.index > 0) {
 		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
 				      alist.addrs, alist.index, 1, 0);
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#ifdef FPROBE_USE_FTRACE
 		ftrace_set_filter_ips(&fprobe_ftrace_ops,
 				      alist.addrs, alist.index, 1, 0);
 #endif
-- 
2.51.1

