Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620731;
	b=3sgCL3LbuKJaiweoJcQA3pIRMO3Qh76yoq2onEhuECOPxPr0aZeB9squ5DW2XoAFAFPt
	 +1/CEu2+qrUMSm72QGP0i3W5GiuspKJyd49Zyn69ZdGRyyaOMIBd/rEo5hEfn3xsN+75V
	 ixtw3eqy1HvwR+iIWDTGqh/LugFTWT4Py5EsxmNer7ZMK4rsCZCsMVEsClZFlCrwgLXW8
	 xtRGaOQSAMKFFsz1Zhfjyz6Bjo2QQWbP3CJUDmT7Nelw25ZJ8R96mvoqMQDxBtrBxBjaT
	 gboL992o+7oYODB1rPXIkaC+MpLMyEAqUfQEM/kUbjxhvB6MWVjh9w9xkC9+jBSPOWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620731;
	h=DMARC-Filter:Received:From:To:Cc:Date:Message-ID:Subject:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=i5cmHvfXLdZBdMByLhBUfZ2DbfSzX2Epd4emD2ZoKDY=;
	b=u43YtS7oK9yjfeLb7aSWpbmGUXJIYJf6gDXmJzZ07BxdNUHXJo539rG45FjnOYQigu5v
	 vwdxPw46D1KeNAzX2TntDp/cgkENqIIA2AUcLjPhfTJ5CFYyqnyfqI17ARB71TXUK4fv9
	 B6zGmaKs0YFTZNhjnZS8StrUIFSSqxI5klz4KlkvFqZxXusKySO94SeylAiPTKW3NrtDl
	 1LXczKOIJ944QSlIt88Xr8nTiX0pho+91fbjAId0N7hyw2fUy7D4Zp2MRbnG/SvK0bEL7
	 5qdTyo9aTv32AnAFJ+m9G3uPxXK9rBhXSKgRxlbWs7ZsJwlBO5OZNx98d3DLvf01fag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.pku.edu.cn;
	spf=pass smtp.mailfrom=stu.pku.edu.cn;
	dkim=pass header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=TzCkBE13;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D1160A380D;
	Mon,  2 Nov 2026 11:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4D1160A380D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=TzCkBE13
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [1.202.162.49])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5330b2354;
	Mon, 2 Nov 2026 19:58:48 +0800 (GMT+08:00)
From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
To: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 19:58:37 +0800
Message-ID: <179362071772.29269.13958672165986396737@stu.pku.edu.cn>
Subject: [PATCH] tracing/probes: bound symstr stores to reserved length
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa19c20598f03a2kunmab045f0fe84f1
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTUIeVk0dQ0hNTEgfGUJKQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKVUlLSVVKTUlVT0JZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0
	xVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=TzCkBE131avBU6on1nlymdE8MAzi1A0nezv226BFiU6xLF66wvZVTldPixewN9hOtX1vAfG7NVFu+FWT9KCQ6X4fPGQanBs1GLir5G26zxGgvR74+PzvRP2KVaUvEy5d9p6rSBux9PupaNG8I0qhezja7sK4mcDPtW2JloJilUM=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=i5cmHvfXLdZBdMByLhBUfZ2DbfSzX2Epd4emD2ZoKDY=;
	h=date:mime-version:subject:message-id:from;

Traceprobe calculates dynamic string sizes before storing the values.  A
probed pointer can change between those passes, so fetch_store_symstrlen()
can reserve space for a short symbol while fetch_store_symstring() observes
a longer one.  The store path reads the reserved length but ignores it and
uses sprint_symbol(), allowing the second symbol to overwrite the trace
record.

KASAN reports:

  BUG: KASAN: slab-out-of-bounds in sized_strscpy
  Write of size 8
  sized_strscpy
  module_address_lookup
  __sprint_symbol
  process_fetch_insn

Format the symbol using the reserved length as the destination bound.

The patched kernel completes the same pointer-switching workload without a
KASAN report.

Fixes: b26a124cbfa8 ("tracing/probes: Add symstr type for dynamic events")
Signed-off-by: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
---
 kernel/trace/trace_probe_tmpl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 8db12f758fdae..cc317cb444e43 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -95,7 +95,7 @@ fetch_store_symstring(unsigned long addr, void *dest, void =
*base)
=20
 	__dest =3D get_loc_data(dest, base);
=20
-	return sprint_symbol(__dest, addr);
+	return scnprintf(__dest, maxlen, "%pS", (void *)addr) + 1;
 }
=20
 /* common part of process_fetch_insn*/
--=20
2.39.5 (Apple Git-154)
