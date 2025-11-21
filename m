Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DB62C158E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763747142; cv=none; b=cBwMlm2YUJhUqgh5XfbXpYIqIsCvq+fLxl+7Ly9g7+0jpWvanKCO3Cl15tRwgz65zZSD8YLiSumxT7ZNuHiz18fKHO51RLxCufLWWLc1KIV8hmlV/MUkmVxKbQwO82A9NrVSkn6f6afeDua0m18amj6TSoJlNdYg1aj7I8Sjkxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763747142; c=relaxed/simple;
	bh=MAliK+IcsyTe77pfxDlXugqDqQMD4jUXrAsnDuEV7lU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=bgz1OcY26e4K9I+kCC6QZdH/G4u0IgyT7sUyg06ICxByN8nSVJ2Y2oOjO5CdEtZ3dHzQy+aLcCrk0zWeqnNer212Q68Dt9pvIb0sJNsz2WdUd543dTcsvNMJhRh00x6hghtw3V2Tu+uHL7OsrRSOr9GyIh8pVBMdYlJ2EgcK8/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RIPmLo5h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RIPmLo5h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763747139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cfAuXX383Gya5pnw9IELY8Vpi4DW1gQ6wftsJO5f6yw=;
	b=RIPmLo5h6b0KgfM2r5dRU8mRalACGTuXdCRgcMRt1fjF01xlueIRooddpJS6o3VpbFlPC2
	bfJ3yC155pAO0/SbGOaP01t/yT9iatsOxaKDjvaZhjPf1oAl9QD9vnVaAFtvgYq97T59fh
	3+eL3Hxzq0vsPZ1Rpllb78Kk4yCtnL8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-Y_kSJDB0P0mBtoeEbBnPYQ-1; Fri, 21 Nov 2025 12:45:38 -0500
X-MC-Unique: Y_kSJDB0P0mBtoeEbBnPYQ-1
X-Mimecast-MFC-AGG-ID: Y_kSJDB0P0mBtoeEbBnPYQ_1763747137
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b30184be7so1172719f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 09:45:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763747137; x=1764351937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cfAuXX383Gya5pnw9IELY8Vpi4DW1gQ6wftsJO5f6yw=;
        b=ihrNLopLt7HPO2tPXLVQYDV9ImUTh1/p0vOFfnAzYjQuDQAvPTMTKIza9fLUeouhCM
         gzzlqdlKJu/OTnAQ1KiPjhP0G1X0HzyetersuSnFrzuVy5K0GAb8yBe2wUJ6N9VP1rwL
         9XHpWrY6GmFT08FAAhL1BYfkdAceSpgZNQJkah/7v7DXKJjCF2j1PffEV5iI0wzAf+YY
         /O2sKvh969eYAf1Kmi4jpAViLQEqN/H0KP4lk4eslrC2mjxvX/cp1KzyMR53YSaNukqA
         Twl3b4AKaVwmLGoOtKjM9mopxEN+zI3Txnx02idpQtgOmVM+7nP5H0nGtnOFt1pC76Y1
         gbXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYZxZ/dzIY6ykdftEPWzVQwuMU/VLtXTIxNXkN/ovjJvwuFSysg5azA92gIDKYfnG0M+Z67kpBybmtf80+ZKaRDK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNQWqPxCVUjJ4cEPBhzAt8yG1QwwPHXw3iPD/uprvQ8hZmiVpI
	Bc907jM6X2M6Z9jY8w9qS/WIhkAHwU8R3EndSYVuUHYdhAG6Dfc86yyYl97O5UoCbs+sr1gWAYe
	RzvY1m/uMpRYFyuhaYevbnGVr4Ydl93NtuxCTcp2cw0NVaBIWqEYqKHqolYDe0MEbZWJj94Fi7Q
	==
X-Gm-Gg: ASbGncsDyffqjWEHzI2PkPY091ylglDzomC7N38NCXexWkyh3qx/q3UOrB4xF7X1ofd
	mNO3pHkHdXZAmhwpAa55igf/s+KFp9yWn4GiEKAxgigt6GixzXHriGiBS4EloNkTRbcfLjX5zPi
	AvaRV37ZNCC3AYaTiAZz+/Wra2O80JPywlw1fTlajfTorpBuGyqDFhEI4hkHV4Ygh+EnuYILtlD
	hlg2Zz6l7PLOzHcKhacA9GqegCLHaoz0xBhY69eqaY2Y9FF2yM9gXWXdQd+MkJVTcPLR1VZW/Un
	991uJaGVw8uGGX6idcqpOWo4xxaBmgnHlByFRHNfs1d8R+qltbGkwAjDJ8d0u+wrVW+b1cDN8i2
	BGhagkqHUg4A6Ckj1KiaUKZvs
X-Received: by 2002:a05:6000:2681:b0:42b:4177:7139 with SMTP id ffacd0b85a97d-42cc1d520famr3437646f8f.46.1763747136940;
        Fri, 21 Nov 2025 09:45:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXmjn5aMQprmB6OepUqjNn0qu4/rJ18fZB8DnVYStyugXuxWVhu6KeoKnCXw+hhS3XPNSxRA==
X-Received: by 2002:a05:6000:2681:b0:42b:4177:7139 with SMTP id ffacd0b85a97d-42cc1d520famr3437620f8f.46.1763747136526;
        Fri, 21 Nov 2025 09:45:36 -0800 (PST)
Received: from costa-tp.bos2.lab ([2a00:a041:e294:5000:b694:8e49:4f51:966d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7ec454csm11529567f8f.0.2025.11.21.09.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 09:45:36 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/8] tools/rtla: Consolidate -C/--cgroup option parsing
Date: Fri, 21 Nov 2025 19:44:59 +0200
Message-ID: <20251121174504.519230-4-costa.shul@redhat.com>
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
X-Mimecast-MFC-PROC-ID: q6YJpkNffvnTzJxMIF25bDYstOXivnRx9uHL8aNNK6U_1763747137
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
index e12192fcb3ab..92fb2973c373 100644
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
 
 	switch (c) {
 	case 'c':
@@ -69,6 +70,10 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
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
2.51.1

