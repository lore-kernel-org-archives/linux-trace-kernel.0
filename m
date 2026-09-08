Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B73521218
	for <linux-trace-kernel@vger.kernel.org>; Tue,  8 Sep 2026 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788858587; cv=none; b=NeWCNnru5dQkEEDZfpTnxL6mG1+b20RWoH7jAqYXzcd5PXMkDcM/5ByDfV0j63j6/KOgi0Qy1ucb2MbQj1L7CObnA+aOG5NDCIPuIRHLerA2ahBRGenXKeM2H7bAAIOG0BHhtrHWs1Ln8iCAHWrOUYMLEunLRiy5wWqoZZNlPaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788858587; c=relaxed/simple;
	bh=94iWMjTIwc0TonrLV6eGBag3QwHv2vDmbqxBkMi2cSQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qAw9LOHOCC2PPNHK1/LrIuqZMiah+JcB6jrr3YClXWsg7Z0xRpRplRtEoh+/0CxdrXL/O1H3m5f4a0dbSqMBL7cE/N+eRtB4npU9h/Q9AtiGNI77VlWe2fmqLvFm09FB4BQokeQRCSA8if7/qoaTdizEToVqQ/z/wZb5GlyR1Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vFvrTHkt; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vFvrTHkt"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49ccfad90f1so27007915e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 08 Sep 2026 02:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788858583; x=1789463383; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=boy6Bccw47o3amNkT4CAs/pFHV7Gzoaqb7AJB1HcaIk=;
        b=vFvrTHktKvSCZHDzAtE3OFzcgu2fUDhy8s4G7hmy3OinJIDdqUgY9GMgZ2Gq1pU9wC
         2KaY7YyP/K+F9CGcC8M6rnRtkoaX4G9Kc00fwXb8M+qzeFtwMUG5TDfEgaXdM3GLKPxX
         i9REI/tLocISSf8bxonLZgn8E6xU8mWIp19Loghw8U5q+ogOJOBxhl8U1T1K/TQvj6cn
         +OhX8v7ygqGj+SajFpgnN0TNfYrhlQTolj+uvloFdNJmDxu9VZof/KF9FRPH1RyU6WH7
         q1/aOJUWreWC6iuotngz4X7/35UTemGIIPe54kylsukCcLjgJ/h8ENx87t/GaFs1J0z4
         0LSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788858583; x=1789463383;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=boy6Bccw47o3amNkT4CAs/pFHV7Gzoaqb7AJB1HcaIk=;
        b=iE5Cb1x5mdS+kKyl6nYInNVA7Yus9yBteZjCOVfrnox6yUNspKc51DuyPmTLPvFa+L
         6SwR8EFfyOXa+u8JwK8Ew8zcB+vWaiTQh+fNsNd/BziftGOuznEPGcSnSUj9s9uzf9xZ
         bbySuc3WDXx7cQk6OWi+3iharOg+YfkkwxVSu9TkWASsE5iQIcGfLhQj9CZiDeH8waVO
         0pzx3Yzrj6kgZbk2801zSyrF9yebITljp6/tFPx0Dsd5FnfKf/R4Srpx1nwyGiSy4vSe
         fmBcXYP8wOEL3LFrVqzcDd8lbrQxdcm+Tbd4ri+hoSEZpgaN2ksiV4evgJYXT43BH42r
         pcGQ==
X-Forwarded-Encrypted: i=1; AKwUvBwqxvPQ+yyNCmhUHoogonSd/VhvgjOICYNV7RYqjPLReZVvpygLk6AMLr5Pp2OHsA7AlccPojZt33mjoBYjxX1QxSs=@vger.kernel.org
X-Gm-Message-State: AFuF++k9jQ0rD2aFS8OuIdJbwBZQFDXIgC08d/3UDJJwyxUvjdGAPqYq
	vFA3GrsfrY3beNeEhXhYxucNMcfIwFqAnqkRMoEKQ73sc8Dn9PIIAIxdgadXzaIu4ABiGfVMNI4
	vrINk0AvqjvnjMN1iMhu92w==
X-Received: from wmby25-n2.prod.google.com ([2002:a05:600c:c059:20b0:499:dd82:8175])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:4449:20b0:49d:3a:e576 with SMTP id 5b1f17b1804b1-49d003ae639mr149520405e9.5.1788858583494;
 Tue, 08 Sep 2026 02:09:43 -0700 (PDT)
