Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ED622371E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742462742; cv=none; b=NBaxZBHxDyOGIYiAMmFDLbMdArkFr12/qftZUdNyZxaA7ZDZby+G9ZgK2ruGNNZsIPmhjxlzNbH3mUa9zaNRpJi3c1YzpMDY8cqIndlkUOjQb4C7lYAyWAQnkFcKSFtFoEg5lR47aOyXGLGQxaO3gSXv5+Em35PxW4xCvTtyiSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742462742; c=relaxed/simple;
	bh=fqgEYXFIkxF5GlmCmiHytufE/2k0aA2ttPBEs7bulF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tr6NGZtH35QB/W3gxrNXAdrYpLtNS2NO7Osj3orpiu5t2hCmRhNlse0+o2tubpFrIJR6K3RH1XMS0EmNUQc6fG1F5HVJL+0I776oyy1B4yDbRXc7mxcJqhkSm1hB5u8QgoJerVpDqLAxpTSHHnHY9jvsaBC7gPHehE3WKYcl3yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E0De/DDD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0De/DDD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742462740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CK5pM6D00pDpzKNVnPPnJFk4235/1El011hY/HmMZUU=;
	b=E0De/DDDbaHkbTrT05aLHE595IKspoWJF1cYS+RiztKLPKZAwFkn4/kWb916s1vJZKnLVJ
	64eDyrS/9sbww/LsuR+MpO1GgzW5XP6aiTRR369ooe78lKsB0zu5vmlYHW1WvzOZyKsZ8g
	Ql7pyvt8id894NQuNNSLLgsPuRP1NOs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-uLVHq97nPsutBKwaRVLPoA-1; Thu,
 20 Mar 2025 05:25:38 -0400
X-MC-Unique: uLVHq97nPsutBKwaRVLPoA-1
X-Mimecast-MFC-AGG-ID: uLVHq97nPsutBKwaRVLPoA_1742462737
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AC211800267;
	Thu, 20 Mar 2025 09:25:37 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.73])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3061019560AF;
	Thu, 20 Mar 2025 09:25:34 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 4/6] rtla: Always set all tracer options
Date: Thu, 20 Mar 2025 10:24:58 +0100
Message-ID: <20250320092500.101385-5-tglozar@redhat.com>
In-Reply-To: <20250320092500.101385-1-tglozar@redhat.com>
References: <20250320092500.101385-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

rtla currently only sets tracer options that are explicitly set by the
user, with the exception of OSNOISE_WORKLOAD.

This leads to improper behavior in case rtla is run with those options
not set to the default value. rtla does reset them to the original
value upon exiting, but that does not protect it from starting with
non-default values set either by an improperly exited rtla or by another
user of the tracers.

For example, after running this command:

$ echo 1 > /sys/kernel/tracing/osnoise/stop_tracing_us

all runs of rtla will stop at the 1us threshold, even if not requested
by the user:

$ rtla osnoise hist
Index   CPU-000   CPU-001
1             8         5
2             5         9
3             1         2
4             6         1
5             2         1
6             0         1
8             1         1
12            0         1
14            1         0
15            1         0
over:         0         0
count:       25        21
min:          1         1
avg:       3.68      3.05
max:         15        12
rtla osnoise hit stop tracing

Fix the problem by setting the default value for all tracer options if
the user has not provided their own value.

For most of the options, it's enough to just drop the if clause checking
for the value being set. For cpus, "all" is used as the default value,
and for osnoise default period and runtime, default values of
the osnoise_data variable in trace_osnoise.c are used.

Fixes: 1eceb2fc2ca5 ("rtla/osnoise: Add osnoise top mode")
Fixes: 829a6c0b5698 ("rtla/osnoise: Add the hist mode")
Fixes: a828cd18bc4a ("rtla: Add timerlat tool and timelart top mode")
Fixes: 1eeb6328e8b3 ("rtla/timerlat: Add timerlat hist mode")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/osnoise.c  | 56 ++++++++++++++---------------
 tools/tracing/rtla/src/timerlat.c | 59 +++++++++++++++----------------
 2 files changed, 56 insertions(+), 59 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index a71618d876e9..2dc3e4539e99 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -17,6 +17,9 @@
 
 #include "osnoise.h"
 
