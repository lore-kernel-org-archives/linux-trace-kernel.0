Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064158488;
	Mon,  6 May 2024 23:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715038402; cv=none; b=ASmo9WhXeEUz7KV8jJnv0yW4sPaXAwIqM/1euQE0lXplWc+rcGE8CPqO75w1/ynmj+euxIjgeCKkyvFVWSBaZU0Soh3kaa9cga9il4z259vLG/YFLFR/qlmW887rRiqcGRUYNjIXwuc2IfdGDFdujgrtXbzsFMAQz/Uop7WJTq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715038402; c=relaxed/simple;
	bh=df3PknBoU5anix9cujjsIkNJ2/JsZBYJnYG+M0uQU10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E2ivfgrwxmVCiKk6rwg2fIVbW3/0uBVP0LU5HArevyKOpo8QjdUmSaYQ887cxcezJjw/dlqeKMl+2jEJQnNUBBwvej3l5HD7IWiZHzTjKLKn8ACrYlezY9EsIU7+9fKK+fG5zxeDKg0pigTcCDg6UHqb2ucwf0GkK9z4WZE0wiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=TJjHeCmh; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="TJjHeCmh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=6ada3f4kBJibYxGlzsjUF3a6VdyBLasYcCQk38XKLBA=; b=TJjHeCmhQ1vBSEj9
	WEyzHBWrHra+PiU+pLJBIeQsdzYG1FKpGdD4FBJq0p3mLfPaRUicbogZ8SUh0KuSqk4T+W6Af1JGp
	2CfTXwZ9/mvFDr+eKiMK8FHOroEUUpVIXRgBqqrIxUr4ZBtfXxy0WNYsUzjZXzccXnjd2t+qNQB4B
	n14IhP9dg+qeZ4Vtzn1Lyj1fF/eG+N/YPyhHRh1TESsi6njSwUQD+Y4u3numWgtvf9U1pNJJuxwAS
	A3sxelX7MZSqP0Tcjg7snEywqGJtVR/Dis8tHuAZ01C2gVMDRAsdZpKFtObAeq/EvmpD3oq802D1L
	4TzCsdofv+Evqhy97g==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s47pV-0051VW-2t;
	Mon, 06 May 2024 23:33:09 +0000
From: linux@treblig.org
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] ftrace: Remove unused global 'ftrace_direct_func_count'
Date: Tue,  7 May 2024 00:33:05 +0100
Message-ID: <20240506233305.215735-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Commit 8788ca164eb4b ("ftrace: Remove the legacy _ftrace_direct API")
stopped setting the 'ftrace_direct_func_count' variable, but left
it around.  Clean it up.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/linux/ftrace.h |  2 --
 kernel/trace/fgraph.c  | 11 -----------
 kernel/trace/ftrace.c  |  1 -
 3 files changed, 14 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index b01cca36147ff..e3a83ebd1b333 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -413,7 +413,6 @@ struct ftrace_func_entry {
 };
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
-extern int ftrace_direct_func_count;
 unsigned long ftrace_find_rec_direct(unsigned long ip);
 int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
 int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
@@ -425,7 +424,6 @@ void ftrace_stub_direct_tramp(void);
 
 #else
 struct ftrace_ops;
-# define ftrace_direct_func_count 0
 static inline unsigned long ftrace_find_rec_direct(unsigned long ip)
 {
 	return 0;
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index c83c005e654e3..a130b2d898f7c 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -125,17 +125,6 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 {
 	struct ftrace_graph_ent trace;
 
-#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
-	/*
-	 * Skip graph tracing if the return location is served by direct trampoline,
-	 * since call sequence and return addresses are unpredictable anyway.
-	 * Ex: BPF trampoline may call original function and may skip frame
-	 * depending on type of BPF programs attached.
-	 */
-	if (ftrace_direct_func_count &&
-	    ftrace_find_rec_direct(ret - MCOUNT_INSN_SIZE))
-		return -EBUSY;
-#endif
 	trace.func = func;
 	trace.depth = ++current->curr_ret_depth;
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index b18b4ece3d7c9..adf34167c3418 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2538,7 +2538,6 @@ ftrace_find_unique_ops(struct dyn_ftrace *rec)
 /* Protected by rcu_tasks for reading, and direct_mutex for writing */
 static struct ftrace_hash __rcu *direct_functions = EMPTY_HASH;
 static DEFINE_MUTEX(direct_mutex);
-int ftrace_direct_func_count;
 
 /*
  * Search the direct_functions hash to see if the given instruction pointer
-- 
2.45.0

