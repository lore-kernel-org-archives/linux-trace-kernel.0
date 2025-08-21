Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA6E217F24
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755748710; cv=none; b=dfIQcJabT0ZL72cACTA2vt4Vi+MHVOoXEF5y/v2ajqhw3jKRc8q2PekdZYc2499D2Ebia22uBSHGOlv8kjifa9Drv4WaeREULv20Hre536tk5lm40Z6yq/u45HPOyoVW2i+96OOIgmC9s19ldQ9Lqej1a2FnaGB1+WBH/M6nssE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755748710; c=relaxed/simple;
	bh=8KguW5zVMIEC0ChXyXKoe03lAfmru1QNaHvw6cUy2eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=g0eSkwp9HfYtewk5+vsJKnrlnCAYtrOV670DgVK/f0989tFUeiHTmGibepn6IXsOEsnBhvF2n1uD6cwPadube2KERQCMFTwL8Pv5XCW6pFUFbiRbkYyMvbcMcG/VJH07M/1OrJzKOsrVvxyoZNEk7ReegP8Drp1TD+auES3DhC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OC7qnW1Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OC7qnW1Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755748706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s703x3NzoHysQ4hvh/o1YdVz59JrRP8nUyfiqri6GGA=;
	b=OC7qnW1QicFzrTvPlEjX0/xEBtJ6E6ou1d68a7cKs3VvSL5ALrvM+Gy0c0gmexVPYzAHlR
	VkAYasKbkmZzl6Rr8r7VEUTxrJt8VIHJy2e3A2+WXUvpVaRz11nvduhAPPx0L4UrRTRag4
	3qzM42i4qlgE4arNvJw9Zgo2Bnqw/ek=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-ZQFtYpRDMVOgmRSQiMzv9Q-1; Wed, 20 Aug 2025 23:58:25 -0400
X-MC-Unique: ZQFtYpRDMVOgmRSQiMzv9Q-1
X-Mimecast-MFC-AGG-ID: ZQFtYpRDMVOgmRSQiMzv9Q_1755748704
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e931cb403daso928190276.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Aug 2025 20:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755748704; x=1756353504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s703x3NzoHysQ4hvh/o1YdVz59JrRP8nUyfiqri6GGA=;
        b=N2pUWtVHdrOa+Ovqdqd7f+qT5Sm3QLgKlymt60NiaLyNFrVW7qgm/ZZIoZ4xa+agQ2
         KNXs2UvjWezjoECGe7KxBx/t+5mV7nIKQt7SfI0Hcrq/KLrgTt+dBhSXSh7+Zc5+6aYL
         SnLLil4W9NMATluA7vvk4zIdzXBhde9vQa8jtPwAxqwpZFc5Wc7huUXXdshwev0eHOds
         eu26jduxyxEYzk95Ie6sa2g0aoR1AvcpbmQA2C2mxeEX+24MB2A41fUlZDNfUVTBR0jE
         1LtnChSsvNshZfbf7u0PFL6/nHaDTL2WgdbmTPMR6f3jdez6Xxa3aeJNeAyp0Cdqjy92
         hAGg==
X-Gm-Message-State: AOJu0YxfXhGHxunA15OWAMHaNmIiPx2YBHVPWx+DWVJAo4Xmrb97CIGj
	x85eF3nEL4WY4XuBoT1ktSseGTY5x6FgvBFcnPMsG/gFjhJgQXZz8o8FW7Qc5fkxbexSCbT9ivM
	ELtCZzYbA489nmmrKDeWXZyJ/0eQ7xneYKW5MIljKoVyI3gJ68LZhyzSoLZTdob8ipt1Q5AXwtp
	VCaYaywA==
X-Gm-Gg: ASbGncsFIoCSNuyxCVPjIZeHE1nnNsovJUNk+W0GDADLq8P5+n+/HG4TwM5ndss8qYZ
	fowSFmmy7cdAAcHSoq/D/fxSfzBCe+KT0+EaJ817QbgmDX8S9C9XJlD3pefuwGs3mnwz15/EBVr
	N8TYRuM5QtNb7MRYUKUy6onaJuLFXw5lz3dclEUYiV4CGQZ0zejj2TPcof/W5bXid/JUtlti7VU
	91bX49EFatdJgeEJr84KD7IqxbVLKgHgKtLCl/SnsMSOS/qx6YTBjK2um8uZ3qsmyaweWrrcHlj
	FCtWJw3E6/6QlwZ2IyXj0l8mYjDi2vAocELHcmxHz3/30mPc0qwYF1yLB146CTob7V/lrsw=
X-Received: by 2002:a05:6902:20c9:b0:e90:cc00:2e4b with SMTP id 3f1490d57ef6-e95088dd57amr1037114276.3.1755748703844;
        Wed, 20 Aug 2025 20:58:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTAGQj4+Zo5ZL0tfX4pRhTBnQf/AuRq3av4FvQDK/mseOhBZenZNhTwSNiaLUFVGBJ1vZ4Ew==
