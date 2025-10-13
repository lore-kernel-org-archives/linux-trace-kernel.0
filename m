Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6406526CE3C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760320342; cv=none; b=Azv8Igxr/bgQ6bz+bWyibEviCM3s92x1Zc5uiR1SGF7B0t+jhQLci+RzC1awsvTzG7YDpXxalucId1zu0ZWkqAMVGURBdgoh0H69YDus19PgYWZW55mQZ0fa6jyTXTRJZ1sK7KAjv551rh7dzZEU4hf8+NCgBq6AQUrjzM/85s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760320342; c=relaxed/simple;
	bh=0ik3H27UNRE+ExKUAWRj/tEyb714XStPlG+VbKW6R0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FSOxLucvAaI4VJVm89hItdaGrlt/Vwf++NmkJ3ShhxlqMe6fQBhoFLwJ0SPRkMXcH6Z1yKXM0qEe0saNJIEUFOkEPNvfNdfh/U+WPKTyv5Szknb/WFYNIQWRB9PIQZ/h47oeOA0dA2EPr+m/akeQxUFNxFbNAg46DO8bZwbVw0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxhn/wxQ; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxhn/wxQ"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-28832ad6f64so41062225ad.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760320338; x=1760925138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zj6tK1V/4VHMz9n6jIia523IIMIYEY9cFEmoYWPFnfU=;
        b=cxhn/wxQ47Cb3BNng1ohtkEsslInS16FmRoYw3d/WYXxpMJXV2u+TDVE//yFMaZlWq
         WrqfkIS5v/RWO2pF3NMU3nzZ9xkUuCko+fq1SSM+E65JyEcKv1TfjXZd5TvWNqZI1xNW
         2dLF15Fmcj8tZUfTMXrRu4a9DmdICp8qnKZvr1DYExwy2RHGQVKEs2Vc3a0VMnKqN900
         xUjnwx6E3NMNSCX2gcStELgZ77MWCjh+4MjSPK3TwTqzamVCjpGiuKtx0M2tIZwHdQXJ
         hAdQnU4wbpsv6gUI7AUVxu+/CKPdjzQsre+UDc5YXPW4oU0y9Y+t03p7nUVdAe5AjsIS
         r7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760320338; x=1760925138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zj6tK1V/4VHMz9n6jIia523IIMIYEY9cFEmoYWPFnfU=;
        b=WyYQDeXysImwUiGPaIy+C1Eb+lGDjfPD5cEg/tzRcHOmbWlPMZf/lMdoAhfdizU9z3
         fGn55T6890zt/LikFNwYQ4vt74rwNpnkm8sPUnUK3R0g4Ud60iw9wVjYr1fEJt1Lu34h
         oSNXE7nMr5LNetRxRnquLZ5ELiUzZhzyMAEumq6fA45JsOt8XAnpFZZs4P+ulu221FkL
         oc5YRXAD6JWQ1sWtmSb1iuH6xSlRbGezOZIxbVOn4PQURZ9Sqf705YSRlBeJ9Zn6sOfv
         8QAhdav3+oLehmvrvvNDm98dCwqoXFZuH3J6BMwlYOjdyXGgdqUt/6LwF1Jq7cQhyvSY
         Vaow==
X-Forwarded-Encrypted: i=1; AJvYcCUVovJ8+7qDxHJyDklNvNJiUUzsfngQCdYOONTYa47SPzfBCAOXngTNJ7tyvy4xMtp7VMG7Sk5FRZEHE5FIT53Fgtk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3MGKcWhz5i74Dvk4n8JP/WRdH1KtU1/WJfre4w3a8dYsTObGj
	IOqNfpqpcOIILUA/YklS/bh7eWaqBZHZ0LidwDasGXxTui5SsNfwvWeaRj4qmw4Q
X-Gm-Gg: ASbGncvRZas5HDbU4dkqgwBrCHW/0phy3FhsNTMRMAy9sYlDKw3RcaImkfKQW2ku2zf
	0/Q7ECvF9IWlU+w0U33VWhRH66XwWW9u0KamVwmPAUGo4ehjN+ZwCteo3mtFHTmzrW22so7DJ2M
	x4w7/0xqE+66gcYdmirKgKncptEdrip+v4n14Llne3lawGeMv251mS4xwFolH4Q0HCRBCxkZ4yx
	/Ye+WaPd/pn9iNyP7uHkMzsgEG7ObM0KVk6ZHiyXtzzuDbPcIJAuCXmqghUQeCRWmLaFi0afmFs
	X0rifbPb7hksCMzsv1QA0sfKSG+mae5sTNlQcSbNZ2Awpl49I007o1VRpBmmH9TkGVjJvYf9sJm
	+fSTAGCiSGJyNHq0vpj5KHl2nK68/nrK/S+e2nekiuPnGkZxY7suQ
