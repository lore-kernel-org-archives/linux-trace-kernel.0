Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70763032A;
	Fri, 26 Jul 2024 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019332; cv=none; b=i7326Dx9tAfDAG9yT4HUoL6h+GD09BszIkuCFfCc4HZWICBW+h8/7sXUnrgX/bjeP0xNxwMAcHvk90VdOHFp/Vu0Trsv8SCCqMhz1FXQohdvjXofs9UR50fqHyoY6BDDaj2T+TJsR4FJrfTjfrQQS3YJVR+HlkdDq+sNdXvWoew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019332; c=relaxed/simple;
	bh=zObUU4lAhpGpelL+rCoAJqPdcYFh3roDcp+/vRmSysE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fJZBU07oW4yD56eNpms7IyiqZKWn12vmhO8QYwzfZvP1ttpPnVWNrvHpAy8aBlTqRzxq50t2gTzhdxVKngU8ftyFiMTREIR7OoC/kmkUIyT0pYPh+/n+UsNSA+ZNvHCxHtBgFhZnfyPR3Gi0chVO8aF5ArpZwLMDd9snvkM8Kt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04275C32782;
	Fri, 26 Jul 2024 18:42:10 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:42:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Use refcount for trace_event_file reference
 counter
Message-ID: <20240726144208.687cce24@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

Instead of using an atomic counter for the trace_event_file reference
counter, use the refcount interface. It has various checks to make sure
the reference counting is correct, and will warn if it detects an error
(like refcount_inc() on '0').

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_events.h | 2 +-
 kernel/trace/trace_events.c  | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 9df3e2973626..fed58e54f15e 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -680,7 +680,7 @@ struct trace_event_file {
 	 * caching and such. Which is mostly OK ;-)
 	 */
 	unsigned long		flags;
-	atomic_t		ref;	/* ref count for opened files */
+	refcount_t		ref;	/* ref count for opened files */
 	atomic_t		sm_ref;	/* soft-mode reference counter */
 	atomic_t		tm_ref;	/* trigger-mode reference counter */
 };
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 852643d957de..81ade9ddcbe5 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -992,18 +992,18 @@ static void remove_subsystem(struct trace_subsystem_dir *dir)
 
 void event_file_get(struct trace_event_file *file)
 {
-	atomic_inc(&file->ref);
+	refcount_inc(&file->ref);
 }
 
 void event_file_put(struct trace_event_file *file)
 {
-	if (WARN_ON_ONCE(!atomic_read(&file->ref))) {
+	if (WARN_ON_ONCE(!refcount_read(&file->ref))) {
 		if (file->flags & EVENT_FILE_FL_FREED)
 			kmem_cache_free(file_cachep, file);
 		return;
 	}
 
-	if (atomic_dec_and_test(&file->ref)) {
+	if (refcount_dec_and_test(&file->ref)) {
 		/* Count should only go to zero when it is freed */
 		if (WARN_ON_ONCE(!(file->flags & EVENT_FILE_FL_FREED)))
 			return;
@@ -2999,7 +2999,7 @@ trace_create_new_event(struct trace_event_call *call,
 	atomic_set(&file->tm_ref, 0);
 	INIT_LIST_HEAD(&file->triggers);
 	list_add(&file->list, &tr->events);
-	event_file_get(file);
+	refcount_set(&file->ref, 1);
 
 	return file;
 }
-- 
2.43.0

