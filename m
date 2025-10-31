Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E34DF59
	for <linux-trace-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761878447; cv=none; b=jhAX21ntuo03mqOkyPY5pD5L2ksHpar4HmJLbHQG7eGMo5IjtODReL4CCgDj9STcqC4IM+72X7ZhPvyUsn34qN4yqxWDL1NYrRNrrKFC8V51pEXyWOLY/Cy5exUw0ZIP8UW6fvoVk1hq1xv53Np4+KGhS4++uN8VJMaOd3dKuTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761878447; c=relaxed/simple;
	bh=V4fan6ifo57XShWUrTfgLxH3pyZdblBrZqYmodxN4+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aMlDYkHQCafl6BR1b7+9lXQgy4D9LQlZGFVcbwaxIYKTDXRMxtcTz24KOGRmUW241CIQEMDunaHY9ZJ2FjP5O5K46FgjAYv5/BAcDe5sP7yxFXlYD7JWstXvawLjIKarx860wuSd6zqdVefczeQka3+oXnS2In11SEx/OAxQOdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxsJ7PJa; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxsJ7PJa"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7a76584ea6cso712361b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761878445; x=1762483245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+0g8Q4oacvJiVCUu5jT6eNzJvI0Wx6VvcTz7epY3njs=;
        b=DxsJ7PJa2BFzNXvG8IRltFuDt0Lyg8cSk03HyMp5ggd9tjvthAByOXqr3lJKyLg4Ga
         CyKn/PJGCrdPXk7N152c2QNbMSf3UzwnEdZ5zDDZmykMBo8zEvPWCBmzoN1zE1CiWPYt
         PpUheGz19Dn1YDzzCpztTUu5Fxn6T4lW/MNZ7ypwEHTRuz/MQyf+tPhnO2nv33JE/WYG
         mBoC2dvXskG8uvuniZPnSFWGiCeCBApjr0ufLowyTy1Y/3Re4NHwbEVMI1Sz7p/bxC+5
         TnAQt9Ju3ggpqUWbktjPQ3sqSsoqjx3I2PXlkwynJ/357qXLOw33ETIpk4bwOyIG2iYI
         w86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761878445; x=1762483245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0g8Q4oacvJiVCUu5jT6eNzJvI0Wx6VvcTz7epY3njs=;
        b=Yd7b700BNlN/oOLFlvcYmnh+7ofsyON/j28VnklluQiEpHp3ry6cqPM7/pYDQbiDi8
         +2hyC+55Dtkr1G2IDkY7belgV3Q/LKMrgx9Cib/kCIf95gg5Nt02oRRqdeDJKhYNaGvi
         BKuEuJrlYmFKc9nawiA54YdPQckfVebGDWDj681kdGXpS12Mk8udJrKRghW++Le7aPmj
         0969ZHuB405xFmS6VYmZO0V02xddV2AYKIDOemLX/cHdkjrEhXITcUnYoxIxKXkm68sz
         /mq1EgdouJugmeLO+jun/PGqaYsUktof5bm51yWI+3jMFcBv45oPSiTNPYTsG+lMf82d
         2bnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWESGKFQshS2+THYtsE0XvlayzwY8OFlNzgO7haGbM/gYvP+sMUgW2VyxDlK95JGThTcvw29wSkX2MsbT5WDIGuw7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTEkAYdSMEfmHzgrsFemaqPYEKt/dNW7IKzTa4U/DrumUMLK8Q
	P6T95Vc+PvwupCSKP2CWPnhe/PcgB678x4AQRCO0c4mM39OGKAJ7oH/B
X-Gm-Gg: ASbGncsreIOo1rHLdZarpoSoa5uRgkW0vW6QldZ9ZSncBZU4UzP1vAdWePfnig6/8/h
	mSxx134zvtlYS92Ohw5f0w6de7paYcpCwglH+7ShNw21d7NmtyiaWACWh90CssGl0xonhu1hoyS
	ILQ6hAJDkJQILxTxdIQfmDjJXLkPdBF7/OBLFOzZHlP3Wojy88g9rkmk14UUVVHqb9FLVyF0/HV
	UTK5lE6oxZlUvTycnto2EEamVVmF+2QarsvlnK3eXDHLwc6rsScfL6GNgwDctI6XqDB+h6f2u2X
	toTpRPBMURryeqYD6ocdX0X8KajMP/uYmVud0vT9IG8Mg7035LFzthcoNbd69b84c8SHq5IhRMG
	kuJ3IAnDOgFX0KMq2DeXI6iCBnjgbkQZZsMRYvD36taM+GxgQFcEwukjf4sAWbKBWkGIPWgU6uz
	KX
