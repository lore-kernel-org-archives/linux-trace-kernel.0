Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70DD350D51
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763747151; cv=none; b=o1DS3X+yk31XD/fJsCArx3/VDbs+m7oVOWR3b2lJwsu2TXC6dbl1jvTtOKoxIqqPUB2WJUSJs3wyh+sbZswmh5J5FRUs6PU65NSAOakoaQBFtGwj7HDdmTn+b18xHzQVSGwgNn2ATzT8Dp1g+CJr9jsmNo/gqsk/2ggMU8iDev0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763747151; c=relaxed/simple;
	bh=U5DeGnZekR8rISaant6f6+HTTp8Iy1SCbciThbchxaM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=UfPnJgUpHGzb8DfSyDtF09iL69iSkHGSwyUAj4tIJSbzeR/WVHuVLUSSdZJ50LclIXlbthX14j9NU9uy9DNB6FKsL8G/F2XKIMlM8xBnnvtkSUNOjkhBeM8hWvi76it1MLpNBlwWnqcut/XxXVBv2Ue0Aok5Cj96cFWA3Kmr+n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SVpZqhzG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVpZqhzG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763747148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=601u8cTJOpTNQMx+d0xy6jF7wJaJPINuIXmBn9DqsBA=;
	b=SVpZqhzGGnmNpCbztuwl/W/neoE1iYkiUA3Mrkq+HtGcXxPHkjCjRKM9RIoiOn0w27IqlR
	2MA7OaBo/0qqsi82Y3ntThRb/eWQpQKKMur+BvS2FJHd1ZRU7srHaD36SRuShSPGZjOClv
	o/T14J34zdSP6OehScYCanTSnFCLLnU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-RjxKJTXSOnS2eABXHQEQug-1; Fri, 21 Nov 2025 12:45:47 -0500
X-MC-Unique: RjxKJTXSOnS2eABXHQEQug-1
X-Mimecast-MFC-AGG-ID: RjxKJTXSOnS2eABXHQEQug_1763747146
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b3155274eso1140155f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 09:45:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763747146; x=1764351946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=601u8cTJOpTNQMx+d0xy6jF7wJaJPINuIXmBn9DqsBA=;
        b=mDf2d1ZCkBLzrWf8fh+uaGG6CKT81LI2fF0aTlvT/yMCHyzTxGZVG41YAJcmd3DNJE
         BNyg0e420cs6XXdbPD314LY4KTn0k7JDrQsWGmKNskLrRd673sP/fF/kgfHT17XDO2nl
         zmSEyKGcRc0lfWAWA2k5z8IvaHpbTLTjfPX5ZAIxaR+1NvXkFUFtnTcOuNLi8WMZB5xV
         8jgBndYPiSCK/5L2p0943DmyHs8l2mbmS7i1++7k3XO48b+uRuTlBwNXerJprhw/yI2I
         rMoHlJo3/KN/+w21jk73Y/hVzjefTEKv+Vt/dpNtxarbFaq/ih8WUgudThOPtZEs90eJ
         wDRA==
X-Forwarded-Encrypted: i=1; AJvYcCXoQiqDa+2sx+S1i/cV0X05VBwg6smdP1ihOl+VGtMWm5KPVZfdaPYEdoZB2gbH9kwxCFiscL3MCS2I6V8VGS9+TTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqj/KYFTGEOtZ22076yMyVSq2rQXj1wGTaTfti2Db2hQE5EG27
	z2RoXAg0c0IP/s7MkRvYDeb/A0mX2xSntias0J0whr5zDUK+qCav0knERUIVm5oqN5kppkayJXW
	nEtUD8tYmOGbIGUrbVXyVDEEgsjn1eLRPcnUoqI8p0lUbfbTG0o9eSNpcnzEJ5Q2HwqtVFvE5PA
	==
X-Gm-Gg: ASbGncsdgNL13fqnZi9nYHFRz2buFzgCaSAX5miyH4k84crbu4rMyYsM7b0BEDtgkxX
	vgllkTHU2dtFeuilp8NRge/S5zMSPXKEGlQaMeI8L6hgavrDdRnfu1RHh84LKDuq6LP4wR3zjNh
	8p5pDZpxz3bUiQkSbdyWj0Zf3bjWh6G/kiIQ9cWtWxJV8E5+pBquLNUbV8/4868zTZCLmJ9/5eB
	LHrj9p1q2oyyFn9jiCzTYJlcTUX0zINyyNw+aSx+5s17gcjqipyrrEvfMifIzrslJZmt8WS9Fwo
	sHp4FUQnzugFQChENapnKW3iZz/nYvn3FY1gp83pAbYWRVn1NRmu3ovy9g33SuJRGirJl6Wb6ty
	9vpA6lVntywnkw5/YTi4jIugL
X-Received: by 2002:a5d:5d02:0:b0:42b:3339:c7ff with SMTP id ffacd0b85a97d-42cc1d19a16mr3698684f8f.43.1763747146280;
        Fri, 21 Nov 2025 09:45:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8kZ/PfttCKjmF1hEvfyYQbUXFlJLAEN1wlOmdYkHKzzjvrHLPwsh+1ZWK5l8V1ImULMCiQQ==
X-Received: by 2002:a5d:5d02:0:b0:42b:3339:c7ff with SMTP id ffacd0b85a97d-42cc1d19a16mr3698652f8f.43.1763747145811;
        Fri, 21 Nov 2025 09:45:45 -0800 (PST)
Received: from costa-tp.bos2.lab ([2a00:a041:e294:5000:b694:8e49:4f51:966d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7ec454csm11529567f8f.0.2025.11.21.09.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 09:45:45 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/8] tools/rtla: Consolidate -e/--event option parsing
Date: Fri, 21 Nov 2025 19:45:02 +0200
Message-ID: <20251121174504.519230-7-costa.shul@redhat.com>
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
X-Mimecast-MFC-PROC-ID: AJ116YPtTZu_5iwYAOX09oVI0HF3xHflMupeKgvljio_1763747146
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
index 720add9511e8..6a1675eba96e 100644
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
 
 	switch (c) {
 	case 'c':
@@ -84,6 +86,15 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
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
2.51.1

