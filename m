Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB78318138
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Dec 2025 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765274475; cv=none; b=m6jRpQwnNMXmcTSGR5j31cBU+aIpeEc/3G7MJ35pVEP6Q0wIgMm+HZ2VJyIG+Ntsghx/i78DqVk1FRo4DuBq81EJ+Z/p/3OBH7ZcyVGalZoEsTl1fxkOECZdexzYufM+Z9QcKxIsVNuIy8986AWBVHHwXUUxCe024/HMtgbxmHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765274475; c=relaxed/simple;
	bh=en8zvrxY8a3RBZdl9ey0RPXajkUaTU7+wFOrRsK8CFI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=InwPUnEYUrCEKGp7minO4ebaYa9H9vTwtZP5uXynEzRcQpga5YDSbnpm3Vw4ollNWnPN7R1hDCN3gzDRBRspAxr2FAdMnDk/oCvHLe/TlqHKWSNdNjlJwX/AG5/vQy4lRbz/anZpFcr/g+1xrB9Mj6TDjJN3iU1Uk4MClKojPlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYJsUnb6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYJsUnb6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765274472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mWORc4vQvCkdC6PaSocYq2/oPRblJcCMNwdxAuUhne4=;
	b=JYJsUnb6LWyVShLHHNtOxchDl5YMh+WMcXUVBdaAeVe23uvRP74RIjGlGjrCB7WKLItbh7
	HyQFJu2AuRRGIbpGNNevqMaX/5ZTUSOuaJEwMxzMLzVgsobiWtxG+EL9XO06x0rQpR/ZwX
	O6W8aop6UUdS7B0NSoMSpzT3vp9TfpA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-zlGc2AS4MxquWlP9yHVDjw-1; Tue, 09 Dec 2025 05:01:10 -0500
X-MC-Unique: zlGc2AS4MxquWlP9yHVDjw-1
X-Mimecast-MFC-AGG-ID: zlGc2AS4MxquWlP9yHVDjw_1765274469
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47797caba11so25352525e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Dec 2025 02:01:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765274469; x=1765879269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mWORc4vQvCkdC6PaSocYq2/oPRblJcCMNwdxAuUhne4=;
        b=mtNMCQFcVpafP6v4CjYvqr2oEkpU2c3lpE3BnT+XrR3BZDQt82yOmgUMn/BRrAUvQM
         y1UMnRxRViHMt3R3j/sk4F6YmTn3VcqnmSA+z+FZJ5t4xki45/wywUmOUSqPc94M9or+
         oRnjBvVnAyeSTtLZmpHchaAu64iIZY06XZXorlC4VQ5/mW9fegwBI65xlK6dvmTQZRMY
         uxl7lKH44xewYGFVMqQvqopFZOjVh9xO4gqJWuQZ9euyq4Qxdjw3qLqN1yNfhya9cGnc
         VEp+isnLCvCxVe6Ph2qSH+kOxOvRq99J7Yy9H8/i7H4ZXBQImPWSlq9CRh76Ko3NVbvU
         vLIA==
X-Forwarded-Encrypted: i=1; AJvYcCUsDjH4b4+TIt4BjJDBC5PdGZAsjinFHQstIdHzP1LidToWgtQPHffYCYBJyEGIy0mYgNTJ5yV7w5Hq58mXeVWmOgg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd2QjBu/D+vU2Pe79kKwyDAmwrUGCkRMWN7f0RmPY8KlVr3ZFm
	QqN2knx+SPNZZ+K8WdKy/TYuB6r420HmiP31EvuspmNs0uF2i+VIq8xOyOdpFG0OjTw8XLIL7wD
	xSFsNeOokxbVYgCRh91R6VuAWz958aLjQc3dBkCVXeCyVIFq2vOra4UFN08Hh1fhpT2d3BcqZAw
	==
X-Gm-Gg: ASbGnctr+GDKFFl+fKw3Jkv97BalTfGdiVw5K5l/qZr3CcAGWsFNibgl5KDZTW9zF7n
	U9wNJbuFvjh1BrqzE4s7ykZwZCWDLyZundWqcXixq+z6y7Ec7kbu7N7vv/5cQDK9/yAbyFxSJBz
	JQxQ+ieKY0s44gY5Ypg7N3atjXhmNX7Lq5mCnEHmhrQ0YY7FuI8RNjiyvUk4l6eDFk6NluOeuPl
	VeNebtGTqhF9YPj5fB8CzWwVxJGlH6fGFIe8iJY1qPk6UIVdBzB/jCbEmnnXqqk8HW0nMINhn9Q
	EKMQXwcHlWMckS7jgBGvTpBNGUHgojoRhsGrMxetufRDdO9M9oSVcrAsvUh1O/CJstLkmBZ3xQi
	/cWNud8NuYhnq5v1ce750hZQgM+g=
X-Received: by 2002:a05:600c:8b4b:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-47939e4ff40mr98781855e9.33.1765274469376;
        Tue, 09 Dec 2025 02:01:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnspC0yIEnUnMafaSQWQIjZzoFcqj1JjFfAvNScGAApQwKNUGcF5ozT1bN/VlNUkbS7to4/A==
X-Received: by 2002:a05:600c:8b4b:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-47939e4ff40mr98781395e9.33.1765274468851;
        Tue, 09 Dec 2025 02:01:08 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e294:5000:b694:8e49:4f51:966d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d612e49sm33620855e9.3.2025.12.09.02.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 02:01:08 -0800 (PST)
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
Subject: [PATCH v2 4/8] tools/rtla: Consolidate -D/--debug option parsing
Date: Tue,  9 Dec 2025 12:00:43 +0200
Message-ID: <20251209100047.2692515-4-costa.shul@redhat.com>
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
X-Mimecast-MFC-PROC-ID: B_7qmaeWVaiYP-LhBpfd9E4xzBGi1Zl75MyiDAEKc2c_1765274469
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Each rtla tool duplicates parsing of -D/--debug.

