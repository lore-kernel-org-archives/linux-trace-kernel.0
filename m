Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793673929;
	b=FeXF3mFTjvhwpdM+rJybT8IfSNeOqvTVPTBgfoaR1n8PqSPbOgYSyPrHyVyzIviP7n9r
	 qPrviilxI5y2xPtVdDxdguWysEBWoq7FEMVfyIEeTr7RtsopjQEqi7TjK3Hknji0GwOKQ
	 aQhRuBN2h/XW6Jxkhv7b8cFiFD23cqaYKrCBlB68VB8BbECEjzEqFNAyCGKuNfMW6Z0EE
	 +x+v6OoEEA36wCNDvePQuwMNoz2nSbfcFi7wVaaWNduzATEHbA3WMsyrbngZ+qqhj6vUY
	 eih9wVCKUeolpFbXgBb3bQ1JtOzqGNw8MhYeFbz3CdV94ja61SiFqWuWTJTxgYyXImg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793673929;
	h=DMARC-Filter:Received:From:To:Cc:Date:Message-ID:Subject:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=z2Ps+XVA2Ccwus88hi1fXu3RjGPJlOzPV/bkye9S1jU=;
	b=a+MXTCOCazlXSpCBwHxDapMOMNeQ/w87Bm1GN/NwSZv9UaF9Qm0/wTpGZhatJOoNqjdx
	 Ip3DpvPMPXPXw0LqAVGmdBd8Fhb/8YZ68tVnnJ9qlt2b8s+hx88OtCUvldEOZqax9zhB/
	 33RakDnqY/qbK7fEPcj1IOVJUuKycp6xUCf4SJKdV5zUaq4IBcIn7vjpPcl351l6vYXMb
	 Sn8WvhWCt8bQa5qSqW1rS9cMOG8qW0csSbO+i9u+TO6J0NjJsNw00jqcXniZIMKq8GMB+
	 1sjnFOHu2YDSEX7afwla52y8w+kEElleQlJP7IzHa8iYbDoFHWcyTaOhyOD0I3K2Kag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.pku.edu.cn;
	spf=pass smtp.mailfrom=stu.pku.edu.cn;
	dkim=pass header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=KAYPfDx4;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59776606D803;
	Tue,  3 Nov 2026 02:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59776606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=KAYPfDx4
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [IPV6:2409:8a00:3c11:dbc0:2581:8e:ca0f:59ab])
	by smtp.qiye.163.com (Hmail) with ESMTP id 534316a42;
	Tue, 3 Nov 2026 10:45:25 +0800 (GMT+08:00)
From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
To: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 10:45:19 +0800
Message-ID: <179367391951.8187.17152618045554425533@stu.pku.edu.cn>
Subject: [PATCH v2] tracing/probes: bound symstr stores to reserved length
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa19f4c136203a2kunm153cdd6b10a868
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSklCVkhKTRhDTB8eQkkeTlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJT0tCQUMaS0tBSBhKSkEfGRhLQUlOQ0pBQx5BGBpLHUFOQh
	oZWVdZFhoPEhUdFFlBWU9LSFVKS0hKTE1DVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=KAYPfDx4w+cHHb50Av7wXG2rfJK4qJrRzi8qlCocC/dW/HUF7eUreZFi2BMvSixFniHLNB2I16PdooqqO9j1HZVK9aJY+kO1KqOJzkR/YpzQcfqhRK2i5mMszHS4iwX4Ki/eFoT5rKUGEwltwZE2S5+tOGeyu8aRz+qlWu4Vie4=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=z2Ps+XVA2Ccwus88hi1fXu3RjGPJlOzPV/bkye9S1jU=;
	h=date:mime-version:subject:message-id:from;

Traceprobe calculates dynamic string sizes before storing the values.  A
probed pointer can change between those passes, so fetch_store_symstrlen()
can reserve space for a short symbol while fetch_store_symstring() observes
a longer one.  The store path ignores the reserved length and allows the
second symbol to overwrite the trace record.

KASAN reports:

  BUG: KASAN: slab-out-of-bounds in sized_strscpy
  Write of size 8
  sized_strscpy
  module_address_lookup
  __sprint_symbol
  process_fetch_insn

Format the symbol into a temporary KSYM_SYMBOL_LEN buffer with
sprint_symbol(), then copy at most the reserved length minus the trailing
NUL.  Using sprint_symbol() for both sizing and storage preserves identical
symbol formatting while bounding the destination write.

Fixes: b26a124cbfa8 ("tracing/probes: Add symstr type for dynamic events")
Signed-off-by: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
---
Changes in v2:
- use sprint_symbol() for both sizing and storage, with a bounded copy from
  a temporary buffer, instead of formatting the destination with %pS

 kernel/trace/trace_probe_tmpl.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 8db12f758fdae..dea6772652550 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -87,15 +87,24 @@ fetch_store_symstrlen(unsigned long addr)
 static nokprobe_inline int
 fetch_store_symstring(unsigned long addr, void *dest, void *base)
 {
+	char namebuf[KSYM_SYMBOL_LEN];
 	int maxlen = get_loc_len(*(u32 *)dest);
 	void *__dest;
+	int len;
 
 	if (unlikely(!maxlen))
 		return -ENOMEM;
 
 	__dest = get_loc_data(dest, base);
+	len = sprint_symbol(namebuf, addr);
+	if (len < 0)
+		return 0;
+
+	len = min(len, maxlen - 1);
+	memcpy(__dest, namebuf, len);
+	((char *)__dest)[len] = '\0';
 
-	return sprint_symbol(__dest, addr);
+	return len + 1;
 }
 
 /* common part of process_fetch_insn*/
-- 
2.39.5 (Apple Git-154)