X-Google-Smtp-Source: AGHT+IE2dwWl+UqU/2jHsr+dNB0RhXouXi22/6xEmRbNmFKZsgsQb5/Wm+bdh0VbO9boH90BBpo6ZQ==
X-Received: by 2002:a05:6a20:914f:b0:341:1dc6:aea with SMTP id adf61e73a8af0-348c71e515fmr2849408637.0.1761878444858;
        Thu, 30 Oct 2025 19:40:44 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93b7e19884sm362557a12.7.2025.10.30.19.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 19:40:44 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	jolsa@kernel.org,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] tracing: fprobe: use ftrace if CONFIG_DYNAMIC_FTRACE_WITH_ARGS
Date: Fri, 31 Oct 2025 10:40:38 +0800
Message-ID: <20251031024038.19176-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
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
v2:
- remove the definition of FPROBE_USE_FTRACE
---
 kernel/trace/fprobe.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index ecd623eef68b..742ad5a61d46 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -44,6 +44,7 @@
 static struct hlist_head fprobe_table[FPROBE_TABLE_SIZE];
 static struct rhltable fprobe_ip_table;
 static DEFINE_MUTEX(fprobe_mutex);
+static struct fgraph_ops fprobe_graph_ops;
 
 static u32 fprobe_node_hashfn(const void *data, u32 len, u32 seed)
 {
@@ -254,7 +255,7 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
 	return ret;
 }
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#if defined(CONFIG_DYNAMIC_FTRACE_WITH_ARGS) || defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
 /* ftrace_ops callback, this processes fprobes which have only entry_handler. */
 static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
 	struct ftrace_ops *ops, struct ftrace_regs *fregs)
@@ -295,7 +296,7 @@ NOKPROBE_SYMBOL(fprobe_ftrace_entry);
 
 static struct ftrace_ops fprobe_ftrace_ops = {
 	.func	= fprobe_ftrace_entry,
-	.flags	= FTRACE_OPS_FL_SAVE_REGS,
+	.flags	= FTRACE_OPS_FL_SAVE_ARGS,
 };
 static int fprobe_ftrace_active;
 
@@ -335,6 +336,13 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
 {
 	return !fp->exit_handler;
 }
+
+static void fprobe_set_ips(unsigned long *ips, unsigned int cnt, int remove,
+			   int reset)
+{
+	ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, remove, reset);
+	ftrace_set_filter_ips(&fprobe_ftrace_ops, ips, cnt, remove, reset);
+}
 #else
 static int fprobe_ftrace_add_ips(unsigned long *addrs, int num)
 {
@@ -349,7 +357,13 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
 {
 	return false;
 }
-#endif
+
+static void fprobe_set_ips(unsigned long *ips, unsigned int cnt, int remove,
+			   int reset)
+{
+	ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, remove, reset);
+}
+#endif /* !CONFIG_DYNAMIC_FTRACE_WITH_ARGS && !CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 
 /* fgraph_ops callback, this processes fprobes which have exit_handler. */
 static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
@@ -596,14 +610,8 @@ static int fprobe_module_callback(struct notifier_block *nb,
 	} while (node == ERR_PTR(-EAGAIN));
 	rhashtable_walk_exit(&iter);
 
-	if (alist.index > 0) {
-		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
-				      alist.addrs, alist.index, 1, 0);
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
-		ftrace_set_filter_ips(&fprobe_ftrace_ops,
-				      alist.addrs, alist.index, 1, 0);
-#endif
-	}
+	if (alist.index > 0)
+		fprobe_set_ips(alist.addrs, alist.index, 1, 0);
 	mutex_unlock(&fprobe_mutex);
 
 	kfree(alist.addrs);
-- 
2.51.2

