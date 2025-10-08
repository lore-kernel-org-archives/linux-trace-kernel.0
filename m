Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C5429B8E1
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Oct 2025 20:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759953606; cv=none; b=Vs9grPfFxd1X7QR+EvIX3z848pTYHCdHIXLb+4/Q3mT4FhJ8+Wq6O+rpK4CP9TN1Y7WnmPA6EPY+1Dn80gwCX0yfikfsbrgrmVAWGGmbPE4XF2EX8o5ddrBkJW2quSDZVLZSmuVLaulezq+tWN0geZR0taiJOs9sObvp7WnHP1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759953606; c=relaxed/simple;
	bh=TqWu55z+5wYc6F+NJ10bIT+HOTq+7ULpdasuP+yIBq8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=O/BZyotq4An1lKWV8DAOPYpQtn1BGJ/ayRKYxr/ne4V2tbrDR9dtRbx/47Ln9J1GPKpTZgoxcECHg8KEE13+UQ1MLK+Egyek3fNOoVtVLzEC71tAcZmyO4nlB6B7eVqjxqBVsAY6wuHV5UOh1rkDVfR07bcVlUiobrjTqfub//k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OGU0jsXi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGU0jsXi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759953603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=II5hn3aPlMfjpXnd9vhycCVPNkV61JFwnfuK1k3g2ms=;
	b=OGU0jsXisUHYabpfmSbKRI79fQgthN6brzSUCwdrqsVSKRaAEfe0aLC9eh5h67fAXSkas+
	2wzVlfhsJ7sKwTiYqMKb5QQhGfwenOw6qjtBx1yG8MU97H1XZWu65E4WRjrL3YlUUI6CuT
	MuRJV6kXy8RwAA8Vlr1pzzoNDIX0PN4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-3OUC_F-QP6-boh9V9mx6Fg-1; Wed, 08 Oct 2025 16:00:02 -0400
X-MC-Unique: 3OUC_F-QP6-boh9V9mx6Fg-1
X-Mimecast-MFC-AGG-ID: 3OUC_F-QP6-boh9V9mx6Fg_1759953601
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e47d14dceso1251865e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Oct 2025 13:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759953601; x=1760558401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=II5hn3aPlMfjpXnd9vhycCVPNkV61JFwnfuK1k3g2ms=;
        b=GZJbL348HmigigUn7w2tp2GzaPwi+Y5oZh+RA2X8oobXG55PHy/hnFtOAD/jsYFKjV
         yuXjtSdq3azYwIMXCHEr6sZQuyKQuwXPQcF4N5Y0JI2jYPh7oOBOk0mtEq4WMCTJITmK
         Ar/rOwKI2Z7KvR9EOZgZm2L/b1HSfcMUTPM19q5EQrveJOupR3eZRvGP9cw36lkPU17L
         u6gqxqv0LnGbmo4lLqFpwE1C8grCa0FB1U4H0QQGfv1LIVtXZAPSQPdq1FROh5ShD4gO
         n9zzCc7COFkbDOjoSQ+/8+BTqOFvUEqAlWX9mD32KnpM0GXQXytNJt4l164QFrmk25bO
         X7AQ==
X-Forwarded-Encrypted: i=1; AJvYcCViOWJLWnH2pDey3gzx/W4zWjbmBUJEqQb2YAdgDs3PiQyxWo5TVbuFG4ywS7WF7V/uUsXK4TD2rokoRTXR+AU7qlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaAFLWRYRQgYOLOxCsZ4tymaevnFj3/yqdVOS0ETpgRSCwzEBr
	sGqe+pV2sqd732aT6Y/U8hpVbX3yVaXhP4wDbknD0184NIpHs9GYa+6IspyYawYnYD6Z4CjJ34g
	5b52qFOP3Bn29KKPK23gPVZm1o3K8a98jNFl9ihRrLzkD1QjUmMM+6WA5DNDWWPbZCTijQUYCkA
	==
X-Gm-Gg: ASbGncvfI2779h5pZAWwhOWJUkdR0gfMpthgydZTzmhsIsbnBule6htq7m9TIsvzziN
	1cJqMJZJ6oEY7jSt+UzP5Wpa1JB4PAnktxaju9HfHT4P9DhTVSDwWKN7InnzaVNFSyv4kqCZ+It
	/n9m0sdCJspjzQElb4l0EK2GUPA3PZmKgE7OJ7y9P6J+LnYY0ChEsnQfn4L+N8+vS7ebnaQD+Zx
	mPtZSEsuHOufbuFxznCPTYYJL18fb5S6oxN7RhwiYmd0o1z4XDgNBwz/p5cOyRG6XZQHxm9WV4d
	H9hnElVrTtUaMWweD4gfzRDf5069h9TVVrObQzrjExkXRKDRaVNQ6zUBhjrJMjE=
X-Received: by 2002:a05:600c:c0c3:20b0:46e:39ef:be77 with SMTP id 5b1f17b1804b1-46faef4161fmr8064865e9.14.1759953600711;
        Wed, 08 Oct 2025 13:00:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlxgZDNU+hfJsuo3gBuETXOFe1aN2DF1fu0vRNbtwpm+xr3TxS17m0h+/cEvx8qvo/IT5uqg==
