Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268888;
	b=d+9ko7vw2qDxqeSz5yMah8mCt5CwE1Up1yy+VVia4Ffhk540Y+yuScd9dXB86liqTOOn
	 PHeH47FTaejQQD9gU4ERE8Mzdd6bMRBhHJAb5nIruhZ9yDdDV4iQhkLiR4rdHM5H0BX4O
	 kSU5aLOoN3sipOo4NVCSzbW9rpYlxYp+yt8mRbr5rgWXBdTN9BWk8BmtSSfjpRbH/iklc
	 3ZTVeSLySdA0gZz6BSLgcN6Bvcm3O2DkrdikrI50mvJFr+tmrB23OZQjr7gjFA0Z1MOUr
	 jW9DpwSXKk7k6uIunijsvTlv9uvTkvjIufSL0f/7obtpXsHqX3J0uM05WjmNQ3DMNlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VK1Ajtb1JXJ00kJiwUwM1nXOM+V+pGWIbXtB6G+Jxho=;
	b=cGGKF/2TSlx9SOt09H0C3SSd1ykw61OJj0igMG9KUjI7+q0rEEqdIy23PS+LdWfDpiSa
	 WQ90pD5rgjNz5ixk519qaM4ciO/yRYrcESMJ6kH7YSuu15SNiwQkg5pB3HwBu21z/m7Gn
	 3M9o/IUnJ03dJVD6dNJ3wBtQaMvKbEpStZMey68zXC1Am7STDfyWLMmigOHPn5kHEdN5M
	 9cCOLE9qBYlfthTx4ddZWcrJgXBhF7AMEznCvPExzKBXkJrB299rqC7i4zJgXnxtP8nd/
	 1bnNVYBOQmJZX47zB4adPf5brWXl55V+jUtcZBnRc5vg0jA+4kdsBKelyPF8AZKYVmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="tb0O/r9O";
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E63606A330
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 00:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8E63606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tb0O/r9O
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-85a5455bd3cso801293a34.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Nov 2026 16:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794268887; x=1794873687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VK1Ajtb1JXJ00kJiwUwM1nXOM+V+pGWIbXtB6G+Jxho=;
        b=tb0O/r9OyvoAv0KHGRmVWCywslO6XIObZiqHc2UYQhw8FrZu/x/l3YHOAIFQIlqow7
         kg0gC9zDUMhnqWSq6bkd7vZPt2gcr+l8fdSGzDeGWzO4PWytryT0PRWFtXJFmpusIwmk
         wPCb3zTlf81s+5v7QHLBY0rWxxDhFLcz4XDYe6qZvwUNkdC2JIwoz3E2vs2v+QxoOnqF
         1+WHooV6n0QXCXotvew0elleVd4UexfxHgpC2Nu2yau+VLq1PqRVQ5itgTRiQFHlV9lk
         CnwUB/Hj0WCJ56O3HRCB8hL9X/kMTw9x8EbNbDD7UR8Yi2ZOi3jv2OfVpWLGmkE0ybZ0
         8IYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794268887; x=1794873687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VK1Ajtb1JXJ00kJiwUwM1nXOM+V+pGWIbXtB6G+Jxho=;
        b=Ubmf4UxIO2jy5LnJV2xbFhC/ZI/plX5lVUN7gc3Cx3eKhmcMi+j0WYJ21rmB7qGgyp
         n5AhyAhoFVKMArK1Z7bHOVDNhD1MbucFouNTelkgb1pwxsFCtb/sPv25RUD70sIe5M4e
         5129SjY/E0GuXOXhZJeS20n+5IIZjU/N2Ybnvhf5imF28eXSRHFngJM1agIby2OkZ5v1
         iZfO4cFP6uYuntqvmQ3QfFjzBrHeJwRk21wf4124MOwVY3fmk5Gh/X+2yTwmWzaQjJgU
         XPpEjR+Y58dp96Cj03Qu8cCDqBgmK5TuzX6OPYI/mcKUrj3T+Bm5umU5zp+upST/9CP1
         0ckw==
X-Forwarded-Encrypted: i=1; AL+hErE9jBZ3enB1P3EHBXPKHTMz35kv71CVRVSyQaxemL5Z2ld7euEtYk7tTOk4Rq9xTdR49UZnuKybELzjREYgEUAj7L0=@vger.kernel.org
X-Gm-Message-State: APuU4Z87rUaU0aIDXrAjk3mWkZqK+0gPU5QABqHYaTRkfv8q88e0Ad2x
	hQczjoWmFz1HJwWXFFDnV8SMfy0MYBrjaUWd1bqOukdK88E5dM2XH5Nn
