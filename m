Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4031F949;
	Mon, 28 Jul 2025 23:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746427; cv=none; b=lUUd0e7tWxPiPmdnvXAoW76lyBKBB82wbc6sfHs7S0Hdv78LLbJ76q9aR6mmpasYfNqMWtLSN9V5X+rEsAeHx3yOq+mpd2zkHB/f+x74r5aFu+veb/3H/vdlbSVSWx/S6pmG4Gn5klIzY2/UyxMtIapbihw90cjzWFOvS34djIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746427; c=relaxed/simple;
	bh=D4vnT/ZawaVbtxqZwLJwOd+ImNHvAF+a6yRJxVug6a4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WnS+d92xR3jvnldMi385G7Ulnf7u+RjYCpCn8EIgEXp1n4dvcctqseZyNQuWSe+BrI6g2BEMkafIe52aUGkLh107QHf4WhWet3P1iBrw6SxDqCV+nO4BWHDm/NRiDjFeLPVBrQ6kpapb3srVvOSCGStjc/kn8MYu2DNcrad2aAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzqOOOl0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzqOOOl0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DDBC4CEE7;
	Mon, 28 Jul 2025 23:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746427;
	bh=D4vnT/ZawaVbtxqZwLJwOd+ImNHvAF+a6yRJxVug6a4=;
	h=From:To:Cc:Subject:Date:From;
	b=ZzqOOOl0JLQ1Uxhs8M/ZWP8JZqsHxp4rvQ178TXp11PL5tbqneQYcCIUUT2DAeqCG
	 9xkWIft+5rRRFSZSWIPufVfVIR5uNabPYAgSRc2H9W1BkkA6hqz7cS77+QyxdiqTcS
	 FIxVhjEWzYotuLPuwSD4TKM3g+JaU7wwDrCRzC6xLzMDoYkmIvrHsUSUJN25UoHPaf
	 O73jW7pNll1vNxBGzzrwDrgowASduUXZjVVIs+deAL1/QHMO0YoH9z9h2jRwzzuFF2
	 lCN6mMJOMMrhUjbcRn1CuMGLG1Bi7hDCURKmy8iSoWgym+ZjATB7ZnAcNDyo0Ou85E
	 FJNx7IhOf2TPA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: fprobe: Fix inifinite recursion using preempt_*_notrace()
Date: Tue, 29 Jul 2025 08:47:03 +0900
Message-ID:  <175374642359.1471729.1054175011228386560.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
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

Since preempt_count_add/del() are tracable functions, it is not allowed
to use preempt_disable/enable() in ftrace handlers. Without this fix,
probing on `preempt_count_add%return` will cause an infinite recursion
of fprobes.

To fix this problem, use preempt_disable/enable_notrace() in
fprobe_return().

Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fprobe.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index b78fce0982c7..c8034dfc1070 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -352,7 +352,7 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
 	size_words = SIZE_IN_LONG(size);
 	ret_ip = ftrace_regs_get_instruction_pointer(fregs);
 
-	preempt_disable();
+	preempt_disable_notrace();
 
 	curr = 0;
 	while (size_words > curr) {
@@ -368,7 +368,7 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
 		}
 		curr += size;
 	}
-	preempt_enable();
+	preempt_enable_notrace();
 }
 NOKPROBE_SYMBOL(fprobe_return);
 