X-Received: by 2002:a05:600c:c0c3:20b0:46e:39ef:be77 with SMTP id 5b1f17b1804b1-46faef4161fmr8064765e9.14.1759953600318;
        Wed, 08 Oct 2025 13:00:00 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8efffasm31209583f8f.41.2025.10.08.12.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 12:59:59 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Jan Stancek <jstancek@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] tools/rtla: Replace osnoise_top_usage("...") with fatal("...")
Date: Wed,  8 Oct 2025 22:59:05 +0300
Message-ID: <20251008195905.333514-6-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008195905.333514-1-costa.shul@redhat.com>
References: <20251008195905.333514-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qtfy2Wy9uO4cyMilofxoa7QHkCcJc-mWkvJIxa7c3GE_1759953601
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

A long time ago, when the usage help was short, it was a favor
to the user to show it on error. Now that the usage help has
become very long, it is too noisy to dump the complete help text
for each typo after the error message itself.

Replace osnoise_top_usage("...") with fatal("...") on errors.

Remove the already unused 'usage' argument from osnoise_top_usage().

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/osnoise_top.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 43fb50b5d936..604a068ed77f 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -257,7 +257,7 @@ osnoise_print_stats(struct osnoise_tool *top)
 /*
  * osnoise_top_usage - prints osnoise top usage message
  */
-static void osnoise_top_usage(struct osnoise_params *params, char *usage)
+static void osnoise_top_usage(struct osnoise_params *params)
 {
 	int i;
 
@@ -296,9 +296,6 @@ static void osnoise_top_usage(struct osnoise_params *params, char *usage)
 		NULL,
 	};
 
-	if (usage)
-		fprintf(stderr, "%s\n", usage);
-
 	if (params->mode == MODE_OSNOISE) {
 		fprintf(stderr,
 			"rtla osnoise top: a per-cpu summary of the OS noise (version %s)\n",
@@ -318,9 +315,6 @@ static void osnoise_top_usage(struct osnoise_params *params, char *usage)
 	for (i = 0; msg[i]; i++)
 		fprintf(stderr, "%s\n", msg[i]);
 
-	if (usage)
-		exit(EXIT_FAILURE);
-
 	exit(EXIT_SUCCESS);
 }
 
@@ -403,7 +397,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		case 'c':
 			retval = parse_cpu_set(optarg, &params->common.monitored_cpus);
 			if (retval)
-				osnoise_top_usage(params, "\nInvalid -c cpu list\n");
+				fatal("\nInvalid -c cpu list\n");
 			params->common.cpus = optarg;
 			break;
 		case 'C':
@@ -422,12 +416,12 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		case 'd':
 			params->common.duration = parse_seconds_duration(optarg);
 			if (!params->common.duration)
-				osnoise_top_usage(params, "Invalid -d duration\n");
+				fatal("Invalid -d duration\n");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
 			if (!tevent)
-				fatal("Error alloc trace event");
+				fatal("Error alloc trace event\n");
 
 			if (params->common.events)
 				tevent->next = params->common.events;
@@ -436,7 +430,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 			break;
 		case 'h':
 		case '?':
-			osnoise_top_usage(params, NULL);
+			osnoise_top_usage(params);
 			break;
 		case 'H':
 			params->common.hk_cpus = 1;
@@ -447,12 +441,12 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		case 'p':
 			params->period = get_llong_from_str(optarg);
 			if (params->period > 10000000)
-				osnoise_top_usage(params, "Period longer than 10 s\n");
+				fatal("Period longer than 10 s\n");
 			break;
 		case 'P':
 			retval = parse_prio(optarg, &params->common.sched_param);
 			if (retval == -1)
-				osnoise_top_usage(params, "Invalid -P priority");
+				fatal("Invalid -P priority\n");
 			params->common.set_sched = 1;
 			break;
 		case 'q':
@@ -461,7 +455,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		case 'r':
 			params->runtime = get_llong_from_str(optarg);
 			if (params->runtime < 100)
-				osnoise_top_usage(params, "Runtime shorter than 100 us\n");
+				fatal("Runtime shorter than 100 us\n");
 			break;
 		case 's':
 			params->common.stop_us = get_llong_from_str(optarg);
@@ -489,7 +483,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 				if (retval)
 					fatal("Error adding trigger %s\n", optarg);
 			} else {
-				osnoise_top_usage(params, "--trigger requires a previous -e\n");
+				fatal("--trigger requires a previous -e\n");
 			}
 			break;
 		case '1': /* filter */
@@ -498,7 +492,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 				if (retval)
 					fatal("Error adding filter %s\n", optarg);
 			} else {
-				osnoise_top_usage(params, "--filter requires a previous -e\n");
+				fatal("--filter requires a previous -e\n");
 			}
 			break;
 		case '2':
@@ -520,7 +514,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 				fatal("Invalid action %s\n", optarg);
 			break;
 		default:
-			osnoise_top_usage(params, "Invalid option");
+			fatal("Invalid option\n");
 		}
 	}
 
-- 
2.51.0

