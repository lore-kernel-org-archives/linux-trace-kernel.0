Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC19358384;
	Fri, 29 May 2026 02:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780022264; cv=none; b=k1piqxkV9HtJz8/897ynBHssKQe7QraJpImh/CTXCa0UJJMFnGJA65pKM9JN4HiSDS1xvfMycgH6rMgWlaBgPKWEmCAqdXJnbrQW1sng85uJhiimeqkCo2g4zD1GtdyutrOVd1sXuzVgWH48PT0mZYe+O7RxE/Rxq/n9D4FPDDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780022264; c=relaxed/simple;
	bh=+lRqd7fgbD3C0tKDu7J+kiasljidHJqhMq+iUpm76Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DraIaUxlWhz+poe7LJhp8+h1hfOYLDDqsxa6TV5lZ+eORAQbnCO7BOWWCVLV1ckdGitoUVdjGGoxLX6i9BF6icCROisMQeeuW7tC24fSI6+ihZoji3CwFkjvV2QDIZUM12zLLigwgfjs5/4RKxSmD7d7XlzMY3WUkQ55go7lx64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 8239D140F9A;
	Fri, 29 May 2026 02:37:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id EA6E12000E;
	Fri, 29 May 2026 02:37:39 +0000 (UTC)
Date: Thu, 28 May 2026 22:37:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ring-buffer: Better comment the use of RB_MISSED_EVENTS
Message-ID: <20260528223738.41276c0e@fedora>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: EA6E12000E
X-Stat-Signature: oer51cd88z158t6m9uaze1bfsmsas99o
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19UmdSRMHCYJsjOm8ljH4MvO69LsyHiSYw=
X-HE-Tag: 1780022259-966133
X-HE-Meta: U2FsdGVkX18xj3A2SEK6bNk8NhatFRc4SFIQLPJGt9XpLjI+dVdPwEJL7a1RCHYHyXz6iUbi3hBlaHDHM/fmkr3WnHf8qkoBMmGpqUc9LYvSUjLK2/LFuTM9+fmIkKuNV17r+gHhiYzBreZSH6nBHQjMKhg0txdYhByLNY5F14pRalHKCrfSAi7CSAZaZ7yK//aD7kY4EmdCUJxOwtbMvTyfb7ZMZq+C0quz/hxxK2i0PcWnZhwmEm/to/xSIedfI6xpRizJtLmG43r3r0kC0b5mAbGuD4xRU1bI9CGnHFpuV9C8kTaAuj6DUTtXraCk88anJcgjEo2dx1u/30Z1Bn0i4xrsmMzZX4/Lj2Z09DLVZsqqN6hIyAarSjFkum3IwjTDfcWp/sGENOTD/isqPQ==

From: Steven Rostedt <rostedt@goodmis.org>

If the persistent ring buffer is detected on boot up to have a corrupted
sub-buffer, that sub-buffer is cleared to zero and its commit value has
the RB_MISSED_EVENTS bit set. That bit is to allow the "trace",
"trace_pipe" and "trace_pipe_raw" files know that events were dropped by
outputting "[LOST EVENTS]".

Only in this case does that bit get set in the writeable portion of the
ring buffer. When events are dropped in the normal ring buffer, that
information is stored in the cpu_buffer descriptor and the
RB_MISSED_EVENTS is set in the buffer page at the time the page is
consumed. It is never set in the writeable portion of the buffer.

Add comments to describe this better as it can be confusing to know when
the RB_MISSED_EVENTS are set in the commit portion of the buffer page.

Link: https://lore.kernel.org/all/20260529001500.14178455a046a5cbc6180861@kernel.org/

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 910f6b3adf74..06fb365bb86e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1929,6 +1929,12 @@ static int __rb_validate_buffer(struct buffer_page *bpage, int cpu,
 	 */
 	if (ret < 0 || (prev_ts && prev_ts > ts) || (next_ts && ts > next_ts)) {
 		local_set(&bpage->entries, 0);
+		/*
+		 * Note, the RB_MISSED_EVENTS is only set inside the main write
+		 * buffer by this verification logic. The normal ring buffer
+		 * has this bit set when the page is read and passed to the
+		 * consumers.
+		 */
 		local_set(&dpage->commit, RB_MISSED_EVENTS);
 		dpage->time_stamp = prev_ts ? prev_ts : next_ts;
 		ret = -1;
@@ -7232,6 +7238,14 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 			local_add(RB_MISSED_STORED, &dpage->commit);
 			size += sizeof(missed_events);
 		}
+		/*
+		 * Note, for the persistent ring buffer, the RB_MISSED_EVENTS
+		 * may have been set in the main buffer via the verification code.
+		 * But here, dpage is a copy of that page and has not yet had
+		 * the RB_MISSED_EVENTS set. As for the normal buffers,
+		 * the main write buffer does not set these bits and it needs
+		 * to be set here.
+		 */
 		local_add(RB_MISSED_EVENTS, &dpage->commit);
 	}
 
-- 
2.53.0

