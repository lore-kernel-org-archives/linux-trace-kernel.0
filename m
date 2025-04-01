Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A9A15E5D4;
	Tue,  1 Apr 2025 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743521702; cv=none; b=s2ESFR/FQqDJ7LBHMVSNmN51rOYc/a7gZ8uehSMuU7Al8ydozjYNDVvbMr7YGskJQekT3hQmUmRxbZPJ8WhZgF4wr8JCamCINc2v9qFCaEliXMrt5hlR1sa1ZO/Pqzf6c7JFIj+Q2JxEAAQx0YZH9/K4XUEMDJSLQZYmmZUq2do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743521702; c=relaxed/simple;
	bh=X9OEUt4lsxqGEHhwQKXxAwdPCxsyBHc752o5nyOFVH4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=lfPaeFvTn0qkzV/fFvdAIKKSAKolZ6w8912j6tm+w1pUQkzX9uvrw0QpGDR9ZVbUNfR2Vffme/lW3klxhgun2Zn9gq+DBU121Y8koV7Iel6RqRrpnhLPLIVkGe8FhQpOmM9ZmPsltK4MBVksC59Ii8Vkq1parzMpS4F0Elm/zdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317A9C4CEE5;
	Tue,  1 Apr 2025 15:35:01 +0000 (UTC)
Date: Tue, 1 Apr 2025 11:36:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Christian Loehle <Christian.Loehle@arm.com>, Leon Romanovsky
 <leon@kernel.org>
Subject: [PATCH] ftrace: Have tracing function args depend on
 PROBE_EVENTS_BTF_ARGS
Message-ID: <20250401113601.17fa1129@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The option PROBE_EVENTS_BTF_ARGS enables the functions
btf_find_func_proto() and btf_get_func_param() which are used by the
function argument tracing code. The option FUNCTION_TRACE_ARGS was
dependent on the same configs that PROBE_EVENTS_BTF_ARGS was dependent on,
but it was also dependent on PROBE_EVENTS_BTF_ARGS. In fact, if
PROBE_EVENTS_BTF_ARGS is supported then FUNCTION_TRACE_ARGS is supported.

Just make FUNCTION_TRACE_ARGS depend on PROBE_EVENTS_BTF_ARGS.

Fixes: 533c20b062d7c ("ftrace: Add print_function_args()")
Closes: https://lore.kernel.org/all/DB9PR08MB75820599801BAD118D123D7D93AD2@DB9PR08MB7582.eurprd08.prod.outlook.com/
Reported-by: Christian Loehle <Christian.Loehle@arm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 033fba0633cf..a3f35c7d83b6 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -265,8 +265,7 @@ config FUNCTION_GRAPH_RETADDR
 
 config FUNCTION_TRACE_ARGS
        bool
-	depends on HAVE_FUNCTION_ARG_ACCESS_API
-	depends on DEBUG_INFO_BTF
+	depends on PROBE_EVENTS_BTF_ARGS
 	default y
 	help
 	  If supported with function argument access API and BTF, then
-- 
2.47.2

