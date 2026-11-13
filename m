Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558601;
	b=kATJCGjFtuX3nnF3KDygWL6jIywpIGJ8geeC684AeyoBHIutPEMqhRvwVAc3k+pc9bKD
	 xXYZ8LvW0abqXNmfn2REcrLLXYf5KYEzefOwEN9a16Lo8mln1sNhenkitxLcBbbqRuU5T
	 0sup+Ueq52pmUYADZ5LWLDvGMz8sdxqaFRZ70rvfatr//1OH4hZk80+vo2rMYyIEZkWNI
	 zY7SUMqn16SuyuA96KCFowfku5oLxS7VSceQMOo3lNODF7rd1l0V9WxwC/f49WmrIZsg2
	 raOdU7HLwjyLiIBwFEn68wV/XbnuWrM3/m31W5wPtvfoKRw9mSsPb+a4OWjnTuYXVyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558601;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ESZTt5kKGm0PXJPG6c/I77NKpQkJeu5VAaTmy1DFTy0=;
	b=mwW2V5AXpZOIcaga491nkHcTzdnWk1FszCcZp6A0Bjkxz2cfnvwXWqRq51pjav/AuZu0
	 2fjN6s90Z4kE6IdobYBnIEuwG1zKiLiQfk0O6avWxb1aAs8EjwUDvgKjQHJRJ+Peg8pKw
	 H8/LKuSfZtMG2C0HI1Zp/R9AqSPNK+Xef3tyNcCnNRkOfjkORbdTO84m7nBDfqnBmajYy
	 l4sMw0rGp55ewBK7aAtB1S/pYxOVT2CNHsE5rTS6Uimt/+i4tS6GWL9OMIl7DzR9Ru/jc
	 qyJgwa1JVGZ9vwGFvZSF2WIRLIEkseT+ROjnNZhtDsbhQHus0u5ddT7+aARGiueQa9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GxVuKNl6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7EE606B606;
	Fri, 13 Nov 2026 08:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GxVuKNl6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AA41F000C4;
	Fri, 13 Nov 2026 08:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794558601;
	bh=ESZTt5kKGm0PXJPG6c/I77NKpQkJeu5VAaTmy1DFTy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GxVuKNl6Q56sez6v+z9Gwao5UeMWepEZ6laSdnLWQCPrGBJ1lz17gd9UCaO/BvB3b
	 TivWirnYrS86ru+wYEWVhdXso6NWFj/bgksal/LhNwtkUio5v5ZZCi0kGJQjQPF+wX
	 X030FqvUSjAXpU+kr8s8xfIK0KG6Immp6OpwTVQEnyfaWhlP/AMjdbebMIFWPNYMV3
	 kHnHXcXh524B0b/KHbeSAbwbdGAqWdHAJX/9puxqTdIKQnzEXo637S94THJoLE1IZR
	 CIk52BVpOFZsJK7e9bl23+9KMRCFsVIPyzUY3m1V3R4O+rrMTCW8aMF6KZ3OdBUuLY
	 F6Vx1XeeDQ4og==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 13/13] tracing/probes: Propagate error codes in eprobe and fprobe creation
Date: Fri, 13 Nov 2026 17:29:57 +0900
Message-ID: <179455859774.403392.5456188096272082390.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179455847934.403392.15146485751358774349.stgit@devnote2>
References: <179455847934.403392.15146485751358774349.stgit@devnote2>
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

