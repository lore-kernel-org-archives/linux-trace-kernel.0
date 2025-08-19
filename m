Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B72177111;
	Tue, 19 Aug 2025 03:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755573514; cv=none; b=sJ22VJv5OUekZ5IQIhuwoDaZeHgfaBcNOpj/Z0tXJdtc43oVok6Ta49WIDZRKMkgdBSjLXfGFOD/DBrfnDOeqrF4ET5Nh/ceU2tHA6nzRLRXYAHJNpNgJSLhIDbz3rNlrpDEB6t/6bfAitjqNkbdC+2UdyLkUW7PraJudq63qTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755573514; c=relaxed/simple;
	bh=+ho5jIKj1qDedkpFWgPNP3rYewspWMkQh1OAld8mQpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BWnpBF/QfeVUJ5gUCaYS41CZy8La9Z1tCsQ2+wV4fwPB53Fp8E9WlU1iZwwtEiBXb/NIiZPJZ5z2OqhE3Jj51fdkXC2oEyClV+IxqPTiyUdI9lc1txROxTBLNIupagIGvu5ks+g6UwS1E4lPXpp24Yynaopc6XzctlCwah4dWy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxCzhfvy; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxCzhfvy"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-244581caca6so36833405ad.2;
        Mon, 18 Aug 2025 20:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755573512; x=1756178312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ObN9f6kDVQBk4T25jWY6sLhImofyjEsN+l2qi7eC9Xo=;
        b=ZxCzhfvyAWHDx2K6V9Ae2IkXXnPstoi3ZzKfpgleZq0Ss9iPSfkA163oLPeuQSUXJu
         UmCBQmLVUb6OzMhjPekdrlqNms0vwlpEQxVeaUw+LrG+cZ4G5Bqq9254nWAFGzYi4WWI
         aUOn/pRvVdpBc0PA8KGFQU5E5NaYdsLl9v9+48sYToQcWRYz3KFegjKsnILmPQjfuV7C
         RLUzC/yYqPqOaOgufFKmJu5CjywBMBSttxTmr8Abxz6VYomKfdqveM5DojNJXGZ4aCVT
         LOXx7Ed0VHy++QPTDjPSh7Zs5iPnhDR1Pi9I2bT1oZZnFq+RnMfih38PI4Z8sH5gp+Ih
         1ADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755573512; x=1756178312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ObN9f6kDVQBk4T25jWY6sLhImofyjEsN+l2qi7eC9Xo=;
        b=hEIP86YoIY0BRXUvcb2OSsi5ToZoaCpdoDxkHXproNUCXejSKhl8Zys5flMKwkWMVE
         f2f3M361jAqTCxpLrgg90wVOkY1th1R/U7f1yxh0EadOYXSIkUVdrDdGjAv8k98b2SvH
         8RZlG0a1qjNVD+UBVQBsrmL2ndEQnY0+nAihD8Iwu7EaXQrw4Zzn6PXJBfuJRQpTJFsQ
         i3UdJen/ragPuogYMnTClzrkXCSh5ulJiu9LS+HUIx2XeFJRasxdKydwK9wSEW5FxHC5
         Denxi5c3TEGnm1oN8/e66Z0kL3WBe6M3T4tbmS2VvPDlp+1F+gHyRkgp856JSkoWCArB
         OVPA==
X-Forwarded-Encrypted: i=1; AJvYcCUbHgkBiWnDzDA6ky+a/k9G4V4NJztsnHH5cFoBEBpp9SI1hsFY/u0XmtGPX99Ygw+6NoR9JOSDVr2A6QIv2PCPby4t@vger.kernel.org, AJvYcCWqFTs1G5dQxsT/4o2Kg0k8SrEu2pA40nCBTTWL+G+kuHK/YcqoyvZF7sL8BTx4uEmVK4CgUgw14rueaUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDPToppdo7Ipru/EufvhRhrdWsvQQX9BR3NwfyKdm18SChVLkX
	IzNzCbnA5w+DQh9CLtICkgjPEDuXNrJsfz1fJxP+1WZU4Eu25Yc/pcMj
