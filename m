Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530292;
	b=GnJWAYoSTi/RAqk2iahjJNmD6+ASr2l/d9EMcAUvOfca2oTRzZWVMOlmW2JXo9IG3MPY
	 8VPqDsLmcAEiim81v6p0yp7Qmpw5sqHoq4pVklVbHBnu4ZYqSwCodE5d+JD+WW+VQwLfL
	 Tkfac66OXNS623EK7aJqvNglqaewB1Lj0pmfUf8QVs7Qr+PNADqMUhZYjWlwc2TUYog5n
	 Tf5eFHdV3WhLx+mZ7ca/QqsC0mFNG+c/GkE5KDMATke78+3paRO+wQ05UWtD5EEtl3gbI
	 lClqYzcma45kFo13EtTmTnVxmT5B8Zijz3yM4Uj9niqwjeSSSlbaOjBrTwFSVKIk6AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530292;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Stat-Signature:X-Spam-Status:
	 X-Session-Marker:X-Session-ID:DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=1LOcVQNYAG/m8FwGOgpeskXItoFPNok4dIXg82mENYE=;
	b=zA3pEtrdS0xwHxPt0bp9pDZ3t+KX7Dn/Nclp+oYF3Yg2som9BSqBbS8sYnJxqHhS0vzz
	 U0WeVH7SPzS48FYIS9DYlniiYZCXsxxyrfWP2BU9m0ikF+oIOlnuH7ZDf6G+vO++27usY
	 mo4DGDhJUq+HWYFTW7qTbhMNxTNvKa+AiIEElgFG/T8q2ToD3gfxnX1fLmw0SKDiRuuxO
	 8/vxNpiCG5aOrbXlMcS0/5ZZS8asiXbf8aU2ew3r53GZhQZ4ysfPFQOI+J+hi+f8Sq8z3
	 3euzqdv8h1tQ/5l2DYSc7UhDM8xPwI+8IXkblI/0CNxujAspM7gi1aXIUxGo3ha4vHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=JuH+hMlD;
	arc=none smtp.remote-ip=216.40.44.16
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AE7606A331;
	Tue, 24 Nov 2026 14:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98AE7606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=JuH+hMlD
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 260B7C0BD5;
	Tue, 24 Nov 2026 14:24:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 83E1A2002E;
	Tue, 24 Nov 2026 14:24:48 +0000 (UTC)
Date: Tue, 24 Nov 2026 09:24:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH v8] tracing/probes: Zero out faulted dereferenced fields
Message-ID: <20261124092447.4dbf5233@gandalf.local.home>
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
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 83E1A2002E
X-Stat-Signature: pekdud8xugcwkn6j476t7m3t1o8aq51z
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX185e3D9loKvSDyp9pRDXXeEiP4mCEPXlfg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=1LOcVQNYAG/m8FwGOgpeskXItoFPNok4dIXg82mENYE=; b=JuH+hMlD48lb3di18Hee9FXnyxim0ufEryo542nNnl2hutQvH4Cu3Bgx45EjmG46/mgG4sPhNeVCpjDCzDKSchTpGxukFWiGuCQ4zs3Ypt/uByEt9OQtEwoZVSvJqVMGhM312ctX663WXFD5eRn7B+VjabHWC5TAA4voo8pyMR4=
X-HE-Tag: 1795530288-998317
X-HE-Meta: U2FsdGVkX19O0OkT3IIMhA09qI0FrhCqvdbj5ORcoWyhWR9tOYISBb8xtGrJe79TQe0dMMMbITvsP6EWfX3hoztoF8txQJBN4qRRbDaRxn9Y6IN5TwOeEEDr0b8B3KcHS50lYjr/RbhY1tGUcSAhfU9LgHvtJtdahMC09c6eq+Hnad/utgdTO/J91Eirom9utVLguzhG1AYqIwMYuRjmkYf3s4nSrQqI7NuIU5YsDYzhC0aX/My2hKT/HMPH2+J19FkvgYbBTPJp98fOXr9ecqMTBRiMbwKvMpBr7ryuNK0gn2upsqu5MmNV2tVAwlbolQH+aY7gR0ToPzN6ck4dzAksdJbv5U2Ysq7p0PihBRyKhvtF/sMB2X9zqgxZT8aBJvQbktxp3jSAWCAAHoXOT2liqMPDs+heyOZbBb82Rd1gknFv45bitDLEACGdsFDz9iu6yFet/iOuEKYy58xcKhrIp1iswVwTwLkwF0QjuEU=

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
Changes since v7: https://patch.msgid.link/20261123213246.00440bfc@gandalf.local.home

- Have all the helper functions test for null pointer before
  dereferencing (Sashiko).

 kernel/trace/trace_probe_tmpl.h | 103 +++++++++++++++++++++++++-------
 1 file changed, 83 insertions(+), 20 deletions(-)

diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 8acc0f0ebd7a..b9fd2f61a0ca 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -96,7 +96,8 @@ fetch_store_symstring(unsigned long addr, void *dest, void *base)
 		return -ENOMEM;
 
 	__dest = get_loc_data(dest, base);
-	len = sprint_symbol(namebuf, addr);
+	/* Do not dereference NULL pointers */
+	len = addr ? sprint_symbol(namebuf, addr) : -1;
 	if (len < 0) {
 		*(u32 *)dest = make_data_loc(0, __dest - base);
 		return 0;
@@ -133,13 +134,65 @@ process_common_fetch_insn(struct fetch_insn *code, unsigned long *val)
 	return 0;
 }
 
+/* On failure, zero out the destination */
+static nokprobe_inline int
+do_probe_mem_read_user(void *dest, void *src, size_t size)
+{
+	int ret;
+
+	/* Do not dereference NULL pointers */
+	ret = src ? probe_mem_read_user(dest, src, size) : -1;
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
+	/* Do not dereference NULL pointers */
+	ret = src ? probe_mem_read(dest, src, size) : -1;
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
 
@@ -147,25 +200,26 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 	/* 2nd stage: dereference memory if needed */
 	do {
 		lval = val;
+		/* Prevent dereferencing NULL val pointer */
+		offset = val ? code->offset : 0;
 		switch (code->op) {
 		case FETCH_OP_DEREF:
-			ret = probe_mem_read(&val, (void *)val + code->offset,
-					     sizeof(val));
+			do_probe_mem_read(&val, (void *)val + offset,
+					  sizeof(val));
 			break;
 		case FETCH_OP_UDEREF:
-			ret = probe_mem_read_user(&val,
-				 (void *)val + code->offset, sizeof(val));
+			do_probe_mem_read_user(&val, (void *)val + offset,
+					       sizeof(val));
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
@@ -175,17 +229,18 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 stage3:
 	/* 3rd stage: store value to buffer */
 	if (unlikely(!dest)) {
+		offset = code->offset;
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
@@ -193,27 +248,33 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 		}
 	}
 
+	/*
+	 * Once val is zero, it is pointing to NULL. Any new dereference is
+	 * also treated as a NULL pointer.
+	 */
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
@@ -237,11 +298,13 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
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

