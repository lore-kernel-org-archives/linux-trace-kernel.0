Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565D324293C;
	Thu, 18 Jun 2026 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772659; cv=none; b=feA4wXBmqiR9DNKZRqqxS+TJQSWAydh4do/Zzou66zkm/rR677hGtOYXBvOd8H5RJXiX/ClSrkbOrLdFn3LQXFRXfbNm1IHblaEwIW2Ma0O+0G/Km8xc6LvP6c/VDrdcv3FyGWdv1A6JvMj3NiBMeurz18akyBiKbIkCXe8tsA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772659; c=relaxed/simple;
	bh=4HBpibtGLUpciz6TG2mA95yTyB8PHElQpql6EawcW0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S4lWg+bmMoyr1HZffM8EL3aRuoU8RsKYMINVeOtrYSkbmCNUMTeS9NUTGlLof1hfy/qi1zEfjZgsSxQGjGbajdfeMFw7fASrbw9StVKIhQv0v6ot33KEoJ5nmZprlvOwWt+cdOz6eN8tsLDPvC7ziF4PxSDnK4q+5xuM9C43Hes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpkfPrGN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpkfPrGN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6861F000E9;
	Thu, 18 Jun 2026 08:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781772658;
	bh=L52jn3tunfqYKfQYczv8p9Yf1ZpIZUbw9N7MnzadMSY=;
	h=From:To:Cc:Subject:Date;
	b=DpkfPrGNSc9NbP4gimiuf8UKM5QcG9OjNG6Oc4q0A8YJbox2uGJmGScxqKSpTW8YX
	 pkE1MsPZXJ/QXj0dEQpWczbpmyRQqhxUeTVEFXA6d4EIOCm6EAfROouXuFVy0N6uFc
	 ywjTlB13VFupmJXvQ4ZRQgjHEWrDX5MW03WvA5S/iv4Dl/LRtvE6agPpIRSNhuff4D
	 Hh4gP/XE0kF+bvn9U4Ol8e2WwXseEhS3cyKumNCv4if0atgbxnBYVbJ6fDf/gtm3yX
	 HkKg5JgDjHdaz0OSE5wMPMuQ//ODDOZrtLm/jBx1SmduaMAZ/JNhbol9mn7WTSrFKz
	 QwbwLZMKMAyHw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing/probes: Remove WARN_ON_ONCE from parse_btf_arg
Date: Thu, 18 Jun 2026 17:50:53 +0900
Message-ID:  <178177265367.2059927.13789953014706792126.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
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

Sashiko found that user can cause this WARN_ON_ONCE() easily
with adding a kprobe event based on a raw address with BTF
parameter.

Since this is not an unexpected condition, remove the
WARN_ON_ONCE().

Link: https://sashiko.dev/#/patchset/178165816303.269421.7302603996990753309.stgit%40devnote2

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: b576e09701c7 ("tracing/probes: Support function parameters if BTF is available")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index fd1caa1f9723..98532c503d02 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -678,7 +678,7 @@ static int parse_btf_arg(char *varname,
 	int i, is_ptr, ret;
 	u32 tid;
 
-	if (WARN_ON_ONCE(!ctx->funcname && !(ctx->flags & TPARG_FL_TEVENT)))
+	if (!ctx->funcname && !(ctx->flags & TPARG_FL_TEVENT))
 		return -EINVAL;
 
 	is_ptr = split_next_field(varname, &field, ctx);

