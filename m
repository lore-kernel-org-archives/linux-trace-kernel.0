Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBE733C532;
	Mon, 20 Apr 2026 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693659; cv=none; b=HfrPnAQ1eyl4QiQ0DsEYOraxqSiFTvHrg5vctcRpQPeoRSFRqITKIbP3dl7imOREUxVNzgG9EeaO1wEyW9+oFE2BGfDO9kjugSm8PZLCaYyCgh85QrlThXcNgmzKSa4TdtX/+7AQGcX/iHYkWhvTKQ3vu0RvP2mo2Lt7aedaYyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693659; c=relaxed/simple;
	bh=B0rnKng8LQIVDP+HvxGHLoFM8lnqHJQo4FhLDaFMJFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EkVdgFaZfWnxVg9btGqRkHus4dtMtCoCBbXzAPiUP/4MgnMVTc+gn2wfR9RzAOMiVJCVKwtwazmg67z4ZwJfbglV7jnuKr1vEvvb/k3DxsZnR3Gmv/o1wf55n7iw9IFgDy8prpLDM4woUO58m+Dirsry/s73ivHBw82kaYsvNF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSJ+2TCi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSJ+2TCi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D14C19425;
	Mon, 20 Apr 2026 14:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776693658;
	bh=B0rnKng8LQIVDP+HvxGHLoFM8lnqHJQo4FhLDaFMJFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sSJ+2TCiApu0CB4YSaFMCbM6g4ZkQxsZlcYtTlNUfOspXN1SsEZUtHSkvdximZACU
	 mI5BVG0WZCppLxvvBhrIGgj96oVVFo+4Q5WOosP6GAUgd7laNw7iCVUsDhof9d1piq
	 AkThladHHWrEXwo+ygfIzfsaXHukn58JW7TPKCwVkorPVGNJMiFunmkc4SWO2KZbm0
	 7cr8EOp+GV/inTl0H9nYeGAOF/r//O3/SeC8Lgj3VusF8w9JArRGLR+cE7h6Rp488c
	 BmhFoBULjmlihXB+hqkHL6X6fb1m7owvsKizPiUiqmCHDZFWX1Ps92weawHFRqJuPf
	 l96vxIpS5OVSQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v10 2/8] tracing/fprobe: Unregister fprobe even if memory allocation fails
Date: Mon, 20 Apr 2026 23:00:56 +0900
Message-ID:  <177669365629.132053.8433032896213721288.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
In-Reply-To:  <177669363667.132053.12454670015890859277.stgit@mhiramat.tok.corp.google.com>
References:  <177669363667.132053.12454670015890859277.stgit@mhiramat.tok.corp.google.com>
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

unregister_fprobe() can fail under memory pressure because of memory
allocation failure, but this maybe called from module unloading, and
usually there is no way to retry it. Moreover. trace_fprobe does not
check the return value.

To fix this problem, unregister fprobe and fprobe_hash_node even if
working memory allocation fails.
Anyway, if the last fprobe is removed, the filter will be freed.

Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v9:
  - Clear ftrace_ops filter when unregister it.
 Changes in v7:
  - Newly added.
---
 kernel/trace/fprobe.c |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index af9ba7250874..a2b659006e0e 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -324,9 +324,10 @@ static void fprobe_ftrace_remove_ips(unsigned long *addrs, int num)
 	lockdep_assert_held(&fprobe_mutex);
 
 	fprobe_ftrace_active--;
-	if (!fprobe_ftrace_active)
+	if (!fprobe_ftrace_active) {
 		unregister_ftrace_function(&fprobe_ftrace_ops);
-	if (num)
+		ftrace_free_filter(&fprobe_ftrace_ops);
+	} else if (num)
 		ftrace_set_filter_ips(&fprobe_ftrace_ops, addrs, num, 1, 0);
 }
 
@@ -525,10 +526,10 @@ static void fprobe_graph_remove_ips(unsigned long *addrs, int num)
 
 	fprobe_graph_active--;
 	/* Q: should we unregister it ? */
-	if (!fprobe_graph_active)
+	if (!fprobe_graph_active) {
 		unregister_ftrace_graph(&fprobe_graph_ops);
-
-	if (num)
+		ftrace_free_filter(&fprobe_graph_ops.ops);
+	} else if (num)
 		ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 1, 0);
 }
 
@@ -932,15 +933,19 @@ int unregister_fprobe(struct fprobe *fp)
 
 	hlist_array = fp->hlist_array;
 	addrs = kcalloc(hlist_array->size, sizeof(unsigned long), GFP_KERNEL);
-	if (!addrs) {
-		ret = -ENOMEM;	/* TODO: Fallback to one-by-one loop */
-		goto out;
-	}
+	/*
+	 * This will remove fprobe_hash_node from the hash table even if
+	 * memory allocation fails. However, ftrace_ops will not be updated.
+	 * Anyway, when the last fprobe is unregistered, ftrace_ops is also
+	 * unregistered.
+	 */
+	if (!addrs)
+		pr_warn("Failed to allocate working array. ftrace_ops may not sync.\n");
 
 	/* Remove non-synonim ips from table and hash */
 	count = 0;
 	for (i = 0; i < hlist_array->size; i++) {
-		if (!delete_fprobe_node(&hlist_array->array[i]))
+		if (!delete_fprobe_node(&hlist_array->array[i]) && addrs)
 			addrs[count++] = hlist_array->array[i].addr;
 	}
 	del_fprobe_hash(fp);

