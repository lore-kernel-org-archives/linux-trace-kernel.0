Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794499139;
	b=1F3IS4fNoWgcS+6wuJP5bB4BZ6Ln3r7PAD4vQ0UOWgJkU4+E6G/BonnWsSAwIlhNi5pv
	 zfBvCpRLk9HAtwAS8+6RqWSbi6LfitW9g3vDm6erKh1jRzJ8NO9gRCd1iJ0IQ9zpPH7pn
	 ZkwOd+NJu+R7JIgG7WFwjcsec5S72X4P+BT3+RTwLrBAdGv5QcZWOfGyz5QSfAy6decSV
	 oTZwPtaAGk6ZEfb9uYohN8a07PrRg9It060raC4WsXimOkv9dp1lBz96LnVjfZKZv33hU
	 nc9leae/qbGrnfeeojJ66atY376kTyiIZlvQU1qyWnkmXckqHziIe8AG/OV+pKt8oQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499139;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id:X-Rspamd-Server:X-Stat-Signature:X-Spam-Status:
	 X-Session-Marker:X-Session-ID:DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=RA4Zm7BEMm8rMWMw7WpSJymch0xY2+ETcvG+vYOO778=;
	b=BL4pTaIANa2fpAoEFNGDCWsaLBcL9gofxL7vrRZd9aMRrN15tFxtQCXQrcEeXovSnuYn
	 SoFdWeHEwx8EVY1nV2FYP+wi/LgJm2QwF7VD8R48t1z9bUIDefJrBWwMX9b4LArLhx2zD
	 UgD62KJ6DA4QVD8zuT1qAB3Qg88sQnx9AmCvrVYE6ieUHGQ7eL/HK3w/DjG0nlYjByMoh
	 YGByQPLu+8w305maVv4TH8Tl3yPrnfWRunojPwnWCa4V3j9W1rtiOKTLYJ4YQvJYdvXtp
	 qCy/tVJk19V3fWh4wbrUZz/FfwyLCQvGVdY1tGjcFvLsGm7nQ/CWfWtJLvLvrkQBSkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=QpEBqYGD;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20303606A323;
	Thu, 12 Nov 2026 15:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20303606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=QpEBqYGD
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id BD17E1A0684;
	Thu, 12 Nov 2026 15:58:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 313D52002B;
	Thu, 12 Nov 2026 15:58:55 +0000 (UTC)
Date: Thu, 12 Nov 2026 10:58:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2] tracing/probes: Zero out faulted dereferenced fields
Message-ID: <20261112105853.38bd39be@fedora>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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
X-Rspamd-Queue-Id: 313D52002B
X-Rspamd-Server: rspamout08
X-Stat-Signature: 4dzcu1t787i6shzwzxdjaxxutfjow5zq
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/TDRtc4a3gZTgU+8DPOX3+8Aw1OT4g16k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=RA4Zm7BEMm8rMWMw7WpSJymch0xY2+ETcvG+vYOO778=; b=QpEBqYGDXIOZbgB0T8jEfN7EsSp1WwhrrXHhTP5AEORWoZVlJjrL7p31F9bv1oHn06pBvRB3xt9mpB/N48W/GNQWocIYDlyhFEdL2YBagvMsgcrfWU5CCTRqZE819peCWlweKf6W7hT3RkLsu1IfplAv421xsNTwJtiSMHd7lM8=
X-HE-Tag: 1794499135-890381
X-HE-Meta: U2FsdGVkX1+TPCutRuhTmth3nWP+OcwBHqQwhwKiUc7RO+6E+p7zoV8ptm/LvdJNpCUseMB0od+f3VT6ZZHk9kC14NMA0s158XKEsMNKZaC+Il1sYpMa234EWndeb84nt2RYX62aBjWVZTS2s0UbioyKD3bhQzDJ38Nas3jGrew8y9ToDqGp13Cj2z+ReTKM+HgBFDAkapPnvPR3lel2XG564Nw4nLc3ezrTx3N67b1XhEANcayzwlkiTe8HgGnqc2DZTCsr3nWxtZ0MOEYLeE76lUEcmG/0kNqdx7Fxa7BQ3QggHoh3iuyIsTZoXFYLWzW1GnFoTIidHunvzVQanBmuGnvhxKMI5OWENfrrco58taH9+rDJWlJy5/x7QygSslwL8aLYTQfFVU9WMU4KfScr5MEIPL0ZhE/wJAKHiRmleOcnHnUeFprHcYW3W2pbYztoRI3eqBineu6DoYqtkORjVthO1tAbLsiCh/RNZ34=

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
Changse since v1: https://patch.msgid.link/20261111050322.49bbebfa@fedora

- Have stage two handle faults as well, and just ignore dereferencing NULL
  pointers. (sashiko)

 kernel/trace/trace_probe_kernel.h | 13 +++++++++++--
 kernel/trace/trace_probe_tmpl.h   | 15 ++++++++-------
 2 files changed, 19 insertions(+), 9 deletions(-)

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
index 8db12f758fda..210a75ed5a92 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -137,23 +137,24 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 		lval = val;
 		switch (code->op) {
 		case FETCH_OP_DEREF:
-			ret = probe_mem_read(&val, (void *)val + code->offset,
-					     sizeof(val));
+			/* Do not dereference NULL pointers */
+			if (val)
+				probe_mem_read(&val, (void *)val + code->offset,
+					       sizeof(val));
 			break;
 		case FETCH_OP_UDEREF:
-			ret = probe_mem_read_user(&val,
-				 (void *)val + code->offset, sizeof(val));
+			/* Do not dereference NULL pointers */
+			if (val)
+				probe_mem_read_user(&val, (void *)val + code->offset,
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
-- 
2.53.0

