Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28411DE8BC;
	Wed, 19 Feb 2025 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965956; cv=none; b=UziPSGjO4RYuhiyuLAW+i2VGkM3z8du/k8Z29z9nxMadUT2s+6tkkIws5a1s3NCUd35klwRJGt4ihiEtl0l3vN+xEhohe8UQT+2znZcb/AZn1Y7rjQduSkAlU2XeDc4qI8MBHMqKkcR/Xai9IbfzdOFr4kfeNaVsRSqrrZEg9U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965956; c=relaxed/simple;
	bh=5rGzPdpmBRaN/dPorbD6DNUJs1Ekol5zaoipRHPyKcg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HDBcoP4Jj5weI8Yfzm/5UPPiXDmPpTsMsEWtJ/cPCCjtcLpqR12jI+5UP2K3xzskFCGqf1xqRxkYJvn/ifA1LC1auonqArGWy/CfP/NN7UEZoOOZStU5DrPWnwlDlmS62XretiKzynM4sr4kKNhL2TKbr4DyTKKZeWd2ZuxwOjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4396a4d5e3bso49907225e9.3;
        Wed, 19 Feb 2025 03:52:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739965953; x=1740570753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GVCpuBaVqDhYrAktBUvHWQ6eE7h/rySOGAjUg4kBeg=;
        b=FcOsXWuGbNrPjvZRbwX+s4TxM1HdVk8R5FJ9p1OrkFy8mG8qZhhMALOXZOGSYXDWzD
         o0vkJftUaUNoXA6EART7NsKSHYiA36LqI5B/q1pA4Buf2kehOQbNpzPwxmbkWnc3r8A3
         iNxI632b8LbHNc/5uG4j5AZ27pVGO95yBFaF38HoSiszrDjH7MyHE2RZLST/7HkKS+Ss
         vHmF4tHWdtEJZd6IGaiExqBQpmuws2Z8H7/xRts9WZD4M9vfXkJ6LxNb8hDoeDEQYdxk
         d9kRqHCx0k7BtWJEdT01SlxS7XlvwsmSPT+MheLIvvUcieHQ6tffFv3ypyVi+VKWZM1j
         E5Hw==
X-Forwarded-Encrypted: i=1; AJvYcCU+VYa1jvDtJhQtWxso0TNJyV+0Tknkf9i+Ei71VKpcMjC8I4iLGQeaI7no3TUO2sm3tzLx5+6EzqD6liznp5WNJnPv@vger.kernel.org, AJvYcCXU27fRECFnd/i3LiGJhnWckiPqkUXtzdBmmQ5zIkFSrf3WFZl6ectuyzvzsRlbiKJRVTvvfz0ZBgSwY14=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUlUFtP0qXOpetFV/qQjZUdwZ1raeR5C/X9GqIjFHdKNOoCiFj
	iHMB695da0zQV4gJmzBlfErVhfjYy47J9UR4LaVnPEXoAoZHWjgdP91X5PLHG9Q=
X-Gm-Gg: ASbGncv5AA0/h+0XK6wnGyz1Udh/R494rWtdZPRnMktz2ei0/g7V+yOR3HFdRz967Zg
	gSl1esDqlhqo9ySkFdDtrg1arFPwySr/k9BO82Z/07GO4mqu2xLJBjhOz+9rew1UPaZhLOYjpp1
	op/zI2lFb7cH7bIaWcvnRC7kXOWr6dHBM6Zo9lwbHLnfORHzOWPTTtrlRX+DYcwIq8MK9IsnFIX
	QIWsXN18ngP/LqxaoOmvOy7k6ZooA4ov4UVl2MpDiSIsT+T/1Dxbd7TuXQgFvHUlAov20vjEDdY
	lEzYDkdYJTH9dgw+JwNNMUvSwaGQ9Uw+
