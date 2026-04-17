Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A39528F5;
	Fri, 17 Apr 2026 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776442691; cv=none; b=FU16G0Ce263ToKt06AIXwNJIMskb6pd/f0XZkrHFLrRX6utn7WNgAl7j8J7mU405xbBX79bLp55x/iebt/r2HDoF3ftKxcHbl9ZDhx1pfmMhxSDl/BR7eN+joLIV1dRXBtPpwGP8G4XEyYz6WQSNEKkhr3dN0MAlu78uAFv5l3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776442691; c=relaxed/simple;
	bh=LolnzKvnymhTfQS/YHJNLIaPqF8ZolErG4t6mUdOL3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1Qvm9kgVLICWLo3GZLZrWKoMyF1pQXkFXim4vznBfIMAwnU27sHWJDgbB3Yqj93jN0H8md1VYkAYWJ4hCUoH3gX8yZ4LI6ZtIG2alTyaMVy4lViCv5YttrhS84ORnZ7+XLC4/r1WJ1mZY+eDYvXbHw+Mz7sNIi1GbDOm/muh5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGWpOYMR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGWpOYMR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20ADC19425;
	Fri, 17 Apr 2026 16:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776442690;
	bh=LolnzKvnymhTfQS/YHJNLIaPqF8ZolErG4t6mUdOL3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lGWpOYMRdzYXKkdUfTmtdbeayiKofLJh1xNBQdIyinuIRL1HT1yc8FU6VFR6Bqjv0
	 xAMlDmlrg2Bmdru0NcK/3olNHqFxxVoWViNXg7CqWQBmyI8K8uXk92rypYcEzDceX+
	 GJOwD+b9Z0lnN5lynSBcIWLAWFFJzYjRNrpVrDqAsrbK46D8NMRhYkgl+ka/QKM0di
	 PXcTzVJUJf7ECYFjVsQZXwQf7d6biA7FHjMc2BJWMJ/3OPW1ojImGGi0YDmKZXEkV6
	 NCIuhm7x9k/5JpDf6qeg9ZLOmx93D7Ua8RKY86X7jHfNyMYte1Jn20g9uP1Ft51nkz
	 b1j2slPMIipoQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v9 3/8] tracing/fprobe: Remove fprobe from hash in failure path
Date: Sat, 18 Apr 2026 01:18:08 +0900
Message-ID:  <177644268811.584467.1100088009838466401.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
In-Reply-To:  <177644266147.584467.8179035927318998910.stgit@mhiramat.tok.corp.google.com>
References:  <177644266147.584467.8179035927318998910.stgit@mhiramat.tok.corp.google.com>
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
 Changes in v8:
  - Fix to check return value of add_fprobe_hash() and break
    loop if insert_fprobe_node() is failed.
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
 kernel/trace/fprobe.c |   85 +++++++++++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 42 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index a2b659006e0e..2e232342cbd4 100644
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
@@ -756,7 +763,6 @@ static int fprobe_init(struct fprobe *fp, unsigned long *addrs, int num)
 	fp->hlist_array = hlist_array;
 	hlist_array->fp = fp;
 	for (i = 0; i < num; i++) {
-		hlist_array->array[i].fp = fp;
 		addr = ftrace_location(addrs[i]);
 		if (!addr) {
 			fprobe_fail_cleanup(fp);
@@ -820,6 +826,8 @@ int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter
 }
 EXPORT_SYMBOL_GPL(register_fprobe);
 
+static int unregister_fprobe_nolock(struct fprobe *fp);
+
 /**
  * register_fprobe_ips() - Register fprobe to ftrace by address.
  * @fp: A fprobe data structure to be registered.
@@ -846,28 +854,22 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
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
 
+	hlist_array = fp->hlist_array;
+	ret = add_fprobe_hash(fp);
+	for (i = 0; i < hlist_array->size && !ret; i++)
+		ret = insert_fprobe_node(&hlist_array->array[i], fp);
+
 	if (ret)
-		fprobe_fail_cleanup(fp);
+		unregister_fprobe_nolock(fp);
 
 	return ret;
 }
@@ -911,27 +913,12 @@ bool fprobe_is_registered(struct fprobe *fp)
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
@@ -957,12 +944,26 @@ int unregister_fprobe(struct fprobe *fp)
 
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
 

