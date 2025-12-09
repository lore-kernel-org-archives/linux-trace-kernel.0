Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CC92FFDC2
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Dec 2025 10:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765274482; cv=none; b=MuqNO7J/b3aL6Gyts+iRR93VI8A2YU5g5+sbTIWn/wHd0uJ55Ps1fH7VOb5E/lZ8/dOcK2QdAVtu2fAkvFi1DUA7R5dW8LP2PQ3tndlPisGPpHEubykg9q58NRb4vCaN1j3KmZeGUUQQre3Dsak2T7Oi0OMVLQaiGQ7kPxyudsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765274482; c=relaxed/simple;
	bh=hd3fz8hCksqBKZMaUqkoJrnPGPaCtPUTWHGD5qYrWDk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=GxJfMt5v5eOUjCd5Ge9JVFfEpHvoMJaAbKsHyTMnN7bccCY6V/GxdWRsiTsgEULULC9G3fwIJbpjb9XzWy/XK7EXbAxjwDOqgwbpJY4ldmBHC+wWQ8q6FuSqBmRh2GkKmdtJpqLgGPqcmcc/sUYgJxWGkvY85wh3JK/qLOrI24o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a4TWVoui; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4TWVoui"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765274479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lS4QJ9Bo6aUGvWeykTwdCJ3BnkDetPbmh8qc9qY4nHE=;
	b=a4TWVouiZ7f5R0mnL7VLC0D0xq0xI60Hcksga/c6FjvblotNMs1ccfhroU4cYR53MDRgWI
	psndNKxkqSp4BXUU0gjy1aKgx79QjToU9pukTObFASdNJH6F39PzMaQaPMTETZNVI5hF9f
	UoUYuROl1YB8smrXckLPYoESCDPhrqU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-syQ_xTDKOh6ULAcQM4CXgg-1; Tue, 09 Dec 2025 05:01:18 -0500
X-MC-Unique: syQ_xTDKOh6ULAcQM4CXgg-1
X-Mimecast-MFC-AGG-ID: syQ_xTDKOh6ULAcQM4CXgg_1765274477
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47788165c97so33388455e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Dec 2025 02:01:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765274477; x=1765879277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lS4QJ9Bo6aUGvWeykTwdCJ3BnkDetPbmh8qc9qY4nHE=;
        b=rAbNzImeqpcXNYy5bSzBjGwI/t95EB4Q5sstMeu+4wf/Nhgnlw5vKeHa9kSVUwkSzw
         HMX/lyQqcGDfBpE0E/OlW6GAPBGxHaBiq8n1LV13XKiObJW8BwFpmt+9Uv5hS99c/GTK
         csnR1IIeOSC24LoyAr+1Z+HoTanWG/mFZUMPzs8EuzJas17veQSf6hTx6Fu4z6kW/C/F
         HJN8psIh0G/uM8tciF7yiJgvsgTIq/AkMSHrlKRzmQ5TbRLZqBfOzJAtffgZ+5F4OOQi
         fry94fNYKBoamIWCbzLPBKMa20T7nT3JjIDXvOfsF4evfw+m1kvfIUZCFLf84XS/xZNq
         L5qw==
X-Forwarded-Encrypted: i=1; AJvYcCUrVmsD630Jz7mCVvl5Q66qZ9HO5eMQXJOwE3CWQLQU0hrYx4Wp/EoF9iiBRYmTBdjd8ilz6Nw2MiC6zELBkKe7BnE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ghJZ3GIXlnOtTQQleCgJWNHOZPQACpMsi94lRTjR63M/sU5T
	xfUGnG+QQq0wz57oAeafQmUUNWanv+SmcDBbF7OL/WocsD2+5+Rla6xDm2ECIl1xIyc8KNPPhtN
	Exkb7tZj9KorBnhfeavXNeXkVUsRG3ooZ0jC7iFZEGA8cnbn8SMlxzx3i0bpaTZOaW9Uv09zyXQ
	==
