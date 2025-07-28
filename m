Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CC226B75C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710665; cv=none; b=AQpCfXPLijq8tn8or9PNXs8+0XLRroG8wCqKW109rjGsa4d7oVWvnWyBBOqxVSUyKY1zcakuSQlIxNgIOaJ1M2mVKjScDe9fAxefDsONToAGvFiPfq5T7qMJ94MvwvZ1F4CZm5eevwQINEgR7DZlOJg/XelrRj8kTb0HJNhySig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710665; c=relaxed/simple;
	bh=r29Q9FG0WKRLs0uX3uFtig4KnkopRaaSrLZsGP9yLUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APwhe6aM4vEJUBDuJwJWolx3K0yJIafUKMwVjhYMpcnZoouco1ck6gZG1cobWDQRaYnTBXMOEouepEL41sf7my0lvpYVttEMQgJ2HkXCRRckPwMNVSKHvWK7yco0ZSVj+VyACcnrAR5GPOTFnPKY0+AvnpVKgJEts8/H7jKyy5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+sluaVf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+sluaVf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753710663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dHfOkuQeKnChCXoWnOaIjVjwkLjX5/enoun8tALv5yQ=;
	b=O+sluaVfSCBRfcMbqRls6cDITo3VrVmpvdvmg1q5ZHMmxLifbZHJ4uUQ5Ju7/JQIXGNKHg
	4iuuRJ23brBBsmYIv8JGQj68/91PKFnwJRh2KZIG4PNJZtJgLGzj9ZETGWfeg/sAk1eY5V
	AtPI9dL7nBiwLRmIQfTE/oEieuQ2kE8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-0jjsgZ18OGWsFWjkuv8nDg-1; Mon,
 28 Jul 2025 09:50:59 -0400
X-MC-Unique: 0jjsgZ18OGWsFWjkuv8nDg-1
X-Mimecast-MFC-AGG-ID: 0jjsgZ18OGWsFWjkuv8nDg_1753710658
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62477180044F;
	Mon, 28 Jul 2025 13:50:58 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.215])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C28511800285;
	Mon, 28 Jul 2025 13:50:52 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v5 3/9] rv: Use strings in da monitors tracepoints
Date: Mon, 28 Jul 2025 15:50:15 +0200
Message-ID: <20250728135022.255578-4-gmonaco@redhat.com>
In-Reply-To: <20250728135022.255578-1-gmonaco@redhat.com>
References: <20250728135022.255578-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Using DA monitors tracepoints with KASAN enabled triggers the following
warning:

 BUG: KASAN: global-out-of-bounds in do_trace_event_raw_event_event_da_monitor+0xd6/0x1a0
 Read of size 32 at addr ffffffffaada8980 by task ...
 Call Trace:
  <TASK>
 [...]
  do_trace_event_raw_event_event_da_monitor+0xd6/0x1a0
  ? __pfx_do_trace_event_raw_event_event_da_monitor+0x10/0x10
  ? trace_event_sncid+0x83/0x200
  trace_event_sncid+0x163/0x200
 [...]
 The buggy address belongs to the variable:
  automaton_snep+0x4e0/0x5e0

This is caused by the tracepoints reading 32 bytes __array instead of
__string from the automata definition. Such strings are literals and
reading 32 bytes ends up in out of bound memory accesses (e.g. the next
automaton's data in this case).
The error is harmless as, while printing the string, we stop at the null
terminator, but it should still be fixed.

Use the __string facilities while defining the tracepoints to avoid
reading out of bound memory.

Fixes: 792575348ff7 ("rv/include: Add deterministic automata monitor definition via C macros")
Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/rv_trace.h | 76 +++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 17ba07329b67..d38e0d3abdfd 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -16,23 +16,23 @@ DECLARE_EVENT_CLASS(event_da_monitor,
 	TP_ARGS(state, event, next_state, final_state),
 
 	TP_STRUCT__entry(
-		__array(	char,	state,		MAX_DA_NAME_LEN	)
-		__array(	char,	event,		MAX_DA_NAME_LEN	)
-		__array(	char,	next_state,	MAX_DA_NAME_LEN	)
-		__field(	bool,	final_state			)
+		__string(	state,		state		)
+		__string(	event,		event		)
+		__string(	next_state,	next_state	)
+		__field(	bool,		final_state	)
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->state,		state,		MAX_DA_NAME_LEN);
-		memcpy(__entry->event,		event,		MAX_DA_NAME_LEN);
-		memcpy(__entry->next_state,	next_state,	MAX_DA_NAME_LEN);
-		__entry->final_state		= final_state;
+		__assign_str(state);
+		__assign_str(event);
+		__assign_str(next_state);
+		__entry->final_state = final_state;
 	),
 
 	TP_printk("%s x %s -> %s%s",
-		__entry->state,
-		__entry->event,
-		__entry->next_state,
+		__get_str(state),
+		__get_str(event),
+		__get_str(next_state),
 		__entry->final_state ? " (final)" : "")
 );
 
