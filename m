Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD8786341
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763747155; cv=none; b=FpiCYgha96zDjQEv5+o2WQnBQl0pjmFRlEHAwB3H5TAlG7fXpyKuV32AxKFUOWQu2Cl1ufQKtupUoVBvVZSAY3xyI3irh4OlNV+CBtORLbJPvnGiYLLvYnQkK1ITOsg8Af+HBa8pv1JqnqF9DK4nt7xkAw4oyz8yvUu0w9pF2CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763747155; c=relaxed/simple;
	bh=vxt6YkT2AJM7gpYvCrWhvWBDfSnksKr0pxtwsqtUlrA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=i3RDepq5zAyOkVYDQM1uKk0IAJ0G7b/2IofM/YefxYJBWOdnTm2HzFDXnEIQDHgTz6vhAhfkHAWiht9ffIG0d6VTqPuofeFAN8uB+F43OBJAK5E6xeYp+ZgBip7FGSC/zEk7DvUfFnOZZbCSz9ujyrDu68z/JZ5F9RxAcZimuZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ggbxGIoD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggbxGIoD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763747152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=stUTEue8FT2h1CDBsUSOzIXkuLJSdaVPkM2CKd/Olvo=;
	b=ggbxGIoDFV4NM3oSoEdb/w/ch/KAU9BZVAni8piG2bYTe53ujR1m5Wd+8avK2Y/oCw/RwL
	SRcp+BHVDz1mEZhz4iUaZWqxN0oTfpBf7IWfeNhmiwNzXYaydiDlpMwlWOJ9zRU0eDIlOH
	suqY1SDiM0HQiB4MsaiskJa8AWpyufI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-rVLSdc9EOS-1n2nTvhM_rw-1; Fri, 21 Nov 2025 12:45:51 -0500
X-MC-Unique: rVLSdc9EOS-1n2nTvhM_rw-1
X-Mimecast-MFC-AGG-ID: rVLSdc9EOS-1n2nTvhM_rw_1763747150
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b3b5ed793so1528315f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 09:45:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763747150; x=1764351950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=stUTEue8FT2h1CDBsUSOzIXkuLJSdaVPkM2CKd/Olvo=;
        b=fiYqEtJspPJNujublGJA15MPjnueTFIzTb4Pm//91+arCybhKCD5edXVw7BXtYd6Q/
         Aw9bHe8XcHsgCWPr6tQSyOKn+bNCBax8JGvVi6oj2z/nmKzxHsrPuI6S2wf7SLvZ1xLe
         HBZL0pVetpEUHhVl+zUsgjJXoodXQ7SLm4/5NjeM4HzcSkF7tmbglY1sclhhJT2o6C9Q
         VVGIHZdUl/kye+5beNkt7t/r/GcVj6hKq4gq4kh7w3VUJpUOdWfSLTCAZMXUv8Dt7gE5
         oOD0EcMXCzwmwVnZBV8eU6tSE2vgHburuFPVtEqbTb/OR5vKVTEy5pYRaXQ+XelmR6QF
         v99g==
X-Forwarded-Encrypted: i=1; AJvYcCV/4xg70nUXsCBcKxuDOQjpK70Q0uviLqtR8PKAz7LFMdXLoKE+VzY+X81zNvPBlGjEIp7UID25cd7pL7gTicKNXws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDHJy6h6qr+jDWd2EKwBU0VzjKzj6wb3x+AuoMcL4LXIrvjFsd
	zD+u+GeCO6XAbmR9HjBnuR5M3a5nNnvA3l/ZRZRVtDbuDFaSf/sven7Yj09fUKLg7nL6XrPRR5D
	nU48nZl7aAw9cQMvxVBEmLn6JPHYsMy++XDR1A57J9MjTpxk5f/LfSANoFQJucivKjFf+70TXdQ
	==