X-Received: by 2002:a05:6902:20c9:b0:e90:cc00:2e4b with SMTP id 3f1490d57ef6-e95088dd57amr1037103276.3.1755748703259;
        Wed, 20 Aug 2025 20:58:23 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e95078a1bdasm385457276.34.2025.08.20.20.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 20:58:22 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 2/7] tools/rtla: Move top/hist union members elsewhere
Date: Wed, 20 Aug 2025 22:57:14 -0500
Message-ID: <20250821035719.137161-3-crwood@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250821035719.137161-1-crwood@redhat.com>
References: <20250821035719.137161-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: thynQd2LdZuzq5tYcC8Hz-e0qhIHtDoopP2EWacYTaQ_1755748704
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The hist members were very similar between timerlat and top, so
just use one common hist struct.

output_divisor, quiet, and pretty printing are pretty generic
concepts that can go in the main struct even if not every
specific tool (currently) uses them.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 tools/tracing/rtla/src/common.h        |  17 ++++
 tools/tracing/rtla/src/osnoise.h       |  19 +---
 tools/tracing/rtla/src/osnoise_hist.c  |  59 ++++++------
 tools/tracing/rtla/src/osnoise_top.c   |  19 ++--
 tools/tracing/rtla/src/timerlat.h      |  22 +----
 tools/tracing/rtla/src/timerlat_bpf.c  |  14 +--
 tools/tracing/rtla/src/timerlat_hist.c | 127 +++++++++++++------------
 tools/tracing/rtla/src/timerlat_top.c  |  38 ++++----
 8 files changed, 152 insertions(+), 163 deletions(-)

diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index 0a44cfaa7c0b..276dfbc7f955 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -3,6 +3,17 @@
 
 #include "utils.h"
 
+struct hist_params {
+	char			no_irq;
+	char			no_thread;
+	char			no_header;
+	char			no_summary;
+	char			no_index;
+	char			with_zeros;
+	int			bucket_size;
+	int			entries;
+};
+
 /*
  * common_params - Parameters shared between timerlat_params and osnoise_params
  */
@@ -27,4 +38,10 @@ struct common_params {
 	char			*cgroup_name;
 	int			hk_cpus;
 	cpu_set_t		hk_cpu_set;
+
+	/* Other parameters */
+	struct hist_params	hist;
+	int			output_divisor;
+	int			pretty_output;
+	int			quiet;
 };
diff --git a/tools/tracing/rtla/src/osnoise.h b/tools/tracing/rtla/src/osnoise.h
index 0386bb50ffa1..b64b39de97b5 100644
--- a/tools/tracing/rtla/src/osnoise.h
+++ b/tools/tracing/rtla/src/osnoise.h
@@ -15,24 +15,7 @@ struct osnoise_params {
 	unsigned long long	runtime;
 	unsigned long long	period;
 	long long		threshold;
-	union {
-		struct {
-			/* top only */
-			int			quiet;
-			int			pretty_output;
-			enum osnoise_mode	mode;
-		};
-		struct {
-			/* hist only */
-			int			output_divisor;
-			char			no_header;
-			char			no_summary;
-			char			no_index;
-			char			with_zeros;
-			int			bucket_size;
-			int			entries;
-		};
-	};
+	enum osnoise_mode	mode;
 };
 
 /*
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 3fb9bb553498..a31ab9b4ab21 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -102,8 +102,8 @@ static void osnoise_hist_update_multiple(struct osnoise_tool *tool, int cpu,
 	int bucket;
 	int *hist;
 
-	if (params->output_divisor)
-		duration = duration / params->output_divisor;
+	if (params->common.output_divisor)
+		duration = duration / params->common.output_divisor;
 
 	bucket = duration / data->bucket_size;
 
@@ -146,7 +146,7 @@ static int osnoise_init_trace_hist(struct osnoise_tool *tool)
 	/*
 	 * Set the size of the bucket.
 	 */
-	bucket_size = params->output_divisor * params->bucket_size;
+	bucket_size = params->common.output_divisor * params->common.hist.bucket_size;
 	snprintf(buff, sizeof(buff), "duration.buckets=%d", bucket_size);
 
 	data->trace_hist = tracefs_hist_alloc(tool->trace.tep, "osnoise", "sample_threshold",
@@ -228,18 +228,18 @@ static void osnoise_hist_header(struct osnoise_tool *tool)
 	char duration[26];
 	int cpu;
 
-	if (params->no_header)
+	if (params->common.hist.no_header)
 		return;
 
 	get_duration(tool->start_time, duration, sizeof(duration));
 	trace_seq_printf(s, "# RTLA osnoise histogram\n");
 	trace_seq_printf(s, "# Time unit is %s (%s)\n",
-			params->output_divisor == 1 ? "nanoseconds" : "microseconds",
-			params->output_divisor == 1 ? "ns" : "us");
+			params->common.output_divisor == 1 ? "nanoseconds" : "microseconds",
+			params->common.output_divisor == 1 ? "ns" : "us");
 
 	trace_seq_printf(s, "# Duration: %s\n", duration);
 
