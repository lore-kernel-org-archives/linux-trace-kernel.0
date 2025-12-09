Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43AB2FDC47
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Dec 2025 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765274472; cv=none; b=FOPSed2WT8wWydLtboMRtPMdu2DuEjTFHBvfxHf9NANCofm2jr9rZ4KxVtRoPIP6W0SXWnbLAIp5VsbQHlhBvZ2XUSLPKYeBNYeCmHTOe92qZ1X8Pkcrvb+mBuC2+o3kIRBjElLpjg0Mix3MVtYdQ9lWagRom00SKdm4F/x9tN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765274472; c=relaxed/simple;
	bh=pcinWGI2amk67BBmpTOCcNnlMLYrFcfvRj36N90uskI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=k1UpVG7WStmiNiwYzUz5RYmAxrKts3KbPR30qpADM+hNryqEOrzXuiUld8KOLPLkTwdwIHIRYNLaE/M5G01Ka/xB0qL4siiQEq6UJaRMYJVX1fszqS8QMOixAJh1PcPcF8w4/YG9LCb6PfwfYi/nEPQGHvmshm/F96n7SQRNI4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XQ/MX7Yf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQ/MX7Yf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765274469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rxr15aPXQxtNlRONPVYNn6GfLGuD9f1NIPlJqiRmPcY=;
	b=XQ/MX7YfzdLIpLQoqEVUrHaFx79j1VbEDW4GotHR63RM37k2LT+08YJvxL7gzEKzE5kTxf
	s0YtOXYA/i13VBpx80+149Q0PurRS3rvvIUOnVpKNDETRpiDkisHnghJZkFG8mKmNEHAJa
	LGCepLqqXyM6S2rsbjeem87W4uSzB5s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-IaideqmjPv6g-U-xa6SUvA-1; Tue, 09 Dec 2025 05:01:08 -0500
X-MC-Unique: IaideqmjPv6g-U-xa6SUvA-1
X-Mimecast-MFC-AGG-ID: IaideqmjPv6g-U-xa6SUvA_1765274467
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47921784b97so35070475e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Dec 2025 02:01:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765274467; x=1765879267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rxr15aPXQxtNlRONPVYNn6GfLGuD9f1NIPlJqiRmPcY=;
        b=f63QXBkPj7ArrftnZWqZrsSVIIyXkNAIPDsNm0Az7JkbN1zre44IVxAZlLaxWpf5NH
         TWiIUNKXP3BZEnzw4D2vHnBuWx4Cr1eXJA2LL46190DzaAv9HxovnlB1dP0buQ9k1OGD
         lyE7sFL5H9zX9W/QbCEwvGPpk5T6X8OIk+J9Ugu8bDHJ3KwYxMZppUdXS0yI8pFmDcC+
         l8TQoQHR7lqnCiMbq6kcCDUdWKqPx6fVmL3a5Fk1jsycOacecFFQHOIItAPsPuAH+ZQN
         5DHrYuo6s//Y1eWT3KTSFy2omisxNX0OXJsjFbYVkBGkJPzj/mJdA4Fpl2d+QMRNa3ZT
         jU4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHfJAUXJLVHVlrfssggmr6bGv3Mk5BW6za/v1ybaarRERSCKhHIoWZxZrbQIDgRI3BgES6FE3WGGIhOcHUIW96Rg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ4dPJMGMomDNO9Ru6W7oBaDhKLT3krigA5P7mGMAHaN5vOMb8
	MYPbQKwuRxG98HbnbKEQT0TRPlPkCwgpvfDhFG9XRVfZZR9QJgCRsDfkIOfA3lHWpVrEZKrO3h+
	/+lBcs8XoZbZl6R6ILJBp1M05W6+f0OTLqtiP+JlJwGGHHnz4W11LCtg9/ThP7Bxm+sc+icT/Ug
	==
