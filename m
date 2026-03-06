Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA1B430B8F
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Mar 2026 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772826871; cv=none; b=pekdMGfLN1zZh7iF9u0LIlbI8TF35BXrpOHT51zq1EXvwzzcNul2E9P8rCltKfqBhEnexUpwuO+yV2E4Kl+nIVRivzb/XrK6hUABXIwKRJwFo7w952kck8MmWedtNqluieaeBS2XU7S91/hNru8p5FjY/NxlqxJbo2g3e+mrC4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772826871; c=relaxed/simple;
	bh=6to0dfrAh3XjTCSonSgtXalBKtCubLPLIEWU1ztAl+A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=uYijg6OINtFzf83i/MYWf9rA7AQRzzesKRpTiNNpFWX9Ba1Zk9B0NVIAlrmWPFLWJqClEmjmnpcVmbLn7Y7DhZa8YTUgUY1KwPBeWZncsSek2YJS4HOtgKmOvzcDUpnL4w/y/bQRAueBmQ5pyrM51y1CQWzIB+GsjQKzsTTAhXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cyTebRLT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cyTebRLT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772826868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zVtg1Z0m8Jaq2J1pJ1SVX/vA+T31djcwB6wnVu1yPyc=;
	b=cyTebRLTGXcNceTPbOVokuMjc3nSoexx2umv0CG9u+XTGiGz623nlcVXpwdAAzRPY4+Z5t
	sdFveQ3I2+MUXLA0I9t2tmWfQBWkQcKOirlvL7b4w65HBtM+ChfYcar4l2zQdora9RIT4q
	Jmrwb7kQfLYtNMYCIGgxQOlY3no2Cro=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-DyP-tUKNOneK2giHTE2trg-1; Fri, 06 Mar 2026 14:54:24 -0500
X-MC-Unique: DyP-tUKNOneK2giHTE2trg-1
X-Mimecast-MFC-AGG-ID: DyP-tUKNOneK2giHTE2trg_1772826862
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4839fc4cef6so95389525e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Mar 2026 11:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772826862; x=1773431662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zVtg1Z0m8Jaq2J1pJ1SVX/vA+T31djcwB6wnVu1yPyc=;
        b=i0oyXfFPPCzXoxbzfdKOAauMJBsk3PWqqVNE6CrcllyIdmQ1svXoYLL3e39VptdbcX
         pHUZcrmd3ioM1qOxx32Ufsz4Yxg73tVPeZded+KuaQrIqtfTgFKF8WDRoHjhcjqBiXJe
         90gNY6R+ZoqxM2PqKhYouczjx5kWLychgRPzcMHbqhIYCv25oEqvTEQdosBnbw22t7PZ
         wNahgaYPPK5rG3qRdgytjrgwE1dFNelu9Bntj+OLe5uDxQlphxEkTGDrX8uwnPggtkzj
         irPVbBM23lMKk4UipLAt5UcxwP0UcTvJ39DLJEY9+x0xIcp1ZyDNmP++YY5xB0iSFQLO
         7Log==
X-Forwarded-Encrypted: i=1; AJvYcCX7q/r/Kpv4mN/CmX3XZRK4nBL64yWv5v4LL7K/8colUmKSB2pCk9aF9BVx7DTYFekBIuB6dcSurmQu3DqXmAhYIWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxqus41Ct42FB42wNz8L/7Fo2fOA8xFaQL9CKvXQ6vhFWOrSne
	wMpCfZrKJPdLoeIVIiVq1EQpRYy3F2YhlmDvJYTDAvlDXG+IRIveYf8D+mV/qfeDh79lI4STxGA
	kHW2DCa6Z7PZofuEO3UwII0d9s+dwgJlOlsPf6z6q8tdpfcbUzlkFBf7r84ZAouAsEjvJ0e4xFQ
	==
