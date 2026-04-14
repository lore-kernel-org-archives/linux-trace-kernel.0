Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C223B9DAC;
	Tue, 14 Apr 2026 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158099; cv=none; b=JjL2HXmK+VQfWAAXcmqHB1zJup+i0YFR3djdTOA3YdFMY8fMzvrrR4x3Ta15qpWsL1XhV1vA0XRArt9HkU3nxaTUXtTVICjMyOKK0G4WXtDik349vjQ5ja5VIpWB4ihp0hDk2V5Bru8ai0MQWArOARV3bKxqiSMw45r+pORrXCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158099; c=relaxed/simple;
	bh=Aa8wrn1cZ8tiqKsLwbrqbJX7XrGkRumRdPDSZdDUhtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AHraRXPb8KR3LSyWloZMvolr2iADI/aA7zaOLlEFmVD8y8/8GgBTZW6rXg9oGoxhhzo2xxxf36hJOnSA3Y8dr9Ixbw5tk5+IrKyEXQoMqZJKvcySapg56TiudVRyp7QQDHB8XUl3jEZiAcXk0x49FAo08miVz4mR31YB6TtySmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kM9Iypje; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kM9Iypje"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E74BC19425;
	Tue, 14 Apr 2026 09:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776158099;
	bh=Aa8wrn1cZ8tiqKsLwbrqbJX7XrGkRumRdPDSZdDUhtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kM9IypjeV6WC4K4flk+aQQgVFbS2bCRHQeJLGHn+DES6duURcW1bWfcsZ6p5GZVFp
	 4dBLChKwBJvTzdKmU5id2LuRgmTS2Lv1+h6M1Ip9pu7YyMmeUOxmasIerhcifuiU17
	 KjP4l3dfAS+r2DgYe+4/1kLGnFVNVk9qv63EmMzwOLPpDOya75oQhHUo8OT27x9rAU
	 s/M82GtpX6H3o84/6zIUranjocgEc2NvbomdKnHWX1E5wWoqDKIQ9Y183HNd2aF6PI
	 QMz9C/4MyEjMsF+3f3g73lpD8WaIjQT3gvVoYbGpIiqncmpP9vgoNOWmnRUNjFOQR2
	 uk85MJIc2zjCA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v6 2/5] tracing/fprobe: Remove fprobe from hash in failure path
Date: Tue, 14 Apr 2026 18:14:57 +0900
Message-ID:  <177615809677.1165997.619922394559783590.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
In-Reply-To:  <177615807787.1165997.921227352050738693.stgit@mhiramat.tok.corp.google.com>
References:  <177615807787.1165997.921227352050738693.stgit@mhiramat.tok.corp.google.com>
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
 kernel/trace/fprobe.c |  109 ++++++++++++++++++++++++++++---------------------
 1 file changed, 63 insertions(+), 46 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index fc7018b28fdd..6a23bb787295 100644
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
 
+static int unregister_fprobe_nolock(struct fprobe *fp, bool force);
+
 /**
  * register_fprobe_ips() - Register fprobe to ftrace by address.
  * @fp: A fprobe data structure to be registered.
@@ -847,29 +855,26 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
 	if (ret)
 		return ret;
 
-	hlist_array = fp->hlist_array;
 	if (fprobe_is_ftrace(fp))
 		ret = fprobe_ftrace_add_ips(addrs, num);
 	else
 		ret = fprobe_graph_add_ips(addrs, num);
+	if (ret) {
+		fprobe_fail_cleanup(fp);
+		return ret;
+	}
 
-	if (!ret) {
-		add_fprobe_hash(fp);
-		for (i = 0; i < hlist_array->size; i++) {
-			ret = insert_fprobe_node(&hlist_array->array[i]);
-			if (ret)
-				break;
-		}
-		/* fallback on insert error */
+	hlist_array = fp->hlist_array;
+	add_fprobe_hash(fp);
+	for (i = 0; i < hlist_array->size; i++) {
+		ret = insert_fprobe_node(&hlist_array->array[i], fp);
 		if (ret) {
-			for (i--; i >= 0; i--)
-				delete_fprobe_node(&hlist_array->array[i]);
+			if (unregister_fprobe_nolock(fp, true))
+				pr_warn("Failed to cleanup fprobe after insertion failure.\n");
+			break;
 		}
 	}
 
-	if (ret)
-		fprobe_fail_cleanup(fp);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(register_fprobe_ips);
@@ -912,37 +917,29 @@ bool fprobe_is_registered(struct fprobe *fp)
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
+static int unregister_fprobe_nolock(struct fprobe *fp, bool force)
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
-	if (!addrs) {
-		ret = -ENOMEM;	/* TODO: Fallback to one-by-one loop */
-		goto out;
-	}
+	if (!addrs && !force)
+		return -ENOMEM;
+	/*
+	 * If @force is set, this function will remove fprobe_hash_node
+	 * from the hash table even if memory allocation fails. However,
+	 * ftrace_ops will not be updated. Anyway, when the last fprobe
+	 * is unregistered, ftrace_ops is also unregistered.
+	 */
 
 	/* Remove non-synonim ips from table and hash */
 	count = 0;
 	for (i = 0; i < hlist_array->size; i++) {
-		if (!delete_fprobe_node(&hlist_array->array[i]))
+		if (delete_fprobe_node(&hlist_array->array[i]))
+			continue;
+
+		if (addrs)
 			addrs[count++] = hlist_array->array[i].addr;
 	}
 	del_fprobe_hash(fp);
@@ -951,15 +948,35 @@ int unregister_fprobe(struct fprobe *fp)
 		fprobe_ftrace_remove_ips(addrs, count);
 	else
 		fprobe_graph_remove_ips(addrs, count);
+	/*
+	 * If count == 0, instead of calling ftrace_set_filter_ips(),
+	 * we must wait for RCU grace period to finish del_fprobe_hash().
+	 */
+	if (!count)
+		synchronize_rcu();
 
 	kfree_rcu(hlist_array, rcu);
 	fp->hlist_array = NULL;
+	kfree(addrs);
 
-out:
-	mutex_unlock(&fprobe_mutex);
+	return !addrs ? -ENOMEM : 0;
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
+	return unregister_fprobe_nolock(fp, false);
 }
 EXPORT_SYMBOL_GPL(unregister_fprobe);
 