Migrate the option parsing from individual tools to the
common_parse_options().

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/common.c        | 6 +++++-
 tools/tracing/rtla/src/osnoise_hist.c  | 6 +-----
 tools/tracing/rtla/src/osnoise_top.c   | 6 +-----
 tools/tracing/rtla/src/timerlat_hist.c | 6 +-----
 tools/tracing/rtla/src/timerlat_top.c  | 6 +-----
 5 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index 33428fa77f9f..5bf79a9bb152 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -58,11 +58,12 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
 	static struct option long_options[] = {
 		{"cpus",                required_argument,      0, 'c'},
 		{"cgroup",              optional_argument,      0, 'C'},
+		{"debug",               no_argument,            0, 'D'},
 		{0, 0, 0, 0}
 	};
 
 	opterr = 0;
-	c = getopt_long(argc, argv, "c:C::", long_options, NULL);
+	c = getopt_long(argc, argv, "c:C::D", long_options, NULL);
 	opterr = 1;
 
 	switch (c) {
@@ -75,6 +76,9 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
 		common->cgroup = 1;
 		common->cgroup_name = parse_optional_arg(argc, argv);
 		break;
+	case 'D':
+		config_debug = 1;
+		break;
 	default:
 		optind = saved_state;
 		return 0;
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 5cbe5e1f1b07..6902486fb144 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -491,7 +491,6 @@ static struct common_params
 			{"auto",		required_argument,	0, 'a'},
 			{"bucket-size",		required_argument,	0, 'b'},
 			{"entries",		required_argument,	0, 'E'},
-			{"debug",		no_argument,		0, 'D'},
 			{"duration",		required_argument,	0, 'd'},
 			{"house-keeping",	required_argument,		0, 'H'},
 			{"help",		no_argument,		0, 'h'},
@@ -519,7 +518,7 @@ static struct common_params
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:b:d:e:E:DhH:p:P:r:s:S:t::T:01234:5:6:7:",
+		c = getopt_long(argc, argv, "a:b:d:e:E:hH:p:P:r:s:S:t::T:01234:5:6:7:",
 				 long_options, NULL);
 
 		/* detect the end of the options. */
@@ -545,9 +544,6 @@ static struct common_params
 			    params->common.hist.bucket_size >= 1000000)
 				fatal("Bucket size needs to be > 0 and <= 1000000");
 			break;
-		case 'D':
-			config_debug = 1;
-			break;
 		case 'd':
 			params->common.duration = parse_seconds_duration(optarg);
 			if (!params->common.duration)
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 35db5b73c0d7..4a61fd50b990 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -346,7 +346,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 	while (1) {
 		static struct option long_options[] = {
 			{"auto",		required_argument,	0, 'a'},
-			{"debug",		no_argument,		0, 'D'},
 			{"duration",		required_argument,	0, 'd'},
 			{"event",		required_argument,	0, 'e'},
 			{"house-keeping",	required_argument,	0, 'H'},
@@ -371,7 +370,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:d:De:hH:p:P:qr:s:S:t::T:0:1:2:3:",
+		c = getopt_long(argc, argv, "a:d:e:hH:p:P:qr:s:S:t::T:0:1:2:3:",
 				 long_options, NULL);
 
 		/* Detect the end of the options. */
@@ -390,9 +389,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 			if (!trace_output)
 				trace_output = "osnoise_trace.txt";
 
-			break;
-		case 'D':
-			config_debug = 1;
 			break;
 		case 'd':
 			params->common.duration = parse_seconds_duration(optarg);
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 9ecab2bb0f1e..97d20e272583 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -797,7 +797,6 @@ static struct common_params
 		static struct option long_options[] = {
 			{"auto",		required_argument,	0, 'a'},
 			{"bucket-size",		required_argument,	0, 'b'},
-			{"debug",		no_argument,		0, 'D'},
 			{"entries",		required_argument,	0, 'E'},
 			{"duration",		required_argument,	0, 'd'},
 			{"house-keeping",	required_argument,	0, 'H'},
@@ -835,7 +834,7 @@ static struct common_params
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
+		c = getopt_long(argc, argv, "a:b:d:e:E:hH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
 				 long_options, NULL);
 
 		/* detect the end of the options. */
@@ -864,9 +863,6 @@ static struct common_params
 			    params->common.hist.bucket_size >= 1000000)
 				fatal("Bucket size needs to be > 0 and <= 1000000");
 			break;
-		case 'D':
-			config_debug = 1;
-			break;
 		case 'd':
 			params->common.duration = parse_seconds_duration(optarg);
 			if (!params->common.duration)
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 6329c3a489aa..96bca67d419f 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -566,7 +566,6 @@ static struct common_params
 	while (1) {
 		static struct option long_options[] = {
 			{"auto",		required_argument,	0, 'a'},
-			{"debug",		no_argument,		0, 'D'},
 			{"duration",		required_argument,	0, 'd'},
 			{"event",		required_argument,	0, 'e'},
 			{"help",		no_argument,		0, 'h'},
@@ -599,7 +598,7 @@ static struct common_params
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:d:De:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
+		c = getopt_long(argc, argv, "a:d:e:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
 				 long_options, NULL);
 
 		/* detect the end of the options. */
@@ -636,9 +635,6 @@ static struct common_params
 			/* set aa_only to avoid parsing the trace */
 			params->common.aa_only = 1;
 			break;
-		case 'D':
-			config_debug = 1;
-			break;
 		case 'd':
 			params->common.duration = parse_seconds_duration(optarg);
 			if (!params->common.duration)
-- 
2.52.0

