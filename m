Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2E72FD7D3
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Dec 2025 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765274492; cv=none; b=YsEMsTto2Kh1H+AopqFiXCMDMq9TKKh+WWqroOsCf55QGM931F4aok2mZInuBOyKyswoedI4gIQQlANrnlU4gP1QDY/bgBl2DseFZ+oyeusmtGZjYXwOG3qIKvIAQXjs8SHpAWD6x4DC4O4TBptD6MT5V73yh9sD4JHn8f/m7Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765274492; c=relaxed/simple;
	bh=dm0ZlFpxDwU7c+FTLD53dLRBwHWG8bE8IWqPhbPaG1E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Gk+FvQtm4dWmGPZszyKkc62E3NwmkywXduiAhIDwll+Ko43Kc++CeYtWsqwTUIDNUUJp+4pVrxoKug1iokFhlxdKzGfUSFg7KZmExNbRLeawNsISe8TBjseIOujnaNZwkMpW/KpqnJnQEdX1UXnLd6m/BJqKQhTBrqF4NdbM/jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y1DP+iof; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1DP+iof"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765274489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zfP+HrsH3y+qCw5H1LJjLG4tJHfmzN00JdjGpieJZ0E=;
	b=Y1DP+iofX1knJdV0wypmQ1B4haellae0ZDEV8IlRupTTlgYjB8Z/PsxPbf0ec8lBmQxNxv
	eJ7fi17WB0zpSbw8M5jmKVCz6SEPjnQOdc8aoiqaV/C5kkPl2H+7idLb8tSQErq7HYIt71
	bhadlEjApxNThoNpKuu6I2kmSiRGJrw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-Wc4T5Iz7McGoRQ4Nz3Kz9Q-1; Tue, 09 Dec 2025 05:01:28 -0500
X-MC-Unique: Wc4T5Iz7McGoRQ4Nz3Kz9Q-1
X-Mimecast-MFC-AGG-ID: Wc4T5Iz7McGoRQ4Nz3Kz9Q_1765274487
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4776b0ada3dso29295425e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Dec 2025 02:01:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765274487; x=1765879287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zfP+HrsH3y+qCw5H1LJjLG4tJHfmzN00JdjGpieJZ0E=;
        b=dwyt+dhwLIqeG5N48pimiaQk+84tJ7Xp4eX5edUNda9y+lqvy0LMGcRuVZ3rc9LEe9
         3qgOCY8+VnWaiZR7CQ778MEzAKvmqjj1f7cV8SnJrsvVUlqPJn5Q3wZvGYFJOuWBBM5g
         NfBJbTURIcHUgnZMneI5+GuG0TjRLWM8HTkt2gbTJz04HtPqHLEeIrm49yn3nV4J0rQd
         nNyDtdADSrDOcc1cfo0pi6m77xOrdjSoKwEeP42JqZHl4PqU1/hvLGovEgGoLzJLIAlw
         0eZ7PPVN0XJP3XQGzTiA/sLLRqdn8UI5xOZQ1O3ZjGHr4uaVn0Kf5ZQzRt/Guonj+MZg
         I4wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnXCrInXxQ38RoO0KuOdjeG5nBONeCsNPvFDMdoKEbZvakMBKVfaArs8qNfCJP8FPEUwiI4kO14bzbA496REX72Os=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI7/pYPfY1cywxAgtftkWdZv8NPEZPryGBHwsQodakWkwMmhWs
	EvqXEVk7ohXNWZKeQMfl2Q/oR8X+3IWVHHTeZOykD9jf9rbsqXENfInxza/TV21WVsv0QZ5dXkM
	riHRQYzHhe8Ua3ILdr3X2igtnq/bxX33TWy9gg+dKboL+hn+Gxhzo7UJzn1EU5lBQrcEvo5TXen
	i8T0TgFK+G
X-Gm-Gg: ASbGnctuRaO/bXtWMQ3HMyPfwHFiWBb2jT7osKhs6N+J/VnAnWX7zi/qrIHmHbqg1E7
	VN08e/gRsju18PR18pXx2ZJ+mUehoNj5Zr5DJ8yK6fY7d8UHbE2+eXE7+S41Icr8L8NdpFKsPqP
	8CDu9a7BYkYuEvdpJBefoVMCAG8ovSWJBn0FbO7SFUEV6fjxEjS4RCH66ExMUYdZtMxncOyQqYh
	jzNlJ9SeSObdhLdhhOiZJzKno88ZFz44K7UF63mIQKL0+2BE5ZN0xvWTWdIEUZ5z9Go0SMHXP0f
	3gpbGzWfSN/c0GWlC2MoaeIanaerDnEW/kGdN3gL1ocMc9d6a11y5uks46pvz4v7aaMTrc9tUkn
	bNEDLvi5oyehe4gDWoUG4HLXqnG4=
