Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794391419;
	b=OuPVMu/Lu/a52ygKvYdNffIuF9sFGXHCSo+XEUnyR+w1CGoiutVcwBm0X6uI57UkLqjO
	 d6IaeXnro1kLaQEfjA2NN91qLGSme3eco/Urg4l07W50Ca/P5hdGnWq0W1laLQiZx8c8e
	 djAONBGkEzsM7ITy1QN7zTiHsAtvV9kvFmWd7g87yOsNmyNQJaSc0jcPdeW096V0J+Xkw
	 TAUUqhWLCaNiEGifzjnysW8c6O4sd20HewxdvgGSWT3RvTJl4yihWl1hXunKV1XFehqXl
	 J79HbC7IFQdepvk8QHtoBq6+Zyggo4EUbdeGtl+4jHr6LpKUEd8csVy/CbSD/2sUD5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391419;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Stat-Signature:X-Spam-Status:
	 X-Session-Marker:X-Session-ID:DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=nxPODO96ooeOFk6g2gU7/c+Ex4GmNCqkv9X+bjevByQ=;
	b=3IvHb2rVQrA80vMwz0etQ/Dc6IaT7xBLhrjZXDLMluTTZ0/YHr3X8U21y2o4JNlMfAr6
	 GqvKZqqCnE/pk8f2EE5D8DR8tu7xCI+wj3XWIzFHUp5mW/2PMFmhLesv7Jm0KE98nAeLj
	 rC/eNTv4n9yNEQGT7YO40VdqiCOTIeaRdQyt+a8TYCQYt+l65FAo9Lb59yysqHV6j+8LK
	 hDMYph+YfmD5gUvG7JmKGpKaNAlMiixrit447WyiBh2x2r+aEf5FY67Xa53fo9b3jmrah
	 j5ZWi11CFYQ4pPIjk+1dyLekpqGKrM248f1sJn0e44pDiq/5BW0xeHF28vZDGllZtFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b="hv/aZhys";
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1BB606A891;
	Wed, 11 Nov 2026 10:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC1BB606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=hv/aZhys
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id B129E12025E;
	Wed, 11 Nov 2026 10:03:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id D0EA719;
	Wed, 11 Nov 2026 10:03:27 +0000 (UTC)
Date: Wed, 11 Nov 2026 05:03:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing/probes: Zero out faulted dereferenced fields
Message-ID: <20261111050322.49bbebfa@fedora>
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
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: D0EA719
X-Stat-Signature: n971ugsmikxw4qo3d4gp7iy3a5w4d59b
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX187LOXOvnlUwba75FnJkjrRJvsphm/oBvM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=nxPODO96ooeOFk6g2gU7/c+Ex4GmNCqkv9X+bjevByQ=; b=hv/aZhysHnZpNpVqmnLZPYq7QULWBWXyKL0StqiMcJ1S6N3DygwqS3WZwJa26BX+Yv1+r6k4SPU3neXom9e50kZtH+Vm1rnaHbC6Uz6cPTUMn+HXtEWoPHC17k1+4kH8+gewADI209ZwcuLngNdRbSdKBq91AggrBHhf7qFXp1o=
X-HE-Tag: 1794391407-275707
X-HE-Meta: U2FsdGVkX188mOS6vxNQO29vO9nGP3G2ppzsqqxZfhscu/SwOszW7BamPGtoWWi6aLpUZboUh04A0+yym919beMxthXbS0mvuMxIqj/SpoJZcuI3fvnUmcSdx6OWRIOukG3lmM3PNX4Cgehepnbm6fJHCNZEQWZJm2cxgUABmz/rqAmEvqrpB22hUSQEVgqZsnpXiRlt+/BdWL4CQXAuVBcEqA6j33ZgejScM6UhM+feVSaPfR8Q+Ph+95uD14+oYDe6iTgScqZM1xRFGlG1eAcJ9nhKaavHRWCGeA+GRM4JjGOT3XLT7k1jHagKtc3LAMe0+xGCCNkcrNDf16nX1NW6pYsnYZH4xtzPKG8ZflYjhBQN76GqL089xT/NQVIYuNm8RFLAkPTgGR7lHdXuLA==

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

Now all gdb are zero when mm is zero.

Cc: stable@vger.kernel.org
Fixes: 533059281ee59 ("tracing: probeevent: Introduce new argument fetching code")
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_probe_kernel.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

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
-- 
2.55.0

