Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795203008;
	b=FU2lS/PzEkMbAgI1EWHf8+vhx2xt1SiL9NjJlHJ+3vzDi/ud2bmXnBOjIOQ/3bz5XO8f
	 D07MeogAZSNuEhnZF37tcPhX8xtdw8HtpvPcXH6OPtDfC6juV3S2QBU//uV4pZEpdScMF
	 jlg7QC6coaNLFScCDmDO/dileAgudJpilrmijNKKHyoVU7hMR3H+5cprGEioQCb+15IYz
	 bTaxtCGDNjEHXxQSQ3/EpuoAmU9Hz/uN/h7BjUuYnKy1sICsqkD6LeijQc+fbjonMDdp7
	 FvwPSwPCowVyM1jYP/UDpWY6egkQ08k+Z8Cp1VsUrQGGmia6GUOGkgBpug4isWMnPrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795203008;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Stat-Signature:X-Spam-Status:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Session-Marker:X-Session-ID:DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=fsR2ckawZaVZ8b1NhX6hZBSLAfDYxLYGyswfVkMNPA8=;
	b=1wbPfQm3AHpL70WHWHHi2vvEiO5NF7cEy2LuTLRx5QBCD5Y14vqevZ7hVHeV5tRv8c7K
	 tHgh9FTks3YLydlfBCI8K3F+SMTWZ+oabKz9EXwS+nuigqjGkafpLyPsUrpaxVT19g/E0
	 oOmbYlPGOcD5Rz5SgYQz2a0M7c0mI4o8Kx8XX7E19cMaPC83n1SlQWzWsr7hGxE8QpbT/
	 +nPzS25d6t8yG6yHDV1CF/E/HiU/ERcvBxa9sbJ+4wYKS2m+gGTaw7jmC4xRv2s2fCFAV
	 K1IaA2Uuk0vXn5ZfBjjjfYe6a00PUFFJjSl3bIAJZjHwskZGenoo5rFmX/MwE3ink2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=3lO3FZvB;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7DF60A2639;
	Fri, 20 Nov 2026 19:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F7DF60A2639
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=3lO3FZvB
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 9646312017F;
	Fri, 20 Nov 2026 19:30:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 1B7E11A;
	Fri, 20 Nov 2026 19:30:04 +0000 (UTC)
Date: Fri, 20 Nov 2026 14:30:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH v4] tracing/probes: Zero out faulted dereferenced fields
Message-ID: <20261120143002.18b364b3@gandalf.local.home>
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
X-Stat-Signature: a1rozdkt8mwikma77uocjc3dioh5py1y
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 1B7E11A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+I8eBn7jDDxOIK/S+O6crh/EdPev82jH0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=fsR2ckawZaVZ8b1NhX6hZBSLAfDYxLYGyswfVkMNPA8=; b=3lO3FZvBiGxk0q7wAyk5ck/kyhXrY9Zs6Jkic3QKAJd7PlWDSA66znNTji/m6NIrsGhTq7/z7jTU8MHC2DqOYdGxr9rOoxKtKnzEZXGNpCXSD+LmyfF6l9MCzPF2CWNQyQ1cJto7P7XGQckeDHnMmpaFMPCFtXmG6LTCtNMOdAE=
X-HE-Tag: 1795203004-537236
X-HE-Meta: U2FsdGVkX1/zImiulvvCzfjq2t70Xz8BN7kzotVM47JEmA+Bc5sn+OcGNP3NX9acNTUV+aChHZEQWNp1b9jhdCQFZCON92bWTJRZgf+arhlXyV1hNrO6hDNJHy2UQU+XdmmM5NRqp33TR5iRXL07Zk3o4exkqC7WzIjfEd1jZ0gDTbBTHmRDgdBD4vxiSVEKWxObjLvEiPlohgwrtrVMOWwjWduPgyRpkgD1yH0SrNQ8gbyTzSYRYH/z2D4mvc8XmvUcO6hAhOA1lt2NgTyZxJYittR9ACXU5OJtbl4C5DXdj96vgseCVm9uX0CYOnHFjcOSbrVfdn9GNm9rC+ruTaXM+Qs21i9z220RLelkteWK7PBmJFwVvytCXbAaEHjn/tGCRW9ni41fo/efvlEq0euOigJ4Sj68GB4NJ5eVORphpLIdI8JXIN+joOcIcOpVZ1cBlnfg0s8DKnV1ejUXHfNzlkoqUOYmn6oEBQ2YvK0=

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
Changes since v3: https://patch.msgid.link/20261119152922.5a66f10e@gandalf.local.home

- Better handle offsets when val is a NULL pointer to always dereference
  NULL. (Sashiko)

- Wrapped the probe_mem_read/_user() in a function to use that does the
  memory clearing on failure so that other code (like trace_uprobe.c) that
  defines probe_mem_read() can also work with it. (Sashiko)

 kernel/trace/trace_probe_tmpl.h | 80 +++++++++++++++++++++++++--------
 1 file changed, 61 insertions(+), 19 deletions(-)

diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 8acc0f0ebd7a..6e137772d2b6 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -133,13 +133,37 @@ process_common_fetch_insn(struct fetch_insn *code, unsigned long *val)
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
 
@@ -147,25 +171,30 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
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
@@ -173,19 +202,25 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 
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
+			ret = fetch_store_strlen(val + offset);
 			code++;
 			goto array;
 		case FETCH_OP_ST_USTRING:
-			ret = fetch_store_strlen_user(val + code->offset);
+			ret = fetch_store_strlen_user(val + offset);
 			code++;
 			goto array;
 		case FETCH_OP_ST_SYMSTR:
-			ret = fetch_store_symstrlen(val + code->offset);
+			ret = fetch_store_symstrlen(val + offset);
 			code++;
 			goto array;
 		default:
@@ -193,27 +228,30 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
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
+		ret = fetch_store_string(val + offset, dest, base);
 		break;
 	case FETCH_OP_ST_USTRING:
 		loc = *(u32 *)dest;
-		ret = fetch_store_string_user(val + code->offset, dest, base);
+		ret = fetch_store_string_user(val + offset, dest, base);
 		break;
 	case FETCH_OP_ST_SYMSTR:
 		loc = *(u32 *)dest;
-		ret = fetch_store_symstring(val + code->offset, dest, base);
+		ret = fetch_store_symstring(val + offset, dest, base);
 		break;
 	default:
 		return -EILSEQ;
@@ -237,11 +275,15 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
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
+			/* Only update a non NULL val */
+			if (val)
+				val = lval + sizeof(char *);
 			if (dest) {
 				dest += sizeof(u32);
 				*(u32 *)dest = update_data_loc(loc, ret);
-- 
2.53.0

