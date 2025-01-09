Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B342010E6;
	Thu,  9 Jan 2025 21:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736457273; cv=none; b=atW19lV5ziVRHuKk1fsSOcAvlt2+Lb2B0YAR4rdyhwMOvzIbn+KWDRJ1hA3/9JrV4LA4MGPzLu0f06zHZ3qn5flUT317EKykO4ve6lu6qjzX1qXa+KkTjYiUbigI6H6OjsuHpmwLM8i/liIGOSooxWZ2OkUhqDJ0A1mIwyJAr9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736457273; c=relaxed/simple;
	bh=T7mLdB6SFMBqseE74nTV1i35EkF5aSyYIoY0ENC5AtI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WviUVgixYSMcORUqxGW73sE6tONgnjURAHUlgvsElU7PumwVmYsSlybDlszXIL7BzIo3VSk7UMKD3JtZW+JJZgvOfXi9AlQK94wFQ3MH/GcsbFoRZm3or5PR4SDEH3skMujxy8V4TmjeuxFtj/5qF5tbv0L8wOg1jN7PvJhQPuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-436249df846so10725355e9.3;
        Thu, 09 Jan 2025 13:14:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736457270; x=1737062070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L3BgyD96AdvmODXIra9m834m7lsPtt6nQc0wsfjhkbI=;
        b=SqDWj0BU+EmVQ1DHbfnkiXVlPTK9DHzYGQkJfFWoRVOix6jsBKkeLjGuRQpkx1JoEM
         ipw+GhzwGJLq9soxXDqZFAz1SV3KEqrYm2mJR0b37LPhwTuZVqZ3VCOczUK5Q04jPBWe
         MaT98i4PNhY8QqXXDOcnvBU10XjfvE5KPLz3h6z/vCpkIRLC0+tykHF+AtvtyjR1dmWB
         o5E3td2QYIUvVKxyofE6tIcB2Rf0dqUVJNcb6tM9/GDgxfysoBRz43juJ6WRYaapOZYX
         c5WlYSL4U99svLr9wuTHJGUN271gU1qNjhj6G6Wjg+RAfY+hr/QqbR8skvTddvF2yBNd
         9fvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP6cQThHwyumvXdEcmFSeoScqEgO8xg4+94gpaPufie0IVMVisraUxvS2m8fQjNMM5exu5ZKfCO4InT95hyWiYfo+y@vger.kernel.org, AJvYcCVr7qm8U5DrmmLx1yAw9QWGkqIborfDzzSp6vt7FO+oaclLlcPq+L7i6wNrc2S1Hac3XByWnDleut6thgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRx2NhfDxLmyVxF1PV99W4SHPKcrmHniZXy5Ex8jW3vKfOjrfx
	zxCVqqtsU5RzjFPfPQSTA3Zi5HqXaWipWJenS96UBX4ZXmUpCGV9R9H5udc4QFQ=
X-Gm-Gg: ASbGnct0Y83iOluZhivtZLxcN2C2xejsYTRCqVGHVI+8cdTTJg7uO7NJ2OjcfYzJL7d
	dWeZPCJSd6gkuQa9/OYvlMo9l11jaLe5HR5Sj87TkiQyVC/9Sc9fIvJkW5dt3ybeDVt/x8HK6+n
	ySMxRG7+rGMJ0gN57u/g7EN/Tej56rAH8ttvBb6sS61jvpLqSHD/zW4lU6fVLzA+EOHQeQSV8nK
	zaX0BItIyf5Z/KjbGB/mZVkeloaJ4mTvUilgVXGFBxc6IGt4//NjmKCIWZXeZSv03xfrGrjQw==
X-Google-Smtp-Source: AGHT+IGrVec3oVckwVZ9ObdeTFgXkGPL5Dk7SFR3ZpSDPk8KzOWIcZa1/3UPWj/1eqdRltr0eHceUQ==
X-Received: by 2002:a05:600c:4f81:b0:434:f1d5:1453 with SMTP id 5b1f17b1804b1-436e2531ec8mr83841635e9.0.1736457269944;
        Thu, 09 Jan 2025 13:14:29 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e280:5300:9068:704e:a31a:c135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9dc895esm31728785e9.13.2025.01.09.13.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 13:14:29 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Eder Zulian <ezulian@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] rtla: Fix implicit NULL dereference