X-Gm-Gg: ASbGnct4cAeHGpcJm6NBC3y9n0u6H/4UWzBV2MwOesAsn7E8MHPqYiQBnlxiB+WdCSX
	xs430ULh4E7SyS8R4nclZE0DOEwoOQgg847a3qqMR2BsRf5F3ayv3I/JVDIwpmSSOERsxn805oI
	m5DzrGltKEP8M63lZ25fB9DmDX+1wO+4QBiU+nb0EPqWJv+79NlbvaP5uNIlKYqgw06o62YErDL
	AUNiG6JtTNlJov47JF2v0UyP5goCEPKofgPAMZytsfpjPicAnkgU+Ey0Ute0l9SnO0C1z+vurKw
	11CZtwTzaaJLIRjXUdDc3ylUvI2BR3ZNUAUrEChXh9pEQ0OjSU9hJj3U3GxFI6txiGnnDB1T2U/
	o3+uYelUAIm2uVdD3EG4=
X-Google-Smtp-Source: AGHT+IGkRi2nb3XOsy0Xn0DVXi38AReWIFR2vwSOBGE7YodAVRzpaVsybNs0Uf5F+ZSxVwJrXa/TQQ==
X-Received: by 2002:a17:902:d4c6:b0:23f:fdeb:4171 with SMTP id d9443c01a7336-245e04b7cecmr16970625ad.39.1755573511570;
        Mon, 18 Aug 2025 20:18:31 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24498d027acsm20677175ad.129.2025.08.18.20.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 20:18:30 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	hca@linux.ibm.com,
	revest@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v6] tracing: fprobe: use rhltable for fprobe_ip_table
Date: Tue, 19 Aug 2025 11:18:25 +0800
Message-ID: <20250819031825.55653-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, all the kernel functions who are hooked by the fprobe will be
added to the hash table "fprobe_ip_table". The key of it is the function
address, and the value of it is "struct fprobe_hlist_node".

The budget of the hash table is FPROBE_IP_TABLE_SIZE, which is 256. And
this means the overhead of the hash table lookup will grow linearly if
the count of the functions in the fprobe more than 256. When we try to
hook all the kernel functions, the overhead will be huge.

Therefore, replace the hash table with rhltable to reduce the overhead.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v6:
- use rcu_read_lock() in delete_fprobe_node()

v5:
- remove unnecessary rcu_read_lock in fprobe_entry

v4:
- replace rhashtable_walk_enter with rhltable_walk_enter

v3:
- some format optimization
- handle the error that returned from rhltable_insert in
  insert_fprobe_node
---
 include/linux/fprobe.h |   3 +-
 kernel/trace/fprobe.c  | 157 ++++++++++++++++++++++++-----------------
 2 files changed, 93 insertions(+), 67 deletions(-)

diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index 7964db96e41a..0a3bcd1718f3 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -7,6 +7,7 @@
 #include <linux/ftrace.h>
 #include <linux/rcupdate.h>
 #include <linux/refcount.h>
+#include <linux/rhashtable.h>
 #include <linux/slab.h>
 
 struct fprobe;
