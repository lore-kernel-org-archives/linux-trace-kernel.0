Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C022FF64F
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Dec 2025 03:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764817382; cv=none; b=hPCYRwFKw6TEGJZQPRgeg89jElHTwYMZ5bhRgP6meNFW8cQ+JvuRvHncsocaPIMeD6QWK1jSJFpN3aKcc1gonYxMGaq0tzIgyDMWfbNc67+nuszjp5z+G9LJRWcsAn8j+vQMf841+c5MXhmnsil72DQhOTbvHtzXF6gzJaIoAZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764817382; c=relaxed/simple;
	bh=AXoL/ZviS158b28X601hoGKltHqS/sOfHzkRmDtbxtU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Pu2aDY+x/BfOdFLb+sWaAxv0TScp8PKHdgof9bdscIOg5MAtVZGX5KPp0a2+5DEWIsxXst8TmRkqejRbIIZGkjxcwwnFWrlfEEX/XG+d/2Q6qoNPsQqLtcbdvoZveA1sJPzrIhX/Aqjp15fbHb9YiCuWhu1zg/MB9j8Ke/L15ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 310695200E;
	Thu,  4 Dec 2025 03:02:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id BCA692002A;
	Thu,  4 Dec 2025 03:02:48 +0000 (UTC)
Date: Wed, 3 Dec 2025 22:02:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc: Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH v2] libtracecmd: Fix continuing in
 tracecmd_iterate_events_reverse()
Message-ID: <20251203220247.53b15b10@robin>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ijjsor9jrdyxhsnojkf5zei19k58e7kt
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: BCA692002A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18G55ojNcJRdL/kXR3A5maeOsjwN9+Ju2Y=
X-HE-Tag: 1764817368-727501
X-HE-Meta: U2FsdGVkX1/WrbAy7IlvEglU+SEND337bzQXAFIfaD9wTRo3pTr4Kz3pduMLDhq7egpGBk12xCYDLuQmILfNLknOXt+AlP7LCK8v8b0arZ5O1ql7ft9wh4oWykYjrpnet3rt/FU/8CebZdr/2qzZZjOGxZlaqsOXJSvLTNjghZlF1kSiLaIW0oPyfT1muujTyVGPii7+LQ19fDTLo8YtJ87RSJl4RsEsMrVu9vohLKbu3PorJo+QUIKhZFOpLCxa571uecFMAArLJK7Y5OYBjsl6egSQvvRi2xXMSPgozW0RbHzpiuYUgcBz/P1dIQXI0gatHEgs6xZCspCExZsI6t8Gkq5zbnOZWYU68bopgTL+/chxfR7jYbjiwx+sk8SC1DVUn7FGCjAnkyfUhWIWig==

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

When a callback from tracecmd_iterate_events_reverse() returns non-zero it
cause the function to exit out early. Calling tracecmd_iterate_events_reverse()
again with cont=true, is supposed to restart where it left off. But
because of the way the reverse traverses all the events on a page, by
calling tracecmd_read_data() to find the next task, it does not pick the
next task. It can pick the next task at the start of the page.

If the callback back causes the function to exit out early, record the
page_offset of the last record read, and then set the cursor back to that
event. Then the next tracecmd_iterate_events_reverse() called with
continue will start with the next record after the one that was last
read.

Link: https://lore.kernel.org/all/20251121120117.20e82d9e@gandalf.local.home/

Fixes: 56cbc522518a5 ("trace-cmd library: Add tracecmd_iterate_events_reverse() API")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/all/20251121120947.368ad1bd@gandalf.local.home/

- Make the next call to tracecmd_iterate_events_reverse() start with
  the next record after the last one read and not the last one that was
  read.

 lib/trace-cmd/trace-input.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/trace-cmd/trace-input.c b/lib/trace-cmd/trace-input.c
index afdbd2aa98b6..5cb13c3f804b 100644
--- a/lib/trace-cmd/trace-input.c
+++ b/lib/trace-cmd/trace-input.c
@@ -3036,6 +3036,7 @@ int tracecmd_iterate_events_reverse(struct tracecmd_input *handle,
 				    void *callback_data, bool cont)
 {
 	unsigned long long last_timestamp = 0;
+	unsigned long long page_offset = 0;
 	struct tep_record **records;
 	struct tep_record *record;
 	int next_cpu;
@@ -3072,6 +3073,8 @@ int tracecmd_iterate_events_reverse(struct tracecmd_input *handle,
 			record = next_last_event(handle, records, next_cpu);;
 			ret = call_callbacks(handle, record, next_cpu,
 					     callback, callback_data);
+			if (ret)
+				page_offset = record->offset;
 			tracecmd_free_record(record);
 		}
 	} while (next_cpu >= 0 && ret == 0);
@@ -3079,6 +3082,17 @@ int tracecmd_iterate_events_reverse(struct tracecmd_input *handle,
 	free_last_events(handle, records, cpus, cpu_size, max_cpus);
 	free(records);
 
+	/*
+	 * If the callback exited out early, then set the cursor back
+	 * to the location of that record so that if this gets called
+	 * again with cont = true, it will continue where it left off.
+	 */
+	if (page_offset) {
+		/* Set the internal cursor to the last record that was read */
+		record = tracecmd_read_at(handle, page_offset, NULL);
+		tracecmd_free_record(record);
+	}
+
 	return ret;
 }
 
-- 
2.51.0

