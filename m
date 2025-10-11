Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7E62367CF
	for <linux-trace-kernel@vger.kernel.org>; Sat, 11 Oct 2025 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760171317; cv=none; b=lRzgMszDD30UACIWvdJYSH07aZculn3p09Oi0vfV3C7DF3xzc2scs1Y32tP3ymsykjC1pgxNyYY+iaprGz/K0QjK3fM1yz86Nq5GUMTMsfe7W0RJWGF+7pCeFMlU8jb7jTzGq584fYjhmbz/Ubb6rD8SKP3WFUvVh1Kb4EG3s6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760171317; c=relaxed/simple;
	bh=jRcrQx61y9kXssdrhnsAAhEbZBbsrGaVtE/xowsZG3U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=iwyyP3UeC1AVPsnnllI6O3y70bngt5ONb26X3ItjC/f1T0Wra7ldd0PZiha8v6AAvVDbqZu0CsJ6NzFKMRWODfIbzLljDsowJ0yu5hOXIPzayGaDSKTCQlfZkfI4VMJ1dEnX6M2acmeLQ+PbPrAQ+3ZbCNa4o2sW0gQG5AW8iwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hYLvFn67; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYLvFn67"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760171311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=izEDGnACaGb+UE+AiB6Iu8Q3+pibeALVxmn3zVNoFFk=;
	b=hYLvFn67HplmdN7x0BxQ49pPV3/aqOge6giPJEYhfSSyVzbNlZbjS5+pGt2cDJmKQkybsv
	MaWB9jv1kG1qrtI227CtEDo847dDsoCUjI29Cvp43qNSQEF1eUwisuxl74VCQBP9dur+jA
	vgWYopaSwX51lBxNMtiSTZRCIZ1+sag=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-Aw35Q-ayNmOzgS9P4em_RA-1; Sat, 11 Oct 2025 04:28:29 -0400
X-MC-Unique: Aw35Q-ayNmOzgS9P4em_RA-1
X-Mimecast-MFC-AGG-ID: Aw35Q-ayNmOzgS9P4em_RA_1760171308
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ecdd80ea44so2279668f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 11 Oct 2025 01:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760171308; x=1760776108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izEDGnACaGb+UE+AiB6Iu8Q3+pibeALVxmn3zVNoFFk=;
        b=VO/cTacvV60eHm9Tvrw7b74YMA467eJvwZ1tkDNZjhP0iJqi8PFFqip/vKIv8/+pY+
         P4sj7DGULmqUXAG0S/Fh1C9o/VAQtJ58eVn7ZG1+PSnh+FH6aX7oq7O69Kax/cw9nPYg
         5/znXJJqJkh+P7Z7rX3fEGqqp2TZlAzRMnwEWFEz5TPjq9LZDk9sezI0R0PJTH8Ujj0e
         LGg3LWsh6cUP5CPdLxoMQNMc98a4/gdeP2SbaI+64qrGg9UYrWmCZEhyoTapPw7nuaCG
         BLgy3S0CXWRX2mlZ5i0NWpEF+kWIdPGapNWCF4dlt2w0Cdcze6h0LmZkzTKZ2w0hJkY6
         9mxg==
X-Forwarded-Encrypted: i=1; AJvYcCVPSo2g4U2Al6aHO0TSFYvT8KPG43YAejEutjy5L1vmqrize6MvX/N8a0QXrD1RrTMcLLKY9wujaN9fa+MNr0vcJsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7AKpo+imhUj81KgCf7/l1LpZ/CYuhQEIu1MHfjl/VwvA3vVLm
	9R/8TbUPUGSxCjKXHKKPlrY8U194EVcyXSBM0IAXk1xdwdhRFrIEGOXJeJ1jubYyyIieBTEO1wi
	V/38+uAnQuAFV94XI11DOHFl3XFSPoPka8kMQA+/R4l+aktz1pyu+0grZ/KYZpNZez97L/vozFg
	==
