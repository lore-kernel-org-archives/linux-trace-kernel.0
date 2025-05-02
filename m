Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCBA267AF0;
	Fri,  2 May 2025 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746204610; cv=none; b=g4bZbB2W9VoRPgnKEaDrjBzZRC7Ggb54qCa0VoUH2GMkC5MHmnCP54nRfQDIf9FPZ36jLcdBiqSS2DaS+62BX+1G9lpzmP0aFpWrjXPyq3PSgvAWdEIsKlOi3IQ0e9XzmM7ssM4Ad8gUtSXWsXVU4TQZHIQ0fAuoaIcDXdPhOMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746204610; c=relaxed/simple;
	bh=Jph6NmqNgTqJBFSZ+GDtcC6ViuoUMw6YWCVmR1fFyvE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=S+9jQ++kKYyOxsqttTIX8bPyGbelrH5/NLc3XyQ7wLvoXKlmUH8Vvxfs3pywzx0Hl4D4yXX4cStludssurZ7Fkh2h6apR1SF32m1AEd31p2ei9oOU1jMVin9/AIm/B0TJUNSk4wP2AfokcG0v13KNCD/v2GnnvvlPmwqqEDrcU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D1BC4CEE4;
	Fri,  2 May 2025 16:50:09 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uAtaS-0000000033C-3ha8;
	Fri, 02 May 2025 12:50:08 -0400
Message-ID: <20250502165008.734340489@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 02 May 2025 12:47:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v7 08/17] unwind_user/deferred: Add unwind cache
References: <20250502164746.178864972@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

Cache the results of the unwind to ensure the unwind is only performed
once, even when called by multiple tracers.

The cache nr_entries gets cleared every time the task exits the kernel.
When a stacktrace is requested, nr_entries gets set to the number of
entries in the stacktrace. If another stacktrace is requested, if
nr_entries is not zero, then it contains the same stacktrace that would be
retrieved so it is not processed again and the entries is given to the
caller.

Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/entry-common.h          |  2 ++
 include/linux/unwind_deferred.h       |  7 +++++++
 include/linux/unwind_deferred_types.h |  7 ++++++-
 kernel/unwind/deferred.c              | 27 ++++++++++++++++++++-------
 4 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index f94f3fdf15fc..6e850c9d3f0c 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -12,6 +12,7 @@
 #include <linux/resume_user_mode.h>
 #include <linux/tick.h>
 #include <linux/kmsan.h>
+#include <linux/unwind_deferred.h>
 
 #include <asm/entry-common.h>
 #include <asm/syscall.h>
@@ -362,6 +363,7 @@ static __always_inline void exit_to_user_mode(void)
 	lockdep_hardirqs_on_prepare();
 	instrumentation_end();
 
+	unwind_exit_to_user_mode();
 	user_enter_irqoff();
 	arch_exit_to_user_mode();
 	lockdep_hardirqs_on(CALLER_ADDR0);
diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 5064ebe38c4f..c2d760e5e257 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -12,6 +12,11 @@ void unwind_task_free(struct task_struct *task);
 
 int unwind_deferred_trace(struct unwind_stacktrace *trace);
 
+static __always_inline void unwind_exit_to_user_mode(void)
+{
+	current->unwind_info.cache.nr_entries = 0;
+}
+
 #else /* !CONFIG_UNWIND_USER */
 
 static inline void unwind_task_init(struct task_struct *task) {}
@@ -19,6 +24,8 @@ static inline void unwind_task_free(struct task_struct *task) {}
 
 static inline int unwind_deferred_trace(struct unwind_stacktrace *trace) { return -ENOSYS; }
 
+static inline void unwind_exit_to_user_mode(void) {}
+
 #endif /* !CONFIG_UNWIND_USER */
 
 #endif /* _LINUX_UNWIND_USER_DEFERRED_H */
diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index aa32db574e43..b3b7389ee6eb 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -2,8 +2,13 @@
 #ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 
-struct unwind_task_info {
+struct unwind_cache {
 	unsigned long		*entries;
+	unsigned int		nr_entries;
+};
+
+struct unwind_task_info {
+	struct unwind_cache	cache;
 };
 
 #endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 5a3789e38c00..89ed04b1c527 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -12,6 +12,7 @@
 int unwind_deferred_trace(struct unwind_stacktrace *trace)
 {
 	struct unwind_task_info *info = &current->unwind_info;
+	struct unwind_cache *cache = &info->cache;
 
 	/* Should always be called from faultable context */
 	might_fault();
@@ -19,17 +20,29 @@ int unwind_deferred_trace(struct unwind_stacktrace *trace)
 	if (current->flags & PF_EXITING)
 		return -EINVAL;
 
-       if (!info->entries) {
-               info->entries = kmalloc_array(UNWIND_MAX_ENTRIES, sizeof(long),
-                                             GFP_KERNEL);
-               if (!info->entries)
-		       return -ENOMEM;
+	if (!cache->entries) {
+		cache->entries = kmalloc_array(UNWIND_MAX_ENTRIES, sizeof(long),
+					       GFP_KERNEL);
+		if (!cache->entries)
+			return -ENOMEM;
+        }
+
+	trace->entries = cache->entries;
+
+	if (cache->nr_entries) {
+               /*
+                * The user stack has already been previously unwound in this
+                * entry context.  Skip the unwind and use the cache.
+                */
+               trace->nr = cache->nr_entries;
+               return 0;
        }
 
 	trace->nr = 0;
-	trace->entries = info->entries;
 	unwind_user(trace, UNWIND_MAX_ENTRIES);
 
+	cache->nr_entries = trace->nr;
+
 	return 0;
 }
 
@@ -44,5 +57,5 @@ void unwind_task_free(struct task_struct *task)
 {
 	struct unwind_task_info *info = &task->unwind_info;
 
-	kfree(info->entries);
+	kfree(info->cache.entries);
 }
-- 
2.47.2


