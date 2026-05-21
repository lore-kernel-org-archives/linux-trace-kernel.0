Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19F93D7D91;
	Thu, 21 May 2026 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371410; cv=none; b=Th37M950kp6JisKx/DvJx7SBFNJcdmMaUJV+vRFEZMHd9gxpt45OZK9z1gu8RB/bRDvnfJPSJgW/9ChSx8utFYYdejAbKTrfGWwS+JDXlImUSp6i1PLQLZAm6/4zyt4HpwCbrxC4jqwiOY1FlKIhZTtkFCb2SVVoLC1ZPmYLkFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371410; c=relaxed/simple;
	bh=qdmh9actQViSDg7m0X6nMq09bxwwqdgAdbVTqk75ChY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=stVz5BThHgi+ABEnAVkxv2TfIPNm6l2mWNY4u6JsacxmuGGDUSvV5cfEn1qyzatyLDrI10IvbDqXmASS+dkRjTUhQi0PresS+bAINSnuIXxd0N89n6Lmn8tN2PaKuftzqDyRF+SuzRnXdifJLjiPxdTOuokcybVZClET++zYn6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id CEC4D403B2;
	Thu, 21 May 2026 13:50:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 4AE7534;
	Thu, 21 May 2026 13:50:06 +0000 (UTC)
Date: Thu, 21 May 2026 09:50:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Move trace_iterator_increment() into
 trace_find_next_entry_inc()
Message-ID: <20260521095026.20c9799d@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4AE7534
X-Rspamd-Server: rspamout06
X-Stat-Signature: a78kzj5b7y49omfmrmbaojhtq4d6egdw
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18s9xSgnWvpme1h8BME2XP4W3JSOpJzPr0=
X-HE-Tag: 1779371406-730136
X-HE-Meta: U2FsdGVkX1+3cCDTg77FlrGCO2ygnt/lE4kpWBgyNygdys3aXRfg2RoRaBwPpCGhYaFoEp30dSPtS6MiPQhvPj4S5Tr8yMjZeqWYTxA2ImBj1vLK/LC5WHAUxH8MJlNacnvk/Ua4HyZwbSNovHi1rCd3IQHX/WFIdlxUNmkfpHAbJH3Oq4iVLPJYf324n3ddY8WsuHWQHDQRhVxazBuWXKaOWacE3DU2VkBlyaW2VtuJvtQROnsUB37Ff/YvaxpPIukZOHjEad8qWWa49q3puKtGagKFaeWacfh2p447SBP3FfLg8w5owZwQkYa+PZNKlQudAjdb4B4aGXiMqoFp3MfACgHK8gBLQ9fFb572S0DvuPXjcatjz2fWVIYVXBaa

From: Steven Rostedt <rostedt@goodmis.org>

trace_iterator_increment() is only called from trace_find_next_entry_inc().
It's a small enough function that really doesn't need to be separated.

Move the code from trace_iterator_increment() into
trace_find_next_entry_inc() and remove trace_iterator_increment().

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4573f65d68ce..0b43e88ac378 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2338,15 +2338,6 @@ void trace_last_func_repeats(struct trace_array *tr,
 	__buffer_unlock_commit(buffer, event);
 }
 
-static void trace_iterator_increment(struct trace_iterator *iter)
-{
-	struct ring_buffer_iter *buf_iter = trace_buffer_iter(iter, iter->cpu);
-
-	iter->idx++;
-	if (buf_iter)
-		ring_buffer_iter_advance(buf_iter);
-}
-
 static struct trace_entry *
 peek_next_entry(struct trace_iterator *iter, int cpu, u64 *ts,
 		unsigned long *lost_events)
@@ -2676,11 +2667,17 @@ struct trace_entry *trace_find_next_entry(struct trace_iterator *iter,
 /* Find the next real entry, and increment the iterator to the next entry */
 void *trace_find_next_entry_inc(struct trace_iterator *iter)
 {
+	struct ring_buffer_iter *buf_iter;
+
 	iter->ent = __find_next_entry(iter, &iter->cpu,
 				      &iter->lost_events, &iter->ts);
 
-	if (iter->ent)
-		trace_iterator_increment(iter);
+	if (iter->ent) {
+		iter->idx++;
+		buf_iter = trace_buffer_iter(iter, iter->cpu);
+		if (buf_iter)
+			ring_buffer_iter_advance(buf_iter);
+	}
 
 	return iter->ent ? iter : NULL;
 }
-- 
2.53.0

