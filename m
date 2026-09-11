Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDE83E122D;
	Fri, 11 Sep 2026 02:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093171; cv=none; b=BUK9QDg20Hvu+kqZhLUyYKaJsFfQzDpu2mcEC3VNxaJs6CeaRLskVux7YdlxIGpYhwqD9IS8QuYvPcUXr876RahQDTmpUng5NiVKxtivtfS8GBA7Jp7nydSfZGVWEOkawhiWhs38oUYsZmDuDeSnXQHCrwIFib59ot86Z5ya1Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093171; c=relaxed/simple;
	bh=3/4A7WGA2zMIswo1jmitErW5tnaewjrFCdOj85kCees=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=nTFKCrRZHWox2spqk02NMoGhUAgRVkFocnwspJPjOlfGM7vu7qXJqDUfqY1ih68SeryUq8ZBH/fKQ1NqviDJeRD7IFX+mCNEKwj42wQtRAina0Nd5JZVFhXYog9rDbG4SsmB/FK7V2VRRdw2AI1Bif22DqTXTq19oFKgIIRSCQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=VBSM05rz; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="VBSM05rz"
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id AD6E7A4F28;
	Fri, 11 Sep 2026 02:12:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 005B132;
	Fri, 11 Sep 2026 02:12:10 +0000 (UTC)
Date: Thu, 10 Sep 2026 22:12:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2] tracing: Take trace_array reference when opening a
 tracer options file
Message-ID: <20260910221209.62dad8d3@robin>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 005B132
X-Stat-Signature: 5bx994e36jeg1atgzhiepy6zg3pdrhj7
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/gdEGTUyGzxT4PkW2JOMG+8HqjAnGODMA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=vgWuFu8zSlq6fFOSGQhSrn+ThxkXehWqmmUN9j1Csy8=; b=VBSM05rzdkC8Nht9eWcXNl9YOJKPFn5B2WRTqmwf62a6mDI82zQudVNG+fcEYAm+K05TVGaXr6KyHc6XKjfUWX9GsWAR3v2bNATOimRH467+bCME4vN5plFxJLOsVuReK+bHlZI0AV7l7Tb0Xz7Rxvh5+K1aHl1XTnSirQ1LHp8=
X-HE-Tag: 1789092730-236229
X-HE-Meta: U2FsdGVkX19+bMyW8Dwa08cSK2Yd9YQFfuzsiMOQMP7ovjpVXOb35f7X+8cUn8NiLmMp+99tmD2cClKFpIqOPWFWivYTD4QhvgN4ULFICSiNyQdMHZjCOv4VkQPFMbBrh418M3H6t/F8U4TtGxCDkto6OxY2MKRmwr+vSp93HCukVUuex7vfGz1QCXBVXN+kvRyZbR5RTQH6gNqjIkGusdJKX0vxElqKZHf/tkwZj2MWSwDpPpN7lgVYZPRbTJ4KdlGk9k81ssDq8o8rbBJbkICHGA9Ap4K9wh9XPUUUyZzO3ak1VAPPVb/T/KRNqDUr1NBux4YofHPsiU4MLLyV2Aqar2A9yf9FjHJhhBaG+1Y/X2GbJnLAxpQlTxBLnJnUd9FiEsu82+VVmxk2lX96gTh5waJO3EXG41WP1Rx/BQNQD7hz9ymP0YuZEoVurbkScoBc/yYhR4ny0tbXMASXbjURFUa0k3SssvSguD6n/08=

From: Steven Rostedt <rostedt@goodmis.org>

When a tracer option file is opened, it is passed a descriptor that points
to an element on the trace_array's topts array. This element has
information to find the trace array and other information. It uses this
element to take a reference of the trace_array so that the trace_array
does not get removed while this file is opened.

Unfortunately, there's a race condition where the element itself could be
freed by the removal of the instance the trace_array represents causing a
use-after-free as this element that is used to find the trace_array to
increment its reference counter is also freed when the instance is
removed.

To solve this, add a trace_array_tracer_options_get() helper function that
will take the address of the element that is passed to the open function
by the inode->i_private pointer and search all the trace_arrays under a
lock to find the one that the element's address is in the range of the
trace_arrays topts array elements. When a match happens, that trace_array's
reference would be increased.

Note, there's a race where if an admin was deleting and creating trace
instances at the same time and the memory of the old trace_array's array
matched the memory of the new trace_array that it could in theory open the
option from the wrong trace array. But we do not care because it would be
stupid to perform that kind of action. As long as the only thing that can
happen is that the option from the wrong trace array is used and doesn't
crash the kernel it will only make the user confused. But if they are
doing something stupid like this, they are already confused, so no harm
done.

Cc: stable@vger.kernel.org
Fixes: 7e2cfbd2d3c86 ("tracing: Have option files inc the trace array ref count")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/linux-trace-kernel/20260902121918.5a9e9d1b@gandalf.local.home/
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
Changes since v1: https://patch.msgid.link/20260902212638.065669192@kernel.org

- Removed the change to make the trace options array a single array in the
  trace_array as it grows via krealloc(). Making it a single array may
  cause it to change address locations if the krealloc() needs more space.
  Instead, add a tr_option_match() helper function that will iterate all
  the tracer options in the topt array and return if there's a match.

 kernel/trace/trace.c | 46 +++++++++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace.h |  1 +
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8658cad53cb5..e4a490d3d08c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7717,12 +7717,55 @@ trace_options_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	return cnt;
 }
 
+static bool tr_option_match(struct trace_array *tr, void *topt)
+{
+	for (int i = 0; i < tr->nr_topts; i++) {
+		struct trace_options *tr_topts = &tr->topts[i];
+
+		if (topt >= (void *)&tr_topts->topts[0] &&
+		    topt < (void *)&tr_topts->topts[tr_topts->nr_topts])
+			return true;
+	}
+	return false;
+}
+
+/*
+ * The topt is the address of a trace_array->topts[] element that holds the
+ * the tracer options descriptor. But since the trace_array reference has not
+ * been taken yet, it cannot be dereferenced as it could have been freed by
+ * a rmdir of the instance the trace_array represents.
+ *
+ * Search the list of trace_arrays and compare the topt to the address of
+ * the entire trace_array topts array for each trace_array in the list.
+ * If one is matched, then take the reference and return it. If not, the
+ * trace_array no longer exits.
+ */
+static int trace_array_tracer_options_get(void *topt)
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
+		if (tr_option_match(tr, topt))
+			return __trace_array_get(tr);
+	}
+	return -ENODEV;
+}
+
 static int tracing_open_options(struct inode *inode, struct file *filp)
 {
 	struct trace_option_dentry *topt = inode->i_private;
 	int ret;
 
-	ret = tracing_check_open_get_tr(topt->tr);
+	ret = trace_array_tracer_options_get(topt);
 	if (ret)
 		return ret;
 
@@ -7984,6 +8027,7 @@ create_trace_option_files(struct trace_array *tr, struct tracer *tracer,
 	tr->topts = tr_topts;
 	tr->topts[tr->nr_topts].tracer = tracer;
 	tr->topts[tr->nr_topts].topts = topts;
+	tr->topts[tr->nr_topts].nr_topts = cnt;
 	tr->nr_topts++;
 
 	for (cnt = 0; opts[cnt].name; cnt++) {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 5e76f94e7a80..bd3c8f80300f 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -227,6 +227,7 @@ struct array_buffer {
 struct trace_options {
 	struct tracer			*tracer;
 	struct trace_option_dentry	*topts;
+	int				nr_topts;
 };
 
 struct trace_pid_list *trace_pid_list_alloc(void);
-- 
2.53.0