X-Google-Smtp-Source: AGHT+IEkHuwtHGCVb3KQH7p/KEDNupgikQ1g8RqG2TQVMHAYFAyUOGsvqlTsC9cN+QSF4E2v5Or1yw==
X-Received: by 2002:a17:903:1a03:b0:267:a1f1:9b23 with SMTP id d9443c01a7336-2902723ff44mr247637635ad.18.1760320338430;
        Sun, 12 Oct 2025 18:52:18 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034deaa54sm117224925ad.5.2025.10.12.18.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 18:52:18 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] tracing: fprobe: optimization for entry only case
Date: Mon, 13 Oct 2025 09:52:08 +0800
Message-ID: <20251013015209.30949-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013015209.30949-1-dongml2@chinatelecom.cn>
References: <20251013015209.30949-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For now, fgraph is used for the fprobe, even if we need trace the entry
only. However, the performance of ftrace is better than fgraph, and we
can use ftrace_ops for this case.

Then performance of kprobe-multi increases from 54M to 69M. Before this
commit:

  $ ./benchs/run_bench_trigger.sh kprobe-multi
  kprobe-multi   :   54.663 ± 0.493M/s

After this commit:

  $ ./benchs/run_bench_trigger.sh kprobe-multi
  kprobe-multi   :   69.447 ± 0.143M/s

Mitigation is disable during the bench testing above.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- add some comment to the rcu_read_lock() in fprobe_ftrace_entry()

v2:
- add some document for fprobe_fgraph_entry as Masami suggested
- merge the rename of fprobe_entry into current patch
- use ftrace_test_recursion_trylock() in fprobe_ftrace_entry()
---
 kernel/trace/fprobe.c | 109 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 98 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 99d83c08b9e2..18319c22cec4 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -254,8 +254,9 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
 	return ret;
 }
 
-static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
-			struct ftrace_regs *fregs)
+/* fgraph_ops callback, this processes fprobes which have exit_handler. */
+static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
+			       struct ftrace_regs *fregs)
 {
 	unsigned long *fgraph_data = NULL;
 	unsigned long func = trace->func;
@@ -292,7 +293,7 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 				if (node->addr != func)
 					continue;
 				fp = READ_ONCE(node->fp);
-				if (fp && !fprobe_disabled(fp))
+				if (fp && !fprobe_disabled(fp) && fp->exit_handler)
 					fp->nmissed++;
 			}
 			return 0;
@@ -312,11 +313,11 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 		if (node->addr != func)
 			continue;
 		fp = READ_ONCE(node->fp);
-		if (!fp || fprobe_disabled(fp))
+		if (unlikely(!fp || fprobe_disabled(fp) || !fp->exit_handler))
 			continue;
 
 		data_size = fp->entry_data_size;
-		if (data_size && fp->exit_handler)
+		if (data_size)
 			data = fgraph_data + used + FPROBE_HEADER_SIZE_IN_LONG;
 		else
 			data = NULL;
@@ -327,7 +328,7 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 			ret = __fprobe_handler(func, ret_ip, fp, fregs, data);
 
 		/* If entry_handler returns !0, nmissed is not counted but skips exit_handler. */
