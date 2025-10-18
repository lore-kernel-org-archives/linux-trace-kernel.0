Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226842D8370
	for <linux-trace-kernel@vger.kernel.org>; Sat, 18 Oct 2025 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760792694; cv=none; b=p8l7LXbffwkhn4r0LcT+AFeZ3PcuFJJfH/cPbMIiF66udg2h0JnNK45CexgAsJ5bEBy+yT/oZlToRHcuFo+J9HDq1ADD3fJSJAQ58Vsi5wLCNmSiZkTSEesmTce/AV18AfYTuQN3upulSeq/7W6PT/0NJ6mfjCGtrwPcN6RO/4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760792694; c=relaxed/simple;
	bh=/QKA0xRQrUJstKtOglqkTvta05yDY6MtV3GQJq3894Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxlalK0KLRjun2kIstcjgc8L/jI2U9ztfjvovAutR1hlOuZLkdYxNQVEtZmXCTOUzxNDSsV9J+efOFTdMXNUL62kOlUJNe6BaoQVQyt+ddFSXeK/PqMJUewfl/4hDL3ss4UZ7/5FUOdLExlNLD1PGmMQk/iMTZxIFtDNoYoQj9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKBe9OAt; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKBe9OAt"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-87c1f3f4373so54553736d6.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 18 Oct 2025 06:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760792691; x=1761397491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWnt+sjZ8ZgsaI+sAzX/D1lkWlG+AQb06P47+lpZEQg=;
        b=PKBe9OAtNm2mYV7LBc/I1P+3WdYFxg32SnRmqXzmR0AC6IhklsxEs7827chNf1tcmu
         7buyvT30Mb4C8cHXMTwRPT16ZhLUZNXwtZeABLYMWojXrECnFVtdLiP52bzk9a8s5RV4
         Gxer1r4m/OGFS1yLYmoL2Tq6q9hP90PyMCweaJQXPSkFGqrxRexa/SPlv07IhaY9Ym1j
         u0ZHl73Jw5vJfsdwDmyycLtyN3Lhg8HQaecqgEokKffpWKdjgSAc8xh2mWyYp38hsnk7
         QJlok8rWmf93BTqSlYQ0A6j7S7bl21MoWrWSkW5rOMQtRNHhGK08pRtA4A7qdiS+uiJj
         p+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760792691; x=1761397491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWnt+sjZ8ZgsaI+sAzX/D1lkWlG+AQb06P47+lpZEQg=;
        b=K5GDkqSnd7/GjEsjp7zDHsPNvf5NotMAhij+qUFXyFSJ7C7BlVyNRq4eKJHksZRs+t
         G/DOI7AKEldHQcCdikllZL/tTDLtvvaM7E92uovaxdeG+Xl8r+NThCVll4WimYOrMIu3
         Y9pFbjTc0EPa1sJ/QUInrlRaKA9Va+Y9Jti9c5wrKUb6YklGPo5Miw6Gr/GPD9wZ1hgz
         RuUyiEqhXJnH5Z1Dy4MshPb+ERyRAqeyFYSljhlPXfuMq7u8b3b7FgLPxAOP+rTibAiI
         9tEsMVuxKDli1sUQ2QSpzml2eCwmSLQwmhfCMAPSWclGgD3GpabQVz2VGP8WvVTnAZmo
         oTKw==
X-Forwarded-Encrypted: i=1; AJvYcCVrAc6pyhfpWzuj6J0coK4UrYwOLCQZEZsz2fIOssCStIRIEZ+hIVz+YF+nGUo180v7L8Xwyx+NdrYqlDb8L74ZPrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqz9JSz1WxAS+xeoOKURKaQBlSN7QqeZ8CcFZRcOD9oUoQKbKP
	agLcJWrTvIfWs6YSO8SZTIVHTE7qPZjezhCpRvAzFzarx3vbOhjT1LCV
