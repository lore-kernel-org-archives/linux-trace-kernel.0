Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4086C2FD1AA;
	Tue, 12 Aug 2025 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755019330; cv=none; b=hkQStONbnWKHlio/8G9HPAHDk7Ck1KttNSw4Y7hogncspmkAk5Dz377yeVlv62VfE6lMjWcy5G+4lCpQxdi2nioUnvwBXsPS34REHj1V0LEPf0brWXzWjqhPiMVJ4HfEoJ/NAKf4wCn2ikPIAzEW9bq0X5tq5bH0RarelAyIBq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755019330; c=relaxed/simple;
	bh=R2TiB1H9am4ZuJpz1fMyadvItK5KVaKH0hEND1XCnsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiw7PYciT0/m8J22dwbpvhbxiNE78M9wLfKkB3dgzPb9+IdMYYAXorVUscCl+H78KHmrAHUOAUvVW3f6xz21AsDMBMD9tYoBnuaAqu8atEAvczNBCQS8Y8d5YUN5sW3+dXWmq4u78GHdDOfYgGh3Ly/x3HixRCsUqRE1ovB3F4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcX6D00F; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcX6D00F"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e841c71aa3so340239085a.2;
        Tue, 12 Aug 2025 10:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755019328; x=1755624128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEUVJaHvM44bvPB8en9gf1PVf9ZiWlysLR/X0mgOrR0=;
        b=jcX6D00FReRSQPLXfbM+u/aH6RqnJjwYwSYByX5JeUxZ7ejSwi0s49Ud9gnO4S36ng
         7bUYEVWcBIGdeLgXrCU5L1mcXPBZDe4MnF4Y8GLu2+pJA8BU5eGFRkrVk5WCAyUOkSdF
         3njBwLN0alBwC38ta9Dc3ik68t9zdeNMZTQmSBLiG/mT2hpPJgXU6/ETuLtDFbQMMSt9
         +2fCdTFT8fPscK32aA7qirrCZrwm+h5oH7P6fbx8UQp9HmocjjJLKTvEX40g84jUsvPB
         UHwIqjrXWI+kK8+zyW6K8WKAywEQjSogT5yB4MY9RZQ25vy1CKqEwHcjVCWwhwWF39gc
         EO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755019328; x=1755624128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEUVJaHvM44bvPB8en9gf1PVf9ZiWlysLR/X0mgOrR0=;
        b=sldwM1wXmeijlb2q2l8stfR0I+YR8cT1yXbsR8O62dt27/fkZI1N/tu+wiXDvAE1CL
         GzohSyp4CIuWW5yPGM/9wTplN+OknUlmwALnUvXM5Sjf6GEYld8Lbs2lbb7Ov/ydFToE
         0rgXVqqPNMINjCVzOy7C3/8Y8gLZhVxN015y2YN+Fhk815bPpTGGrAh9AkuLmRb/qWX0
         qa/COLaZ32zDKNndpMnGOUqfvs7kg24i8f/0R01Ji0iVXv7/Op0K5Sn5fy7HEyoXc9hS
         5TvHRk9eyB+xO0sSJ1HZRLXXaz6O0UqFh/UmE0+rtdYl9QLIrDg/UBXj/BrgbZr6EUtP
         XQfw==
X-Forwarded-Encrypted: i=1; AJvYcCUAVS4nujwZRJczxuXlvVvXLPkZzHYFE7HLjxs6bEgxax5mkLsyLp9JvcJ8sHOzNGnyW2cIWU6tY7rluy6hfbdgXKVX@vger.kernel.org, AJvYcCVHQqZ1sP18YF8pZJScrv6wNEITkxrZEJH+PPUSc78/WSMs1k6VVe9LOLh/yc4ZBeimz3QEN4SC0KQ=@vger.kernel.org, AJvYcCXsWreOUe4lG0227yCkGd4zKcYyoWwu9AR/oXPqWTijY4yPnhKbaldFNICDcO2FX8ZObBJ7kJPCvrG3Jp4o@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/YVnOmlvpe+hLa0iQcKtj1Q7tDl5+jLIR3ZK5m74dRCX9QKhv
	hl18FNiBZ7f8emPyxTxFp5CruMSphbZtZEBy7sm0FqDs3OEdrlySNp4y