X-Gm-Gg: ATEYQzwBb0DqLZEAZo1UWX8JlEOVC+vyjLFlrQLYvTyGPaHjpv3tDYs7ryN+uDg0RB4
	eDGcRRQ1gMIjQeLVhEI2gCNNmIB3KpRIEwX/5IgBpl0Yw6MkhuHw9cYES7yajy/DIIY6QgnYt7h
	ECyfPY/z/ONyyLKQ2PQbVWQgkJaGPAPXZZwRTRoCUM1bduI5Vkw6dpd9fhP+TAFR1Bw0iMeWgN4
	6nfOF2xTPN0xdvQeE1nGvt2dOHp3FcWuinh7iW+q54kG0GOPMYCeu72XkIzVS1R5UmTC5sdBiPB
	qOQPvUEhawZIOqnf/dc5jv1dXpoRgysIiZ1xpezvGBjJRAgmlUnaGpGZu/+VzvhvmSgsEWauTOM
	NqHLuendtMxvaUqNY1YJ6PZhXQ+We/UdSp1Xy3Q==
X-Received: by 2002:a05:600c:1e88:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-48526759d12mr62794565e9.15.1772826862004;
        Fri, 06 Mar 2026 11:54:22 -0800 (PST)
X-Received: by 2002:a05:600c:1e88:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-48526759d12mr62794165e9.15.1772826861464;
        Fri, 06 Mar 2026 11:54:21 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485276b75eesm48596485e9.14.2026.03.06.11.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 11:54:21 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v4 3/4] tools/rtla: Remove unneeded nr_cpus members
Date: Fri,  6 Mar 2026 21:49:51 +0200
Message-ID: <20260306194953.2511960-4-costa.shul@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306194953.2511960-1-costa.shul@redhat.com>
References: <20260306194953.2511960-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tzLD5s-zLvtjk7e_Ag73yQLl5nmk0ISK5BoFUel2TGo_1772826862
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

nr_cpus does not change at runtime, so keeping it in struct members is
unnecessary.

Use the global nr_cpus instead of struct members.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/osnoise_hist.c  | 18 ++++++------
 tools/tracing/rtla/src/osnoise_top.c   |  3 --
 tools/tracing/rtla/src/timerlat_aa.c   | 10 +++----
 tools/tracing/rtla/src/timerlat_hist.c | 38 ++++++++++++--------------
 tools/tracing/rtla/src/timerlat_top.c  | 19 ++++++-------
 5 files changed, 38 insertions(+), 50 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index f39f60d3b00e..5bbec27b46a7 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -29,7 +29,6 @@ struct osnoise_hist_data {
 	struct osnoise_hist_cpu	*hist;
 	int			entries;
 	int			bucket_size;
-	int			nr_cpus;
 };
 
 /*
@@ -41,7 +40,7 @@ osnoise_free_histogram(struct osnoise_hist_data *data)
 	int cpu;
 
 	/* one histogram for IRQ and one for thread, per CPU */
-	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
 		if (data->hist[cpu].samples)
 			free(data->hist[cpu].samples);
 	}
@@ -73,7 +72,6 @@ static struct osnoise_hist_data
 
 	data->entries = entries;
 	data->bucket_size = bucket_size;
-	data->nr_cpus = nr_cpus;
 
 	data->hist = calloc(1, sizeof(*data->hist) * nr_cpus);
 	if (!data->hist)
@@ -246,7 +244,7 @@ static void osnoise_hist_header(struct osnoise_tool *tool)
 	if (!params->common.hist.no_index)
 		trace_seq_printf(s, "Index");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -275,7 +273,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "count:");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -287,7 +285,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "min:  ");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -300,7 +298,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "avg:  ");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -316,7 +314,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "max:  ");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -351,7 +349,7 @@ osnoise_print_stats(struct osnoise_tool *tool)
 			trace_seq_printf(trace->seq, "%-6d",
 					 bucket * data->bucket_size);
 
-		for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+		for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 			if (!data->hist[cpu].count)
 				continue;
