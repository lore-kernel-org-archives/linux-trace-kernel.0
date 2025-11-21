Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BC134FF53
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763747141; cv=none; b=LCEe7D079UXTnAC6h4Mu/8xvL2M659MGUBch9Gq/cnub5J6slG0iPetypmZsr+Lwuozrp61tvm/uSY7onle8Ny/T0ghqJHeA0Hc7w0FxeyyYOWV9FJbDyq9tJ/OM6+y7mQ17dduGbi4+vu2qc1aHl7nxFQ+P4iV7zNXV4nJCNPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763747141; c=relaxed/simple;
	bh=pT/n7TwuIIVbjLsRSlAm3v1I6gvrDAWaKDW6YsvrdCs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=WmQf1eHbjcq8Uz0XVqQz7CeWubANgSjG0e2W55Kt8Xd33NWyH8hKyiRLkS8eJJsbysn3vvrp6Co1COEaVzT2iTeVAmUDVeCohvU1Bnn054LWggNi0nBDPtHliFYeqPWXPrMb/QiiZ1Jbe4jvt5Mp00TYf/HD0NV8ACPxoahlYRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X4tgWjmt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X4tgWjmt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763747138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YpyZDwI31rENzFfB5C1Wg2Rz+FfMtSQE+luFnR7RLDs=;
	b=X4tgWjmtERQYZMPMB1ubIXuf0Nh/Fa8Dxpvyh0hkY23ExSGmL+68R4HbFjBHd0q7sYkwu7
	ZMZ57ECpfgqLzWkG1A1YyuwsLFQyElChXFCBhq+B7YZaoeLWk4qQ6l1uRtUoi8O2QrMAaf
	rqx+b7BCdTyJcl/phr7SJczFWFP0++4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-dbvBzNqAPBWrHAMEMP5v4g-1; Fri, 21 Nov 2025 12:45:35 -0500
X-MC-Unique: dbvBzNqAPBWrHAMEMP5v4g-1
X-Mimecast-MFC-AGG-ID: dbvBzNqAPBWrHAMEMP5v4g_1763747134
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b2b9c7ab6so1102117f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 09:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763747134; x=1764351934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YpyZDwI31rENzFfB5C1Wg2Rz+FfMtSQE+luFnR7RLDs=;
        b=UNiPm3XSNVnOVn++oOvLiaW52Wo2hAwt6OLNYOAipbSx5EPenvk4DmmLPwdvbsoEVL
         pTW859uXAfxWwHQGlUcqI3zsj0dDQ18fbO531UdH/vhJ62ikF+H3Hyb2b394USomAsN/
         di8n/c4+hKlMIZVMn3m7LI5HELHKqWjLFV+lr1raf1if+2g7xg1qju8wmNRebaKuPnY4
         HpQPAwYOYwqv/dwY8FtM66xE+GEYaRJxB2ejq3sAreuntN7Rw7lvuXU0g4655iWPH1E7
         fd41gk//D8cmlmzGduvK/f4IqvgJjzYBKXQQsW4oxDqnvwmx4lgninP9+S4OyuyV3LXz
         DJ/A==
X-Forwarded-Encrypted: i=1; AJvYcCUo3gikuQbjMKO4Gko7/SAD53WM7TGEw9U+tckQiLryGUvyJPGJ75yylffqsUGmJPJ1fliQKsTkBg+MTAnqEpSuruM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4A65IhD2JiUr4EiigViBO7tKOBzEPURjEs8zXG0P1nzA3hBY9
	Lbk1mY5GDs6k/27qzmwRdCIwFIHosKkNpElsPN5Ys5l3LbueaKXleUdmH5ofZuQufxg7powrTOj
	GjvVVCrU8jffLZG844XuWANTdwCQZwQay6jm4rS1opxBVkWFEUYdpxkm2oThJGXxnKMbLTCjk0Q
	==
X-Gm-Gg: ASbGncsWYKQomjQ6dMqGfA6GDGaM1NbQkvZ5QXEIdS+pFuztRFfrtyhiYgopWWkEsxH
	ULURNLngleyxgnU+VC/T/lomNbBPFL0nz5y2soSL5/aerflgCnU6mkdEpzUEzDkLLXcKTFmSOgG
	CCX/pwMKRCbBfrNkvW9wGMBAs1vVPfOtxJuE4ODzKHB3d/eTM+ORyULHQwgRSE9ffwyH61+44G0
	sHRVPQOl/Rz9EDO7L8NGyfU9e1/opB7Z2w1tkMkMnVUn/78NjV5sQyggCg4iXSA/Q97H+dMgbvK
	WexNuYfbpP6ldlGQEcu1giATvnYPrTdqjXyajeeB2Mw0HM8tkws5lAnbf3nBUbgQ0amuwkeru2j
	Yq3QCOpiLptA845j9vKOTlC2O
X-Received: by 2002:a05:6000:240b:b0:429:c4bb:fbc4 with SMTP id ffacd0b85a97d-42cc1cc293dmr3253803f8f.25.1763747133662;
        Fri, 21 Nov 2025 09:45:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIpzBXzy0HPFysMAQjEIJp3Hx8LAxcp7Ta/3C1XrC0QGlsWwYqzq+LzSYTGLDxPDmbXken+A==
X-Received: by 2002:a05:6000:240b:b0:429:c4bb:fbc4 with SMTP id ffacd0b85a97d-42cc1cc293dmr3253778f8f.25.1763747133191;
        Fri, 21 Nov 2025 09:45:33 -0800 (PST)
Received: from costa-tp.bos2.lab ([2a00:a041:e294:5000:b694:8e49:4f51:966d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7ec454csm11529567f8f.0.2025.11.21.09.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 09:45:32 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/8] tools/rtla: Consolidate -c/--cpus option parsing
Date: Fri, 21 Nov 2025 19:44:58 +0200
Message-ID: <20251121174504.519230-3-costa.shul@redhat.com>
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
X-Mimecast-MFC-PROC-ID: Z0O7oPecuT-qZsNEoCfOMPs0cLY_Qcj9TuT71Sb_0wI_1763747134
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
index 5eaf6d9e11bf..e12192fcb3ab 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -56,13 +56,19 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
 	int c;
 
 	static struct option long_options[] = {
+		{"cpus",                required_argument,      0, 'c'},
 		{0, 0, 0, 0}
 	};
 
 	opterr = 0;
-	c = getopt_long(argc, argv, "", long_options, NULL);
+	c = getopt_long(argc, argv, "c:", long_options, NULL);
 
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
2.51.1

