Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446920;
	b=gBV6i5Ia8qUFk5npXaouioYRUcHLpxWS7AuA6HR/CoWXvOO1earVlMXXm0p7FHePnQIA
	 vGgwAPiPZ6zoIyO6sSmVtn9iqRJkMAq3d0Jt61biRrDqSUBFLps3+lk9JhFhKHxWTF7m4
	 1TRMWSCEjoqu54bnlokt/bnNO8/T9Y0q/aZ6IU5BdvuSZSfz6pypdckPWlZ6FpdkOMKMf
	 xRUfU+qOvCuWgkFgKK2Awx3UdFrJ6/Lh8JjOc78KFt1WmPAwLc/y8cIyX6DgYTEzgPgAA
	 yNS14Lur9Kjs3d+dYnVom4IeC3x3Ke1HX+uoBBPMvbMwimDf/K2eZT/gT5EEGg6eeuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446920;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ESZTt5kKGm0PXJPG6c/I77NKpQkJeu5VAaTmy1DFTy0=;
	b=H5HeZallULWCXGAliQAYfbvHLpGWmrKYXbg3cfOxLNo5/OYJ3XTtWx7CRCzpMiwPdwKY
	 YalU1JcVz8nGvrmWV+b68v4L8zcuNBeHuFlXrQ8sbgU4TERQP4uIak6il6sZrMI+dCW3b
	 L09KdfsFRjoY5mdXxlYmo9GfEHwDv9tKSMuY+48Joec9TzJw1/ZfvW/YgpNwGi/ePx4uj
	 zzDD+k+6UoJ3Pwt8MCp+djslSLNINYjaXZ1qxwi3nxijKy8WxygBFOyBeW+ThgRzZfjXC
	 PMhCaH/Sh6pWlxwdn1zG5OmXf7vsMX0HuZ71y3DctOm125NkD2nHln/Fipy+9k14J4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KbParMb+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1C9606A880;
	Thu, 12 Nov 2026 01:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KbParMb+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDF71F00A08;
	Thu, 12 Nov 2026 01:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794446920;
	bh=ESZTt5kKGm0PXJPG6c/I77NKpQkJeu5VAaTmy1DFTy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KbParMb+yAQYoWgpVFhAIG7pg7tdqo7XkKXAJM3Gkc5BNgNl8Vj0PUNN3P1iuiPqN
	 6VQyTleHMtZwSxzhMPyQ1YEI6Hj/4ErEunTAdsWwbXp7NJsGzS22kHLh/gjGRjrOve
	 64dvrUhojbbWGPeq2kbuiUkFv6hu9JFKcHETbXG6fM5JJqEaygmZ83a0vKImeNbaRw
	 zzILH+i0xfFdXg0+4UyOG5zvzXRMY8a0dsQnzWPPsBo48PyYlCPwxUiR/UqKiXhQQX
	 OX/cAgHLBFe+sa5jQHpDp7wE77gEN9q7ItBWzCchDzd2TyLEBECIhHalHFNoN3xKLC
	 2yPMDx/1AlDWg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 13/13] tracing/probes: Propagate error codes in eprobe and fprobe creation
Date: Thu, 12 Nov 2026 10:28:36 +0900
Message-ID: <179444691677.345731.9574690062592232082.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179444679892.345731.5271591537517106679.stgit@devnote2>
References: <179444679892.345731.5271591537517106679.stgit@devnote2>
User-Agent: StGit/0.19
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
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

In __trace_eprobe_create() and trace_fprobe_create_internal(), error
codes returned by helper and registration functions (such as -ENOMEM or
-EEXIST) are overwritten with -EINVAL.

Propagate the actual error codes to the caller.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_eprobe.c |    2 +-
 kernel/trace/trace_fprobe.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index f65da7b3adf4..d1477ff5b128 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -917,7 +917,7 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 		trace_probe_log_set_index(filter_idx);
 		ret = trace_eprobe_parse_filter(ep, filter_cnt, argv + filter_idx);
 		if (ret)
-			return -EINVAL;
+			return ret;
 	} else
 		ep->filter_str = NULL;
 
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 9ab0871a6461..f6bfc4073887 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -1272,7 +1272,7 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 	/* a symbol(or tracepoint) must be specified */
 	ret = parse_symbol_and_return(argc, argv, &symbol, &is_return, is_tracepoint);
 	if (ret < 0)
-		return -EINVAL;
+		return ret;
 
 	trace_probe_log_set_index(0);
 	if (event) {
@@ -1388,7 +1388,7 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 			trace_probe_log_err(0, BAD_PROBE_ADDR);
 		else if (ret != -ENOMEM && ret != -EEXIST)
 			trace_probe_log_err(0, FAIL_REG_PROBE);
-		return -EINVAL;
+		return ret;
 	}
 
 	/* 'tf' is successfully registered. To avoid freeing, assign NULL. */

