Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C45B2FBDE2
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Dec 2025 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765274470; cv=none; b=jSa9ylcqELcUFQ0Xwsn34q5mbHxunSL3StuPAZDPTgrcTbrRs0KWucOsa9LuM/1gq1OcxVLVxTOdEMVjdW8LcZfLP424Eh6/4n7h9AF9OVq11Cv5+oF078p0t7tm7YlbN13gxGKBjkbfCAzRHuKWEAkIM6NLENJVnEjA8XpKBvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765274470; c=relaxed/simple;
	bh=5HYWKp1InhB144zgvqpcWgNPV35GCPenTEuhbXijW6g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=R8GdX9WRNNOc7ndQc+kUxb/QC9lQJU0KFc6lFiIy7atSHh3DOaTGSKYqT0Mb4u+iOSLlqHb4IECVjU4IjOzTdb8TlrE4kkj1Hcets6HfrpSMm9axp61ZaSTJ0S/6gB9WVdZZZSrtdu/vd6LujQK9373PUR+zplrzWlYo+cj/XMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RvFpNHGn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvFpNHGn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765274466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s+bcyW/x/HLr1cSMDPW8eIM00B0y7p70Qx8GdgLwv1A=;
	b=RvFpNHGnfYOGEXms9UtvEVo3X0A28oeTOwWrzdt15AFAULouXpYeCLiN4K339z7Rzq0yvG
	GYaGRtqFxRa7oY717afSEfpoqC6//SN8ci3cBfT4jMWJcNJc58aWZ4+rkVLRTV9W/GU/E4
	Qh/mF7b/aSOnRsrtZ1GrrlFEn+o3BtM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-Rr1sFXfcM8C6RjnAW24XMA-1; Tue, 09 Dec 2025 05:01:03 -0500
X-MC-Unique: Rr1sFXfcM8C6RjnAW24XMA-1
X-Mimecast-MFC-AGG-ID: Rr1sFXfcM8C6RjnAW24XMA_1765274462
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4792bd2c290so39406775e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Dec 2025 02:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765274462; x=1765879262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+bcyW/x/HLr1cSMDPW8eIM00B0y7p70Qx8GdgLwv1A=;
        b=fqwb0cNDfQhdskI96AoMMG1skjyNF2fLRFDmSEdt60RvoeCcY8egCsdd4inMsYrn7E
         obIoMigxTFXLIiYLttuzsb8wmF2/A2XJoxwWcL7P8KCsqdXMPexmvMZiU0vFZyRq921/
         RJ3NskLUWgPNbQukRfbX3O9/qBoDNDnfSd20vdnWVufvL0BprhXmohjZDX0YHjCCutUb
         13yLxoBXS3fkvzXGqBAE5UUGbzSK0VSclRKYbC4O8Kvvqo6PIxVQC9ya7ABefvCpnbEm
         6TTFwS853XSKGIb8dM20wT2xCbqhRoink30Q1SZn4ybetBnNMMJya49VKlmOi1srzVYK
         WfgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLH5WFk2boOLrCUZRqq/R7bnRKk7Bp/iO14g74b96plJnLkgVNFMAwSVdEBG72abaJy3wlkN8SeofMnR48a/3wmjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZLy6g+61h4Sajd40MuEu1xm6cd6qFU7ElV56VRGpYiv/aS86t
	fOJzvzcrH6+Gt8M/lU1THwFiZhCiwKFzZdausTtRvS41QR2ANzlaD0NzBD+lY9gt3rLwglE5ktg
	UEgNdjSV7KWZJjBBfjmxxymPQGgeapq+8ZTCLwuAccjKzvOCWE8Ez0a8kPlJbiAn1NpRyfmDbrA
	==
X-Gm-Gg: ASbGncuBGC1hM8QiYzCaWDmd5/EI6/7ICj5TibJsIBK0+oE/A3P5iY/b+AmkS4f/Pj9
	Q1n0jlHhjBckCzojgGBcXl8cw66RPPEx6cT36nqRcdLy60M1gj1EwtYla+f04rpIq/jpDV9lrQy
	/IE1n61SR4oUV8aeqSk+zXLoaH661n854WpLvkEZu2MePyntQE52wrwQ0NdNff2BIGgFBj/LuOf
	Ff6mumxtYBn/thnuYtPj7CDwKp2rkmiqm/bGdBlJ6N8IvMJroit0z2c3AX71juilCa9cbS1qZml
	mE5YIBCjZ4Zne7OBeegsOFUY2zxzLdDRFHQZyhTrFBkQObIGVPxcWOJSAOsl/gzZNaHcG1KQzW3
	3wNhHfDD8p/kqr22s2rwcfLmNjkI=
