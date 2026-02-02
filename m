Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B889537E2EA;
	Mon,  2 Feb 2026 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049809; cv=none; b=K5S1q1AB+BIyeRw/GyfhniQiVSEji2LAnNR7g8QNtVCf5nE5MqsWyKICIbseOtkTqoOOJL7B9ftvJj6NfsCMWEaAAOqWR03c6/+9kLFD5HbBtb/dSfPQYEFBmGRiL1I/sBcn8KyQk/M2HGYaTmcHsW5LG0NnEM+I+4Bo/QK5FDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049809; c=relaxed/simple;
	bh=hvmjrmCDqs2cbPx+cY0rUIOh3dOCMe3bW5Rw4e9Ck7k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=FLpzDbTZcaYxjgNbDhwuyIiDc6LzqPZ1GyIW3SEI+AdFFbpezE0F6ABUguC39JySXDl4dDog7z187J3V91ZGzPas+RWF1nL3rOwD5t7F9aKUqIJAs5FWAmJ8qlQ96orxngcUlzUyuHZ6vwM92kqeyYLRdAtMyEBPY4W8pL1bi2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id A402FD3515;
	Mon,  2 Feb 2026 16:30:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id E8BF320011;
	Mon,  2 Feb 2026 16:29:58 +0000 (UTC)
Date: Mon, 2 Feb 2026 11:30:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "jempty.liang" <imntjempty@163.com>
Subject: [PATCH] tracing: Fix ftrace event field alignments
Message-ID: <20260202113024.61d5c1fd@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: E8BF320011
X-Stat-Signature: owowchn5ps9g48khdok5c98uhonkxh7w
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19h3t/GMABdxK87oz5/Dg6gJmSvmck6coM=
X-HE-Tag: 1770049798-846485
X-HE-Meta: U2FsdGVkX1+O5O3ca51EIDmVRwKC4x5AdZ0FZTgdyltFZZwmO6DIuvs1OZh6EanUldzCTdqpaWMhEBj2upTSspuZF/8aSMr7eo/jZ/CJajIqW/++q2oYjksh4FdsnG3D94SoPdQn+iZOGFZ4sNRpwXARxCkJD8AFsvlojGnjm6BeDq8GCqltwgL73o1dWADsgyG8lKrDLI70JLOAkTUjqPRBRcFjVfBWFZ8T6jC3rTnm0oyulx0sw1lXNPVm8ETD9lTbeVi/27KEPeZU+cmvj3l/j4er4DfyYXybf/wKlmVvaS1h+VkhHtK+AyFKxg5c1sHPoYJd9tXHVpRen4vIlNdg+igO213yWYZAYg7a4lDSsMq/DRXKo5WERkU5NX5xy6MlpYHgFsIhgVkLdxtadkte97mLWHqwS4bUYM1rwAM=

From: Steven Rostedt <rostedt@goodmis.org>

The fields of ftrace specific events (events used to save ftrace internal
events like function traces and trace_printk) are generated similarly to
how normal trace event fields are generated. That is, the fields are added
to a trace_events_fields array that saves the name, offset, size,
alignment and signness of the field. It is used to produce the output in
the format file in tracefs so that tooling knows how to parse the binary
data of the trace events.

The issue is that the macro to determine the alignment of a field used the
alignment of the type when used normally, but not when it is used within a
structure.

This was fixed for normal trace event fields via: 4c3d2f9388d36 ("tracing:
Use a struct alignof to determine trace event field alignment"), but was
missed for the ftrace specific events.

Do the same for ftrace specific events by creating a helper macro:

 #define ALIGN_STRUCTFIELD(type) ((int)(__alignof__(struct {type b;})))

and use that as the alignment of types within the ftrace event structures.

Cc: stable@vger.kernel.org
Fixes: 04ae87a52074e ("ftrace: Rework event_create_dir()")
Reported-by: "jempty.liang" <imntjempty@163.com>
Closes: https://lore.kernel.org/all/20260130015740.212343-1-imntjempty@163.com/
Closes: https://lore.kernel.org/all/20260202123342.2544795-1-imntjempty@163.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_export.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_export.c b/kernel/trace/trace_export.c
index 1698fc22afa0..5b96ac750049 100644
--- a/kernel/trace/trace_export.c
+++ b/kernel/trace/trace_export.c
@@ -14,6 +14,9 @@
 
 #include "trace_output.h"
 
+/* The alignment of a type when in a structure */
+#define ALIGN_STRUCTFIELD(type) ((int)(__alignof__(struct {type b;})))
+
 /* Stub function for events with triggers */
 static int ftrace_event_register(struct trace_event_call *call,
 				 enum trace_reg type, void *data)
@@ -88,7 +91,7 @@ static void __always_unused ____ftrace_check_##name(void)		\
 #undef __field_ext
 #define __field_ext(_type, _item, _filter_type) {			\
 	.type = #_type, .name = #_item,					\
-	.size = sizeof(_type), .align = __alignof__(_type),		\
+	.size = sizeof(_type), .align = ALIGN_STRUCTFIELD(_type),	\
 	is_signed_type(_type), .filter_type = _filter_type },
 
 
-- 
2.51.0