-	if (!params->no_index)
+	if (!params->common.hist.no_index)
 		trace_seq_printf(s, "Index");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
@@ -267,10 +267,10 @@ osnoise_print_summary(struct osnoise_params *params,
 {
 	int cpu;
 
-	if (params->no_summary)
+	if (params->common.hist.no_summary)
 		return;
 
-	if (!params->no_index)
+	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "count:");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
@@ -284,7 +284,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	}
 	trace_seq_printf(trace->seq, "\n");
 
-	if (!params->no_index)
+	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "min:  ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
@@ -299,7 +299,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	}
 	trace_seq_printf(trace->seq, "\n");
 
-	if (!params->no_index)
+	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "avg:  ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
@@ -317,7 +317,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	}
 	trace_seq_printf(trace->seq, "\n");
 
-	if (!params->no_index)
+	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "max:  ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
@@ -352,7 +352,7 @@ osnoise_print_stats(struct osnoise_params *params, struct osnoise_tool *tool)
 	for (bucket = 0; bucket < data->entries; bucket++) {
 		total = 0;
 
-		if (!params->no_index)
+		if (!params->common.hist.no_index)
 			trace_seq_printf(trace->seq, "%-6d",
 					 bucket * data->bucket_size);
 
@@ -367,7 +367,7 @@ osnoise_print_stats(struct osnoise_params *params, struct osnoise_tool *tool)
 			trace_seq_printf(trace->seq, "%9d ", data->hist[cpu].samples[bucket]);
 		}
 
-		if (total == 0 && !params->with_zeros) {
+		if (total == 0 && !params->common.hist.with_zeros) {
 			trace_seq_reset(trace->seq);
 			continue;
 		}
@@ -391,7 +391,7 @@ osnoise_print_stats(struct osnoise_params *params, struct osnoise_tool *tool)
 		return;
 	}
 
-	if (!params->no_index)
+	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "over: ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
@@ -490,9 +490,9 @@ static struct osnoise_params
 		exit(1);
 
 	/* display data in microseconds */
-	params->output_divisor = 1000;
-	params->bucket_size = 1;
-	params->entries = 256;
+	params->common.output_divisor = 1000;
+	params->common.hist.bucket_size = 1;
+	params->common.hist.entries = 256;
 
 	while (1) {
 		static struct option long_options[] = {
@@ -547,8 +547,9 @@ static struct osnoise_params
 
 			break;
 		case 'b':
-			params->bucket_size = get_llong_from_str(optarg);
-			if ((params->bucket_size == 0) || (params->bucket_size >= 1000000))
+			params->common.hist.bucket_size = get_llong_from_str(optarg);
+			if (params->common.hist.bucket_size == 0 ||
+			    params->common.hist.bucket_size >= 1000000)
 				osnoise_hist_usage("Bucket size needs to be > 0 and <= 1000000\n");
 			break;
 		case 'c':
@@ -588,8 +589,9 @@ static struct osnoise_params
 			params->common.events = tevent;
 			break;
 		case 'E':
-			params->entries = get_llong_from_str(optarg);
-			if ((params->entries < 10) || (params->entries > 9999999))
+			params->common.hist.entries = get_llong_from_str(optarg);
+			if (params->common.hist.entries < 10 ||
+			    params->common.hist.entries > 9999999)
 				osnoise_hist_usage("Entries must be > 10 and < 9999999\n");
 			break;
 		case 'h':
@@ -641,16 +643,16 @@ static struct osnoise_params
 				params->trace_output = "osnoise_trace.txt";
 			break;
 		case '0': /* no header */
-			params->no_header = 1;
+			params->common.hist.no_header = 1;
 			break;
 		case '1': /* no summary */
-			params->no_summary = 1;
+			params->common.hist.no_summary = 1;
 			break;
 		case '2': /* no index */
-			params->no_index = 1;
+			params->common.hist.no_index = 1;
 			break;
 		case '3': /* with zeros */
-			params->with_zeros = 1;
+			params->common.hist.with_zeros = 1;
 			break;
 		case '4': /* trigger */
 			if (params->common.events) {
@@ -690,7 +692,7 @@ static struct osnoise_params
 		exit(EXIT_FAILURE);
 	}
 
-	if (params->no_index && !params->with_zeros)
+	if (params->common.hist.no_index && !params->common.hist.with_zeros)
 		osnoise_hist_usage("no-index set and with-zeros not set - it does not make sense");
 
 	return params;
@@ -729,7 +731,8 @@ static struct osnoise_tool
 	if (!tool)
 		return NULL;
 
-	tool->data = osnoise_alloc_histogram(nr_cpus, params->entries, params->bucket_size);
+	tool->data = osnoise_alloc_histogram(nr_cpus, params->common.hist.entries,
+					     params->common.hist.bucket_size);
 	if (!tool->data)
 		goto out_err;
 
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index ad5daa8210aa..7c68feed300e 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -125,11 +125,12 @@ static void osnoise_top_header(struct osnoise_tool *top)
 {
 	struct osnoise_params *params = top->params;
 	struct trace_seq *s = top->trace.seq;
+	bool pretty = params->common.pretty_output;
 	char duration[26];
 
 	get_duration(top->start_time, duration, sizeof(duration));
 
-	if (params->pretty_output)
+	if (pretty)
 		trace_seq_printf(s, "\033[2;37;40m");
 
 	trace_seq_printf(s, "                                          ");
@@ -143,13 +144,13 @@ static void osnoise_top_header(struct osnoise_tool *top)
 
 	trace_seq_printf(s, "                                   ");
 
-	if (params->pretty_output)
+	if (pretty)
 		trace_seq_printf(s, "\033[0;0;0m");
 	trace_seq_printf(s, "\n");
 
 	trace_seq_printf(s, "duration: %9s | time is in us\n", duration);
 
-	if (params->pretty_output)
+	if (pretty)
 		trace_seq_printf(s, "\033[2;30;47m");
 
 	trace_seq_printf(s, "CPU Period       Runtime ");
@@ -164,7 +165,7 @@ static void osnoise_top_header(struct osnoise_tool *top)
 	trace_seq_printf(s, "          IRQ      Softirq       Thread");
 
 eol:
-	if (params->pretty_output)
+	if (pretty)
 		trace_seq_printf(s, "\033[0;0;0m");
 	trace_seq_printf(s, "\n");
 }
@@ -232,7 +233,7 @@ osnoise_print_stats(struct osnoise_params *params, struct osnoise_tool *top)
 	if (nr_cpus == -1)
 		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
-	if (!params->quiet)
+	if (!params->common.quiet)
 		clear_terminal(trace->seq);
 
 	osnoise_top_header(top);
@@ -446,7 +447,7 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 			params->common.set_sched = 1;
 			break;
 		case 'q':
-			params->quiet = 1;
+			params->common.quiet = 1;
 			break;
 		case 'r':
 			params->runtime = get_llong_from_str(optarg);
@@ -534,8 +535,8 @@ osnoise_top_apply_config(struct osnoise_tool *tool, struct osnoise_params *param
 		}
 	}
 
-	if (isatty(STDOUT_FILENO) && !params->quiet)
-		params->pretty_output = 1;
+	if (isatty(STDOUT_FILENO) && !params->common.quiet)
+		params->common.pretty_output = 1;
 
 	return 0;
 
@@ -705,7 +706,7 @@ int osnoise_top_main(int argc, char **argv)
 			goto out_top;
 		}
 
