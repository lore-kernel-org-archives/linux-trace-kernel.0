Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3A426CE37;
	Fri,  1 Aug 2025 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754058306; cv=none; b=YEFKUW+FbBwuB4+OYOLABMjzcHb1qodR0256IEnla9T7FMCnVMLWk2vjkqtb+EniV+uYjTp+KHWqy6NQ7pqpIlQ8pvfkclI6glNRQi80i47O1c8D51VAjHQLujsbi04X3PjI8LjEkDuL5pFlJdwLMaKhKvPdhtLfH3P+0X4V3+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754058306; c=relaxed/simple;
	bh=wBWx+Y3RO/IH5YBMOUYqg6RORH0rHuPQ/Pbz7bTXkRg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=m+U9XLKYi+WV/MYc4Z1nfRi3xvfHvlPjGA9mwZSUAHIs4KDmX4aCP8w9E8uIUadD0bzBxV7NPe5n23/WwkADfXPrqdENg6MVqiOJl0Swud9Y458TWwXetCIlDMDrYRiTsoVwRgwVebjE9yTrEcG1eH46q33JkyocUbnLR5wd1RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5+w/YTQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5+w/YTQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC770C4CEF6;
	Fri,  1 Aug 2025 14:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754058305;
	bh=wBWx+Y3RO/IH5YBMOUYqg6RORH0rHuPQ/Pbz7bTXkRg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=e5+w/YTQPbjv5gkqIpOPZyiKKf3yvsQIDBxEy29IFCFKAr9kWO+HQOdd6WkXVjolu
	 F9ZUhNNg8B4k9IBKoiz3LALsjocJ+9+jJT1sayrTTs6apNzcZPJFqJTQdi3akt5rqd
	 a+U9vcVRGrpwcpvBDRtDiaHwPAoT1VR6IvBLjcWxX0gYIBPwyn7XLmc6jEsvONkwJU
	 Lf/RmuFTuHMJgcde/Bq7Kb/UH4iC8ptlcsNyVSqV5oWtQdS2ClgGy25Ll2H0LiijMU
	 14e6+hXOm09b9lIxN7oqqdPNYArYNZBJdq1883D+ZX1tM7QQZpxkZYM5eyT2RCw9By
	 5kk7NnlitJgfw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uhqhK-00000007Uva-42rV;
	Fri, 01 Aug 2025 10:25:26 -0400
Message-ID: <20250801142526.816157660@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 01 Aug 2025 10:25:10 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4/5] tracing: Use __free(kfree) in trace.c to remove gotos
References: <20250801142506.431659758@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

There's a couple of locations that have goto out in trace.c for the only
purpose of freeing a variable that was allocated. These can be replaced
with __free(kfree).

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a781c8145ea6..e029b92cf379 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5041,7 +5041,7 @@ tracing_cpumask_read(struct file *filp, char __user *ubuf,
 		     size_t count, loff_t *ppos)
 {
 	struct trace_array *tr = file_inode(filp)->i_private;
-	char *mask_str;
+	char *mask_str __free(kfree) = NULL;
 	int len;
 
 	len = snprintf(NULL, 0, "%*pb\n",
@@ -5052,16 +5052,10 @@ tracing_cpumask_read(struct file *filp, char __user *ubuf,
 
 	len = snprintf(mask_str, len, "%*pb\n",
 		       cpumask_pr_args(tr->tracing_cpumask));
-	if (len >= count) {
-		count = -EINVAL;
-		goto out_err;
-	}
-	count = simple_read_from_buffer(ubuf, count, ppos, mask_str, len);
-
-out_err:
-	kfree(mask_str);
+	if (len >= count)
+		return -EINVAL;
 
-	return count;
+	return simple_read_from_buffer(ubuf, count, ppos, mask_str, len);
 }
 
 int tracing_set_cpumask(struct trace_array *tr,
@@ -10738,7 +10732,8 @@ ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
 				size_t count, loff_t *ppos,
 				int (*createfn)(const char *))
 {
-	char *kbuf, *buf, *tmp;
+	char *kbuf __free(kfree) = NULL;
+	char *buf, *tmp;
 	int ret = 0;
 	size_t done = 0;
 	size_t size;
@@ -10753,10 +10748,9 @@ ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
 		if (size >= WRITE_BUFSIZE)
 			size = WRITE_BUFSIZE - 1;
 
-		if (copy_from_user(kbuf, buffer + done, size)) {
-			ret = -EFAULT;
-			goto out;
-		}
+		if (copy_from_user(kbuf, buffer + done, size))
+			return -EFAULT;
+
 		kbuf[size] = '\0';
 		buf = kbuf;
 		do {
@@ -10772,8 +10766,7 @@ ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
 					/* This can accept WRITE_BUFSIZE - 2 ('\n' + '\0') */
 					pr_warn("Line length is too long: Should be less than %d\n",
 						WRITE_BUFSIZE - 2);
-					ret = -EINVAL;
-					goto out;
+					return -EINVAL;
 				}
 			}
 			done += size;
@@ -10786,17 +10779,12 @@ ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
 
 			ret = createfn(buf);
 			if (ret)
-				goto out;
+				return ret;
 			buf += size;
 
 		} while (done < count);
 	}
-	ret = done;
-
-out:
-	kfree(kbuf);
-
-	return ret;
+	return done;
 }
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-- 
2.47.2


