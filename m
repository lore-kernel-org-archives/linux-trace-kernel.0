Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184195;
	b=Vn2BtDkmYnKNwyK3xfAgubhl/rooBDlxcD3Bh8xmOX2Zi8TFKZ9Bm0ArJibrxM+YO0zB
	 edcYAWykmyQumqU/vh3z9KuwSHDgk6vLIRMi02aJ9cFlrNOzq8zEuyC0UnwKD//o9aNrH
	 fesUtrxITzKgLiZCpsKem0C+Pf5f0IB69eOoD4Ib5AZtw+0bNOjswhNtefTfFFt0+SyMQ
	 zVsXydrZIVGtEnzlsHctOMAUAY0J+lS2ojkiq3ZiGo2Xy2q3Xh+xqBXBt47F6h3V13oKJ
	 elPr1sebcpXM0S4By0sgIZ2xStMYlmpeIwG0A6zQNy87NRO844+6JynHHlGw7i97ILA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184195;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ESZTt5kKGm0PXJPG6c/I77NKpQkJeu5VAaTmy1DFTy0=;
	b=DjtFn5dyRIHo9US6b1/oWLA57FaBx2FKd88vmAa1fg8f4Ur4+hYh9fFn82odUEg8gH5c
	 pJ6FsDVIGR7GwDy3g4RkGiH1KdvO6yR7EDJyMcLPHElbzW82SgmgdLIE6D/orEaBcRTYV
	 ttLDjQ4U18Z7R4FDo6ACIJeisljrvg+qGvihFNzlDbDEae4ZaWTIoK3HudOsbVdlnSYy1
	 Rm13vhodGwyn4ikHXfrDI/njmNf/4V5QG7v83tKRuppioEanBheLhYYDKB44coLevcfZ0
	 oOIFeOkdBZHwf79InIRlR6QWUGy186rr3rlnHxw3/4YvysTYExHVXIUxRWn65lbZPjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="L/wHKqN1";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBF2606A321;
	Mon,  9 Nov 2026 00:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L/wHKqN1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236A21F008A1;
	Mon,  9 Nov 2026 00:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184195;
	bh=ESZTt5kKGm0PXJPG6c/I77NKpQkJeu5VAaTmy1DFTy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L/wHKqN1fqWLOhGqc9CUqunjrIHIT1IgKr+XLrNc50b8cYY7oBN+yAqweedzjIcKA
	 CFbtpN6jWTdHp3g2cIABa+CJqTKQRlLCBYL2S7rUPUxgYCyUdNE/7R5ccbd0zron86
	 maO308B1F9XDQkEO/VezSsuUcUer8bnaCuM9lZI+XwTFKCmT29drGOVQb3+Wn2ZmFf
	 /eTSTPz3cpMY9OC9tK6yBnU9UAe3YgD8MgXqfJbZtsucKxAZ3+U61Ae6o3w5PDIjFE
	 FpLRdeVb3Hlh9hEfMe/WDf2w5hH9HNpykDRGiR7r5XafBhjEnTHzXc/tqlDkKJ9B0P
	 ObZ9GndFpOeUQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 12/12] tracing/probes: Propagate error codes in eprobe and fprobe creation
Date: Mon,  9 Nov 2026 09:29:52 +0900
Message-ID: <179418419198.227715.15433232608137637935.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179418408457.227715.1485179201014819821.stgit@devnote2>
References: <179418408457.227715.1485179201014819821.stgit@devnote2>
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

