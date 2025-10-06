Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0AF126C05;
	Mon,  6 Oct 2025 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744038; cv=none; b=CL0xBRoUFIzlEnt0VI4vD1EdgW8kP4toboPqrr4c8vbAZlvkg+bCSHPAyZYXdkwYYOz73h6pC0D4VSDVHeKXsAiLTj2XosyPQXrn8ojoLH5yCrsjSSGGUcNSpzmvFAv5rEbqmGg8rg7Kt+LZ/lOqmxbdwTiqIcbcTLn7QvF7/LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744038; c=relaxed/simple;
	bh=QhzIG03aHboFObiRBtxv27Nts9zZSF/gkbUUOv91YoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jqicyFF/ZKVReZ0FcrHZXnvrs5H9UHY5TkZ0YfFaJTXFWyLSFdSeOIJMQZXbxX0aymwxsyy3ZCenKZcuOkGfTtleGz0+vBZWWN5WojUrLN1Emq+6PryxTqfLYccOps1LP9tp7Yyjaji0sGqtjKPUk7EWiZMJy5IKWlg2AOJg/Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kInQ3g7r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kInQ3g7r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFBBC4CEF5;
	Mon,  6 Oct 2025 09:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759744037;
	bh=QhzIG03aHboFObiRBtxv27Nts9zZSF/gkbUUOv91YoA=;
	h=From:To:Cc:Subject:Date:From;
	b=kInQ3g7rmAPmJlKrHwBOT+EO6DFomMRjCDB1xhOjl+UTuHhoAgUFOtYfacsoy/fbx
	 Mvi8z6wk2hlyxcxtBHvOqwkB8IZUB6mOAffoqbG1gHrD9tQ/BWwpaDFyEtsA1xCMWT
	 058bjMrpx8Qk94S1obLFE3znGxvJ0uYg+qMPw/LhNMVl5BPkGL/eOj6tpMZK/wb0D4
	 1TcrkZn5jT/6yktfDtzvWrcVPKdw+/eo9LJuBiEUFGRTK5ViLyDdqoh67rSmMjofML
	 B9Voa3Ud+sdTgat6SwnysQu95EE3DFl/u+APycvloYjAMgnKRkstKkkdqHKS1dEQzA
	 MaH4biIQdcElQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Brown <broonie@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: wprobe: Fix to use IS_ERR_PCPU() for per-cpu pointer
Date: Mon,  6 Oct 2025 18:47:12 +0900
Message-ID: <175974403177.1372080.12078001360837326466.stgit@devnote2>
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

Since wprobe uses IS_ERR() for per-cpu pointer, it failed to build.

/tmp/next/build/kernel/trace/trace_wprobe.c: In function '__register_trace_wprobe':
/tmp/next/build/kernel/trace/trace_wprobe.c:176:20: error: cast to generic address space pointer from disjoint '__seg_gs' address space pointer [-Werror]
  176 |         if (IS_ERR((void * __force)tw->bp_event)) {
      |                    ^
/tmp/next/build/kernel/trace/trace_wprobe.c:177:35: error: cast to generic address space pointer from disjoint '__seg_gs' address space pointer [-Werror]
  177 |                 int ret = PTR_ERR((void * __force)tw->bp_event);
      |                                   ^

Use IS_ERR_PCPU() instead.

Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/all/aN6fTmAjD7-SJsw2@sirena.org.uk/
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 - Confirmed that `make allmodconfig && make` passed on x86_64 and arm64.
---
 kernel/trace/trace_wprobe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
index 4b00a8e917c1..aa8ef173528b 100644
--- a/kernel/trace/trace_wprobe.c
+++ b/kernel/trace/trace_wprobe.c
@@ -173,7 +173,7 @@ static int __register_trace_wprobe(struct trace_wprobe *tw)
 	attr.bp_type = tw->type;
 
 	tw->bp_event = register_wide_hw_breakpoint(&attr, wprobe_perf_handler, tw);
-	if (IS_ERR((void * __force)tw->bp_event)) {
+	if (IS_ERR_PCPU((void * __force)tw->bp_event)) {
 		int ret = PTR_ERR((void * __force)tw->bp_event);
 
 		tw->bp_event = NULL;

