Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BFC3DDDC9;
	Mon, 20 Jul 2026 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542354; cv=none; b=fiXdhySEVkuYZVmrhx7j7AsQQ+S2834tBOwrZjw3eeKsqWnhZW2oV/OmsS+l0ucck8muXRRo0wJmzKuxdEForRDyB8c5AuLgWSoOY2an1WNAgisMEysXQxRMCT14FnAHcAHx2rm/+MhDUt7I4qjBElezjM95WClPKEWjdNy4ZQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542354; c=relaxed/simple;
	bh=1AiS9B+t3qU+1/uIBx8ML7kKAI4vz2trbk6Bz2BK+uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lKtCqrU49SDZ/ITKLYPFlMbz90rj0j8Z3VZIa5qIBOhvHddtkPJMjGsoLZttvM+973c51XZCQOTU0/qf8hl6xKp1D54kwAD1SVED5oRruLbX/MEdosVXk47xh3pC8Wp9Dc2g6k8Nbimhk93NJrhZ9dODHfxcIPBN2dCOorS7HKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FH4kRi7q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FH4kRi7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CDB1F000E9;
	Mon, 20 Jul 2026 10:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784542343;
	bh=TRnSNdJJ5HxRVmdzYJIAGXiOj/310Q87mPBJ3yN1MPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FH4kRi7qvbGz5uNvtIRi075P0Ljva+2OUaQLhzkuahzJMXinEV0H+brE/QiMITv2T
	 woMk+MV93tmQoev4lfkC2tvC5QDypLT8Gmc7Z/NM4BL3YcOI8I4T2cmEwpDz2gIldf
	 3vyy9ilIKKatCRMi5EqljS48eNqKP01A7KWn+HNexgiuZnwdIKEGC7YPk+abOV0PgX
	 IVx6B6OK39t/aP2ZkyQlhb3sreTQAw8si03GjgVbzl1xOXn9C1NRh5k+8hAaWOwvTA
	 SrnZJmIsmKRDzrz/yZk9PR+kx1zny9GxQUrECzOuHIIOianzhJ86a04AqxZU+IjNAT
	 Rfh1glfZiGIqg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/4] tracing/probes: Prevent out-of-bounds write in __trace_probe_log_err()
Date: Mon, 20 Jul 2026 19:12:20 +0900
Message-ID: <178454233992.290363.18323091580600697731.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178454232006.290363.11301475407231432622.stgit@devnote2>
References: <178454232006.290363.11301475407231432622.stgit@devnote2>
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

If trace_probe_log.argc is 0 in __trace_probe_log_err(), the loop
constructing the command string will not execute and p will remain equal to
command. Writing to *(p - 1) will cause an out-of-bounds access before
command. This should not happen, but better to be treated.

Reject if trace_probe_log.argc is 0.

Fixes: ab105a4fb894 ("tracing: Use tracing error_log with probe events")
Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 95e3d072321f..49daa3cc2a45 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -188,7 +188,7 @@ void __trace_probe_log_err(int offset, int err_type)
 
 	lockdep_assert_held(&dyn_event_ops_mutex);
 
-	if (!trace_probe_log.argv)
+	if (!trace_probe_log.argv || !trace_probe_log.argc)
 		return;
 
 	/* Recalculate the length and allocate buffer */

