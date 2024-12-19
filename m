Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFFE1D417B;
	Thu, 19 Dec 2024 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639185; cv=none; b=BTDphn0F9DTGAT5k1DKy1320sFqubmmfe919fxdrGivEeOJ6+YZzSfB6wmoqAvIFvW3ATd3FbMl8JP9LpOu26IOCtdJiZovaIusbeH+JQuvtCG1lZ81qicZhMvNsgUgf8WCzBuDP/g3gcR/aSW17XjGaICVsNja8B2Hifo/+c70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639185; c=relaxed/simple;
	bh=P2FbeD6seuoCUmuzI54xDLabJBUB6VKTSG7K74qIQA4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=tyPS/YfEU0YbLJlMxXD+1Gsh9ryAch51rded0m6OunpZtxShZMRo0XToAGGjOo7TWkL+g0DtKOLgfpATGp/8/+H5AgNipLkGI6ITL4un/57VpSfF1qS084bHT8AH5bKUbXd+Bye2lXVuGtg5bcQJOcPCnc6Clq2xBIW/6YOKs+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E448AC4CED6;
	Thu, 19 Dec 2024 20:13:04 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tOMu2-0000000AOMS-2qH5;
	Thu, 19 Dec 2024 15:13:46 -0500
Message-ID: <20241219201346.533876847@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 19 Dec 2024 15:12:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 12/14] tracing: Switch trace_osnoise.c code over to use guard() and __free()
References: <20241219201158.193821672@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The osnoise_hotplug_workfn() grabs two mutexes and cpu_read_lock(). It has
various gotos to handle unlocking them. Switch them over to guard() and
let the compiler worry about it.

The osnoise_cpus_read() has a temporary mask_str allocated and there's
some gotos to make sure it gets freed on error paths. Switch that over to
__free() to let the compiler worry about it.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 38 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index b9f96c77527d..b8626892c66d 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2083,26 +2083,21 @@ static void osnoise_hotplug_workfn(struct work_struct *dummy)
 {
 	unsigned int cpu = smp_processor_id();
 
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 
 	if (!osnoise_has_registered_instances())
 		goto out_unlock_trace;
 
-	mutex_lock(&interface_lock);
-	cpus_read_lock();
+	guard(mutex)(&interface_lock);
+	guard(cpus_read_lock)();
 
 	if (!cpu_online(cpu))
-		goto out_unlock;
+		return;
+
 	if (!cpumask_test_cpu(cpu, &osnoise_cpumask))
-		goto out_unlock;
+		return;
 
 	start_kthread(cpu);
-
-out_unlock:
-	cpus_read_unlock();
-	mutex_unlock(&interface_lock);
-out_unlock_trace:
-	mutex_unlock(&trace_types_lock);
 }
 
 static DECLARE_WORK(osnoise_hotplug_work, osnoise_hotplug_workfn);
@@ -2300,31 +2295,22 @@ static ssize_t
 osnoise_cpus_read(struct file *filp, char __user *ubuf, size_t count,
 		  loff_t *ppos)
 {
-	char *mask_str;
+	char *mask_str __free(kfree) = NULL;
 	int len;
 
-	mutex_lock(&interface_lock);
+	guard(mutex)(&interface_lock);
 
 	len = snprintf(NULL, 0, "%*pbl\n", cpumask_pr_args(&osnoise_cpumask)) + 1;
 	mask_str = kmalloc(len, GFP_KERNEL);
-	if (!mask_str) {
-		count = -ENOMEM;
-		goto out_unlock;
-	}
+	if (!mask_str)
+		return -ENOMEM;
 
 	len = snprintf(mask_str, len, "%*pbl\n", cpumask_pr_args(&osnoise_cpumask));
-	if (len >= count) {
-		count = -EINVAL;
-		goto out_free;
-	}
+	if (len >= count)
+		return -EINVAL;
 
 	count = simple_read_from_buffer(ubuf, count, ppos, mask_str, len);
 
-out_free:
-	kfree(mask_str);
-out_unlock:
-	mutex_unlock(&interface_lock);
-
 	return count;
 }
 
-- 
2.45.2


