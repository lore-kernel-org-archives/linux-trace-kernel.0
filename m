Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A067E14D2B9
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Oct 2024 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999381; cv=none; b=tdl3mh3FBjHCUB7YsZP9ox5UyQMKpgbwqphslBhkXjhXOVE4fEfetZe1Tkyh13xTs43opLEhbAQbyrDpfa6b7S7l2iLX1GeeDV+vqATHbFIJXjGDgcruzg8KbMO1Y+2HhVRh01NvX2sE+VmMCL7fI1JBwh3lPTwJ7TZpsJPvz7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999381; c=relaxed/simple;
	bh=xeLkTEKTNAT9sGDnDK9o2ilMhsBVyA9UijtR9xfjMfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQW6Z0RZCp7b2B0hyfsAVRrVAPRocIrzYTeWNYZ5zzAFCSjwUXlBIPbhhv2rwaCBM3Ob+oExBIKt+On8WpLMeBu0gJ3rUIIumfJn14Fo/CSX+vgwL96ptd6ZiYUzlzIp+N20R6t+aibnIx5x0pgZ5smPIjiwrqNjwrA+A1DNY10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IWt0EeQR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWt0EeQR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728999378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JwYhkpHghGKHLaekKCNgK0lS740JHddsBSXXuOkvWNI=;
	b=IWt0EeQRSXYnfhPRyjkG5RCKbwG9kKnTeQ3Cnc8qHR9gEWBxo8nJDMY5W8/DCjjwG+e/R5
	oTLaVZrct4GOmiSrKWCGmHZzVZlYP0/ZyJL87aaMxEjR9PbqrvRm7jy/tzW6KZkpDArHi8
	yekQsC9UyuIfCTAzWCDku8wScHlofF0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-EO0uGmp6OmOK-1ygPSlV2A-1; Tue,
 15 Oct 2024 09:36:17 -0400
X-MC-Unique: EO0uGmp6OmOK-1ygPSlV2A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55F361955BC1;
	Tue, 15 Oct 2024 13:36:16 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 695D119560A7;
	Tue, 15 Oct 2024 13:36:14 +0000 (UTC)
From: tglozar@redhat.com
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jkacur@redhat.com,
	jwyatt@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v4 4/6] rtla/timerlat: Add --deepest-idle-state for top
Date: Tue, 15 Oct 2024 15:35:50 +0200
Message-ID: <20241015133552.3043040-5-tglozar@redhat.com>
In-Reply-To: <20241015133552.3043040-1-tglozar@redhat.com>
References: <20241015133552.3043040-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Tomas Glozar <tglozar@redhat.com>

Add option to limit deepest idle state on CPUs where timerlat is running
for the duration of the workload.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat_top.c | 42 ++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 7fb85c8ee3bc..fca0da3caa87 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -48,6 +48,7 @@ struct timerlat_top_params {
 	int			pretty_output;
 	int			warmup;
 	int			buffer_size;
+	int			deepest_idle_state;
 	cpu_set_t		hk_cpu_set;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
@@ -447,7 +448,7 @@ static void timerlat_top_usage(char *usage)
 		"",
 		"  usage: rtla timerlat [top] [-h] [-q] [-a us] [-d s] [-D] [-n] [-p us] [-i us] [-T us] [-s us] \\",
 		"	  [[-t[file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] [-H cpu-list]\\",
-		"	  [-P priority] [--dma-latency us] [--aa-only us] [-C[=cgroup_name]] [-u|-k] [--warm-up s]",
+		"	  [-P priority] [--dma-latency us] [--aa-only us] [-C[=cgroup_name]] [-u|-k] [--warm-up s] [--deepest-idle-state n]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us latency is hit",
@@ -481,6 +482,7 @@ static void timerlat_top_usage(char *usage)
 		"	  -U/--user-load: enable timerlat for user-defined user-space workload",
 		"	     --warm-up s: let the workload run for s seconds before collecting data",
 		"	     --trace-buffer-size kB: set the per-cpu trace buffer size in kB",
+		"	     --deepest-idle-state n: only go down to idle state n on cpus used by timerlat to reduce exit from idle latency",
 		NULL,
 	};
 
@@ -518,6 +520,9 @@ static struct timerlat_top_params
 	/* disabled by default */
 	params->dma_latency = -1;
 
+	/* disabled by default */
+	params->deepest_idle_state = -2;
+
 	/* display data in microseconds */
 	params->output_divisor = 1000;
 
@@ -550,6 +555,7 @@ static struct timerlat_top_params
 			{"aa-only",		required_argument,	0, '5'},
 			{"warm-up",		required_argument,	0, '6'},
 			{"trace-buffer-size",	required_argument,	0, '7'},
+			{"deepest-idle-state",	required_argument,	0, '8'},
 			{0, 0, 0, 0}
 		};
 
@@ -726,6 +732,9 @@ static struct timerlat_top_params
 		case '7':
 			params->buffer_size = get_llong_from_str(optarg);
 			break;
+		case '8':
+			params->deepest_idle_state = get_llong_from_str(optarg);
+			break;
 		default:
 			timerlat_top_usage("Invalid option");
 		}
@@ -922,6 +931,7 @@ int timerlat_top_main(int argc, char *argv[])
 	int return_value = 1;
 	char *max_lat;
 	int retval;
+	int nr_cpus, i;
 
 	params = timerlat_top_parse_args(argc, argv);
 	if (!params)
@@ -971,6 +981,28 @@ int timerlat_top_main(int argc, char *argv[])
 		}
 	}
 
+	if (params->deepest_idle_state >= -1) {
+		if (!have_libcpupower_support()) {
+			err_msg("rtla built without libcpupower, --deepest-idle-state is not supported\n");
+			goto out_free;
+		}
+
+		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
+
+		for (i = 0; i < nr_cpus; i++) {
+			if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
+				continue;
+			if (save_cpu_idle_disable_state(i) < 0) {
+				err_msg("Could not save cpu idle state.\n");
+				goto out_free;
+			}
+			if (set_deepest_cpu_idle_state(i, params->deepest_idle_state) < 0) {
+				err_msg("Could not set deepest cpu idle state.\n");
+				goto out_free;
+			}
+		}
+	}
+
 	if (params->trace_output) {
 		record = osnoise_init_trace_tool("timerlat");
 		if (!record) {
@@ -1125,6 +1157,13 @@ int timerlat_top_main(int argc, char *argv[])
 	timerlat_aa_destroy();
 	if (dma_latency_fd >= 0)
 		close(dma_latency_fd);
+	if (params->deepest_idle_state >= -1) {
+		for (i = 0; i < nr_cpus; i++) {
+			if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
+				continue;
+			restore_cpu_idle_disable_state(i);
+		}
+	}
 	trace_events_destroy(&record->trace, params->events);
 	params->events = NULL;
 out_free:
@@ -1134,6 +1173,7 @@ int timerlat_top_main(int argc, char *argv[])
 	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(top);
 	free(params);
+	free_cpu_idle_disable_states();
 out_exit:
 	exit(return_value);
 }
-- 
2.47.0

