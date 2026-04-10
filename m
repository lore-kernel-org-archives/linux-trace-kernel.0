Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0193AE196;
	Fri, 10 Apr 2026 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775813723; cv=none; b=Mj+493yBKHb9VJDILunXvUsid0c7TUSR/0e2NbK5YrK881Qf4UGZN1jjtc1O/TwpGx6XElIQzlTExOs1u0i6RcSKH7LVi0TFb/5tlv7KnLdC9QLmaT0xz6HD+rgT7wrkKyaURRcAXTp2tLq8pPSCHmRB/INmEb60GcGu2aiq1r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775813723; c=relaxed/simple;
	bh=MdXE+yvLBVQbxyHx+/lHgZ8yQWyUyvXtTgoKmqmIuGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gpsGjK0h9LG49PG9RuySFWJuHx2yyOvLnZCHoJ3i7CErm44NM382BLhOrNjmaguyWnYJa8Cm3Rl/sT8l9Fi+FfynnehIHSSAlre1SGOkK48enl4uxl2VsNA0F/cgdGi4SuOzZlnhfZWk/L/D71o74MPH/6Qy0TvRD5XE1/m3Pa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxiMfgwA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxiMfgwA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA43EC19421;
	Fri, 10 Apr 2026 09:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775813722;
	bh=MdXE+yvLBVQbxyHx+/lHgZ8yQWyUyvXtTgoKmqmIuGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sxiMfgwA0E3HoPcEFK9Tf1hJK6EGqVPJVeranIvyK2VBOdWJ4EQA03rqkVwkgmSPV
	 S6gL3dUnPBWHIzixQAGc4LyVmfnadhmwXzIezKBsBGzZvogRem9H0yVBb9eG/jAdFX
	 FOa7ZoKxbcIbZXG0FsutN93uzGGPGl7H4Qk/jCJdW83YLKAfTyAi6/8loWv6y6gHKQ
	 bMIG/bgFaS2/mBlmeORCoC0DWG6aA8JqfpcAldl+jumX9Qnq19Rvd3CEQ28nLqEJrq
	 z+GDi0oUE4ayIR2ocXyJx/7kG4KsC0zKeMsImutlhSRA2zYCzjOMZ0so3bhi7/6xHq
	 7wwGTm2O5SQ1A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] tracing/fprobe: Remove fprobe from hash in failure path
Date: Fri, 10 Apr 2026 18:35:20 +0900
Message-ID:  <177581371999.617881.16151200432846312505.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To:  <177581370903.617881.3002655215679528157.stgit@mhiramat.tok.corp.google.com>
References:  <177581370903.617881.3002655215679528157.stgit@mhiramat.tok.corp.google.com>
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
 Changes in v3:
  - Newly added.
---
 kernel/trace/fprobe.c |   73 ++++++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 34 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 56d145017902..1b5c47685186 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -4,6 +4,7 @@
  */
 #define pr_fmt(fmt) "fprobe: " fmt
 
+#include <linux/cleanup.h>
 #include <linux/err.h>
 #include <linux/fprobe.h>
 #include <linux/kallsyms.h>
@@ -821,6 +822,8 @@ int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter
 }
 EXPORT_SYMBOL_GPL(register_fprobe);
 
+static int unregister_fprobe_nolock(struct fprobe *fp);
+
 /**
  * register_fprobe_ips() - Register fprobe to ftrace by address.
  * @fp: A fprobe data structure to be registered.
@@ -845,30 +848,29 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
 
 	mutex_lock(&fprobe_mutex);
 
-	hlist_array = fp->hlist_array;
 	if (fprobe_is_ftrace(fp))
 		ret = fprobe_ftrace_add_ips(addrs, num);
 	else
 		ret = fprobe_graph_add_ips(addrs, num);
+	if (ret) {
+		fprobe_fail_cleanup(fp);
+		return ret;
+	}
 
 	if (!ret) {
+		hlist_array = fp->hlist_array;
 		add_fprobe_hash(fp);
 		for (i = 0; i < hlist_array->size; i++) {
 			ret = insert_fprobe_node(&hlist_array->array[i]);
-			if (ret)
+			if (ret) {
+				hlist_array->size = i;
+				unregister_fprobe_nolock(fp);
 				break;
-		}
-		/* fallback on insert error */
-		if (ret) {
-			for (i--; i >= 0; i--)
-				delete_fprobe_node(&hlist_array->array[i]);
+			}
 		}
 	}
 	mutex_unlock(&fprobe_mutex);
 
-	if (ret)
-		fprobe_fail_cleanup(fp);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(register_fprobe_ips);
@@ -911,32 +913,21 @@ bool fprobe_is_registered(struct fprobe *fp)
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
-	if (!fp || !is_fprobe_still_exist(fp)) {
-		ret = -EINVAL;
-		goto out;
+	if (!hlist_array || !hlist_array->size) {
+		del_fprobe_hash(fp);
+		fprobe_fail_cleanup(fp);
+		return 0;
 	}
 
-	hlist_array = fp->hlist_array;
 	addrs = kcalloc(hlist_array->size, sizeof(unsigned long), GFP_KERNEL);
-	if (!addrs) {
-		ret = -ENOMEM;	/* TODO: Fallback to one-by-one loop */
-		goto out;
-	}
+	if (!addrs)
+		return -ENOMEM;	/* TODO: Fallback to one-by-one loop */
 
 	/* Remove non-synonim ips from table and hash */
 	count = 0;
@@ -953,12 +944,26 @@ int unregister_fprobe(struct fprobe *fp)
 
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
+	if (!fp || !is_fprobe_still_exist(fp))
+		return -EINVAL;
+
+	return unregister_fprobe_nolock(fp);
 }
 EXPORT_SYMBOL_GPL(unregister_fprobe);
 

