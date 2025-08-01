Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CBC28BAB1;
	Fri,  1 Aug 2025 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754080716; cv=none; b=EtbUGHWt4WM2jAQqxr1ZyuA47TX6ca0h6VSrn/cE+RkeDQ6HGHjAixii5Ex6ur0mL6TgJZirsFo7da7oTKhZeI0EsqXNyu7Ytt+HlHEkVbfDW21giB8fvWRhpOdujCxX4kxO/q5pE6C6+Iz9Etof8DNe61+mr42paJPUqJ2+8Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754080716; c=relaxed/simple;
	bh=taGLadHbgyKGhx64e1z5+xzIAjnv5MRlLFrrYN0dWf0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GDUV0Txej9rDXhHmVUvaWd/T1XDZjnSNAktrqqpQDONuXc/rF/CzPbnJBiaK+lg7C2wmd0ZUYeyWC+RqYHq19jFQu9PZ5yjDM+VihW4vlWzdGq0JoiFx6j3Lg6u8XmPJamiGqpj2lQLxm3Od04jxy6tuwVdaKDlfsZY2yCqdnCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLQIt9iS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLQIt9iS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AE6C4CEFA;
	Fri,  1 Aug 2025 20:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754080716;
	bh=taGLadHbgyKGhx64e1z5+xzIAjnv5MRlLFrrYN0dWf0=;
	h=Date:From:To:Cc:Subject:References:From;
	b=GLQIt9iS/9lfzx8MHw7f3PU3/cSxBsjZnmSYFXs0YLkXZNtHbvh54xsOmKH9rK5Ns
	 o19ySfGtSG0e/8D8kpNlI5cQu9YwVodFZWFNiXgBAfJeQe3iEpqLfG/IHJkyiQe5B2
	 mWipt0mPZvswPqrVD+c4L0a7d41YrMQ9kUdQLRXNQcYD65BOyfDJfsbT/OnaTIUk5E
	 MLHp4snHBeuxrOF64ourUXrgfo0kgpMFHZjDuE8V4DWJvFwyk9qqi3HoCLcop3dAkj
	 aD8CycrQQL3t3AZkT5KlkoMg0oSbAjSz6tFTGmiDMTcutObkILS6sVhd4QFCNMAStx
	 b1W+qVpng3qYA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uhwWo-00000007jb3-0mKr;
	Fri, 01 Aug 2025 16:38:58 -0400
Message-ID: <20250801203858.040892777@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 01 Aug 2025 16:37:26 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 4/5] tracing: Use __free(kfree) in trace.c to remove gotos
References: <20250801203722.072085868@kernel.org>
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
index 4299e89ed04e..d0b1964648c1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5042,7 +5042,7 @@ tracing_cpumask_read(struct file *filp, char __user *ubuf,
 		     size_t count, loff_t *ppos)
 {
 	struct trace_array *tr = file_inode(filp)->i_private;
-	char *mask_str;
+	char *mask_str __free(kfree) = NULL;
 	int len;
 
 	len = snprintf(NULL, 0, "%*pb\n",
@@ -5053,16 +5053,10 @@ tracing_cpumask_read(struct file *filp, char __user *ubuf,
 
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
@@ -10739,7 +10733,8 @@ ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
 				size_t count, loff_t *ppos,
 				int (*createfn)(const char *))
 {
-	char *kbuf, *buf, *tmp;
+	char *kbuf __free(kfree) = NULL;
+	char *buf, *tmp;
 	int ret = 0;
 	size_t done = 0;
 	size_t size;
@@ -10754,10 +10749,9 @@ ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
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
@@ -10773,8 +10767,7 @@ ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
 					/* This can accept WRITE_BUFSIZE - 2 ('\n' + '\0') */
 					pr_warn("Line length is too long: Should be less than %d\n",
 						WRITE_BUFSIZE - 2);
-					ret = -EINVAL;
-					goto out;
+					return -EINVAL;
 				}
 			}
 			done += size;
@@ -10787,17 +10780,12 @@ ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
 
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


