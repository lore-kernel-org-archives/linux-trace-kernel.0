Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFF4350A1D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 17:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763747157; cv=none; b=RWtwuSvvhCwEqkCdezSd4NcmBI6jbxCFtXwzyOQPOk5dHCFhp2ecs6TRCsoApxepVzoCtMurvW5rEbZdvKXpmKTvcSYU0PWWeMSo9Ggn9W5WxcRwNlMGKhwA46RnsWu0DR802b4+kLUGATuOwvB5xrkNDOw0DeqRHyHYzcC6GXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763747157; c=relaxed/simple;
	bh=D1AdlKWho2by+4CzgvcoFl74FcN82SAXeg9cfxfzFB8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Zc119M/SxORb7OFIyTp67EUVLe1K2soWeov+uqp0zH0WCt7jQu5UJKMHChOYqzquSn5h8rpskhBLG8k+LGGpBpxisuH2ZFOSZYTT7NTb3psB3YNzrBXbTgaUphFi9nE8maVsz2hd2Q3OFw06aEaKMN9D/AXxrRziVc8ThgF8NIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X2l9KnWd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2l9KnWd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763747154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4isV2YzTCHizoKjzYDGn0aeaubcmK1LCw5702FwMQNE=;
	b=X2l9KnWdydPVr8W8H2cJU22zQfWIZU2GQRp/avdWEUHX8WIXH43dw+k1wcbeFznjWuzgJB
	F7scuKlGrOdDav3WcLpLiuILVQV/M6KH1di2Lt8kGS999mfdmD4fVuxFquBLxcdl5OGkck
	1nSLFfaXXoFWgo4IbpXR3/cZHmCeGcQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-cHv7cK4JPOyNSE-dfDIfIw-1; Fri, 21 Nov 2025 12:45:53 -0500
X-MC-Unique: cHv7cK4JPOyNSE-dfDIfIw-1
X-Mimecast-MFC-AGG-ID: cHv7cK4JPOyNSE-dfDIfIw_1763747152
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-429c5da68e5so1401680f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 09:45:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763747152; x=1764351952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4isV2YzTCHizoKjzYDGn0aeaubcmK1LCw5702FwMQNE=;
        b=fln7plaiBTEoZNaoObkfJuG1i/x05iUwCjKJdUvEttep2s70fkV+meu6TEwBFLhesN
         zc/6IquiLHdo6IIkwmPCPUNMThvQ0Ea2D6EVeJk4AjOGF5o38bzgdp6PaBfrlZILSbrL
         i0QirRxAuDYnaZsTQxx+GPjJ0gC6dHQTtpBWYOQD2/0FRpiPtQU2zBS1EgY1y17ECjiY
         MULglVGgTG2aGDZj3D+KkyOA9GQuhayEvwaajjq/bx+0b8KTB3iQtN+D8rfqHzRzAzNy
         yEMx/ByHfOMddlhSPaHwKQLpHhRb0e9DXZI8X44/s6Zh0JRIIvAA9ItOGtrCj0MHiO3q
         HZmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+3P4q8sVhnNj1wS4wtAedN7B5Gv/3WQblyyXPgZ7pFgBCkEn7KMKl9EatCR/JE2n23nebLOY43f99ESUrYLEcJhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf0p9Z3GuJizG09qW4X9CuZJ0tGItLdVud/f8ciTz69kycUxXG
	8fETEmLH6c55uzVk59vYq4A3E+JECv+avsbnMav1scYP97atTwMrDiT+GU/YtCjx3NWFcyB07Bo
	nAUW3FxjxjAXOonHTl6JgfxvT0t7bhRw1xy64UO+1ZWR/fQw4BX7N9zMZQW+YsAwdraw1l49LcA
	==
