Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7501F3446CA
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763747136; cv=none; b=uIuzkJZ08Fzraeu/ve85RSv2e+U2B3rTepCYy0oN9CLns4UEXw4AmCR80ujPgPChkv0N7HWju7trdS/x5cjpaMkMVUraWC+eClnVBNJ2nrJqH6+id63JhyjW/DyJRXdX9SMEMjE0W9qeYIgl9QBr3Ra7wsBzwjcqO82DDsliZXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763747136; c=relaxed/simple;
	bh=hEnSqrU6gyHDpfaTTvuhCk0gZVj3SdwGrgEDkeASOzo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=RqlgN5L+6cbXnqunOK2nAHsVOvSzL8Cw0ErQWTRktJoDRE+Z8PtnXHYEFJ3NKL2R5jm2s9o8P8NvD01PWaFAU+y41O6NErIwEbYyG/JHqtkP9WO+kVLT2gNBNdR3MNEgB1ZZ/KqPUdyxGitcZbCANTxRQ8Ig3jK1WfkqhywS43E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dK/aViu2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dK/aViu2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763747133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a8U8k61ooI8uwApq9Nne2HkmVcuivM1F21YTKzt65jc=;
	b=dK/aViu27ZAn+LwOsF1gRUkohvUL8J1xi2b0oEQoYE5W9UrCgt7ttLHqoQW+aP4uEkuhkM
	WF8MUp5xunWzUdOkLNtWu/QfrAa4T0OgDI+9WUPO5mTV9b7PBB7MsU/B3KZslgzGOR0aaN
	4gEkyHF1J+8+M/RVH+mIUc4Yk55DwVA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-MeFG-FzQOUK5fL2QW6YiMw-1; Fri, 21 Nov 2025 12:45:30 -0500
X-MC-Unique: MeFG-FzQOUK5fL2QW6YiMw-1
X-Mimecast-MFC-AGG-ID: MeFG-FzQOUK5fL2QW6YiMw_1763747129
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477a0ddd1d4so28206335e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 09:45:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763747129; x=1764351929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a8U8k61ooI8uwApq9Nne2HkmVcuivM1F21YTKzt65jc=;
        b=B3uVZYvgIXR5ti0HH4Wu1ncDDx+J8DLKdKIAtcBviS2Gl2WTifrGomBynmvsrGvLTK
         iQXoWen5dwYIq1h/yHHB8NCYiF3hiDdbZ+YcR4jg3FmCXDKk/1l+JXnpkGF3ZbL7g88F
         NiMnjGQK5bN9ux5cR3QJYcwywnj97wC5Ww9t+4afZGxH3CgRKSsrBs7CQUpCdQWyCgfD
         19CTYbn7Km6rmhGz+O7RJq1NICtvTj75TUUQZ37aiPJTMp2SNql/6daPd0rfZQ5Ve3lr
         bI1to+Kt1eo1PpaF4nfN5sa4K150H2m/VWICuXPjTQwZaCM2XicjB+eE2Waue/EBly0T
         JobA==
X-Forwarded-Encrypted: i=1; AJvYcCV9DUxHTS3Jsk/ElfSd/HbMKNhP7YJ2PzP/4e9IMwobsVk6ZqtUsms30CHfQxORaoRuJp3qcZhrYmMn+U6ABUPRwLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNgB4Ruis9zYRaTk37ouOfI3o3vgCn+kwFpYTifm5qMohW04RN
	NnmQdo+DUA4Y3zEyWqKmPuXcjLojnGKqnWeKizCpyYeOqS9dc+PPtm62gwJxf/xOjOYcouduOGx
	63UGp6jWx8lBeyQtQM3+zj5saLO1I4E0BsoxmTwsfFLzq245brYZI4U53Q9J9FMENIBH3dxfSQQ
	==
X-Gm-Gg: ASbGncsbp37D9masBDZ8RbJNYUMXfBAj7f74dJdqqJj/VZ029isII1dYKn1sKFHNlnx
	p7ij+3n2k406JAmiB+3uMHc50hnqm+Ws8l+VsMEqUQBYa1IXaWTeacADqICWxl4fKmvN+NH/6L5
	krW66gclnj2/T2JMb9BFXdFe4DuzzsUcfD3JhDQlsZrgGcKuMtngtUH7FFotmK39qoiHEacm/7d
	FhnNMWJ4ctmMvK4Aj65Q/u7huuDGhJxk9P67QBN2Wq/5yl1At64S4/mhGBoqRFNoN55b9lIsrHU
	7y+G+ytYz3MfwJEUGvVYoJZOZfy+Pg8qyv7McNqQnda5KfCpSq48RKVwlDXUU+/4Kzj80QvtxWa
	DiV1ftBF5vdmkm1KgrYk8lAUe
X-Received: by 2002:a05:600c:1f85:b0:477:7b30:a6fe with SMTP id 5b1f17b1804b1-477c1116013mr27453385e9.18.1763747128618;
        Fri, 21 Nov 2025 09:45:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+H0undz5MZzoSg1LxF9NOXlTyyk9c7w50TvXj8Zav3XyrYG5bpmJO1uYPj5tlwMHTJM4AzA==
X-Received: by 2002:a05:600c:1f85:b0:477:7b30:a6fe with SMTP id 5b1f17b1804b1-477c1116013mr27453165e9.18.1763747128228;
        Fri, 21 Nov 2025 09:45:28 -0800 (PST)
Received: from costa-tp.bos2.lab ([2a00:a041:e294:5000:b694:8e49:4f51:966d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7ec454csm11529567f8f.0.2025.11.21.09.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 09:45:27 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/8] tools/rtla: Add common_parse_options()
Date: Fri, 21 Nov 2025 19:44:57 +0200
Message-ID: <20251121174504.519230-2-costa.shul@redhat.com>
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
X-Mimecast-MFC-PROC-ID: oN1AceXJ8pogo3OkHigBaVIVChDLUM_HOTfeDuqeYYA_1763747129
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Each rtla tool duplicates parsing of many common options. This creates
maintenance overhead and risks inconsistencies when updating these
options.

Add common_parse_options() to centralize parsing of options used across
all tools.

Common options to be migrated in future patches.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/common.c        | 34 ++++++++++++++++++++++++++
 tools/tracing/rtla/src/common.h        |  1 +
 tools/tracing/rtla/src/osnoise_hist.c  |  3 +++
 tools/tracing/rtla/src/osnoise_top.c   |  3 +++
 tools/tracing/rtla/src/timerlat_hist.c |  3 +++
 tools/tracing/rtla/src/timerlat_top.c  |  3 +++
 6 files changed, 47 insertions(+)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index b197037fc58b..5eaf6d9e11bf 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -5,6 +5,7 @@
 #include <signal.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <getopt.h>
 #include "common.h"
 
 struct trace_instance *trace_inst;
@@ -37,6 +38,39 @@ static void set_signals(struct common_params *params)
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
2.51.1

