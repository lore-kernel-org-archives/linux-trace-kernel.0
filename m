Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F66D271450
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Oct 2025 03:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067542; cv=none; b=Y199RW7vuhIPeISWkRoDJkfpzLzDmdaDU+g5bFqzcPAnQsLNHnn3Jxc7kxTPtNR0+3dT12Hd48BdqFl9SqqXGIo1L+7fmV1roHw7dEwxcWW9KREp2gMiYS32ZdnVDDLqxlbn0rSw9xAgrjSg0ZjiaMzUV4tSLU6pNmuSQRgKO8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067542; c=relaxed/simple;
	bh=BpJi/vaZmaMrSd2P2X1czVc4BiMq7wfJtbSVngqW5m0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XVKnMy1kx5LcXtIP4OIQ+ibbdbRMUGobrLXe1vzzySuBl+9yXt05e8wHYP9cbgb1SWE+07XI6oHSq/D8LEO2rGKOze3CTACvFFsdfVZjr8EYYHIrS8qUWVBwJBWhnCq0Jj24bBKjP7HLWfNuUDPVgvoP7aHzOsBXw62v1am22Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsvWAjRA; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsvWAjRA"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-794f11334adso1448835b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Oct 2025 20:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760067539; x=1760672339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtrdkRoYKffOfWTuEywjN8EL4Ba6ONqO4F8W9HPcWYc=;
        b=hsvWAjRAGwQSOiRVOj7znFPqa11b/PNFnvWStn0BVQWrO3mYqGPn+9CiHhqbv7jhOQ
         qv0YToW3sKC+jUkjsAtvJzEfMK81kPHhIBzdXrcXaCWoQdmV/iZ3skeeb/q6n7RPWBCy
         aetRG2PXaAnGljzDPqYxI6otWwQAb2/Ba0NMK+7P/rl09FQfnKJHxmBcnKpN8Bg1EWbi
         JT6/jHKj9QQ2i8NyYh0Vhl/yjkHEsv+2HLn4k901/l1SRSvjS9EA+16/IQkkYqg+nAcc
         NA3FBmFdXpqXdNvVQMpvBkfkr9R//Nj3YcWHuNUBjaxmvc8+yMzahKLxWNugKKO5js00
         4aEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760067539; x=1760672339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtrdkRoYKffOfWTuEywjN8EL4Ba6ONqO4F8W9HPcWYc=;
        b=VftrmUuyrpAjBQd7dLobsjp3YrC2DexLA1qu6OsqUhOMdgDsEX/TubNeeNwlpI0wuV
         /Z8own8d0+eZ1R/UbB73PVStM40zcxTbjWhruhqA8mPPl+jIi1IhElr1CCL/YxMz7pRC
         Hxxdp3rGCxTgkVg4MuOifXnkFm8iZhSQYcyXkEB+e9TRuAGXuAzwFgcregAWElXI/q8V
         uSweyck4NejVLfibT+07QiX4OWkCv5s0JOuEbXkpppNdPsajEGgb8pSWdqXmL9vzqVdD
         mhzB4AQm0fXBoBknxOGRdcScbQxgzovITtE09xsHg3x+sMeHuygHtjlP76r6sVjMf1qE
         FErg==
X-Forwarded-Encrypted: i=1; AJvYcCVnDye+cmfctbtlKuYPELOMAOQS5ysUV2eobzlOx8nnJPXKwn6dq1dEZmDFvZirdNrCaqrNnOMBDINEq/AWUO5wsvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySYT3TQxQzs73rVLEN4IEckUMgaYBoZmfFpixRxAvu9YqB1jGh
	6+nHvMmuFnBWOfWuAw7no6P7Qh1EskmPTAdQQFuHkzRq+7PkGJFzt57v
X-Gm-Gg: ASbGnct/IZfavEUTGrM3z/5ov4WNWlMRWEmfSSA7mLKjifykIGHdbHRvlHL8I/eRa/e
	iUjvHijQUKckCyFyHI6VdhKLQ9IEGZuxvFCgbg5tU58i+k8UhZzHGmS9AkYidghOqFHnS2fI3ok
	gTQX3ejX65dLRpNB11LUCv5SFh7ADERWJH56ySU6xtZTVRJzEsfpDPtD5vdA+0wdggaiippXO8z
	uxglp3S4/dCyxmXK0BgPthFvOH+r8BGmtdM/536BkdE1+T4658Nmyt/vPeQEWK+VrZ2CnQv5n6E
	hEBvyYIfu7KlyNFyprD8Qn9zblBDBUjSaOLPu8z68CVTCGqQ9sBTbXDtdvseHqekWue7MqLY1Th
	PtjFg56ZLrDS8g9gN4LgWIzYCbpxKWIqmbNuyDWXfkFzDzLTt
X-Google-Smtp-Source: AGHT+IFtBEHP618h3t53kD4WHUk6lpqNdymniKN8BAkFUVnrFnhXgl8zSMIDyAukKdjyqa7r+hV2CQ==
X-Received: by 2002:a05:6a20:3d06:b0:251:1b8c:5643 with SMTP id adf61e73a8af0-32da845fdf3mr13573976637.50.1760067539326;
        Thu, 09 Oct 2025 20:38:59 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d993853sm1260148b3a.74.2025.10.09.20.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 20:38:58 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 1/2] tracing: fprobe: optimization for entry only case
Date: Fri, 10 Oct 2025 11:38:46 +0800
Message-ID: <20251010033847.31008-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010033847.31008-1-dongml2@chinatelecom.cn>
References: <20251010033847.31008-1-dongml2@chinatelecom.cn>
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
v2:
- add some document for fprobe_fgraph_entry as Masami suggested
- merge the rename of fprobe_entry into current patch
- use ftrace_test_recursion_trylock() in fprobe_ftrace_entry()
---
 kernel/trace/fprobe.c | 104 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 93 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 99d83c08b9e2..bb02d6d09d6a 100644
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
@@ -379,11 +380,82 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
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
@@ -498,9 +570,12 @@ static int fprobe_module_callback(struct notifier_block *nb,
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
@@ -733,7 +808,11 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
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
@@ -829,7 +908,10 @@ int unregister_fprobe(struct fprobe *fp)
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

