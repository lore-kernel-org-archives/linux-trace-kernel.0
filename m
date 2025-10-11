Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3258239E6F
	for <linux-trace-kernel@vger.kernel.org>; Sat, 11 Oct 2025 08:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760171312; cv=none; b=CzybnJuvMJBgYyZ7Vr8THWkFe4jSHVPpph/bmn6avpybcHinpadD0ohzyOhF2144GZrr1Fma9eqWdkYerQFxo293OUDgGuot16Zl71GHxcz5jREabjkQB9uYj0FMzkTp42XzhogZ1u6CERDIQQ774iJiFOFo4TZKyJs10WCEE9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760171312; c=relaxed/simple;
	bh=bK9ZbbRSu/RcSrw1tHd8Ioosrltuz2a83Oe9kALhMi0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=BLLBEcTgBCfcwpIiNdOygYzlLcbfPUcZNpl9Y3iNxISZ0ZPgsrShfYG5wq+qK+Juanwuo3EPEJLXoAtCRaWDibns4qPcu522gR+oP5/9sJb3kch9hPa6C+KFM7pi1M29qQEf/m1WeW2YcEmUxY5R3nIgXY9jDlWzNev2nZTw75c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G44Tp6EC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G44Tp6EC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760171305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dBAgrUtuAZgF1r3Y0+9jCP35gSNzVvlFmIc27nq44Uk=;
	b=G44Tp6ECiFAaeFSGd78HthSJjzbI455qLl57mTSEmpRSv3xYRiq5jz8zMKxEYT05RHjORC
	qoysIHGsebwFjzJ2x7bapRnS8x8FEIBpMlFyOcb0usZGQHTvioUYqGVCYRBX4fN2jtlxBR
	CroBNqXpjGtxU53ooW3x7RRFWqoI7kM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-q4qWoFKlPDaVe7VZuw3W-A-1; Sat, 11 Oct 2025 04:28:24 -0400
X-MC-Unique: q4qWoFKlPDaVe7VZuw3W-A-1
X-Mimecast-MFC-AGG-ID: q4qWoFKlPDaVe7VZuw3W-A_1760171303
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-426d314d0deso602173f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 11 Oct 2025 01:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760171303; x=1760776103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBAgrUtuAZgF1r3Y0+9jCP35gSNzVvlFmIc27nq44Uk=;
        b=Rhj8HqKEtdEakXzczz9qEWwptq1yiPKBxDgMmR8xOVn0HHyRfxSl5Y7Z4tqz2LPAMk
         cCSvjboaR9mE+dWnGDEkHzoosWEnNJNeWoHZ7mf7YuUG+3eZbAAkm0Nx26hkvaE0kMrI
         Ebt1lHKdZ0UY1dYiSY67NaI2SmlnJpOYcNFg12jxdZZl0+5CxAI0e+Ocy6LddXWWizI1
         MNK/BNbrs6lkhfK4ImRCVmFR7htIcLwGYDJd/hoV5DRUYzusj+V98F2Y0n46VtDw8Tf8
         +l2IMdJ9SAxAYLuzmpk8rLbIdHcbmsXsVMhE+BTnxGTDeVTUvT/FQJ8LHinrcigztaK6
         NPBg==
X-Forwarded-Encrypted: i=1; AJvYcCV2O/QykKCXyC0ZQ1uxWqudRrWuy+B8NgFgjdhTiSyaa++efLrccvYo5fEyOJp2vMn3pCf4DXIVbaB8vU+x9r+ea+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YytI14snRxIy4yeGhDMpwruCqZTv/MFwILabVizSexkRRXZYN2t
	LFezc7Nzv8x88Rtb/F56gf/ARYOph3+Z6DCWDlCAnxS7blLdM9dW2eZXrqlN45HaLBm8rWIz1Ka
	g9BUx1tQtpypYIvlp3bKe11dO47hWFlc/0yPazl6o15yXvNyTV152l8OHhsNXj5TcGv1wz6foxw
	==
X-Gm-Gg: ASbGncsTLMpi+5JF8z2YSvwvMHy9TGvBKsxFHKMT0XyQeKZBc1xC/gu/OT2RPR3UsR1
	j+5apkDIG9IdZnFQZNxcEawa2gQ2gd2t1qm4c9ZG6n7yaNuzUzy15qkzUSqn7r4iX3uc41VDI2w
	dWrKKo4YvCwQHlv61rEQTVV7E+2wIceNh9Pk4bMZWWMo9iRI7WTTL74958aRP0nBuLJLESbkzG8
	wbwFX7pj5jztkPEXBBVnztxeoVbmyOGapwxX7h6dnrCVPdN9AAJGIySOUD3ENKuUOZPCZCJ5Wpp
	se8x30Hr2fEanWIdVW5iKkFMaWrraRN85RwE/+qjLsAj
X-Received: by 2002:a05:6000:659:10b0:426:d82f:889e with SMTP id ffacd0b85a97d-426d82f88cbmr276597f8f.14.1760171303103;
        Sat, 11 Oct 2025 01:28:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrOrLxL1eNdz8ZKW238q93rZX5VW6RjLN0F6KEdjI7rPURwhL8djYrNs8pRcGaxQcWksUQkg==
