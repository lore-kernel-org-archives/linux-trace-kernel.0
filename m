Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A6A3EDABD
	for <linux-trace-kernel@vger.kernel.org>; Thu,  8 Jan 2026 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865885; cv=none; b=jEmLoDlrrAyAUBKG5CZyVO8pr7IEU4lEDIiUy+RHVqf2esshQeAmgE5lDTgWwtwFj7rWKSet6xhX0MsfSRgjyggqP7GCJh2LvRjUopNMhKHgN/49N2U2xj32E53x1ocLPhPfvzZj6w6w99ysUiMLlTxZwzfHLaPuJbUgQU2jHX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865885; c=relaxed/simple;
	bh=SuLNrz3Wes0/pJvpNloKTunHGX7P3Yn5n5zDeoT2tGM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=fhLsgKwWNxO67nFC3paTBJwUT36QRluYbxbAQS0NwlPsczRAPdzwBMc+B/sPgowF7wc+tHFNiX+Hjy0Mmcmf+zypy/LhH4vHk2C7s8R5yyPp/d37+0xbEvxzEFMxgMHuYajQhe47LrDckDGC2iB6QPC1n/zfK9lkHA2zWJce7ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VLR7AUQj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLR7AUQj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767865870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n/qG/vo5uiZxrmVn+D6q59bRYSUzjsYV+KJyxKKhli0=;
	b=VLR7AUQjaC1CXMy6+/0RDN+DV2c8/YOSLK/Sm6s12chTFm0mZtqxRYiRZyKQBFIgmDuk8d
	vPa8hVaKfi0iSmH4VDVKFymUVfLxcA1n6LfiQ3NmhzELlAUGTeFT/9cLCwvgN3rAK4p/ZK
	uSeYye7RA+3Ay+g4wScMeMVXFvtUzHQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-fvfaiKfSOCe6VUFhf6t7XA-1; Thu, 08 Jan 2026 04:51:09 -0500
X-MC-Unique: fvfaiKfSOCe6VUFhf6t7XA-1
X-Mimecast-MFC-AGG-ID: fvfaiKfSOCe6VUFhf6t7XA_1767865868
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477c49f273fso30515965e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 08 Jan 2026 01:51:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767865868; x=1768470668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/qG/vo5uiZxrmVn+D6q59bRYSUzjsYV+KJyxKKhli0=;
        b=fHLKBwfLQnSsXgRUuJ3JpU5X+eFFpoi54uvh4rX7oT9GJgwuv4Eu2SN8mcVyHJ3aqS
         /P3xcmsh3zaE4XTf5xsmYt6YesByey0yJmrnOc85w2inU8kuVo6zmmr4FLo55Fj16+gT
         u4xVProrokHaiM9k0UE2ojp6645OBZ3ZnfS6FtKEl8SHKpuuj4rvXlhK7pY5cv1hWf1b
         xMNHRcMBxUFXKe61ag+FhDjwelXHaJ+DdrbLM35c+yN5IlqyOAbvHJJ1lgIADUGu8DL9
         ECc9wg8zNegb+H7VO0/O5UkocRxjWY7jsRzleAQ+BMnQnGpiu+m8gLGUXp6zJ/3F3UO+
         JKkg==
X-Forwarded-Encrypted: i=1; AJvYcCVqaDrowVl4xQF0ChFWRsSGhwcGYuzuh6zTaDI5tiZZ+IWjgqqO3OE5HqsXLYJsPTYfaNOVVW/3BCMdErBhxZ7Z7qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRgFYye+OcjMkMlWFLEVVg7dQXWZ1EQCRooGoBZ6uzbxS67On5
	DZQ5gj/1dUSAWHxIt/B9NFyns8Jy7rsR1PN8vOV3oYX/eI/JXkq/ahEK0qGQ4VBevLP7aoyroJv
	g1tEFvGVE9JCb3XmLC9XryvTOYBPe+EIIex+hbaoQxcMpAOEkbiEjUCSATdzaGLpWFtOsrvurXQ
	==
X-Gm-Gg: AY/fxX7fJl170Yf3GmAm+/GT82ZPCglHozC7NfyHR9qAjFx7/TbamBD2wTRtIpEU7UT
	TMj3L+GDHuqZnpAUDJ1I52wWxU8P+nCM7ElNQ2Ka1if1RBW6tqHkZlL9XdSdcSwqj0j0PgIWIeX
	HUCcLI87qHunGwflu3gZraZDl+bJfpwPxfc/5hrG3ojJuSgzfGfxqz6Kh/uDDSaLSSRC1wNfv7p
	0pLwAteXuOKMOFjIq9OxmlF6Ydxn+85ZPWfJg+nZMv0Q+sDqVMBhC4ieuO/8tJroCsK1GbyS7D9
	O+O5RfRrcpUsN8PkLDS+QA+0ezHcpojWaLRd/O6C2RuHbzbiuyW9+rhAnTO5ulZopqQempP85r4
	N1HkP0tJKlu2g+f/minQrfw==
