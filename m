Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665358;
	b=UOX5Thz5FbcdfGOMMvB5rli5jEVDDNhVYz/wcUqniy5w+lNHN9CEWr/MbFS41VuAPao9
	 fc59Q46Z4EmnYk3bHLNr5F1YmfD+Zortjwmt6Dd27LJM6MJpst0ze4opskNeRrAmg/KTM
	 gz7/+hioIWtdIXNhIm8jsm3V+Fv5op1NbpNb/jr+mwcnAlp2O0zCSL6UvrOtK/3NuRjaI
	 NCmUOW9sKYQ6CsO+3na+8SLX3EuzaLRyDlyuJ2AQgkYXtyGQsoq0Xa1OlhnjlTClZGk6w
	 kyCtE2DaxsvxrAPTd9bCTJQICxYxeuTKwDU1v8flPBPSaWI0sHSUW33sGDDRdKD5l7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Qd7HphUqkcKhdfCjaFBu+tr1XuoKQm99xEDeO/POT9w=;
	b=J58BqAikzU8TbVSlsjVamnNNmM1dyRRf2j0qSL7St4n1J/vQpE58w/i3fbPfr6ZhZN2I
	 ZQB/qfkPcNYVYF++r++FQCoDoQb/zdxodl2kb+khZipW2lQhYN8nt+N9ZAQMNTwwNvt9F
	 HU7GUFbQw9gGaI8gwUbBZPzlgpz5RxTPq0seAEXUZzyst65QScTc4UkkNO5NOn+ns1DYR
	 EqSD4sh5n9JyhSxrFM+sKIjTn9r0IPobGxxfCEre/2ZPmVD7F2IV/NR2uWLVgv9iYKZ0f
	 s1nC2zpa5YOK671TBC+wrnAPfH0flxWBHQKBP18Ld4kQiWf1/cnpJdifPUMemP/0msg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lley6koS;
	arc=none smtp.remote-ip=209.85.221.72
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8152B606A31C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 03:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8152B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lley6koS
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48c6a1d4034so3796496f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 19:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795665356; x=1796270156; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qd7HphUqkcKhdfCjaFBu+tr1XuoKQm99xEDeO/POT9w=;
        b=lley6koSJpX9qpFlviYTW72vXsqWihzKk2HgPSi7o3MVjPgAsJK7bdY1zkME88/0dy
         92Anwo6bMrtCXA0gJ+k7AOugE1aycl/NHaE8W2N8puTqMZAMxsEbydy+4gv8yMovWC/+
         Dl7Php4f3FL/LtIZiuz3kOWGoT4scmo5o6M3FgbjnjJfnFQBmKOtH/vory8q3jfNWC8Y
         V2WHdbAm+EdcA0lgPTPyEdceGmlUKxMXYdzr9qQDDcS1lQlFbt+7KsKki4j1/3EJlhWZ
         WENNUL8YxCF1SAs9kt87SvHhYtoDSAvbtI4y1/+jX9iVVFqoJuHLHxCUU3FCvZZrYpYX
         ucWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795665356; x=1796270156;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qd7HphUqkcKhdfCjaFBu+tr1XuoKQm99xEDeO/POT9w=;
        b=SQ9QM2x9SwL+DZ2eR3sp2gsOyhzpxiELcShpB5GM+xExt2vKFQdgbQ26fXOV6s5YPs
         +EvAa4uF+gOgYQo9+k65coyaGKkoxxPdfVAOlFtDtd9UuB1q3zNVbp75dQKtnyn4bB+q
         sqYaMBKtbD3Cvhixf0MtbwGKE3bIwGPW6WAy5MGx4BAo2H/C+5aw0pp1b8SGByfT8i3Y
         b5bnAM5LuIHFQYC08C75zcKRtv4BYC8o7aZMR+Zd6tXAeoxkgjfKp9C4bhtB/KUDojZ6
         reZCV7UMH7gT4BKeMbDmiDiHVAYNwPOwwqlAeFoGAruALqurlcfzqkgmkQCpBFL/KtqB
         QwhA==
X-Forwarded-Encrypted: i=1; AL+hErF4GOA5r3+iWdykJAnFgCcbAtZxvETuxBtC7oK1M7yXAD7K45KoV0/dd32J7AHEkA6cti+zLPqeDYwm3lY0a97xcKs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YhnmH5jGkAFApPav9ZzQpr+sxRJCh/hSuiGamAFjB/A3BCFKj
	tFGeUwcevDFqysqLNCFBk2gg0lMuKXmIm1hGiEdSf6fkw+ttj+6rU6D3cySJZcQOOwNEC6aM2g=
	=
