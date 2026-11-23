Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795469437;
	b=CMSFFZBqRzc1lCBcv13m5dTTsR75jmjTBay0IhCv7Hq2ZLZxZemYnwK4O2qoAb1c8ucW
	 wINFs12vi8/jhn0D1V3DAGrhBjbaN6axpXsNZoQWPAkx0SSuTZHeyd/oFu76JrWqbQBBM
	 NVxAVVNGFMez54sm9RL/KF8xvJTl/PQcPM10lS69BHjUwv8J129WMxOgdbpb94yvGGKbN
	 Hh9ZkYHiXMPMrbksHWUC+XhAbBDV2dp7u2ycEatKH1PvRt7+pRI59NYtN4BkQHIRvlhcl
	 tf6DdCksaClMCl/HvisXeUmnw0WXorfKYFd8dgY9lSofcZlNydYviEWvHsVf+kGTyLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795469437;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Stat-Signature:X-Spam-Status:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Session-Marker:X-Session-ID:DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=GIrhH1OZ9MJiCq6ByD8kCbZD75ZiEpxNCzwWoUWugNY=;
	b=up18NUbi37jg4Dl4Bg2WeGYd5fQ6PQ79PUgEHNkCA+4rbh9zN1/mC2bjUdT3neVtYZt4
	 EuXQHOAZPvTGjYbgNbxUCwMMBf6y3q0fHCryOCaDmPHeg8s64tIo+yU3H1EJnofFNDgcG
	 cTELFbKiByupkAGTTQn14ejplWa81jwRFJF+EQv/a+ouwagX6jpLCjsy0D3xrQJtMVRpK
	 ildf94ZW429SFsMD+cnNlqCHNpdOiLUNxU8Xun1LdjXFH2jX1YYCzz79zCom91WU3oVUO
	 B5EmqOZPE7n0flbND8ZW7B0IGXtos12dEncGepoAB40AIBv1ULxVJhDJLhn6QHQsrOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=QUyENsVG;
	arc=none smtp.remote-ip=216.40.44.13
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01D4606A321;
	Mon, 23 Nov 2026 21:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D01D4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=QUyENsVG
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 0BCC340A22;
	Mon, 23 Nov 2026 21:30:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 3C36E2000F;
	Mon, 23 Nov 2026 21:30:28 +0000 (UTC)
Date: Mon, 23 Nov 2026 16:30:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH v6] tracing/probes: Zero out faulted dereferenced fields
Message-ID: <20261123163027.4d101385@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: dpjicisamknfqy88fz1d7ek5ac7c6cwf
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 3C36E2000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18aOsfcsIgPdIZ/mYmd2JTTvygceHr63+Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=GIrhH1OZ9MJiCq6ByD8kCbZD75ZiEpxNCzwWoUWugNY=; b=QUyENsVGcRJLBcCPNhHB3wvJMNxP4jvuWwjJlPXYC1s0b0g/NkSOAnLSASbEbLvj5dabUVt8FRuU2nr1v2SL21ogHygmHH3BsdYImtgGhW1ley6aq7NznKONzm8EK6nCv8eqhU0SXN15dXfLFn7ttXTZg6pRsyPcnjuYrW8U0Qw=
X-HE-Tag: 1795469428-180139
X-HE-Meta: U2FsdGVkX1+seYfBGGbHGjY3D5c3lFnj2PZJ0vmKhJHCtEjgmdkk5EI3lDV7ON/kTvgGR09Fuh34BTNOsa+TlLBVu/cH6yVeKVJ2LfdwkeVTOWThk7i+SN3Lrod0/c3rNDU6tG5Wyxcl/EaE50TRGZVW6dXBk8XSDN7iiY3TNwnXn3gJR+wwYpj26WS+vTWOQ3uxUh8ZhvbzgzVFZv68v/JBPy3UWJACR9JKdRmWmZVgcwir4nvSkD/0nr90qGEwpU4acZtyYgxybYNqhrNI9e0IUbCk1A0AnAPLpuyRWfc/jAgIbWodf6C3NT2aFMANeHqi/SvNEyE9pFuPwrNEqz7q1SDB6jPhal6cA6W3QT2bvFu+rQc7We3Do7NVhF4/wrvzGHQKkdJBgqodfU1WlQGNykoJs+cF62AIdqs4VgSDr4ge71iT6y+qF64VAUmO0ugPqpDqUGXxlwFC1pTB6EOt69CJl1rVDzlkNZFrqyA=

