Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7CA13AA3E;
	Sat, 22 Mar 2025 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742668820; cv=none; b=Pams9eHSSovuqPYP073tb+vpgS8kLU5qHfalF3CA/62QeFRv/fRAaoJwLHwmObcrj50Tv0A7dFR9P9a6AwZzVxcGxZaqnxNauI3L7hwpCEXgaTUs5lFokCPHHQq/IxHoT5XjUP2UGM0aiKGzlmBi3LENDjJbhgVIl93B6jVqPA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742668820; c=relaxed/simple;
	bh=v3IXLPjfdjY5DazaIWNFKX52u0XISPphYLNliCnlMsA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=V9drjejmNOVS85iH90FoZGPC7OSmLHpswBkKzJTMGgYyT3qGM2/U0+ftrqg4TA5v1fCsmkfT/m38B/F9+6DdH6EKySTtdM0mzndSAU0r8B5qqjOWKHeYjy1schBwpAotHu2zwJQG3/x3dj264olwuxWq1NqTc8Poi2mk9dynHg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38f2f391864so1681741f8f.3;
        Sat, 22 Mar 2025 11:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742668816; x=1743273616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DRZDk7bvL6uYFZ1R6UFx7FmgxRahWKilPMlgJyJmggU=;
        b=StqgcDrqbb4otvEtas1QHCxzLWl6pmnAYQa/t2KXRjBqWxF2Yn4PMAbnvpFln5q+23
         YgpU5Z/u7vTq8ABdxYQOpSOArkVEDV21Yx08hPj7esSSt4BlRGGPJ9z5NUZ4VPyPAsvn
         7vNXR9xQKPCyzzQxVQT6wxhFduMSRgTprCgXY8wCDZisUL4wIrrIuaPEcpclU/t29YPX
         1zyEP2PIdTjeYCxu6sugtpFMrg05A7bNVSmcP5VMvjion+neuJgKlWQsEp5uFUwFq1qf
         4MLgiH8COAIXrWvijcsdA1OAqPvWD3DLtJihMw9rIa3hDcn58FLuXJMslJGXztG+x0f/
         TOOw==
X-Forwarded-Encrypted: i=1; AJvYcCUb9+MEt8xkMJx6Jo0Fro/u1pYz+nwmL7wKxgr4+wgTOdS4AAoYYVCH4H0a290qP6smYLEJ/ny/uxVbnOQ=@vger.kernel.org, AJvYcCW13609cOVjQlRsVqot1K+R+kkQayTSsK/FSPV9ZIOCWlt/6mmtDVtHEwArAfV8T7zIrjreShykPMmLIuQRwJO5dbdy@vger.kernel.org
X-Gm-Message-State: AOJu0YznWmZ2t4SMOXl98D2xxNvAyAYb335Ttw9FUOEMJtZFei3gDSa/
	N7byyIeYva/IwbtTdE7H9thFrczLEuZgZZkEzUlcBbTgPjaiy2xK
X-Gm-Gg: ASbGncsC9cPRHuAlhtK5dZMThnCIBGl5/MdzHhCm6KQu243rNuMErm/RAdGvnimMxI1
	e872PxgIko/L3Cg/ApnaldJsM/y1HKT/B1y/Ob5sjIABDiZwdnfOxhHLykmgaIAOIVuJMbrvZMY
	NZm4zGdzdulsdXQ/mFH5ldBz+MK9sYfcjlHuZMD1FmHC9AywE4TRcBMlHtyYoA+pzBbG1t1I00i
	35ifzXZpimYmAWTubGYnch5WPO0+oX41ls3TPMqGVd4rwDEXmyjnoC2c3CX3VCOmHpf11Vb2SN3
	Y1zap+ROH3MXXvMczlQjhTMagt9QIE8xUIoQD8mBahTXHwdD5yS3BG1akT0=
X-Google-Smtp-Source: AGHT+IGrmjS83pS5U8IiUahOsv5euyd/fSaJqbmmkZDTbLnbai5PsBWImJFbtBBsEyZ4mjtBLwLGgw==
X-Received: by 2002:a5d:59ad:0:b0:391:3cb7:d441 with SMTP id ffacd0b85a97d-3997f90d30fmr7211616f8f.25.1742668816192;
        Sat, 22 Mar 2025 11:40:16 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a041:e280:5300:f8dc:acb8:77bb:8cf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f43ecbsm113941315e9.10.2025.03.22.11.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 11:40:15 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Eder Zulian <ezulian@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] rtla: Fix crash due to NULL record dereference
Date: Sat, 22 Mar 2025 20:34:16 +0200
Message-ID: <20250322183439.393533-2-costa.shul@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous patch introduced a crash by dereferencing record,
which can be NULL.

Add checks to prevent the crash.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/osnoise_hist.c  | 3 ++-
 tools/tracing/rtla/src/osnoise_top.c   | 3 ++-
 tools/tracing/rtla/src/timerlat_hist.c | 3 ++-
 tools/tracing/rtla/src/timerlat_top.c  | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 7c6ef67ef3e6c..f94c7c049406d 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -983,7 +983,8 @@ int osnoise_hist_main(int argc, char *argv[])
 
 	if (osnoise_trace_is_off(tool, record)) {
 		printf("rtla osnoise hit stop tracing\n");
-		save_trace_to_file(record->trace.inst, params->trace_output);
+		if (record)
+			save_trace_to_file(record->trace.inst, params->trace_output);
 	}
 
 out_hist:
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 0eeefbbbf3173..003c0f76b1ada 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -813,7 +813,8 @@ int osnoise_top_main(int argc, char **argv)
 
 	if (osnoise_trace_is_off(tool, record)) {
 		printf("osnoise hit stop tracing\n");
-		save_trace_to_file(record->trace.inst, params->trace_output);
+		if (record)
+			save_trace_to_file(record->trace.inst, params->trace_output);
 	}
 
 out_top:
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 93d0c9e450204..f91efe8804586 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -1473,7 +1473,8 @@ int timerlat_hist_main(int argc, char *argv[])
 		if (!params->no_aa)
 			timerlat_auto_analysis(params->stop_us, params->stop_total_us);
 
-		save_trace_to_file(record->trace.inst, params->trace_output);
+		if (record)
+			save_trace_to_file(record->trace.inst, params->trace_output);
 	}
 
 out_hist:
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 3894ac37d81ca..f082f8b91afef 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -1295,7 +1295,8 @@ int timerlat_top_main(int argc, char *argv[])
 		if (!params->no_aa)
 			timerlat_auto_analysis(params->stop_us, params->stop_total_us);
 
-		save_trace_to_file(record->trace.inst, params->trace_output);
+		if (record)
+			save_trace_to_file(record->trace.inst, params->trace_output);
 	} else if (params->aa_only) {
 		/*
 		 * If the trace did not stop with --aa-only, at least print the
-- 
2.48.1

