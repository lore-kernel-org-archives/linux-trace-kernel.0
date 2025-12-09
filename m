Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622B332039E
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Dec 2025 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765274501; cv=none; b=AkS8k+p+UotuIlapsb16+PqXbeD7rg9HtAFW/sOZSAIqWo8sQ+Q7im4XuMJaBL8PQpdc2KWFJi2BDyxPOCFulXp+lbBMmAJTpbA7oxChOFZohiIEs2Adno39J9uMqnWHJFE2LVZEHp0qcd0XgXx/sGJtd6qWhIxcSUUWRt5BcGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765274501; c=relaxed/simple;
	bh=ejWTHYAHpCN7TT9hEX+fDp0ncfVn5expsWBW4EZ5cLM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=W0AS2xdHx2ta3ypUzUchXYTz2rhPkpc82JSNb/p/h38bx9kDq0mISCCEe5BRKyqJBgzT4WaFQJN/5D6QAvyIH/Ug6W90UPYwBEY+Sbun0StrauC3tY9GRs0LWUuqwiFcuGsZNAKW88tvXxS2syKtYK8dX1UGWf8LUy5bQRBYFg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hEpas5NN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hEpas5NN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765274498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XopP5omlArBg1COrzW/8PFhgUrp7XUb/fU3Cn1CCkW4=;
	b=hEpas5NNN2fhZW2DabSJ8qMr/1mLr6bzJnNfr3HSbhFy4Tj1yssmfFxCJ4AWGHkJFtv7V9
	fS9QxPgSGWDqUfBUKv5BUT6/toJUMJE1CeVYDwQ15cDmHv8N1yajk+8mTEvUYNjXy7zpeT
	sFQBane/i0LEcwThIZ3AuCcZjniPPhw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-GqbDfc1CMbKDTA3uL55NRA-1; Tue, 09 Dec 2025 05:01:31 -0500
X-MC-Unique: GqbDfc1CMbKDTA3uL55NRA-1
X-Mimecast-MFC-AGG-ID: GqbDfc1CMbKDTA3uL55NRA_1765274490
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4776b0ada3dso29295765e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Dec 2025 02:01:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765274490; x=1765879290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XopP5omlArBg1COrzW/8PFhgUrp7XUb/fU3Cn1CCkW4=;
        b=qfooCrwM3hXwGMuXM+IcFyQvGas+ME/J8cvW3X8+gQOy8y8GGGiuQgWuG6/X33XlBL
         Idc9ehn7OqppNtG4st3isa79sKjAMy1CbxqXzmZ4i8ZX2BivvNj29NzqKRSERSV49/EW
         hDOJlFWHE1UCsYPgj76ciPcG6vCpCUOig3bqoDl23Fk7pMu2+Gj0tqc9Cwp8I5KyxT91
         LyEm3Vyp+QEmGYRON3CpvCfO9lOcS9I3U/c8RpQgoEt6G6qUfmXpBq2WonQA/wAt4ltm
         elxGU8plIEnSMYdcudYQKOLYhxNHYO0ios7u56DSuaUvDrMkBr289Gw+rLZocsWQWxEl
         Mz8g==
X-Forwarded-Encrypted: i=1; AJvYcCUK8XFZb4OfBXQBo0YIIcMFgo4m0wW0BFFl5BXNT+A0Ye6lkqIS4ipggYX0mGwOTsK9U3qMc/2SkCk+yt5wHf7NAdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwonpVl9q3XHappWQiKN+QSSuIZ+aRcf9BJQjcGfLJHuK/OUQFm
	mtptAKoSvkTTcHozdjiuCC7brGvALnVfurvhfWMU4QTDcmVc/ZFOkKhb/elYUr29++KaUP0VAoB
	XRngTMw4U9MQ50NgQNGQDOJLNJsRDwAXmUsM5QG88hVlVJWePAJNetXpswBTISnKFPPnVJ7pfLg
	==
X-Gm-Gg: ASbGncvyx5lbl2RoLXKD9ZoMO+atpo8vy5Ne4s5ZT6m0+e1yIY2UM73LEjMNrfHUQOz
	w15uYFFU91XAMssBk4NycTNDBuCU5Hb54Dx6xHjD2NTqc8flAGgjhKjfJgApcPfGctAesui3Pbi
	ikdLZu0PsIF+sraLNxYZV+0uNWnVb7FTarn+Q12sCJcXbEnB3TTgo+y5X9TIlgmxYgo1A83Z83U
	9iv8N4yjKBJVCERsoH/sla7Z4fnMEM8LvE9+mZt6/ICGIjOycmNPqFWA8iwtTvRhrgBXluLGHLw
	dXG2Nn94nGZy5kIcTa/jK5yMDKMotSjhFDPQLwgEf0qUlYN4OeDp7XEF1Ut5dmBeOw4zWc8w5mW
	Y3JiNY4OW4WZ6KqBmMnGnJLkZ620=
X-Received: by 2002:a05:600c:b93:b0:46e:2815:8568 with SMTP id 5b1f17b1804b1-47a7fa3461cmr9671735e9.10.1765274489957;
        Tue, 09 Dec 2025 02:01:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdL0aWJq9Na/i5QVM915r1BIfJqSUNYkKkn1qJXEWt/d8zebY4kBFqkVmi6b96uD3/6jdtDw==
X-Received: by 2002:a05:600c:b93:b0:46e:2815:8568 with SMTP id 5b1f17b1804b1-47a7fa3461cmr9671325e9.10.1765274489430;
        Tue, 09 Dec 2025 02:01:29 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e294:5000:b694:8e49:4f51:966d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d612e49sm33620855e9.3.2025.12.09.02.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 02:01:28 -0800 (PST)
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
Subject: [PATCH v2 8/8] tools/rtla: Consolidate -H/--house-keeping option parsing
Date: Tue,  9 Dec 2025 12:00:47 +0200
Message-ID: <20251209100047.2692515-8-costa.shul@redhat.com>
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
X-Mimecast-MFC-PROC-ID: mMR4zCKLaoTxp1wozAA6yuItBHJy8vQy33HiKqS84OE_1765274490
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
index e042b2d9dbf5..8e90bb4a76f9 100644
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
 	opterr = 1;
 
 	switch (c) {
@@ -97,6 +98,11 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
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
2.52.0

