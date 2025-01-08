Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C3615B99E;
	Wed,  8 Jan 2025 01:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736299453; cv=none; b=mcAvutBM/4UEIBXcvDE5qwzC4BmBI24trWmnKlnDlztNc1z4xM3/Q/8kEh2lyW4rF5saan9EjKuWIv2Dnz4yPt/YcGR7nFAFHpg68MSWX+GN1TeamqN/+KY8EHcPSGJhAMJGbAgI61XXSGRh6sT3bqFkyHEcRlJvFY4gKV/5iWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736299453; c=relaxed/simple;
	bh=6QyVNa11BsehG9ROF+5/Jw9ETQ4uZvxVJBFzAmC3XNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FdrlVdDOT8PG43fDJoMrMKyB8DY2Anduu1zXFfrEKa2pnPljveT5Bxml0rLbVmhulS51qtv89sueCsJj/p24CPDsxShgkyVi6s//saFRvMxLJ22hHQ18l/GQid6DFDVhNuN6qLTEp64hp/MDzz+dQuY2A1yD3s/c7++A9P/F8oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IavwcxY5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IavwcxY5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8437CC4CED6;
	Wed,  8 Jan 2025 01:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736299452;
	bh=6QyVNa11BsehG9ROF+5/Jw9ETQ4uZvxVJBFzAmC3XNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IavwcxY5GGttsxg0/MkWg8pkyfppisZvGocCJILIVVGQ7IJItUbAx0APjfh3LIo/x
	 W5HUZd/qAjJs/H78oCfJwR4ZJNrnaXvh4zyECMJmNFx4HC5PlfCTSwFHOM2BbsmeNi
	 n6H1aq8Amh/YAVb6F+al1bQjfMpK7iqwJ/YvZ97AKgeHNmb1DaGu7nuGJwTbRVTWLc
	 e/Oxsx4Sc8CiuZTOO8d/VH64MhflGLWXO0LBSlFz6N3Byf5AVjgJrLX8SHYk/O6Qye
	 nnM25LnNIAWuaRpJpg5dPCcgYiZYM7SVWIqbc1Fb6nFkf4kl5SRIuqeYsfyOfgtaoZ
	 3rEOhtcg/bQHg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] tracing/kprobes: Fix to free objects when failed to copy a symbol
Date: Wed,  8 Jan 2025 10:24:07 +0900
Message-ID: <173629944700.1450013.2866967127814543723.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173629943548.1450013.12412761424554510119.stgit@devnote2>
References: <173629943548.1450013.12412761424554510119.stgit@devnote2>
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

In __trace_kprobe_create(), if something fails it must goto error block
to free objects. But when strdup() a symbol, it returns without that.
Fix it to goto the error block to free objects correctly.

Fixes: 6212dd29683e ("tracing/kprobes: Use dyn_event framework for kprobe events")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 263fac44d3ca..fb9d4dffa66e 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -940,8 +940,10 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		}
 		/* a symbol specified */
 		symbol = kstrdup(argv[1], GFP_KERNEL);
-		if (!symbol)
-			return -ENOMEM;
+		if (!symbol) {
+			ret = -ENOMEM;
+			goto error;
+		}
 
 		tmp = strchr(symbol, '%');
 		if (tmp) {