@@ -26,7 +27,7 @@ typedef void (*fprobe_exit_cb)(struct fprobe *fp, unsigned long entry_ip,
  * @fp: The fprobe which owns this.
  */
 struct fprobe_hlist_node {
-	struct hlist_node	hlist;
+	struct rhlist_head	hlist;
 	unsigned long		addr;
 	struct fprobe		*fp;
 };
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index c8034dfc1070..fb127fa95f21 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -10,6 +10,7 @@
 #include <linux/kprobes.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/rhashtable.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
 
@@ -41,60 +42,67 @@
  *  - RCU hlist traversal under disabling preempt
  */
 static struct hlist_head fprobe_table[FPROBE_TABLE_SIZE];
-static struct hlist_head fprobe_ip_table[FPROBE_IP_TABLE_SIZE];
+static struct rhltable fprobe_ip_table;
 static DEFINE_MUTEX(fprobe_mutex);
 
-/*
- * Find first fprobe in the hlist. It will be iterated twice in the entry
- * probe, once for correcting the total required size, the second time is
- * calling back the user handlers.
- * Thus the hlist in the fprobe_table must be sorted and new probe needs to
- * be added *before* the first fprobe.
- */
-static struct fprobe_hlist_node *find_first_fprobe_node(unsigned long ip)
+static u32 fprobe_node_hashfn(const void *data, u32 len, u32 seed)
 {
-	struct fprobe_hlist_node *node;
-	struct hlist_head *head;
+	return hash_ptr(*(unsigned long **)data, 32);
+}
 
-	head = &fprobe_ip_table[hash_ptr((void *)ip, FPROBE_IP_HASH_BITS)];
-	hlist_for_each_entry_rcu(node, head, hlist,
-				 lockdep_is_held(&fprobe_mutex)) {
-		if (node->addr == ip)
-			return node;
-	}
-	return NULL;
+static int fprobe_node_cmp(struct rhashtable_compare_arg *arg,
+			   const void *ptr)
+{
+	unsigned long key = *(unsigned long *)arg->key;
+	const struct fprobe_hlist_node *n = ptr;
+
+	return n->addr != key;
 }
-NOKPROBE_SYMBOL(find_first_fprobe_node);
 
-/* Node insertion and deletion requires the fprobe_mutex */
-static void insert_fprobe_node(struct fprobe_hlist_node *node)
+static u32 fprobe_node_obj_hashfn(const void *data, u32 len, u32 seed)
 {
-	unsigned long ip = node->addr;
-	struct fprobe_hlist_node *next;
-	struct hlist_head *head;
+	const struct fprobe_hlist_node *n = data;
+
+	return hash_ptr((void *)n->addr, 32);
+}
 
+static const struct rhashtable_params fprobe_rht_params = {
+	.head_offset		= offsetof(struct fprobe_hlist_node, hlist),
+	.key_offset		= offsetof(struct fprobe_hlist_node, addr),
+	.key_len		= sizeof_field(struct fprobe_hlist_node, addr),
+	.hashfn			= fprobe_node_hashfn,
+	.obj_hashfn		= fprobe_node_obj_hashfn,
+	.obj_cmpfn		= fprobe_node_cmp,
+	.automatic_shrinking	= true,
+};
+
+/* Node insertion and deletion requires the fprobe_mutex */
+static int insert_fprobe_node(struct fprobe_hlist_node *node)
+{
 	lockdep_assert_held(&fprobe_mutex);
 
-	next = find_first_fprobe_node(ip);
-	if (next) {
-		hlist_add_before_rcu(&node->hlist, &next->hlist);
-		return;
-	}
-	head = &fprobe_ip_table[hash_ptr((void *)ip, FPROBE_IP_HASH_BITS)];
-	hlist_add_head_rcu(&node->hlist, head);
+	return rhltable_insert(&fprobe_ip_table, &node->hlist, fprobe_rht_params);
 }
 
 /* Return true if there are synonims */
 static bool delete_fprobe_node(struct fprobe_hlist_node *node)
 {
 	lockdep_assert_held(&fprobe_mutex);
+	bool ret;
 
 	/* Avoid double deleting */
 	if (READ_ONCE(node->fp) != NULL) {
 		WRITE_ONCE(node->fp, NULL);
-		hlist_del_rcu(&node->hlist);
+		rhltable_remove(&fprobe_ip_table, &node->hlist,
+				fprobe_rht_params);
 	}
-	return !!find_first_fprobe_node(node->addr);
+
+	rcu_read_lock();
+	ret = !!rhltable_lookup(&fprobe_ip_table, &node->addr,
+				fprobe_rht_params);
+	rcu_read_unlock();
+
+	return ret;
 }
 
 /* Check existence of the fprobe */
@@ -249,9 +257,10 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
 static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 			struct ftrace_regs *fregs)
 {
-	struct fprobe_hlist_node *node, *first;
 	unsigned long *fgraph_data = NULL;
 	unsigned long func = trace->func;
+	struct fprobe_hlist_node *node;
+	struct rhlist_head *head, *pos;
 	unsigned long ret_ip;
 	int reserved_words;
 	struct fprobe *fp;
@@ -260,14 +269,11 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 	if (WARN_ON_ONCE(!fregs))
 		return 0;
 
-	first = node = find_first_fprobe_node(func);
-	if (unlikely(!first))
-		return 0;
-
+	head = rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);
 	reserved_words = 0;