X-Gm-Gg: ASbGncs23atxO5m8ql+iZZvvyZ3zyJ6flf/znr3SvpmZeLAClVrhfubv98z10uGwSJp
	0PPMFRnfNzarvAidjTQNc+fQXFJFmZ95xeN/7Mgg0y/NPHkyv40Ya2yt1cWSzxz4eZGH4rxHlBu
	oUlJYQugxjjE/9br9PjV+zNG4EIUouvJHhbVvB2AlObnRDFdqtoDYf91FzCLZj5N7Zgy0a4PJb2
	aHWo8BKtYkZt08uLOSZNj7a40HYrrjCv21+HHd5/j7PE3MxsYxzpgziuwJN+wubXl/ES0ew1MBf
	hVShy+4GVlCg12/1Ml785Kp0b+UE+HoUtsGD1Ep/JavlLOxYYMCGZzqb9Dq4MxIlB7hDLznbEZ+
	s102hOXStwDzS8rgmMmvjbzI6
X-Received: by 2002:a05:6000:2881:b0:429:bc56:cd37 with SMTP id ffacd0b85a97d-42cc1ac9ce9mr3485054f8f.6.1763747149728;
        Fri, 21 Nov 2025 09:45:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpqCYrgceE1yQxRUQgFRs4ztxop0bpE/tG9aVbffduYMdGlSTjfpT7+d4XAocdRAomj/wX/g==
X-Received: by 2002:a05:6000:2881:b0:429:bc56:cd37 with SMTP id ffacd0b85a97d-42cc1ac9ce9mr3485028f8f.6.1763747149258;
        Fri, 21 Nov 2025 09:45:49 -0800 (PST)
Received: from costa-tp.bos2.lab ([2a00:a041:e294:5000:b694:8e49:4f51:966d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7ec454csm11529567f8f.0.2025.11.21.09.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 09:45:48 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 7/8] tools/rtla: Consolidate -P/--priority option parsing
Date: Fri, 21 Nov 2025 19:45:03 +0200
Message-ID: <20251121174504.519230-8-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251121174504.519230-1-costa.shul@redhat.com>
References: <20251121174504.519230-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zyLBIdo4e4ErXWDbX68sUzx6Vds5KE71W-MpyX_4lhQ_1763747150
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Each rtla tool duplicates parsing of -P/--priority.

Migrate the option parsing from individual tools to the
common_parse_options().

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/common.c        | 8 +++++++-
 tools/tracing/rtla/src/osnoise_hist.c  | 9 +--------
 tools/tracing/rtla/src/osnoise_top.c   | 9 +--------
 tools/tracing/rtla/src/timerlat_hist.c | 9 +--------
 tools/tracing/rtla/src/timerlat_top.c  | 9 +--------
 5 files changed, 11 insertions(+), 33 deletions(-)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index 6a1675eba96e..dd67c6b47eaa 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -62,11 +62,12 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
 		{"debug",               no_argument,            0, 'D'},
 		{"duration",            required_argument,      0, 'd'},
 		{"event",               required_argument,      0, 'e'},
+		{"priority",            required_argument,      0, 'P'},
 		{0, 0, 0, 0}
 	};
 
 	opterr = 0;
