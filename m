Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010894E50B3;
	Thu, 17 Sep 2026 21:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679426; cv=none; b=tB/WqQH+K5rO4fi22oTl5sl3uXeBATVJ02qM7jfmjxYvKvlmx+IjdRRlDCT+hf3xuo268bTiVw16N5KHXMTA9C+QhcHgnHQYw8ge6ZeSUt3QrTITgx/p44HSlzF93hhegKZuAVGEs64xumlaWW6MveEtnzNsMOJBR2B5OtmAQbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679426; c=relaxed/simple;
	bh=Qz7wsNBn7X0IRNJQxffHD0+eZ3qZSae3dTtj99C4zjM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VsWTR/dzMfeSN0oS7Ps1j1rX1x8v2Xiz8Rb54tI39VNcoZMrro5SbSzdrgfXTYXaxdogBO3Qbunf+XQOJyxkSVQU8he6UMB9L+XU/7JyPsMohjzyuY87b/JcHZbZjlarocc27n7xFJc7gQpknhjYKqE4Hf+ZZFMpyzULBD3nwB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVJ5XdcR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVJ5XdcR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1BE1F00893;
	Thu, 17 Sep 2026 21:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679424;
	bh=L/Y01rtw2Oa+Vy9CCrV4xDyr+hvwgS9qc/chBYxmU0E=;
	h=From:To:Cc:Subject:Date;
	b=nVJ5XdcR61rgsGMU0iAkviBzIksPhSNQjUjmlUbWs0ZPj/ATrBeJuo09DFcFsBjbB
	 yLhfqdmp84ymo3ox4BmdSC+PcRDFm4UNMBZ/8xq23I8AJnn2X5rbOCLhXrKbZi4SJs
	 G2Kwhzxc3n9ExyRL2AxZCQa53KUEkEoRS/w874xe1JNmEC9V9W/WUOX6z/VADQyh2a
	 LvwGpM43AtQ3rK8QI2SocbsOdv7VIwdluz+Nb7K5tgg9cBANom6roTvcpLbnqzyFWZ
	 hluUfB3HD/T70g4qhulvYQlX2CEstpCjr8kBO+oMjAgKyHxBb6AxIT0/AEClQeEPjN
	 nL5y+/51NSJYA==
From: Kees Cook <kees@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] tracing/probes: Add const to new_argv allocation type
Date: Thu, 17 Sep 2026 14:10:23 -0700
Message-Id: <20260917211022.i.677-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1552; i=kees@kernel.org; h=from:subject:message-id; bh=E+R4+qF8O/jjXRPY3YPnl4j+s4OUrIzo0YyCbGvax0o=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrwu20X78ynMR3tuqCzdVMU/ddnRs/vJNZq/tDz8Q+2 qv0y4wHHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABN5PZnhf2XeDN11txKnTZQ6 9fzhWt5DDtqPXB85FFrXLuKbOHXeHHeGf0YWGU9dFu/qNJyvsbUkhSeoKzfFmYFJpKn8Vtnq974 rGQE=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees+treewide@kernel.org>

In preparation for converting the kmalloc family of allocators to the
type-aware kmalloc_obj family, we need to make sure that the returned
type from the allocation matches the type of the variable being
assigned. (The kmalloc family returns "void *", which can be implicitly
cast to any pointer type.)

The assigned type is "const char **", but the converted allocation type
would be "char **", which is the same type without the const qualifier.
As there is no general way to safely add const qualifiers, take the size
from the assignment target instead. No change in allocation size
results.

Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
kernel/trace/trace_probe.o

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees+treewide@kernel.org>
---
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: <linux-trace-kernel@vger.kernel.org>
---
 kernel/trace/trace_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 804442b2f7d2..cfb710095f65 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -2316,7 +2316,7 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 	else
 		*new_argc = argc;
 
-	new_argv = kcalloc(*new_argc, sizeof(char *), GFP_KERNEL);
+	new_argv = kcalloc(*new_argc, sizeof(*new_argv), GFP_KERNEL);
 	if (!new_argv)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.34.1

