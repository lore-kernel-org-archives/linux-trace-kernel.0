Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59613AF675;
	Tue, 28 Jul 2026 23:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785281402; cv=none; b=SqHH3p4stTFL1Xh6+SCQvkWYFzHa8iUOIwAA+sNGi0nEsfJQBnXSRoAKW1Z5m/bGhEzBjLE659jHXqJSnHATZYb8mnaCzgI4jw+GZIJpbJDBUrYdHyBxki/9292Yv7RAxC5l9cLFaUj1Vlkv4IeZnN/H5PgEi8PgMLHTNDgAI0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785281402; c=relaxed/simple;
	bh=FgpS9+QPklEXlzy+WfiP4U7Amx2mASPaCrmoX1TXl/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k/wQsKuo/U4Ju8IluKw/z3yQPw8Fu6ydNpFJyWNzaaJaoqqRdhS65a3Ga+xSmNe8bBmyJHjKtEhBsVcT0c5VPyfafRQvmPiG1FYSrKFXNSNEk+TFnTiVhrRW5vUN72wqvCjvUEXzxUyFimwM7dcwXeo+DSscS0fBVKBGx4j5IC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEAEawk8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEAEawk8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4BC1F000E9;
	Tue, 28 Jul 2026 23:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785281401;
	bh=wbaULLWznHC4hug1EZ2OwF3FsKQp7Yyl7ZPgwbsi9cY=;
	h=From:To:Cc:Subject:Date;
	b=YEAEawk8NAj368aPgWg2Sm6f3fUKIrWaCPjbd+MaxnK6TKmOPIAT6K1r2V6IboW0T
	 fvtNzkjbLIawG9E7XwiVHgCIjc+d5V/nOqf/yyIiW28usrpAMY58tqTLDeWmXTPUD+
	 cGl/ynWB42rGFWqT5g+g2XfxWj6V5/vvNiPZyEHdR2hCzWQnt3wnD6+UdFUhl8Qj1h
	 RMvlSwtErvCAtqbcCx6Eg/wWskRfY3/gAGNznHSoFC/bvg1H17w+O7yF2AlPt3HO1S
	 +hmKR3v8mXpRwLRO86k+kYnVtzpn/fB0cMKhxvqJ4+U7wetc78FVfVt77v74qH8uuy
	 +bdpac9AD+OTg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] fprobe: Simplify fprobe_remove_ips() by reusing existing helpers
Date: Wed, 29 Jul 2026 08:29:58 +0900
Message-ID: <178528139798.102586.5349128066643420018.stgit@devnote2>
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

fprobe_remove_ips() manually duplicates the unregister and filter-removal
logic for both graph and ftrace ops. Simplify it by delegating to the
existing fprobe_graph_remove_ips() and fprobe_ftrace_remove_ips() helpers.

Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fprobe.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index f681015413b8..54256586fde3 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -464,15 +464,8 @@ static bool fprobe_exists_on_hash(unsigned long ip, bool ftrace)
 #ifdef CONFIG_MODULES
 static void fprobe_remove_ips(unsigned long *ips, unsigned int cnt)
 {
-	if (!nr_fgraph_fprobes)
-		__fprobe_graph_unregister();
-	else if (cnt)
-		ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, 1, 0);
-
-	if (!nr_ftrace_fprobes)
-		__fprobe_ftrace_unregister();
-	else if (cnt)
-		ftrace_set_filter_ips(&fprobe_ftrace_ops, ips, cnt, 1, 0);
+	fprobe_graph_remove_ips(ips, cnt);
+	fprobe_ftrace_remove_ips(ips, cnt);
 }
 #endif
 #else

