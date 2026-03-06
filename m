Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A95A4301B6
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Mar 2026 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772826872; cv=none; b=a+cNdXzbZhvG1w0v2/KlUK4TdmjQoMcmGtRBgCxmZlKlm8vH+xETMVdPdN5bji/G0MNYQMipUhgSOff1YmmyZ/sHKXKwfagqV0IvgAxEWr7zlY6Roa1Pn5Ve0JWsAPwfi7uvwp+fqkELuNMea3bF3vtYiZlnegJmWFMObNzWQs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772826872; c=relaxed/simple;
	bh=OWC7q8wLb6/3FihOEavLfTvY2AxxNgMODatMWWOuplM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=rMW+NhTNbVrMzTYGmCdB4vu1ypYzgpth/q0b2xt3G15gshEJu0wQFKv8VgoTQOuB6UpTcP25VyUL64ve+DBLjdmp1vp+u54skKchQQ0ozR7F6IsByKWOI4e31mVkpb71rpgCE44hRPXIDtJTYu6ZtgKK/8GQJGUvJ5hoH38ueQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ff4psvFZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ff4psvFZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772826868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+QhEt5URy2DIR8oMNtQgq3o4v4oSagpPMGAskLs6Ck=;
	b=Ff4psvFZRf9d2nBytkhedbNPsDS2PvaJzJbW3S0pmRR+vrTY+wSZzPVpksFZuRb/5VsEsE
	CydElmUWOaAvfbimR8Gn67kTAhEv4PXfOWSpoyRpZslM+qVRBP6+fc+ZR2UdPRmtn32Mc/
	9iB7adj41hQOBNaceso0eGc9Xm+r3V8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-87EiTHKGN2yDyl-ynMo2YA-1; Fri, 06 Mar 2026 14:54:27 -0500
X-MC-Unique: 87EiTHKGN2yDyl-ynMo2YA-1
X-Mimecast-MFC-AGG-ID: 87EiTHKGN2yDyl-ynMo2YA_1772826866
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48529847dedso5579795e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Mar 2026 11:54:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772826866; x=1773431666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E+QhEt5URy2DIR8oMNtQgq3o4v4oSagpPMGAskLs6Ck=;
        b=luZQUaLYkS5TX8DiCfPFGf0M0fxoPeOcdvsMxvCiEscR6enbJQ4FcdO77DUyPS45mN
         XF0jrb4DCpnzA2FTD7KOWjkgtJt8Wx3e8GfPO+SshgHhyae07kLQmacly/9rBk7f1M7c
         iHKLohCHwcZPhX5v5poGUOjWW9hMRTLcnQ8YbHnr9mdX3y3imS+NckQ5wr7qyO6PAP1j
         ZMxe2lY5752MxZTmR6S1LAgLefHgY+ll+D+KJqUeklEuFYEn1jf7QCu07jEkA6f8bnkv
         OdWMnrnx1dk/fXxGjyymVAHQ/6Iaee31Bixd3qz2ygD6S5m/q2xhd6Z4+alBtV1ulQi0
         pTlA==
X-Forwarded-Encrypted: i=1; AJvYcCWIpT9T/5r6mU15ylkRFArOU9ZBAYA5CIVKOTOj9DDAA5sVAd1ldze5kenee17TmLmMaeoBRR6KhIeSkypDiIfxAw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhMsL91uzAGqnYA5e6ZsDSJppd7PEB2oEsJWxS/LheAWofijG7
	Cy9QTeWqu/Tuf0iZh8HAAzZwpz1hCK7pYNPGd3spSdXsccNEpkdOAWQWv/IFWXtPr0PTvB2i30c
	q2tkbzxJbflgMPQW35IcMmLuVu6NPy6IhYMPqoiGReslYXwEdqCMD9WQN6iFoUd6THKcBkKshdA
	==
X-Gm-Gg: ATEYQzyMyvNLghyn3PgwH5oMArMAhCNIO6jrFFP0KyRIGmbocRKFaL6KIPcRr0X82+J
	7bUVaYuwMCT66EK+mafNwcZQE59It07nIVXbM6BONJHJ6+7QbL/4vZZXLixWRlWf2euBZP4+d6d
	SmKP88D3R2V03pX1TMT3zKSVADRK+zqF1bQwwF5UeTDzaOC7dQlPkNa4Xc5iUM/kplOJwMc46kb
	kzClru/cNBIVkkdqgGH0ZnaRpOFuaL+atlDA6qgVEcxxS/a0Mme06em1dONIz0NuEW13TI9iyNi
	qOngqAlBuuFxxkkWfQn4Cq9w3aYeWm5qLlupcR8HxqMo7q5MdekSHhWxyEX0AMarkQfsXaN4USZ
	szjXwQtPQ4EvY5bT8h6fcUzasw4pZU2yKsfmhtA==
X-Received: by 2002:a05:600c:4752:b0:483:7783:537b with SMTP id 5b1f17b1804b1-4852697a593mr55972975e9.24.1772826866114;
        Fri, 06 Mar 2026 11:54:26 -0800 (PST)
