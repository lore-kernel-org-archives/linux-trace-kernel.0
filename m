Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C3E1F30A4;
	Mon,  8 Sep 2025 02:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757297181; cv=none; b=peAXsDiW8J05rps9gFjAupeqt70cjlVhJfDQsMjHv/lmDxaFtD2ujvET68yef5CJgBpE6BMtBSGXnT3B1bNOh/ais2g3eo4YkeESotWuwrdAeBkKivoO3EPjyyy0zGiz0um4vcQj4NGNdHGjNHHw6DBQn6LwTXpUxi/7RpN9Fsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757297181; c=relaxed/simple;
	bh=us1QFzHM3F3Tx5gbB5Xm3+iG8ZcTVYz+MmsqUabv0Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8ANH/Cg0mYGZolRLv4RC4B0usu0sPrTIpfTdJAiJlOtt5L+TXZZZ8dsJvwkkb7H9dNlJmDP8eD3gkDL7KxO1YO3T/Ls7jNkje0SM49BupWmVgGLQF0w/kRZM5+IENoMWjjgMtX2WbDneMPDdrfmGNu05cYMOMoeI9RPdUHVvS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRnZS0lD; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRnZS0lD"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70ba7aa131fso45198106d6.2;
        Sun, 07 Sep 2025 19:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757297179; x=1757901979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaBAcVJZNA9ab0l53ugbMEso8fa/CwAwMsudSNPp4o4=;
        b=cRnZS0lD9FtO77RKFu/PT8A5VmIw7ZZbuL+etD0QxF0dg9Q81SCl4gd9TYHr/8+Ntf
         sqPlng/SkarW2Lib3T2rnuoPT9J0reAIQGic+Kp2PojRhC8lS5RkTc4SOpv4w9g1yx1W
         Ps8qB4t7SdpEZmEL9XJ22YVkVQIT1hClkmXsrPSAggjRtTucjc3Kqwth7JGb7NymKYwH
         CPwKTocWv3l0gZudEGycsXejWzeqqujBUbkFEg6e8lwP2s49GLvxTM9b6EASKmlWwFJu
         zzlkWwhBN+sGEARgW969lkMJJtWunvk48PA/6bjkBmbaZoKotoajiWgDjGMVRfpySTuI
         QPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757297179; x=1757901979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oaBAcVJZNA9ab0l53ugbMEso8fa/CwAwMsudSNPp4o4=;
        b=hOGGJBrf7x065D1AuAawFYKOejDbanO2Zla0In4RXFSHm9DD/sSTAu9HrGTvjClkL9
         I2GUVY3/Qzj6pgWdEdEAkbkUJVfcD7L/b77fZVRxuWZcQ62k9qR0mooE9G6qsC5mE93l
         1DJveN3nLV8Ds4FcbZfgmIUoZb89jyKOoWg92Zab/Tf/eDENskvxL/tvhAsSrpsm/25T
         Z6Smzz1BVCXNalYfAH97B7eBPo0sEc+swUFw2RsFXUgAa0NUm+cr9n0Y2iGzI5Npnj1P
         LTn5Z750Lvd2xXy49mHviVsuvuEOYgOXpJUtPqUu2xtdYZ4hTEFB4ls0RLih1Q+dZ4xH
         WIng==
X-Forwarded-Encrypted: i=1; AJvYcCU0x6BEJS5qloxirIl+QELOQlTqC3/KrJ02sqQSd9cNDfYPTfgHq8OZdc92yHvC+EMNzolaIs4cm8WxQRM=@vger.kernel.org, AJvYcCV2PEeQxQPnrdIqLJtiKXQ0jeFheMLs6UD5YdOJKYFd2PZCdv7UgQlQBZbYBPIAVSUzSz3R94bNEHHYf5MQnx7yDD69@vger.kernel.org
X-Gm-Message-State: AOJu0YwTPUvoUPjaCIxJzBjGhRO6GSEmVdyosQO+q8G6O7fQCzp94O/h
	0VcUfEM6m55Qwj638iYDe+s4atS0xPzRc19BL0/E0xJgDavmmTyAaTHL
X-Gm-Gg: ASbGncvcm76rovw8GiAjZgXL2wfwfl2nix30v79JBPvFcR9VligAd73VEM3soKOnpCr
	wNs+3x+FKjIriDhYER+z7sWKFqrvIfb4UyRxW56GZLl7H2WcaFB+7K/OXMc/hg9PLQYiQxnfzss
	VVoQNXYNPAPErIYFcJF84M2v+FaUgILT0Ys2rJwFgGIiXQhIEMFXeMlE7IWhCF6/ST8xm6O6z9x
	rYPO1INtsEvVDK25w8csOXd/Fi3NEG+pup5aqb8/K87wtI3lr51qOlhH0EsGcUNc5BaREHwx+vp
	QEgcqhMtboSMDa1kt+BcogyFjt78tX7rGtHzVgQqkytEhBZDKfuf31CQL5YHf4qMZtzz5TWV504
	S4xXYtucZQpp3Nb9QLH3S+wc0oBeaQUM2sRJXlnqu31SoJtTjzJTNMk5e2FviyrULMR0DTNV5aS
	eDSh9Ihs7s+vFjOBFIlw==
X-Google-Smtp-Source: AGHT+IHZ/hD01zVbSdcsMLdVqx/W+/+CcThF2p0btDBB01OxOdC6PVomOpWDgdx2a2KJFxUAqssFWQ==
X-Received: by 2002:a0c:f119:0:b0:739:f004:a176 with SMTP id 6a1803df08f44-739f004a468mr57212566d6.39.1757297178592;
        Sun, 07 Sep 2025 19:06:18 -0700 (PDT)
Received: from ideapad.solutionip.com (wsip-184-179-113-83.ri.ri.cox.net. [184.179.113.83])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-72925b87571sm79638846d6.6.2025.09.07.19.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 19:06:18 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: rostedt@goodmis.org,
	tglozar@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>
Subject: [PATCH v3 3/3] rtla: fix -a overriding -t argument
Date: Sun,  7 Sep 2025 22:05:59 -0400
Message-ID: <e4a61cf3416c9b2a2c4952cbc93b4b05a7c3a37e.1757034919.git.ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1757034919.git.ipravdin.official@gmail.com>
References: <cover.1757034919.git.ipravdin.official@gmail.com>
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
 tools/tracing/rtla/src/osnoise_hist.c  | 3 ++-
 tools/tracing/rtla/src/osnoise_top.c   | 3 ++-
 tools/tracing/rtla/src/timerlat_hist.c | 3 ++-
 tools/tracing/rtla/src/timerlat_top.c  | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 1dc39de79d78..3aa74affac26 100644
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
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index b3e161536ed8..6bcb8d10c342 100644
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
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index ad713dafa3c3..f845d5fa8141 100644
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
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 7f1885018624..42d85ea2e996 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -625,7 +625,8 @@ static struct timerlat_params
 			params->print_stack = auto_thresh;
 
 			/* set trace */
-			trace_output = "timerlat_trace.txt";
+			if (!trace_output)
+				trace_output = "timerlat_trace.txt";
 
 			break;
 		case '5':
-- 
2.48.1