X-Received: by 2002:a05:6000:1886:b0:432:a9f0:48c with SMTP id ffacd0b85a97d-432c38d26f6mr7083934f8f.63.1767865868148;
        Thu, 08 Jan 2026 01:51:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkqw8qcmUgoA8mC0TH98TFcHP34mNo4yMgAAgBUIPtadXeGFTh50WxGruEp0kESFHrPnWmjw==
X-Received: by 2002:a05:6000:1886:b0:432:a9f0:48c with SMTP id ffacd0b85a97d-432c38d26f6mr7083902f8f.63.1767865867666;
        Thu, 08 Jan 2026 01:51:07 -0800 (PST)
Received: from costa-tp.bos2.lab ([2a00:a041:e23c:600:cadf:120:2b7f:a706])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df939sm15128268f8f.21.2026.01.08.01.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:51:07 -0800 (PST)
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
Subject: [PATCH v1] tools/rtla: Generate optstring from long options
Date: Thu,  8 Jan 2026 11:49:55 +0200
Message-ID: <20260108095011.2115719-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9jLHOPmRrdHmCJNqtkgudhdqWOpOKXTVoyhNbIENWYw_1767865868
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

getopt_long() processes short and long options independently.
RTLA, like the majority of applications, uses both short and long
variants for each logical option.

Since the val member of struct option holds the letter of the short
variant, the string of short options can be reconstructed from the
array of long options.

Add getopt_auto() to generate optstring from an array of long options,
eliminating the need to maintain separate short option strings.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/common.c        | 32 +++++++++++++++++++++++++-
 tools/tracing/rtla/src/common.h        |  2 ++
 tools/tracing/rtla/src/osnoise_hist.c  |  3 +--
 tools/tracing/rtla/src/osnoise_top.c   |  3 +--
 tools/tracing/rtla/src/timerlat_hist.c |  3 +--
 tools/tracing/rtla/src/timerlat_top.c  |  3 +--
 6 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index ceff76a62a30..f310b0d59ad3 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -39,6 +39,36 @@ static void set_signals(struct common_params *params)
 	}
 }
 
+/*
+ * getopt_auto - auto-generates optstring from long_options
+ */
+int getopt_auto(int argc, char **argv, const struct option *long_opts)
+{
+	char opts[256];
+	int n = 0;
+
+	for (int i = 0; long_opts[i].name; i++) {
+		if (long_opts[i].val < 32 || long_opts[i].val > 127)
+			continue;
+
+		if (n + 4 >= sizeof(opts))
+			fatal("optstring buffer overflow");
+
+		opts[n++] = long_opts[i].val;
+
+		if (long_opts[i].has_arg == required_argument)
+			opts[n++] = ':';
+		else if (long_opts[i].has_arg == optional_argument) {
+			opts[n++] = ':';
+			opts[n++] = ':';
+		}
+	}
+
+	opts[n] = '\0';
+
+	return getopt_long(argc, argv, opts, long_opts, NULL);
+}
+
 /*
  * common_parse_options - parse common command line options
  *
@@ -69,7 +99,7 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
 	};
 
 	opterr = 0;
-	c = getopt_long(argc, argv, "c:C::Dd:e:H:P:", long_options, NULL);
+	c = getopt_auto(argc, argv, long_options);
 	opterr = 1;
 
 	switch (c) {
diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index 7602c5593ef5..d4b3715700be 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #pragma once
 
+#include <getopt.h>
 #include "actions.h"
 #include "timerlat_u.h"
 #include "trace.h"
@@ -156,6 +157,7 @@ int osnoise_set_stop_us(struct osnoise_context *context, long long stop_us);
 int osnoise_set_stop_total_us(struct osnoise_context *context,
 			      long long stop_total_us);
 
+int getopt_auto(int argc, char **argv, const struct option *long_opts);
 int common_parse_options(int argc, char **argv, struct common_params *common);
 int common_apply_config(struct osnoise_tool *tool, struct common_params *params);
 int top_main_loop(struct osnoise_tool *tool);
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 9d70ea34807f..5c863e7aad28 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -506,8 +506,7 @@ static struct common_params
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:b:E:hp:r:s:S:t::T:01234:5:6:7:",
-				 long_options, NULL);
+		c = getopt_auto(argc, argv, long_options);
 
 		/* detect the end of the options. */
 		if (c == -1)
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index d54d47947fb4..b7aed40fd216 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -358,8 +358,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:hp:qr:s:S:t::T:0:1:2:3:",
-				 long_options, NULL);
+		c = getopt_auto(argc, argv, long_options);
 
 		/* Detect the end of the options. */
 		if (c == -1)
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 4e8c38a61197..096de8ba3efb 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -825,8 +825,7 @@ static struct common_params
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:b:E:hi:knp:s:t::T:uU0123456:7:8:9\1\2:\3:",
-				 long_options, NULL);
+		c = getopt_auto(argc, argv, long_options);
 
 		/* detect the end of the options. */
 		if (c == -1)
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 284b74773c2b..27c14aa71a8b 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -588,8 +588,7 @@ static struct common_params
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:hi:knp:qs:t::T:uU0:1:2:345:6:7:",
-				 long_options, NULL);
+		c = getopt_auto(argc, argv, long_options);
 
 		/* detect the end of the options. */
 		if (c == -1)
-- 
2.52.0