-		if (!params->quiet)
+		if (!params->common.quiet)
 			osnoise_print_stats(params, tool);
 
 		if (osnoise_trace_is_off(tool, record))
diff --git a/tools/tracing/rtla/src/timerlat.h b/tools/tracing/rtla/src/timerlat.h
index dd9e0f05bdad..212ee7971bab 100644
--- a/tools/tracing/rtla/src/timerlat.h
+++ b/tools/tracing/rtla/src/timerlat.h
@@ -23,7 +23,6 @@ struct timerlat_params {
 	struct common_params	common;
 	long long		timerlat_period_us;
 	long long		print_stack;
-	int			output_divisor;
 	int			dma_latency;
 	int			no_aa;
 	int			dump_tasks;
@@ -31,30 +30,11 @@ struct timerlat_params {
 	int			kernel_workload;
 	int			user_data;
 	int			deepest_idle_state;
+	int			aa_only;
 	enum timerlat_tracing_mode mode;
 
 	struct actions threshold_actions;
 	struct actions end_actions;
-
-	union {
-		struct {
-			/* top only */
-			int			quiet;
-			int			aa_only;
-			int			pretty_output;
-		};
-		struct {
-			/* hist only */
-			char			no_irq;
-			char			no_thread;
-			char			no_header;
-			char			no_summary;
-			char			no_index;
-			char			with_zeros;
-			int			bucket_size;
-			int			entries;
-		};
-	};
 };
 
 int timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params);
diff --git a/tools/tracing/rtla/src/timerlat_bpf.c b/tools/tracing/rtla/src/timerlat_bpf.c
index a6c77ac55e00..03be2606f54a 100644
--- a/tools/tracing/rtla/src/timerlat_bpf.c
+++ b/tools/tracing/rtla/src/timerlat_bpf.c
@@ -21,20 +21,20 @@ int timerlat_bpf_init(struct timerlat_params *params)
 		return 1;
 
 	/* Pass common options */
-	bpf->rodata->output_divisor = params->output_divisor;
-	bpf->rodata->entries = params->entries;
+	bpf->rodata->output_divisor = params->common.output_divisor;
+	bpf->rodata->entries = params->common.hist.entries;
 	bpf->rodata->irq_threshold = params->common.stop_us;
 	bpf->rodata->thread_threshold = params->common.stop_total_us;
 	bpf->rodata->aa_only = params->aa_only;
 
