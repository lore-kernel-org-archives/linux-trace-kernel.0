Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794473443;
	b=hlt4fPl5faPZONew4U03b9CP/4UUg5ozn2HDnNdHo15O7f1hjuq0e62dNKx3FIzzTLbD
	 emuI3xq14AmlNH1E+dT8p96HXprMYrXNzNAoHbZnefV2BSASlVUgiLSCJY9ZZQl2vCV06
	 mtK8aT+aPq+3Ug5PZaNxdh8zY2ieXb7nwSSqoml8P185XNqO/Vd+Y8ziHpWDzG//fybC4
	 7bWppn4l04qLftdfATg32VE6ysMsSbDpmhq2ArkYrLt25JICs774OjfkoOQKfbLCY3W2S
	 5ul+EAFK3j8URJ8W0v0GUzck7RRcIZ/2t6JUrGewiuVkw9QcPWpt5bjJO0sc/VlqHBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473443;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META;
	bh=Jl6qvweGQpW+nbs6axEr2+kW3talX+zQg1ftatVYsHs=;
	b=pRsj9AR8KACMD9OtMphPCCsf+GaboSOjBM61vXHMXOcpNjDwKfWx1JY/bbiDphJ41bfO
	 Rq3/HJ+n8OVRKctlfeY3jMk+nOrtfVxql88456udubbqRPj3G50c4/+/LjEH9J4aZ93Y8
	 S3vDNg66p35i362ZFGBsiQ+y1mfVN0cH5vSVnxNgiCYsn4wDEtxR7hjXtEAgrurZ74LfA
	 eWR1wPOxBmEx8gcJwh548qQAPJUyTQWs9l6c9CMU3nEjX/SaPmE5jyJSZK8NdfR9E5gy4
	 ftjLPw0jbvOpUawWnv0CuOZxwTE5H5jxof60V+fKotGTZ1uUbPSSE869XtJXYkGYTlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=o1+ctg3A;
	arc=none smtp.remote-ip=80.241.56.151
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7165E606A323;
	Thu, 12 Nov 2026 08:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7165E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=o1+ctg3A
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jQDcZ3V5jz8scj;
	Thu, 12 Nov 2026 09:50:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1794473438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Jl6qvweGQpW+nbs6axEr2+kW3talX+zQg1ftatVYsHs=;
	b=o1+ctg3AI8mAuDCIAekF0xijzSx8q/PNpGDgu/XD/6NaMvyv9KWODOzBW5mwvew57Sau0T
	5gQryaRnse9hE4/Su7IXk6oOgkOcDse6qI4B296/APurNYArbqRhwhxYqUENsPkqzqN2LB
	1vip+Qz6qrT2YjWVstbOlvb+Gh9tmwOd3ECTq3CmUVjiIW514r0HavXPKndaXIzmxMxeRo
	dDdmuHgEXeCJiUN7/RbZE9eM9ZfLlj2P0nql8qfpKkdgigIhDjVz1Uq2406c1jYd0BxmzC
	0WM0Hz7M8y9I/ZVwdPBkD/0PELsbp9gPEYKmJ5W6Sllrz3QcwofCYR7il64/Tg==
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH] docs, kprobes: Fix bracket
Date: Thu, 12 Nov 2026 09:50:16 +0100
Message-ID: <20261112085017.690228-1-manuelebnerli@mailbox.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ecb4fad61c4526f25ba
X-MBO-RS-META: cpakoubau8wcpqht9m9798awgf3c1z4d

Remove needless ')'

Fixing: a1dac767622c
Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 Documentation/trace/kprobes.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/kprobes.rst b/Documentation/trace/kprobes.rst
index 19c04a91a6..91b76ed435 100644
--- a/Documentation/trace/kprobes.rst
+++ b/Documentation/trace/kprobes.rst
@@ -31,7 +31,7 @@ can trap at almost any kernel code address [1]_, specifying a handler
 routine to be invoked when the breakpoint is hit.
 
 .. [1] some parts of the kernel code can not be trapped, see
-       :ref:`kprobes_blacklist`)
+       :ref:`kprobes_blacklist`
 
 There are currently two types of probes: kprobes, and kretprobes
 (also called return probes).  A kprobe can be inserted on virtually
-- 
2.56.0

