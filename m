Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795487577;
	b=UCiyr2JP5Eg5IH3eh7E4nCZJqUtmV/TXXjmiTWyjhYsp8WtD+2y+ULytijm4Xl+fRMfl
	 /NJYzmq66ScHrnnq9m0b3CZU2mi+sgvAGWelCBt1fQsf+O6PqW3PU+Kj/WFUn4YymcqsB
	 EH8Lno3xfcU+AgjKTvA9cgkrSE6geg5LHtlU+xNles7/iAL008zBoKzZ3EMV4dyMdz0j/
	 C47ofOy1Vsp2WLZNnx/5Y2udm661WrH8/31X/8/Rr5nL+mE6fBBWEq58C41v3C4N6tU0N
	 Obr4v65nGL+n8va+gZlr5Nug6m/sHOhcBIBaDK3R1De38OqPyc6jZidWFScvjeuZThg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795487577;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id:X-Stat-Signature:X-Spam-Status:X-Rspamd-Server:
	 X-Session-Marker:X-Session-ID:DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=LYw5dB/kREf5FV+MEWHuvwi1aZyoz5YEQ3sJCgGLW58=;
	b=q/PSuWKuBUXh2xHwy6TZm1wcCQxMtX+g09cK6+V4XmJUxyaCPuCFMjYWrxyDOPVt8v+C
	 U8rnuMWRDA7x0lb+Hx0R/zbJ6xYHOBi7GNxuJ9BHNDbJeilCoUyFt96dFS0bOoqcFJ+xt
	 3i4ZjReUf2Qcou07238W1G8bv/meXtXnUVnhZ0k0FhwAPgkYIJCM0hqnc3zHYU8TURljo
	 ix3OVnTvVmoH+JPdUyM0yssaD5ajHcTD1Ha/RB6Y1jty05er3idPg2ppdsh6k+LlHPyOg
	 fOH5ioEXN/r5YrMm2r5eyjxRbmYQDmyDz62bAUetOk73d19IFrEkd4tBo8T74wutIsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=1eQV8KQd;
	arc=none smtp.remote-ip=216.40.44.14
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623F2606A31E;
	Tue, 24 Nov 2026 02:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 623F2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=1eQV8KQd
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 8F0731409F2;
	Tue, 24 Nov 2026 02:32:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id F1B176000F;
	Tue, 24 Nov 2026 02:32:47 +0000 (UTC)
Date: Mon, 23 Nov 2026 21:32:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH v7] tracing/probes: Zero out faulted dereferenced fields
Message-ID: <20261123213246.00440bfc@gandalf.local.home>
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
X-Rspamd-Queue-Id: F1B176000F
X-Stat-Signature: 9r45zioifipcm9kk857sbbojg66kuuq8
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18hj0naVw6/xHxtvdB42V4cNkH8U8m1NXw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=LYw5dB/kREf5FV+MEWHuvwi1aZyoz5YEQ3sJCgGLW58=; b=1eQV8KQdsc27tLdGI48CXTYzYjOcnzsOgzNrWyQHlp34QpMKFNs3XyKeqfx1yL63RMJtV0bWjfRTNT5I7gbmLQ2VYxSNqYGv1mnnbLPCzZRSSCbqY3kCkL2Ucu5E4b9ZWWn1+Ei5GCrit3ZBlsGczP8XLERb/c9PpgRu4A2Ns50=
X-HE-Tag: 1795487567-803411
X-HE-Meta: U2FsdGVkX19BPvbydimWVarY/tGCsLPGR4cGLHcRYA21c5NDQ0gfcFZ3R6KKlIZNuo68gt/Qx2HJmVkVz6Oh/4w60hCtFgyeuJ/dA0EL+xxEgJuF3VsPYxNtjoSDXxrOQZaR3YgyXszEoJQRC9zPIUyRmnVQfbhSjG116r41RvCf6RNgdbzA/6UmLnajgypoefsmPE+MYwkjoMPXtVSKPuim6w1JLLT7OWQ3YrDT67iyhzZhPpIvRDE9NIGHQOa3Ns5yL6bc578tjPi/bTVkfGAF5Jpd0aUcQJF3Zi/tYyYvK6musXqDpzN/MypGp2mx6Fn/W26R5X5pXZrmOqFQvCHEb4Y4bXUrYjhF3JN5M6TgUq4qFrlHXKkteIvedpAOWVig5EK50wi1HzUH1ePoVv499SWPYNCfwysh1CSJsQlYMg8CUkn6T/MFSZmZzJTI6vPk+V5Ep42DBWo5SQNhwa5uGsZ7luXZuXL8grYuHNI=

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
v6 was supposed to be this patch but a broken version was sent out by mistake.

Changes since v5: https://patch.msgid.link/20261120152432.0dc2bdf0@gandalf.local.home

- Handle fetch_store_string*() when val is NULL (Sashiko)

 kernel/trace/trace_probe_tmpl.h | 110 ++++++++++++++++++++++++++------
 1 file changed, 89 insertions(+), 21 deletions(-)

diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 8acc0f0ebd7a..9672474b067b 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -90,13 +90,15 @@ fetch_store_symstring(unsigned long addr, void *dest, void *base)
 	char namebuf[KSYM_SYMBOL_LEN];
 	int maxlen = get_loc_len(*(u32 *)dest);
 	void *__dest;
-	int len;
+	int len = -1;
 
 	if (unlikely(!maxlen))
 		return -ENOMEM;
 
 	__dest = get_loc_data(dest, base);
-	len = sprint_symbol(namebuf, addr);
+	/* Do not dereference NULL pointers */
+	if (addr)
+		len = sprint_symbol(namebuf, addr);
 	if (len < 0) {
 		*(u32 *)dest = make_data_loc(0, __dest - base);
 		return 0;
@@ -133,13 +135,63 @@ process_common_fetch_insn(struct fetch_insn *code, unsigned long *val)
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
+		void *__dest = get_loc_data(dest, base);
+
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
+		void *__dest = get_loc_data(dest, base);
+
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
 
@@ -147,25 +199,30 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
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
@@ -173,19 +230,25 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 
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
@@ -193,27 +256,30 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
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
@@ -237,11 +303,13 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
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

