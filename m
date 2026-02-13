Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389C429CE9
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Feb 2026 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770983586; cv=none; b=H8ZYilaVOmKYm52iDHZlSLusaq3OuEcPV/cRfP7o1LAtU6mE+StsAlX8QTMkDgCJOPqnTjPYbVB5NtxES7T1zLxkOUc2aWcZP3QJsx72j0aS4uetOG7EBkSbacHBTn6Ek7hDedaqzE6sAmP4P+2YL7RZZCObmxASa19xK1MJjJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770983586; c=relaxed/simple;
	bh=0GS+sGsKXEzx+jNnjrXhGcR2pmtCanW/2A8zyqvNC+o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=tBG58OyqSrnJJ9Yq1bvaS2iqlILayMuMQrHwQtQXyxSqu2KCA/N8M4NKd0uZqg7OGnboyQGQqJ1NDZADWNr6ttp23W2kbaaYd1ycZKcXZ7RSHztVAc/NZIjcezeB1MUJt2qn/sUTNAvrak3Qf5CdQkGm2ASaMjS7B64pAbqEoZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a7Yp7WrN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7Yp7WrN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770983584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=brymhXOpcI8ZGOoB0rH9K+9PTJHbZxRRnQAyHzspC9M=;
	b=a7Yp7WrNxatI7j31mFyeGSv4yt5wJ3kEGLFQwhA/bd/8YZyMt70iKIgZKzv3gR2WYUysOe
	FZPO70WJiksAJdMzZ67Qnxz9RW4lD2V5riqMV1LWvtCFtn3rUIPgCg1+X6sB0/tQqH5k2A
	QxX2TgrXUGmDFEpd4oISmbvNoH432zg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-N3TbTaYPOzinK9lkgnTG5Q-1; Fri, 13 Feb 2026 06:53:03 -0500
X-MC-Unique: N3TbTaYPOzinK9lkgnTG5Q-1
X-Mimecast-MFC-AGG-ID: N3TbTaYPOzinK9lkgnTG5Q_1770983582
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-483786a09b1so4956975e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Feb 2026 03:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770983582; x=1771588382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=brymhXOpcI8ZGOoB0rH9K+9PTJHbZxRRnQAyHzspC9M=;
        b=bA8kEmfvyDbNx0o8Rd/10dCg1qVmYXPDbhfYj2qp/0R4wAObmWONjEqka8ZiHhCLJB
         xw7yHB1qjDdGMrDur977aXCFynOIsAAIOttqH6aPJDJY+6RIC4OiId86bsTVVgKtpWwc
         BFoMoh8FY1ZoJgBtK7rLreLhCq0VdDiC0LCYv1+xaz+6te5bNToM5JKO6yHcjCsgI08B
         SiCKi6O5y0/anAhxcQVH+OQygxwaH5ZujBiKZ4I9/MwRPCA0dCbfa6HMZbaiyGzF1vOM
         /x1+4CZEJ/F44dY4EF//SELHh+k6x4ppXAjX14mSfT13UC5yZwjetwiWV267L2FlWq+f
         2C2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNfD5qk7OzvSImon5CpOhyslXyjTE1xupea37LJuPntSvJH3NNzM9EbLZ2gnNnbMwtr8tS5jvsFZ9f38+GYRb0Jtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWE75MG5xemtg7cFJL/LK7D9bwJH7CMY9Ma+uqUhGucKIuMbT2
	OekGnjTbf4AAccaetxQ7pUTg345Q7+EIsBzomdKw5ToWcVntBAGzIsMC74Y4h9JTqhytxSTvMNX
	YOKTcdU501NMDVwXkkNI2M0PaYyEOQWzacP9eoE5mu24gwmStWjL3E8gpoeg40mKtQzE1eSvJUA
	==
