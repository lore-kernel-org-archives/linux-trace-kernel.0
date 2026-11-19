Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795120172;
	b=Au2xqnJ3iGsipPNCw8mXvtEsso3cv1GyxhfHSBfrUuMNpCzrlDFJ6nr9lKnJ7J8/iOqh
	 BsrvnUV01vchTl8EmKPiimIbe1jnz3YCb9vHVfxvoMjMNvEDCJUvrra/O46L97ksXoyg+
	 A913YOI+nEo2IYypKiHrdog+6sNrGM4BBwQNLa3vLRQMEmGprWOQvbj9o73viqInp//4N
	 tNWbC9t/KK5i10RVoIHZCrAdmiNFowe7wUtBoBXKal8C+/I4XwKiUIccwA5hVLk+S1iFU
	 JqTML/kECr3SdFthpOxs9JRDKAylc0kvkY3tNsuHRN3/kgG1XzCZ9Ms0v39Yyf9oVDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120172;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Stat-Signature:X-Spam-Status:
	 X-Session-Marker:X-Session-ID:DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=PnxIt1bw+pEf3Hn45cnPIXxc6g7CbUAWTpW7fsZ8zl8=;
	b=IJU2Re1iZNAIyeTNFJVInOU2czeczE2sT4tCbuw4mWzGGx028KQHmhKAuMCNV4h8MQXa
	 GvvYcGvnvWhLw5N6hlFW4rRnyBycQMrnjGlYSMS/W4njet605yDfb97fXJGflawtxezbh
	 dI5/Sc74HpvRkEPmYxG6E8OfuvllI2c6dwkQAIRROmzRVXU9loZZ3UP378xkH0NymrhAR
	 AbyswepTzQ8mioe7hkgkUYda1Nf6jPLkyD7relWa6b15YpnGRbCsuTJNzTZUeqzQxgI56
	 fkAoYgt7q+ibp5VoKC+hkUL74CmQn+s9pUlbmir538wmyfRH5LBKiVpAZ9RC1aJgcFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=y23HLLDd;
	arc=none smtp.remote-ip=216.40.44.17
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E228A606A320;
	Thu, 19 Nov 2026 20:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E228A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=y23HLLDd
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id D2459A8B16;
	Thu, 19 Nov 2026 20:29:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 339B920025;
	Thu, 19 Nov 2026 20:29:23 +0000 (UTC)
Date: Thu, 19 Nov 2026 15:29:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH v3] tracing/probes: Zero out faulted dereferenced fields
Message-ID: <20261119152922.5a66f10e@gandalf.local.home>
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
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 339B920025
X-Stat-Signature: sy9gy9ix1zwjkmy6z37r8wautc78ddnr
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+9Aau3MhQeAR+KxyK2Lke4W3EUJtXLNUo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=PnxIt1bw+pEf3Hn45cnPIXxc6g7CbUAWTpW7fsZ8zl8=; b=y23HLLDduHn6Caipj+sgwATAVM0NekRql4FyqNKH7ZIJFtRiMy7ENSWOfvnBgn2/FV0og1fB7gA8zmo6vjBogPVCJE5KKo8MfvcJcyy2O6iYIRmS+OY38MdGonPRbPZALLuwKXjEgi9Xs/UoBm/Tdst7WNhDyAmAmbkO938Ulrg=
X-HE-Tag: 1795120163-700725
X-HE-Meta: U2FsdGVkX182mqpNEikB1Hymz0Vfvx9t0IecANTgEFwleDzTGwlmScPYdsyzEzs1pOm6KgtnLPWxUZGJGo5c8x4PCpRt/Xfi9OfOgq/2AbKt/CM35WkZAg0nu2lOWZXw7j1y8ROdwuJzwfn9ddfZkXsteTKo0e1tJsqaNaV/Rv6JJaL6J4ul2J2SXR+EQxu2qbpUdx9BDN2GKU9WK2KVYtlSjno1orqpsglnBP/yngjYFpNGPYvDZ3f5jvlGcbB/xm0axjL5Icrviz/iRJx0h1LZA1kbLo2HxG4Jek+Zoy6U3/ix73Wc4yXUXrL/P/D33Ty+7Z2gEL3a5xsoXQs8lxdrYJFc0puir1zvyxTe+mka/ZWGQvIS4VY1ji5aenViF+nqVbWwUYc+Zgm+wqOOR3jvD74wHuGku2G+zkxv0r+2wHosxPjnk6r3ySHwG//yYncNinjBuVCL4+Pi3YityMBmupEZ4V1b/AUro5Ui8ZQ=

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
Changes since v2: https://patch.msgid.link/20261112105853.38bd39be@fedora

