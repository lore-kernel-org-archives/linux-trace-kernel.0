Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42E42FD7D3
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Dec 2025 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765274472; cv=none; b=D8TKYEOOs/TTfSKqQoeb0CRieoaVaNzkixGo6kWsYPdp6QI4nTXYEeSOMAsBAHnVeZFcipRNwGYn1gXjfLbsGqBZ+WpYIEMHtsoWNbBs7/5FwWmn0fbE7L7FqxriFpmnf5iedSDEu1wTvexDcOUKkg1pG4OZXsBA24UKLRyrlO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765274472; c=relaxed/simple;
	bh=EYL8jMHEMsZ6U+ISXHnaT8gl0oIxzRcdqDA/qKxcflA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=LzjhpzsotBZaVvQ8eWQHJt2k9GB7O9zQykVow58icM7Ne6DtvUH3QFHb8Rx0Z7UWS5ciG/mzSWTw+PSHFUrqitrwK2lKPO7+pufvV59hPAXaqaLOi/L1cPIBADQ2y+no/rCWZ4JISmbZClILKeTgnWNv2luUpEdQ7hsr/GAZ6ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HXdcCmBl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXdcCmBl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765274469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulHpppgPkD0WivPOraMTYrfg6Edxoov5Pk58h71j2Rg=;
	b=HXdcCmBl3DunBCHhmmrJGiVPlOnQcUXEc/YkL8rCO8R5TgysROFO/DpWKSYT9EZg7UaiTA
	Jlr8Xj3vvYCM0C9ajjzbQvpFBTYZle9PG/9vSJqu7lT24BEF3DWt7M6NPhybni+aa3u/IU
	ria+lBuLxvnnJxo+9te46k3GbXs6AI4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-odXQM3h9P72OnMSt7Qi9SA-1; Tue, 09 Dec 2025 05:01:05 -0500
X-MC-Unique: odXQM3h9P72OnMSt7Qi9SA-1
X-Mimecast-MFC-AGG-ID: odXQM3h9P72OnMSt7Qi9SA_1765274465
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4779b432aecso32879745e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Dec 2025 02:01:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765274465; x=1765879265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ulHpppgPkD0WivPOraMTYrfg6Edxoov5Pk58h71j2Rg=;
        b=RV/zzB3SYVPNgUpAjXioGjSXsFAAynRCz4WaF7inFE9w0EQUm3f0ypwOIoywCTS76m
         KTqDxwrS9flsXgwjyvL9vwfgMmZ5w8DnXiXFm2YrITo87Af2C0DI4+uf8FEWeWhFsijk
         rsGvwPHhIdimL4r3ZqYOEpm8ld3AVLvqQXwj6+R6IShuBPEqu2aeCQcD2KFk4S44CM39
         LwU7g4G9+DI28YMbD5Me0NfH4zESlWjZtZ5kHQdgz2Y8o0k2DqEgCKWipgaDpjGsNTdd
         rliUOtu4qOioEieR7kl2SXvc4NgnRvCfpmqVoAJ8q3E8MjtggqDpk0Y21oRht7TWxdIG
         N4Uw==
X-Forwarded-Encrypted: i=1; AJvYcCW/tKnMtjP+edOWUbkQkU2Gf0407rWY+Ww2+rpTmEWMZy9sjs+hYa1xKcl6YlvtSFJfb/ffes6zB4Rq8MRucvbFRGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR6VMjgIYoM9QNTkeBFJ9rEu0wy3buabYPC/DI+lnTJTfqSPAt
	OHowsbxW5AOfR2gbCOt5tWugVOG+cW62JI87Ba9I8MPMcYNT2gSp2yjaLM91G0IGySqR19Bjpas
	QJlizdO5KucsZOV80rOmO5bRrgoOY+2PhJUUbMlTr0lJOTSbf0stAEs5TK4Ic+oWOxREx7jD9UQ
	==
