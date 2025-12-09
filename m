Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1272E2FD7D3
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Dec 2025 10:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765274495; cv=none; b=AtB8h7CGsK9XV0BmEO6Ek/9EMq/efCnjPupzeS1JQVI7FenPjWAhx6Lb6a+PtyxxMw/Ckxt65rIG5A6TIZ3XkLOWZKY7vBxzIcvFNubn0JerjRnGVCaP29fdWjZsgClAV2V/dr9cC1tbCJI2XdCL2QZg65Uo4c/abpggiyBQaSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765274495; c=relaxed/simple;
	bh=JLKgHehEeINl2fS+BzZCk0HjwnNW3HaDSTcC2IEcqW8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=IsPxxNpr0ftWU2AQHP/GBMDFAmy/guo0YHMNzCXX00lJVQ8UZL0f0g3jgKy0y8edY30GuGZCq1phDmneyCseSixH3vuHVU8roQkFsQ2fiLdQJqYbGOUQb/ch6rcw7pzdxxcC0A6py9Ti6kpoAYnWxN9FOOI421IjQQT69JP2hlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NXwasz/M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXwasz/M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765274493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kIv++FpwQ8cJlrOo8A+9VRWshKcIwit2Bm/NrhT0O0E=;
	b=NXwasz/M4c7LoZvk96fFFXe1nsOogyUxAYv6fAXX3Lo2978OK093mUCkSKq2a0qD3qo/cX
	LYpuvy2DEgwMQQ8c18TmSTeY7xJPH0G4xr9ZjifKCDhXsZYFpqybU8/NrQSNlkSj0WeHUG
	bHe/RXCdO+TZ6cW44b873dc0BReIs1U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-SnphJ1_CMDurpaCwTFeMAQ-1; Tue, 09 Dec 2025 05:01:30 -0500
X-MC-Unique: SnphJ1_CMDurpaCwTFeMAQ-1
X-Mimecast-MFC-AGG-ID: SnphJ1_CMDurpaCwTFeMAQ_1765274489
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47777158a85so66636535e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Dec 2025 02:01:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765274489; x=1765879289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kIv++FpwQ8cJlrOo8A+9VRWshKcIwit2Bm/NrhT0O0E=;
        b=gD5yd+gD78Bf5D2esTmb8GpP0dFfqdrRy/jn5ykVyfyrWW7idD4tHMNxifqQ/9C4NY
         HAJNUFmUlHSOlV6kjLP0A5yFgiCv2b42p59a0x7qChN+V9gwtKljSOmMiVABVUKI1pX4
         XHYNmVHvZXgwmmLfOWU+Dc9I6TitRlvf2Feib1shQ8yDW7MeJxFyVkBqtWLYpcdJH557
         fF/Gwva1ptKlMBWs4a6//QNowrm5ubC3Ong30O71YGv4And4ri4lKWolJrObBTplu6O6
         G1IP7RHKbkekuB7uICDbLjiwEf/EzVWDrz8jL10Osz/QEnBVpNOjJHhAF1vpHaNRvzZ4
         zrrw==
X-Forwarded-Encrypted: i=1; AJvYcCV9lOt5Gefy9cqRQxXAe/MHc3O+f1K/bG+rb5DISTyPwbFIh+CaqZnoy8ru5A6FEjYdRMzPo/6u9IrQJHnRTonNG+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSUzDqfWhqDEugC+l8ayMUANr4WWqTlr7pXrzCjlSCgydBmCvW
	DZaA81CEgUXnerzROoxk733QQGJhowZoCR61f4XpunT+RNu8B+E31XonMV4TT/flXfTmXIH2Da0
	Ama1bsaj99SWun56XRASHzVogMMPYyB5XZ5vKobtLH9DZWoysdG3HcprLrGpvy2uioXOnVPhrzA
	==
X-Gm-Gg: ASbGncuJvITyc64wQmMxzl2q9JWi9GWa9Wc69d2K58VAbTRh3gQFw0lkuttHh2V5Wrt
	76g29D1/mtqJ99pNPHV8KHWorZqsKiGEHQ7R24LHQI7xmNRzKtUyo4yNpnfE3hlbROHlA5zXWx3
	0uqbQvCapajhqedZnJiWTEuSaWuuIqANN87tw5QuF2jEBh4W4FRBxeKl7vwqvUkSSNRUM/5J4G/
	vLwPZLYj1kbhIBWT3ljQoEmJhz26XxnV36Lu4V3aFWrvHwRqPOJuGv6yY+lMl4jhaJCuwhPdvtV
	NZuWSuLGursIQ6m6gtoJRwu4wJgrDLFqhLaJ0XlN9GYaYPvVXs6dX1Z7efr0g5wFGNRgKzPRxE2
	/PI0Wg1a0jjVUdHooi4IujB/To7Q=
X-Received: by 2002:a05:600c:4f54:b0:477:b642:9dbf with SMTP id 5b1f17b1804b1-47939e48e88mr90871035e9.32.1765274488360;
        Tue, 09 Dec 2025 02:01:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHea2Gfp1CUlrY7K6Xr1ASJKjeyHdKR9s8EfgoVAgj8HKYsqSpBqHwLntE+sqO2vKTAoAwX/w==
X-Received: by 2002:a05:600c:4f54:b0:477:b642:9dbf with SMTP id 5b1f17b1804b1-47939e48e88mr90870625e9.32.1765274487884;
        Tue, 09 Dec 2025 02:01:27 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e294:5000:b694:8e49:4f51:966d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d612e49sm33620855e9.3.2025.12.09.02.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 02:01:27 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] tools/rtla: Consolidate -P/--priority option parsing
Date: Tue,  9 Dec 2025 12:00:46 +0200
Message-ID: <20251209100047.2692515-7-costa.shul@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251209100047.2692515-1-costa.shul@redhat.com>
References: <20251209100047.2692515-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: svzGcK7ffZgt8wirET1gbmUbkY9mPv6tOSUm6onQNpk_1765274489
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
index 684ff49f0a4c..e042b2d9dbf5 100644
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
 	opterr = 1;
 
 	switch (c) {
@@ -96,6 +97,11 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
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
2.52.0

