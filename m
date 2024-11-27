Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC699463
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732714968; cv=none; b=aIC5mmr6Enwk4fqF17jWIFT1FmYdmdxcf5vBJfpz8X4P4pCaxI3eGkow8vRXEjyc+dXkFji2w0aXR62MhL5ppBw5K83iDr0R3eDMwlNfHz+Yt3MJtEzLErXIWnA/2FssDXvC3c6TsDlXeErs96K2DdFtqZ9BgKEk4HBR83uG4CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732714968; c=relaxed/simple;
	bh=RTCrqjRzuZyB+6SaGVRbNBwxLFJ80VrTdPYE5BQetHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jnGIDmpPZQp2Trs2K650fyZItFILThLfkYfAhgoca8fpdmd51kE9TkM0ZcVC60RA68tsC7q3XoPAuJ/8WmI9+AB2zf5KM5Ujt89WZzEZkVq4Emwk8yEFQcEdjk4NPqP1FSiA+6ULGgNMHeYVXXAtOcw0/UFzH85jIMlPvAloG8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uxe7EUZr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uxe7EUZr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732714963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DrqEyN1VIkRW+8Dy1kjHg1io3m7CiBN0LwYlK4a0uE4=;
	b=Uxe7EUZrQWlu8th2gL7faCOJtkBaM3xVpZXhwf3O1Hyw+WD6PU/KGe4Ya4SDwYiYoAEGtp
	54dzEwltW9HZKEoooXTalUvYb6K7vdFb/HbHarxOyRt/60di5HikqChv4X3ftegOvpmBVh
	3EIFUWZ37GyYvyd20BsfUqm58iE3yNw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422--71aCkMMNDq79fYvTqV5PQ-1; Wed,
 27 Nov 2024 08:42:42 -0500
X-MC-Unique: -71aCkMMNDq79fYvTqV5PQ-1
X-Mimecast-MFC-AGG-ID: -71aCkMMNDq79fYvTqV5PQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A5D01955F77;
	Wed, 27 Nov 2024 13:42:41 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.132])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E0A2A1956054;
	Wed, 27 Nov 2024 13:42:38 +0000 (UTC)
From: tglozar@redhat.com
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2] rtla/timerlat: Fix histogram ALL for zero samples
Date: Wed, 27 Nov 2024 14:41:30 +0100
Message-ID: <20241127134130.51171-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Tomas Glozar <tglozar@redhat.com>

rtla timerlat hist currently computers the minimum, maximum and average
latency even in cases when there are zero samples. This leads to
nonsensical values being calculated for maximum and minimum, and to
divide by zero for average.

A similar bug is fixed by 01b05fc0e5f3 ("rtla/timerlat: Fix histogram
report when a cpu count is 0") but the bug still remains for printing
the sum over all CPUs in timerlat_print_stats_all.

The issue can be reproduced with this command:

$ rtla timerlat hist -U -d 1s
Index
over:
count:
min:
avg:
max:
Floating point exception (core dumped)

(There are always no samples with -U unless the user workload is
created.)

Fix the bug by omitting max/min/avg when sample count is zero,
displaying a dash instead, just like we already do for the individual
CPUs. The logic is moved into a new function called
format_summary_value, which is used for both the individual CPUs
and for the overall summary.

Cc: stable@vger.kernel.org
Fixes: 1462501c7a8 ("rtla/timerlat: Add a summary for hist mode")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat_hist.c | 177 ++++++++++++++-----------
 1 file changed, 96 insertions(+), 81 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 8b66387e5f35..4403cc4eba30 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -281,6 +281,21 @@ static void timerlat_hist_header(struct osnoise_tool *tool)
 	trace_seq_reset(s);
 }
 
+/*
+ * format_summary_value - format a line of summary value (min, max or avg)
+ * of hist data
+ */
+static void format_summary_value(struct trace_seq *seq,
+				 int count,
+				 unsigned long long val,
+				 bool avg)
+{
+	if (count)
+		trace_seq_printf(seq, "%9llu ", avg ? val / count : val);
+	else
+		trace_seq_printf(seq, "%9c ", '-');
+}
+
 /*
  * timerlat_print_summary - print the summary of the hist data to the output
  */