From: Steven Rostedt <rostedt@goodmis.org>

While looking at tasks global descriptor tables, I discovered the
following anomaly:

~# echo 't:sched sched_switch prev=prev mm=(task_struct)prev->mm ppgd=(task_struct)prev->mm->pgd' > /sys/kernel/tracing/dynamic_events

The above creates a tprobe on the sched_switch tracepoint and records the
previous task_struct pointer, it's mm_struct and the pgd the mm_struct
points to.

~# trace-cmd start -e tracepoints:sched

            bash-1050    [000] d..3.    90.829478: sched: (__probestub_sched_switch+0x0/0x10) prev=0xffff88d30b623600 mm=0xffff88d30108c600 ppgd=0xffff88d33352b000
          <idle>-0       [002] d..3.    90.836024: sched: (__probestub_sched_switch+0x0/0x10) prev=0xffff88d301870000 mm=0x0 ppgd=0x0
     rcu_preempt-15      [002] d..3.    90.836031: sched: (__probestub_sched_switch+0x0/0x10) prev=0xffff88d3013ad100 mm=0x0 ppgd=0xffff88d33352b000

The first event has is a user task that has both a valid mm_struct and a pgd.
The second event is a kernel task where the mm_struct is NULL and so is the
dereferenced pgd pointer.

The third event is where things looked strange. The mm_struct is NULL but
the dereferenced pgd has a value! That is: NULL->pgd produced something
other than zero.

The reason for this is that the probe_mem_read() and probe_mem_read_user()
do not write to the destination on failure. The process_fetch_insn_bottom()
loop does not check the return value of the dereference (as it is the last
one), and does not update the event. That leaves the value for that failed
field to be whatever was in the ring buffer at that time.

Have both probe_mem_read() and probe_mem_read_user() set the destination to
zero on failure to read the address.

Now all pgd are zero when mm is zero.

Also update the stage 2 of process_fetch_insn_bottom() to not return on
fault but to just set the value to zero and also do not even bother
dereferencing the address if the value is already zero. This allows the
code to continue and fill in the zero into the memory location on the
ring buffer.

Cc: stable@vger.kernel.org
Fixes: 533059281ee59 ("tracing: probeevent: Introduce new argument fetching code")
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
Changes since v5: https://patch.msgid.link/20261120152432.0dc2bdf0@gandalf.local.home

- Handle fetch_store_string*() when val is NULL (Sashiko)

 kernel/trace/trace_probe_tmpl.h | 100 ++++++++++++++++++++++++++------
 1 file changed, 81 insertions(+), 19 deletions(-)

diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 8acc0f0ebd7a..53fd7f654377 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -133,13 +133,59 @@ process_common_fetch_insn(struct fetch_insn *code, unsigned long *val)
 	return 0;
 }
 
