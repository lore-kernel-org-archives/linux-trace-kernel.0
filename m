Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A1C36CDF2;
	Fri, 23 Jan 2026 01:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132316; cv=none; b=kCfwDPofh/aGmQ/+QzF2WHAk3ib4+qhjwbb6I2DkHND8NUqveuwcAn8GpSmikIcMwg5frqWIhvtMiUD/E6dnyy/OTUqOmxVCSzX+ZkFCtFtpAaFW3QhZc2/O7yUYgkxbESGNhmyQrn3OoI/kszsN1Qt9s09s2wx9twf88OhDVk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132316; c=relaxed/simple;
	bh=J1/hDHaZEK+VMrPeFc5/OdUOASGbsqSE6VgRHsbykTo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pP8L4vCrCXQ5rXp6A90lxuR4yACijb7gaAsNlDoBK1NWAL761i2zKC0sLnyE6MbtL+K/3daum59G4mPGZ9QxztbpC7kKaqD30WEx2j7DBOTdMWoHQAOHaYcdTuFdzuoa838AANn41i1nhTjszZu9KkRVFrahe3j2SR0MQAJpOJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 2258F945EB;
	Fri, 23 Jan 2026 01:37:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 7754C8000F;
	Fri, 23 Jan 2026 01:37:56 +0000 (UTC)
Date: Thu, 22 Jan 2026 20:38:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH] tracing: Have hist_debug show what function a field uses
Message-ID: <20260122203822.58df4d80@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7754C8000F
X-Stat-Signature: dy5ykk875dgma835tgnteuj7n3bcugc1
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+KjjWQbHLl4eeNTu6fXfJfJEdqO8plVGY=
X-HE-Tag: 1769132276-968188
X-HE-Meta: U2FsdGVkX18xmLUoq28rSwjx+CYfU8WlsS9+SUNk1pD1sdFsszfMkFzgANK9oac3eIWkuTRiVVN2gXtMzI1fT5NOCNdUwYlj2HzY+/dOF5QRQ1G0thijzujHmcOkk3ANhqd0771gggB23cr/fO1KlL5kGWrLLxzHdaQX7e0XlQxgW/gSrOFRMccZZ2KDvuQFvXX7Z9a0M423oG73MJHTU2kxIsUc5Yg5Ax6GEhZEmTbjyGq++Cn2GIE8vBvY9qr43+jqT5GiyUkxEpBPP9IO4FYCkVF+sUwb3WAtyGgiQksPN1sHUOR5dcDnonSy2zhl2lHOLF1Ugi6TN0gJpmULYyvfl3cBkcZo2NX2tV69Ylc/VBul4n4ADc3dGkaCH4fZ

From: Steven Rostedt <rostedt@goodmis.org>

When CONFIG_HIST_TRIGGERS_DEBUG is enabled, each trace event has a
"hist_debug" file that explains the histogram internal data. This is very
useful for debugging histograms.

One bit of data that was missing from this file was what function a
histogram field uses to process its data. The hist_field structure now has
a fn_num that is used by a switch statement in hist_fn_call() to call a
function directly (to avoid spectre mitigations).

Instead of displaying that number, create a string array that maps to the
histogram function enums so that the function for a field may be
displayed:

 ~# cat /sys/kernel/tracing/events/sched/sched_switch/hist_debug
[..]
hist_data: 0000000043d62762

  n_vals: 2
  n_keys: 1
  n_fields: 3

  val fields:

    hist_data->fields[0]:
      flags:
        VAL: HIST_FIELD_FL_HITCOUNT
      type: u64
      size: 8
      is_signed: 0
      function: hist_field_counter()

    hist_data->fields[1]:
      flags:
        HIST_FIELD_FL_VAR
      var.name: __arg_3921_2
      var.idx (into tracing_map_elt.vars[]): 0
      type: unsigned long[]
      size: 128
      is_signed: 0
      function: hist_field_nop()

  key fields:

    hist_data->fields[2]:
      flags:
        HIST_FIELD_FL_KEY
      ftrace_event_field name: prev_pid
      type: pid_t
      size: 8
      is_signed: 1
      function: hist_field_s32()

The "function:" field above is added.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 75 +++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 31 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 4a7f945e368d..24441b30a1a4 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -105,38 +105,44 @@ enum field_op_id {
 	FIELD_OP_MULT,
 };
 
