Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1805E23D281;
	Sat,  2 May 2026 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777730337; cv=none; b=i37eUlbeACxgr6zkiqDlT9MzhMk8FaXQKQBISNRFJtZ/gjdHwruVwdUmCWOkJ1XFi9Gt+tEgsklp8cmG7DaKGIeBkuT4grKG/fYHH5PXo9NdJ14JJyhBtAJ4qJa9ySPXKo5EIuKdN9Vp8uoVaMSilBFXO4koOjs76qlCrjYcuuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777730337; c=relaxed/simple;
	bh=+Cr2rImynkVm/Byzz1l70+CqZXnQ5l9fN3Rd102WQcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RrQ3ihbC+J3eRVD9+z7bjjvfMyba7vdEy8GIb3SDdMOmI1srDEmSnXR8Vviraf07XqlZ/cSnEe11WJVWSant+qHX5ONgcqui0jDOB6jyoeB9B0IlX/bs3RxvptoyDV9fUX1+TdxvwjjE0r+30LdY4lgGRBuDeirynaysAfLBHUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-208-105-007.092.208.pools.vodafone-ip.de ([92.208.105.7] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1wJArq-000000001gN-3G5R;
	Sat, 02 May 2026 15:58:50 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] tracing: probes: remove unused variable
Date: Sat,  2 May 2026 15:57:42 +0200
Message-ID: <20260502135826.146257-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

params is always NULL in traceprobe_expand_meta_args, it can be removed.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
Would it be better to return ERR_PTR(-EOPNOTSUPP) instead of NULL, similar to
what is done in other places where NOSUP_BTFARG is logged? This would make the
parsing fail if $arg* is used without BTF support. At the moment, we skip the
$arg*...

 kernel/trace/trace_probe.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index e0d3a0da26af..b627093a941e 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1729,7 +1729,6 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 					 int *new_argc, char *buf, int bufsize,
 					 struct traceprobe_parse_context *ctx)
 {
-	const struct btf_param *params = NULL;
 	int i, j, n, used, ret, args_idx = -1;
 	const char **new_argv __free(kfree) = NULL;
 
@@ -1747,7 +1746,7 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 		if (args_idx != -1) {
 			/* $arg* requires BTF info */
 			trace_probe_log_err(0, NOSUP_BTFARG);
-			return (const char **)params;
+			return NULL;
 		}
 		*new_argc = argc;
 		return NULL;
-- 
2.43.7

