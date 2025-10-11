Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8814123ABAF
	for <linux-trace-kernel@vger.kernel.org>; Sat, 11 Oct 2025 08:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760171315; cv=none; b=ogxTnojFQe4ztZHJqMI+8mT2KrwJFUYO8VKs6XEXRaNW0VVdsloGgHZ74HANXo/2N5q1zLUMYKfevZsgOLv/1jskZTEVUVW0HMaBm6J/A+wi6HmaOZyO/HR/2lZK+7NpZDgPICB6k+Q18Hl6ib7f5V6zXV1+lEXmfF9zvGPTOdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760171315; c=relaxed/simple;
	bh=LRfI47UB2UnyFYw/FWC26NL7Yq0N9R5zYg3HcLRgkdM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=RtfjiACKUGiFO/0mdBpl6SKEJc9xZuHZlYroafK+EWcK2o7cBdD5m89PJtuD0Y42DeohSI9Mpp/60n8DiJN9JcagTkQ1NGcSmJ1WHQR4VE5a9NlUYJocEUPy5DaO6cgtwXKzYpFEL4CLCaMxUrvlgqA2iVigyxUvHs/C+fGlFm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dsGrrI9b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dsGrrI9b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760171308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rHj98cou2Y19csOC6HqCSeOGSHvHBg7RYgMNCaj5iUM=;
	b=dsGrrI9boOUvqZhpWt9z0xI/TXZl/aB05gfOiryTQx0Mome7F0V1rORBZJ/BC1kAFa5zfc
	QNHjUFsBf8sLhfl94Q6EfHMiL/G56UMWeODVhPRO9SL48OwNOQd/UYP4Q+yJIKl3zS4tm4
	0gATF8kjpEya2ZgRCDZnTc+KfmFU/y0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-AOWjfFkaPZ6N9IZ8q1HiWg-1; Sat, 11 Oct 2025 04:28:27 -0400
X-MC-Unique: AOWjfFkaPZ6N9IZ8q1HiWg-1
X-Mimecast-MFC-AGG-ID: AOWjfFkaPZ6N9IZ8q1HiWg_1760171306
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e44b9779eso15952755e9.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 11 Oct 2025 01:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760171306; x=1760776106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHj98cou2Y19csOC6HqCSeOGSHvHBg7RYgMNCaj5iUM=;
        b=YPo7AGBPhDu+geBH/wUrY1kfUFgIx3TbRNjeuqcUK+UvyzrG5XWm4dDMzuUGmEjrR7
         DeVB05esnw2jFLVQB+0FjTaV+5C52K41NzvTKAE12PEgPsqmS3ltDysoi0mwsyio6Jfc
         uPpZ+pTkA+0g3DZMrNic4HCuHBAIM1i3Rz24ftuK352s4YT9K5ge8Vy6Hk9ZbwKIzgIW
         17j2zQaxlprkWS5x+Q6TgoE7MtFoBgpMcM9kUD48y4Rb05Ag4/BnE3IJolayn5Yo5Ubt
         JmKmVrqAiHCfhDS0KerHTDicdjTrKKgtwrZzJBHARG1c3bGYWKrEbjdtjE01WwniSY4G
         jUKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUHfIqadQEamMla5qOw06Y+QtpfJ88IZC2+S4kLbuRaOycZGKhbDpsaZRU31NkQKGfwiRIgyBqklqIlQe7k/T6uIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMJ25/E9PaQxZEz59nSalghBmCGY3WRHJne6CyXExfJYnraWz7
	nnRDiBbByzN7Uo93/rKNRqzmFbmRACkJwhu13ptBDkLFLrRJ5FizIg214jKCtlPy+LpJ6lSu9rx
	t25RPbRfZ7j8k6w1/Pk27fIMQhBKKrMITsDBy/+9FoPKfMuDAv03BqmXNGa2dYyCV4xnKVbP6uA
	==
X-Gm-Gg: ASbGncvTOK6CtlveVrjS94k1CZgMTiKbWEVMAn9pu89d3lBjbDkMdmbGgcbK0dF8A4v
	+P/4pGEaVT198cqPA/WstVHagz6T7jqagenzXIZppa8i6FJG8ITr26lHlr28QUlMIdtAnPPckFF
	ird4ZBHcjG/Xvtl0ieb90YAtQ9Wd/rn0euLyJ5ur6fq7tVbDeZWmOq6DtKHuPh0EbC0ClZrvVy7
	sm+rVnzxWfIgOt+FlDQlGDtK1ILWJwSWNs4Ri+z6a3qdMrjTJiQKQjls291Ugj8kcsjUkey9Z+P
	yceGhBmtsHvhuEJLl7lecJ5XDDvstTzdzIEJFd37H+ZX
X-Received: by 2002:a05:6000:4305:b0:3ec:d78d:8fcc with SMTP id ffacd0b85a97d-42666ab85a7mr8999689f8f.14.1760171305784;
        Sat, 11 Oct 2025 01:28:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqokUQUSflqj2ie1uzhEOzTJOaDkXEKNoBKE1a5t+pgJEbZNk3LxtrY+4KW6G+rzLsLPIdSg==
X-Received: by 2002:a05:6000:4305:b0:3ec:d78d:8fcc with SMTP id ffacd0b85a97d-42666ab85a7mr8999670f8f.14.1760171305390;
        Sat, 11 Oct 2025 01:28:25 -0700 (PDT)
Received: from localhost ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d0006sm8022580f8f.34.2025.10.11.01.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 01:28:25 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] tools/rtla: Replace timerlat_hist_usage("...") with fatal("...")
Date: Sat, 11 Oct 2025 11:27:36 +0300
Message-ID: <20251011082738.173670-4-costa.shul@redhat.com>
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
X-Mimecast-MFC-PROC-ID: IVycYlOQccW4_B5qD_nuWJoxhxszPvMxadFMewWF5Io_1760171306
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