X-Gm-Gg: ASbGncteNXt/wRys042VrgH8QYQpezGzZTEuLVC+nfXiDMRGi/QudZP8OBbHf5vL+PX
	b++TsnjkqRs+m3N8tkq7DS5OP5LPJVlDO/DR6+cM7Wiiv3bjT6injurlxWYbATv3f+9tHaHj9y5
	NcisX4myZ9YtR7+8e4xGgmockSiCfLYtTYDLxWnzyKFTbHC0a2GHB+EXFAJjlVH8gW4TTKz4KAr
	3UtkZ3Pq/utsfxHZCeg6GfHHZfJoF2sRObxTAUfkHAMvE/wCx/WPjG5u9YOtQDd4EFYQNmfaTQ0
	qe1oCnIxITkD3o2Azmdh7812iz5hhYOo20uMYwyyj8FKC7urh5a+EqlbsZTR7lFrMA+lo88pghF
	4Dt5lbzd6eLqaU3RBHsgEZ1swXwY=
X-Received: by 2002:a05:600c:6989:b0:477:9650:3175 with SMTP id 5b1f17b1804b1-47939c913d3mr115977755e9.0.1765274466954;
        Tue, 09 Dec 2025 02:01:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkKrcIUTLPtuKVf64ualhvNn4rZkcylMIrwaMTfzhza7ra4vlCX9LF8krRte6+CeAsfi+68A==
X-Received: by 2002:a05:600c:6989:b0:477:9650:3175 with SMTP id 5b1f17b1804b1-47939c913d3mr115977335e9.0.1765274466523;
        Tue, 09 Dec 2025 02:01:06 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e294:5000:b694:8e49:4f51:966d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d612e49sm33620855e9.3.2025.12.09.02.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 02:01:05 -0800 (PST)
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
Subject: [PATCH v2 3/8] tools/rtla: Consolidate -C/--cgroup option parsing
Date: Tue,  9 Dec 2025 12:00:42 +0200
Message-ID: <20251209100047.2692515-3-costa.shul@redhat.com>
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
X-Mimecast-MFC-PROC-ID: JZY359_FXWfmeGFiPqCrTIx0QuVPcp-yoheERIWHQY0_1765274467
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Each rtla tool duplicates parsing of -C/--cgroup.

Migrate the option parsing from individual tools to the
common_parse_options().

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/common.c        | 7 ++++++-
 tools/tracing/rtla/src/osnoise_hist.c  | 7 +------
 tools/tracing/rtla/src/osnoise_top.c   | 7 +------
 tools/tracing/rtla/src/timerlat_hist.c | 7 +------
 tools/tracing/rtla/src/timerlat_top.c  | 7 +------
 5 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index e5aa8c30cd7d..33428fa77f9f 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -57,11 +57,12 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
 
 	static struct option long_options[] = {
 		{"cpus",                required_argument,      0, 'c'},
+		{"cgroup",              optional_argument,      0, 'C'},
 		{0, 0, 0, 0}
 	};
 
 	opterr = 0;
-	c = getopt_long(argc, argv, "c:", long_options, NULL);
+	c = getopt_long(argc, argv, "c:C::", long_options, NULL);
 	opterr = 1;
 
 	switch (c) {
@@ -70,6 +71,10 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
 			fatal("Invalid -c cpu list");
 		common->cpus = optarg;
 		break;
+	case 'C':
+		common->cgroup = 1;
+		common->cgroup_name = parse_optional_arg(argc, argv);
+		break;
 	default:
 		optind = saved_state;
 		return 0;
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 9e721362989a..5cbe5e1f1b07 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -491,7 +491,6 @@ static struct common_params
 			{"auto",		required_argument,	0, 'a'},
 			{"bucket-size",		required_argument,	0, 'b'},
 			{"entries",		required_argument,	0, 'E'},
-			{"cgroup",		optional_argument,	0, 'C'},
 			{"debug",		no_argument,		0, 'D'},
 			{"duration",		required_argument,	0, 'd'},
 			{"house-keeping",	required_argument,		0, 'H'},
@@ -520,7 +519,7 @@ static struct common_params
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:C::b:d:e:E:DhH:p:P:r:s:S:t::T:01234:5:6:7:",
+		c = getopt_long(argc, argv, "a:b:d:e:E:DhH:p:P:r:s:S:t::T:01234:5:6:7:",
 				 long_options, NULL);
 
 		/* detect the end of the options. */
@@ -546,10 +545,6 @@ static struct common_params
 			    params->common.hist.bucket_size >= 1000000)
 				fatal("Bucket size needs to be > 0 and <= 1000000");
 			break;
