Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B2E30506A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517169; cv=none; b=iG8HkRUzJpC3NcoinxuhQMyLOQ77U3wi8aK0htSM/jJL4M0On32wrMs430YifpIA4AlpvPLQHUOsXeKwYrCpEiwW/psBtDUbGQXb0eSWMojtFWDtnnA2IZGUiQy7ZngvQuxNggewkxAVNwoJO6eL0uOlNGiTnW/YQ/amaS1uEms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517169; c=relaxed/simple;
	bh=K7p6UhWLDRfKZT2gAOrP7MNUFUmEeyqKtxB0zO9luS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wu4sU1mzHfiGqVs0w+B+2lfZeNCLouazzuenKae9TUY0FJehcyh5V/NSCv5uyCRHmESgHHDxlVgPv7AafqYn7e/YS3drFIotz0Ul1XiIHEx3ElxirOJVwclWVcivdGKb9Q7C5JpNa6mKbqme9PFH4kjIpEpgRXHvuUPUCYJycIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXZvIqwY; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXZvIqwY"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so4938746b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760517167; x=1761121967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Te5eI+fh3hZ8vEBMN4EQiUZ0pMD+A28Xmwyz5U4lckA=;
        b=BXZvIqwYEJH0s5kHf6GOSh4pVqz1Aa0aUeq62GgzPE7A2b6uuNkx6PVVvkTZQlC1JL
         CfocRoUgsAtbQ2ga7J5cSDBFXa2PJeMoRjUpduRDaFJZhLKA4x2hx3kl7eS03yXgX/2X
         rPr0S/UzWmIUGEemHSkdlEqzHl15z+dgn3VDK5Vc2KOCsch2M2CVHP82Gsetw+ex2c2d
         f5/yykAfsbag5Pc9q2/698os0fK8ZOstm9mrc8xjD3elolUHM9JJfI2+L4psRLRfURSE
         KVTCR+7sB/lc89/AsFQhmnBwjRmnTwDMrlGD8geh1qMS78dWRrb9CX2Bns0jIl3eDsGc
         Nq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760517167; x=1761121967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Te5eI+fh3hZ8vEBMN4EQiUZ0pMD+A28Xmwyz5U4lckA=;
        b=AXDCpPORkHDKryoap4Dp3JB/9FniKwVqfvieG7yH2AGkCX7elhnbBDqbm7r4fjoZ+L
         oMa9QkNg5eKydbEp2AobcRje9q/e7K79cBS4wSqsoiJjEouim15mhxKSvT67BRJi8o3B
         UD/FrmMHNB3nDc33PYq0FFg/n9StLZARMH0EF9KpOaOk6PZqYv5/7/aq7AeoJzLtngCo
         n2cbRcMbYgC146BCAGpYE/srFgYEAazXzmv+0o/znVcI3VF6xrZmjnj5whpQdw23sl4K
         Usvk4YFFg7KXH/qL9dPNqKyRCKfZUBSzWgdciDm9yVFO+iLhEmFNBtoI8YHGPgOxCEsn
         plbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJFdK9TqvKSOquFzPy3FYxPE9w0UBbXAxucaaVbBlbjZpLEG/LK4+rPq8buSBwSOmdh2KthUORD6BNsdakIQOhbNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrqu41V0TikGiJgtxM1YKVnVIbE5IUVwHlbrYktpeLmv+hQ+xf
	e1XeY2xa0G8FFfbb34oImF13PgiyiNZV5zfSlgkAUe9FPGZy6esLDCs4
X-Gm-Gg: ASbGncvo32yEau17T61SKY9Pl5oT3Q2RkYRfIK+NskGjktJvR0FTlc3PveghsDpUj3q
	+uzmRgBcdCEuXXEotETYH/4gpw0Mc3oouyYN/zAhbYoC+NHB8sWzwuCjR+vznm79X1ylKSov8eI
	ly8AJOwehDODo13Vyp78lctt1cORPwzWiB7TZG8re8r88wEuRuvRcMAfcTbev8GqRpebMNEUz8+
	Q6MPoCRRFzdlCGIDCrHteLR+lEzA2NOPLTADWv7+t9X1nj9aBw0PeKqxqwrIw+RU4GsDwANdOSR
	9ONauJqZ4aGC0BwCk+6c+apn59l1ye9iZDJKJ43lY+pSDt7cGQgT5yO044XsmbGeVj71nwLUCSn
	yq0rRvOT1OUZCrMd8xuNOsDzGKji5o9OXVfiMXtJ+ThSqu7ZcQF51
X-Google-Smtp-Source: AGHT+IFtyahH715Ez7HcycJ7972WoW2MVWw6sJis7+N0dA6wa5rXuDxh5CHRyvbCK5UYHcZBqvtpgQ==
X-Received: by 2002:a17:902:fc87:b0:28a:8ae7:4034 with SMTP id d9443c01a7336-2902725eda4mr336705755ad.25.1760517166511;
        Wed, 15 Oct 2025 01:32:46 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f35e62sm188932455ad.88.2025.10.15.01.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 01:32:46 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] tracing: fprobe: optimization for entry only case