- Do not dereference any val that is zero. Set offset to zero as well.
  (sashiko)

 kernel/trace/trace_probe_kernel.h | 13 ++++++++--
 kernel/trace/trace_probe_tmpl.h   | 41 +++++++++++++++++++------------
 2 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/trace_probe_kernel.h b/kernel/trace/trace_probe_kernel.h
index 4eb4acfa09ba..00542a162d30 100644
--- a/kernel/trace/trace_probe_kernel.h
+++ b/kernel/trace/trace_probe_kernel.h
@@ -102,18 +102,27 @@ static nokprobe_inline int
 probe_mem_read_user(void *dest, void *src, size_t size)
 {
 	const void __user *uaddr =  (__force const void __user *)src;
+	int ret;
 
-	return copy_from_user_nofault(dest, uaddr, size);
+	ret = copy_from_user_nofault(dest, uaddr, size);
+	if (ret < 0)
+		memset(dest, 0, size);
+	return ret;
 }
 
 static nokprobe_inline int
 probe_mem_read(void *dest, void *src, size_t size)
 {
+	int ret;
+
 #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	if ((unsigned long)src < TASK_SIZE)
 		return probe_mem_read_user(dest, src, size);
 #endif
-	return copy_from_kernel_nofault(dest, src, size);
+	ret = copy_from_kernel_nofault(dest, src, size);
+	if (ret < 0)
+		memset(dest, 0, size);
+	return ret;
 }
 
 #endif /* __TRACE_PROBE_KERNEL_H_ */
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 8acc0f0ebd7a..4bb5ca440b75 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -139,7 +139,7 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 			   void *dest, void *base)
 {
 	struct fetch_insn *s3 = NULL;
-	int total = 0, ret = 0, i = 0;
+	int total = 0, ret = 0, i = 0, offset;
 	u32 loc = 0;
 	unsigned long lval, llval = val;
 
@@ -147,25 +147,28 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
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
+				probe_mem_read(&val, (void *)val + offset,
+					       sizeof(val));
 			break;
 		case FETCH_OP_UDEREF:
-			ret = probe_mem_read_user(&val,
-				 (void *)val + code->offset, sizeof(val));
+			/* Do not dereference NULL pointers */
+			if (val)
+				probe_mem_read_user(&val, (void *)val + offset,
+						    sizeof(val));
 			break;
 		case FETCH_OP_CPU_PTR:
 			val = (unsigned long)this_cpu_ptr((void __percpu *)val);
-			ret = 0;
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
@@ -173,19 +176,22 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 
 	s3 = code;
 stage3:
+	/* Prevent dereferencing NULL val pointer */
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
@@ -193,27 +199,30 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 		}
 	}
 
+	/* Prevent dereferencing NULL val pointer */
+	offset = val ? code->offset : 0;
+
 	switch (code->op) {
 	case FETCH_OP_ST_RAW:
 		fetch_store_raw(val, code, dest);
 		break;
 	case FETCH_OP_ST_MEM:
-		probe_mem_read(dest, (void *)val + code->offset, code->size);
+		probe_mem_read(dest, (void *)val + offset, code->size);
 		break;
 	case FETCH_OP_ST_UMEM:
-		probe_mem_read_user(dest, (void *)val + code->offset, code->size);
+		probe_mem_read_user(dest, (void *)val + offset, code->size);
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
-- 
2.53.0

