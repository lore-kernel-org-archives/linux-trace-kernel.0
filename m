Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888C02F90FA;
	Tue, 12 Aug 2025 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016082; cv=none; b=mWlr0iox09OMSfP+iCqsWIjitjBF1YS92eyon05BwlzmwrOOJyMk9SQJxiOWohkeDdUPvX5YgVkQzSYNqZCphWRpHTe3uKssF6y6CqVuQrwvnYQ6hz2pl3RYkaLKyXfLUwYzXoO+YBLVp+zqZcS78i0BzKePfrfz0+/ez/9v4tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016082; c=relaxed/simple;
	bh=aaRlaMnKQF/KXaTUudMGeFyfuROIytQq19mkqMGgYyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mcowtjQGFJUojsuu5E2DCUBjWvq8VJBFTFKGB7SwiZJTFw4WyDIcfTOfa2vR8iCOTpRyYwp6nEamR4KIXoXm6lyuNjOf1wiwEmO8b8Y1/5/g4IYiSPQjCfSQgeJUD553ngtGp6AeA7/2LsnMusobDDC0AUXK1vbw3FACzHTpNyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xe6qedDz; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xe6qedDz"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e6696eb47bso559695585a.3;
        Tue, 12 Aug 2025 09:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755016079; x=1755620879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rLm2lrFLTZGd2gYNfqFFy1afCQreKJUHVchLm6m9Xo=;
        b=Xe6qedDzA5kelivDAznTzxujAjQ8SWeZeRJScwIiJxi87j73sSIjw7ZtZuj+Kyvvw6
         aLkUMmTtOUogU0UF9mUO1PQbFTDcVxotXas2sXrjM6yFVr8keRVGLBczsI4dcNujItp8
         bx3LoW3k2JNY0oKyKC8rDCqvBQE7Rahhon1hM8R9v5AXeIAKRNNtI7T0SbAolEvg4TjA
         yU/dWGxzFzodLde+QzZUKs9TYm8A1EmWJXAXiQx9PcR2TjABQgYb6ouEMudPXHfuPQth
         CWFPbUnKUdFVHQ961AtF47FA7HwCGoM72GdjluRWrkTEC3KBP23DTl5yFLHS1BoZFXfu
         1KVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755016079; x=1755620879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rLm2lrFLTZGd2gYNfqFFy1afCQreKJUHVchLm6m9Xo=;
        b=uhS9FETTWW2gMwX4MbS3/d4GvMiEVdxGBQMMMXysdBGwyi1UIAnZp6NpOAvInTyGJH
         Yek2o7Wc8siUrx1RWS2nOqkUXM+xuZ/0rBTKzHLO9MgDk4WxVmp3NQSGdfyHykvKbYJ0
         aHKVwnYR0h52+BtLM7gG/LSq692YXpBDEUo1XmnvwGsiqLZd58k4MJBlMEgH/RR7Uk57
         WwPkgTlaxuMvbWb2TMiob8dBxanpXCxIvI58LT23EGQ3d1ydKbxgqXFUOMN2HZOaTwbN
         2k5G2QcnoK/Tmm9p0q+PEjqXQRyTQEWsNv3K1HeQb/5TEQVXefUtUuoW0NVHbR+RmYXH
         5s7g==
X-Forwarded-Encrypted: i=1; AJvYcCUMUKpeWzRf6sl0CZbeDJBXhOGosbxbbRa6QqD6EISnTna5Y1VANIT++Wr0uKpWGCcnj4JWVICZSL46R6+U@vger.kernel.org, AJvYcCV95o9KkCu+sLoFyzSz2nrcSM0aU1A0xvHqKnI73rXo9oN03zWI9hgBp3jYheL68q1ppYxyGuXsyEWa7NCoRcBGd5Au@vger.kernel.org, AJvYcCWwEkxoCTjSx+KGmNR36LyJc6d2OXOKbc9hl7K4ul9jiSPAkkPTeVcSJvaiuOw7f0fl6BFiBOhWHRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM+zpqZymVaWPnEUc7VsuCq8VtBPoKNFsDD6MsmROB5SwcOdAA
	q28jBactKeV8egDD4xHqmA3O5VH89+77qsJbj6SbvKe68uyDBp16YCHm
X-Gm-Gg: ASbGncvNv5qBaAGHqNKl+J978sSniYV2ELQ7OiTi2cbz6MG0kzIBIoQ4ynR2LRGY9PO
	j+P7+Kidb4ld22Ff83Dn8Q5br+ItWVxCSIdy8C/YS5hMSVEtTKdM7T7tnqKyN4jUFStpl5vyVfY
	mIGG23/HV93fIUANSCx3xoDxyRq5ByAanokIxBUmfJlW2Ke5j+RtK3E4AeUSrfwbzPu3od9B889
	s8mQNPXqkItsPdzA/xGynXgHLB554UBHY3gtBF3gI5qP6uBP+Wk3sjmaH31AS75tHbceFYXkKdT
	zm9x+wYrxAH8+7QMO0ZuhVe2/94sPDjLcMMVPs5CB/nJwEjlC9OEkohw+EK62vqc9rPxOOuttK4
	Tn9Q7UPvx7fnmxUjw1O7Evxm+oy3t3hg6oWKzbxdfhW4tGgwj/5bxbKa7WimHP01DN9B2C3iBNv
	ec3U266YVn4cF7
