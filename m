Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404231A3176;
	Thu,  6 Feb 2025 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738861140; cv=none; b=bCOxfKE+VQlCiZpm9lAOIobdJflLH3EIEe8Fgm8TDlIu/OcbCER8n1Lz0TIAoHWEP9BlMy43GTSnuuO52qMx10Qkn8orQx5Xi31BH11ssG24c8OCJrppoMXCcorzGSr/Cpx0zLVsSddkED/pb/G3N+yyecFpgrs9ULqpExrDDF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738861140; c=relaxed/simple;
	bh=oKw1gq3IJXBNZHaLukyfGjM4RYUKQnlHlVj8vrLsr7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lxm+QnHDnQoikC63Ens7HkC0GBTb272SeAyDXnFdk5Ag/CPgpdmeDqDkIOzc3GxygxvniaDo66mdHbpZvWewZaUk2mh6mbuOkp3MAZvbzwZDQzV0D3hTvtmk402KYJfDEkwSB2chBoN8K8s4XsL9gbHLjgHAfGVskLNWTAZvVfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zzz7vuaF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zzz7vuaF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F630C4CEDD;
	Thu,  6 Feb 2025 16:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738861139;
	bh=oKw1gq3IJXBNZHaLukyfGjM4RYUKQnlHlVj8vrLsr7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zzz7vuaF/l+EvyS+Cm7imJ7FSxBtUyKVRFJh0UKgtzVS/GhBV9NskzkztEuoR4q1M
	 DY3qKTJY80GIVvRWp/bAOLM7fUnTqidWC8z8UXij8gPOgsXKDzpkTiBAnF0T/cxPA6
	 nLXU3qj+/KbP0rp3iQaCzmOd4RGfpP65XhHhuoGgKyC/T/0R/GJe9VCIgkWSQJYMXv
	 xgJk3EKhZ8DaZwWny0bgo5ZjGIwsD3iuJt4XJTx4a8nJd6sQLxkIOY3JdTbNZRua8K
	 UUT6JqPBRJqk9klq7RBE7w/Cw+3TfQysM3iemA6joIefppl/be7DkdCPGIr6Rnud5c
	 lJ2QQJzlgzfAQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/3] tracing: Remove checking the activity when module map is updating
Date: Fri,  7 Feb 2025 01:58:56 +0900
Message-ID: <173886113592.496116.11615563462036645436.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207015330.5c71ad55ed2f516da1410711@kernel.org>
References: <20250207015330.5c71ad55ed2f516da1410711@kernel.org>
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

Remove unnecessary active check because tr->flags already checks it.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace.c |   13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0f010a34de84..5a064e712fd7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10090,15 +10090,6 @@ static void trace_module_remove_evals(struct module *mod)
 static inline void trace_module_remove_evals(struct module *mod) { }
 #endif /* CONFIG_TRACE_EVAL_MAP_FILE */
 
-static bool trace_array_active(struct trace_array *tr)
-{
-	if (tr->current_trace != &nop_trace)
-		return true;
-
-	/* 0 is no events, 1 is all disabled */
-	return trace_events_enabled(tr, NULL) > 1;
-}
-
 static void trace_module_record(struct module *mod)
 {
 	struct trace_array *tr;
@@ -10107,9 +10098,7 @@ static void trace_module_record(struct module *mod)
 		/* Update any persistent trace array that has already been started */
 		if ((tr->flags & (TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT)) ==
 		    TRACE_ARRAY_FL_BOOT) {
-			/* Only update if the trace array is active */
-			if (trace_array_active(tr))
-				save_mod(mod, tr);
+			save_mod(mod, tr);
 		}
 	}
 }

