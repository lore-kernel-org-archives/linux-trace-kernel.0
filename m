Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62421A2550;
	Tue, 21 Jan 2025 20:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737490354; cv=none; b=Hdz7oy682Vmi83iXd43V9gH4cskqeDYgATyR/pChCkFJEQ6/srXIvetKj4n4Ke9gIcdwUyHLt2iCMitLKhoL9r4bDDJHUEwTZ+CNfEvoA7XU6WMfDjYxQVIbQ6qH8bMFRyCCkPdLON7aDD2V+wF3jnGK3PeyE/72en0js4soIGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737490354; c=relaxed/simple;
	bh=hCHX0Go2VF9VIUh0junnH5x2evJ1YFHQ+uJFvWppspk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ivofX0RJMnHXUDBBuDWClCsNBTg0HymBRrB7tUJEVqmVfdReS852yfVU4o4f7wJIllnp/Pp3cqwgoZloeheSW28K+yuJFauyVIhK4sLf1gsYozfAgsqK8PNtnOIwhH2ZgSDcc6m+1mHXtCRvtOUJAHq7ApsQ8bKYeaa/wU3NfA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AA6C4CEDF;
	Tue, 21 Jan 2025 20:12:33 +0000 (UTC)
Date: Tue, 21 Jan 2025 15:12:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sasha Levin <sashal@kernel.org>, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] tracing: Fix allocation of printing set_event file content
Message-ID: <20250121151236.47fcf433@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The adding of cached events for modules not loaded yet required a
descriptor to separate the iteration of events with the iteration of
cached events for a module. But the allocation used the size of the
pointer and not the size of the contents to allocate its data and caused a
slab-out-of-bounds.

Reported-by: Sasha Levin <sashal@kernel.org>
Closes: https://lore.kernel.org/all/Z4_OHKESRSiJcr-b@lappy/
Fixes: b355247df104e ("tracing: Cache ":mod:" events for modules not loaded yet")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 51c5014877e8..5217dcddcb4c 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1588,7 +1588,7 @@ static void *s_start(struct seq_file *m, loff_t *pos)
 	struct set_event_iter *iter;
 	loff_t l;
 
-	iter = kzalloc(sizeof(iter), GFP_KERNEL);
+	iter = kzalloc(sizeof(*iter), GFP_KERNEL);
 	if (!iter)
 		return NULL;
 
-- 
2.45.2

