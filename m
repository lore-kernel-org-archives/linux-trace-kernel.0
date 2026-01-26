Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85211FC7FB;
	Mon, 26 Jan 2026 18:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769450440; cv=none; b=SWQtI5MWwd8UNBcOGJ5wCvGEHX06bEYqbTYA6BvhNVYBHWsSmSBWU1wRLHNDtsASaKufGhjmU2oeD3emC5IzwBYgbCZEdjFYFZo8l7FukNQ3FEYH4nUWq/l1KXHAsAsOv7nu9Ng1td/TPRG+m5k4l2YzLbV7FegZkvotBQzIBf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769450440; c=relaxed/simple;
	bh=45KasaFR6y+1FQoCE5U8JN3wpN2OA3XTEsLGhSC+jjU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=VPHRTnuf3ICIQFBWlqN42DObkNS+etXjkt03Pmb7X+4Ugd4Fe1fLL9sOK9DKMpQ9kS7KuR081YQNALTfqeDjJnXmuURYUOSycos1pqbj9r+Q9s0hi8hwjz+SuqRTCCaHj0wkR0hpHkVxGtBSW2wUDPixwQku2PUiULt+zB47sHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 4CFC51608AA;
	Mon, 26 Jan 2026 18:00:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 872346000B;
	Mon, 26 Jan 2026 18:00:35 +0000 (UTC)
Date: Mon, 26 Jan 2026 13:00:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH] tracing: Remove duplicate ENABLE_EVENT_STR and 
 DISABLE_EVENT_STR macros
Message-ID: <20260126130037.4ba201f9@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 872346000B
X-Stat-Signature: 5qg4kqtsibq3pj3r99oec7mrk777cakt
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+HHEZ9g2+V+Rl7M5CPmUZMvtVvVtTjo64=
X-HE-Tag: 1769450435-758238
X-HE-Meta: U2FsdGVkX1/xiHgQKdU2aAjIe8+sn5XeanXklc7eL7Uw7HEYYiP/ZD5BJ0Vd8ZamzUPjPG/S3z9/+QNwWv8iGIeauZfwMnPTQEe74Dx8M1hiM5l6hlzGuBLyCca0phPI7kDhV0NFIYAwP8FkicpZ5eC9C1xNJ1uNoejGCdZZBfRUJsWij275dbwKXDAsMlC34RCBliQvX75rVfaGduzskB4n/lYtjaVl3/h/Bs1ojDllpHJGAxJsJY7ohGWVIq2YknZQmYHH1JS3ymV7xUZUoxJkVFG+NwDY/VU9FjAPkPqmkyGH00KTfHGZ2WoKxppf/pXtm0yLQ4D9df9BkK671OcNdvZGBBbh5FqhMclES/P42kXnkoocoBfaWjaFwKI8E4pdQQOF5accY0x+qiShhg==

From: Steven Rostedt <rostedt@goodmis.org>

The macros ENABLE_EVENT_STR and DISABLE_EVENT_STR were added to trace.h so
that more than one file can have access to them, but was never removed
from their original location. Remove the duplicates.

Fixes: d0bad49bb0a09 ("tracing: Add enable_hist/disable_hist triggers")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 166b0d59be3d..af6d1fe5cab7 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -4113,11 +4113,6 @@ void trace_put_event_file(struct trace_event_file *file)
 EXPORT_SYMBOL_GPL(trace_put_event_file);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-
-/* Avoid typos */
-#define ENABLE_EVENT_STR	"enable_event"
-#define DISABLE_EVENT_STR	"disable_event"
-
 struct event_probe_data {
 	struct trace_event_file	*file;
 	unsigned long			count;
-- 
2.51.0