X-Gm-Gg: ASbGncvXGHhKpz9hr61ZYaSK/5Kg/ECvxw4MTMRZgXboPE90nRAZnhdxa0c9kUkXhus
	Gtrc5aZyWb35B7KNNS7nagoJPNwJpTFzMjBawEbH25Tw70shkLEG82evFXQKg25qgCsWzAqT07m
	ubY7LVHNw1gb23+hFLLdljIGkRGB340LNiGU989y/G0E3qK8WDaQUYZoERdPvLQFHhv8ARnO9A8
	R3WNSGmi7GD80lyGQXv1fVnkVrNKGWHL88UJypm/+Q9Px+S4QGv1Vp+B0w1y9KNDPmDVDLLcf4K
	ZRB3Txi3Wf+zzlG8cDus8Rv03GqFAsydLrDyIuDEGsIojdPY5Cjv+qMmHM1VQXQNgeF5RLoatUd
	jR8/0T+gU5ddwB4R/xnAuXvfN
X-Received: by 2002:a5d:5f54:0:b0:42b:3108:5671 with SMTP id ffacd0b85a97d-42cba7c4d96mr8095365f8f.29.1763747151991;
        Fri, 21 Nov 2025 09:45:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEM8NKpwRcn40VnEReWwYMQNvRZKJQwoTcUDLfVIQM9E7znbRvegTyP8bUUSuZwUOgLpRPQYw==
X-Received: by 2002:a5d:5f54:0:b0:42b:3108:5671 with SMTP id ffacd0b85a97d-42cba7c4d96mr8095340f8f.29.1763747151498;
        Fri, 21 Nov 2025 09:45:51 -0800 (PST)
Received: from costa-tp.bos2.lab ([2a00:a041:e294:5000:b694:8e49:4f51:966d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7ec454csm11529567f8f.0.2025.11.21.09.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 09:45:51 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 8/8] tools/rtla: Consolidate -H/--house-keeping option parsing
Date: Fri, 21 Nov 2025 19:45:04 +0200
Message-ID: <20251121174504.519230-9-costa.shul@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 7Djo10YvL6UPmYvZ4GH9N5nMZmdQQTBHOJ2slZ_6F0o_1763747152
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Each rtla tool duplicates parsing of -H/--house-keeping.

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
index dd67c6b47eaa..9d047a64146b 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -62,12 +62,13 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
 		{"debug",               no_argument,            0, 'D'},
 		{"duration",            required_argument,      0, 'd'},
 		{"event",               required_argument,      0, 'e'},
+		{"house-keeping",       required_argument,      0, 'H'},
 		{"priority",            required_argument,      0, 'P'},
 		{0, 0, 0, 0}
 	};
 
 	opterr = 0;