X-Google-Smtp-Source: AGHT+IFo1JdEFRG0OuDkT3+aosw6jrG0ZodoETEdSk81Gszj9XVoky2dkekqX9SgLI9SwZWqYjX4fQ==
X-Received: by 2002:a05:620a:aa19:b0:7c5:49b7:237c with SMTP id af79cd13be357-7e86451bef0mr37941385a.27.1755016079135;
        Tue, 12 Aug 2025 09:27:59 -0700 (PDT)
Received: from ipravd-Nitro-AN515-55.mynetworksettings.com ([2600:4040:530f:f000:a841:61f7:aa1f:bc8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e8079cfcc9sm1269013885a.29.2025.08.12.09.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 09:27:58 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: rostedt@goodmis.org,
	corbet@lwn.net,
	tglozar@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>
Subject: [PATCH 3/3] rtla: fix -a overriding -t argument
Date: Tue, 12 Aug 2025 12:27:32 -0400
Message-ID: <dc8d963c095e10e2dee093ef7f50943ad6b606d4.1755014784.git.ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1755014784.git.ipravdin.official@gmail.com>
References: <cover.1755014784.git.ipravdin.official@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running rtla as

    `rtla <timerlat|osnoise> <top|hist> -t custom_file.txt -a 100`

-a options override trace output filename specified by -t option.
Running the command above will create <timerlat|osnoise>_trace.txt file
instead of custom_file.txt. Fix this by making sure that -a option does
not override trace output filename even if it's passed after trace
output filename is specified.

Fixes: 173a3b014827 ("rtla/timerlat: Add the automatic trace option")
Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
---
 tools/tracing/rtla/src/osnoise_hist.c  | 8 +++++---
 tools/tracing/rtla/src/osnoise_top.c   | 8 +++++---
 tools/tracing/rtla/src/timerlat_hist.c | 8 +++++---
 tools/tracing/rtla/src/timerlat_top.c  | 8 +++++---
 4 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 92c379fbe030..babcd97cec66 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -543,7 +543,8 @@ static struct osnoise_params
 			params->threshold = 1;
 
 			/* set trace */
-			params->trace_output = "osnoise_trace.txt";
+			if (!params->trace_output)
+				params->trace_output = "osnoise_trace.txt";
 
 			break;
 		case 'b':
@@ -639,10 +640,11 @@ static struct osnoise_params
 					params->trace_output = &optarg[1];
 				else
 					params->trace_output = &optarg[0];
-			} else if (optind < argc && argv[optind][0] != '0')
+			} else if (optind < argc && argv[optind][0] != '0') {
 				params->trace_output = argv[optind];
-			else
+			} else {
 				params->trace_output = "osnoise_trace.txt";
+			}
 			break;
 		case '0': /* no header */
 			params->no_header = 1;
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index d149c3c4ac11..6c1e83f7a828 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -383,7 +383,8 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 			params->threshold = 1;
 
 			/* set trace */
-			params->trace_output = "osnoise_trace.txt";
+			if (!params->trace_output)
+				params->trace_output = "osnoise_trace.txt";
 
 			break;
 		case 'c':
@@ -469,10 +470,11 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 					params->trace_output = &optarg[1];
 				else
 					params->trace_output = &optarg[0];
-			} else if (optind < argc && argv[optind][0] != '-')
+			} else if (optind < argc && argv[optind][0] != '-') {
 				params->trace_output = argv[optind];
-			else
+			} else {
 				params->trace_output = "osnoise_trace.txt";
+			}
 			break;
 		case 'T':
 			params->threshold = get_llong_from_str(optarg);
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index c397f6260054..d4f2a5f02998 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -874,7 +874,8 @@ static struct timerlat_params
 			params->print_stack = auto_thresh;
 
 			/* set trace */
-			trace_output = "timerlat_trace.txt";
+			if (!trace_output)
+				trace_output = "timerlat_trace.txt";
 
 			break;
 		case 'c':
@@ -971,10 +972,11 @@ static struct timerlat_params
 					trace_output = &optarg[1];
 				else
 					trace_output = &optarg[0];
-			} else if (optind < argc && argv[optind][0] != '-')
+			} else if (optind < argc && argv[optind][0] != '-') {
 				trace_output = argv[optind];
-			else
+			} else {
 				trace_output = "timerlat_trace.txt";
+			}
 			break;
 		case 'u':
 			params->user_workload = 1;
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 73949d52cf41..4f40e7ebde88 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -613,7 +613,8 @@ static struct timerlat_params
 			params->print_stack = auto_thresh;
 
 			/* set trace */
-			trace_output = "timerlat_trace.txt";
+			if (!trace_output)
+				trace_output = "timerlat_trace.txt";
 
 			break;
 		case '5':
@@ -716,10 +717,11 @@ static struct timerlat_params
 					trace_output = &optarg[1];
 				else
 					trace_output = &optarg[0];
-			} else if (optind < argc && argv[optind][0] != '-')
+			} else if (optind < argc && argv[optind][0] != '-') {
 				trace_output = argv[optind];
-			else
+			} else {
 				trace_output = "timerlat_trace.txt";
+			}
 			break;
 		case 'u':
 			params->user_workload = true;
-- 
2.48.1