X-Gm-Gg: ASbGncuOPsBaLNz23u8YEDJHFm9dhDYZxIeK+omFzHsZsNXdxOD+AsMM0m37PzR0veZ
	kQaDRyJY5p/41YEj1+N3gZ2UmO26NwEerOk0A/HowC4F5sEq1pN2BoJu3LmDFGBFZ2I3c3ixPsX
	cHOmJ3+xLdtMuS3Tel54sQ2dWgFK1bxMeQSRpE28PenY2decKtmsQjzYLzcvEi6zWeWoXSL3TJH
	XOONryPQxAAHp4SisNGPhQwcXWmh+0wWdGqnR1nnZFEpAVWrRk6T29RsmrZJW5997V+jR7oFHNf
	fZzvET5mbbaIuFh8VhNqU6JkYIKagkeAsxwca1dN1YOc
X-Received: by 2002:a05:6000:2f86:b0:404:2fe4:3a80 with SMTP id ffacd0b85a97d-425829ee8c7mr11070494f8f.25.1760171308263;
        Sat, 11 Oct 2025 01:28:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6+EqJMpQvaelkIXVEWLlIUO2XxTYtzFkl/y1HXogC30uU15snwvq85P0+PcPFAzDMeu1IWA==
X-Received: by 2002:a05:6000:2f86:b0:404:2fe4:3a80 with SMTP id ffacd0b85a97d-425829ee8c7mr11070479f8f.25.1760171307888;
        Sat, 11 Oct 2025 01:28:27 -0700 (PDT)
Received: from localhost ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d0006sm8022580f8f.34.2025.10.11.01.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 01:28:27 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] tools/rtla: Replace osnoise_top_usage("...") with fatal("...")
Date: Sat, 11 Oct 2025 11:27:37 +0300
Message-ID: <20251011082738.173670-5-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251011082738.173670-1-costa.shul@redhat.com>
References: <20251011082738.173670-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zjbd1Z_x-0FvL2TjtkHERGdHQl6SYwuURJD6E-2WcPM_1760171308
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

Changes since v1:
- fatal() prints "\n" insteasd of caller as suggested Crystal Wood
---
 tools/tracing/rtla/src/osnoise_top.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 87f282e8c145..f0782c5ed0b1 100644
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
+				fatal("Invalid -c cpu list");
 			params->common.cpus = optarg;
 			break;
 		case 'C':
@@ -422,7 +416,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		case 'd':
 			params->common.duration = parse_seconds_duration(optarg);
 			if (!params->common.duration)
-				osnoise_top_usage(params, "Invalid -d duration\n");
+				fatal("Invalid -d duration");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
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
+				fatal("Period longer than 10 s");
 			break;
 		case 'P':
 			retval = parse_prio(optarg, &params->common.sched_param);
 			if (retval == -1)
-				osnoise_top_usage(params, "Invalid -P priority");
+				fatal("Invalid -P priority");
 			params->common.set_sched = 1;
 			break;
 		case 'q':
@@ -461,7 +455,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		case 'r':
 			params->runtime = get_llong_from_str(optarg);
 			if (params->runtime < 100)
-				osnoise_top_usage(params, "Runtime shorter than 100 us\n");
+				fatal("Runtime shorter than 100 us");
 			break;
 		case 's':
 			params->common.stop_us = get_llong_from_str(optarg);
@@ -489,7 +483,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 				if (retval)
 					fatal("Error adding trigger %s", optarg);
 			} else {
-				osnoise_top_usage(params, "--trigger requires a previous -e\n");
+				fatal("--trigger requires a previous -e");
 			}
 			break;
 		case '1': /* filter */
@@ -498,7 +492,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 				if (retval)
 					fatal("Error adding filter %s", optarg);
 			} else {
-				osnoise_top_usage(params, "--filter requires a previous -e\n");
+				fatal("--filter requires a previous -e");
 			}
 			break;
 		case '2':
@@ -520,7 +514,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 				fatal("Invalid action %s", optarg);
 			break;
 		default:
-			osnoise_top_usage(params, "Invalid option");
+			fatal("Invalid option");
 		}
 	}
 
-- 
2.51.0