-	hlist_for_each_entry_from_rcu(node, hlist) {
+	rhl_for_each_entry_rcu(node, pos, head, hlist) {
 		if (node->addr != func)
-			break;
+			continue;
 		fp = READ_ONCE(node->fp);
 		if (!fp || !fp->exit_handler)
 			continue;
@@ -278,13 +284,12 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 		reserved_words +=
 			FPROBE_HEADER_SIZE_IN_LONG + SIZE_IN_LONG(fp->entry_data_size);
 	}
-	node = first;
 	if (reserved_words) {
 		fgraph_data = fgraph_reserve_data(gops->idx, reserved_words * sizeof(long));
 		if (unlikely(!fgraph_data)) {
-			hlist_for_each_entry_from_rcu(node, hlist) {
+			rhl_for_each_entry_rcu(node, pos, head, hlist) {
 				if (node->addr != func)
-					break;
+					continue;
 				fp = READ_ONCE(node->fp);
 				if (fp && !fprobe_disabled(fp))
 					fp->nmissed++;
@@ -299,12 +304,12 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 	 */
 	ret_ip = ftrace_regs_get_return_address(fregs);
 	used = 0;
-	hlist_for_each_entry_from_rcu(node, hlist) {
+	rhl_for_each_entry_rcu(node, pos, head, hlist) {
 		int data_size;
 		void *data;
 
 		if (node->addr != func)
-			break;
+			continue;
 		fp = READ_ONCE(node->fp);
 		if (!fp || fprobe_disabled(fp))
 			continue;
@@ -448,25 +453,21 @@ static int fprobe_addr_list_add(struct fprobe_addr_list *alist, unsigned long ad
 	return 0;
 }
 
-static void fprobe_remove_node_in_module(struct module *mod, struct hlist_head *head,
-					struct fprobe_addr_list *alist)
+static void fprobe_remove_node_in_module(struct module *mod, struct fprobe_hlist_node *node,
+					 struct fprobe_addr_list *alist)
 {
-	struct fprobe_hlist_node *node;
 	int ret = 0;
 
-	hlist_for_each_entry_rcu(node, head, hlist,
-				 lockdep_is_held(&fprobe_mutex)) {
-		if (!within_module(node->addr, mod))
-			continue;
-		if (delete_fprobe_node(node))
-			continue;
-		/*
-		 * If failed to update alist, just continue to update hlist.
-		 * Therefore, at list user handler will not hit anymore.
-		 */
-		if (!ret)
-			ret = fprobe_addr_list_add(alist, node->addr);
-	}
+	if (!within_module(node->addr, mod))
+		return;
+	if (delete_fprobe_node(node))
+		return;
+	/*
+	 * If failed to update alist, just continue to update hlist.
+	 * Therefore, at list user handler will not hit anymore.
+	 */
+	if (!ret)
+		ret = fprobe_addr_list_add(alist, node->addr);
 }
 
 /* Handle module unloading to manage fprobe_ip_table. */
@@ -474,8 +475,9 @@ static int fprobe_module_callback(struct notifier_block *nb,
 				  unsigned long val, void *data)
 {
 	struct fprobe_addr_list alist = {.size = FPROBE_IPS_BATCH_INIT};
+	struct fprobe_hlist_node *node;
+	struct rhashtable_iter iter;
 	struct module *mod = data;
-	int i;
 
 	if (val != MODULE_STATE_GOING)
 		return NOTIFY_DONE;
@@ -486,8 +488,16 @@ static int fprobe_module_callback(struct notifier_block *nb,
 		return NOTIFY_DONE;
 
 	mutex_lock(&fprobe_mutex);
-	for (i = 0; i < FPROBE_IP_TABLE_SIZE; i++)
-		fprobe_remove_node_in_module(mod, &fprobe_ip_table[i], &alist);
+	rhltable_walk_enter(&fprobe_ip_table, &iter);
+	do {
+		rhashtable_walk_start(&iter);
+
+		while ((node = rhashtable_walk_next(&iter)) && !IS_ERR(node))
+			fprobe_remove_node_in_module(mod, node, &alist);
+
+		rhashtable_walk_stop(&iter);
+	} while (node == ERR_PTR(-EAGAIN));
+	rhashtable_walk_exit(&iter);
 
 	if (alist.index < alist.size && alist.index > 0)
 		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
@@ -727,8 +737,16 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
 	ret = fprobe_graph_add_ips(addrs, num);
 	if (!ret) {
 		add_fprobe_hash(fp);
-		for (i = 0; i < hlist_array->size; i++)
-			insert_fprobe_node(&hlist_array->array[i]);
+		for (i = 0; i < hlist_array->size; i++) {
+			ret = insert_fprobe_node(&hlist_array->array[i]);
+			if (ret)
+				break;
+		}
+		/* fallback on insert error */
+		if (ret) {
+			for (i--; i >= 0; i--)
+				delete_fprobe_node(&hlist_array->array[i]);
+		}
 	}
 	mutex_unlock(&fprobe_mutex);
 
@@ -824,3 +842,10 @@ int unregister_fprobe(struct fprobe *fp)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(unregister_fprobe);
+
+static int __init fprobe_initcall(void)
+{
+	rhltable_init(&fprobe_ip_table, &fprobe_rht_params);
+	return 0;
+}
+late_initcall(fprobe_initcall);
-- 
2.50.1

