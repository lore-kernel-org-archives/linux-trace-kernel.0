Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580F815ECF4;
	Wed,  5 Jun 2024 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619226; cv=none; b=GmCMhRBkZevzJzEftse6jeS560yxg+YR4T7JbNVhROjHWR1HfmfR/s3ap4NQ9a+1EKy8OGsGzd8O6LzAw6RmtOwqsKuZ6SK4kMmWgyIj/2O2gmyzds5YP3RlQ2JnJbrLsoGh43TUfV+QgW+rQrOk0L2CLeOEAtxADJxbgq7TS24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619226; c=relaxed/simple;
	bh=Lo+KTDar5Td+LgUarTq7UKV7H+gNQWMb5yhOymYhrw4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jfoc2BZyM/ZbGNu19JDqZQzduHT7gunnpaougO6sEfHbC0cuqHJ5amQw5+WSSwL4bDntZqvom7lSc8CQMy4a2IkucGREYSM+8BDGdtUJo5pQAZwfFKsa2mkUaFU5SBP29TfaS/Xozz7roC4ExyK1YJfIbgdN+qJvL72jNbIXgmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70C5C32781;
	Wed,  5 Jun 2024 20:27:05 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sExDw-00000000i8O-3qFn;
	Wed, 05 Jun 2024 16:27:08 -0400
Message-ID: <20240605202708.773583114@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 05 Jun 2024 16:26:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 kernel test robot <lkp@intel.com>
Subject: [PATCH 4/6] ftrace: Fix prototypes for ftrace_startup/shutdown_subops()
References: <20240605202644.293295925@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The ftrace_startup_subops() was in the wrong header, and both functions
were not defined on !CONFIG_DYNAMIC_FTRACE.

Fixes: 5fccc7552ccbc ("ftrace: Add subops logic to allow one ops to manage many")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406051524.a12JqLqx-lkp@intel.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace_internal.h | 9 +++++++++
 kernel/trace/trace.h           | 1 -
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace_internal.h b/kernel/trace/ftrace_internal.h
index bfba10c2fcf1..4bb1e881154a 100644
--- a/kernel/trace/ftrace_internal.h
+++ b/kernel/trace/ftrace_internal.h
@@ -15,6 +15,7 @@ extern struct ftrace_ops global_ops;
 int ftrace_startup(struct ftrace_ops *ops, int command);
 int ftrace_shutdown(struct ftrace_ops *ops, int command);
 int ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs);
+int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command);
 int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command);
 
 #else /* !CONFIG_DYNAMIC_FTRACE */
@@ -39,6 +40,14 @@ ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs)
 {
 	return 1;
 }
+static inline int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command)
+{
+	return -EINVAL;
+}
+static inline int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index b37402e3f0c9..8783bebd0562 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1186,7 +1186,6 @@ extern int ftrace_set_filter(struct ftrace_ops *ops, unsigned char *buf,
 			     int len, int reset);
 extern int ftrace_set_notrace(struct ftrace_ops *ops, unsigned char *buf,
 			      int len, int reset);
-extern int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command);
 #else
 struct ftrace_func_command;
 
-- 
2.43.0


