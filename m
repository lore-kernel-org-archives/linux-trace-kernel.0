Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E18E363C4C;
	Wed, 20 May 2026 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301688; cv=none; b=ZjL46l5jR1QCBlfpzdZbHsM1wUq7jmHuCl4nfzjdSIwHaxmn0/N0/q7K0G3SjeGQ9df9+GkZCEWPl62eN9BFHup4o+SnsnAlVXtZnrFBE/cZ7eDcguvqji9k2itwWriEeFr/IZ+FCVOSG4nZDnjJJZB4A0a53m/a82yP3ChXNwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301688; c=relaxed/simple;
	bh=ocL88MDLDLDXWchYd1ddmpWL2VsLW4FD3PTg/f98BX0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=OLU9J+GLURmAhOoScHfccurhFEtkNfqwWlbJyRmHBNXUjjNauuDGO1zJkD6o8vGg7T9OGwQIwq9P09YNwgVk606jABr2HjwVqTL69++gfc0IoquBHDyuhBXjtkyeLluLbEyLEKqre22v0h9MT/WswApA2mvBGzl567ykPH/v5pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 28902160D32;
	Wed, 20 May 2026 18:28:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 9E8B480019;
	Wed, 20 May 2026 18:27:58 +0000 (UTC)
Date: Wed, 20 May 2026 14:28:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ring-buffer: Fix reporting of missed events in iterator
Message-ID: <20260520142817.4050abab@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9E8B480019
X-Rspamd-Server: rspamout06
X-Stat-Signature: zswo4qgspgwwppgj3cxtgu9ph5pftg3t
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+g9eidD7DLGEdVVJMhpVCBJIfp+R17ciI=
X-HE-Tag: 1779301678-153184
X-HE-Meta: U2FsdGVkX18crBLR0kUZnT5MilNYzwojvfcjpOx60V+4niDuEoSMY2OAchCX5SdDPSYwrUNIhPdSduZ3uHnicAukhRZiU85wDHQHGxLvmNhyze/ovP3IiwPJKfvc/5A0tic6fAt+NASlFAymuAjYgsx6oRiAPyYck6CqIA2xtwU/AhKhDCd8xjVMdMf3LTN2nUlRj216PESMEMt0YbXahDcXRulo8AFzTvAzBSh6whumPOevodQcyojmHWe8nybkHOwzas9heDNcE8pf6ZBzNjj4WDRd7vtZnLxNJoxMbbcygLZN9lruOiRpGdAFDaOGI2z0HBXElVeGG25NsrCzAq1qzpSsGH3D4q3eLZ0lNj8h3naebwo4RBPhdcQflumO0k0vGgabMAGvbJ8DrAZ73Q==

From: Steven Rostedt <rostedt@goodmis.org>

When tracing is active while reading the trace file, if the iterator
reading the buffer detects that the writer has passed the iterator head,
it will reset and set a "missed events" flag. This flag is passed to the
output processing to show the user that events were missed:

  CPU:4 [LOST EVENTS]

The problem is that the flag is reset after it is checked in
ring_buffer_iter_dropped(). But the "trace" file iterates over all the CPU
ring buffers and it will check if they are dropped when figuring out which
buffer to print next. This prematurely clears the missed_events flag if
the CPU buffer with the missed events is not the one that is printed next.

On the iteration where the CPU buffer with the missed events is printed,
the check if it had missed events would return false and the output does
not show that events were missed.

Do not reset the missed_events flag when checking if there were missed
events, but instead clear it when moving the iterator head to the next
event.

Cc: stable@vger.kernel.org
Fixes: c9b7a4a72ff64 ("ring-buffer/tracing: Have iterator acknowledge dropped events")
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 5326924615a4..47b0a7b43f0f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6086,10 +6086,7 @@ ring_buffer_peek(struct trace_buffer *buffer, int cpu, u64 *ts,
  */
 bool ring_buffer_iter_dropped(struct ring_buffer_iter *iter)
 {
-	bool ret = iter->missed_events != 0;
-
-	iter->missed_events = 0;
-	return ret;
+	return iter->missed_events != 0;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_iter_dropped);
 
@@ -6251,7 +6248,7 @@ void ring_buffer_iter_advance(struct ring_buffer_iter *iter)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
-
+	iter->missed_events = 0;
 	rb_advance_iter(iter);
 
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
-- 
2.53.0