A long time ago, when the usage help was short, it was a favor
to the user to show it on error. Now that the usage help has
become very long, it is too noisy to dump the complete help text
for each typo after the error message itself.

Replace timerlat_hist_usage("...\n") with fatal("...") on errors.

Remove the already unused 'usage' argument from timerlat_hist_usage().

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---

Changes since v1:
- fatal() prints "\n" insteasd of caller as suggested by Crystal Wood
---
 tools/tracing/rtla/src/timerlat_hist.c | 32 +++++++++++---------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index ab5d8ca4593c..71557f5751a6 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -710,7 +710,7 @@ timerlat_print_stats(struct osnoise_tool *tool)
 /*
  * timerlat_hist_usage - prints timerlat top usage message
  */
-static void timerlat_hist_usage(char *usage)
+static void timerlat_hist_usage(void)
 {
 	int i;
 
@@ -766,18 +766,12 @@ static void timerlat_hist_usage(char *usage)
 		NULL,
 	};
 
-	if (usage)
-		fprintf(stderr, "%s\n", usage);
-
 	fprintf(stderr, "rtla timerlat hist: a per-cpu histogram of the timer latency (version %s)\n",
 			VERSION);
 
 	for (i = 0; msg[i]; i++)
 		fprintf(stderr, "%s\n", msg[i]);
 
-	if (usage)
-		exit(EXIT_FAILURE);
-
 	exit(EXIT_SUCCESS);
 }
 
@@ -884,7 +878,7 @@ static struct common_params
 		case 'c':
 			retval = parse_cpu_set(optarg, &params->common.monitored_cpus);
 			if (retval)
-				timerlat_hist_usage("\nInvalid -c cpu list\n");
+				fatal("Invalid -c cpu list");
 			params->common.cpus = optarg;
 			break;
 		case 'C':
@@ -901,7 +895,7 @@ static struct common_params
 			params->common.hist.bucket_size = get_llong_from_str(optarg);
 			if (params->common.hist.bucket_size == 0 ||
 			    params->common.hist.bucket_size >= 1000000)
-				timerlat_hist_usage("Bucket size needs to be > 0 and <= 1000000\n");
+				fatal("Bucket size needs to be > 0 and <= 1000000");
 			break;
 		case 'D':
 			config_debug = 1;
@@ -909,7 +903,7 @@ static struct common_params
 		case 'd':
 			params->common.duration = parse_seconds_duration(optarg);
 			if (!params->common.duration)
-				timerlat_hist_usage("Invalid -D duration\n");
+				fatal("Invalid -D duration");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
@@ -925,11 +919,11 @@ static struct common_params
 			params->common.hist.entries = get_llong_from_str(optarg);
 			if (params->common.hist.entries < 10 ||
 			    params->common.hist.entries > 9999999)
-				timerlat_hist_usage("Entries must be > 10 and < 9999999\n");
+				fatal("Entries must be > 10 and < 9999999");
 			break;
 		case 'h':
 		case '?':
-			timerlat_hist_usage(NULL);
+			timerlat_hist_usage();
 			break;
 		case 'H':
 			params->common.hk_cpus = 1;
@@ -949,12 +943,12 @@ static struct common_params
 		case 'p':
 			params->timerlat_period_us = get_llong_from_str(optarg);
 			if (params->timerlat_period_us > 1000000)
-				timerlat_hist_usage("Period longer than 1 s\n");
+				fatal("Period longer than 1 s");
 			break;
 		case 'P':
 			retval = parse_prio(optarg, &params->common.sched_param);
 			if (retval == -1)
-				timerlat_hist_usage("Invalid -P priority");
+				fatal("Invalid -P priority");
 			params->common.set_sched = 1;
 			break;
 		case 's':
@@ -1004,7 +998,7 @@ static struct common_params
 				if (retval)
 					fatal("Error adding trigger %s", optarg);
 			} else {
-				timerlat_hist_usage("--trigger requires a previous -e\n");
+				fatal("--trigger requires a previous -e");
 			}
 			break;
 		case '7': /* filter */
@@ -1013,7 +1007,7 @@ static struct common_params
 				if (retval)
 					fatal("Error adding filter %s", optarg);
 			} else {
-				timerlat_hist_usage("--filter requires a previous -e\n");
+				fatal("--filter requires a previous -e");
 			}
 			break;
 		case '8':
@@ -1060,10 +1054,10 @@ static struct common_params
 		fatal("rtla needs root permission");
 
 	if (params->common.hist.no_irq && params->common.hist.no_thread)
-		timerlat_hist_usage("no-irq and no-thread set, there is nothing to do here");
+		fatal("no-irq and no-thread set, there is nothing to do here");
 
 	if (params->common.hist.no_index && !params->common.hist.with_zeros)
-		timerlat_hist_usage("no-index set with with-zeros is not set - it does not make sense");
+		fatal("no-index set with with-zeros is not set - it does not make sense");
 
 	/*
 	 * Auto analysis only happens if stop tracing, thus:
@@ -1072,7 +1066,7 @@ static struct common_params
 		params->no_aa = 1;
 
 	if (params->common.kernel_workload && params->common.user_workload)
-		timerlat_hist_usage("--kernel-threads and --user-threads are mutually exclusive!");
+		fatal("--kernel-threads and --user-threads are mutually exclusive!");
 
 	/*
 	 * If auto-analysis or trace output is enabled, switch from BPF mode to
-- 
2.51.0

