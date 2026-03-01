Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05E413B58A;
	Sun,  1 Mar 2026 01:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329185; cv=none; b=ibNB4WlfvUVVLz5kSO1NkrhVtgFJwr72xJVZkVeeT/an5wfocC4t9mvwNHcA2Pdfhn1eM8CFc3C/wryykCeipirIDGCbcqMphVrep/aXIZjsYmdRxv4VMcYGiV1WFSSFFKfoaIuR2ZywPcPmC2DsgXGM5HIf9aZeBlkvC7SiJlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329185; c=relaxed/simple;
	bh=VH48fcp+2oB3iYUNX93PtT5RmBaiJMwnznEnFOsguu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mCXTA4CMrvz+WYFkeu6uacPhKoUUlmaijWyB+gU+NDxFaEXwxChnqol3b+RVqej5zDgdkcgfZ5cRRANSL6BdOwJnFFOrc3XzZSlSyHGe3LPm4LtxubEkp4Gz/TzNHVZyp+e5Jqnb3cP/sKwXOIqc5bs4CHLEAWwFzwxRRx6oUcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dz/0gLdl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dz/0gLdl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4339C19421;
	Sun,  1 Mar 2026 01:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329185;
	bh=VH48fcp+2oB3iYUNX93PtT5RmBaiJMwnznEnFOsguu0=;
	h=From:To:Cc:Subject:Date:From;
	b=dz/0gLdl9o3Yc4RL0W+oVvq+vwtveE9xjiXLEKMnmdT8QqEsKKQeH8oZkocJm0xBy
	 i7YxIqPigIEbam48sfx0jIf97sIGGQJ/A3SCPJWcO7Xv0PbbONIjxq9hngHdHLfMx1
	 FRa3gaD+zv+mioU8XBySY5hOuG1tqgP2aeaGXteoU3jy0EMkiwc1yysNaTW2dtx3Fb
	 PbUI+iys7s5j3bFG56P1dYvavkRqW1hHI5F9GC9cUn4s1UucN34ElI0jf00Thfc1uX
	 M+QZx17JmOG4CGg9wscJgvhTAylMr2ssWeJh4D/+w1sQ08GspVFz60skDhE+gQbeZ/
	 KsbVQvl0zXCwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	petr.pavlu@suse.com
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Subject: FAILED: Patch "tracing: Wake up poll waiters for hist files when removing an event" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:39:43 -0500
Message-ID: <20260301013943.1700798-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9678e53179aa7e907360f5b5b275769008a69b80 Mon Sep 17 00:00:00 2001
From: Petr Pavlu <petr.pavlu@suse.com>
Date: Thu, 19 Feb 2026 17:27:02 +0100
Subject: [PATCH] tracing: Wake up poll waiters for hist files when removing an
 event

The event_hist_poll() function attempts to verify whether an event file is
being removed, but this check may not occur or could be unnecessarily
delayed. This happens because hist_poll_wakeup() is currently invoked only
from event_hist_trigger() when a hist command is triggered. If the event
file is being removed, no associated hist command will be triggered and a
waiter will be woken up only after an unrelated hist command is triggered.

Fix the issue by adding a call to hist_poll_wakeup() in
remove_event_file_dir() after setting the EVENT_FILE_FL_FREED flag. This
ensures that a task polling on a hist file is woken up and receives
EPOLLERR.

Cc: stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tom Zanussi <zanussi@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://patch.msgid.link/20260219162737.314231-3-petr.pavlu@suse.com
Fixes: 1bd13edbbed6 ("tracing/hist: Add poll(POLLIN) support on hist file")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_events.h | 5 +++++
 kernel/trace/trace_events.c  | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 0a2b8229b999c..37eb2f0f3dd8e 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -683,6 +683,11 @@ static inline void hist_poll_wakeup(void)
 
 #define hist_poll_wait(file, wait)	\
 	poll_wait(file, &hist_poll_wq, wait)
+
+#else
+static inline void hist_poll_wakeup(void)
+{
+}
 #endif
 
 #define __TRACE_EVENT_FLAGS(name, value)				\
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 61fe01dce7a6f..b659653dc03ac 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1311,6 +1311,9 @@ static void remove_event_file_dir(struct trace_event_file *file)
 	free_event_filter(file->filter);
 	file->flags |= EVENT_FILE_FL_FREED;
 	event_file_put(file);
+
+	/* Wake up hist poll waiters to notice the EVENT_FILE_FL_FREED flag. */
+	hist_poll_wakeup();
 }
 
 /*
-- 
2.51.0