@@ -328,29 +343,23 @@ timerlat_print_summary(struct timerlat_hist_params *params,
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
 
-		if (!params->no_irq) {
-			if (data->hist[cpu].irq_count)
-				trace_seq_printf(trace->seq, "%9llu ",
-						data->hist[cpu].min_irq);
-			else
-				trace_seq_printf(trace->seq, "        - ");
-		}
+		if (!params->no_irq)
+			format_summary_value(trace->seq,
+					     data->hist[cpu].irq_count,
+					     data->hist[cpu].min_irq,
+					     false);
 
-		if (!params->no_thread) {
-			if (data->hist[cpu].thread_count)
-				trace_seq_printf(trace->seq, "%9llu ",
-						data->hist[cpu].min_thread);
-			else
-				trace_seq_printf(trace->seq, "        - ");
-		}
+		if (!params->no_thread)
+			format_summary_value(trace->seq,
+					     data->hist[cpu].thread_count,
+					     data->hist[cpu].min_thread,
+					     false);
 
-		if (params->user_hist) {
-			if (data->hist[cpu].user_count)
-				trace_seq_printf(trace->seq, "%9llu ",
-						data->hist[cpu].min_user);
-			else
-				trace_seq_printf(trace->seq, "        - ");
-		}
+		if (params->user_hist)
+			format_summary_value(trace->seq,
+					     data->hist[cpu].user_count,
+					     data->hist[cpu].min_user,
+					     false);
 	}
 	trace_seq_printf(trace->seq, "\n");
 
@@ -364,29 +373,23 @@ timerlat_print_summary(struct timerlat_hist_params *params,
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
 
-		if (!params->no_irq) {
-			if (data->hist[cpu].irq_count)
-				trace_seq_printf(trace->seq, "%9llu ",
-						 data->hist[cpu].sum_irq / data->hist[cpu].irq_count);
-			else
-				trace_seq_printf(trace->seq, "        - ");
-		}
+		if (!params->no_irq)
+			format_summary_value(trace->seq,
+					     data->hist[cpu].irq_count,
+					     data->hist[cpu].sum_irq,
+					     true);
 
-		if (!params->no_thread) {
-			if (data->hist[cpu].thread_count)
-				trace_seq_printf(trace->seq, "%9llu ",
-						 data->hist[cpu].sum_thread / data->hist[cpu].thread_count);
-			else
-				trace_seq_printf(trace->seq, "        - ");
-		}
+		if (!params->no_thread)
+			format_summary_value(trace->seq,
+					     data->hist[cpu].thread_count,
+					     data->hist[cpu].sum_thread,
+					     true);
 
-		if (params->user_hist) {
-			if (data->hist[cpu].user_count)
-				trace_seq_printf(trace->seq, "%9llu ",
-						 data->hist[cpu].sum_user / data->hist[cpu].user_count);
-			else
-				trace_seq_printf(trace->seq, "        - ");
-		}
+		if (params->user_hist)
+			format_summary_value(trace->seq,
+					     data->hist[cpu].user_count,
+					     data->hist[cpu].sum_user,
+					     true);
 	}
 	trace_seq_printf(trace->seq, "\n");
 
