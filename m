Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77D3340A6A;
	Wed, 15 Apr 2026 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247740; cv=none; b=glzzuBsGwk50cztS3gpDCiTxZmy242przgsf0XCwAA9QsFdl8HsEDCL1xEIgR44nkB0VeCZXYn2h7UDGwaKna/GmwamkqsiHEofaDz2LPEnhfR7zzqlWzEpDbkZf1bFSktgP8MRVBn+aZsaY2JQiS8MRq8aWO/af5kIxTxzm8lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247740; c=relaxed/simple;
	bh=2cnKJdk5yVgYoMxjltisR4SF9rg4l0e+Rj4E0adsHkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DRscUccVvhwXq1IsJEhtaPQfuymrLAiEgcbM3HlPedhViC5tTYinJkH9zEsH+2e49QTUwVn9gygd3MK0sGIEe4LiJCXH3fDElslnuflA1bOUYM78URXFWQnlNtA9bayRkpeyZPrUEtGXhpumWwX+ZZ9jICYIIVEWMY4E2puKOiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STOSt7/c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STOSt7/c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772EDC2BCB4;
	Wed, 15 Apr 2026 10:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776247740;
	bh=2cnKJdk5yVgYoMxjltisR4SF9rg4l0e+Rj4E0adsHkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=STOSt7/cu3WrPiYs7nnfioLEgsdUvgC6Vw7uuxEsoz0d7pdOptYFOQ5sqIGWUuV7g
	 xFr3VGRSmI1swbWefqlnmyK8GksiO3GfLoNU4TIKV5nEhU5NSyGddxYxxitVYO+uYN
	 5xC1MbiDLVHVaXa1eoIdZ+ZveMibngDwmgV0Uv+vlpKhdp+M1RzpTDsgR8ZzUzMNeW
	 jHXG9rwNpxvnkK9TW+8iSmxheUIJWpf/w31oOVk606I8p3Exx0yhUJsH6oDSspb4X0
	 /dgKQ4FQpqyIZUMfLj/gAivMCwBkyJLbZo0HKEaglYIA7BlWQr2FEhoDbSRlL5wq24
	 zJ2aGEZwbgxow==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7 3/6] tracing/fprobe: Remove fprobe from hash in failure path
Date: Wed, 15 Apr 2026 19:08:58 +0900
Message-ID:  <177624773781.2407691.17563168322102270682.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
In-Reply-To:  <177624771150.2407691.15764846647014540969.stgit@mhiramat.tok.corp.google.com>
References:  <177624771150.2407691.15764846647014540969.stgit@mhiramat.tok.corp.google.com>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

When register_fprobe_ips() fails, it tries to remove a list of
fprobe_hash_node from fprobe_ip_table, but it missed to remove
fprobe itself from fprobe_table. Moreover, when removing
the fprobe_hash_node which is added to rhltable once, it must
use kfree_rcu() after removing from rhltable.

To fix these issues, this reuses unregister_fprobe() internal
code to rollback the half-way registered fprobe.

Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v7:
  - Remove RCU grace period wait, since fprobe itself is not
    that is not needed.
 Changes in v6:
  - Wait for an RCU grace period before returning error in
    unregister_fprobe_nolock().
 Changes in v5:
  - When rolling back an fprobe that failed to register, the
    fprobe_hash_node are forcibly removed and warn if failure.
 Changes in v4:
  - Remove short-cut case because we always need to upadte ftrace_ops.
  - Use guard(mutex) in register_fprobe_ips() to unlock it correctly.
  - Remove redundant !ret check in register_fprobe_ips().
  - Do not set hlist_array->size in failure case, instead,
    hlist_array->array[i].fp is set only when insertion is succeeded.
  Changes in v3:
  - Newly added.
---
 kernel/trace/fprobe.c |   87 +++++++++++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 43 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index d634eb8e8b9e..c58e41b2da8e 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -79,20 +79,27 @@ static const struct rhashtable_params fprobe_rht_params = {
 };
 
 /* Node insertion and deletion requires the fprobe_mutex */