-	c = getopt_long(argc, argv, "c:C::Dd:e:P:", long_options, NULL);
+	c = getopt_long(argc, argv, "c:C::Dd:e:H:P:", long_options, NULL);
 
 	switch (c) {
 	case 'c':
@@ -96,6 +97,11 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
 			tevent->next = common->events;
 		common->events = tevent;
 		break;
+	case 'H':
+		common->hk_cpus = 1;
+		if (parse_cpu_set(optarg, &common->hk_cpu_set))
+			fatal("Error parsing house keeping CPUs");
+		break;
 	case 'P':
 		if (parse_prio(optarg, &common->sched_param) == -1)
 			fatal("Invalid -P priority");
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 6ed5f5594960..1ebd3b48b2d3 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -490,7 +490,6 @@ static struct common_params
 			{"auto",		required_argument,	0, 'a'},
 			{"bucket-size",		required_argument,	0, 'b'},
 			{"entries",		required_argument,	0, 'E'},
-			{"house-keeping",	required_argument,		0, 'H'},
 			{"help",		no_argument,		0, 'h'},
 			{"period",		required_argument,	0, 'p'},
 			{"runtime",		required_argument,	0, 'r'},
@@ -514,7 +513,7 @@ static struct common_params
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:b:E:hH:p:r:s:S:t::T:01234:5:6:7:",
+		c = getopt_long(argc, argv, "a:b:E:hp:r:s:S:t::T:01234:5:6:7:",
 				 long_options, NULL);
 
 		/* detect the end of the options. */
@@ -550,12 +549,6 @@ static struct common_params
 		case '?':
 			osnoise_hist_usage();
 			break;
-		case 'H':
-			params->common.hk_cpus = 1;
-			retval = parse_cpu_set(optarg, &params->common.hk_cpu_set);
-			if (retval)
-				fatal("Error parsing house keeping CPUs");
-			break;
 		case 'p':
 			params->period = get_llong_from_str(optarg);
 			if (params->period > 10000000)
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index d2dfad960440..02e5e6e18e8d 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -345,7 +345,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 	while (1) {
 		static struct option long_options[] = {
 			{"auto",		required_argument,	0, 'a'},
-			{"house-keeping",	required_argument,	0, 'H'},
 			{"help",		no_argument,		0, 'h'},
 			{"period",		required_argument,	0, 'p'},
 			{"quiet",		no_argument,		0, 'q'},
@@ -366,7 +365,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:hH:p:qr:s:S:t::T:0:1:2:3:",
+		c = getopt_long(argc, argv, "a:hp:qr:s:S:t::T:0:1:2:3:",
 				 long_options, NULL);
 
 		/* Detect the end of the options. */
@@ -390,12 +389,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		case '?':
 			osnoise_top_usage(params);
 			break;
-		case 'H':
-			params->common.hk_cpus = 1;
-			retval = parse_cpu_set(optarg, &params->common.hk_cpu_set);
-			if (retval)
-				fatal("Error parsing house keeping CPUs");
-			break;
 		case 'p':
 			params->period = get_llong_from_str(optarg);
 			if (params->period > 10000000)
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index e7ba083b5eb4..d1a6cf0c2e0d 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -797,7 +797,6 @@ static struct common_params
 			{"auto",		required_argument,	0, 'a'},
 			{"bucket-size",		required_argument,	0, 'b'},
 			{"entries",		required_argument,	0, 'E'},
-			{"house-keeping",	required_argument,	0, 'H'},
 			{"help",		no_argument,		0, 'h'},
 			{"irq",			required_argument,	0, 'i'},
 			{"nano",		no_argument,		0, 'n'},
@@ -830,7 +829,7 @@ static struct common_params
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:b:E:hH:i:knp:s:t::T:uU0123456:7:8:9\1\2:\3:",
+		c = getopt_long(argc, argv, "a:b:E:hi:knp:s:t::T:uU0123456:7:8:9\1\2:\3:",
 				 long_options, NULL);
 
 		/* detect the end of the options. */
@@ -869,12 +868,6 @@ static struct common_params
 		case '?':
 			timerlat_hist_usage();
 			break;
-		case 'H':
-			params->common.hk_cpus = 1;
-			retval = parse_cpu_set(optarg, &params->common.hk_cpu_set);
-			if (retval)
-				fatal("Error parsing house keeping CPUs");
-			break;
 		case 'i':
 			params->common.stop_us = get_llong_from_str(optarg);
 			break;
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 8250bea4b2fd..12e3d8c6f850 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -566,7 +566,6 @@ static struct common_params
 		static struct option long_options[] = {
 			{"auto",		required_argument,	0, 'a'},
 			{"help",		no_argument,		0, 'h'},
-			{"house-keeping",	required_argument,	0, 'H'},
 			{"irq",			required_argument,	0, 'i'},
 			{"nano",		no_argument,		0, 'n'},
 			{"period",		required_argument,	0, 'p'},
@@ -594,7 +593,7 @@ static struct common_params
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:hH:i:knp:qs:t::T:uU0:1:2:345:6:7:",
+		c = getopt_long(argc, argv, "a:hi:knp:qs:t::T:uU0:1:2:345:6:7:",
 				 long_options, NULL);
 
 		/* detect the end of the options. */
@@ -635,12 +634,6 @@ static struct common_params
 		case '?':
 			timerlat_top_usage();
 			break;
-		case 'H':
-			params->common.hk_cpus = 1;
-			retval = parse_cpu_set(optarg, &params->common.hk_cpu_set);
-			if (retval)
-				fatal("Error parsing house keeping CPUs");
-			break;
 		case 'i':
 			params->common.stop_us = get_llong_from_str(optarg);
 			break;
-- 
2.51.1