@@ -387,7 +385,7 @@ osnoise_print_stats(struct osnoise_tool *tool)
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "over: ");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 3a241b69f622..672cdb254f4c 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -31,7 +31,6 @@ struct osnoise_top_cpu {
 
 struct osnoise_top_data {
 	struct osnoise_top_cpu	*cpu_data;
-	int			nr_cpus;
 };
 
 /*
@@ -59,8 +58,6 @@ static struct osnoise_top_data *osnoise_alloc_top(void)
 	if (!data)
 		return NULL;
 
-	data->nr_cpus = nr_cpus;
-
 	/* one set of histograms per CPU */
 	data->cpu_data = calloc(1, sizeof(*data->cpu_data) * nr_cpus);
 	if (!data->cpu_data)
diff --git a/tools/tracing/rtla/src/timerlat_aa.c b/tools/tracing/rtla/src/timerlat_aa.c
index 095483375823..41d8d48c5b41 100644
--- a/tools/tracing/rtla/src/timerlat_aa.c
+++ b/tools/tracing/rtla/src/timerlat_aa.c
@@ -102,7 +102,6 @@ struct timerlat_aa_data {
  * The analysis context and system wide view
  */
 struct timerlat_aa_context {
-	int nr_cpus;
 	int dump_tasks;
 	enum stack_format stack_format;
 
@@ -759,7 +758,7 @@ void timerlat_auto_analysis(int irq_thresh, int thread_thresh)
 	irq_thresh = irq_thresh * 1000;
 	thread_thresh = thread_thresh * 1000;
 
-	for (cpu = 0; cpu < taa_ctx->nr_cpus; cpu++) {
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
 		taa_data = timerlat_aa_get_data(taa_ctx, cpu);
 
 		if (irq_thresh && taa_data->tlat_irq_latency >= irq_thresh) {
@@ -787,7 +786,7 @@ void timerlat_auto_analysis(int irq_thresh, int thread_thresh)
 
 	printf("\n");
 	printf("Printing CPU tasks:\n");
-	for (cpu = 0; cpu < taa_ctx->nr_cpus; cpu++) {
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
 		taa_data = timerlat_aa_get_data(taa_ctx, cpu);
 		tep = taa_ctx->tool->trace.tep;
 
@@ -813,7 +812,7 @@ static void timerlat_aa_destroy_seqs(struct timerlat_aa_context *taa_ctx)
 	if (!taa_ctx->taa_data)
 		return;
 
-	for (i = 0; i < taa_ctx->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		taa_data = timerlat_aa_get_data(taa_ctx, i);
 
 		if (taa_data->prev_irqs_seq) {
@@ -863,7 +862,7 @@ static int timerlat_aa_init_seqs(struct timerlat_aa_context *taa_ctx)
 	struct timerlat_aa_data *taa_data;
 	int i;
 
-	for (i = 0; i < taa_ctx->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 
 		taa_data = timerlat_aa_get_data(taa_ctx, i);
 
@@ -1052,7 +1051,6 @@ int timerlat_aa_init(struct osnoise_tool *tool, int dump_tasks, enum stack_forma
 
 	__timerlat_aa_ctx = taa_ctx;
 
-	taa_ctx->nr_cpus = nr_cpus;
 	taa_ctx->tool = tool;
 	taa_ctx->dump_tasks = dump_tasks;
 	taa_ctx->stack_format = stack_format;
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 7e735b62488c..cfb745b75b8a 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -44,7 +44,6 @@ struct timerlat_hist_data {
 	struct timerlat_hist_cpu	*hist;
 	int				entries;
 	int				bucket_size;
-	int				nr_cpus;
 };
 
 /*
@@ -56,7 +55,7 @@ timerlat_free_histogram(struct timerlat_hist_data *data)
 	int cpu;
 
 	/* one histogram for IRQ and one for thread, per CPU */
-	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
 		if (data->hist[cpu].irq)
 			free(data->hist[cpu].irq);
 
@@ -94,7 +93,6 @@ static struct timerlat_hist_data
 
 	data->entries = entries;
 	data->bucket_size = bucket_size;
-	data->nr_cpus = nr_cpus;
 
 	/* one set of histograms per CPU */
 	data->hist = calloc(1, sizeof(*data->hist) * nr_cpus);
@@ -204,9 +202,9 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 {
 	struct timerlat_hist_data *data = tool->data;
 	int i, j, err;
-	long long value_irq[data->nr_cpus],
-		  value_thread[data->nr_cpus],
-		  value_user[data->nr_cpus];
+	long long value_irq[nr_cpus],
+		  value_thread[nr_cpus],
+		  value_user[nr_cpus];
 
 	/* Pull histogram */
 	for (i = 0; i < data->entries; i++) {
@@ -214,7 +212,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 						  value_user);
 		if (err)
 			return err;
-		for (j = 0; j < data->nr_cpus; j++) {
+		for (j = 0; j < nr_cpus; j++) {
 			data->hist[j].irq[i] = value_irq[j];
 			data->hist[j].thread[i] = value_thread[j];
 			data->hist[j].user[i] = value_user[j];
@@ -226,7 +224,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->hist[i].irq_count = value_irq[i];
 		data->hist[i].thread_count = value_thread[i];
 		data->hist[i].user_count = value_user[i];
@@ -236,7 +234,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->hist[i].min_irq = value_irq[i];
 		data->hist[i].min_thread = value_thread[i];
 		data->hist[i].min_user = value_user[i];
@@ -246,7 +244,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->hist[i].max_irq = value_irq[i];
 		data->hist[i].max_thread = value_thread[i];
 		data->hist[i].max_user = value_user[i];
@@ -256,7 +254,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->hist[i].sum_irq = value_irq[i];
 		data->hist[i].sum_thread = value_thread[i];
 		data->hist[i].sum_user = value_user[i];
@@ -266,7 +264,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->hist[i].irq[data->entries] = value_irq[i];
 		data->hist[i].thread[data->entries] = value_thread[i];
 		data->hist[i].user[data->entries] = value_user[i];
@@ -300,7 +298,7 @@ static void timerlat_hist_header(struct osnoise_tool *tool)
 	if (!params->common.hist.no_index)
 		trace_seq_printf(s, "Index");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -352,7 +350,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "count:");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -374,7 +372,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "min:  ");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -402,7 +400,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "avg:  ");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -430,7 +428,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "max:  ");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -475,7 +473,7 @@ timerlat_print_stats_all(struct timerlat_params *params,
 	sum.min_thread = ~0;
 	sum.min_user = ~0;
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -622,7 +620,7 @@ timerlat_print_stats(struct osnoise_tool *tool)
 			trace_seq_printf(trace->seq, "%-6d",
 					 bucket * data->bucket_size);
 
-		for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+		for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 			if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 				continue;
@@ -660,7 +658,7 @@ timerlat_print_stats(struct osnoise_tool *tool)
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "over: ");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 994e89a57cd3..8fad4edb0d72 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -41,7 +41,6 @@ struct timerlat_top_cpu {
 
 struct timerlat_top_data {
 	struct timerlat_top_cpu	*cpu_data;
-	int			nr_cpus;
 };
 
 /*
@@ -71,8 +70,6 @@ static struct timerlat_top_data *timerlat_alloc_top(void)
 	if (!data)
 		return NULL;
 
-	data->nr_cpus = nr_cpus;
-
 	/* one set of histograms per CPU */
 	data->cpu_data = calloc(1, sizeof(*data->cpu_data) * nr_cpus);
 	if (!data->cpu_data)
@@ -190,16 +187,16 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 {
 	struct timerlat_top_data *data = tool->data;
 	int i, err;
-	long long value_irq[data->nr_cpus],
-		  value_thread[data->nr_cpus],
-		  value_user[data->nr_cpus];
+	long long value_irq[nr_cpus],
+		  value_thread[nr_cpus],
+		  value_user[nr_cpus];
 
 	/* Pull summary */
 	err = timerlat_bpf_get_summary_value(SUMMARY_CURRENT,
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->cpu_data[i].cur_irq = value_irq[i];
 		data->cpu_data[i].cur_thread = value_thread[i];
 		data->cpu_data[i].cur_user = value_user[i];
@@ -209,7 +206,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->cpu_data[i].irq_count = value_irq[i];
 		data->cpu_data[i].thread_count = value_thread[i];
 		data->cpu_data[i].user_count = value_user[i];
@@ -219,7 +216,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->cpu_data[i].min_irq = value_irq[i];
 		data->cpu_data[i].min_thread = value_thread[i];
 		data->cpu_data[i].min_user = value_user[i];
@@ -229,7 +226,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->cpu_data[i].max_irq = value_irq[i];
 		data->cpu_data[i].max_thread = value_thread[i];
 		data->cpu_data[i].max_user = value_user[i];
@@ -239,7 +236,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->cpu_data[i].sum_irq = value_irq[i];
 		data->cpu_data[i].sum_thread = value_thread[i];
 		data->cpu_data[i].sum_user = value_user[i];
-- 
2.53.0

