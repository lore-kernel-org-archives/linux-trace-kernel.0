Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794496788;
	b=I3IGjUVuvOGoEJIeI+m1uynYrSoYEn14Fku2cLr8KfS8VDW6CbFaqLkEZ7tEdw4CGvs0
	 ve6BuGAdBeNF4G7xfHUJKanPXQydVTujRpOek64ubLzR2kGG4/jQmR3mIFDr33hc03HUY
	 2YQcYuFMfdtapHgi5hnPtGU5VFD1POOqhKS14kBkUjstX8l0B/RSMAuUaLRZGQEdj6qvY
	 +Gv30BlCP2/3fLfwb0qTi4tQtdiWliWfqX7WUqlyfb9hp/exSw92apXtr3R6wsYgVrcj5
	 zOqvcLoX3w6PMHMJU0lmVZxr3DC82ha+Q3W+zx7pjCsthnssIHG0fo8IE6w3wJJm8qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496788;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=03AJzptY//ZjOsx7gciWrj84OyhOQNNWsyWVo7nSKNQ=;
	b=14bbOl8dvwsZIUMlYcQrylQGlivgcwSYmMvr7RFVGvckMVltilP4Ge8SB/hLqzCamPeO
	 FUPIWcHBKJIrKx7RdVh827DjNQfuipeMqtA5/fze15+hiMm4fltzS7B+0wRco+kn2TuD9
	 ASbyhjSJGK3/ggnDo2FPLR6nMOs749R+HGBEODXJGg6TOvSrsLWQ22pRXoMPPnerTHiyM
	 4P15rfYUk7dJdDk1KSEn/XgKDq51MH8pGejrEaGq91s93PqchUdGavwFm7usx5UwKznB6
	 iLOhapT840GCdDsv03MqaYcrvBeOqAVBYNL2uz4qG28nwL2vRLw7UC9llg9JjNiwxcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=jvVfGcJs;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7DE60A2607;
	Thu, 12 Nov 2026 15:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A7DE60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=jvVfGcJs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=03AJzptY//ZjOsx7gciWrj84OyhOQNNWsyWVo7nSKNQ=; b=jvVfGcJsZhkzStKD59dPSOxzNo
	fARmju5vLQ1l8p3aJ+6SapfL8ZtaH4uOxSHv3amdOuAU8fIsh1dEQzLPSXWKnfSmDqWsFPcZYGvh5
	22FXsyN2cBgCKWhVIzpsbWKG8fn07OwZZVgYLaDNbTWu1R9i+V2PC6WKlLVgAzUBEturBwFnlxyaG
	Y/afOsEFeS29O+7PFUWCTXKN00Q28XjntcFUDBaR+nOxuMS4UvoUPXmqevWxi8gAYDrD6GP+oPMLN
	k1lGEgfxQ8NAY+UZ7v4JEGkiJLiPnA0ceB4pDouLPmwJZrXb9v0HkZkvSLwrpooyhMaqGT6So5huo
	O4gWx5gg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRWaS-00E3vX-04;
	Thu, 12 Nov 2026 15:19:40 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 12 Nov 2026 07:18:42 -0800
Subject: [PATCH] fgraph: Do not mark index 0 in every shadow stack frame
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-fgraph-bit0-v1-1-695ad14f4b1e@debian.org>
X-B4-Tracking: v=1; b=H4sIANLY9WoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0Mj3bT0osSCDN2kzBID3eQ042QTC/PUNEvLZCWgjoKi1LTMCrBp0bG
 1tQDiK60eXQAAAA==