X-Gm-Gg: ASbGnctrt4v4ujyBODwElIqwdh/nWFjMV0EobUIDfdZ4I1VqnuzltJhI4Bie8yawCL1
	dcKuFVj8G7htB6vBUn7DlyV9MdqRoq0qz6PZUW4yR+0ILAo13Dn6qHLDIG7EumF6ZD0NAraf3BG
	XKlGWKxpfNfHMloZnHV1tUy0JROpy1F/WKqYdZ98wErrVDu+J3g9Ztuvrx7LAZuO9uFj6ZNmqrG
	A0XPjW+v8onBnfDMdZ7+MrvtScCJXT02e5HUsHYYKHWWlcXMEj5zPHpYOPBuu39ZrUohqt+1hLG
	2qw5oWrw1utvEqwpq9acPkYOh6w4XZ2pJRI7RzYmT1RJqP34FVwLd8ndXS+gIhZmO3+1E8MWOY9
	OBRiL4kRzw1ks2jji8/3F3BEB0TCzj26+G0hjWWSopClT0dZA8u+xPyTWlb5RDI4K9GZoeRlRG5
	ImR77G1Xk1NYNhIRHHCBcGQY3yyJapoJh0KYep
X-Google-Smtp-Source: AGHT+IHmRouhpzmNuhXsb90wciLNRo+Xh2dXpLMyR7s2zHZrsvFLahcyOci9MsF3wzHDrdrwup9N5g==
X-Received: by 2002:a05:6214:1948:b0:87c:dff0:7c0a with SMTP id 6a1803df08f44-87cdff07d94mr54571536d6.55.1760792691024;
        Sat, 18 Oct 2025 06:04:51 -0700 (PDT)
Received: from ideapad.mynetworksettings.com ([2600:4040:5304:d300:275f:6229:da5:6a60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028966fasm15840596d6.33.2025.10.18.06.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 06:04:50 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: rostedt@goodmis.org,
	tglozar@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>
Subject: [PATCH v4 2/2] rtla: fix -a overriding -t argument
Date: Sat, 18 Oct 2025 09:04:31 -0400
Message-ID: <93cf8411e8c23ebdcf2e168f0f7d3e8c9081900b.1760791697.git.ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1760791697.git.ipravdin.official@gmail.com>
References: <cover.1760791697.git.ipravdin.official@gmail.com>
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
Reviewed-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/osnoise_hist.c  | 3 ++-
 tools/tracing/rtla/src/osnoise_top.c   | 2 ++
 tools/tracing/rtla/src/timerlat_hist.c | 3 ++-
 tools/tracing/rtla/src/timerlat_top.c  | 3 ++-
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 8b12d8803998..ae8426f40f8f 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -557,7 +557,8 @@ static struct common_params
 			params->threshold = 1;
 
 			/* set trace */
-			trace_output = "osnoise_trace.txt";
+			if (!trace_output)
+				trace_output = "osnoise_trace.txt";
 
 			break;
 		case 'b':
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 0be400666c05..9487c6a592c2 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -398,6 +398,8 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 
 			/* set trace */
 			trace_output = "osnoise_trace.txt";
+			if (!trace_output)
+				trace_output = "osnoise_trace.txt";
 
 			break;
 		case 'c':
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 16416192e432..311c4f18ce4c 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -878,7 +878,8 @@ static struct common_params
 			params->print_stack = auto_thresh;
 
 			/* set trace */
-			trace_output = "timerlat_trace.txt";
+			if (!trace_output)
+				trace_output = "timerlat_trace.txt";
 
 			break;
 		case 'c':
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index fe4f4e69e00f..3a3b11b5beaa 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -628,7 +628,8 @@ static struct common_params
 			params->print_stack = auto_thresh;
 
 			/* set trace */
-			trace_output = "timerlat_trace.txt";
+			if (!trace_output)
+				trace_output = "timerlat_trace.txt";
 
 			break;
 		case '5':
-- 
2.48.1

