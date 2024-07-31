Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C8D1AAE25
	for <linux-trace-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722415146; cv=none; b=e+cISf1168dwSXjsoZIGhyIjJE5Iyqn1HHXCJVzUCfUCK4Gr2SawxRdGZQDxbdjpO2/IUpCdAxPZMb6dLBJU76Djtqoc0zj+W5JvEgWoCLFELQLHIaDCfS4R9LeNYccRKFNk+42as9FWQPSGSvZyAQit0xTxaiwLrx2cLNa3J7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722415146; c=relaxed/simple;
	bh=H2g2piUjymztI+zJAzp4FxlkP6G0s8qCAn3CbGkzlz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzFBpOesKl79TdS1vBFLexp37HCEeJZmsyAH6J00ORJxVCzWxoti6lLCMD5NX2laPZP0zqu8kD3mLFoZTz+RUlDfhs5JibR+xqpqHaAekFer5Q9cwcAEmXe6HfKkSAvYUdDoURRe5Hp7p1F4saxlcBqtkHm5DbabcRMYsuW6VhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NWutqv7v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NWutqv7v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722415144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gLZ1FcdpM0yfEx21dYtJ0QoefqhZWfvbIyg8r+8+3Lc=;
	b=NWutqv7vcry9TCCUKZS0ActQSnTx29BQaj0dDLiTLfgjqA20jdG1g4/VhXDMK4rs8LdL6q
	sojVcuOd4KsoamPiqvNOdSmC2oGve8u6NGQm2ZlOI8iH5SKh09k6gIN8MzxxB4cXEUTT2s
	BEgGuDWx+7E7JnopPlyAXUEG/SrYanc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-g2sa1bNyMcqC5HrIapRXcQ-1; Wed,
 31 Jul 2024 04:38:56 -0400
X-MC-Unique: g2sa1bNyMcqC5HrIapRXcQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D5091956088;
	Wed, 31 Jul 2024 08:38:55 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.159])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 93D973000197;
	Wed, 31 Jul 2024 08:38:52 +0000 (UTC)
From: tglozar@redhat.com
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 5/6] rtla/timerlat: Add --deepest-idle-state for hist
Date: Wed, 31 Jul 2024 10:36:54 +0200
Message-ID: <20240731083655.375293-6-tglozar@redhat.com>
In-Reply-To: <20240731083655.375293-1-tglozar@redhat.com>
References: <20240731083655.375293-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Tomas Glozar <tglozar@redhat.com>

Support limiting deepest idle state also for timerlat-hist.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat_hist.c | 46 +++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index a3907c390d67..41cf6a0535b4 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -55,6 +55,7 @@ struct timerlat_hist_params {
 	int			entries;
 	int			warmup;
 	int			buffer_size;
+	int			deepest_idle_state;
 };
 
 struct timerlat_hist_cpu {
@@ -655,7 +656,7 @@ static void timerlat_hist_usage(char *usage)
 		"         [-t[file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] [-H cpu-list]\\",
 		"	  [-P priority] [-E N] [-b N] [--no-irq] [--no-thread] [--no-header] [--no-summary] \\",
 		"	  [--no-index] [--with-zeros] [--dma-latency us] [-C[=cgroup_name]] [--no-aa] [--dump-task] [-u|-k]",
-		"	  [--warm-up s]",
+		"	  [--warm-up s] [--deepest-idle-state n]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us latency is hit",
@@ -695,6 +696,7 @@ static void timerlat_hist_usage(char *usage)
 		"	  -U/--user-load: enable timerlat for user-defined user-space workload",
 		"	     --warm-up s: let the workload run for s seconds before collecting data",
 		"	     --trace-buffer-size kB: set the per-cpu trace buffer size in kB",
+		"	     --deepest-idle-state n: only go down to idle state n on cpus used by timerlat to reduce exit from idle latency",
 		NULL,
 	};
 
@@ -732,6 +734,9 @@ static struct timerlat_hist_params
 	/* disabled by default */
 	params->dma_latency = -1;
 
+	/* disabled by default */
+	params->deepest_idle_state = -2;
+
 	/* display data in microseconds */
 	params->output_divisor = 1000;
 	params->bucket_size = 1;
@@ -772,6 +777,7 @@ static struct timerlat_hist_params
 			{"dump-task",		no_argument,		0, '\1'},
 			{"warm-up",		required_argument,	0, '\2'},
 			{"trace-buffer-size",	required_argument,	0, '\3'},
+			{"deepest-idle-state",	required_argument,	0, '\4'},
 			{0, 0, 0, 0}
 		};
 
@@ -960,6 +966,9 @@ static struct timerlat_hist_params
 		case '\3':
 			params->buffer_size = get_llong_from_str(optarg);
 			break;
+		case '\4':
+			params->deepest_idle_state = get_llong_from_str(optarg);
+			break;
 		default:
 			timerlat_hist_usage("Invalid option");
 		}
@@ -1152,6 +1161,9 @@ int timerlat_hist_main(int argc, char *argv[])
 	int return_value = 1;
 	pthread_t timerlat_u;
 	int retval;
+#ifdef HAVE_LIBCPUPOWER_SUPPORT
+	int i;
+#endif /* HAVE_LIBCPUPOWER_SUPPORT */
 
 	params = timerlat_hist_parse_args(argc, argv);
 	if (!params)
@@ -1201,6 +1213,26 @@ int timerlat_hist_main(int argc, char *argv[])
 		}
 	}
 
+	if (params->deepest_idle_state >= -1) {
+#ifdef HAVE_LIBCPUPOWER_SUPPORT
+		for (i = 0; i < sysconf(_SC_NPROCESSORS_CONF); i++) {
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
+#else
+		err_msg("rtla built without libcpupower, --deepest-idle-state is not supported\n");
+		goto out_free;
+#endif /* HAVE_LIBCPUPOWER_SUPPORT */
+	}
+
 	if (params->trace_output) {
 		record = osnoise_init_trace_tool("timerlat");
 		if (!record) {
@@ -1332,6 +1364,15 @@ int timerlat_hist_main(int argc, char *argv[])
 	timerlat_aa_destroy();
 	if (dma_latency_fd >= 0)
 		close(dma_latency_fd);
+#ifdef HAVE_LIBCPUPOWER_SUPPORT
+	if (params->deepest_idle_state >= -1) {
+		for (i = 0; i < sysconf(_SC_NPROCESSORS_CONF); i++) {
+			if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
+				continue;
+			restore_cpu_idle_disable_state(i);
+		}
+	}
+#endif /* HAVE_LIBCPUPOWER_SUPPORT */
 	trace_events_destroy(&record->trace, params->events);
 	params->events = NULL;
 out_free:
@@ -1340,6 +1381,9 @@ int timerlat_hist_main(int argc, char *argv[])
 	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(tool);
 	free(params);
+#ifdef HAVE_LIBCPUPOWER_SUPPORT
+	free_cpu_idle_disable_states();
+#endif /* HAVE_LIBCPUPOWER_SUPPORT */
 out_exit:
 	exit(return_value);
 }
-- 
2.45.2

