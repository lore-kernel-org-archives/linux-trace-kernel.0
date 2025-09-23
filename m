Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8019D31D373
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619211; cv=none; b=swXfH0jmU+SD329QihXJtzYa2Vp9By4+zrGOF1vFHx+AS/ign21VVu80vhKCw6dGjOo1VC91Vk5WyVABpgYFgmwDEWIuFo4m7aG9UaFitwo1t2DtYeFcaJ46D0Vpko2jeBETIvYDErHlTb4gguoMCMUHR9H1BU1E8tXmMGE+NdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619211; c=relaxed/simple;
	bh=5pnjXc/9ZbmjjTrBgjp8P0EtDaAx5Q8QwP0wZtxZOA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G772245APeU5FjbU1adjyR7+WRjq4+4uKdbK7I9CocEE7BW0Gjl7jsZOKEK/0S9VKr59kCde/Ddf+FM76KJq5J9JUcXBoEG4lW1LCgtk9KqiGxMzcqPcmNZPUNCNANeVatB7wxrMAQRUugA/KT4fSfooB9J8hB6SYHEu11mqECo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWhz9Kj7; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWhz9Kj7"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b4c1fc383eeso3591788a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758619209; x=1759224009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaNfaBqm37JCuf2+6crFN8tXW1LJyt91pScqJZvXw60=;
        b=NWhz9Kj7/t9cH5P8i8XyscVK9005WZTn6fLtpu9EVBmLAdHM+8Qh2a9qFAqcfzTKMv
         QNTO0VEdjLJBxBG5AQFIZ9Elp7Zd5rDSOw8N4pmtyaTKPEf5lxmsNW1nwYF560/nb7+o
         mUuzhpfpf6Gmdt+RLIK+IydQf/zutgIRagn0Mm+2Tl+q4Bu/6kP+qXxnA+sZ91oTnwlE
         Xr+dVMX8UeLoK4PpHrX4rB77mTvjhp3MW9xC8JFqyd7l2ebSW82A7x/eXZcJhVApC4Tc
         /AbyBVmi316kV52ZEF0GYsFnMl/3NdHYVQr+QR81T5mulzsuQNjFM2iYe+KS4HVo9iHk
         YHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758619209; x=1759224009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaNfaBqm37JCuf2+6crFN8tXW1LJyt91pScqJZvXw60=;
        b=LzqMov4Lq/WwraGmk9qD5VyPDpRwwv+Nx3oXL+WfV+ipRNqS02w19Va2bLsgzKTy/G
         B3iyZ34xjAUoqNOY3OwwI/pOEFPBJVikN5OQQQ8qcDqryMyWScIFgxl7tZl5aG6hFugg
         YuPpRIpoHvEKs846amFU0Q4Diaxs5+eruVy9Mm7wElJlKjABSlINSgL6Rki/2uARo8AQ
         c1v5wd20isTDcDzMj0jlANlOROwM3K7w+zR0T/2AVx/xgDh8SA/VVFc674axYX80Mj4U
         JpLgOMQdZ9HpOA9Aj7g2inYbssGKni/xpQRmlRvsEC7g12M0gMr21z4utQ2oRQUIOJua
         PXoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaG+EWNRaIe7TsvW+HHA9YB2kFALYKgkoSNtY4FERoDCO+sjOfzc5MxI9+nzWddBhJ+ZwtThq+x0Wzb90/8w1F8zI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj4rFte5j6RvI4DzLJwpKrHPtxRnBAQpcqr4xgid1KEZmXDusK
	o/fIS2h80qWP6fJZ017EtsPUqghfHq/Jr1iYOLR3GJd7DXfnCK0EN6kL
X-Gm-Gg: ASbGncvXcYsOZz0nMi0zDHuQJxWwg7XUHgiFslSHB18r0hIZqwTif8srQrIoHwiffom
	HxUZh5xAdAXYgjI/AWumqLmMh/rBqEbmACAYwT4HNUPjACIsXcvE1riKeMGSL2qbg5N69aizNk0
	tq8ClPE965mLZEq9maozEenvW2DvFKirTcyQWBoc6TXrWhZlr1iGu5ZYwT7n6Up2KfQCyqLOTTB
	5jZPy7+dyFos420gVNcuFzsGn3i1DQzcoagTi70IPUKLCdZKE5TF/4g2nod+yaIGbss9tNtFvTS
	fmg3HYSeLh0/vAyohUYCMFcsjIoe6Pxl8JJxAOGkCDGixjY4afU7BIv7OzFx3dq/f4ZAb9zbWma
	uxOopvCMWy+qOf+HCeYE=
