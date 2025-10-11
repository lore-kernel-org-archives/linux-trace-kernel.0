Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD8923C51C
	for <linux-trace-kernel@vger.kernel.org>; Sat, 11 Oct 2025 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760171319; cv=none; b=TO7SrSLNBSrGD0o+L+JJ7rsUM5cWGD0y67zzQ038BV1u4jzKaftqj1qfuRK3x46SwFven50SL9Vo5G7uiYUMz+nKQVKqn/G8Ep73WzmmDTngYm3iKNHN/8rCzexhDb2Bn38Mfd+QvMuyCd/TBpVBPzssdFu0ahVpHCYL01bS3VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760171319; c=relaxed/simple;
	bh=lMxJsTBvYIIRzV2ysIaeaApJyW/Xxwl8lAvSVzlHlhs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=LhS2U419BOYt7QpL7otDi+z4XlQgtrw2ZgmMFlBq8+jRcWSf0EilxB+Z9no+Dkx1ybNQLMDCHKiNWL3oAtdjz9PYuqLc0CXC5571TpKaNOQkAA6bAVhNSWZRT4lhjVZxuaIYWyqXPMVkJ3QyrUqKD4cro6F2tvV/qUU6WMXXum8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fM0zycJB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fM0zycJB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760171313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOj4qrsjoSEV40FZCa/GgcbP7ZbPD06dUm2Vl71DoUE=;
	b=fM0zycJBCtWmbD1mQQOId4NHouuRqcA7NHoFSSNP/muOdnh5dfxaUvek5SvvsQ5zXLQqyO
	PnMAkYapWVY6U/irJS+g7R3Zz8MAfMLLUJ+TkW2Xm2thSxs16Oo8IZwUj6sgx1Pv5QeeD0
	IJGn1UK8pLf/3BVskPO7qfogz/oC9QQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-aP3QYDz5OPC8jwBaUqsQqg-1; Sat, 11 Oct 2025 04:28:31 -0400
X-MC-Unique: aP3QYDz5OPC8jwBaUqsQqg-1
X-Mimecast-MFC-AGG-ID: aP3QYDz5OPC8jwBaUqsQqg_1760171311
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e509374dcso11260985e9.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 11 Oct 2025 01:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760171311; x=1760776111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOj4qrsjoSEV40FZCa/GgcbP7ZbPD06dUm2Vl71DoUE=;
        b=DA8wyJ/7b6CfvZKpLnu7lrGvZNHdoLGxomMObw8zLtdbrf5oP+DvMsBgkHeLX1GX3y
         dzdTDfg8j6eBMircikB49d0ppPOS6iUCSkgjRrMb9NOmJ6ThYrr/MulnP3TQlhQ7wDEN
         HrIydHx7rxMXMcj2RE9kyJn4eZB2ZOKoJpfoHzHTsJQ+pzuYf/CMiKT/9AdD8cFUJlLd
         ZoMbmNhrrz+KBdcvXARDninzFzyNhjHXeHQCvew/qh/bptYy4yZPSm3l3l/Jah14V1do
         Spsg3zlZHeYapVFfbOiaKh7SYx9RSTN2ow5LNxYlxCXHXNYATaInkvm23c8GKb3dNK/x
         rxGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZnqR0Om1syoIPSAzeWp08l3F+eirIOFautnYAhNfZeVpNTsB/GE+CI3MYlmybsAXFNztUfvN7fr05vYXHEQHB84Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8+WRLZLcDFs1Hh1FY6mX/id/S8Ri+TNhJMZ33/qBVMMhQ6Wk6
	pLgEo7vsdN2NvG/Dl4P6A5XdJI8kcMY606QnPdiVJWz+WIfTfDBneLmdbTvHtQTJ5KqwjZpsOtr
	jmZuImunNOcX3/qJ68TkfX2A6H1SESC5wmJWKyw/s/UMtZXiMLFJeAYjfLvM1usvQvo5ILHwRtA
	==
X-Gm-Gg: ASbGncskQFS+spem3okX+NrgJYDy05OEwiUAfaHzn5RgZ5LFTbyBANYF/lVYrHHNCQ6
	WJFNJffX4yXmsDpvxJjuHKFPEzCmSc42W/iavIhuvg4mymyV/6V02qx2lbcdx2ooFrWAQwCpRF8
	kFMlVrPvOvoNbUS7aNXNVFOCN283bwnD0int8c9iuAUEqJTiDNUoL2P9QAqbMNJBIq8vsBJGI7M
	P6EroXDHYcrVgvgxuCDA47iAUQVDUvh/0a3B24ULTGxw5iCTvBhwSds12p0TjjcOIJs+iIJEJMj
	0ybE42Z2Uf3IL7eHsdJI8r3gNNhIXKnojonEXuvSt1J+
