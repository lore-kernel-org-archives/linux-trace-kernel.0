Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A09815EFAA;
	Wed,  5 Jun 2024 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619226; cv=none; b=tJu41+91y4eSrPCA3wSyt9Y6CnYxOS5+s5XnfEACgsIJpmRy2TsGfNMs2Dm2w/N3dNJc/ZWrwSwGYRubkiPStJ9f8C6puTqp3BJOJYhsiW19EY6eeRQrA6KqCBZb/oRUGB6Zywq70DzdPhMhWxDNYmYBb9GyuPvdOeVJ46w4ROc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619226; c=relaxed/simple;
	bh=f7mhAHQ6UAt9EOXxpYEDswe/vbF9g8NMK/HEN3liMwc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=mI4XHqniUmUd55hBSuYPqfpIqnF0DMkRaTu6UeGxAoZNY+I7uvMe90vHm0diOZqnF/aasZXthnbNPkHtWRKUIJofUq9RnQQunJ+d0sfH63cWRKWnGxetfBmWrwSUoGxdlvfjATtj+6CpPOT/6iRgBxxxCsIqDOGXccTsIWHCaeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02763C32786;
	Wed,  5 Jun 2024 20:27:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sExDx-00000000i8s-0Jhv;
	Wed, 05 Jun 2024 16:27:09 -0400
Message-ID: <20240605202708.936515302@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 05 Jun 2024 16:26:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 kernel test robot <lkp@intel.com>
Subject: [PATCH 5/6] function_graph: Make fgraph_do_direct static key static
References: <20240605202644.293295925@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The static branch key "fgraph_do_direct" was not declared static but is
only used in one file. Change it to a static variable.

Fixes: cc60ee813b503 ("function_graph: Use static_call and branch to optimize entry function")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406051711.dS1sQZ9n-lkp@intel.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 4bf91eebbb08..63d828054c79 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -515,7 +515,7 @@ static struct fgraph_ops fgraph_stub = {
 static struct fgraph_ops *fgraph_direct_gops = &fgraph_stub;
 DEFINE_STATIC_CALL(fgraph_func, ftrace_graph_entry_stub);
 DEFINE_STATIC_CALL(fgraph_retfunc, ftrace_graph_ret_stub);
-DEFINE_STATIC_KEY_TRUE(fgraph_do_direct);
+static DEFINE_STATIC_KEY_TRUE(fgraph_do_direct);
 
 /**
  * ftrace_graph_stop - set to permanently disable function graph tracing
-- 
2.43.0