X-Gm-Gg: ASbGncskofbY3PuKbxCxu5Xst6h71kAonDuln7xgVVdHBkuMeXSqtMDRf98mPECHI3K
	2EKRwO9oa8sk2YOvEbMbpbTyc3dJnTyH1oe0AVbZbaAU/ydlXYgb43xbBOTBMv1F+mtTSn58Yod
	T12bvysYI5KTITFsHHoAByAGtvUiKj9qYkBTlNxJG5PFgMjO89SUDq/1gJHIq7Vijct9gj3gC/k
	3hlMx9E+9M6VOneCG2NnByLXWIOq8Iu5g9AqUBuNw+E/QjDxdXrl+Ys+uw7girKPr7u/j270NTJ
	h2aM9wtTjz674IsxmspKgu06ugSRdvDMNpNKVQK4pVnmRNyIRO7+UNZM/zeiM8I3SmQLsWo95Zx
	mPhlw0X6UnDSRejzGDrN9DzC72ud1M8z9/aOBqYvtnZ3+BfPDd4PcN4WfxN1OjQ5dIU0ZeC5Jo3
	CAjthWFQFL+cxj
X-Google-Smtp-Source: AGHT+IGvse4bfdU5DzZnHf9+yvgLrC++fKXcXrALaIaqHFG3dy0JHw8SIiQDSBDahRlCsazhY+Q1ZA==
X-Received: by 2002:a05:620a:ac19:b0:7e6:9285:9909 with SMTP id af79cd13be357-7e864593126mr58553485a.35.1755019328058;
        Tue, 12 Aug 2025 10:22:08 -0700 (PDT)
Received: from ipravd-Nitro-AN515-55.mynetworksettings.com ([2600:4040:530f:f000:a841:61f7:aa1f:bc8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e82a1ccbfesm863457285a.51.2025.08.12.10.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:22:07 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: rostedt@goodmis.org,
	corbet@lwn.net,
	tglozar@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>
Subject: [PATCH v2 3/3] rtla: fix -a overriding -t argument
Date: Tue, 12 Aug 2025 13:21:11 -0400
Message-ID: <96f305f622de233c28d4ed9f23583b4d6ab2d1ac.1755018581.git.ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1755018581.git.ipravdin.official@gmail.com>
References: <cover.1755018581.git.ipravdin.official@gmail.com>
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

Remove clear_terminal in timerlat top as it removes "Saving trace to <filename>"
line from the terminal and is not used in other modes.

Fixes: 173a3b014827 ("rtla/timerlat: Add the automatic trace option")
Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
---
 tools/tracing/rtla/src/osnoise_hist.c  |  8 +++++---
 tools/tracing/rtla/src/osnoise_top.c   |  8 +++++---
 tools/tracing/rtla/src/timerlat_hist.c |  8 +++++---
 tools/tracing/rtla/src/timerlat_top.c  | 20 +++++---------------
 4 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 298640d92434..53655bccbbad 100644
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
@@ -640,10 +641,11 @@ static struct osnoise_params
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
index 70924242bcdd..db61a0c970e9 100644
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
@@ -470,10 +471,11 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
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
index 2a48a076d941..123b7f89f80a 100644
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
@@ -972,10 +973,11 @@ static struct timerlat_params
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
index e45d9978744c..4d7c3d74ac50 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -423,15 +423,6 @@ timerlat_top_print_sum(struct osnoise_tool *top, struct timerlat_top_cpu *summar
 	}
 }
 
-/*
- * clear_terminal - clears the output terminal
- */
-static void clear_terminal(struct trace_seq *seq)
-{
-	if (!config_debug)
-		trace_seq_printf(seq, "\033c");
-}
-
 /*
  * timerlat_print_stats - print data for all cpus
  */
@@ -449,9 +440,6 @@ timerlat_print_stats(struct timerlat_params *params, struct osnoise_tool *top)
 	if (nr_cpus == -1)
 		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
-	if (!params->quiet)
-		clear_terminal(trace->seq);
-
 	timerlat_top_reset_sum(&summary);
 
 	timerlat_top_header(params, top);
@@ -625,7 +613,8 @@ static struct timerlat_params
 			params->print_stack = auto_thresh;
 
 			/* set trace */
-			trace_output = "timerlat_trace.txt";
+			if (!trace_output)
+				trace_output = "timerlat_trace.txt";
 
 			break;
 		case '5':
@@ -729,10 +718,11 @@ static struct timerlat_params
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

