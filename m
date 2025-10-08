Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E3F28D82A
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Oct 2025 20:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759953603; cv=none; b=dqdW1FDL4HcprfG74C646Dj7re3nFKXUfvIbd7xeA1aDqYhGjJRBZ/m6cvRctQ97914rylbYUawZBVR/3QOhG6oJblUWepOATjLQduXP0aa5Km+5BYI9iqEWS1zaV2lB41SW6ynyBGTVLiqzv+OpkO1stNXQxBEWGNpcs37zQlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759953603; c=relaxed/simple;
	bh=YxZxGVPgrbcUQf05HaafiT1TjMGPobJaNf5XRQb6JKU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=RJC64N7Q7LsyqVDtIqja3PPV9YfV4X69fdQ5JwtWB/nly+4Ov6tShH6PSFw+73AWq1zrA31WpXpjzwbF+iSJH4Fcv06vlEGVGvv4Eify2cnFn00Vld2/PSG7iE5dM5aJMZuzPdiUN9yEhxi8UE+dYKhdANO+F2KvIRLzG2ormKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h36lys2u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h36lys2u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759953601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hg94taPX5CGEY2YLQCYWgTJzRNpALaMB5K0LUWzUztM=;
	b=h36lys2uX8Gz6l+pQKay3ntP4G0ZDHk+LzQuaxETVx7NlIgMt5am/i78+NJBudam1xPVgp
	ogKYkpSpalQp2rKIG+rxNYv27Xl3pz0S0vBfaSmoPtWma/3RSEwY7tW8UAYwoPTx9gv6jc
	tsbmUyzHTRyjD7zmCB7oW9Wbow2bats=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-2xMKWyF3NHS5lMY6kpBdAQ-1; Wed, 08 Oct 2025 15:59:58 -0400
X-MC-Unique: 2xMKWyF3NHS5lMY6kpBdAQ-1
X-Mimecast-MFC-AGG-ID: 2xMKWyF3NHS5lMY6kpBdAQ_1759953597
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3f384f10762so221351f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759953597; x=1760558397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hg94taPX5CGEY2YLQCYWgTJzRNpALaMB5K0LUWzUztM=;
        b=XSqFV9Bws0MJvS+oSGLixSRL24IAMpGQtfUlrJx4lgz6vFh2biWxyv+mvC4zduLO7g
         5x2a4F+m594Lwdbp4ohFnSVPh6qLLWzW8aYNgOaYHpS+nPh7mW7QxwT6VDkQl1XWA9Nm
         UX3IXD2J9kXAfpFdC3dYnf3aFkz2wb8e5diyHhigdBB2PT4kW/6tLEr7DKTq2+BH9H/f
         7v8s8+j37jilkUy7r/Irkhv/tr//RH5v+1KvlWUXkyzcFUm9zZLHBrIrKzm8NCB3xwbX
         qiOQZARVo3d/nzNOAXvAhCk84mSIMP8ae7Ob+QM+sGAyCR15cQ0cKa7RwjL4bTXSLyGN
         OMQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2Yyw6B3viPOjh44zc97g0fNTRdSiy+nnoHS0E2Y0l4THorkA38xTRyBK/hVDXMJVyxQhl1Fbv7R8/CRHNOIgW2L8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLh7SXnrpyYgVA+CrZg9n0mHaQe/XidnTGIDmRmleOxNzekzMm
	iSwXB9zpluHW7DakUT8YjsXDwgoi9qhNb2KPhDCDj4A5MDWQ7/I6YzrCh2gpWiPyaWFfnn60Ut2
	Qy6FYOvGaXaftuzv0ek7XEOmTaiIXzIQJ/yhP5/JUkzZI633709vkyOV+gutelYP9YCqNHF03ug
	==
X-Gm-Gg: ASbGncvCkfMKFKpzFB4G78sdPdIX8y+GgGqUyBqpivq41ANy1gWByeEz+pEf7zx751r
	Z92Jh3pCHUzBeJ63dfARKMMZv7E8u4ievHQSlwHYMIYkTnYJTs4bXGd467bHBeYlZSrOqfT6NY5
	CByN0Gm7UPJ8V5rIZD+ve1u9K/o47ITgMHb36gGWMQY2DB9fLNCfj/roEirKxTg+slSuVk4n77r
	KbM5ZQrZVdfC+qjZwVCkdsS0ZzqMpZLrgiEr6UfkAKt5Ezt5A10Twu/dJdvAU06K5duHGK7hRga
	2lZpVzyCFncUFBuAT/BYz3GDwiH/YqAS+I/mPoDGqFvGziSF2gMU07Cfy54Fdqc=
X-Received: by 2002:a05:6000:1862:b0:3e7:492f:72b4 with SMTP id ffacd0b85a97d-4266e7df7f7mr3015744f8f.42.1759953596833;
        Wed, 08 Oct 2025 12:59:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0dEKdVVbbefPxraYSKbfgy6wGcFkOVkvZ4hpJR6iApWTuCQJvWeYWquxXyKMzAk9ArVEwTQ==
X-Received: by 2002:a05:6000:1862:b0:3e7:492f:72b4 with SMTP id ffacd0b85a97d-4266e7df7f7mr3015729f8f.42.1759953596310;
        Wed, 08 Oct 2025 12:59:56 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8efffasm31209583f8f.41.2025.10.08.12.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 12:59:55 -0700 (PDT)
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
Subject: [PATCH v1 4/5] tools/rtla: Replace osnoise_hist_usage("...") with fatal("...")
Date: Wed,  8 Oct 2025 22:59:04 +0300
Message-ID: <20251008195905.333514-5-costa.shul@redhat.com>
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
X-Mimecast-MFC-PROC-ID: nxSH142UvqFFP-QpIfdzf6K0ro4hg2vtKnpJ1tD0kmo_1759953597
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

