Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF7A3502AA
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763747146; cv=none; b=Y9wwDH7MFaGuM0uOKqW5NtAeanSYkbTMpdPVGXCq2fKYFlt9PTRkRxo6XrBys/xhagfQ9R8guVkjySiVgaijD2ETdTR/fZWmVzyNZ7V+UC3F6ofFiS/VGnKwTZEsMCH9B8g5YuBmhrdNhETmDzPAvYE+LQlKabQVv3FLlldYPx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763747146; c=relaxed/simple;
	bh=jI07AZA+TX7XdamDHqd4AYGgXdXJ9w/eJer63SI/Klc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=jn1OdxBlpSJMXXy1TncXIXxQKRaWScZkKU2UDPg05oxuhaExoYXFanUll8QU9DlNiLldW641CfOROEQE8QJKqTp/mX3BgqFm5fDrahUCmcxtEyyK0RAYN1zsseqQqp3+jtj7ErK6rk1iCONzp4pU8JVrbtmjWIj5QgGAJdcoCDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tlk+Gach; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tlk+Gach"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763747143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g4vTg2SXn5ikmleP2ulGHJRIjy4fI9F/oORLv9vFsuE=;
	b=Tlk+GachBXPdEoSXeX4Em8yQiXoQXln7GsD9xvcZWNn0v1p8QCUouAn9DP+Z1uTjq9G/sH
	Ux93WCeksc9TTDjHcUg4V31lzSKqY2vX12pqIrqP33DCM1lga3Aga319LabJ15QmrnxiHQ
	AXIayZm2BHGwSgB+0zme8axViXRUr6w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-L-K74EcHNii_E_bZTYGqFQ-1; Fri, 21 Nov 2025 12:45:42 -0500
X-MC-Unique: L-K74EcHNii_E_bZTYGqFQ-1
X-Mimecast-MFC-AGG-ID: L-K74EcHNii_E_bZTYGqFQ_1763747142
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b2ad29140so1233708f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 09:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763747141; x=1764351941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g4vTg2SXn5ikmleP2ulGHJRIjy4fI9F/oORLv9vFsuE=;
        b=lnHf2Qr5UXmcIG8R5NOkDOS9c5mz1cCMIC9cZdemSmyelA0zTuG3ccleXAC1BTa9PR
         5y/1SkWGza5uUvICNvQRZv/Sbe39gEBs2N9/QuYmmkxvw95ErELGIgdZhpe5ypRgv+7I
         6og0YmqHTRnZc1sdUEqro+OvRmpYoPMW0OvRRuwjwlhcMNTw5xRT34HuP4ZwEG7ml2v/
         MFUbNp/EHMgb5vnn5C4bMgA8TsP1+71+iknDQF+Mn4vpAI/DfV0BcCoAxHTUOX+wJDKY
         YUS4xDd7hkpZbi/ZMFcohERjMji1J2bI27iCn8JI8o5YAU42HQcrrJOpnvBZApkCovKe
         BTgg==
X-Forwarded-Encrypted: i=1; AJvYcCXtcmdXc+uOFwran6S/Q40f+C0U/Ncy1RWyYwJmwAyfE0TnGWAMFSOj0nVcmIQbc/QvHg0/1CL79Gn6S2ET+XhCMy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx15hUJvWTjHmT+UFDL1MlHQ3jrq9T+EpRBBQtuAidbl5g0ockP
	HOsFgo3gLelzSg7XiSmhVMRpjyrkTYp5DrgwFHpKp4Kj84X0qs8EWMEkIiut41X0A2kXCdSegct
	iqmCqye+Jloa2oujAiIQ5pKN+zpeNwKH6TaY+p0SmYxNbR/yUIoq/R4yhBO8yCkH1ylkdI6WhUA
	==
X-Gm-Gg: ASbGncuAEN+xhj5z7InXqSTqaka5Qz2hQjN4NIpCcBVFnyiWskCOLkOTab8DnlqRUDK
	U2k+6GqtIS0WWESjHu3DAWS2oIObGkmkKKUtPuqx5J0CcI1XSVoOv0veUKSCgWel2pielk0TcxP
	LlEt3PQutfUSBjhfn+VPkppgtnBk3Jl2vHwEevDWvmSiMOhugWGylpyNkd1d7qEXfLyWMcMr3ur
	2R1GKkrc1D9P0L9mtab0dj9jaqPLkwRB71IMGJTHinZkhTSage8dGYV3j6BNDGfSqwcfRIAjFQN
	E+t1bQRvpP+TB4Zp56TRIotnY9jPFuZouWgL9AZHYyclDtdH1o6qigt8vhBIxl0mvNHZvxmWHbV
	QKIlXXIeFuzQMznH/ol9LIPiP
X-Received: by 2002:a5d:5850:0:b0:429:c709:7b54 with SMTP id ffacd0b85a97d-42cc1cf3c0bmr3187028f8f.36.1763747141416;
        Fri, 21 Nov 2025 09:45:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMogGSpPJax38iHwqevfbwGGHtpcSZqT2Cj7PBh9pXn6LQfxQmFEKu2ydXxpCDILAnwUBkIg==
X-Received: by 2002:a5d:5850:0:b0:429:c709:7b54 with SMTP id ffacd0b85a97d-42cc1cf3c0bmr3186997f8f.36.1763747140921;
        Fri, 21 Nov 2025 09:45:40 -0800 (PST)
Received: from costa-tp.bos2.lab ([2a00:a041:e294:5000:b694:8e49:4f51:966d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7ec454csm11529567f8f.0.2025.11.21.09.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 09:45:40 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/8] tools/rtla: Consolidate -D/--debug option parsing
Date: Fri, 21 Nov 2025 19:45:00 +0200
Message-ID: <20251121174504.519230-5-costa.shul@redhat.com>
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
X-Mimecast-MFC-PROC-ID: IBhv4d2pbXFAnSz6Yhi588wGaszCo3K3VFRwhYRm16Q_1763747142
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
index 92fb2973c373..4d752e438e89 100644
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
 
 	switch (c) {
 	case 'c':
@@ -74,6 +75,9 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
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
2.51.1