+#define FIELD_FUNCS					\
+	C(NOP,			"nop"),			\
+	C(VAR_REF,		"var_ref"),		\
+	C(COUNTER,		"counter"),		\
+	C(CONST,		"const"),		\
+	C(LOG2,			"log2"),		\
+	C(BUCKET,		"bucket"),		\
+	C(TIMESTAMP,		"timestamp"),		\
+	C(CPU,			"cpu"),			\
+	C(COMM,			"comm"),		\
+	C(STRING,		"string"),		\
+	C(DYNSTRING,		"dynstring"),		\
+	C(RELDYNSTRING,		"reldynstring"),	\
+	C(PSTRING,		"pstring"),		\
+	C(S64,			"s64"),			\
+	C(U64,			"u64"),			\
+	C(S32,			"s32"),			\
+	C(U32,			"u32"),			\
+	C(S16,			"s16"),			\
+	C(U16,			"u16"),			\
+	C(S8,			"s8"),			\
+	C(U8,			"u8"),			\
+	C(UMINUS,		"uminus"),		\
+	C(MINUS,		"minus"),		\
+	C(PLUS,			"plus"),		\
+	C(DIV,			"div"),			\
+	C(MULT,			"mult"),		\
+	C(DIV_POWER2,		"div_power2"),		\
+	C(DIV_NOT_POWER2,	"div_not_power2"),	\
+	C(DIV_MULT_SHIFT,	"div_mult_shift"),	\
+	C(EXECNAME,		"execname"),		\
+	C(STACK,		"stack"),
+
+#undef C
+#define C(a, b)		HIST_FIELD_FN_##a
+
 enum hist_field_fn {
-	HIST_FIELD_FN_NOP,
-	HIST_FIELD_FN_VAR_REF,
-	HIST_FIELD_FN_COUNTER,
-	HIST_FIELD_FN_CONST,
-	HIST_FIELD_FN_LOG2,
-	HIST_FIELD_FN_BUCKET,
-	HIST_FIELD_FN_TIMESTAMP,
-	HIST_FIELD_FN_CPU,
-	HIST_FIELD_FN_COMM,
-	HIST_FIELD_FN_STRING,
-	HIST_FIELD_FN_DYNSTRING,
-	HIST_FIELD_FN_RELDYNSTRING,
-	HIST_FIELD_FN_PSTRING,
-	HIST_FIELD_FN_S64,
-	HIST_FIELD_FN_U64,
-	HIST_FIELD_FN_S32,
-	HIST_FIELD_FN_U32,
-	HIST_FIELD_FN_S16,
-	HIST_FIELD_FN_U16,
-	HIST_FIELD_FN_S8,
-	HIST_FIELD_FN_U8,
-	HIST_FIELD_FN_UMINUS,
-	HIST_FIELD_FN_MINUS,
-	HIST_FIELD_FN_PLUS,
-	HIST_FIELD_FN_DIV,
-	HIST_FIELD_FN_MULT,
-	HIST_FIELD_FN_DIV_POWER2,
-	HIST_FIELD_FN_DIV_NOT_POWER2,
-	HIST_FIELD_FN_DIV_MULT_SHIFT,
-	HIST_FIELD_FN_EXECNAME,
-	HIST_FIELD_FN_STACK,
+	FIELD_FUNCS
 };
 
 /*
@@ -5845,6 +5851,12 @@ const struct file_operations event_hist_fops = {
 };
 
 #ifdef CONFIG_HIST_TRIGGERS_DEBUG
+
+#undef C
+#define C(a, b)		b
+
+static const char * const field_funcs[] = { FIELD_FUNCS };
+
 static void hist_field_debug_show_flags(struct seq_file *m,
 					unsigned long flags)
 {
@@ -5909,6 +5921,7 @@ static int hist_field_debug_show(struct seq_file *m,
 	seq_printf(m, "      type: %s\n", field->type);
 	seq_printf(m, "      size: %u\n", field->size);
 	seq_printf(m, "      is_signed: %u\n", field->is_signed);
+	seq_printf(m, "      function: hist_field_%s()\n", field_funcs[field->fn_num]);
 
 	return 0;
 }
-- 
2.51.0