X-Received: by 2002:a05:600c:5306:b0:46e:3d41:5fe7 with SMTP id 5b1f17b1804b1-46fa9afbd48mr94401185e9.29.1760171310578;
        Sat, 11 Oct 2025 01:28:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK5DqK5p00Q8fy/jT6hCAziOfIB4t7V7rJVh/6m2CXm+TH90wdKa0CBAPVz1Kvu+HBjsP2vw==
X-Received: by 2002:a05:600c:5306:b0:46e:3d41:5fe7 with SMTP id 5b1f17b1804b1-46fa9afbd48mr94400995e9.29.1760171310146;
        Sat, 11 Oct 2025 01:28:30 -0700 (PDT)
Received: from localhost ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d0006sm8022580f8f.34.2025.10.11.01.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 01:28:29 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] tools/rtla: Replace osnoise_hist_usage("...") with fatal("...")
Date: Sat, 11 Oct 2025 11:27:38 +0300
Message-ID: <20251011082738.173670-6-costa.shul@redhat.com>
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
X-Mimecast-MFC-PROC-ID: l1mmdeZBDLgbwX2UhUeMfWS60mCLk9P5e1sAwsV9Crg_1760171311
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

Changes since v1:
- fatal() prints "\n" insteasd of caller as suggested Crystal Wood
---
 tools/tracing/rtla/src/osnoise_hist.c | 32 +++++++++++----------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 31a2c9cf97f5..b0b7f04c3871 100644
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
+				fatal("Bucket size needs to be > 0 and <= 1000000");
 			break;
 		case 'c':
 			retval = parse_cpu_set(optarg, &params->common.monitored_cpus);
 			if (retval)
-				osnoise_hist_usage("\nInvalid -c cpu list\n");
+				fatal("Invalid -c cpu list");
 			params->common.cpus = optarg;
 			break;
 		case 'C':
@@ -588,7 +582,7 @@ static struct common_params
 		case 'd':
 			params->common.duration = parse_seconds_duration(optarg);
 			if (!params->common.duration)
-				osnoise_hist_usage("Invalid -D duration\n");
+				fatal("Invalid -D duration");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
@@ -604,11 +598,11 @@ static struct common_params
 			params->common.hist.entries = get_llong_from_str(optarg);
 			if (params->common.hist.entries < 10 ||
 			    params->common.hist.entries > 9999999)
-				osnoise_hist_usage("Entries must be > 10 and < 9999999\n");
+				fatal("Entries must be > 10 and < 9999999");
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
+				fatal("Period longer than 10 s");
 			break;
 		case 'P':
 			retval = parse_prio(optarg, &params->common.sched_param);
 			if (retval == -1)
-				osnoise_hist_usage("Invalid -P priority");
+				fatal("Invalid -P priority");
 			params->common.set_sched = 1;
 			break;
 		case 'r':
 			params->runtime = get_llong_from_str(optarg);
 			if (params->runtime < 100)
-				osnoise_hist_usage("Runtime shorter than 100 us\n");
+				fatal("Runtime shorter than 100 us");
 			break;
 		case 's':
 			params->common.stop_us = get_llong_from_str(optarg);
@@ -670,7 +664,7 @@ static struct common_params
 				if (retval)
 					fatal("Error adding trigger %s", optarg);
 			} else {
-				osnoise_hist_usage("--trigger requires a previous -e\n");
+				fatal("--trigger requires a previous -e");
 			}
 			break;
 		case '5': /* filter */
@@ -679,7 +673,7 @@ static struct common_params
 				if (retval)
 					fatal("Error adding filter %s", optarg);
 			} else {
-				osnoise_hist_usage("--filter requires a previous -e\n");
+				fatal("--filter requires a previous -e");
 			}
 			break;
 		case '6':
@@ -701,7 +695,7 @@ static struct common_params
 				fatal("Invalid action %s", optarg);
 			break;
 		default:
-			osnoise_hist_usage("Invalid option");
+			fatal("Invalid option");
 		}
 	}
 
@@ -712,7 +706,7 @@ static struct common_params
 		fatal("rtla needs root permission");
 
 	if (params->common.hist.no_index && !params->common.hist.with_zeros)
-		osnoise_hist_usage("no-index set and with-zeros not set - it does not make sense");
+		fatal("no-index set and with-zeros not set - it does not make sense");
 
 	return &params->common;
 }
-- 
2.51.0