-	c = getopt_long(argc, argv, "c:C::Dd:e:", long_options, NULL);
+	c = getopt_long(argc, argv, "c:C::Dd:e:P:", long_options, NULL);
 
 	switch (c) {
 	case 'c':
@@ -95,6 +96,11 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
 			tevent->next = common->events;
 		common->events = tevent;
 		break;
+	case 'P':
+		if (parse_prio(optarg, &common->sched_param) == -1)
+			fatal("Invalid -P priority");
+		common->set_sched = 1;
+		break;
 	default:
 		optind = saved_state;
 		return 0;
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index c4013f50e803..6ed5f5594960 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -493,7 +493,6 @@ static struct common_params
 			{"house-keeping",	required_argument,		0, 'H'},
 			{"help",		no_argument,		0, 'h'},
 			{"period",		required_argument,	0, 'p'},
-			{"priority",		required_argument,	0, 'P'},
 			{"runtime",		required_argument,	0, 'r'},
 			{"stop",		required_argument,	0, 's'},
 			{"stop-total",		required_argument,	0, 'S'},
@@ -515,7 +514,7 @@ static struct common_params
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:b:E:hH:p:P:r:s:S:t::T:01234:5:6:7:",
+		c = getopt_long(argc, argv, "a:b:E:hH:p:r:s:S:t::T:01234:5:6:7:",
 				 long_options, NULL);
 
 		/* detect the end of the options. */
@@ -562,12 +561,6 @@ static struct common_params
 			if (params->period > 10000000)
 				fatal("Period longer than 10 s");
 			break;
-		case 'P':
-			retval = parse_prio(optarg, &params->common.sched_param);
-			if (retval == -1)
-				fatal("Invalid -P priority");
-			params->common.set_sched = 1;
-			break;
 		case 'r':
 			params->runtime = get_llong_from_str(optarg);
 			if (params->runtime < 100)
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 846d25ee4885..d2dfad960440 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -348,7 +348,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 			{"house-keeping",	required_argument,	0, 'H'},
 			{"help",		no_argument,		0, 'h'},
 			{"period",		required_argument,	0, 'p'},
-			{"priority",		required_argument,	0, 'P'},
 			{"quiet",		no_argument,		0, 'q'},
 			{"runtime",		required_argument,	0, 'r'},
 			{"stop",		required_argument,	0, 's'},
@@ -367,7 +366,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:hH:p:P:qr:s:S:t::T:0:1:2:3:",
+		c = getopt_long(argc, argv, "a:hH:p:qr:s:S:t::T:0:1:2:3:",
 				 long_options, NULL);
 
 		/* Detect the end of the options. */
@@ -402,12 +401,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 			if (params->period > 10000000)
 				fatal("Period longer than 10 s");
 			break;
-		case 'P':
-			retval = parse_prio(optarg, &params->common.sched_param);
-			if (retval == -1)
-				fatal("Invalid -P priority");
-			params->common.set_sched = 1;
-			break;
 		case 'q':
 			params->common.quiet = 1;
 			break;
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 4744f84a452e..e7ba083b5eb4 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -802,7 +802,6 @@ static struct common_params
 			{"irq",			required_argument,	0, 'i'},
 			{"nano",		no_argument,		0, 'n'},
 			{"period",		required_argument,	0, 'p'},
-			{"priority",		required_argument,	0, 'P'},
 			{"stack",		required_argument,	0, 's'},
 			{"thread",		required_argument,	0, 'T'},
 			{"trace",		optional_argument,	0, 't'},
@@ -831,7 +830,7 @@ static struct common_params
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:b:E:hH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
+		c = getopt_long(argc, argv, "a:b:E:hH:i:knp:s:t::T:uU0123456:7:8:9\1\2:\3:",
 				 long_options, NULL);
 
 		/* detect the end of the options. */
@@ -890,12 +889,6 @@ static struct common_params
 			if (params->timerlat_period_us > 1000000)
 				fatal("Period longer than 1 s");
 			break;
-		case 'P':
-			retval = parse_prio(optarg, &params->common.sched_param);
-			if (retval == -1)
-				fatal("Invalid -P priority");
-			params->common.set_sched = 1;
-			break;
 		case 's':
 			params->print_stack = get_llong_from_str(optarg);
 			break;
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index b77e5b6550a1..8250bea4b2fd 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -570,7 +570,6 @@ static struct common_params
 			{"irq",			required_argument,	0, 'i'},
 			{"nano",		no_argument,		0, 'n'},
 			{"period",		required_argument,	0, 'p'},
-			{"priority",		required_argument,	0, 'P'},
 			{"quiet",		no_argument,		0, 'q'},
 			{"stack",		required_argument,	0, 's'},
 			{"thread",		required_argument,	0, 'T'},
@@ -595,7 +594,7 @@ static struct common_params
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
+		c = getopt_long(argc, argv, "a:hH:i:knp:qs:t::T:uU0:1:2:345:6:7:",
 				 long_options, NULL);
 
 		/* detect the end of the options. */
@@ -656,12 +655,6 @@ static struct common_params
 			if (params->timerlat_period_us > 1000000)
 				fatal("Period longer than 1 s");
 			break;
-		case 'P':
-			retval = parse_prio(optarg, &params->common.sched_param);
-			if (retval == -1)
-				fatal("Invalid -P priority");
-			params->common.set_sched = 1;
-			break;
 		case 'q':
 			params->common.quiet = 1;
 			break;
-- 
2.51.1

