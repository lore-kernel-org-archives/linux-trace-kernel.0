Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15418477E37;
	Tue,  1 Sep 2026 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788294933; cv=none; b=QWO3B/CuoxWQ2bDDRh9J/DL5UasqltsDArN/S7DnMS6na+QJtHxPXUjX1pcaRBrMynnWrwnBD3Y6QsBy5MZXk4FI78bO/KhZ7KvYjltsbekqo5s46M5ucO8AvinjKk5uptusx2DjzDeHhiN0QtL/GVHcSdPi62wadVD60GJ4yH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788294933; c=relaxed/simple;
	bh=pHIsrFSNvLWC/4DPdUY0rtzW7sSfm7EwgWqWklgBjiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mJARv51xiRPZ7zQdEkXbSqojF1KXneZLwxkq8zTjHNRONltJGm1SSsZ0p5bX/UZjr462z8S4Khs1wiS+w/vSaBrMrcOFtjunv+mwmvb+1x8ZnPDmLPYKdD7DxfxGhFhZiBAyTIxcNBp7pC8EuRBcwXpS9jKy2gDl5BM1r18xCqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=Ll5Rr+oi; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="Ll5Rr+oi"
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 6D9931404CC;
	Tue,  1 Sep 2026 20:35:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id B7B2B20010;
	Tue,  1 Sep 2026 20:35:21 +0000 (UTC)
Date: Tue, 1 Sep 2026 16:36:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Take trace_array reference when opening options
 file
Message-ID: <20260901163620.6cbe0ada@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: bafzbjascqatj1zqasq768c4ikudgkcd
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: B7B2B20010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/l1ba6B717nU07kq57QxxIl85zG+MopOU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=h+HW9juB6WRMvybig35oZxUCTIigBs56Ot//5krdEtM=; b=Ll5Rr+oiRXGQkOwM/KPuwkC2OFnoDgD91vu+7tzXZfZ34+qV7Pdfm2ctKzdEIohRCz6Cv53dlVz8tbBOQMneQerkYGcqvzzHsVCecTGFW8yriXjNk8jQSS9RsIgGNkH/3J0RS7X2O/XF2LwxMSdhQpPMlri8xEoSdWJDUcx5mQc=
X-HE-Tag: 1788294921-337226
X-HE-Meta: U2FsdGVkX1+zsVntxLsV5cZzCQNt5WENt6tpS4rNNQH1dCUqgWgStDqVxaLJT2Ix1UZin+Lf48mCDX+SUjhOD147+0FiIjPNRRCTv+E/1hwfBCgMUKxTrxXPZHHdbZ1kn8KB1YK1td/YO3PhM19s+SaPHmSfCSz2roYqzsrw316a6lFlfUx629p8WGwYa+yeRTn/T4vjb0mO1GXkZTgJwSCbHNK3or0LG8CAnoC712Z6zZVmEGx9rwBhimouCwWgHWskMnve/d+UAMSfe4JWfNcF0z+7XPrjizduI2yYfgSoa1ccL+qrr6cJKd9w2IYIatDuyNHq5lo1IpgmmNvSPMII3vbGy4LofGayS8B/xRcfNpmuovT/4JUCtpmYGLtbbZ2uASIl2VzGxcZUGpSl5A==

From: Steven Rostedt <rostedt@goodmis.org>

The options files do not take the trace_array reference for the options
they represent. This could cause a use-after-free kernel crash if one of
these files is opened by one task and another task removes the instance
that the option is for. Because it doesn't take a reference upon opening,
it will not stop the removal which will free the options descriptor that
is being used.

As the options are somewhat dynamic in their creation at boot up, each
file represents a flag in the trace_array. The trace_array has an array of
indexes to represent each of these flags that is stored in the
trace_flags_index array. The address of the index array element is used to
pass to the inode->i_private pointer. Then that element is read which
holds the index (which represents the flag) and then the index is used to
calculate the trace_array descriptor from its trace_flags_index array.

One issue is that the index element can not be referenced until the
trace_array's reference is taken. To handle this, create a new helper
function called: trace_array_options_get() that will iterate all the
existing trace_arrays in the ftrace_trace_arrays list (under the
trace_types_lock), and compare the passed in address of the index element
with the entire array of the trace_array's trace_flags_index array.
If it matches, then up the corresponding trace_array's reference and
return.

Cc: stable@vger.kernel.org
Fixes: 577b785f55168 ("tracing: add tracer dependent options to options directory")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/linux-trace-kernel/20260828135858.2AC501F000E9@smtp.kernel.org/
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 67 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a946e0183fd1..61ca05ee991d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7842,11 +7842,70 @@ trace_options_core_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	return cnt;
 }
 
+/*
+ * The tr_index is the address of a trace_array->trace_flags_index[]
+ * element that holds the index of the trace flag. But since the
+ * trace_array reference has not been taken yet, it cannot be referenced
+ * as it could have been freed by a rmdir of the instance the trace_array
+ * represents.
+ *
+ * Search the list of trace_arrays and compare the tr_index to the
+ * address of the entire trace_array trace_flags_index array for each
+ * trace_array in the list. If one is matched, then take the reference
+ * and return it. If not, the trace_array no longer exits.
+ */
+static int trace_array_options_get(void *tr_index)
+{
+	struct trace_array *tr;
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
+	if (tracing_disabled)
+		return -ENODEV;
+
+	guard(mutex)(&trace_types_lock);
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		if (tr_index >= &tr->trace_flags_index[0] &&
+		    tr_index < &tr->trace_flags_index[TRACE_FLAGS_MAX_SIZE])
+			return __trace_array_get(tr);
+	}
+	return -ENODEV;
+}
+
+static int trace_options_open(struct inode *inode, struct file *filp)
+{
+	void *tr_index = inode->i_private;
+
+	if (trace_array_options_get(tr_index) < 0)
+		return -ENODEV;
+
+	filp->private_data = tr_index;
+
+	return 0;
+}
+
+static int trace_options_release(struct inode *inode, struct file *filp)
+{
+	void *tr_index = filp->private_data;
+	struct trace_array *tr;
+	unsigned int index;
+
+	get_tr_index(tr_index, &tr, &index);
+
+	trace_array_put(tr);
+
+	return 0;
+}
+
 static const struct file_operations trace_options_core_fops = {
-	.open = tracing_open_generic,
-	.read = trace_options_core_read,
-	.write = trace_options_core_write,
-	.llseek = generic_file_llseek,
+	.open		= trace_options_open,
+	.read		= trace_options_core_read,
+	.write		= trace_options_core_write,
+	.llseek		= generic_file_llseek,
+	.release	= trace_options_release,
 };
 
 struct dentry *trace_create_file(const char *name,
-- 
2.53.0

