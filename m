Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E19817FACE
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204169; cv=none; b=l9sgGJPVZFYqkmgPind6O/ehBZurm67Q2/YtFs/oRyHFurAP3GqI4XxIB0L/HeDhDm6Z1WNI7UCzHVLfAPevAk4EATj0oubzX4Hnn9+DQnKTMBQbj2uu7MYvyDZmUIznZ5x1/oVhJ+bm9NEBI40cDkVzCdgXr0FRGoqjgJfX9oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204169; c=relaxed/simple;
	bh=ak0D1RyKjNQbr1Wgva/mn4SWVkmIAoC+xSn8Iu47Vhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkFnGeg68U5ajKFNYfWeMCBvt9Fnb2eqDpF4gRAMU6GQwr1CWZ7d0dPv/MWxMDK3pPuN37lF41fXlZw9qOIzNnrVWObfOO/aw1QJV5CxdGi2ee/aGPm7RN//lWWVDhcfQhuoShhMP+cpOexIgJmzAR3HLP397Jj2ULTx6QKpFCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DGarEA54; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGarEA54"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718204165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Ni7sEvqwYy/qdng9JHhwxqL5eMcqZfuwVc8G8BHbZc=;
	b=DGarEA54hKBoK9eavV0PurspE0drf3o49Yq+dZaxeTGI+TbEch8j6fOGWTt5Mpn7Or2ewF
	xwEPk+HXmSIXhHXG5mVaf8SKHjiI/BX6K+q8ONQMFzqXx9a4YtWpCWO8zkuQGWAGaoTv2V
	1uhaIERJtuadjeASFGj27ck5NOj+Pvk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-NRQKEMsZNjWcjWauwEknCg-1; Wed,
 12 Jun 2024 10:56:00 -0400
X-MC-Unique: NRQKEMsZNjWcjWauwEknCg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 190F9195607C;
	Wed, 12 Jun 2024 14:55:59 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.68])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ED8321956087;
	Wed, 12 Jun 2024 14:55:56 +0000 (UTC)
From: tglozar@redhat.com
To: bristot@kernel.org,
	rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jkacur@redhat.com,
	jwyatt@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 3/5] rtla/timerlat: Add --disable-idle-states for top
Date: Wed, 12 Jun 2024 16:54:37 +0200
Message-ID: <20240612145439.206990-4-tglozar@redhat.com>
In-Reply-To: <20240612145439.206990-1-tglozar@redhat.com>
References: <20240612145439.206990-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Tomas Glozar <tglozar@redhat.com>

Add option to disable idle states on CPUs where timerlat is running for
the duration of the workload.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat_top.c | 35 ++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 8c16419fe22a..dd1e5b03d781 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -48,6 +48,7 @@ struct timerlat_top_params {
 	int			pretty_output;
 	int			warmup;
 	int			buffer_size;
+	int			disable_idle_states;
 	cpu_set_t		hk_cpu_set;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
@@ -447,7 +448,7 @@ static void timerlat_top_usage(char *usage)
 		"",
 		"  usage: rtla timerlat [top] [-h] [-q] [-a us] [-d s] [-D] [-n] [-p us] [-i us] [-T us] [-s us] \\",
 		"	  [[-t[file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] [-H cpu-list]\\",
-		"	  [-P priority] [--dma-latency us] [--aa-only us] [-C[=cgroup_name]] [-u|-k] [--warm-up s]",
+		"	  [-P priority] [--dma-latency us] [--aa-only us] [-C[=cgroup_name]] [-u|-k] [--warm-up s] [--disable-idle-states]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us latency is hit",
@@ -481,6 +482,7 @@ static void timerlat_top_usage(char *usage)
 		"	  -U/--user-load: enable timerlat for user-defined user-space workload",
 		"	     --warm-up s: let the workload run for s seconds before collecting data",
 		"	     --trace-buffer-size kB: set the per-cpu trace buffer size in kB",
+		"	     --disable-idle-states: disable all idle states for cpus used by timerlat to reduce exit from idle latency",
 		NULL,
 	};
 
@@ -518,6 +520,9 @@ static struct timerlat_top_params
 	/* disabled by default */
 	params->dma_latency = -1;
 
+	/* disabled by default */
+	params->disable_idle_states = 0;
+
 	/* display data in microseconds */
 	params->output_divisor = 1000;
 
@@ -550,6 +555,7 @@ static struct timerlat_top_params
 			{"aa-only",		required_argument,	0, '5'},
 			{"warm-up",		required_argument,	0, '6'},
 			{"trace-buffer-size",	required_argument,	0, '7'},
+			{"disable-idle-states",	no_argument,		0, '8'},
 			{0, 0, 0, 0}
 		};
 
@@ -726,6 +732,9 @@ static struct timerlat_top_params
 		case '7':
 			params->buffer_size = get_llong_from_str(optarg);
 			break;
+		case '8':
+			params->disable_idle_states = 1;
+			break;
 		default:
 			timerlat_top_usage("Invalid option");
 		}
@@ -922,6 +931,7 @@ int timerlat_top_main(int argc, char *argv[])
 	int return_value = 1;
 	char *max_lat;
 	int retval;
+	int i;
 
 	params = timerlat_top_parse_args(argc, argv);
 	if (!params)
@@ -971,6 +981,21 @@ int timerlat_top_main(int argc, char *argv[])
 		}
 	}
 
+	if (params->disable_idle_states) {
+		for (i = 0; i < sysconf(_SC_NPROCESSORS_CONF); i++) {
+			if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
+				continue;
+			if (save_cpu_idle_disable_state(i) < 0) {
+				err_msg("Could not save cpu idle state.\n");
+				goto out_free;
+			}
+			if (set_cpu_idle_disable_state(i, 1) < 0) {
+				err_msg("Could not disable cpu idle state.\n");
+				goto out_free;
+			}
+		}
+	}
+
 	if (params->trace_output) {
 		record = osnoise_init_trace_tool("timerlat");
 		if (!record) {
@@ -1125,6 +1150,13 @@ int timerlat_top_main(int argc, char *argv[])
 	timerlat_aa_destroy();
 	if (dma_latency_fd >= 0)
 		close(dma_latency_fd);
+	if (params->disable_idle_states) {
+		for (i = 0; i < sysconf(_SC_NPROCESSORS_CONF); i++) {
+			if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
+				continue;
+			restore_cpu_idle_disable_state(i);
+		}
+	}
 	trace_events_destroy(&record->trace, params->events);
 	params->events = NULL;
 out_free:
@@ -1134,6 +1166,7 @@ int timerlat_top_main(int argc, char *argv[])
 	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(top);
 	free(params);
+	free_cpu_idle_disable_states();
 out_exit:
 	exit(return_value);
 }
-- 
2.43.0

