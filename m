Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8723DCDAB;
	Mon, 20 Jul 2026 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544255; cv=none; b=PdzbxaFMdrOva/wh3HoPbJP8+M3zqNpvZlOVT++jNK7TFbmnrDs+I4Cx5GVu2+p2OAoY1FhE8fYeIR50rOllmqZ0CjDUqvr1bkIeSvxUuBK+uNtWN0GdygeZ9G3RMKG/Vz6di1kKetVZjE5sCIjUh1mLdG6XqEMoifzCPlQ23oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544255; c=relaxed/simple;
	bh=1PMfcfVNo+EYFmcwkHRrP8vXKS9gzrg1aqxHd+IOfNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YyN3MsVMdWDzsvQH0f+cR/PxbLlMiLlwOB0WvEWOd0dXp/22IIOhEaXPLnPxvWBtMUAjE7y49XlpUMdyXhg27yE5Vp/6cq3XPM7W3Er9OTXNQkfjx5nxKPMLQHbg9CZ5Ny0U3IZYTlCr49+1GoWb+iNgsFGDMu/0vmwZGpLz284=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpO0lpr+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpO0lpr+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257C31F00A3D;
	Mon, 20 Jul 2026 10:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784544241;
	bh=yaNa94Ge2NX6/wJoRd+5oweC6fVIPAVHk59DVlRbaaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QpO0lpr+5hEYYTdCvTGl6RF46SlEQN+Mm5ZIDGAW9I8y94wYlfFOOPGL9cfcqI7JP
	 eiIQsgRf32RlmexGVjuwNQrGhJsswkgShuBNjlCUn03Ddi/UCr7H36zscKaQdQ86yS
	 AgGFaJ2L4zo/VD6OLkv/PLvmMSC+KJwOkI6rKWg9sC3ruCwt2y+YuC4pWNmlWY4zND
	 A3attoZkqWKuuze1snZj7Ux7Y1RulE7Kt1Sm8xA47Vd9khOTuawzpDvLMzCx2FvcCa
	 3N7Sp0nB+ItHyPAhmJmHQonmnSJqaQsuC4fsjwLG2aZgdR98UHf22j71hFozPvNnyv
	 kJGw21SDC18Rg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 03/10] tracing/probes: Remove redundant bounds check in trace_probe_compare_arg_type()
Date: Mon, 20 Jul 2026 19:43:57 +0900
Message-ID: <178454423769.296567.6694636865644203423.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178454420994.296567.10239174745865301350.stgit@devnote2>
References: <178454420994.296567.10239174745865301350.stgit@devnote2>
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

In trace_probe_compare_arg_type(), prior to entering the comparison loop,
a->nr_args and b->nr_args are checked for equality. Since the loop
condition is i < a->nr_args, i is guaranteed to be less than b->nr_args
inside the loop.

Remove the redundant (b->nr_args <= i) check.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 7568f5e68de7..91ba4490937b 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -2770,10 +2770,9 @@ int trace_probe_compare_arg_type(struct trace_probe *a, struct trace_probe *b)
 		return b->nr_args + 1;
 
 	for (i = 0; i < a->nr_args; i++) {
-		if ((b->nr_args <= i) ||
-		    ((a->args[i].type != b->args[i].type) ||
-		     (a->args[i].count != b->args[i].count) ||
-		     strcmp(a->args[i].name, b->args[i].name)))
+		if ((a->args[i].type != b->args[i].type) ||
+		    (a->args[i].count != b->args[i].count) ||
+		    strcmp(a->args[i].name, b->args[i].name))
 			return i + 1;
 	}
 

