Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C5D358D0F
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Dec 2025 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947999; cv=none; b=BXKSNgqVVxtSzJiqhH8Aji9zU590pVCOAKtd4G7y/0fKknoyQH/li8A/Jv6GiZ/V7AugHy54Pk1g92ywRz9FCyiO1KR5cat1lFJPAJksAl1O53ssHo7qrHKmLMutNmT3WyLuLpnW2fZMCZ+4SB3bB/BOoyF9DO5/YSonBBME0Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947999; c=relaxed/simple;
	bh=fqkDclscetl1onzDkAYTGMs5/xfnJigxLB8w63vxu38=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=iCV9ZRkzXcfhQEJSOpx//huqFfvhd2pjxZYq7IfK8p7mMuSENLjTkkygZdfrd84UOLJPQ27UItZjPxVgkvS9vLKsriMArGeP48q3HicZz3eK550H4UquBfm81x4tTBHNW3f/QjaGCE0zNy7RVle5lTWl7EuEAlIPBAHOp7TD8LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P7ZSPSbZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7ZSPSbZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764947994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OoCD2KwltZzGeGT9ov3HcxpnEQgu1EpiOMCYmtKAx+k=;
	b=P7ZSPSbZ2rRWTv/UbiceN+wodvK/OezSRWxYEcOvyzByqRJRDKKZGcnU8gN3f9xcytaO8k
	e6MDAz6WfyG8iJStjx4CALEGYzFzpamzbg0JfDZU6wxMi9NNQrqo45VCzIJF3isrbI1i4q
	UFI5V/v8ax30pFomb4nUdsoclKbMb0s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-GWlwp28dMDWBj7sSRkcaZw-1; Fri, 05 Dec 2025 10:19:49 -0500
X-MC-Unique: GWlwp28dMDWBj7sSRkcaZw-1
X-Mimecast-MFC-AGG-ID: GWlwp28dMDWBj7sSRkcaZw_1764947988
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477cf2230c8so20420225e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Dec 2025 07:19:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764947988; x=1765552788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OoCD2KwltZzGeGT9ov3HcxpnEQgu1EpiOMCYmtKAx+k=;
        b=XYbQ98nLHfIw9QCQ5Od8IpptZDo8yCQMgrkIueXP4Zk6KHlZPzknHQlu63d2xRS3as
         96rwSWwyepG0gxQZkrYF8GkveYmBshMc1HEVDJC2bkVXzzz9XCvNwSw552Q+C4VTNCq6
         ltVsQd5G+xOKkVfPORZo+6D+kzUz+IrL0y8mJIjWpkpKgqWBb6hDHJmgu2Te9tydGw8q
         ubLwzFBoTZGOAbElyJ0vVDUgH31Xs1W3dYNXbn6eiHy39x2dQXYtFktOkh426V+y2KRz
         qezunTetV0LbxO89ig94aABJOVG49Sp36tN8GGCItbRmSLRNDUjwgKElgBlPhrd2VXGN
         Qj4w==
X-Forwarded-Encrypted: i=1; AJvYcCWLSmgCYNu1XfxKR3KWljPfWDIyQ75j0cIBnAgirasxS0VROHktzaucCYwBVH9i4Lvw0/6PQzVCq5AigHF0DGxMqq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEZtmTFqJpj8ivJX7U1wxX9swyy7qhRbUVpgNY2GJf9tYaNCy7
	XhLA2BN/7LTkXWcVeILZ3cx5cyXrSBy7uA2Fy5JlkvtpT9Hh89GX6Y8KIoVPgJ1wEoQTUEbdCEF
	/hcMnYxIVKcRAo4dUMstCUGhxdYC6M0UJTNphd6BAmmwI6BXNsvgj9Uotan0t0m3dn2xNFZta/g
	==
X-Gm-Gg: ASbGncuzeBXhJomdLWIcY058q4CCCYCduTpwcYwvbgwu7NudclaHQy+h3z6msf2WAaJ
	RN6uMBq5pC+wC+rMgR+la9M3fagn8GnN6YrlSUoAuqB2ZK2poW/jxDCVjJxypq2HaI60k0TKuct
	2CNIM4Vv6tIWVZcwTUIbOAu0HtQuS+T4V63wkamZzQS/3ntFYoRPF0+JM3sd+/XGEpa17F4zqx/
	eB7i69NYqiGTu03JhoFTJDKhmNvN3C4aa3qbm9TR0ZaWojVtMlg4O9BhWnLHJjWaob2nqIbOm5V
	a6i3hYZzbafpXCLYowiNnauqZw1ILBbWNEKTBa2qXKF06MgQtNRqpF0XFE/J2TRYx2o9xXp2F5k
	H4/2dZ8fVjA9/BD1mf/kAwv6Gios=
X-Received: by 2002:a05:600c:524b:b0:471:115e:87bd with SMTP id 5b1f17b1804b1-4792f38d616mr70704935e9.26.1764947988172;
        Fri, 05 Dec 2025 07:19:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFCot/KF5F65hplGg4xWSLyvS1jVC/e+gBoRR6TDiuo7BMwLsACBc72R7yqlYEmRSaUPcRuA==
X-Received: by 2002:a05:600c:524b:b0:471:115e:87bd with SMTP id 5b1f17b1804b1-4792f38d616mr70704575e9.26.1764947987631;
        Fri, 05 Dec 2025 07:19:47 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e294:5000:b694:8e49:4f51:966d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b021cd2sm74880785e9.1.2025.12.05.07.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 07:19:47 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v1 2/4] tools/rtla: Remove unneeded nr_cpus arguments