X-Google-Smtp-Source: AGHT+IG3ynY4UK+SsdUVSWoFpGYbb21gaKH0sSIJYddvHUwrQq+l84afRbdI1AvvJzx7siPBXaqARg==
X-Received: by 2002:a17:90b:2243:b0:329:cb75:fef2 with SMTP id 98e67ed59e1d1-332a94f538bmr2369393a91.3.1758619208557;
        Tue, 23 Sep 2025 02:20:08 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77d8c3adfd4sm14114941b3a.82.2025.09.23.02.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 02:20:08 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 2/2] tracing: fprobe: optimization for entry only case
Date: Tue, 23 Sep 2025 17:20:01 +0800
Message-ID: <20250923092001.1087678-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923092001.1087678-1-dongml2@chinatelecom.cn>
References: <20250923092001.1087678-1-dongml2@chinatelecom.cn>
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
 kernel/trace/fprobe.c | 88 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 81 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 1785fba367c9..de4ae075548d 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -292,7 +292,7 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
 				if (node->addr != func)
 					continue;
 				fp = READ_ONCE(node->fp);
-				if (fp && !fprobe_disabled(fp))
+				if (fp && !fprobe_disabled(fp) && fp->exit_handler)
 					fp->nmissed++;
 			}
 			return 0;
@@ -312,11 +312,11 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
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
@@ -327,7 +327,7 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
 			ret = __fprobe_handler(func, ret_ip, fp, fregs, data);
 
 		/* If entry_handler returns !0, nmissed is not counted but skips exit_handler. */
-		if (!ret && fp->exit_handler) {
+		if (!ret) {
 			int size_words = SIZE_IN_LONG(data_size);
 
 			if (write_fprobe_header(&fgraph_data[used], fp, size_words))
@@ -384,6 +384,70 @@ static struct fgraph_ops fprobe_graph_ops = {
 };
 static int fprobe_graph_active;
 
+/* ftrace_ops backend (entry-only) */
+static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
+	struct ftrace_ops *ops, struct ftrace_regs *fregs)
+{
+	struct fprobe_hlist_node *node;
+	struct rhlist_head *head, *pos;
+	struct fprobe *fp;
+
+	guard(rcu)();
+	head = rhltable_lookup(&fprobe_ip_table, &ip, fprobe_rht_params);
+
+	rhl_for_each_entry_rcu(node, pos, head, hlist) {
+		if (node->addr != ip)
+			break;
+		fp = READ_ONCE(node->fp);
+		if (unlikely(!fp || fprobe_disabled(fp) || fp->exit_handler))
+			continue;
+		/* entry-only path: no exit_handler nor per-call data */
+		if (fprobe_shared_with_kprobes(fp))
+			__fprobe_kprobe_handler(ip, parent_ip, fp, fregs, NULL);
+		else
+			__fprobe_handler(ip, parent_ip, fp, fregs, NULL);
+	}
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
@@ -500,9 +564,12 @@ static int fprobe_module_callback(struct notifier_block *nb,
 	} while (node == ERR_PTR(-EAGAIN));
 	rhashtable_walk_exit(&iter);
 
-	if (alist.index < alist.size && alist.index > 0)
+	if (alist.index < alist.size && alist.index > 0) {
 		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
 				      alist.addrs, alist.index, 1, 0);
+		ftrace_set_filter_ips(&fprobe_ftrace_ops,
+				      alist.addrs, alist.index, 1, 0);
+	}
 	mutex_unlock(&fprobe_mutex);
 
 	kfree(alist.addrs);
@@ -735,7 +802,11 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
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
@@ -831,7 +902,10 @@ int unregister_fprobe(struct fprobe *fp)
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