X-Gm-Gg: AZuq6aIOeAVEALf66xdfodRiFYPBzOk5E1G8ZTthGRGQjI6nzYJlpPdg7PJ5fP7uY/7
	veD4XPVE74nGzpLcI9GoumMyqSyyVHgE0OTEy6yg9gpHfOrhO3XsxQevq8huzD60XPvMTxw6O9X
	uAoyOt5rDVtswJBaFkn4Caw3UUBOupPo2YkG2ySrP0Aial/Q9cFnWCQEOJ9p+mDhvzOL1HyC/xb
	JhoQrrGu5Y+Hau7QAxjWlNcE2n8PHhYFBgk8MB5kYc8ifI+fUs2mN7QT369A7DJ7UIqAgOp+46z
	bg0DZI395zgNeHjycoDxybblHHlF0z/yXKrclCvhxmungCYRyQxF/AgGlYH1ZWsMRvb1IIqbWG8
	sln/ZxxfHXpftjh0conoc9KKu+ys8TXV2yq4=
X-Received: by 2002:a05:600c:5296:b0:482:eec4:74c with SMTP id 5b1f17b1804b1-48373a5d771mr22090225e9.22.1770983581817;
        Fri, 13 Feb 2026 03:53:01 -0800 (PST)
X-Received: by 2002:a05:600c:5296:b0:482:eec4:74c with SMTP id 5b1f17b1804b1-48373a5d771mr22089795e9.22.1770983581338;
        Fri, 13 Feb 2026 03:53:01 -0800 (PST)
Received: from costa-tp.bos2.lab ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d835f6bsm234671275e9.14.2026.02.13.03.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 03:53:00 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 2/5] tools/rtla: Remove unneeded nr_cpus arguments
Date: Fri, 13 Feb 2026 13:52:31 +0200
Message-ID: <20260213115234.430232-3-costa.shul@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260213115234.430232-1-costa.shul@redhat.com>
References: <20260213115234.430232-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OFmLx2k2606cot09Up0yorUJRh4OCLiwqMxLwKaGnQQ_1770983582
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

nr_cpus does not change at runtime, so passing it through function
arguments is unnecessary.

Use the global nr_cpus instead of propagating it via parameters.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/osnoise_hist.c  |  4 ++--
 tools/tracing/rtla/src/osnoise_top.c   |  4 ++--
 tools/tracing/rtla/src/timerlat_bpf.c  |  5 ++---
 tools/tracing/rtla/src/timerlat_bpf.h  |  6 ++----
 tools/tracing/rtla/src/timerlat_hist.c | 19 +++++++------------
 tools/tracing/rtla/src/timerlat_top.c  | 19 +++++++------------
 tools/tracing/rtla/src/timerlat_u.c    |  6 +++---
 7 files changed, 25 insertions(+), 38 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 03ebff34fff4..d83ee047a5f5 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -62,7 +62,7 @@ static void osnoise_free_hist_tool(struct osnoise_tool *tool)
  * osnoise_alloc_histogram - alloc runtime data
  */
 static struct osnoise_hist_data