Date: Tue,  8 Sep 2026 10:09:37 +0100
In-Reply-To: <20260908090937.838544-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260908090937.838544-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908090937.838544-4-vdonnefort@google.com>
Subject: [PATCH v2 3/3] tracing: Rename tracing_entries_fops to tracing_capacity_fops
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Since commit 8a5f63637890 ("ring-buffer: Fix subbuf resize race with
ring buffer readers"), "capacity" refers to the memory available for
events, while "entries" refers to the number of events in a ring buffer.
As a consequence, rename trace_array::entries to capacity to align with
this convention.

While at it, rename also tracing_total_entries_fops. It is the aggragate
of all ring buffer capacities.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/trace.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 400d7a97e745..780c4987032b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5672,8 +5672,7 @@ tracing_syscall_buf_write(struct file *filp, const char __user *ubuf,
 }
 
 static ssize_t
-tracing_entries_read(struct file *filp, char __user *ubuf,
-		     size_t cnt, loff_t *ppos)
+tracing_capacity_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
 {
 	struct inode *inode = file_inode(filp);
 	struct trace_array *tr = inode->i_private;
@@ -5720,8 +5719,7 @@ tracing_entries_read(struct file *filp, char __user *ubuf,
 }
 
 static ssize_t
-tracing_entries_write(struct file *filp, const char __user *ubuf,
-		      size_t cnt, loff_t *ppos)
+tracing_capacity_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t *ppos)
 {
 	struct inode *inode = file_inode(filp);
 	struct trace_array *tr = inode->i_private;
@@ -5748,8 +5746,7 @@ tracing_entries_write(struct file *filp, const char __user *ubuf,
 }
 
 static ssize_t
-tracing_total_entries_read(struct file *filp, char __user *ubuf,
-				size_t cnt, loff_t *ppos)
+tracing_total_capacity_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
 {
 	struct trace_array *tr = filp->private_data;
 	char buf[64];
@@ -6600,10 +6597,10 @@ static const struct file_operations tracing_pipe_fops = {
 	.release	= tracing_release_pipe,
 };
 
-static const struct file_operations tracing_entries_fops = {
+static const struct file_operations tracing_capacity_fops = {
 	.open		= tracing_open_generic_tr,
-	.read		= tracing_entries_read,
-	.write		= tracing_entries_write,
+	.read		= tracing_capacity_read,
+	.write		= tracing_capacity_write,
 	.llseek		= generic_file_llseek,
 	.release	= tracing_release_generic_tr,
 };
@@ -6623,9 +6620,9 @@ static const struct file_operations tracing_buffer_meta_fops = {
 	.release	= tracing_seq_release,
 };
 
-static const struct file_operations tracing_total_entries_fops = {
+static const struct file_operations tracing_total_capacity_fops = {
 	.open		= tracing_open_generic_tr,
-	.read		= tracing_total_entries_read,
+	.read		= tracing_total_capacity_read,
 	.llseek		= generic_file_llseek,
 	.release	= tracing_release_generic_tr,
 };
@@ -7653,7 +7650,7 @@ tracing_init_tracefs_percpu(struct trace_array *tr, long cpu)
 				tr, cpu, &tracing_stats_fops);
 
 	trace_create_cpu_file("buffer_size_kb", TRACE_MODE_WRITE, d_cpu,
-				tr, cpu, &tracing_entries_fops);
+				tr, cpu, &tracing_capacity_fops);
 
 	if (tr->range_addr_start)
 		trace_create_cpu_file("buffer_meta", TRACE_MODE_READ, d_cpu,
@@ -8954,10 +8951,10 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 			  tr, &tracing_pipe_fops);
 
 	trace_create_file("buffer_size_kb", writable_mode, d_tracer,
-			  tr, &tracing_entries_fops);
+			  tr, &tracing_capacity_fops);
 
 	trace_create_file("buffer_total_size_kb", TRACE_MODE_READ, d_tracer,
-			  tr, &tracing_total_entries_fops);
+			  tr, &tracing_total_capacity_fops);
 
 	trace_create_file("trace_clock", writable_mode, d_tracer, tr,
 			  &trace_clock_fops);
-- 
2.55.0.979.g7e5102b832-goog