X-Gm-Gg: AYBFou1k3c5uKRtLTyiA1Ygpdb8wxfWLq/XcVNJLy0/iPr+wYa8/PuFopl8JgHMAM2z
	iK6zuMXgFJYWa5w0gpLxakmaCXKASjOPdfyZRwRYrXYpX00p28HXMnhKgMcZP2uhCEAx76Esock
	yvBTN2wEEyIqk+s8Mw4pbOeg5JcRPlWJ0NpPMuQ/ipDegMpzCcrUAs01isbKERC9yiJTLVebr6W
	iWHgTsLLG3GOZoW+7J95XRQl20E96ja3EZ1HiW+q3o+gvm3pg3mR0pomqQcsFv1hstxBys1J/na
	+OeQUD5ciqGUBWG4R3xe38Bo6g6mHBM4Vmwiv/zyipKo3EDx9/1SXEwbgjPac6c3KBUKPfsjLWp
	ylJo9WPtZKRNhdDmvp6KdhO/N+HaJTEX2X5go/POCi640/YmZ+J/wQaxKRx5ykd05Kx6HZEiTxi
	tMclQIHVZ0twEon6kEDdn/UzgN8dDyJB0nrjXtA65oBAMdE7U2tQzecbB38V6cJjTDUjykU9F1x
	p+8QkhAEPBpdmirJLMKwJCldGJscXFiZGR5d+m7AJjTHvp8LAnLZ1z+oJ3B5pCuCy03ONAnBlOI
	5l2WgFscFBQ282oB3SqNB01muJjMZASZL7xXzD7vR2g=
X-Received: by 2002:a05:6830:314f:b0:845:3cfe:5f1 with SMTP id 46e09a7af769-860dc70cd52mr843968a34.5.1794268886839;
        Mon, 09 Nov 2026 16:01:26 -0800 (PST)
Received: from sheng2080.cmix.louisiana.edu ([130.70.15.5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcb5f7b4sm625492a34.4.2026.11.09.16.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:01:25 -0800 (PST)
From: Leizhen Zhang <lzsx618@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leizhen Zhang <lzsx618@gmail.com>
Subject: [PATCH v3] tracepoint-update: check the section end before reading a string
Date: Mon,  9 Nov 2026 18:01:17 -0600
Message-Id: <20261110000117.1720256-1-lzsx618@gmail.com>
X-Mailer: git-send-email 2.34.1
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

for_each_shdr_str() evaluates strlen(str) before checking str < end.
A string section always ends in a NUL, so the last iteration always
steps str to end and then calls strlen() on the bytes just past the
section. This is not limited to malformed input: running the tool on
the vmlinux.o of a plain defconfig build, as "make UT=1" does, takes
that path in both loops that use the macro.

It does no harm today because what follows the section is another part
of the same mapped file, but it is still a read outside the section on
every such run. Check the bound first; the loop is otherwise unchanged.

The problem was found with ASan, and the analysis and fix were
prepared with the help of an AI coding assistant; I reviewed and
tested the result.

Fixes: e30f8e61e251 ("tracing: Add a tracepoint verification check at build time")
Signed-off-by: Leizhen Zhang <lzsx618@gmail.com>
---
Changes in v3:
- Dropped v2 1/2 ("do not reuse section pointers from a previous file"):
  Kbuild only ever passes one file per invocation, so no real build can
  reach it.
- Reworded the commit message to say where the read actually happens:
  I checked with an instrumented copy of the tool, and both loops step
  onto the section end when run on a defconfig vmlinux.o.
- Rebased onto v7.4-rc1.
- Replaced the Assisted-by trailer with a sentence in the changelog.

v2: https://lore.kernel.org/r/20261008164117.3670267-2-lzsx618@gmail.com

 scripts/tracepoint-update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/tracepoint-update.c b/scripts/tracepoint-update.c
index 5cf43c0aac89..c70c0b076554 100644
--- a/scripts/tracepoint-update.c
+++ b/scripts/tracepoint-update.c
@@ -74,7 +74,7 @@ static int add_string(const char *str, const char ***vals, int *count)
 #define for_each_shdr_str(len, ehdr, sec)				\
 	for (const char *str = (void *)(ehdr) + shdr_offset(sec),	\
 			*end = str + shdr_size(sec);			\
-	     len = strlen(str), str < end;				\
+	     str < end && (len = strlen(str), true);			\
 	     str += (len) + 1)
 
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.34.1

