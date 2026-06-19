Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB6B21CC51
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Jun 2026 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781894684; cv=none; b=Cj7M3Y2vppxnkQ7QLXYuuodQ3voHD9a/m7vvaEUJ6xF8b8e9UOUtFpQGwr1Iult8rnqqyeP+p8k4rgpA7gWEsTMIw+S2O73HL+t2xex74BMVlWwfoQI2qc2vEF/w3zggSyo7AsEy6af47CqSB1CUipoczQiYoSuoJ6WTnRHBj4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781894684; c=relaxed/simple;
	bh=8fXqGjNnbzut5woYDNdWs5iK62wSfrgJGZ644zR4Ack=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FGwinrYFroq9d4aDfLCllNw5WptP+73q/PYwh8xNb7ZWjw3N3hUHzswW6tuKpNDfibqq3KDlzTnNrkjjdSDX1MaMlqxjVdQ1uwDrMwZ2oJTt+fT/BmY0yeWGpxm+MXI7trn4u+0596rZehoaSubwL+NgntJgNRAxOzadTHC9m/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rl+mAWcm; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rl+mAWcm"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-845369f60faso1422288b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Jun 2026 11:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781894683; x=1782499483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zn4Y1p1IcAK+Z0EJz1OWw0jaNTsfN8IrR0vu8eQ8SnE=;
        b=Rl+mAWcmStYSL79udmdDAFo3G8xmTqzzeJF/bxflvyi5aUJ14/2TGJ1mBo7HDTCDSh
         TE4HQUVvG3RHaYClauo195T6QvPJfl4ZPY8yIDMl4X85DPcyZE7JvhFesgtmk6xWbZM4
         8sNYXszMxvmnzyglDSoY19EqUlIgF9LHdvu4HGYvIWStrQosbCHxc1Ci53VrZ7pxwgWN
         espJTBtx3s2cHa8jn5Z7AHrW/5sQiuv/URswPEBpulaOL8B8ZdM3Add9ZqajayKDsBt2
         6vAwBJeuRpTu068bbXhXW1tA7bQAZEGdCSpMcTvDB1EVaI1ltYuQzqFKvjIuEAUf3cv5
         7Vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781894683; x=1782499483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zn4Y1p1IcAK+Z0EJz1OWw0jaNTsfN8IrR0vu8eQ8SnE=;
        b=ngjSttWcq11OIKsHMGdyPBasT7V136utNKQXPKKo61PwYyq50aXhjfeXg3PimMkQv2
         wnTwgSU5fEfS1iVsiwYsm9qPknkoSSzF4Vt+zakt9NmdZDmRt5JPtNllXYPbRjt+UnAC
         5F1afnfOyL6jSEPw0xpQR5GD7aX0OGFWurezTyCVM/udxHRCmGAsfPlBf3yDhGG0iJPk
         UcodlCl63LRqivhQahpQRvMCBN4kn57rQps9w6zdzETGan4XhQC/gwvwt5n96sGxlP+4
         7pQw97XfluhufV4vwwOWPkajaX66FV5YM0vOUlV4oWWWl+cbUDH5GA9Gga9Qwg+fRLZ/
         IPqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Bw5WUeHvU/6t1iCusbj1mW+HXmhHclk8/GNS64W6USCY4WcUYVfoH8K3BzoYK+TO/8W/UTBlbKIh9rNQK+WqXRMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsuPvxG9xsuchZQeeUZ8l90Bq4QhE2wlmciJRrYCsiqAHK/AyF
	ay5lb4s4htLKSYKhhR6SNqv/Ust2Q7SPJIpOntzFYfGckRojxV9M212D
X-Gm-Gg: AfdE7cmj6IrDK+3K5SUQsorQjNJE2hDF5rcQ3weUMcnBVIwClpKQKOAl6/QUkq8ilWs
	5JB9WzEmp1yVtTsWwAj105NA0jvNa11iC0dBT1fxv5LaBFaZHNgk6wGdt2x0CQZ6XAvr9LFIKPX
	OmIuBvrA7TkJAMRMkvpBRRKQ8W5nuy+3hVMYXXJiAxOfSebVQVrFV4Rx3XvpZcmTHWP+HIIAKLh
	oPUbKUi82U/v+22v5VyZP0q39BMhvIPKX+1JU/rmpCz4/V+WM88U20wfIViYCtSyJzmRLKgo2Lk
	+gNFvgqdSlo0f3yPUYeEyZS+8QzKpwgZxhX6S83YivV2obHSnqHUEDB458Z/1P3ghZPBxKDM2x1
	BCQlhjaoylr1Mad6SS0r5Na+2M4P+kxgi47O/vX+HNzBBA89oEhsdTa0DI0xLral8Jw5im3HacA
	v5SnlMtk9CoRe5LObNXI6SUtnN+XciZcjSsLL9e18r/ZW+tfSSWwo=
X-Received: by 2002:a05:6a00:2a0c:b0:842:5c90:736b with SMTP id d2e1a72fcca58-8455088dc84mr5813361b3a.29.1781894682874;
        Fri, 19 Jun 2026 11:44:42 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8455382780asm2969123b3a.46.2026.06.19.11.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 11:44:42 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing/fprobe: Fix NULL pointer dereference in fprobe_fgraph_entry()
Date: Fri, 19 Jun 2026 18:44:24 +0000
Message-ID: <20260619184425.3824774-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fprobe_fgraph_entry() sizes a shadow-stack reservation in one walk of
the per-ip fprobe list and fills it in a second walk, both under
rcu_read_lock() only. A fprobe registered on an already-live ip can
become visible between the two walks, so the fill walk processes an
exit_handler the sizing walk did not count and used runs past
reserved_words. If the sizing walk counted nothing, fgraph_data is NULL
and the first write_fprobe_header() faults:

  Oops: general protection fault, probably for non-canonical address ...
  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  RIP: 0010:fprobe_fgraph_entry+0xa38/0xf10 kernel/trace/fprobe.c:167
  Call Trace:
   <TASK>
   function_graph_enter_regs+0x44c/0xa10 kernel/trace/fgraph.c:677
   ftrace_graph_func+0xc5/0x140 arch/x86/kernel/ftrace.c:671
   __kernel_text_address+0x9/0x40 kernel/extable.c:78
   arch_stack_walk+0x117/0x170 arch/x86/kernel/stacktrace.c:26
   kmem_cache_free+0x188/0x580 mm/slub.c:6378
   tcp_data_queue+0x18d/0x6550 net/ipv4/tcp_input.c:5590
   [...]
   </TASK>

The list cannot be frozen across the two walks, so skip a node that does
not fit the reservation and count it as missed.

Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 kernel/trace/fprobe.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index f378613ad120..f215990b9061 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -613,6 +613,16 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
 			continue;
 
 		data_size = fp->entry_data_size;
+		/*
+		 * The list may have grown since it was sized, so this node
+		 * may not fit. Skip it as missed rather than overrun the
+		 * reservation.
+		 */
+		if (fp->exit_handler &&
+		    used + FPROBE_HEADER_SIZE_IN_LONG + SIZE_IN_LONG(data_size) > reserved_words) {
+			fp->nmissed++;
+			continue;
+		}
 		if (data_size && fp->exit_handler)
 			data = fgraph_data + used + FPROBE_HEADER_SIZE_IN_LONG;
 		else
-- 
2.43.0

