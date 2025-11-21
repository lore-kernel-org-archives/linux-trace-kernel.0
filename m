Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928A13502BB
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763747149; cv=none; b=SeVQstOy+hdzOSKGE4PHAN3FV1YB+qYQTm0ZkB/Q4gqkU/83D9GY/zdKnVXD9Vc8sNST9DrBnMX+b4qvEtphFaQ+TDGiDMDuqUUipS2D3/sGaU64d/PyQF5lj6XESkXS6FmarK/3x45ihwUm9rm49BFMPv3y0wPX3Orczzv9Vq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763747149; c=relaxed/simple;
	bh=6HtkTrHaTP+JFYuLUkmN198Pzc6w5QKX3HI4CwFiz8Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=IzysVWHIdsnpKiXYBoM6UAOhTtxKseZjbfH0DpDAxGHouJSPFpDKZDBCgEOv6LC/FW9zmQeus0Ku6WMdHc/3VxEIGAscqBT4bnjLiaAKQG4r4u3NR8J7QCSdSxnIFX//ZTvw0P6BzEXePqrhN/2RA3W+BUyNXJeZ5N6gtiH0gMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iSlN3m66; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSlN3m66"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763747146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kDhqvOby/zFkZ07q4dNsAW+VSloRxfxxgo+K0Cbo+L4=;
	b=iSlN3m662Mdp8KocSmHr+02dcBVu1LMfLtcbxxWHOtkDcSi01zPX3RGyoEFjKKENXARiev
	zCY7UmyIhwy9d/lD3LZyhVYwiygXjjj2hESvmqB3GJsEs5ZE3AUQoQ776rWccw9u4ra9kf
	UZOcFfmKiv1PXID++Pn8VMvSjIsjX+M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-c_aJ2VAQPZ2p3FQ4m30qnQ-1; Fri, 21 Nov 2025 12:45:45 -0500
X-MC-Unique: c_aJ2VAQPZ2p3FQ4m30qnQ-1
X-Mimecast-MFC-AGG-ID: c_aJ2VAQPZ2p3FQ4m30qnQ_1763747144
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429c95fdba8so1171452f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 09:45:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763747144; x=1764351944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kDhqvOby/zFkZ07q4dNsAW+VSloRxfxxgo+K0Cbo+L4=;
        b=c4BWte0JSOeQJQ290KbbMYJXpXsO6kuYNuI/XfkFH/KZE1lYTu8uuDgqd31jmDYhYM
         5phWIfMiBa2ayrTId13NeIMIA4kIA1Yi9wnVdYtdOlgif1eOtZAxUCnQv6/oe7IrRwSd
         /rVAOWAiTUzB1A1/FXSWT1n5qNor0uBBUqkY3QJyWPkS9FLTsOayawA8noIkAufnxY5c
         df+PhG2uwAMMWtr7V5fH86ipi/e4B5XlabyiUD5ETbyBaobNQkrvQhwLuHazPWB0zumM
         Wjw77SiTmP2CO3+QA30Y+wThmLF4WahElZtaEUwP6h7QNkWshHY9Wv84ELSggCjHWJba
         Paaw==
X-Forwarded-Encrypted: i=1; AJvYcCVeOY1Q8v3Ws4mQdJYAFGtUiIP3skOECpOV3wGnxK11ZlZe8eQKWUbGr+mPdDHqov3HbKyxOhbBxvtANMG9hoJXIhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzke7dDgojPzs/Xkbzv9Dj/IsZSxLh4C4VmLdTdlUr3UWRjBGle
	B3wrZwC/9t/Aqc/ndi0kOVIin1BqYlqJjjMs/8PqGw1/XhtFaivgKZYrrRp7nbhYYu4rP5GmwXN
	1fhgcrXo5YEUbzS1ExJa9Uf7Do4wzArp1Jihok5z/Aa9+Drjz4urcHnF2JTYtHbU+ioPqLnr8QQ
	==
X-Gm-Gg: ASbGncsBDD7yOuNZzg+trXITJFw8h58I9d2oQ6YVcOpzJfnjLZPqa7JnXYLyuXn9VDw
	qFd9uJctmShHWqKoQsGgo86Sg9lpZOel41Im0oioE/8vGSN33FDvTwmTM0doz5mjwOnhLZCCy8f
	UwMO9I95X92Qc5A7BDVD++iG3VhitSNVol/CgBsSHhicl+fZqXwHvYEDESA/xEUMXRgssa6RVRL
	CQFl78Lq/EV3b8pt3U6vT64qMjNWgls9j5cuuAt9TOc1hwzCLDQ/C2zSMYeKdA8pLJWEu5hXBkl
	NHpsZLJynbXbid0D5nkRxaLhUM23uBfbeXMcAwHNV7GpQl04QQWJ7kb5p0KNfx49KhpZ5wYAmCo
	e7/coSNYynrUIH7y3fJXrKhZ6
X-Received: by 2002:a05:6000:24c4:b0:42b:3268:bfc0 with SMTP id ffacd0b85a97d-42cc1d51edcmr3330176f8f.49.1763747143832;
        Fri, 21 Nov 2025 09:45:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxKNuFIoU06S06x8Gb8WaEp9y+FF/CyN7E0SyCsTyUfV7QzJpyh4EXIBf5slRqz/Hw5NztZg==
X-Received: by 2002:a05:6000:24c4:b0:42b:3268:bfc0 with SMTP id ffacd0b85a97d-42cc1d51edcmr3330154f8f.49.1763747143390;
        Fri, 21 Nov 2025 09:45:43 -0800 (PST)
Received: from costa-tp.bos2.lab ([2a00:a041:e294:5000:b694:8e49:4f51:966d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7ec454csm11529567f8f.0.2025.11.21.09.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 09:45:42 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/8] tools/rtla: Consolidate -d/--duration option parsing
Date: Fri, 21 Nov 2025 19:45:01 +0200
Message-ID: <20251121174504.519230-6-costa.shul@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 2QCbkDiZmTVxRzf_xKTxAtQQiqSuuMXdBZvv1y9mIio_1763747144
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
index 4d752e438e89..720add9511e8 100644
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
 
 	switch (c) {
 	case 'c':
@@ -78,6 +79,11 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
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
2.51.1