Date: Wed, 15 Oct 2025 16:32:37 +0800
Message-ID: <20251015083238.2374294-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015083238.2374294-1-dongml2@chinatelecom.cn>
References: <20251015083238.2374294-1-dongml2@chinatelecom.cn>
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
v4:
- fallback to fgraph if FTRACE_OPS_FL_SAVE_REGS not supported

v3:
- add some comment to the rcu_read_lock() in fprobe_ftrace_entry()

v2:
- add some document for fprobe_fgraph_entry as Masami suggested
- merge the rename of fprobe_entry into current patch
- use ftrace_test_recursion_trylock() in fprobe_ftrace_entry()
---
 kernel/trace/fprobe.c | 128 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 119 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 99d83c08b9e2..ecd623eef68b 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -254,8 +254,106 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
 	return ret;
 }
 
-static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
-			struct ftrace_regs *fregs)
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
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
+static bool fprobe_is_ftrace(struct fprobe *fp)
+{
+	return !fp->exit_handler;
+}
+#else
+static int fprobe_ftrace_add_ips(unsigned long *addrs, int num)
+{
+	return -ENOENT;
+}
+
+static void fprobe_ftrace_remove_ips(unsigned long *addrs, int num)
+{
+}
+
+static bool fprobe_is_ftrace(struct fprobe *fp)
+{
+	return false;
+}
+#endif
+
+/* fgraph_ops callback, this processes fprobes which have exit_handler. */
+static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
+			       struct ftrace_regs *fregs)
 {
 	unsigned long *fgraph_data = NULL;
 	unsigned long func = trace->func;
@@ -292,7 +390,7 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 				if (node->addr != func)
 					continue;
 				fp = READ_ONCE(node->fp);
-				if (fp && !fprobe_disabled(fp))
+				if (fp && !fprobe_disabled(fp) && !fprobe_is_ftrace(fp))
 					fp->nmissed++;
 			}
 			return 0;
@@ -312,7 +410,7 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 		if (node->addr != func)
 			continue;
 		fp = READ_ONCE(node->fp);
-		if (!fp || fprobe_disabled(fp))
+		if (unlikely(!fp || fprobe_disabled(fp) || fprobe_is_ftrace(fp)))
 			continue;
 
 		data_size = fp->entry_data_size;
@@ -340,7 +438,7 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 	/* If any exit_handler is set, data must be used. */
 	return used != 0;
 }
-NOKPROBE_SYMBOL(fprobe_entry);
+NOKPROBE_SYMBOL(fprobe_fgraph_entry);
 
 static void fprobe_return(struct ftrace_graph_ret *trace,
 			  struct fgraph_ops *gops,
@@ -379,7 +477,7 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
 NOKPROBE_SYMBOL(fprobe_return);
 
 static struct fgraph_ops fprobe_graph_ops = {
-	.entryfunc	= fprobe_entry,
+	.entryfunc	= fprobe_fgraph_entry,
 	.retfunc	= fprobe_return,
 };
 static int fprobe_graph_active;
@@ -498,9 +596,14 @@ static int fprobe_module_callback(struct notifier_block *nb,
 	} while (node == ERR_PTR(-EAGAIN));
 	rhashtable_walk_exit(&iter);
 
-	if (alist.index > 0)
+	if (alist.index > 0) {
 		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
 				      alist.addrs, alist.index, 1, 0);
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+		ftrace_set_filter_ips(&fprobe_ftrace_ops,
+				      alist.addrs, alist.index, 1, 0);
+#endif
+	}
 	mutex_unlock(&fprobe_mutex);
 
 	kfree(alist.addrs);
@@ -733,7 +836,11 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
 	mutex_lock(&fprobe_mutex);
 
 	hlist_array = fp->hlist_array;
-	ret = fprobe_graph_add_ips(addrs, num);
+	if (fprobe_is_ftrace(fp))
+		ret = fprobe_ftrace_add_ips(addrs, num);
+	else
+		ret = fprobe_graph_add_ips(addrs, num);
+
 	if (!ret) {
 		add_fprobe_hash(fp);
 		for (i = 0; i < hlist_array->size; i++) {
@@ -829,7 +936,10 @@ int unregister_fprobe(struct fprobe *fp)
 	}
 	del_fprobe_hash(fp);
 
-	fprobe_graph_remove_ips(addrs, count);
+	if (fprobe_is_ftrace(fp))
+		fprobe_ftrace_remove_ips(addrs, count);
+	else
+		fprobe_graph_remove_ips(addrs, count);
 
 	kfree_rcu(hlist_array, rcu);
 	fp->hlist_array = NULL;
-- 
2.51.0