X-Gm-Gg: ASbGnct0JwwHNdPP362HM3//T4plf5L+hk8dwuthCpRJmy6bM70DBYHypWfyAhpn09Z
	YG5JCE7KqXUFX1Qfsti/Z4EfQMOt/JfYcz0lHGk+gr9M8Bqtd1jvU4Z29ZxFCxdQj9OV/DhkRP1
	d2nWMx+3KgtR1YTwRuAmABgbjAqEglOK0Zy2bn3hlOf8AFE+UkIL19Ang+1h8PgaIJXsEImN2Pe
	l8Gu7HVbiWleRSl+SOkzKRS4B8yG3EyHt+nQ+2LIFiEnN70svVwnCVnesN6GI8FwxBh17yN3SPg
	p7LGgJDNnQsyY6JCedEDbhkdw/o/mmX0ua3IvHmnp9VwzEdfuiozv+pXZoDrVx3TYaMVGs5Q2mg
	VnHuM6BszIuh7DdWIA4tousOIj50=
X-Received: by 2002:a05:600c:1382:b0:477:aed0:f401 with SMTP id 5b1f17b1804b1-47939e276e1mr80240105e9.23.1765274464602;
        Tue, 09 Dec 2025 02:01:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKl2EQBEkqNCg6U4G3dj7IGLT7huIGgrqSFVgLdWD41QjtWYM84wV0MpjtV78sUTQJbkNY0w==
X-Received: by 2002:a05:600c:1382:b0:477:aed0:f401 with SMTP id 5b1f17b1804b1-47939e276e1mr80239655e9.23.1765274463941;
        Tue, 09 Dec 2025 02:01:03 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e294:5000:b694:8e49:4f51:966d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d612e49sm33620855e9.3.2025.12.09.02.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 02:01:03 -0800 (PST)
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
Subject: [PATCH v2 2/8] tools/rtla: Consolidate -c/--cpus option parsing
Date: Tue,  9 Dec 2025 12:00:41 +0200
Message-ID: <20251209100047.2692515-2-costa.shul@redhat.com>
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
X-Mimecast-MFC-PROC-ID: b8dCjH_OMiR34Jybsteo5P1d9IKiPCc0r5Kb-iW3FX0_1765274465
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Each rtla tool duplicates parsing of -c/--cpus.

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
index a78f9883521e..e5aa8c30cd7d 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -56,14 +56,20 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
 	int c;
 
 	static struct option long_options[] = {
+		{"cpus",                required_argument,      0, 'c'},
 		{0, 0, 0, 0}
 	};
 
 	opterr = 0;
-	c = getopt_long(argc, argv, "", long_options, NULL);
+	c = getopt_long(argc, argv, "c:", long_options, NULL);
 	opterr = 1;
 
 	switch (c) {
+	case 'c':
+		if (parse_cpu_set(optarg, &common->monitored_cpus))
+			fatal("Invalid -c cpu list");
+		common->cpus = optarg;
+		break;
 	default:
 		optind = saved_state;
 		return 0;
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 35f4a068af95..9e721362989a 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -491,7 +491,6 @@ static struct common_params
 			{"auto",		required_argument,	0, 'a'},
 			{"bucket-size",		required_argument,	0, 'b'},
 			{"entries",		required_argument,	0, 'E'},
-			{"cpus",		required_argument,	0, 'c'},
 			{"cgroup",		optional_argument,	0, 'C'},
 			{"debug",		no_argument,		0, 'D'},
 			{"duration",		required_argument,	0, 'd'},
@@ -521,7 +520,7 @@ static struct common_params
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:p:P:r:s:S:t::T:01234:5:6:7:",
+		c = getopt_long(argc, argv, "a:C::b:d:e:E:DhH:p:P:r:s:S:t::T:01234:5:6:7:",
 				 long_options, NULL);
 
 		/* detect the end of the options. */
@@ -547,12 +546,6 @@ static struct common_params
 			    params->common.hist.bucket_size >= 1000000)
 				fatal("Bucket size needs to be > 0 and <= 1000000");
 			break;