-	if (params->entries != 0) {
+	if (params->common.hist.entries != 0) {
 		/* Pass histogram options */
-		bpf->rodata->bucket_size = params->bucket_size;
+		bpf->rodata->bucket_size = params->common.hist.bucket_size;
 
 		/* Set histogram array sizes */
-		bpf_map__set_max_entries(bpf->maps.hist_irq, params->entries);
-		bpf_map__set_max_entries(bpf->maps.hist_thread, params->entries);
-		bpf_map__set_max_entries(bpf->maps.hist_user, params->entries);
+		bpf_map__set_max_entries(bpf->maps.hist_irq, params->common.hist.entries);
+		bpf_map__set_max_entries(bpf->maps.hist_thread, params->common.hist.entries);
+		bpf_map__set_max_entries(bpf->maps.hist_user, params->common.hist.entries);
 	} else {
 		/* No entries, disable histogram */
 		bpf_map__set_autocreate(bpf->maps.hist_irq, false);
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index a3de644f2b75..4dc22a749885 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -141,8 +141,8 @@ timerlat_hist_update(struct osnoise_tool *tool, int cpu,
 	int bucket;
 	int *hist;
 
-	if (params->output_divisor)
-		latency = latency / params->output_divisor;
+	if (params->common.output_divisor)
+		latency = latency / params->common.output_divisor;
 
 	bucket = latency / data->bucket_size;
 
@@ -288,18 +288,18 @@ static void timerlat_hist_header(struct osnoise_tool *tool)
 	char duration[26];
 	int cpu;
 
-	if (params->no_header)
+	if (params->common.hist.no_header)
 		return;
 
 	get_duration(tool->start_time, duration, sizeof(duration));
 	trace_seq_printf(s, "# RTLA timerlat histogram\n");
 	trace_seq_printf(s, "# Time unit is %s (%s)\n",
-			params->output_divisor == 1 ? "nanoseconds" : "microseconds",
-			params->output_divisor == 1 ? "ns" : "us");
+			params->common.output_divisor == 1 ? "nanoseconds" : "microseconds",
+			params->common.output_divisor == 1 ? "ns" : "us");
 
 	trace_seq_printf(s, "# Duration: %s\n", duration);
 
-	if (!params->no_index)
+	if (!params->common.hist.no_index)
 		trace_seq_printf(s, "Index");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
@@ -309,10 +309,10 @@ static void timerlat_hist_header(struct osnoise_tool *tool)
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
 
-		if (!params->no_irq)
+		if (!params->common.hist.no_irq)
 			trace_seq_printf(s, "   IRQ-%03d", cpu);
 
-		if (!params->no_thread)
+		if (!params->common.hist.no_thread)
 			trace_seq_printf(s, "   Thr-%03d", cpu);
 
 		if (params->user_data)
@@ -350,10 +350,10 @@ timerlat_print_summary(struct timerlat_params *params,
 {
 	int cpu;
 
-	if (params->no_summary)
+	if (params->common.hist.no_summary)
 		return;
 
-	if (!params->no_index)
+	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "count:");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
@@ -363,11 +363,11 @@ timerlat_print_summary(struct timerlat_params *params,
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
 
-		if (!params->no_irq)
+		if (!params->common.hist.no_irq)
 			trace_seq_printf(trace->seq, "%9llu ",
 					data->hist[cpu].irq_count);
 
-		if (!params->no_thread)
+		if (!params->common.hist.no_thread)
 			trace_seq_printf(trace->seq, "%9llu ",
 					data->hist[cpu].thread_count);
 
@@ -377,7 +377,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	}
 	trace_seq_printf(trace->seq, "\n");
 
-	if (!params->no_index)
+	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "min:  ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
@@ -387,13 +387,13 @@ timerlat_print_summary(struct timerlat_params *params,
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
 
-		if (!params->no_irq)
+		if (!params->common.hist.no_irq)
 			format_summary_value(trace->seq,
 					     data->hist[cpu].irq_count,
 					     data->hist[cpu].min_irq,
 					     false);
 
-		if (!params->no_thread)
+		if (!params->common.hist.no_thread)
 			format_summary_value(trace->seq,
 					     data->hist[cpu].thread_count,
 					     data->hist[cpu].min_thread,
@@ -407,7 +407,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	}
 	trace_seq_printf(trace->seq, "\n");
 
-	if (!params->no_index)
+	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "avg:  ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
@@ -417,13 +417,13 @@ timerlat_print_summary(struct timerlat_params *params,
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
 
-		if (!params->no_irq)
+		if (!params->common.hist.no_irq)
 			format_summary_value(trace->seq,
 					     data->hist[cpu].irq_count,
 					     data->hist[cpu].sum_irq,
 					     true);
 
-		if (!params->no_thread)
+		if (!params->common.hist.no_thread)
 			format_summary_value(trace->seq,
 					     data->hist[cpu].thread_count,
 					     data->hist[cpu].sum_thread,
@@ -437,7 +437,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	}
 	trace_seq_printf(trace->seq, "\n");
 
-	if (!params->no_index)
+	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "max:  ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
@@ -447,13 +447,13 @@ timerlat_print_summary(struct timerlat_params *params,
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
 
-		if (!params->no_irq)
+		if (!params->common.hist.no_irq)
 			format_summary_value(trace->seq,
 					     data->hist[cpu].irq_count,
 					     data->hist[cpu].max_irq,
 					     false);
 
-		if (!params->no_thread)
+		if (!params->common.hist.no_thread)
 			format_summary_value(trace->seq,
 					     data->hist[cpu].thread_count,
 					     data->hist[cpu].max_thread,
@@ -479,7 +479,7 @@ timerlat_print_stats_all(struct timerlat_params *params,
 	struct timerlat_hist_cpu sum;
 	int cpu;
 
-	if (params->no_summary)
+	if (params->common.hist.no_summary)
 		return;
 
 	memset(&sum, 0, sizeof(sum));
@@ -512,13 +512,13 @@ timerlat_print_stats_all(struct timerlat_params *params,
 		update_max(&sum.max_user, &cpu_data->max_user);
 	}
 
-	if (!params->no_index)
+	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "ALL:  ");
 
-	if (!params->no_irq)
+	if (!params->common.hist.no_irq)
 		trace_seq_printf(trace->seq, "      IRQ");
 
-	if (!params->no_thread)
+	if (!params->common.hist.no_thread)
 		trace_seq_printf(trace->seq, "       Thr");
 
 	if (params->user_data)
@@ -526,14 +526,14 @@ timerlat_print_stats_all(struct timerlat_params *params,
 
 	trace_seq_printf(trace->seq, "\n");
 
-	if (!params->no_index)
+	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "count:");
 
-	if (!params->no_irq)
+	if (!params->common.hist.no_irq)
 		trace_seq_printf(trace->seq, "%9llu ",
 				 sum.irq_count);
 
-	if (!params->no_thread)
+	if (!params->common.hist.no_thread)
 		trace_seq_printf(trace->seq, "%9llu ",
 				 sum.thread_count);
 
@@ -543,16 +543,16 @@ timerlat_print_stats_all(struct timerlat_params *params,
 
 	trace_seq_printf(trace->seq, "\n");
 
-	if (!params->no_index)
+	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "min:  ");
 
-	if (!params->no_irq)
+	if (!params->common.hist.no_irq)
 		format_summary_value(trace->seq,
 				     sum.irq_count,
 				     sum.min_irq,
 				     false);
 
-	if (!params->no_thread)
+	if (!params->common.hist.no_thread)
 		format_summary_value(trace->seq,
 				     sum.thread_count,
 				     sum.min_thread,
@@ -566,16 +566,16 @@ timerlat_print_stats_all(struct timerlat_params *params,
 
 	trace_seq_printf(trace->seq, "\n");
 
-	if (!params->no_index)
+	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "avg:  ");
 
-	if (!params->no_irq)
+	if (!params->common.hist.no_irq)
 		format_summary_value(trace->seq,
 				     sum.irq_count,
 				     sum.sum_irq,
 				     true);
 
-	if (!params->no_thread)
+	if (!params->common.hist.no_thread)
 		format_summary_value(trace->seq,
 				     sum.thread_count,
 				     sum.sum_thread,
@@ -589,16 +589,16 @@ timerlat_print_stats_all(struct timerlat_params *params,
 
 	trace_seq_printf(trace->seq, "\n");
 
-	if (!params->no_index)
+	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "max:  ");
 
-	if (!params->no_irq)
+	if (!params->common.hist.no_irq)
 		format_summary_value(trace->seq,
 				     sum.irq_count,
 				     sum.max_irq,
 				     false);
 
-	if (!params->no_thread)
+	if (!params->common.hist.no_thread)
 		format_summary_value(trace->seq,
 				     sum.thread_count,
 				     sum.max_thread,
@@ -631,7 +631,7 @@ timerlat_print_stats(struct timerlat_params *params, struct osnoise_tool *tool)
 	for (bucket = 0; bucket < data->entries; bucket++) {
 		total = 0;
 
-		if (!params->no_index)
+		if (!params->common.hist.no_index)
 			trace_seq_printf(trace->seq, "%-6d",
 					 bucket * data->bucket_size);
 
@@ -642,13 +642,13 @@ timerlat_print_stats(struct timerlat_params *params, struct osnoise_tool *tool)
 			if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 				continue;
 
-			if (!params->no_irq) {
+			if (!params->common.hist.no_irq) {
 				total += data->hist[cpu].irq[bucket];
 				trace_seq_printf(trace->seq, "%9d ",
 						data->hist[cpu].irq[bucket]);
 			}
 
-			if (!params->no_thread) {
+			if (!params->common.hist.no_thread) {
 				total += data->hist[cpu].thread[bucket];
 				trace_seq_printf(trace->seq, "%9d ",
 						data->hist[cpu].thread[bucket]);
@@ -662,7 +662,7 @@ timerlat_print_stats(struct timerlat_params *params, struct osnoise_tool *tool)
 
 		}
 
-		if (total == 0 && !params->with_zeros) {
+		if (total == 0 && !params->common.hist.with_zeros) {
 			trace_seq_reset(trace->seq);
 			continue;
 		}
@@ -672,7 +672,7 @@ timerlat_print_stats(struct timerlat_params *params, struct osnoise_tool *tool)
 		trace_seq_reset(trace->seq);
 	}
 
-	if (!params->no_index)
+	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "over: ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
@@ -682,11 +682,11 @@ timerlat_print_stats(struct timerlat_params *params, struct osnoise_tool *tool)
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
 
-		if (!params->no_irq)
+		if (!params->common.hist.no_irq)
 			trace_seq_printf(trace->seq, "%9d ",
 					 data->hist[cpu].irq[data->entries]);
 
-		if (!params->no_thread)
+		if (!params->common.hist.no_thread)
 			trace_seq_printf(trace->seq, "%9d ",
 					 data->hist[cpu].thread[data->entries]);
 
@@ -804,9 +804,9 @@ static struct timerlat_params
 	params->deepest_idle_state = -2;
 
 	/* display data in microseconds */
-	params->output_divisor = 1000;
-	params->bucket_size = 1;
-	params->entries = 256;
+	params->common.output_divisor = 1000;
+	params->common.hist.bucket_size = 1;
+	params->common.hist.entries = 256;
 
 	/* default to BPF mode */
 	params->mode = TRACING_MODE_BPF;
@@ -894,8 +894,9 @@ static struct timerlat_params
 			}
 			break;
 		case 'b':
-			params->bucket_size = get_llong_from_str(optarg);
-			if ((params->bucket_size == 0) || (params->bucket_size >= 1000000))
+			params->common.hist.bucket_size = get_llong_from_str(optarg);
+			if (params->common.hist.bucket_size == 0 ||
+			    params->common.hist.bucket_size >= 1000000)
 				timerlat_hist_usage("Bucket size needs to be > 0 and <= 1000000\n");
 			break;
 		case 'D':
@@ -919,9 +920,10 @@ static struct timerlat_params
 			params->common.events = tevent;
 			break;
 		case 'E':
-			params->entries = get_llong_from_str(optarg);
-			if ((params->entries < 10) || (params->entries > 9999999))
-					timerlat_hist_usage("Entries must be > 10 and < 9999999\n");
+			params->common.hist.entries = get_llong_from_str(optarg);
+			if (params->common.hist.entries < 10 ||
+			    params->common.hist.entries > 9999999)
+				timerlat_hist_usage("Entries must be > 10 and < 9999999\n");
 			break;
 		case 'h':
 		case '?':
@@ -942,7 +944,7 @@ static struct timerlat_params
 			params->kernel_workload = 1;
 			break;
 		case 'n':
-			params->output_divisor = 1;
+			params->common.output_divisor = 1;
 			break;
 		case 'p':
 			params->timerlat_period_us = get_llong_from_str(optarg);
@@ -979,22 +981,22 @@ static struct timerlat_params
 			params->user_data = 1;
 			break;
 		case '0': /* no irq */
-			params->no_irq = 1;
+			params->common.hist.no_irq = 1;
 			break;
 		case '1': /* no thread */
-			params->no_thread = 1;
+			params->common.hist.no_thread = 1;
 			break;
 		case '2': /* no header */
-			params->no_header = 1;
+			params->common.hist.no_header = 1;
 			break;
 		case '3': /* no summary */
-			params->no_summary = 1;
+			params->common.hist.no_summary = 1;
 			break;
 		case '4': /* no index */
-			params->no_index = 1;
+			params->common.hist.no_index = 1;
 			break;
 		case '5': /* with zeros */
-			params->with_zeros = 1;
+			params->common.hist.with_zeros = 1;
 			break;
 		case '6': /* trigger */
 			if (params->common.events) {
@@ -1067,10 +1069,10 @@ static struct timerlat_params
 		exit(EXIT_FAILURE);
 	}
 
-	if (params->no_irq && params->no_thread)
+	if (params->common.hist.no_irq && params->common.hist.no_thread)
 		timerlat_hist_usage("no-irq and no-thread set, there is nothing to do here");
 
-	if (params->no_index && !params->with_zeros)
+	if (params->common.hist.no_index && !params->common.hist.with_zeros)
 		timerlat_hist_usage("no-index set with with-zeros is not set - it does not make sense");
 
 	/*
@@ -1127,7 +1129,8 @@ static struct osnoise_tool
 	if (!tool)
 		return NULL;
 
-	tool->data = timerlat_alloc_histogram(nr_cpus, params->entries, params->bucket_size);
+	tool->data = timerlat_alloc_histogram(nr_cpus, params->common.hist.entries,
+					      params->common.hist.bucket_size);
 	if (!tool->data)
 		goto out_err;
 
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 9fb60f4dd092..72be083d7d71 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -132,8 +132,8 @@ timerlat_top_update(struct osnoise_tool *tool, int cpu,
 	struct timerlat_top_data *data = tool->data;
 	struct timerlat_top_cpu *cpu_data = &data->cpu_data[cpu];
 
-	if (params->output_divisor)
-		latency = latency / params->output_divisor;
+	if (params->common.output_divisor)
+		latency = latency / params->common.output_divisor;
 
 	if (!thread) {
 		cpu_data->irq_count++;
@@ -258,39 +258,40 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 static void timerlat_top_header(struct timerlat_params *params, struct osnoise_tool *top)
 {
 	struct trace_seq *s = top->trace.seq;
+	bool pretty = params->common.pretty_output;
 	char duration[26];
 
 	get_duration(top->start_time, duration, sizeof(duration));
 
-	if (params->pretty_output)
+	if (pretty)
 		trace_seq_printf(s, "\033[2;37;40m");
 
 	trace_seq_printf(s, "                                     Timer Latency                                              ");
 	if (params->user_data)
 		trace_seq_printf(s, "                                         ");
 
-	if (params->pretty_output)
+	if (pretty)
 		trace_seq_printf(s, "\033[0;0;0m");
 	trace_seq_printf(s, "\n");
 
 	trace_seq_printf(s, "%-6s   |          IRQ Timer Latency (%s)        |         Thread Timer Latency (%s)", duration,
-			params->output_divisor == 1 ? "ns" : "us",
-			params->output_divisor == 1 ? "ns" : "us");
+			params->common.output_divisor == 1 ? "ns" : "us",
+			params->common.output_divisor == 1 ? "ns" : "us");
 
 	if (params->user_data) {
 		trace_seq_printf(s, "      |    Ret user Timer Latency (%s)",
-				params->output_divisor == 1 ? "ns" : "us");
+				params->common.output_divisor == 1 ? "ns" : "us");
 	}
 
 	trace_seq_printf(s, "\n");
-	if (params->pretty_output)
+	if (pretty)
 		trace_seq_printf(s, "\033[2;30;47m");
 
 	trace_seq_printf(s, "CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max");
 	if (params->user_data)
 		trace_seq_printf(s, " |      cur       min       avg       max");
 
-	if (params->pretty_output)
+	if (pretty)
 		trace_seq_printf(s, "\033[0;0;0m");
 	trace_seq_printf(s, "\n");
 }
@@ -449,7 +450,7 @@ timerlat_print_stats(struct timerlat_params *params, struct osnoise_tool *top)
 	if (nr_cpus == -1)
 		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
-	if (!params->quiet)
+	if (!params->common.quiet)
 		clear_terminal(trace->seq);
 
 	timerlat_top_reset_sum(&summary);
@@ -563,7 +564,7 @@ static struct timerlat_params
 	params->deepest_idle_state = -2;
 
 	/* display data in microseconds */
-	params->output_divisor = 1000;
+	params->common.output_divisor = 1000;
 
 	/* default to BPF mode */
 	params->mode = TRACING_MODE_BPF;
@@ -696,7 +697,7 @@ static struct timerlat_params
 			params->kernel_workload = true;
 			break;
 		case 'n':
-			params->output_divisor = 1;
+			params->common.output_divisor = 1;
 			break;
 		case 'p':
 			params->timerlat_period_us = get_llong_from_str(optarg);
@@ -710,7 +711,7 @@ static struct timerlat_params
 			params->common.set_sched = 1;
 			break;
 		case 'q':
-			params->quiet = 1;
+			params->common.quiet = 1;
 			break;
 		case 's':
 			params->print_stack = get_llong_from_str(optarg);
@@ -842,8 +843,8 @@ timerlat_top_apply_config(struct osnoise_tool *top, struct timerlat_params *para
 	if (retval)
 		goto out_err;
 
-	if (isatty(STDOUT_FILENO) && !params->quiet)
-		params->pretty_output = 1;
+	if (isatty(STDOUT_FILENO) && !params->common.quiet)
+		params->common.pretty_output = 1;
 
 	return 0;
 
@@ -942,7 +943,7 @@ timerlat_top_main_loop(struct osnoise_tool *top,
 			return retval;
 		}
 
-		if (!params->quiet)
+		if (!params->common.quiet)
 			timerlat_print_stats(params, top);
 
 		if (osnoise_trace_is_off(top, record)) {
@@ -992,7 +993,8 @@ timerlat_top_bpf_main_loop(struct osnoise_tool *top,
 
 	/* Pull and display data in a loop */
 	while (!stop_tracing) {
-		wait_retval = timerlat_bpf_wait(params->quiet ? -1 : params->common.sleep_time);
+		wait_retval = timerlat_bpf_wait(params->common.quiet ? -1 :
+						params->common.sleep_time);
 
 		retval = timerlat_top_bpf_pull_data(top);
 		if (retval) {
@@ -1000,7 +1002,7 @@ timerlat_top_bpf_main_loop(struct osnoise_tool *top,
 			return retval;
 		}
 
-		if (!params->quiet)
+		if (!params->common.quiet)
 			timerlat_print_stats(params, top);
 
 		if (wait_retval == 1) {
-- 
2.48.1

