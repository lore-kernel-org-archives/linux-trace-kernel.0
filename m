Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEDF38237B;
	Mon, 13 Apr 2026 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776069580; cv=none; b=KmvHzYlDRQ+V8cH+nGueaVdMiJO26Dj1sGues31oZH3pozMQOxQ0+Lwrk7lxvX42kr550qBMZBV84AOqW4vgvWnJA1l0gHANkydVO/EAOLdKWKGz2omyV5nBBGpN8cnBMbZ9u3Ui8kLzOzctF36EJuD0aqke4fyFMxX7DYfzSWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776069580; c=relaxed/simple;
	bh=jXA6yadbpUkxcpwhhq5hK3fAHHFh5qDZGWqxwlhONQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jEwJiFr4D5emjaaS7He7rAzm0kucTuSs40XG0NspT4Mf1iXhLDqmiRDPEbf3h38qCkve+u+9lJkmvz2069LM8kpE0eCVxD+Xql0xduBH/qCSMdRfG0mblop8F/ahXdYIjvMOdImpXYMKWFxq7Ea5T53gH5PiwQqfl3yknhePMNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmAbHFq/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmAbHFq/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3343C116C6;
	Mon, 13 Apr 2026 08:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776069580;
	bh=jXA6yadbpUkxcpwhhq5hK3fAHHFh5qDZGWqxwlhONQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bmAbHFq/mg8fK7oPBGx7hI//NpbxS/TD5GPWtUBzprn467HU3Ybje7helA3DlW0y0
	 tu34Y8an2gQ8/7B+huRSYlCiuanEk40jcDbZqmhL7LqgcP/arR3iMniexHRsEIbEz3
	 u0r+bWM5HtFLkNbWT65piuCX4qKZFDTwJBCrpHYvW/Re0xKuCh1+cTbqZSR9TuSOMh
	 TGCLUqmehhDvajVxevTTRExb0UxmUYUglXqXtYRZTbC8HxdiriKI8IC930+xcawYtJ
	 BiIrDp1yyD1XZasc5hegw/zmAqc2qU82EyKNClIxVWSVKHdsCXSRWBsSrX4uBq2Wq9
	 r6FYpsCBt/SKg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] tracing/fprobe: Remove fprobe from hash in failure path
Date: Mon, 13 Apr 2026 17:39:35 +0900
Message-ID: <177606957579.929411.7546403883012683849.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <177606956628.929411.17392736689322577701.stgit@devnote2>
References: <177606956628.929411.17392736689322577701.stgit@devnote2>
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
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
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
 kernel/trace/fprobe.c |  101 ++++++++++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 48 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index dcadf1d23b8a..1d9a3d2276cd 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -4,6 +4,7 @@
  */
 #define pr_fmt(fmt) "fprobe: " fmt
 
+#include <linux/cleanup.h>
 #include <linux/err.h>
 #include <linux/fprobe.h>
 #include <linux/kallsyms.h>
@@ -78,20 +79,27 @@ static const struct rhashtable_params fprobe_rht_params = {
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
@@ -759,7 +767,6 @@ static int fprobe_init(struct fprobe *fp, unsigned long *addrs, int num)
 	fp->hlist_array = hlist_array;
 	hlist_array->fp = fp;
 	for (i = 0; i < num; i++) {
-		hlist_array->array[i].fp = fp;
 		addr = ftrace_location(addrs[i]);
 		if (!addr) {
 			fprobe_fail_cleanup(fp);
@@ -823,6 +830,8 @@ int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter
 }
 EXPORT_SYMBOL_GPL(register_fprobe);
 
+static int unregister_fprobe_nolock(struct fprobe *fp, bool force);
+
 /**
  * register_fprobe_ips() - Register fprobe to ftrace by address.
  * @fp: A fprobe data structure to be registered.
@@ -845,31 +854,27 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
 	if (ret)
 		return ret;
 
-	mutex_lock(&fprobe_mutex);
+	guard(mutex)(&fprobe_mutex);
 
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
-	mutex_unlock(&fprobe_mutex);
-
-	if (ret)
-		fprobe_fail_cleanup(fp);
 
 	return ret;
 }
@@ -913,37 +918,23 @@ bool fprobe_is_registered(struct fprobe *fp)
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
-	if (!fp || !is_fprobe_still_exist(fp)) {
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
@@ -955,12 +946,26 @@ int unregister_fprobe(struct fprobe *fp)
 
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
+	if (!fp || !is_fprobe_still_exist(fp))
+		return -EINVAL;
+
+	return unregister_fprobe_nolock(fp, false);
 }
 EXPORT_SYMBOL_GPL(unregister_fprobe);
 