Date: Fri,  5 Dec 2025 17:19:22 +0200
Message-ID: <20251205151924.2250142-2-costa.shul@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251205151924.2250142-1-costa.shul@redhat.com>
References: <20251205151924.2250142-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7ROSnGhbWgWFnlA-Y59LJE1LmzYOwTLnHBx4P3Hr7F8_1764947988
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
index 0bed9717cef6..ae773334e700 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -63,7 +63,7 @@ static void osnoise_free_hist_tool(struct osnoise_tool *tool)
  * osnoise_alloc_histogram - alloc runtime data
  */
 static struct osnoise_hist_data
-*osnoise_alloc_histogram(int nr_cpus, int entries, int bucket_size)
+*osnoise_alloc_histogram(int entries, int bucket_size)
 {
 	struct osnoise_hist_data *data;
 	int cpu;
@@ -704,7 +704,7 @@ static struct osnoise_tool
 	if (!tool)
 		return NULL;
 
-	tool->data = osnoise_alloc_histogram(nr_cpus, params->hist.entries,
+	tool->data = osnoise_alloc_histogram(params->hist.entries,
 					     params->hist.bucket_size);
 	if (!tool->data)
 		goto out_err;
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 8fa0046f0136..367a765387c8 100644
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
 
@@ -548,7 +548,7 @@ struct osnoise_tool *osnoise_init_top(struct common_params *params)
 	if (!tool)
 		return NULL;
 
-	tool->data = osnoise_alloc_top(nr_cpus);
+	tool->data = osnoise_alloc_top();
 	if (!tool->data) {
 		osnoise_destroy_tool(tool);
 		return NULL;
diff --git a/tools/tracing/rtla/src/timerlat_bpf.c b/tools/tracing/rtla/src/timerlat_bpf.c
index e97d16646bcd..4b623a904802 100644
--- a/tools/tracing/rtla/src/timerlat_bpf.c
+++ b/tools/tracing/rtla/src/timerlat_bpf.c
@@ -169,12 +169,11 @@ int timerlat_bpf_get_hist_value(int key,
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
 #endif /* HAVE_BPF_SKEL */
diff --git a/tools/tracing/rtla/src/timerlat_bpf.h b/tools/tracing/rtla/src/timerlat_bpf.h
index 118487436d30..2b18f3061c32 100644
--- a/tools/tracing/rtla/src/timerlat_bpf.h
+++ b/tools/tracing/rtla/src/timerlat_bpf.h
@@ -27,8 +27,7 @@ int timerlat_bpf_get_hist_value(int key,
 int timerlat_bpf_get_summary_value(enum summary_field key,
 				   long long *value_irq,
 				   long long *value_thread,
-				   long long *value_user,
-				   int cpus);
+				   long long *value_user);
 
 static inline int have_libbpf_support(void) { return 1; }
 #else
@@ -52,8 +51,7 @@ static inline int timerlat_bpf_get_hist_value(int key,
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
index 37bb9b931c8c..d4a9dcd67d48 100644
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
@@ -1082,7 +1077,7 @@ static struct osnoise_tool
 	if (!tool)
 		return NULL;
 
-	tool->data = timerlat_alloc_histogram(nr_cpus, params->hist.entries,
+	tool->data = timerlat_alloc_histogram(params->hist.entries,
 					      params->hist.bucket_size);
 	if (!tool->data)
 		goto out_err;
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 8b15f4439c6c..7b62549f69e3 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -63,7 +63,7 @@ static void timerlat_free_top_tool(struct osnoise_tool *tool)
 /*
  * timerlat_alloc_histogram - alloc runtime data
  */
-static struct timerlat_top_data *timerlat_alloc_top(int nr_cpus)
+static struct timerlat_top_data *timerlat_alloc_top(void)
 {
 	struct timerlat_top_data *data;
 	int cpu;
@@ -197,8 +197,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 
 	/* Pull summary */
 	err = timerlat_bpf_get_summary_value(SUMMARY_CURRENT,
-					     value_irq, value_thread, value_user,
-					     data->nr_cpus);
+					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
 	for (i = 0; i < data->nr_cpus; i++) {
@@ -208,8 +207,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 	}
 
 	err = timerlat_bpf_get_summary_value(SUMMARY_COUNT,
-					     value_irq, value_thread, value_user,
-					     data->nr_cpus);
+					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
 	for (i = 0; i < data->nr_cpus; i++) {
@@ -219,8 +217,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 	}
 
 	err = timerlat_bpf_get_summary_value(SUMMARY_MIN,
-					     value_irq, value_thread, value_user,
-					     data->nr_cpus);
+					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
 	for (i = 0; i < data->nr_cpus; i++) {
@@ -230,8 +227,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 	}
 
 	err = timerlat_bpf_get_summary_value(SUMMARY_MAX,
-					     value_irq, value_thread, value_user,
-					     data->nr_cpus);
+					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
 	for (i = 0; i < data->nr_cpus; i++) {
@@ -241,8 +237,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 	}
 
 	err = timerlat_bpf_get_summary_value(SUMMARY_SUM,
-					     value_irq, value_thread, value_user,
-					     data->nr_cpus);
+					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
 	for (i = 0; i < data->nr_cpus; i++) {
@@ -828,7 +823,7 @@ static struct osnoise_tool
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