@@ -400,29 +403,23 @@ timerlat_print_summary(struct timerlat_hist_params *params,
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
 
-		if (!params->no_irq) {
-			if (data->hist[cpu].irq_count)
-				trace_seq_printf(trace->seq, "%9llu ",
-						 data->hist[cpu].max_irq);
-			else
-				trace_seq_printf(trace->seq, "        - ");
-		}
+		if (!params->no_irq)
+			format_summary_value(trace->seq,
+					     data->hist[cpu].irq_count,
+					     data->hist[cpu].max_irq,
+					     false);
 
-		if (!params->no_thread) {
-			if (data->hist[cpu].thread_count)
-				trace_seq_printf(trace->seq, "%9llu ",
-						data->hist[cpu].max_thread);
-			else
-				trace_seq_printf(trace->seq, "        - ");
-		}
+		if (!params->no_thread)
+			format_summary_value(trace->seq,
+					     data->hist[cpu].thread_count,
+					     data->hist[cpu].max_thread,
+					     false);
 
-		if (params->user_hist) {
-			if (data->hist[cpu].user_count)
-				trace_seq_printf(trace->seq, "%9llu ",
-						data->hist[cpu].max_user);
-			else
-				trace_seq_printf(trace->seq, "        - ");
-		}
+		if (params->user_hist)
+			format_summary_value(trace->seq,
+					     data->hist[cpu].user_count,
+					     data->hist[cpu].max_user,
+					     false);
 	}
 	trace_seq_printf(trace->seq, "\n");
 	trace_seq_do_printf(trace->seq);
@@ -506,16 +503,22 @@ timerlat_print_stats_all(struct timerlat_hist_params *params,
 		trace_seq_printf(trace->seq, "min:  ");
 
 	if (!params->no_irq)
-		trace_seq_printf(trace->seq, "%9llu ",
-				 sum.min_irq);
+		format_summary_value(trace->seq,
+				     sum.irq_count,
+				     sum.min_irq,
+				     false);
 
 	if (!params->no_thread)
-		trace_seq_printf(trace->seq, "%9llu ",
-				 sum.min_thread);
+		format_summary_value(trace->seq,
+				     sum.thread_count,
+				     sum.min_thread,
+				     false);
 
 	if (params->user_hist)
-		trace_seq_printf(trace->seq, "%9llu ",
-				 sum.min_user);
+		format_summary_value(trace->seq,
+				     sum.user_count,
+				     sum.min_user,
+				     false);
 
 	trace_seq_printf(trace->seq, "\n");
 
@@ -523,16 +526,22 @@ timerlat_print_stats_all(struct timerlat_hist_params *params,
 		trace_seq_printf(trace->seq, "avg:  ");
 
 	if (!params->no_irq)
-		trace_seq_printf(trace->seq, "%9llu ",
-				 sum.sum_irq / sum.irq_count);
+		format_summary_value(trace->seq,
+				     sum.irq_count,
+				     sum.sum_irq,
+				     true);
 
 	if (!params->no_thread)
-		trace_seq_printf(trace->seq, "%9llu ",
-				 sum.sum_thread / sum.thread_count);
+		format_summary_value(trace->seq,
+				     sum.thread_count,
+				     sum.sum_thread,
+				     true);
 
 	if (params->user_hist)
-		trace_seq_printf(trace->seq, "%9llu ",
-				 sum.sum_user / sum.user_count);
+		format_summary_value(trace->seq,
+				     sum.user_count,
+				     sum.sum_user,
+				     true);
 
 	trace_seq_printf(trace->seq, "\n");
 
@@ -540,16 +549,22 @@ timerlat_print_stats_all(struct timerlat_hist_params *params,
 		trace_seq_printf(trace->seq, "max:  ");
 
 	if (!params->no_irq)
-		trace_seq_printf(trace->seq, "%9llu ",
-				 sum.max_irq);
+		format_summary_value(trace->seq,
+				     sum.irq_count,
+				     sum.max_irq,
+				     false);
 
 	if (!params->no_thread)
-		trace_seq_printf(trace->seq, "%9llu ",
-				 sum.max_thread);
+		format_summary_value(trace->seq,
+				     sum.thread_count,
+				     sum.max_thread,
+				     false);
 
 	if (params->user_hist)
-		trace_seq_printf(trace->seq, "%9llu ",
-				 sum.max_user);
+		format_summary_value(trace->seq,
+				     sum.user_count,
+				     sum.max_user,
+				     false);
 
 	trace_seq_printf(trace->seq, "\n");
 	trace_seq_do_printf(trace->seq);
-- 
2.47.0