Date: Thu,  9 Jan 2025 23:13:26 +0200
Message-ID: <20250109211358.2619367-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `record` variable is NULL when tracing is not requested:

struct osnoise_tool *record = NULL;

if (params->trace_output) {
        record = osnoise_init_trace_tool("osnoise");
....

Value of `&record->trace` in this case is NULL just because
the `trace` member is the first member `struct osnoise_tool` with offset 0.
`&record->trace` just returns the offset.

Explicit dereference `record->trace' would cause segmentation fault.

Add explicit check for zero `record`.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/osnoise_hist.c  | 4 ++--
 tools/tracing/rtla/src/osnoise_top.c   | 4 ++--
 tools/tracing/rtla/src/timerlat_hist.c | 4 ++--
 tools/tracing/rtla/src/timerlat_top.c  | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 214e2c93fde01..46add229967b1 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -970,7 +970,7 @@ int osnoise_hist_main(int argc, char *argv[])
 			goto out_hist;
 		}
 
-		if (trace_is_off(&tool->trace, &record->trace))
+		if (trace_is_off(&tool->trace, record ? &record->trace : NULL))
 			break;
 	}
 
@@ -980,7 +980,7 @@ int osnoise_hist_main(int argc, char *argv[])
 
 	return_value = 0;
 
-	if (trace_is_off(&tool->trace, &record->trace)) {
+	if (trace_is_off(&tool->trace, record ? &record->trace : NULL)) {
 		printf("rtla osnoise hit stop tracing\n");
 		if (params->trace_output) {
 			printf("  Saving trace to %s\n", params->trace_output);
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 45647495ce3bd..a0302b30da122 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -801,7 +801,7 @@ int osnoise_top_main(int argc, char **argv)
 		if (!params->quiet)
 			osnoise_print_stats(params, tool);
 
-		if (trace_is_off(&tool->trace, &record->trace))
+		if (trace_is_off(&tool->trace, record ? &record->trace : NULL))
 			break;
 
 	}
@@ -810,7 +810,7 @@ int osnoise_top_main(int argc, char **argv)
 
 	return_value = 0;
 
-	if (trace_is_off(&tool->trace, &record->trace)) {
+	if (trace_is_off(&tool->trace, record ? &record->trace : NULL)) {
 		printf("osnoise hit stop tracing\n");
 		if (params->trace_output) {
 			printf("  Saving trace to %s\n", params->trace_output);
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 4403cc4eba302..d92a894fecc00 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -1342,7 +1342,7 @@ int timerlat_hist_main(int argc, char *argv[])
 			goto out_hist;
 		}
 
-		if (trace_is_off(&tool->trace, &record->trace))
+		if (trace_is_off(&tool->trace, record ? &record->trace : NULL))
 			break;
 
 		/* is there still any user-threads ? */
@@ -1363,7 +1363,7 @@ int timerlat_hist_main(int argc, char *argv[])
 
 	return_value = 0;
 
-	if (trace_is_off(&tool->trace, &record->trace)) {
+	if (trace_is_off(&tool->trace, record ? &record->trace : NULL)) {
 		printf("rtla timerlat hit stop tracing\n");
 
 		if (!params->no_aa)
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 059b468981e4d..f05ef7aadf515 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -1093,7 +1093,7 @@ int timerlat_top_main(int argc, char *argv[])
 	while (!stop_tracing) {
 		sleep(params->sleep_time);
 
-		if (params->aa_only && !trace_is_off(&top->trace, &record->trace))
+		if (params->aa_only && !trace_is_off(&top->trace, record ? &record->trace : NULL))
 			continue;
 
 		retval = tracefs_iterate_raw_events(trace->tep,
@@ -1110,7 +1110,7 @@ int timerlat_top_main(int argc, char *argv[])
 		if (!params->quiet)
 			timerlat_print_stats(params, top);
 
-		if (trace_is_off(&top->trace, &record->trace))
+		if (trace_is_off(&top->trace, record ? &record->trace : NULL))
 			break;
 
 		/* is there still any user-threads ? */
@@ -1131,7 +1131,7 @@ int timerlat_top_main(int argc, char *argv[])
 
 	return_value = 0;
 
-	if (trace_is_off(&top->trace, &record->trace)) {
+	if (trace_is_off(&top->trace, record ? &record->trace : NULL)) {
 		printf("rtla timerlat hit stop tracing\n");
 
 		if (!params->no_aa)
-- 
2.47.0