X-Received: by 2002:a05:600c:1d10:b0:477:c71:1fc1 with SMTP id 5b1f17b1804b1-47939e23a91mr98177035e9.19.1765274462050;
        Tue, 09 Dec 2025 02:01:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8KxQrMj7U6e1JstP0WFesnzNwmHbfF/lCNrfMTqI9auubM26riS6hcbS0rJ00WMWWR86q/A==
X-Received: by 2002:a05:600c:1d10:b0:477:c71:1fc1 with SMTP id 5b1f17b1804b1-47939e23a91mr98176475e9.19.1765274461319;
        Tue, 09 Dec 2025 02:01:01 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e294:5000:b694:8e49:4f51:966d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d612e49sm33620855e9.3.2025.12.09.02.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 02:01:00 -0800 (PST)
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
Subject: [PATCH v2 1/8] tools/rtla: Add common_parse_options()
Date: Tue,  9 Dec 2025 12:00:40 +0200
Message-ID: <20251209100047.2692515-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OVactX2CWNvX96DL7ShxD1OY5pen8A8HaSdHxkAeYVQ_1765274462
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Each rtla tool duplicates parsing of many common options. This creates
maintenance overhead and risks inconsistencies when updating these
options.

Add common_parse_options() to centralize parsing of options used across
all tools.

Common options to be migrated in future patches.

Changes since v1:
- restore opterr

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/common.c        | 35 ++++++++++++++++++++++++++
 tools/tracing/rtla/src/common.h        |  1 +
 tools/tracing/rtla/src/osnoise_hist.c  |  3 +++
 tools/tracing/rtla/src/osnoise_top.c   |  3 +++
 tools/tracing/rtla/src/timerlat_hist.c |  3 +++
 tools/tracing/rtla/src/timerlat_top.c  |  3 +++
 6 files changed, 48 insertions(+)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index b197037fc58b..a78f9883521e 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -5,6 +5,7 @@
 #include <signal.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <getopt.h>
 #include "common.h"
 
 struct trace_instance *trace_inst;
@@ -37,6 +38,40 @@ static void set_signals(struct common_params *params)
 	}
 }
 
+/*
+ * common_parse_options - parse common command line options
+ *
+ * @argc: argument count
+ * @argv: argument vector
+ * @common: common parameters structure
+ *
+ * Parse command line options that are common to all rtla tools.
+ *
+ * Returns: non zero if a common option was parsed, or 0
+ * if the option should be handled by tool-specific parsing.
+ */
+int common_parse_options(int argc, char **argv, struct common_params *common)
+{
+	int saved_state = optind;
+	int c;
+
+	static struct option long_options[] = {
+		{0, 0, 0, 0}
+	};
+
+	opterr = 0;
+	c = getopt_long(argc, argv, "", long_options, NULL);
+	opterr = 1;
+
+	switch (c) {
+	default:
+		optind = saved_state;
+		return 0;
+	}
+
+	return c;
+}
+
 /*
  * common_apply_config - apply common configs to the initialized tool
  */
diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index 9ec2b7632c37..1066d777a823 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -153,6 +153,7 @@ struct osnoise_tool *osnoise_init_tool(char *tool_name);
 struct osnoise_tool *osnoise_init_trace_tool(const char *tracer);
 bool osnoise_trace_is_off(struct osnoise_tool *tool, struct osnoise_tool *record);
 
+int common_parse_options(int argc, char **argv, struct common_params *common);
 int common_apply_config(struct osnoise_tool *tool, struct common_params *params);
 int top_main_loop(struct osnoise_tool *tool);
 int hist_main_loop(struct osnoise_tool *tool);
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index ff8c231e47c4..35f4a068af95 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -518,6 +518,9 @@ static struct common_params
 			{0, 0, 0, 0}
 		};
 
+		if (common_parse_options(argc, argv, &params->common))
+			continue;
+
 		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:p:P:r:s:S:t::T:01234:5:6:7:",
 				 long_options, NULL);
 
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 04c699bdd736..550731c7addd 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -370,6 +370,9 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 			{0, 0, 0, 0}
 		};
 
+		if (common_parse_options(argc, argv, &params->common))
+			continue;
+
 		c = getopt_long(argc, argv, "a:c:C::d:De:hH:p:P:qr:s:S:t::T:0:1:2:3:",
 				 long_options, NULL);
 
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 1fb471a787b7..ffcfcabb9964 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -834,6 +834,9 @@ static struct common_params
 			{0, 0, 0, 0}
 		};
 
+		if (common_parse_options(argc, argv, &params->common))
+			continue;
+
 		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
 				 long_options, NULL);
 
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 29c2c1f717ed..d18d48671ccd 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -598,6 +598,9 @@ static struct common_params
 			{0, 0, 0, 0}
 		};
 
+		if (common_parse_options(argc, argv, &params->common))
+			continue;
+
 		c = getopt_long(argc, argv, "a:c:C::d:De:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
 				 long_options, NULL);
 
-- 
2.52.0