+/* On failure, zero out the destination */
+static nokprobe_inline int
+do_probe_mem_read_user(void *dest, void *src, size_t size)
+{
+	int ret;
+
+	ret = probe_mem_read_user(dest, src, size);
+	if (ret < 0)
+		memset(dest, 0, size);
+	return ret;
+}
+
+/* On failure, zero out the destination */
+static nokprobe_inline int
+do_probe_mem_read(void *dest, void *src, size_t size)
+{
+	int ret;
+
+	ret = probe_mem_read(dest, src, size);
+	if (ret < 0)
+		memset(dest, 0, size);
+	return ret;
+}
+
+static nokprobe_inline int
+do_fetch_store_string(unsigned long addr, void *dest, void *base)
+{
+	/* NULL addr gets zero size string */
+	if (!addr) {
+		*(u32 *)dest = make_data_loc(0, __dest - base);
+		return 0;
+	}
+	return fetch_store_string(addr, dest, base);
+}
+
+static nokprobe_inline int
+do_fetch_store_string_user(unsigned long addr, void *dest, void *base)
+{
+	/* NULL addr gets zero size string */
+	if (!addr) {
+		*(u32 *)dest = make_data_loc(0, __dest - base);
+		return 0;
+	}
+	return fetch_store_string_user(addr, dest, base);
+}
+
 /* From the 2nd stage, routine is same */
 static nokprobe_inline int
 process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 			   void *dest, void *base)
 {
 	struct fetch_insn *s3 = NULL;
-	int total = 0, ret = 0, i = 0;
+	int total = 0, ret = 0, i = 0, offset;
 	u32 loc = 0;
 	unsigned long lval, llval = val;
 
@@ -147,25 +193,30 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 	/* 2nd stage: dereference memory if needed */
 	do {
 		lval = val;
+		/* Prevent dereferencing NULL val pointer */
+		offset = val ? code->offset : 0;
 		switch (code->op) {
 		case FETCH_OP_DEREF:
-			ret = probe_mem_read(&val, (void *)val + code->offset,
-					     sizeof(val));
+			/* Do not dereference NULL pointers */
+			if (val)
+				do_probe_mem_read(&val, (void *)val + offset,
+						  sizeof(val));
 			break;
 		case FETCH_OP_UDEREF:
-			ret = probe_mem_read_user(&val,
-				 (void *)val + code->offset, sizeof(val));
+			/* Do not dereference NULL pointers */
+			if (val)
+				do_probe_mem_read_user(&val, (void *)val + offset,
+						       sizeof(val));
 			break;
 		case FETCH_OP_CPU_PTR:
-			val = (unsigned long)this_cpu_ptr((void __percpu *)val);
-			ret = 0;
+			/* Do not dereference NULL pointers */
+			if (val)
+				val = (unsigned long)this_cpu_ptr((void __percpu *)val);
 			break;
 		default:
 			lval = llval;
 			goto out;
 		}
-		if (ret)
-			return ret;
 		llval = lval;
 		code++;
 	} while (1);
@@ -173,19 +224,25 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 
 	s3 = code;
 stage3:
+	/*
+	 * Once val is zero, it is pointing to NULL. Any new dereference is
+	 * also treated as a NULL pointer.
+	 */
+	offset = val ? code->offset : 0;
+
 	/* 3rd stage: store value to buffer */
 	if (unlikely(!dest)) {
 		switch (code->op) {
 		case FETCH_OP_ST_STRING:
-			ret = fetch_store_strlen(val + code->offset);
+			ret = val ? fetch_store_strlen(val + offset) : 0;
 			code++;
 			goto array;
 		case FETCH_OP_ST_USTRING:
-			ret = fetch_store_strlen_user(val + code->offset);
+			ret = val ? fetch_store_strlen_user(val + offset) : 0;
 			code++;
 			goto array;
 		case FETCH_OP_ST_SYMSTR:
-			ret = fetch_store_symstrlen(val + code->offset);
+			ret = val ? fetch_store_symstrlen(val + offset) : 0;
 			code++;
 			goto array;
 		default:
@@ -193,27 +250,30 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 		}
 	}
 
+	/* When val is NULL, so should the val + offset */
+	offset = val ? code->offset : 0;
+
 	switch (code->op) {
 	case FETCH_OP_ST_RAW:
 		fetch_store_raw(val, code, dest);
 		break;
 	case FETCH_OP_ST_MEM:
-		probe_mem_read(dest, (void *)val + code->offset, code->size);
+		do_probe_mem_read(dest, (void *)val + offset, code->size);
 		break;
 	case FETCH_OP_ST_UMEM:
-		probe_mem_read_user(dest, (void *)val + code->offset, code->size);
+		do_probe_mem_read_user(dest, (void *)val + offset, code->size);
 		break;
 	case FETCH_OP_ST_STRING:
 		loc = *(u32 *)dest;
-		ret = fetch_store_string(val + code->offset, dest, base);
+		ret = do_fetch_store_string(val + offset, dest, base);
 		break;
 	case FETCH_OP_ST_USTRING:
 		loc = *(u32 *)dest;
-		ret = fetch_store_string_user(val + code->offset, dest, base);
+		ret = do_fetch_store_string_user(val + offset, dest, base);
 		break;
 	case FETCH_OP_ST_SYMSTR:
 		loc = *(u32 *)dest;
-		ret = fetch_store_symstring(val + code->offset, dest, base);
+		ret = fetch_store_symstring(val + offset, dest, base);
 		break;
 	default:
 		return -EILSEQ;
@@ -237,11 +297,13 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 			if (s3->op != FETCH_OP_ST_STRING &&
 			    s3->op != FETCH_OP_ST_USTRING) {
 				dest += s3->size;
-				val += s3->size;
+				/* Only update a non NULL val */
+				if (val)
+					val += s3->size;
 				goto stage3;
 			}
 			code--;
-			val = lval + sizeof(char *);
+			val = lval ? lval + sizeof(char *) : 0;
 			if (dest) {
 				dest += sizeof(u32);
 				*(u32 *)dest = update_data_loc(loc, ret);
-- 
2.53.0