-		if (!ret && fp->exit_handler) {
+		if (!ret) {
 			int size_words = SIZE_IN_LONG(data_size);
 
 			if (write_fprobe_header(&fgraph_data[used], fp, size_words))
@@ -340,7 +341,7 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 	/* If any exit_handler is set, data must be used. */
 	return used != 0;
 }
-NOKPROBE_SYMBOL(fprobe_entry);
+NOKPROBE_SYMBOL(fprobe_fgraph_entry);
 
 static void fprobe_return(struct ftrace_graph_ret *trace,
 			  struct fgraph_ops *gops,
@@ -379,11 +380,87 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
 NOKPROBE_SYMBOL(fprobe_return);
 
 static struct fgraph_ops fprobe_graph_ops = {
-	.entryfunc	= fprobe_entry,
+	.entryfunc	= fprobe_fgraph_entry,
 	.retfunc	= fprobe_return,
 };
 static int fprobe_graph_active;
 
+/* ftrace_ops callback, this processes fprobes which have only entry_handler. */
+static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
+	struct ftrace_ops *ops, struct ftrace_regs *fregs)
+{
+	struct fprobe_hlist_node *node;
+	struct rhlist_head *head, *pos;
+	struct fprobe *fp;
+	int bit;
+
+	bit = ftrace_test_recursion_trylock(ip, parent_ip);
+	if (bit < 0)
+		return;
+
+	/*
+	 * ftrace_test_recursion_trylock() disables preemption, but
+	 * rhltable_lookup() checks whether rcu_read_lcok is held.
+	 * So we take rcu_read_lock() here.
+	 */
+	rcu_read_lock();
+	head = rhltable_lookup(&fprobe_ip_table, &ip, fprobe_rht_params);
+
+	rhl_for_each_entry_rcu(node, pos, head, hlist) {
+		if (node->addr != ip)
+			break;
+		fp = READ_ONCE(node->fp);
+		if (unlikely(!fp || fprobe_disabled(fp) || fp->exit_handler))
+			continue;
+
+		if (fprobe_shared_with_kprobes(fp))
+			__fprobe_kprobe_handler(ip, parent_ip, fp, fregs, NULL);
+		else
+			__fprobe_handler(ip, parent_ip, fp, fregs, NULL);
+	}
+	rcu_read_unlock();
+	ftrace_test_recursion_unlock(bit);
+}
+NOKPROBE_SYMBOL(fprobe_ftrace_entry);
+
+static struct ftrace_ops fprobe_ftrace_ops = {
+	.func	= fprobe_ftrace_entry,
+	.flags	= FTRACE_OPS_FL_SAVE_REGS,
+};
+static int fprobe_ftrace_active;
+
+static int fprobe_ftrace_add_ips(unsigned long *addrs, int num)
+{
+	int ret;
+
+	lockdep_assert_held(&fprobe_mutex);
+
+	ret = ftrace_set_filter_ips(&fprobe_ftrace_ops, addrs, num, 0, 0);
+	if (ret)
+		return ret;
+
+	if (!fprobe_ftrace_active) {
+		ret = register_ftrace_function(&fprobe_ftrace_ops);
+		if (ret) {
+			ftrace_free_filter(&fprobe_ftrace_ops);
+			return ret;
+		}
+	}
+	fprobe_ftrace_active++;
+	return 0;
+}
+
+static void fprobe_ftrace_remove_ips(unsigned long *addrs, int num)
+{
+	lockdep_assert_held(&fprobe_mutex);
+
+	fprobe_ftrace_active--;
+	if (!fprobe_ftrace_active)
+		unregister_ftrace_function(&fprobe_ftrace_ops);
+	if (num)
+		ftrace_set_filter_ips(&fprobe_ftrace_ops, addrs, num, 1, 0);
+}
+
 /* Add @addrs to the ftrace filter and register fgraph if needed. */
 static int fprobe_graph_add_ips(unsigned long *addrs, int num)
 {
@@ -498,9 +575,12 @@ static int fprobe_module_callback(struct notifier_block *nb,
 	} while (node == ERR_PTR(-EAGAIN));
 	rhashtable_walk_exit(&iter);
 
-	if (alist.index > 0)
+	if (alist.index > 0) {
 		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
 				      alist.addrs, alist.index, 1, 0);
+		ftrace_set_filter_ips(&fprobe_ftrace_ops,
+				      alist.addrs, alist.index, 1, 0);
+	}
 	mutex_unlock(&fprobe_mutex);
 
 	kfree(alist.addrs);
@@ -733,7 +813,11 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
 	mutex_lock(&fprobe_mutex);
 
 	hlist_array = fp->hlist_array;
-	ret = fprobe_graph_add_ips(addrs, num);
+	if (fp->exit_handler)
+		ret = fprobe_graph_add_ips(addrs, num);
+	else
+		ret = fprobe_ftrace_add_ips(addrs, num);
+
 	if (!ret) {
 		add_fprobe_hash(fp);
 		for (i = 0; i < hlist_array->size; i++) {
@@ -829,7 +913,10 @@ int unregister_fprobe(struct fprobe *fp)
 	}
 	del_fprobe_hash(fp);
 
-	fprobe_graph_remove_ips(addrs, count);
+	if (fp->exit_handler)
+		fprobe_graph_remove_ips(addrs, count);
+	else
+		fprobe_ftrace_remove_ips(addrs, count);
 
 	kfree_rcu(hlist_array, rcu);
 	fp->hlist_array = NULL;
-- 
2.51.0