X-Change-ID: 20261112-fgraph-bit0-cf3c487ef99c
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2103; i=leitao@debian.org;
 h=from:subject:message-id; bh=UvXPZ58gPt8YzT13/CIaQfnnCc0bbexfQdodr77XTHs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq9dkID+lRC3775ZUeSqACpCKtcL5oXbV6zPLX/
 1kdmxnNOlaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavXZCAAKCRA1o5Of/Hh3
 bddID/4qsiGosEYT5qBMmr7/l8CgQgfE6ruPjtKC+VT8Mnn0VaI8i9F/dro/tVw2ic/ltC4mooy
 v1d/RlpnHfCDrMbiRObumLCLDpKvNdPbfJSFTfEXR/AFCBpEGsn5k61C505OmYi334mn/2mPats
 9F9nFucKoaUSUnOChqAkKsaGtauIIhgS1jNqRbR1LuREtL55qkMdntWfxuQ3NR/cvaUwaCBsCSy
 K0qWwE60srPIU3LEV9EDYAycu23cgSkHETntnGlDRPEQoZM2o3dLKflkiPYfPH2mG4C1cQadfp2
 fGGlhV63wD8Hpu0I8F4kKzEWN7hYpkhW7kCr0my+/1Rl71bk+nvSjzgHU2Uy8peBK14hXYsb5Ut
 6adF14F7cuBdPogJOcUr9vtc64nxNW1Tzw440E88WKDEAlI3RZqWHeM7vakujwyyC0uKOa+DY3w
 ANayqge3PZ3oogYAz8wP+Oi0dXtCt3GfPw3GGAh0zKyMH2vR7+Kj9bGPMnfzv+UbPvWiUxSg4nZ
 ibO+yRIT2ijkCrvDfSeqGYPP0oHM5LX90x91wNzaxeOLj5he4pXFERAZQnUyFDRiHUKpJePrjAY
 ARFfU+I3G6MgHDyiC8A546IYMgx97yFm7VPw8lvikmaR5uHQaD0hoghRvklY1tScP3EVHTp4edT
 gIgzZYLsNWQ1lPQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

We are seeing this warning on an arm64 host:

  WARNING: kernel/trace/fprobe.c:676 at fprobe_return+0x260/0x2c8, CPU#16: FuncSched/3281330
  Call trace:
   fprobe_return+0x260/0x2c8 (P)
   ftrace_return_to_handler+0x2bc/0x5a8
   return_to_handler+0x20/0x48
   futex_wait+0xa4/0x218
   do_futex+0xb4/0x1d0
   __arm64_sys_futex+0x15c/0x278

The theory is that function_graph_enter_regs() sets BIT(0) in the bitmap
of every frame, a leftover of an old tail-call check, while the return
path calls the retfunc of every set bit.

A reproducer on linux-next supports the theory. On a fresh boot, with no
other fgraph user yet:

  cd /sys/kernel/tracing
  echo 'f:fpexit vfs_read%return' >> dynamic_events
  echo 1 > events/fprobes/fpexit/enable	# fprobe_graph_ops: index 0
  echo vfs_write > set_ftrace_filter
  echo function_graph > current_tracer	# function_graph: index 1
  echo x > /dev/null			# WARN on vfs_write return

Removing the bit was agreed in the review of the series that added it
[0], but the line stayed. Drop it now.

Link: https://lore.kernel.org/all/20240527093436.7060d358a64cc2ea3213b07b@kernel.org/ [0]
Fixes: 7aa1eaef9f42 ("function_graph: Allow multiple users to attach to function graph")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 kernel/trace/fgraph.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 6d87143b3ddb5f..a674874e6a05a6 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -700,11 +700,7 @@ int function_graph_enter_regs(unsigned long ret, unsigned long func,
 	if (!bitmap)
 		goto out_ret;
 
-	/*
-	 * Since this function uses fgraph_idx = 0 as a tail-call checking
-	 * flag, set that bit always.
-	 */
-	set_bitmap(current, offset, bitmap | BIT(0));
+	set_bitmap(current, offset, bitmap);
 	ftrace_test_recursion_unlock(bit);
 	return 0;
  out_ret:

---
base-commit: aaa2f954c21b205a0bcd0961e5b2be4e82e58455
change-id: 20261112-fgraph-bit0-cf3c487ef99c

Best regards,
--  
Breno Leitao <leitao@debian.org>