X-Received: by 2002:a05:600c:3b07:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-47a7fa4abadmr11829025e9.13.1765274486746;
        Tue, 09 Dec 2025 02:01:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFU0ebiuV6AMD/lDxKit3ZET/4bnX0Ls/5jM4mJ/ZtGis6YzCS9Ix4zf/63SJY/PpWObL8gmA==
X-Received: by 2002:a05:600c:3b07:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-47a7fa4abadmr11828535e9.13.1765274486226;
        Tue, 09 Dec 2025 02:01:26 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e294:5000:b694:8e49:4f51:966d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d612e49sm33620855e9.3.2025.12.09.02.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 02:01:25 -0800 (PST)
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
Subject: [PATCH v2 6/8] tools/rtla: Consolidate -e/--event option parsing
Date: Tue,  9 Dec 2025 12:00:45 +0200
Message-ID: <20251209100047.2692515-6-costa.shul@redhat.com>
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
X-Mimecast-MFC-PROC-ID: E3lnkpzVuSRdFnT9m4dnsI8aJCfuJFz_8iaA4rMYZU4_1765274487
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Each rtla tool duplicates parsing of -e/--event.

Migrate the option parsing from individual tools to the
common_parse_options().

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/common.c        | 13 ++++++++++++-
 tools/tracing/rtla/src/osnoise_hist.c  | 14 +-------------
 tools/tracing/rtla/src/osnoise_top.c   | 14 +-------------
 tools/tracing/rtla/src/timerlat_hist.c | 14 +-------------
 tools/tracing/rtla/src/timerlat_top.c  | 13 +------------
 5 files changed, 16 insertions(+), 52 deletions(-)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index e6ff011d2cd2..684ff49f0a4c 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -52,6 +52,7 @@ static void set_signals(struct common_params *params)
  */
 int common_parse_options(int argc, char **argv, struct common_params *common)
 {
+	struct trace_events *tevent;
 	int saved_state = optind;
 	int c;
 
@@ -60,11 +61,12 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
 		{"cgroup",              optional_argument,      0, 'C'},
 		{"debug",               no_argument,            0, 'D'},
 		{"duration",            required_argument,      0, 'd'},
+		{"event",               required_argument,      0, 'e'},
 		{0, 0, 0, 0}
 	};
 
 	opterr = 0;