-static int insert_fprobe_node(struct fprobe_hlist_node *node)
+static int insert_fprobe_node(struct fprobe_hlist_node *node, struct fprobe *fp)
 {
+	int ret;
+
 	lockdep_assert_held(&fprobe_mutex);
 
-	return rhltable_insert(&fprobe_ip_table, &node->hlist, fprobe_rht_params);
+	ret = rhltable_insert(&fprobe_ip_table, &node->hlist, fprobe_rht_params);
+	/* Set the fprobe pointer if insertion was successful. */
+	if (!ret)
+		WRITE_ONCE(node->fp, fp);
+	return ret;
 }
 
 /* Return true if there are synonims */
 static bool delete_fprobe_node(struct fprobe_hlist_node *node)
 {
-	lockdep_assert_held(&fprobe_mutex);
 	bool ret;
 
-	/* Avoid double deleting */
+	lockdep_assert_held(&fprobe_mutex);
+
+	/* Avoid double deleting and non-inserted nodes */
 	if (READ_ONCE(node->fp) != NULL) {
 		WRITE_ONCE(node->fp, NULL);
 		rhltable_remove(&fprobe_ip_table, &node->hlist,
@@ -757,7 +764,6 @@ static int fprobe_init(struct fprobe *fp, unsigned long *addrs, int num)
 	fp->hlist_array = hlist_array;
 	hlist_array->fp = fp;
 	for (i = 0; i < num; i++) {
-		hlist_array->array[i].fp = fp;
 		addr = ftrace_location(addrs[i]);
 		if (!addr) {
 			fprobe_fail_cleanup(fp);
@@ -821,6 +827,8 @@ int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter
 }
 EXPORT_SYMBOL_GPL(register_fprobe);
 
+static int unregister_fprobe_nolock(struct fprobe *fp);
+
 /**
  * register_fprobe_ips() - Register fprobe to ftrace by address.
  * @fp: A fprobe data structure to be registered.
@@ -847,28 +855,22 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
 	if (ret)
 		return ret;
 
-	hlist_array = fp->hlist_array;
 	if (fprobe_is_ftrace(fp))
 		ret = fprobe_ftrace_add_ips(addrs, num);
 	else
 		ret = fprobe_graph_add_ips(addrs, num);
-
-	if (!ret) {
-		add_fprobe_hash(fp);
-		for (i = 0; i < hlist_array->size; i++) {
-			ret = insert_fprobe_node(&hlist_array->array[i]);
-			if (ret)
-				break;
-		}
-		/* fallback on insert error */
-		if (ret) {
-			for (i--; i >= 0; i--)
-				delete_fprobe_node(&hlist_array->array[i]);
-		}
+	if (ret) {
+		fprobe_fail_cleanup(fp);
+		return ret;
 	}
 
-	if (ret)
-		fprobe_fail_cleanup(fp);
+	hlist_array = fp->hlist_array;
+	add_fprobe_hash(fp);
+	for (i = 0; i < hlist_array->size; i++) {
+		ret = insert_fprobe_node(&hlist_array->array[i], fp);
+		if (ret)
+			unregister_fprobe_nolock(fp);
+	}
 
 	return ret;
 }
@@ -912,27 +914,12 @@ bool fprobe_is_registered(struct fprobe *fp)
 	return true;
 }
 
-/**
- * unregister_fprobe() - Unregister fprobe.
- * @fp: A fprobe data structure to be unregistered.
- *
- * Unregister fprobe (and remove ftrace hooks from the function entries).
- *
- * Return 0 if @fp is unregistered successfully, -errno if not.
- */
-int unregister_fprobe(struct fprobe *fp)
+static int unregister_fprobe_nolock(struct fprobe *fp)
 {
-	struct fprobe_hlist *hlist_array;
+	struct fprobe_hlist *hlist_array = fp->hlist_array;
 	unsigned long *addrs = NULL;
-	int ret = 0, i, count;
+	int i, count;
 
-	mutex_lock(&fprobe_mutex);
-	if (!fp || !fprobe_registered(fp)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	hlist_array = fp->hlist_array;
 	addrs = kcalloc(hlist_array->size, sizeof(unsigned long), GFP_KERNEL);
 	/*
 	 * This will remove fprobe_hash_node from the hash table even if
@@ -958,12 +945,26 @@ int unregister_fprobe(struct fprobe *fp)
 
 	kfree_rcu(hlist_array, rcu);
 	fp->hlist_array = NULL;
+	kfree(addrs);
 
-out:
-	mutex_unlock(&fprobe_mutex);
+	return 0;
+}
 
-	kfree(addrs);
-	return ret;
+/**
+ * unregister_fprobe() - Unregister fprobe.
+ * @fp: A fprobe data structure to be unregistered.
+ *
+ * Unregister fprobe (and remove ftrace hooks from the function entries).
+ *
+ * Return 0 if @fp is unregistered successfully, -errno if not.
+ */
+int unregister_fprobe(struct fprobe *fp)
+{
+	guard(mutex)(&fprobe_mutex);
+	if (!fp || !fprobe_registered(fp))
+		return -EINVAL;
+
+	return unregister_fprobe_nolock(fp);
 }
 EXPORT_SYMBOL_GPL(unregister_fprobe);
 