A long time ago, when the usage help was short, it was a favor
to the user to show it on error. Now that the usage help has
become very long, it is too noisy to dump the complete help text
for each typo after the error message itself.

Replace osnoise_hist_usage("...") with fatal("...") on errors.

Remove the already unused 'usage' argument from osnoise_hist_usage().

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/osnoise_hist.c | 34 +++++++++++----------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 43c323521f55..3c4d8e25fd55 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -421,7 +421,7 @@ osnoise_print_stats(struct osnoise_tool *tool)
 /*
  * osnoise_hist_usage - prints osnoise hist usage message
  */
-static void osnoise_hist_usage(char *usage)
+static void osnoise_hist_usage(void)
 {
 	int i;
 
@@ -467,18 +467,12 @@ static void osnoise_hist_usage(char *usage)
 		NULL,
 	};
 
-	if (usage)
-		fprintf(stderr, "%s\n", usage);
-
 	fprintf(stderr, "rtla osnoise hist: a per-cpu histogram of the OS noise (version %s)\n",
 			VERSION);
 
 	for (i = 0; msg[i]; i++)
 		fprintf(stderr, "%s\n", msg[i]);
 
-	if (usage)
-		exit(EXIT_FAILURE);
-
 	exit(EXIT_SUCCESS);
 }
 
@@ -564,12 +558,12 @@ static struct common_params
 			params->common.hist.bucket_size = get_llong_from_str(optarg);
 			if (params->common.hist.bucket_size == 0 ||
 			    params->common.hist.bucket_size >= 1000000)
-				osnoise_hist_usage("Bucket size needs to be > 0 and <= 1000000\n");
+				fatal("Bucket size needs to be > 0 and <= 1000000\n");
 			break;
 		case 'c':
 			retval = parse_cpu_set(optarg, &params->common.monitored_cpus);
 			if (retval)
-				osnoise_hist_usage("\nInvalid -c cpu list\n");
+				fatal("\nInvalid -c cpu list\n");
 			params->common.cpus = optarg;
 			break;
 		case 'C':
@@ -588,12 +582,12 @@ static struct common_params
 		case 'd':
 			params->common.duration = parse_seconds_duration(optarg);
 			if (!params->common.duration)
-				osnoise_hist_usage("Invalid -D duration\n");
+				fatal("Invalid -D duration\n");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
 			if (!tevent)
-				fatal("Error alloc trace event");
+				fatal("Error alloc trace event\n");
 
 			if (params->common.events)
 				tevent->next = params->common.events;
@@ -604,11 +598,11 @@ static struct common_params
 			params->common.hist.entries = get_llong_from_str(optarg);
 			if (params->common.hist.entries < 10 ||
 			    params->common.hist.entries > 9999999)
-				osnoise_hist_usage("Entries must be > 10 and < 9999999\n");
+				fatal("Entries must be > 10 and < 9999999\n");
 			break;
 		case 'h':
 		case '?':
-			osnoise_hist_usage(NULL);
+			osnoise_hist_usage();
 			break;
 		case 'H':
 			params->common.hk_cpus = 1;
@@ -619,18 +613,18 @@ static struct common_params
 		case 'p':
 			params->period = get_llong_from_str(optarg);
 			if (params->period > 10000000)
-				osnoise_hist_usage("Period longer than 10 s\n");
+				fatal("Period longer than 10 s\n");
 			break;
 		case 'P':
 			retval = parse_prio(optarg, &params->common.sched_param);
 			if (retval == -1)
-				osnoise_hist_usage("Invalid -P priority");
+				fatal("Invalid -P priority\n");
 			params->common.set_sched = 1;
 			break;
 		case 'r':
 			params->runtime = get_llong_from_str(optarg);
 			if (params->runtime < 100)
-				osnoise_hist_usage("Runtime shorter than 100 us\n");
+				fatal("Runtime shorter than 100 us\n");
 			break;
 		case 's':
 			params->common.stop_us = get_llong_from_str(optarg);
@@ -670,7 +664,7 @@ static struct common_params
 				if (retval)
 					fatal("Error adding trigger %s\n", optarg);
 			} else {
-				osnoise_hist_usage("--trigger requires a previous -e\n");
+				fatal("--trigger requires a previous -e\n");
 			}
 			break;
 		case '5': /* filter */
@@ -679,7 +673,7 @@ static struct common_params
 				if (retval)
 					fatal("Error adding filter %s\n", optarg);
 			} else {
-				osnoise_hist_usage("--filter requires a previous -e\n");
+				fatal("--filter requires a previous -e\n");
 			}
 			break;
 		case '6':
@@ -701,7 +695,7 @@ static struct common_params
 				fatal("Invalid action %s\n", optarg);
 			break;
 		default:
-			osnoise_hist_usage("Invalid option");
+			fatal("Invalid option\n");
 		}
 	}
 
@@ -712,7 +706,7 @@ static struct common_params
 		fatal("rtla needs root permission\n");
 
 	if (params->common.hist.no_index && !params->common.hist.with_zeros)
-		osnoise_hist_usage("no-index set and with-zeros not set - it does not make sense");
+		fatal("no-index set and with-zeros not set - it does not make sense\n");
 
 	return &params->common;
 }
-- 
2.51.0