-	c = getopt_long(argc, argv, "c:C::Dd:", long_options, NULL);
+	c = getopt_long(argc, argv, "c:C::Dd:e:", long_options, NULL);
 	opterr = 1;
 
 	switch (c) {
@@ -85,6 +87,15 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
 		if (!common->duration)
 			fatal("Invalid -d duration");
 		break;
+	case 'e':
+		tevent = trace_event_alloc(optarg);
+		if (!tevent)
+			fatal("Error alloc trace event");
+
+		if (common->events)
+			tevent->next = common->events;
+		common->events = tevent;
+		break;
 	default:
 		optind = saved_state;
 		return 0;
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 1b79bfefc214..c4013f50e803 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -469,7 +469,6 @@ static struct common_params
 *osnoise_hist_parse_args(int argc, char *argv[])
 {
 	struct osnoise_params *params;
-	struct trace_events *tevent;
 	int retval;
 	int c;
 	char *trace_output = NULL;
@@ -499,7 +498,6 @@ static struct common_params
 			{"stop",		required_argument,	0, 's'},
 			{"stop-total",		required_argument,	0, 'S'},
 			{"trace",		optional_argument,	0, 't'},
-			{"event",		required_argument,	0, 'e'},
 			{"threshold",		required_argument,	0, 'T'},
 			{"no-header",		no_argument,		0, '0'},
 			{"no-summary",		no_argument,		0, '1'},
@@ -517,7 +515,7 @@ static struct common_params
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:b:e:E:hH:p:P:r:s:S:t::T:01234:5:6:7:",
+		c = getopt_long(argc, argv, "a:b:E:hH:p:P:r:s:S:t::T:01234:5:6:7:",
 				 long_options, NULL);
 
 		/* detect the end of the options. */
@@ -543,16 +541,6 @@ static struct common_params
 			    params->common.hist.bucket_size >= 1000000)
 				fatal("Bucket size needs to be > 0 and <= 1000000");
 			break;
-		case 'e':
-			tevent = trace_event_alloc(optarg);
-			if (!tevent)
-				fatal("Error alloc trace event");
-
-			if (params->common.events)
-				tevent->next = params->common.events;
-
-			params->common.events = tevent;
-			break;
 		case 'E':
 			params->common.hist.entries = get_llong_from_str(optarg);
 			if (params->common.hist.entries < 10 ||
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 619c5bcf8f35..846d25ee4885 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -322,7 +322,6 @@ static void osnoise_top_usage(struct osnoise_params *params)
 struct common_params *osnoise_top_parse_args(int argc, char **argv)
 {
 	struct osnoise_params *params;
-	struct trace_events *tevent;
 	int retval;
 	int c;
 	char *trace_output = NULL;
@@ -346,7 +345,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 	while (1) {
 		static struct option long_options[] = {
 			{"auto",		required_argument,	0, 'a'},
-			{"event",		required_argument,	0, 'e'},
 			{"house-keeping",	required_argument,	0, 'H'},
 			{"help",		no_argument,		0, 'h'},
 			{"period",		required_argument,	0, 'p'},
@@ -369,7 +367,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:e:hH:p:P:qr:s:S:t::T:0:1:2:3:",
+		c = getopt_long(argc, argv, "a:hH:p:P:qr:s:S:t::T:0:1:2:3:",
 				 long_options, NULL);
 
 		/* Detect the end of the options. */
@@ -388,16 +386,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 			if (!trace_output)
 				trace_output = "osnoise_trace.txt";
 
-			break;
-		case 'e':
-			tevent = trace_event_alloc(optarg);
-			if (!tevent)
-				fatal("Error alloc trace event");
-
-			if (params->common.events)
-				tevent->next = params->common.events;
-			params->common.events = tevent;
-
 			break;
 		case 'h':
 		case '?':
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 0a7e5dcce121..4744f84a452e 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -766,7 +766,6 @@ static struct common_params
 *timerlat_hist_parse_args(int argc, char *argv[])
 {
 	struct timerlat_params *params;
-	struct trace_events *tevent;
 	int auto_thresh;
 	int retval;
 	int c;
@@ -810,7 +809,6 @@ static struct common_params
 			{"user-threads",	no_argument,		0, 'u'},
 			{"kernel-threads",	no_argument,		0, 'k'},
 			{"user-load",		no_argument,		0, 'U'},
-			{"event",		required_argument,	0, 'e'},
 			{"no-irq",		no_argument,		0, '0'},
 			{"no-thread",		no_argument,		0, '1'},
 			{"no-header",		no_argument,		0, '2'},
@@ -833,7 +831,7 @@ static struct common_params
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:b:e:E:hH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
+		c = getopt_long(argc, argv, "a:b:E:hH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
 				 long_options, NULL);
 
 		/* detect the end of the options. */
@@ -862,16 +860,6 @@ static struct common_params
 			    params->common.hist.bucket_size >= 1000000)
 				fatal("Bucket size needs to be > 0 and <= 1000000");
 			break;
-		case 'e':
-			tevent = trace_event_alloc(optarg);
-			if (!tevent)
-				fatal("Error alloc trace event");
-
-			if (params->common.events)
-				tevent->next = params->common.events;
-
-			params->common.events = tevent;
-			break;
 		case 'E':
 			params->common.hist.entries = get_llong_from_str(optarg);
 			if (params->common.hist.entries < 10 ||
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 4340fbf3f879..b77e5b6550a1 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -538,7 +538,6 @@ static struct common_params
 *timerlat_top_parse_args(int argc, char **argv)
 {
 	struct timerlat_params *params;
-	struct trace_events *tevent;
 	long long auto_thresh;
 	int retval;
 	int c;
@@ -566,7 +565,6 @@ static struct common_params
 	while (1) {
 		static struct option long_options[] = {
 			{"auto",		required_argument,	0, 'a'},
-			{"event",		required_argument,	0, 'e'},
 			{"help",		no_argument,		0, 'h'},
 			{"house-keeping",	required_argument,	0, 'H'},
 			{"irq",			required_argument,	0, 'i'},
@@ -597,7 +595,7 @@ static struct common_params
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:e:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
+		c = getopt_long(argc, argv, "a:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
 				 long_options, NULL);
 
 		/* detect the end of the options. */
@@ -634,15 +632,6 @@ static struct common_params
 			/* set aa_only to avoid parsing the trace */
 			params->common.aa_only = 1;
 			break;
-		case 'e':
-			tevent = trace_event_alloc(optarg);
-			if (!tevent)
-				fatal("Error alloc trace event");
-
-			if (params->common.events)
-				tevent->next = params->common.events;
-			params->common.events = tevent;
-			break;
 		case 'h':
 		case '?':
 			timerlat_top_usage();
-- 
2.52.0

