Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E745420E89;
	Wed,  2 Sep 2026 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365902; cv=none; b=rdlSfSjKmvYUHEiOSEVEru4dd5J/MQWh2Bi9rY/AdKmY1De1CA1d47tBJKlP/oNuep2D++EHNpiOzD0SbFN5XA+hgNKztM5C/A0chzQs3OzeQW+f26F/4k8XWvpC8ev1hPNF7oeBvhiqzpWEzrfzXvD+rxP5tVLLngrybJ70vyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365902; c=relaxed/simple;
	bh=9bfkU3piEPZ2AYc1xqoEHGzpUcTGmfrcewEql0zFcu4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pK9MC6JM+Ms70lNb2QXpEKx6pCT7DjSMh5d+ZmfBj+3EUXb7HmSLp8BgUwxqFIp7zhWKClzVQL0wZcnh9Kib2qGbc5aRXe0L3tTgN0pAawejO4UTlTTkiNAu7GQF7Glsevvru5UGab6Nt1CGEBa1sr+TFk8RgL/LaZvwYFVsfx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=qb8nTvGv; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="qb8nTvGv"
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 669EEA3F25;
	Wed,  2 Sep 2026 16:18:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 9EE1A18;
	Wed,  2 Sep 2026 16:18:17 +0000 (UTC)
Date: Wed, 2 Sep 2026 12:19:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH v3] tracing: Take trace_array reference when opening options
 file
Message-ID: <20260902121918.5a9e9d1b@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9EE1A18
X-Stat-Signature: 4dg8jcdmhcr95y634rtehs58bh8rte6g
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1//XBQSpKTvgZgysxrArnYntSkLa4DdqMw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=mX3v9TrQu4w/vyFOqMHhNw0dKXXE3EzPt/swGummXdA=; b=qb8nTvGvqJqA2s23Nxth1ViQ0W/gxeoWS2Yakgn4uo/jFIvqeipwrk3fT/AhRlPjuc2MXMu8+vbkwYTOAyXtfr83ENipMFJesjvxQHdjZ09GFLi7Qw2Y3xg/eojSVg6Nd3AhqKcrIEiBZ9c3lpwHVhUx+EuhY3MpGKfiPb/khO4=
X-HE-Tag: 1788365897-285665
X-HE-Meta: U2FsdGVkX18utJZ3qqgMCxWeZ0JLomnRlm0ETHAxxp6owYQME8HzJQtLFCIVCCAi9IKrV350QPrxuCr5D/opSZ3kOm6T0Z0YeZ8u+8pSZzZNfNQGY/DEmMnZdZc27B+OJ3+YU6hiKmmYo3iBm76DM69ZQkJ5Ko9ClKzIY+eLSEhMKFxp9pHkVf4cLa4EmU3ahaURS/ta/XG4UhZljJw06vJGtupgcLM8OD8InxLOGeNWMdWMC5y9taRIlpn9frGTIXDrbnSdP/MNhHjDHqthxb1VxVC/xe0bjlvoK2cYTzzvO8G4PO6siMHJbsb/oANklTIMf7snvYrS7ndyOdxcEoVYguAL0mFAFnLhhCpJR8U++upd930LhFKjkb8Ni19lrMThG4Z5sYpU6jUrOeoLVEZ+cFSEPKENoSnZTnEC6Edu/c8HeNaD+NY1SeKFcJkuQN8yllLfhKFh7JYaWwWvQx7uiyk2ahzpSh4SGTCywpw=

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
Changes since v2: ??
  Ignore it. I resent v1 because I didn't add the "-a" to my "git commit --amend"
  before sending.

Changes since v1: https://patch.msgid.link/20260901163620.6cbe0ada@gandalf.local.home

- Added (void *) typecast to comparison. (kernel test robot)

 kernel/trace/trace.c | 67 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a946e0183fd1..722d0ba2d233 100644
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
+		if (tr_index >= (void *)&tr->trace_flags_index[0] &&
+		    tr_index < (void *)&tr->trace_flags_index[TRACE_FLAGS_MAX_SIZE])
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