@@ -43,18 +43,18 @@ DECLARE_EVENT_CLASS(error_da_monitor,
 	TP_ARGS(state, event),
 
 	TP_STRUCT__entry(
-		__array(	char,	state,		MAX_DA_NAME_LEN	)
-		__array(	char,	event,		MAX_DA_NAME_LEN	)
+		__string(	state,	state	)
+		__string(	event,	event	)
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->state,		state,		MAX_DA_NAME_LEN);
-		memcpy(__entry->event,		event,		MAX_DA_NAME_LEN);
+		__assign_str(state);
+		__assign_str(event);
 	),
 
 	TP_printk("event %s not expected in the state %s",
-		__entry->event,
-		__entry->state)
+		__get_str(event),
+		__get_str(state))
 );
 
 #include <monitors/wip/wip_trace.h>
@@ -75,26 +75,26 @@ DECLARE_EVENT_CLASS(event_da_monitor_id,
 	TP_ARGS(id, state, event, next_state, final_state),
 
 	TP_STRUCT__entry(
-		__field(	int,	id				)
-		__array(	char,	state,		MAX_DA_NAME_LEN	)
-		__array(	char,	event,		MAX_DA_NAME_LEN	)
-		__array(	char,	next_state,	MAX_DA_NAME_LEN	)
-		__field(	bool,	final_state			)
+		__field(	int,		id		)
+		__string(	state,		state		)
+		__string(	event,		event		)
+		__string(	next_state,	next_state	)
+		__field(	bool,		final_state	)
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->state,		state,		MAX_DA_NAME_LEN);
-		memcpy(__entry->event,		event,		MAX_DA_NAME_LEN);
-		memcpy(__entry->next_state,	next_state,	MAX_DA_NAME_LEN);
-		__entry->id			= id;
-		__entry->final_state		= final_state;
+		__assign_str(state);
+		__assign_str(event);
+		__assign_str(next_state);
+		__entry->id		= id;
+		__entry->final_state	= final_state;
 	),
 
 	TP_printk("%d: %s x %s -> %s%s",
 		__entry->id,
-		__entry->state,
-		__entry->event,
-		__entry->next_state,
+		__get_str(state),
+		__get_str(event),
+		__get_str(next_state),
 		__entry->final_state ? " (final)" : "")
 );
 
@@ -105,21 +105,21 @@ DECLARE_EVENT_CLASS(error_da_monitor_id,
 	TP_ARGS(id, state, event),
 
 	TP_STRUCT__entry(
-		__field(	int,	id				)
-		__array(	char,	state,		MAX_DA_NAME_LEN	)
-		__array(	char,	event,		MAX_DA_NAME_LEN	)
+		__field(	int,	id	)
+		__string(	state,	state	)
+		__string(	event,	event	)
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->state,		state,		MAX_DA_NAME_LEN);
-		memcpy(__entry->event,		event,		MAX_DA_NAME_LEN);
-		__entry->id			= id;
+		__assign_str(state);
+		__assign_str(event);
+		__entry->id	= id;
 	),
 
 	TP_printk("%d: event %s not expected in the state %s",
 		__entry->id,
-		__entry->event,
-		__entry->state)
+		__get_str(event),
+		__get_str(state))
 );
 
 #include <monitors/wwnr/wwnr_trace.h>
-- 
2.50.1