-		case 'C':
-			params->common.cgroup = 1;
-			params->common.cgroup_name = parse_optional_arg(argc, argv);
-			break;
 		case 'D':
 			config_debug = 1;
 			break;
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 73736cefd992..35db5b73c0d7 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -346,7 +346,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 	while (1) {
 		static struct option long_options[] = {
 			{"auto",		required_argument,	0, 'a'},
-			{"cgroup",		optional_argument,	0, 'C'},
 			{"debug",		no_argument,		0, 'D'},
 			{"duration",		required_argument,	0, 'd'},
 			{"event",		required_argument,	0, 'e'},
@@ -372,7 +371,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:C::d:De:hH:p:P:qr:s:S:t::T:0:1:2:3:",
+		c = getopt_long(argc, argv, "a:d:De:hH:p:P:qr:s:S:t::T:0:1:2:3:",
 				 long_options, NULL);
 
 		/* Detect the end of the options. */
@@ -391,10 +390,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 			if (!trace_output)
 				trace_output = "osnoise_trace.txt";
 
-			break;
-		case 'C':
-			params->common.cgroup = 1;
-			params->common.cgroup_name = parse_optional_arg(argc, argv);
 			break;
 		case 'D':
 			config_debug = 1;
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 4ae77145adea..9ecab2bb0f1e 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -796,7 +796,6 @@ static struct common_params
 	while (1) {
 		static struct option long_options[] = {
 			{"auto",		required_argument,	0, 'a'},
-			{"cgroup",		optional_argument,	0, 'C'},
 			{"bucket-size",		required_argument,	0, 'b'},
 			{"debug",		no_argument,		0, 'D'},
 			{"entries",		required_argument,	0, 'E'},
@@ -836,7 +835,7 @@ static struct common_params
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
+		c = getopt_long(argc, argv, "a:b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
 				 long_options, NULL);
 
 		/* detect the end of the options. */
@@ -858,10 +857,6 @@ static struct common_params
 			if (!trace_output)
 				trace_output = "timerlat_trace.txt";
 
-			break;
-		case 'C':
-			params->common.cgroup = 1;
-			params->common.cgroup_name = parse_optional_arg(argc, argv);
 			break;
 		case 'b':
 			params->common.hist.bucket_size = get_llong_from_str(optarg);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 9774c26b27ff..6329c3a489aa 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -566,7 +566,6 @@ static struct common_params
 	while (1) {
 		static struct option long_options[] = {
 			{"auto",		required_argument,	0, 'a'},
-			{"cgroup",		optional_argument,	0, 'C'},
 			{"debug",		no_argument,		0, 'D'},
 			{"duration",		required_argument,	0, 'd'},
 			{"event",		required_argument,	0, 'e'},
@@ -600,7 +599,7 @@ static struct common_params
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:C::d:De:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
+		c = getopt_long(argc, argv, "a:d:De:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
 				 long_options, NULL);
 
 		/* detect the end of the options. */
@@ -637,10 +636,6 @@ static struct common_params
 			/* set aa_only to avoid parsing the trace */
 			params->common.aa_only = 1;
 			break;
-		case 'C':
-			params->common.cgroup = 1;
-			params->common.cgroup_name = optarg;
-			break;
 		case 'D':
 			config_debug = 1;
 			break;
-- 
2.52.0