-*osnoise_alloc_histogram(int nr_cpus, int entries, int bucket_size)
+*osnoise_alloc_histogram(int entries, int bucket_size)
 {
 	struct osnoise_hist_data *data;
 	int cpu;
@@ -652,7 +652,7 @@ static struct osnoise_tool
 	if (!tool)
 		return NULL;
 
-	tool->data = osnoise_alloc_histogram(nr_cpus, params->hist.entries,
+	tool->data = osnoise_alloc_histogram(params->hist.entries,
 					     params->hist.bucket_size);
 	if (!tool->data)
 		goto out_err;
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 7dcd2e318205..73b3ac0dd43b 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -51,7 +51,7 @@ static void osnoise_free_top_tool(struct osnoise_tool *tool)
 /*
  * osnoise_alloc_histogram - alloc runtime data
  */
-static struct osnoise_top_data *osnoise_alloc_top(int nr_cpus)
+static struct osnoise_top_data *osnoise_alloc_top(void)
 {
 	struct osnoise_top_data *data;
 
@@ -496,7 +496,7 @@ struct osnoise_tool *osnoise_init_top(struct common_params *params)
 	if (!tool)
 		return NULL;
 
-	tool->data = osnoise_alloc_top(nr_cpus);
+	tool->data = osnoise_alloc_top();
 	if (!tool->data) {
 		osnoise_destroy_tool(tool);
 		return NULL;
diff --git a/tools/tracing/rtla/src/timerlat_bpf.c b/tools/tracing/rtla/src/timerlat_bpf.c
index 05adf18303df..8d5c3a095e41 100644
--- a/tools/tracing/rtla/src/timerlat_bpf.c
+++ b/tools/tracing/rtla/src/timerlat_bpf.c
@@ -191,13 +191,12 @@ int timerlat_bpf_get_hist_value(int key,
 int timerlat_bpf_get_summary_value(enum summary_field key,
 				   long long *value_irq,
 				   long long *value_thread,
-				   long long *value_user,
-				   int cpus)
+				   long long *value_user)
 {
 	return get_value(bpf->maps.summary_irq,
 			 bpf->maps.summary_thread,
 			 bpf->maps.summary_user,
-			 key, value_irq, value_thread, value_user, cpus);
+			 key, value_irq, value_thread, value_user, nr_cpus);
 }
 
 /*
diff --git a/tools/tracing/rtla/src/timerlat_bpf.h b/tools/tracing/rtla/src/timerlat_bpf.h
index 169abeaf4363..f4a5476f2abb 100644
--- a/tools/tracing/rtla/src/timerlat_bpf.h
+++ b/tools/tracing/rtla/src/timerlat_bpf.h
@@ -28,8 +28,7 @@ int timerlat_bpf_get_hist_value(int key,
 int timerlat_bpf_get_summary_value(enum summary_field key,
 				   long long *value_irq,
 				   long long *value_thread,
-				   long long *value_user,
-				   int cpus);
+				   long long *value_user);
 int timerlat_load_bpf_action_program(const char *program_path);
 static inline int have_libbpf_support(void) { return 1; }
 #else
@@ -53,8 +52,7 @@ static inline int timerlat_bpf_get_hist_value(int key,
 static inline int timerlat_bpf_get_summary_value(enum summary_field key,
 						 long long *value_irq,
 						 long long *value_thread,
-						 long long *value_user,
-						 int cpus)
+						 long long *value_user)
 {
 	return -1;
 }
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 841118ed84f2..dee5fbf622c3 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -83,7 +83,7 @@ static void timerlat_free_histogram_tool(struct osnoise_tool *tool)
  * timerlat_alloc_histogram - alloc runtime data
  */
 static struct timerlat_hist_data
-*timerlat_alloc_histogram(int nr_cpus, int entries, int bucket_size)
+*timerlat_alloc_histogram(int entries, int bucket_size)
 {
 	struct timerlat_hist_data *data;
 	int cpu;
@@ -223,8 +223,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 
 	/* Pull summary */
 	err = timerlat_bpf_get_summary_value(SUMMARY_COUNT,
-					     value_irq, value_thread, value_user,
-					     data->nr_cpus);
+					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
 	for (i = 0; i < data->nr_cpus; i++) {
@@ -234,8 +233,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 	}
 
 	err = timerlat_bpf_get_summary_value(SUMMARY_MIN,
-					     value_irq, value_thread, value_user,
-					     data->nr_cpus);
+					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
 	for (i = 0; i < data->nr_cpus; i++) {
@@ -245,8 +243,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 	}
 
 	err = timerlat_bpf_get_summary_value(SUMMARY_MAX,
-					     value_irq, value_thread, value_user,
-					     data->nr_cpus);
+					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
 	for (i = 0; i < data->nr_cpus; i++) {
@@ -256,8 +253,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 	}
 
 	err = timerlat_bpf_get_summary_value(SUMMARY_SUM,
-					     value_irq, value_thread, value_user,
-					     data->nr_cpus);
+					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
 	for (i = 0; i < data->nr_cpus; i++) {
@@ -267,8 +263,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 	}
 
 	err = timerlat_bpf_get_summary_value(SUMMARY_OVERFLOW,
-					     value_irq, value_thread, value_user,
-					     data->nr_cpus);
+					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
 	for (i = 0; i < data->nr_cpus; i++) {
@@ -1036,7 +1031,7 @@ static struct osnoise_tool
 	if (!tool)
 		return NULL;
 
-	tool->data = timerlat_alloc_histogram(nr_cpus, params->hist.entries,
+	tool->data = timerlat_alloc_histogram(params->hist.entries,
 					      params->hist.bucket_size);
 	if (!tool->data)
 		goto out_err;
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 3e395ce4fa9f..25b4d81b4fe0 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -62,7 +62,7 @@ static void timerlat_free_top_tool(struct osnoise_tool *tool)
 /*
  * timerlat_alloc_histogram - alloc runtime data
  */
-static struct timerlat_top_data *timerlat_alloc_top(int nr_cpus)
+static struct timerlat_top_data *timerlat_alloc_top(void)
 {
 	struct timerlat_top_data *data;
 	int cpu;
@@ -196,8 +196,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 
 	/* Pull summary */
 	err = timerlat_bpf_get_summary_value(SUMMARY_CURRENT,
-					     value_irq, value_thread, value_user,
-					     data->nr_cpus);
+					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
 	for (i = 0; i < data->nr_cpus; i++) {
@@ -207,8 +206,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 	}
 
 	err = timerlat_bpf_get_summary_value(SUMMARY_COUNT,
-					     value_irq, value_thread, value_user,
-					     data->nr_cpus);
+					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
 	for (i = 0; i < data->nr_cpus; i++) {
@@ -218,8 +216,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 	}
 
 	err = timerlat_bpf_get_summary_value(SUMMARY_MIN,
-					     value_irq, value_thread, value_user,
-					     data->nr_cpus);
+					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
 	for (i = 0; i < data->nr_cpus; i++) {
@@ -229,8 +226,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 	}
 
 	err = timerlat_bpf_get_summary_value(SUMMARY_MAX,
-					     value_irq, value_thread, value_user,
-					     data->nr_cpus);
+					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
 	for (i = 0; i < data->nr_cpus; i++) {
@@ -240,8 +236,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 	}
 
 	err = timerlat_bpf_get_summary_value(SUMMARY_SUM,
-					     value_irq, value_thread, value_user,
-					     data->nr_cpus);
+					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
 	for (i = 0; i < data->nr_cpus; i++) {
@@ -782,7 +777,7 @@ static struct osnoise_tool
 	if (!top)
 		return NULL;
 
-	top->data = timerlat_alloc_top(nr_cpus);
+	top->data = timerlat_alloc_top();
 	if (!top->data)
 		goto out_err;
 
diff --git a/tools/tracing/rtla/src/timerlat_u.c b/tools/tracing/rtla/src/timerlat_u.c
index a569fe7f93aa..03b4e68e8b1e 100644
--- a/tools/tracing/rtla/src/timerlat_u.c
+++ b/tools/tracing/rtla/src/timerlat_u.c
@@ -99,7 +99,7 @@ static int timerlat_u_main(int cpu, struct timerlat_u_params *params)
  *
  * Return the number of processes that received the kill.
  */
-static int timerlat_u_send_kill(pid_t *procs, int nr_cpus)
+static int timerlat_u_send_kill(pid_t *procs)
 {
 	int killed = 0;
 	int i, retval;
@@ -169,7 +169,7 @@ void *timerlat_u_dispatcher(void *data)
 
 		/* parent */
 		if (pid == -1) {
-			timerlat_u_send_kill(procs, nr_cpus);
+			timerlat_u_send_kill(procs);
 			debug_msg("Failed to create child processes");
 			pthread_exit(&retval);
 		}
@@ -196,7 +196,7 @@ void *timerlat_u_dispatcher(void *data)
 		sleep(1);
 	}
 
-	timerlat_u_send_kill(procs, nr_cpus);
+	timerlat_u_send_kill(procs);
 
 	while (procs_count) {
 		pid = waitpid(-1, &wstatus, 0);
-- 
2.52.0