X-Gm-Gg: ASbGnctj9A2Jb+XQKCVA3uY2niEtxCxjKfbFRlSODJhGWoNYkRhtkgJLQcThiZqSvA6
	E10V5rf42sOWwjcynPhMQOzCUiw+Z1HQb0lJ9ncV725qgtVwI+rnk5q1Fzy6Mg6sF5Ey3LST5G9
	sbVrSH7898Wrv73Q0lVpyW35+JLuF5Q+CNeupGmWBitrdHSpds7f2CZOzsTVEsn//ryROMW9xYp
	298I4USMvzdyWbElDde5/vEwoSTZRIJLFn1WnlQyFGe4xR+py+38JQVWF/DX11JQsdv2OrZlS6K
	yuGfxWfTGpqP7dFj8nnzdlGAluDd/e22qRaUHO7CzF7NJx4DcgclZQb0+usbcHEiRyzFIN/Uw/b
	KpASSBB6CpuqqbDT40Eh2a22dKyk=
X-Received: by 2002:a05:600c:3b9d:b0:477:7b16:5fa6 with SMTP id 5b1f17b1804b1-47939dec75bmr112885685e9.3.1765274476670;
        Tue, 09 Dec 2025 02:01:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHedUWkHnxa8byDCoUHHOPBLiai9/sYUgqzr/SlTFbm4BVLn2rDDnNuWnA6pJEUK+AAel7W+Q==
X-Received: by 2002:a05:600c:3b9d:b0:477:7b16:5fa6 with SMTP id 5b1f17b1804b1-47939dec75bmr112885255e9.3.1765274476171;
        Tue, 09 Dec 2025 02:01:16 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e294:5000:b694:8e49:4f51:966d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d612e49sm33620855e9.3.2025.12.09.02.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 02:01:10 -0800 (PST)
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
Subject: [PATCH v2 5/8] tools/rtla: Consolidate -d/--duration option parsing
Date: Tue,  9 Dec 2025 12:00:44 +0200
Message-ID: <20251209100047.2692515-5-costa.shul@redhat.com>
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
X-Mimecast-MFC-PROC-ID: lDwpHNwZvpSuhVdDUrPMKQStqafW16ZQvZqqkOtAu0A_1765274477
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Each rtla tool duplicates parsing of -d/--duration.

Migrate the option parsing from individual tools to the
common_parse_options().

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/common.c        | 8 +++++++-
 tools/tracing/rtla/src/osnoise_hist.c  | 8 +-------
 tools/tracing/rtla/src/osnoise_top.c   | 8 +-------
 tools/tracing/rtla/src/timerlat_hist.c | 8 +-------
 tools/tracing/rtla/src/timerlat_top.c  | 8 +-------
 5 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index 5bf79a9bb152..e6ff011d2cd2 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -59,11 +59,12 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
 		{"cpus",                required_argument,      0, 'c'},
 		{"cgroup",              optional_argument,      0, 'C'},
 		{"debug",               no_argument,            0, 'D'},
+		{"duration",            required_argument,      0, 'd'},
 		{0, 0, 0, 0}
 	};
 
 	opterr = 0;
-	c = getopt_long(argc, argv, "c:C::D", long_options, NULL);
+	c = getopt_long(argc, argv, "c:C::Dd:", long_options, NULL);
 	opterr = 1;
 
 	switch (c) {
@@ -79,6 +80,11 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
 	case 'D':
 		config_debug = 1;
 		break;
+	case 'd':
+		common->duration = parse_seconds_duration(optarg);
+		if (!common->duration)
+			fatal("Invalid -d duration");
+		break;
 	default:
 		optind = saved_state;
 		return 0;
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 6902486fb144..1b79bfefc214 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -491,7 +491,6 @@ static struct common_params
 			{"auto",		required_argument,	0, 'a'},
 			{"bucket-size",		required_argument,	0, 'b'},
 			{"entries",		required_argument,	0, 'E'},
-			{"duration",		required_argument,	0, 'd'},
 			{"house-keeping",	required_argument,		0, 'H'},
 			{"help",		no_argument,		0, 'h'},
 			{"period",		required_argument,	0, 'p'},
@@ -518,7 +517,7 @@ static struct common_params
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:b:d:e:E:hH:p:P:r:s:S:t::T:01234:5:6:7:",
+		c = getopt_long(argc, argv, "a:b:e:E:hH:p:P:r:s:S:t::T:01234:5:6:7:",
 				 long_options, NULL);
 
 		/* detect the end of the options. */
@@ -544,11 +543,6 @@ static struct common_params
 			    params->common.hist.bucket_size >= 1000000)
 				fatal("Bucket size needs to be > 0 and <= 1000000");
 			break;