X-Google-Smtp-Source: AGHT+IE/c+Ksc46dGnu84e9QkmFiPT5dAH5jp0N9KvELTSa06TyHyAY9kKRXYAQHF/w6yRDl2jnK4g==
X-Received: by 2002:a05:600c:1c18:b0:439:6d7c:48fd with SMTP id 5b1f17b1804b1-43999d755acmr31206835e9.4.1739965952941;
        Wed, 19 Feb 2025 03:52:32 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e280:5300:f8dc:acb8:77bb:8cf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43993d297e9sm47979485e9.33.2025.02.19.03.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 03:52:32 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Eder Zulian <ezulian@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] rtla: Refactor save_trace_to_file
Date: Wed, 19 Feb 2025 13:51:10 +0200
Message-ID: <20250219115138.406075-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The functions osnoise_hist_main(), osnoise_top_main(),
timerlat_hist_main(), and timerlat_top_main() are lengthy and contain
duplicated code.

Refactor by consolidating the duplicate lines into the
save_trace_to_file() function.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/osnoise_hist.c  | 5 +----
 tools/tracing/rtla/src/osnoise_top.c   | 5 +----
 tools/tracing/rtla/src/timerlat_hist.c | 5 +----
 tools/tracing/rtla/src/timerlat_top.c  | 5 +----
 tools/tracing/rtla/src/trace.c         | 4 ++++
 5 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index b4930b835b0a1..7c6ef67ef3e6c 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -983,10 +983,7 @@ int osnoise_hist_main(int argc, char *argv[])
 
 	if (osnoise_trace_is_off(tool, record)) {
 		printf("rtla osnoise hit stop tracing\n");
-		if (params->trace_output) {
-			printf("  Saving trace to %s\n", params->trace_output);
-			save_trace_to_file(record->trace.inst, params->trace_output);
-		}
+		save_trace_to_file(record->trace.inst, params->trace_output);
 	}
 
 out_hist:
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 4772677ac762c..0eeefbbbf3173 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -813,10 +813,7 @@ int osnoise_top_main(int argc, char **argv)
 
 	if (osnoise_trace_is_off(tool, record)) {
 		printf("osnoise hit stop tracing\n");
-		if (params->trace_output) {
-			printf("  Saving trace to %s\n", params->trace_output);
-			save_trace_to_file(record->trace.inst, params->trace_output);
-		}
+		save_trace_to_file(record->trace.inst, params->trace_output);
 	}
 
 out_top:
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 6d7d0a2d45b47..5f54b268a1033 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -1390,10 +1390,7 @@ int timerlat_hist_main(int argc, char *argv[])
 		if (!params->no_aa)
 			timerlat_auto_analysis(params->stop_us, params->stop_total_us);
 
-		if (params->trace_output) {
-			printf("  Saving trace to %s\n", params->trace_output);
-			save_trace_to_file(record->trace.inst, params->trace_output);
-		}
+		save_trace_to_file(record->trace.inst, params->trace_output);
 	}
 
 out_hist:
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 05a9403b01d26..1e64e6216bc2e 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -1159,10 +1159,7 @@ int timerlat_top_main(int argc, char *argv[])
 		if (!params->no_aa)
 			timerlat_auto_analysis(params->stop_us, params->stop_total_us);
 
-		if (params->trace_output) {
-			printf("  Saving trace to %s\n", params->trace_output);
-			save_trace_to_file(record->trace.inst, params->trace_output);
-		}
+		save_trace_to_file(record->trace.inst, params->trace_output);
 	} else if (params->aa_only) {
 		/*
 		 * If the trace did not stop with --aa-only, at least print the
diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 728f5029d5335..74ed2f6208baa 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -75,12 +75,16 @@ int save_trace_to_file(struct tracefs_instance *inst, const char *filename)
 	int out_fd, in_fd;
 	int retval = -1;
 
+	if (!filename)
+		return 0;
+
 	in_fd = tracefs_instance_file_open(inst, file, O_RDONLY);
 	if (in_fd < 0) {
 		err_msg("Failed to open trace file\n");
 		return -1;
 	}
 
+	printf("  Saving trace to %s\n", filename);
 	out_fd = creat(filename, mode);
 	if (out_fd < 0) {
 		err_msg("Failed to create output file %s\n", filename);
-- 
2.48.1