X-Received: from wrvd9.prod.google.com ([2002:a5d:5389:0:b0:4a7:85c3:7bf9])
 (user=dmnk job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:5e89:0:b0:4a7:5115:22c8
 with SMTP id ffacd0b85a97d-4ae3aa4548fmr27020181f8f.48.1795665355446; Wed, 25
 Nov 2026 19:55:55 -0800 (PST)
Date: Thu, 26 Nov 2026 04:55:53 +0100
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.911.g883d8bcb20-goog
Message-ID: <20261126035553.406453-1-dmnk@google.com>
Subject: [PATCH] tracing/synthetic: bound dynamic string and stack stores to
 reserved size
From: Dominik Maier <dmnk@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>, 
	Lee Jones <lee@kernel.org>, linux-trace-kernel@vger.kernel.org, dmnk+artist@google.com
Content-Type: text/plain; charset="UTF-8"

When recording a synthetic event, trace_event_raw_event_synth() and
perf_event_raw_event_synth() first call get_field_size() to measure
dynamic string and stacktrace fields, reserve a ring-buffer or
perf-buffer entry of that size, and then call write_synth_entry() to
copy the field values into the reserved entry.

However, the source buffers backing histogram variables in
elt_data->field_var_str[] are updated across CPUs without per-element
locking. If another CPU writes a longer string or deeper stacktrace into
the same histogram element between get_field_size() and
write_synth_entry(), the copy path overflows the reserved entry:

- trace_string() calls fetch_store_strlen() a second time and sets
  data->as_dynamic.len to the newly measured length, allowing
  fetch_store_string() to write past the reserved entry.
- trace_stack() re-scans stack[] up to HIST_STACKTRACE_DEPTH entries
  without checking the reserved size, allowing memcpy() to write past
  the reserved entry. Its loop bound also stops at HIST_STACKTRACE_DEPTH
  longs even though stack[0] holds the frame count, dropping the last
  frame when stack[0] == HIST_STACKTRACE_DEPTH.

When an entry sits near the end of a 4 KiB ring-buffer page, writing
past the reservation crosses into the next physical page (reported by
KASAN as use-after-free when that adjacent page is free, or corrupting
adjacent slab objects):

  BUG: KASAN: use-after-free in strncpy_from_kernel_nofault+0x1dd/0x250
  Write of size 1 at addr ffff888008c95000 by task repro_synth_toc/68
  Call Trace:
   strncpy_from_kernel_nofault+0x1dd/0x250
   trace_string+0x308/0x710
   trace_event_raw_event_synth+0x6c1/0xa70
   action_trace+0x134/0x220
   event_hist_trigger+0xe78/0x1330

Pass the remaining reserved dynamic byte budget (maxlen) into
trace_string() and trace_stack(), matching store_trace_args() in
trace_probe. In trace_string(), clamp data->as_dynamic.len to
min(maxlen, MAX_STRING_SIZE) and let fetch_store_string() copy and
record the stored length in a single pass. In trace_stack(), size and
bound the copy via synth_stack_size() and rounddown(maxlen,
sizeof(long)). Also plumb maxlen through synth_event_trace() and
synth_event_trace_array() after validating n_vals.

Fixes: bd82631d7ccd ("tracing: Add support for dynamic strings to synthetic events")
Fixes: 00cf3d672a9d ("tracing: Allow synthetic events to pass around stacktraces")
Cc: stable@vger.kernel.org
Signed-off-by: Dominik Maier <dmnk@google.com>
---
Note: Based on v7.4-rc4 (ebb7a8dc1e74) atop Lee Jones's "[RESEND]
tracing/synthetic: Handle dynamic string read faults"
(https://lore.kernel.org/all/20261109155758.3330810-1-lee@kernel.org/).

Found with an AI-assisted code review tool (ARTIST) and verified in
QEMU/KVM with KASAN, lockdep, and synth_event_gen_test against v7.4-rc4
(reproduces the out-of-bounds write from an unprivileged thread pair
before the fix, clean across string and stacktrace races after);
standalone reproducer available to maintainers on request.

 kernel/trace/trace_events_synth.c | 97 ++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 39 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 8492a5f..ccec678 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -426,11 +426,25 @@ static struct trace_event_functions synth_event_funcs = {
 	.trace		= print_synth_event
 };
 
+static __always_inline unsigned int synth_stack_size(const long *stack)
+{
+	unsigned long n_entries;
+
+	if (!stack)
+		return 0;
+
+	n_entries = min_t(unsigned long,
+			  READ_ONCE(*(const unsigned long *)stack),
+			  HIST_STACKTRACE_DEPTH);
+	return (n_entries + 1) * sizeof(unsigned long);
+}
+
 static unsigned int trace_string(struct synth_trace_event *entry,
 				 struct synth_event *event,
 				 char *str_val,
 				 bool is_dynamic,
 				 unsigned int data_size,
+				 unsigned int maxlen,
 				 unsigned int *n_u64)
 {
 	unsigned int len = 0;
@@ -442,14 +456,13 @@ static unsigned int trace_string(struct synth_trace_event *entry,
 
 		data->as_dynamic.offset = struct_size(entry, fields, event->n_u64) + data_size;
 
-		ret = fetch_store_strlen((unsigned long)str_val);
-		if (ret <= 0) {
+		if (!maxlen) {
 			data->as_dynamic.len = 0;
 			(*n_u64)++;
 			return 0;
 		}
 
-		data->as_dynamic.len = ret;
+		data->as_dynamic.len = min_t(unsigned int, maxlen, MAX_STRING_SIZE);
 
 		ret = fetch_store_string((unsigned long)str_val, &entry->fields[*n_u64], entry);
 		if (ret > 0)
@@ -479,6 +492,7 @@ static unsigned int trace_stack(struct synth_trace_event *entry,
 				 struct synth_event *event,
 				 long *stack,
 				 unsigned int data_size,
+				 unsigned int maxlen,
 				 unsigned int *n_u64)
 {
 	union trace_synth_field *data = &entry->fields[*n_u64];
@@ -489,16 +503,13 @@ static unsigned int trace_stack(struct synth_trace_event *entry,
 	data_offset = struct_size(entry, fields, event->n_u64);
 	data_offset += data_size;
 
-	for (len = 0; len < HIST_STACKTRACE_DEPTH; len++) {
-		if (!stack[len])
-			break;
-	}
-
-	len *= sizeof(long);
+	len = min_t(unsigned int, synth_stack_size(stack),
+		    rounddown(maxlen, sizeof(long)));
 
 	/* Find the dynamic section to copy the stack into. */
 	data_loc = (void *)entry + data_offset;
-	memcpy(data_loc, stack, len);
+	if (len)
+		memcpy(data_loc, stack, len);
 
 	/* Fill in the field that holds the offset/len combo */
 
@@ -529,8 +540,7 @@ static __always_inline int get_field_size(struct synth_event *event,
 
 		if (event->dynamic_fields[i]->is_stack) {
 			/* reserve one extra element for size */
-			len = *((unsigned long *)str_val) + 1;
-			len *= sizeof(unsigned long);
+			len = synth_stack_size((const long *)str_val);
 		} else {
 			len = fetch_store_strlen((unsigned long)str_val);
 			if (len <= 0)
@@ -545,12 +555,15 @@ static __always_inline int get_field_size(struct synth_event *event,
 static __always_inline void write_synth_entry(struct synth_event *event,
 					      struct synth_trace_event *entry,
 					      u64 *var_ref_vals,
-					      unsigned int *var_ref_idx)
+					      unsigned int *var_ref_idx,
+					      unsigned int fields_size)
 {
-	int data_size = 0;
+	unsigned int fixed_size = event->n_u64 * sizeof(u64);
+	unsigned int maxlen = fields_size > fixed_size ? fields_size - fixed_size : 0;
+	unsigned int data_size = 0;
+	unsigned int len;
 	int i, n_u64;
 	int val_idx;
-	int len;
 
 	for (i = 0, n_u64 = 0; i < event->n_fields; i++) {
 		val_idx = var_ref_idx[i];
@@ -559,14 +572,16 @@ static __always_inline void write_synth_entry(struct synth_event *event,
 
 			len = trace_string(entry, event, str_val,
 					   event->fields[i]->is_dynamic,
-					   data_size, &n_u64);
+					   data_size, maxlen, &n_u64);
 			data_size += len; /* only dynamic string increments */
+			maxlen -= len;
 		} else if (event->fields[i]->is_stack) {
 			long *stack = (long *)(long)var_ref_vals[val_idx];
 
 			len = trace_stack(entry, event, stack,
-					   data_size, &n_u64);
+					  data_size, maxlen, &n_u64);
 			data_size += len;
+			maxlen -= len;
 		} else {
 			struct synth_field *field = event->fields[i];
 			u64 val = var_ref_vals[val_idx];
@@ -623,7 +638,7 @@ static void trace_event_raw_event_synth(void *__data,
 	if (!entry)
 		return;
 
-	write_synth_entry(event, entry, var_ref_vals, var_ref_idx);
+	write_synth_entry(event, entry, var_ref_vals, var_ref_idx, fields_size);
 
 	trace_event_buffer_commit(&fbuffer);
 }
@@ -658,7 +673,7 @@ static void perf_event_raw_event_synth(void *__data,
 	if (unlikely(!entry))
 		return;
 
-	write_synth_entry(event, entry, var_ref_vals, var_ref_idx);
+	write_synth_entry(event, entry, var_ref_vals, var_ref_idx, fields_size);
 
 	perf_fetch_caller_regs(regs);
 
@@ -1833,7 +1848,7 @@ __synth_event_trace_end(struct synth_event_trace_state *trace_state)
  */
 int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
 {
-	unsigned int i, n_u64, len, data_size = 0;
+	unsigned int i, n_u64, len, maxlen, data_size = 0;
 	struct synth_event_trace_state state;
 	va_list args;
 	int ret;
@@ -1845,6 +1860,9 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
 		return ret;
 	}
 
+	if (n_vals != state.event->n_fields)
+		return -EINVAL;
+
 	if (state.event->n_dynamic_fields) {
 		va_start(args, n_vals);
 
@@ -1853,9 +1871,10 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
 
 			if (state.event->fields[i]->is_string &&
 			    state.event->fields[i]->is_dynamic) {
-				char *str_val = (char *)(long)val;
+				int slen = fetch_store_strlen((unsigned long)val);
 
-				data_size += strlen(str_val) + 1;
+				if (slen > 0)
+					data_size += slen;
 			}
 		}
 
@@ -1866,11 +1885,7 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
 	if (ret)
 		return ret;
 
-	if (n_vals != state.event->n_fields) {
-		ret = -EINVAL;
-		goto out;
-	}
-
+	maxlen = data_size;
 	data_size = 0;
 
 	va_start(args, n_vals);
@@ -1884,8 +1899,9 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
 
 			len = trace_string(state.entry, state.event, str_val,
 					   state.event->fields[i]->is_dynamic,
-					   data_size, &n_u64);
+					   data_size, maxlen, &n_u64);
 			data_size += len; /* only dynamic string increments */
+			maxlen -= len;
 		} else {
 			struct synth_field *field = state.event->fields[i];
 
@@ -1910,7 +1926,7 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
 		}
 	}
 	va_end(args);
-out:
+
 	__synth_event_trace_end(&state);
 
 	return ret;
@@ -1938,7 +1954,7 @@ EXPORT_SYMBOL_GPL(synth_event_trace);
 int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
 			    unsigned int n_vals)
 {
-	unsigned int i, n_u64, field_pos, len, data_size = 0;
+	unsigned int i, n_u64, field_pos, len, maxlen, data_size = 0;
 	struct synth_event_trace_state state;
 	char *str_val;
 	int ret;
@@ -1950,12 +1966,18 @@ int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
 		return ret;
 	}
 
+	if (n_vals != state.event->n_fields)
+		return -EINVAL;
+
 	if (state.event->n_dynamic_fields) {
 		for (i = 0; i < state.event->n_dynamic_fields; i++) {
+			int slen;
+
 			field_pos = state.event->dynamic_fields[i]->field_pos;
 			str_val = (char *)(long)vals[field_pos];
-			len = strlen(str_val) + 1;
-			data_size += len;
+			slen = fetch_store_strlen((unsigned long)str_val);
+			if (slen > 0)
+				data_size += slen;
 		}
 	}
 
@@ -1963,11 +1985,7 @@ int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
 	if (ret)
 		return ret;
 
-	if (n_vals != state.event->n_fields) {
-		ret = -EINVAL;
-		goto out;
-	}
-
+	maxlen = data_size;
 	data_size = 0;
 
 	for (i = 0, n_u64 = 0; i < state.event->n_fields; i++) {
@@ -1976,8 +1994,9 @@ int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
 
 			len = trace_string(state.entry, state.event, str_val,
 					   state.event->fields[i]->is_dynamic,
-					   data_size, &n_u64);
+					   data_size, maxlen, &n_u64);
 			data_size += len; /* only dynamic string increments */
+			maxlen -= len;
 		} else {
 			struct synth_field *field = state.event->fields[i];
 			u64 val = vals[i];
@@ -2002,7 +2021,7 @@ int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
 			n_u64++;
 		}
 	}
-out:
+
 	__synth_event_trace_end(&state);
 
 	return ret;

base-commit: ebb7a8dc1e74c705daffe11c2faf38ec2628f838
prerequisite-patch-id: 7dc33810eaa036b15c9945cc52ea7ac069534ffb
-- 
2.56.1.911.g883d8bcb20-goog