+#define DEFAULT_SAMPLE_PERIOD	1000000			/* 1s */
+#define DEFAULT_SAMPLE_RUNTIME	1000000			/* 1s */
+
 /*
  * osnoise_get_cpus - return the original "osnoise/cpus" content
  *
@@ -1127,46 +1130,43 @@ osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
 	if (!params->sleep_time)
 		params->sleep_time = 1;
 
-	if (params->cpus) {
-		retval = osnoise_set_cpus(tool->context, params->cpus);
-		if (retval) {
-			err_msg("Failed to apply CPUs config\n");
-			goto out_err;
-		}
+	retval = osnoise_set_cpus(tool->context, params->cpus ? params->cpus : "all");
+	if (retval) {
+		err_msg("Failed to apply CPUs config\n");
+		goto out_err;
 	}
 
 	if (params->runtime || params->period) {
 		retval = osnoise_set_runtime_period(tool->context,
 						    params->runtime,
 						    params->period);
-		if (retval) {
-			err_msg("Failed to set runtime and/or period\n");
-			goto out_err;
-		}
+	} else {
+		retval = osnoise_set_runtime_period(tool->context,
+						    DEFAULT_SAMPLE_PERIOD,
+						    DEFAULT_SAMPLE_RUNTIME);
 	}
 
-	if (params->stop_us) {
-		retval = osnoise_set_stop_us(tool->context, params->stop_us);
-		if (retval) {
-			err_msg("Failed to set stop us\n");
-			goto out_err;
-		}
+	if (retval) {
+		err_msg("Failed to set runtime and/or period\n");
+		goto out_err;
 	}
 
-	if (params->stop_total_us) {
-		retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
-		if (retval) {
-			err_msg("Failed to set stop total us\n");
-			goto out_err;
-		}
+	retval = osnoise_set_stop_us(tool->context, params->stop_us);
+	if (retval) {
+		err_msg("Failed to set stop us\n");
+		goto out_err;
 	}
 
-	if (params->threshold) {
-		retval = osnoise_set_tracing_thresh(tool->context, params->threshold);
-		if (retval) {
-			err_msg("Failed to set tracing_thresh\n");
-			goto out_err;
-		}
+	retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
+	if (retval) {
+		err_msg("Failed to set stop total us\n");
+		goto out_err;
+	}
+
+	retval = osnoise_set_tracing_thresh(tool->context, params->threshold);
+	if (retval) {
+		err_msg("Failed to set tracing_thresh\n");
+		goto out_err;
 	}
 
 	if (params->hk_cpus) {
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 448fb1f7d3a6..c29e2ba2d7d8 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -16,6 +16,8 @@
 
 #include "timerlat.h"
 
+#define DEFAULT_TIMERLAT_PERIOD	1000			/* 1ms */
+
 /*
  * timerlat_apply_config - apply common configs to the initialized tool
  */
@@ -27,49 +29,44 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 	if (!params->sleep_time)
 		params->sleep_time = 1;
 
-	if (params->cpus) {
-		retval = osnoise_set_cpus(tool->context, params->cpus);
-		if (retval) {
-			err_msg("Failed to apply CPUs config\n");
-			goto out_err;
-		}
-	} else {
+	retval = osnoise_set_cpus(tool->context, params->cpus ? params->cpus : "all");
+	if (retval) {
+		err_msg("Failed to apply CPUs config\n");
+		goto out_err;
+	}
+
+	if (!params->cpus) {
 		for (i = 0; i < sysconf(_SC_NPROCESSORS_CONF); i++)
 			CPU_SET(i, &params->monitored_cpus);
 	}
 
-	if (params->stop_us) {
-		retval = osnoise_set_stop_us(tool->context, params->stop_us);
-		if (retval) {
-			err_msg("Failed to set stop us\n");
-			goto out_err;
-		}
+	retval = osnoise_set_stop_us(tool->context, params->stop_us);
+	if (retval) {
+		err_msg("Failed to set stop us\n");
+		goto out_err;
 	}
 
-	if (params->stop_total_us) {
-		retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
-		if (retval) {
-			err_msg("Failed to set stop total us\n");
-			goto out_err;
-		}
+	retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
+	if (retval) {
+		err_msg("Failed to set stop total us\n");
+		goto out_err;
 	}
 
 
-	if (params->timerlat_period_us) {
-		retval = osnoise_set_timerlat_period_us(tool->context, params->timerlat_period_us);
-		if (retval) {
-			err_msg("Failed to set timerlat period\n");
-			goto out_err;
-		}
+	retval = osnoise_set_timerlat_period_us(tool->context,
+						params->timerlat_period_us ?
+						params->timerlat_period_us :
+						DEFAULT_TIMERLAT_PERIOD);
+	if (retval) {
+		err_msg("Failed to set timerlat period\n");
+		goto out_err;
 	}
 
 
-	if (params->print_stack) {
-		retval = osnoise_set_print_stack(tool->context, params->print_stack);
-		if (retval) {
-			err_msg("Failed to set print stack\n");
-			goto out_err;
-		}
+	retval = osnoise_set_print_stack(tool->context, params->print_stack);
+	if (retval) {
+		err_msg("Failed to set print stack\n");
+		goto out_err;
 	}
 
 	if (params->hk_cpus) {
-- 
2.48.1