X-Received: by 2002:a05:600c:4752:b0:483:7783:537b with SMTP id 5b1f17b1804b1-4852697a593mr55972745e9.24.1772826865698;
        Fri, 06 Mar 2026 11:54:25 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485276b75eesm48596485e9.14.2026.03.06.11.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 11:54:25 -0800 (PST)
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
Subject: [PATCH v4 4/4] tools/rtla: Remove unneeded nr_cpus from for_each_monitored_cpu
Date: Fri,  6 Mar 2026 21:49:52 +0200
Message-ID: <20260306194953.2511960-5-costa.shul@redhat.com>
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
X-Mimecast-MFC-PROC-ID: YzU7t35NAozSseQuzJJAlyo0_nEG6Ou_x2i_JqrZVqw_1772826866
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

nr_cpus does not change at runtime, so passing it through the macro
argument is unnecessary.

Remove the argument and use the global nr_cpus instead.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/common.h        |  2 +-
 tools/tracing/rtla/src/osnoise_hist.c  | 15 +++++++--------
 tools/tracing/rtla/src/osnoise_top.c   |  2 +-
 tools/tracing/rtla/src/timerlat.c      |  4 ++--
 tools/tracing/rtla/src/timerlat_hist.c | 16 ++++++++--------
 tools/tracing/rtla/src/timerlat_top.c  |  2 +-
 6 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index 90a3c0d1dbf3..22ec436a93cc 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -110,7 +110,7 @@ struct common_params {
 
 extern int nr_cpus;
 
-#define for_each_monitored_cpu(cpu, nr_cpus, common) \
+#define for_each_monitored_cpu(cpu, common) \
 	for (cpu = 0; cpu < nr_cpus; cpu++) \
 		if (!(common)->cpus || CPU_ISSET(cpu, &(common)->monitored_cpus))
 
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 5bbec27b46a7..4181e025511a 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -244,7 +244,7 @@ static void osnoise_hist_header(struct osnoise_tool *tool)
 	if (!params->common.hist.no_index)
 		trace_seq_printf(s, "Index");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -273,8 +273,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "count:");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
-
+	for_each_monitored_cpu(cpu, &params->common) {
 		if (!data->hist[cpu].count)
 			continue;
 
@@ -285,7 +284,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "min:  ");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -298,7 +297,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "avg:  ");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -314,7 +313,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "max:  ");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -349,7 +348,7 @@ osnoise_print_stats(struct osnoise_tool *tool)
 			trace_seq_printf(trace->seq, "%-6d",
 					 bucket * data->bucket_size);
 
-		for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+		for_each_monitored_cpu(cpu, &params->common) {
 
 			if (!data->hist[cpu].count)
 				continue;
@@ -385,7 +384,7 @@ osnoise_print_stats(struct osnoise_tool *tool)
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "over: ");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 672cdb254f4c..f92caea9f2e9 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -236,7 +236,7 @@ osnoise_print_stats(struct osnoise_tool *top)
 
 	osnoise_top_header(top);
 
-	for_each_monitored_cpu(i, nr_cpus, &params->common) {
+	for_each_monitored_cpu(i, &params->common) {
 		osnoise_top_print(top, i);
 	}
 
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 31c921efa7c1..8a44537e25cb 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -115,7 +115,7 @@ int timerlat_enable(struct osnoise_tool *tool)
 			return -1;
 		}
 
-		for_each_monitored_cpu(i, nr_cpus, &params->common) {
+		for_each_monitored_cpu(i, &params->common) {
 			if (save_cpu_idle_disable_state(i) < 0) {
 				err_msg("Could not save cpu idle state.\n");
 				return -1;
@@ -218,7 +218,7 @@ void timerlat_free(struct osnoise_tool *tool)
 	if (dma_latency_fd >= 0)
 		close(dma_latency_fd);
 	if (params->deepest_idle_state >= -1) {
-		for_each_monitored_cpu(i, nr_cpus, &params->common) {
+		for_each_monitored_cpu(i, &params->common) {
 			restore_cpu_idle_disable_state(i);
 		}
 	}
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index cfb745b75b8a..ee1af251c94d 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -298,7 +298,7 @@ static void timerlat_hist_header(struct osnoise_tool *tool)
 	if (!params->common.hist.no_index)
 		trace_seq_printf(s, "Index");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -350,7 +350,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "count:");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -372,7 +372,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "min:  ");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -400,7 +400,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "avg:  ");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -428,7 +428,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "max:  ");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -473,7 +473,7 @@ timerlat_print_stats_all(struct timerlat_params *params,
 	sum.min_thread = ~0;
 	sum.min_user = ~0;
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -620,7 +620,7 @@ timerlat_print_stats(struct osnoise_tool *tool)
 			trace_seq_printf(trace->seq, "%-6d",
 					 bucket * data->bucket_size);
 
-		for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+		for_each_monitored_cpu(cpu, &params->common) {
 
 			if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 				continue;
@@ -658,7 +658,7 @@ timerlat_print_stats(struct osnoise_tool *tool)
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "over: ");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 8fad4edb0d72..cc296c9d7fe7 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -446,7 +446,7 @@ timerlat_print_stats(struct osnoise_tool *top)
 
 	timerlat_top_header(params, top);
 
-	for_each_monitored_cpu(i, nr_cpus, &params->common) {
+	for_each_monitored_cpu(i, &params->common) {
 		timerlat_top_print(top, i);
 		timerlat_top_update_sum(top, i, &summary);
 	}
-- 
2.53.0