X-Received: by 2002:a05:6000:659:10b0:426:d82f:889e with SMTP id ffacd0b85a97d-426d82f88cbmr276582f8f.14.1760171302720;
        Sat, 11 Oct 2025 01:28:22 -0700 (PDT)
Received: from localhost ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d0006sm8022580f8f.34.2025.10.11.01.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 01:28:22 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] tools/rtla: Replace timerlat_top_usage("...") with fatal("...")
Date: Sat, 11 Oct 2025 11:27:35 +0300
Message-ID: <20251011082738.173670-3-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251011082738.173670-1-costa.shul@redhat.com>
References: <20251011082738.173670-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: A88EGF5WC5tc_HfnMcp2HHNPurP_BUPmW6wAd9oJLsQ_1760171303
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

A long time ago, when the usage help was short, it was a favor
to the user to show it on error. Now that the usage help has
become very long, it is too noisy to dump the complete help text
for each typo after the error message itself.

Replace timerlat_top_usage("...\n") with fatal("...") on errors.

Remove the already unused 'usage' argument from timerlat_top_usage().

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---

Changes since v1:
- fatal() prints "\n" insteasd of caller as suggested by Crystal Wood
---
 tools/tracing/rtla/src/timerlat_top.c | 28 +++++++++++----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index d8e60f823b25..27b64bdc5b18 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -476,7 +476,7 @@ timerlat_print_stats(struct osnoise_tool *top)
 /*
  * timerlat_top_usage - prints timerlat top usage message
  */
-static void timerlat_top_usage(char *usage)
+static void timerlat_top_usage(void)
 {
 	int i;
 
@@ -524,18 +524,12 @@ static void timerlat_top_usage(char *usage)
 		NULL,
 	};
 
-	if (usage)
-		fprintf(stderr, "%s\n", usage);
-
 	fprintf(stderr, "rtla timerlat top: a per-cpu summary of the timer latency (version %s)\n",
 			VERSION);
 
 	for (i = 0; msg[i]; i++)
 		fprintf(stderr, "%s\n", msg[i]);
 
-	if (usage)
-		exit(EXIT_FAILURE);
-
 	exit(EXIT_SUCCESS);
 }
 
@@ -648,7 +642,7 @@ static struct common_params
 		case 'c':
 			retval = parse_cpu_set(optarg, &params->common.monitored_cpus);
 			if (retval)
-				timerlat_top_usage("\nInvalid -c cpu list\n");
+				fatal("Invalid -c cpu list");
 			params->common.cpus = optarg;
 			break;
 		case 'C':
@@ -667,7 +661,7 @@ static struct common_params
 		case 'd':
 			params->common.duration = parse_seconds_duration(optarg);
 			if (!params->common.duration)
-				timerlat_top_usage("Invalid -d duration\n");
+				fatal("Invalid -d duration");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
@@ -680,7 +674,7 @@ static struct common_params
 			break;
 		case 'h':
 		case '?':
-			timerlat_top_usage(NULL);
+			timerlat_top_usage();
 			break;
 		case 'H':
 			params->common.hk_cpus = 1;
@@ -700,12 +694,12 @@ static struct common_params
 		case 'p':
 			params->timerlat_period_us = get_llong_from_str(optarg);
 			if (params->timerlat_period_us > 1000000)
-				timerlat_top_usage("Period longer than 1 s\n");
+				fatal("Period longer than 1 s");
 			break;
 		case 'P':
 			retval = parse_prio(optarg, &params->common.sched_param);
 			if (retval == -1)
-				timerlat_top_usage("Invalid -P priority");
+				fatal("Invalid -P priority");
 			params->common.set_sched = 1;
 			break;
 		case 'q':
@@ -740,7 +734,7 @@ static struct common_params
 				if (retval)
 					fatal("Error adding trigger %s", optarg);
 			} else {
-				timerlat_top_usage("--trigger requires a previous -e\n");
+				fatal("--trigger requires a previous -e");
 			}
 			break;
 		case '1': /* filter */
@@ -749,7 +743,7 @@ static struct common_params
 				if (retval)
 					fatal("Error adding filter %s", optarg);
 			} else {
-				timerlat_top_usage("--filter requires a previous -e\n");
+				fatal("--filter requires a previous -e");
 			}
 			break;
 		case '2': /* dma-latency */
@@ -785,7 +779,7 @@ static struct common_params
 				fatal("Invalid action %s", optarg);
 			break;
 		default:
-			timerlat_top_usage("Invalid option");
+			fatal("Invalid option");
 		}
 	}
 
@@ -802,10 +796,10 @@ static struct common_params
 		params->no_aa = 1;
 
 	if (params->no_aa && params->common.aa_only)
-		timerlat_top_usage("--no-aa and --aa-only are mutually exclusive!");
+		fatal("--no-aa and --aa-only are mutually exclusive!");
 
 	if (params->common.kernel_workload && params->common.user_workload)
-		timerlat_top_usage("--kernel-threads and --user-threads are mutually exclusive!");
+		fatal("--kernel-threads and --user-threads are mutually exclusive!");
 
 	/*
 	 * If auto-analysis or trace output is enabled, switch from BPF mode to
-- 
2.51.0