-		case 'd':
-			params->common.duration = parse_seconds_duration(optarg);
-			if (!params->common.duration)
-				fatal("Invalid -D duration");
-			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
 			if (!tevent)
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 4a61fd50b990..619c5bcf8f35 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -346,7 +346,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 	while (1) {
 		static struct option long_options[] = {
 			{"auto",		required_argument,	0, 'a'},
-			{"duration",		required_argument,	0, 'd'},
 			{"event",		required_argument,	0, 'e'},
 			{"house-keeping",	required_argument,	0, 'H'},
 			{"help",		no_argument,		0, 'h'},
@@ -370,7 +369,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:d:e:hH:p:P:qr:s:S:t::T:0:1:2:3:",
+		c = getopt_long(argc, argv, "a:e:hH:p:P:qr:s:S:t::T:0:1:2:3:",
 				 long_options, NULL);
 
 		/* Detect the end of the options. */
@@ -390,11 +389,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 				trace_output = "osnoise_trace.txt";
 
 			break;
-		case 'd':
-			params->common.duration = parse_seconds_duration(optarg);
-			if (!params->common.duration)
-				fatal("Invalid -d duration");
-			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
 			if (!tevent)
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 97d20e272583..0a7e5dcce121 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -798,7 +798,6 @@ static struct common_params
 			{"auto",		required_argument,	0, 'a'},
 			{"bucket-size",		required_argument,	0, 'b'},
 			{"entries",		required_argument,	0, 'E'},
-			{"duration",		required_argument,	0, 'd'},
 			{"house-keeping",	required_argument,	0, 'H'},
 			{"help",		no_argument,		0, 'h'},
 			{"irq",			required_argument,	0, 'i'},
@@ -834,7 +833,7 @@ static struct common_params
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:b:d:e:E:hH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
+		c = getopt_long(argc, argv, "a:b:e:E:hH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
 				 long_options, NULL);
 
 		/* detect the end of the options. */
@@ -863,11 +862,6 @@ static struct common_params
 			    params->common.hist.bucket_size >= 1000000)
 				fatal("Bucket size needs to be > 0 and <= 1000000");
 			break;
-		case 'd':
-			params->common.duration = parse_seconds_duration(optarg);
-			if (!params->common.duration)
-				fatal("Invalid -D duration");
-			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
 			if (!tevent)
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 96bca67d419f..4340fbf3f879 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -566,7 +566,6 @@ static struct common_params
 	while (1) {
 		static struct option long_options[] = {
 			{"auto",		required_argument,	0, 'a'},
-			{"duration",		required_argument,	0, 'd'},
 			{"event",		required_argument,	0, 'e'},
 			{"help",		no_argument,		0, 'h'},
 			{"house-keeping",	required_argument,	0, 'H'},
@@ -598,7 +597,7 @@ static struct common_params
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:d:e:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
+		c = getopt_long(argc, argv, "a:e:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
 				 long_options, NULL);
 
 		/* detect the end of the options. */
@@ -635,11 +634,6 @@ static struct common_params
 			/* set aa_only to avoid parsing the trace */
 			params->common.aa_only = 1;
 			break;
-		case 'd':
-			params->common.duration = parse_seconds_duration(optarg);
-			if (!params->common.duration)
-				fatal("Invalid -d duration");
-			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
 			if (!tevent)
-- 
2.52.0

