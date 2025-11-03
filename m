Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82363221DB5
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Nov 2025 06:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762151683; cv=none; b=Rt8aic24wux6ZTk7COHCYoBogxfrcbe2n8zhmx5TxsyzEk0Bg3UoFbpTl+j5gDAZEGnhcED+WyOL3hBf0LB/xv75EckcAkHtrqriFlF3nFbgTIaOMAYS4k+dXs799M/73clEqK0z/R0+eQ7xK+QkHn0ZyBUPKA8clz97IQ99tLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762151683; c=relaxed/simple;
	bh=l3X8/HCu2jjhNwfqprnRXqlwt8o4gif9BBGKVwAZJ08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WPFxgEtdjv+Q/5i7ppSPRAZ3N76ZU03nCwzyzGRbdYrqXdRg5QvBRahI6hE5T7tW0xmqLHEtv7XtKI1s4VPATR9OQbnVKL2wlGuyIaZ6f/7LEnt52jKIpcojeavmfRBKiDvwWjADW723rsLFAhAlby5XxOmdKcyJ8Yzdkl0mqqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csO3V6h3; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csO3V6h3"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-340bcc92c7dso1407523a91.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 02 Nov 2025 22:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762151682; x=1762756482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y0cklwjYFWwcH/zJRyQ1Tmvs7zr5qVecrRqFbTLGTgg=;
        b=csO3V6h3o3x15USzxQ5voMe3noUZam+etJBf4n4K3FD9VM7PZVpmgizgDpd++bHvc+
         I3Y5ulJV0hHyiFnYDmJXYXEIGZTAsVcOqTbOGMKJDUKtwrpd1FD+8PjCK1tMDxaOzbxD
         l92/SZllYLZb5kJuBsOhG1d4TVaw7UQYnxg3HBHZqSadeT4FmWzUrE5pt719+0AHCWAx
         yIJLk8jT8iz3zfsQm3nep7Hf6nuFwiB6CaZUpG2cAOvaBtp+tJENb4vDqQnRDpk/kQDK
         T11t2gndNwgcN7lFe506tcWowAPP7qovAuJIF4AGtw1W4Dxr8cpF152W/PKIGbeJhGia
         I/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762151682; x=1762756482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y0cklwjYFWwcH/zJRyQ1Tmvs7zr5qVecrRqFbTLGTgg=;
        b=CGtlW9Y9jmQkZa+EHhW1Y0f/5JqpNPa+zYB0xCS1bewnmHg0rU1tgjxuh2RNYyDOaV
         tQ0liMF3a+vZqqTEg3TwvPEvikjOvxdNXRcBmW8ooX1YBKELQhW/gCeopJp1X2Jgs6Z+
         BhIxEdmiCaIYYK6BNvYJqVW2gRYJPKAs1x/8RyrYyLiOC9CycA0gozfTRxZ2PO6sg5Zi
         m28FWmr7SzD0yuWyJCMrT62IIB+GbIdeEbUvuWPxKCW9iV+kwrkf7uY4JL9zjlhjCWg1
         hNSVVemumpj2tv3rnwOPqpbRswTnpx5INx3tcBBpwX4ocNBruWOpbjyG9gxFkCCvTcKs
         gUHA==
X-Forwarded-Encrypted: i=1; AJvYcCWqteL/XzEaFGXFZ8T1w9d80sKg209ST5dfnCLEA0k2b4sbjny4K+FN3jxW7yanRz7c+IJc4G7i/uya0dXYUVgtD2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvt3Y4+31SBSwyvEmpyjtfcoSacIf9OpXh7Ue40e0hj5U+4fwG
	OtP2xZ2fsMUIjbimyQ7l+5803WKX6+F7aHMUmTLimJgeEZIsdiw+qPvr
X-Gm-Gg: ASbGncvsNxT50Yx25dKPyjACSz977PpVzQHcEUozdcYRkp1gkKIWfSvbaPUvQnJ+Vu/
	K0MGfhdujGEUQqyFsLTNxB/WAde2al+ung72y7WLRzSFbcOZsCp/rCMp2kV/QwZVhFSlomtPRmF
	hpuLiDjuTSkJxI14rynLqcmZrjodEskJQWLs8GU++wgfEvxOwIvuxqO4vjwf/1cYf/vjEtvn4PV
	I42GC0W2d/gJbdDBG/WsUHTD/YQVAlHTerNX6i6XUeM5vrM7W9opHspgdT/WzK+EIEpkGcvhSkZ
	J/jcvx3K7D+LsUc0Z2yQ+z5xWKqGeAGcLCeXYI6mxp7G+nsast9qJUG8gj3o8jfsai320TBrKUc
	qXwqDS7aF25iPq+24WuYMqy9gL59P+OpVlMJmxr5KBcFLuVF19xlYmnQQCmNqsjcBUUX3WpmHh5
	pS
X-Google-Smtp-Source: AGHT+IGdj6Fh9qiNLzROwa+IJ6zR12Ju+TaxMNk+532E7LVd24e4IdXGR46tFBhnzHEeLr0aBGl4vA==
X-Received: by 2002:a17:90b:6cd:b0:340:e8ce:7569 with SMTP id 98e67ed59e1d1-340e8ce7685mr5427076a91.12.1762151681569;
        Sun, 02 Nov 2025 22:34:41 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ab5ee9fde6sm1777415b3a.45.2025.11.02.22.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 22:34:41 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	jolsa@kernel.org,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3] tracing: fprobe: use ftrace if CONFIG_DYNAMIC_FTRACE_WITH_ARGS
Date: Mon,  3 Nov 2025 14:34:34 +0800
Message-ID: <20251103063434.47388-1-dongml2@chinatelecom.cn>
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
v3:
- fix the build warning when CONFIG_MODULES not enabled

v2:
- remove the definition of FPROBE_USE_FTRACE
---
 kernel/trace/fprobe.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index ecd623eef68b..0b1ee8e585f2 100644
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
 
@@ -335,6 +336,15 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
 {
 	return !fp->exit_handler;
 }
+
+#ifdef CONFIG_MODULES
+static void fprobe_set_ips(unsigned long *ips, unsigned int cnt, int remove,
+			   int reset)
+{
+	ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, remove, reset);
+	ftrace_set_filter_ips(&fprobe_ftrace_ops, ips, cnt, remove, reset);
+}
+#endif
 #else
 static int fprobe_ftrace_add_ips(unsigned long *addrs, int num)
 {
@@ -349,7 +359,15 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
 {
 	return false;
 }
+
+#ifdef CONFIG_MODULES
+static void fprobe_set_ips(unsigned long *ips, unsigned int cnt, int remove,
+			   int reset)
+{
+	ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, remove, reset);
+}
 #endif
+#endif /* !CONFIG_DYNAMIC_FTRACE_WITH_ARGS && !CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 
 /* fgraph_ops callback, this processes fprobes which have exit_handler. */
 static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
@@ -596,14 +614,8 @@ static int fprobe_module_callback(struct notifier_block *nb,
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

