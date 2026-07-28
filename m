Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469023191D3;
	Tue, 28 Jul 2026 23:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785281259; cv=none; b=ftR4PqxaiZhXRsadwcbB5/5GpOHdnk8AZzAbk5WFfIBPUaC3xJl4t4Em0Sv/5KrtO/1ZmQPRYzvhaOUrIkh+CT5FvETifhc2Au2xmXPXVu0CpFj/jrO9Zt7Lrw3Dy1bWpf+aByFbNp6FNNfKjrviVbjHLAV/cH5nGxUJ8L9KtMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785281259; c=relaxed/simple;
	bh=FPUAhRy1Lg5r1kCglLpIH+5v8ou7nKZzbwQjRKR9JRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AvcBpMfxJuzOWgrbHYa+M3WofdHhK7nmR2Y1Rf7/e3NrFUBNDzOuLV05ELuTOPzlZKcDRpiL+uL9lg1f1GewsIJvqksLoqMBmidAdB8L9a/z6TO8Yn2SIhZIQtc1l1jnqLl+vEuZuJdmrAAHCGV7tP5rmgWzXD67n2OuLO5JziQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIyOnCXk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIyOnCXk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863961F000E9;
	Tue, 28 Jul 2026 23:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785281257;
	bh=WwQv5SbnA20kgb0TtmC5to+oBwGXDAcSoVI5dnvlCqA=;
	h=From:To:Cc:Subject:Date;
	b=kIyOnCXk2dxlLJ6hRWMTnTYp8jV7NBObOG9zru0xIB7eoOTR2Bcdm9ih82BiCzaN2
	 5svqDql2X7yRAfe2a0JOlkBkogc0RlQL7MBTimt1ZtV7k13TswdoU/9KcWk+SJ3ecf
	 JDGQQEbSXkAWRSewo61taYc7iJlXwTNGVzSsKTr7VYZ0AEbdBZ0RW1DLcbtBDolghv
	 PpLei/o2qZVJ6DIuCTU3W+R4l40j+XsDug6gFIuQITWweuEK/OgRHSdJVkcMdVQWKl
	 cuyH/zE764dSaHZ0Jsnu59AO5DS9+r/xfxPY5qbZqsZudUQGv6wqWi3KNNrPurIjF6
	 6Gx/XpxiVq5ww==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] fprobe: Fix module reference count leak on error in register_fprobe()
Date: Wed, 29 Jul 2026 08:27:33 +0900
Message-ID: <178528125360.101985.4144133640239273153.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

In register_fprobe(), get_ips_from_filter() resolves target function
addresses and increments module reference counts via try_module_get() for
symbols in kernel modules. If get_ips_from_filter() fails on the second
pass and returns an error, register_fprobe() returned directly without
releasing module references acquired up to that point.

Fix this by ensuring the cleanup loop executing module_put() runs even when
get_ips_from_filter() returns a negative error.

Fixes: d24fa977eec5 ("tracing: fprobe: Fix to lock module while registering fprobe")
Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fprobe.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index f215990b9061..f681015413b8 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -961,10 +961,8 @@ int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter
 		return -ENOMEM;
 
 	ret = get_ips_from_filter(filter, notfilter, addrs, mods, num);
-	if (ret < 0)
-		return ret;
-
-	ret = register_fprobe_ips(fp, addrs, ret);
+	if (ret >= 0)
+		ret = register_fprobe_ips(fp, addrs, ret);
 
 	for (int i = 0; i < num; i++) {
 		if (mods[i])