-		case 'c':
-			retval = parse_cpu_set(optarg, &params->common.monitored_cpus);
-			if (retval)
-				fatal("Invalid -c cpu list");
-			params->common.cpus = optarg;
-			break;
 		case 'C':
 			params->common.cgroup = 1;
 			params->common.cgroup_name = parse_optional_arg(argc, argv);
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 550731c7addd..73736cefd992 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -346,7 +346,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 	while (1) {
 		static struct option long_options[] = {
 			{"auto",		required_argument,	0, 'a'},
-			{"cpus",		required_argument,	0, 'c'},
 			{"cgroup",		optional_argument,	0, 'C'},
 			{"debug",		no_argument,		0, 'D'},
 			{"duration",		required_argument,	0, 'd'},
@@ -373,7 +372,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:c:C::d:De:hH:p:P:qr:s:S:t::T:0:1:2:3:",
+		c = getopt_long(argc, argv, "a:C::d:De:hH:p:P:qr:s:S:t::T:0:1:2:3:",
 				 long_options, NULL);
 
 		/* Detect the end of the options. */
@@ -392,12 +391,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 			if (!trace_output)
 				trace_output = "osnoise_trace.txt";
 
-			break;
-		case 'c':
-			retval = parse_cpu_set(optarg, &params->common.monitored_cpus);
-			if (retval)
-				fatal("Invalid -c cpu list");
-			params->common.cpus = optarg;
 			break;
 		case 'C':
 			params->common.cgroup = 1;
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index ffcfcabb9964..4ae77145adea 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -796,7 +796,6 @@ static struct common_params
 	while (1) {
 		static struct option long_options[] = {
 			{"auto",		required_argument,	0, 'a'},
-			{"cpus",		required_argument,	0, 'c'},
 			{"cgroup",		optional_argument,	0, 'C'},
 			{"bucket-size",		required_argument,	0, 'b'},
 			{"debug",		no_argument,		0, 'D'},
@@ -837,7 +836,7 @@ static struct common_params
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
+		c = getopt_long(argc, argv, "a:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
 				 long_options, NULL);
 
 		/* detect the end of the options. */
@@ -859,12 +858,6 @@ static struct common_params
 			if (!trace_output)
 				trace_output = "timerlat_trace.txt";
 
-			break;
-		case 'c':
-			retval = parse_cpu_set(optarg, &params->common.monitored_cpus);
-			if (retval)
-				fatal("Invalid -c cpu list");
-			params->common.cpus = optarg;
 			break;
 		case 'C':
 			params->common.cgroup = 1;
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index d18d48671ccd..9774c26b27ff 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -566,7 +566,6 @@ static struct common_params
 	while (1) {
 		static struct option long_options[] = {
 			{"auto",		required_argument,	0, 'a'},
-			{"cpus",		required_argument,	0, 'c'},
 			{"cgroup",		optional_argument,	0, 'C'},
 			{"debug",		no_argument,		0, 'D'},
 			{"duration",		required_argument,	0, 'd'},
@@ -601,7 +600,7 @@ static struct common_params
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:c:C::d:De:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
+		c = getopt_long(argc, argv, "a:C::d:De:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
 				 long_options, NULL);
 
 		/* detect the end of the options. */
@@ -638,12 +637,6 @@ static struct common_params
 			/* set aa_only to avoid parsing the trace */
 			params->common.aa_only = 1;
 			break;
-		case 'c':
-			retval = parse_cpu_set(optarg, &params->common.monitored_cpus);
-			if (retval)
-				fatal("Invalid -c cpu list");
-			params->common.cpus = optarg;
-			break;
 		case 'C':
 			params->common.cgroup = 1;
 			params->common.cgroup_name = optarg;
-- 
2.52.0

