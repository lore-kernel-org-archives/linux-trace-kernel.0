Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67AE37FF42;
	Wed,  1 Jul 2026 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782926870; cv=none; b=ANvu+335OgnDtCs0n+gfHsSY1TcTogLLWfRtEKWSx/aykG2ikOprEWBBIPN33L2sJoHU2VVlcB2lJ71ppZXQUb4xPJx+EOlcuacsIlnWuv2WiRBfso4rkqCBFo5FrgFBs73uYR9jxyEXucXvQ+AjKDBqDMA/n3vs+zghzjG+l1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782926870; c=relaxed/simple;
	bh=HzPfLDKaloqjQ1kYY2FnGN6M35Fm9ZgCdlyXKPrF4QE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fRdgnhwZnzaMeVn7Re0tObpyXRYs+J1mKqDUUD6iJFz4TvVYGEf6m7mzLgOYAqvB8wHhphWbRNR+2vkuDss//w8BVj4FJqM8KyxpsidXn3Ja5PslYsZZ8cJz1xVMoXpxWiDY6rASJm6GCRSIDxCLTzzzEBScoznWPKB3T2mGdn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 5A0D01402FB;
	Wed,  1 Jul 2026 17:27:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 7322120033;
	Wed,  1 Jul 2026 17:27:45 +0000 (UTC)
Date: Wed, 1 Jul 2026 13:27:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, David Carlier <devnexen@gmail.com>
Subject: [PATCH] tracing: Add a no-rcu-check version of
 trace_##event##_enabled()
Message-ID: <20260701132744.6a7fc68b@robin>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: dt8h11bqgjuhm3gmb5xw913ci5oygcup
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 7322120033
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18M72ey8fVWRJAiCbq67QspPl8DgGXezHA=
X-HE-Tag: 1782926865-891507
X-HE-Meta: U2FsdGVkX1+ixkgZjxMYV6R9/RsGtiNTEuZWi1UExSxfs6Ou08YpWY37dc/X7unmUwPhIuHpXJDvFWw12LYFV1qVCMFC8fPvPp970ir4fsKcgTw3BLsPkTkNMDWiLYreeQkt7BPyafc6Yy1oDRiGW9DL88uAjxpzkATq4Mb54/DOPGQykOslm6w76qK5G2TxbaopYE/nSAD+6ajyinMyQwWmJAm7Eu5bK5+rs5x2cIYCDV/sN+DaedDdh1AGxsTw+dHu7E3UF8PV21RTMD4JJ2dq0FYtfBOd76TTN9O3NM7nB6vOK2V0j+aCPAvtMI1GYf02IWwtx6snsMeDm/ZnJOyrdGrLiaPS+By3oAtfRVPu6pDuC/HZhHt5DYy7JoQ5VcVV7GW2LU5mjjJ1W3Z4TBJyrn87htscuHoUtTxFVNvB4DhNTgwknYhcdxmBb13+4pMsTEAHTzQiKyxe7moJ7c0REbxhxGq0Xy23cS/P1XA=

From: Steven Rostedt <rostedt@goodmis.org>

Tracepoints require that RCU is watching. To prevent them from being used
in places that RCU is not watching, the trace_##event() macro always
calls rcu_is_watching() even when the event is not enabled and warns if
RCU is not watching. This is to make sure a warning is triggered even if
the tracepoint is never enabled (as it is only a bug when it is).

It was noticed that tracepoints could be hidden within
trace_#event#_enabled() calls, which are used to do extra work for the
tracepoint only if the tracepoint is enabled. But this also can hide the
fact that a tracepoint is placed in a location that can be called when RCU
is not watching.

Commit 9764e731ef6ab ("tracepoint: Add lockdep rcu_is_watching() check to
trace_##name##_enabled()") added a check to the trace_##event##_enabled()
macro to make sure RCU is watching when it is called to make sure not to
hide the bug of a tracepoint being called when RCU is not watching.

There is one case in the irq_disable tracepoint where it is within a
trace_irq_disable_enabled() block, but it checks if RCU is watching, and
if it isn't, it makes a call to ct_irq_enter() that makes RCU watch again.
But because trace_irq_disable_enabled() now checks if RCU is watching and
will trigger if it isn't. This is a false warning as the code within
the block handles this case.

Add a new internal macro __trace_##event##_enabled() that doesn't check if
RCU is watching, and convert the irq_enable/disable tracepoints over to
it.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/all/CAMuHMdXud_RpWag_hFqa2ByBGRxg6KnxGL1ObCWZrpTsk3TfAw@mail.gmail.com/
Fixes: 9764e731ef6ab ("tracepoint: Add lockdep rcu_is_watching() check to trace_##name##_enabled()")
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/tracepoint.h      | 12 +++++++++++-
 kernel/trace/trace_preemptirq.c |  2 +-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 4a0c36f40fe2..e0d838c9ce93 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -292,13 +292,18 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	{								\
 	}								\
 	static inline bool						\
+	__trace_##name##_enabled(void)					\
+	{								\
+		return static_branch_unlikely(&__tracepoint_##name.key);\
+	}								\
+	static inline bool						\
 	trace_##name##_enabled(void)					\
 	{								\
 		if (IS_ENABLED(CONFIG_LOCKDEP)) {			\
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\
 		}							\
-		return static_branch_unlikely(&__tracepoint_##name.key);\
+		return __trace_##name##_enabled();			\
 	}
 
 #define __DECLARE_TRACE(name, proto, args, cond, data_proto)			\
@@ -457,6 +462,11 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	{								\
 	}								\
 	static inline bool						\
+	__trace_##name##_enabled(void)					\
+	{								\
+		return false;						\
+	}								\
+	static inline bool						\
 	trace_##name##_enabled(void)					\
 	{								\
 		return false;						\
diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index 0c42b15c3800..b63e3558948f 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -30,7 +30,7 @@
 #else
 #define trace(point, args)					\
 	do {							\
-		if (trace_##point##_enabled()) {		\
+		if (__trace_##point##_enabled()) {		\
 			bool exit_rcu = false;			\
 			if (in_nmi())				\
 				break;				\
-- 
2.53.0

