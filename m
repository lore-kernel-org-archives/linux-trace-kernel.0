Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BFF15ECCB;
	Wed,  5 Jun 2024 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619225; cv=none; b=gLg3bT4IrpJihB1/YlbeFpkeEdfbkp41HONSy6MnKO3CAYntN5LkBX8Gu4I9TPyh/Q7dkEazsHDR+ROTdI8xCoZuythZ/WOFhlJ9tOSO1nF0QryFWMNPHq0TLbJ7mAwLy3n9iLFcECbp/2fAIyZjvIiqVMUIgpS3603uK8u8AIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619225; c=relaxed/simple;
	bh=j7IAs0iqnm589HLRMIPJ8FP0EVvPqQDV6iAvK8Vv5HI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=eb4ya+3IplsWxLIEpPscCk31UowZpcPnVQDlMUVLnodBHIH91vvqH1wDBvJXCD1ZwKmb+mymJCZmueFJo+yqS/FGmK9eII03CzUHFqle1OizIoUzQ/ClMMm5pOiLTQlBN8EinYbW4mHOBW3jt42fkmK8+3qdMs7fwYPCBIYBXWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6FDC4AF09;
	Wed,  5 Jun 2024 20:27:05 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sExDw-00000000i7Q-2U08;
	Wed, 05 Jun 2024 16:27:08 -0400
Message-ID: <20240605202708.450784356@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 05 Jun 2024 16:26:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/6] ftrace: Assign ftrace_list_end to ftrace_ops_list type cast to RCU
References: <20240605202644.293295925@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Use a type cast to convert ftrace_list_end to RCU when assigning
ftrace_ops_list. This will quiet the sparse warning:

 kernel/trace/ftrace.c:125:59: warning: incorrect type in initializer (different address spaces)
 kernel/trace/ftrace.c:125:59:    expected struct ftrace_ops [noderef] __rcu *[addressable] [toplevel] ftrace_ops_list
 kernel/trace/ftrace.c:125:59:    got struct ftrace_ops *

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index da7e6abf48b4..3af0b1feb873 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -122,7 +122,7 @@ static int ftrace_disabled __read_mostly;
 
 DEFINE_MUTEX(ftrace_lock);
 
-struct ftrace_ops __rcu *ftrace_ops_list __read_mostly = &ftrace_list_end;
+struct ftrace_ops __rcu *ftrace_ops_list __read_mostly = (struct ftrace_ops __rcu *)&ftrace_list_end;
 ftrace_func_t ftrace_trace_function __read_mostly = ftrace_stub;
 struct ftrace_ops global_ops;
 
-- 
2.43.0


