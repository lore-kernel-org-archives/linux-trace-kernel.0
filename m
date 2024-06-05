Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5712215ECF3;
	Wed,  5 Jun 2024 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619226; cv=none; b=ka6xQRBCZHP9Cap7n2Vp54VYo9g0Ay3cPKLTb3EcGKWuv6YJnLJEdEFOIoCJ6gNhh0dBgwUJwrm/D5p7fG86Fa5jlRAupsRJ9lcp4sYPDXX5VrkORt/I/kUqHHOXv2Mw+De4Sd1TopYvvJGEusYS2hhb/X4C3e04o+Q3m9uV0s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619226; c=relaxed/simple;
	bh=4Q9p3K5GndKyfNAahJjpQzFGmcIsZnywwComrYPdA8Y=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=uqL2V0YDiyFVdn64x71E4JtiJ3tX0oF2P3fyMKkOR/R4pHQtvymTwa/14sDvhiGsBZjN2KQwvTX6cwYkCpTbV3o2CarBLtRns3NrIKSoBi/chtyDFPp4F/Oc95yE1jaXRozB3HwGkW5CYJmVgNaIqn1XNdg1kQnbXSMx8L6hiXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A85AC4AF0A;
	Wed,  5 Jun 2024 20:27:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sExDx-00000000i9M-0zcE;
	Wed, 05 Jun 2024 16:27:09 -0400
Message-ID: <20240605202709.096020676@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 05 Jun 2024 16:26:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 kernel test robot <lkp@intel.com>
Subject: [PATCH 6/6] function_graph: Do not update pid func if CONFIG_DYNAMIC_FTRACE not
 enabled
References: <20240605202644.293295925@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The ftrace subops is only defined if CONFIG_DYNAMIC_FTRACE is enabled. If
it is not, function tracing is extremely limited, and the subops in the
ftrace_ops structure is not defined (and will fail to compile). If
DYNAMIC_FTRACE is not enabled, then function graph filtering will not
work (as it shouldn't).

Fixes: df3ec5da6a1e7 ("function_graph: Add pid tracing back to function graph tracer")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406051855.9VIYXbTB-lkp@intel.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 63d828054c79..c0e428c87ea5 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1177,6 +1177,7 @@ void fgraph_update_pid_func(void)
 	if (!(graph_ops.flags & FTRACE_OPS_FL_INITIALIZED))
 		return;
 
+#ifdef CONFIG_DYNAMIC_FTRACE
 	list_for_each_entry(op, &graph_ops.subop_list, list) {
 		if (op->flags & FTRACE_OPS_FL_PID) {
 			gops = container_of(op, struct fgraph_ops, ops);
@@ -1186,6 +1187,7 @@ void fgraph_update_pid_func(void)
 				static_call_update(fgraph_func, gops->entryfunc);
 		}
 	}
+#endif
 }
 
 /* Allocate a return stack for each task */
-- 
2.43.0


