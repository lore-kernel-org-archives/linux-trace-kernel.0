Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598F33B83F9;
	Wed, 14 Oct 2026 08:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791967169; cv=none; b=bh0CjGHQbwBgRouteLDoRyoA6Hy6HFCZgjKDD1HA/gTOzQPoW0i3s7Q0iaX8uJmJVdwViwswD/u963fvMecBJvGUQW/TsyLqOxzsC/MyLTfayFRga6IPDJyaqu5gxyHNvDR3cZVlMYeF+ngeg9OuqhFrtmSeRGbeztB7cPB5E9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791967169; c=relaxed/simple;
	bh=+vafbOQDOcGBeKsxs6qqZFvka0Sj9IAPNwvvivwotG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EVxTbCLiyGfLHhrWk0wejaJuinhOd1k+RvjL2CdHOnnfVqbUYwKtZ+dHHVIeQYDSBFtHx7n6V3qbCaCWVQa/Y/q4Srt8N/juLIyZ0xybCsv7nfYD9gZni6jf1vNZTgjhIgNSrkNwQ1F6OVvuQH89wDTuc6GfZK5LGMh11i+Wbbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-209-185-035.092.209.pools.vodafone-ip.de ([92.209.185.35] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1xGuW8-00000001y0q-1b2R;
	Wed, 14 Oct 2026 10:39:20 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Martin Kaiser <martin@kaiser.cx>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: probes: error if BTF is required but unavailable
Date: Wed, 14 Oct 2026 10:37:40 +0200
Message-ID: <20261014083838.31020-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

traceprobe_expand_meta_args expands probe arguments based on BTF info.

Return an error if we have arguments that need expanding but BTF is not
supported.

The params variable is now unused, it can be removed.

Fixes: d157d7694460 ("tracing/probes: Support BTF field access from $retval")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 kernel/trace/trace_probe.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index cfb710095f65..516c439932a0 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -2287,7 +2287,6 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 					 int *new_argc, char *buf, int bufsize,
 					 struct traceprobe_parse_context *ctx)
 {
-	const struct btf_param *params = NULL;
 	int i, j, n, used, ret, args_idx = -1;
 	const char **new_argv __free(kfree) = NULL;
 
@@ -2305,7 +2304,7 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 		if (args_idx != -1) {
 			/* $arg* requires BTF info */
 			trace_probe_log_err(0, NOSUP_BTFARG);
-			return (const char **)params;
+			return ERR_PTR(-EOPNOTSUPP);
 		}
 		*new_argc = argc;
 		return NULL;
-- 
2.43.7

