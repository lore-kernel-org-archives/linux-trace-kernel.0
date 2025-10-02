Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9FD28641F
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Oct 2025 12:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759408582; cv=none; b=ZCMEbmwTuGCL633st/nc2kht25za+QOTbY4MpDg21QN+54uI3N64ZDevTSOjHAjPPKOvI4PZ/mwUK4FxwgMJfw7dP75/vhKkc29lg1ExF7K7O7t2jbpPjucbIuoAQn1+oVmtBp7x3LW/wy553dFrMfa86msPT7cZEdeAp1EsdPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759408582; c=relaxed/simple;
	bh=K1ZN9t3MdWMg4kJzpTOCTOC/yGyvTS4NMdf0NiQkp9U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTBPevZz8sqkFgiyxEdYyWP/No9rjKTbOcIwZqOZlqkFxgpV+J8ZrdaDEvIIBpQx/aL5vKMLBr+d0cvZGVyb4jW6RyRShDTfSzXyDjgiiXx9N3x7UzbqBIRBaY6kt4uSOQ/moPLRBbZCOI3dOEzy9M3M0tZZNeR6JTYwLMqFroM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e29d65728so6133295e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Oct 2025 05:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759408579; x=1760013379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBlodwS+anVQZ01YfkUn1gudQWI1rvI4IORZ7L6X7l0=;
        b=id+Nh/zS1HAhr2StIrv19LScTsdiFciKRQF4QIQjbwrG8QJf7SfKvt3whTS+wyRWG2
         Aj12NCf7p6EfBzpaLNN69rD+yZO9my3DHVhVzLCJ8ZX88ftxdWBqhJIS0ZqyjAW0+qiN
         gutgrLlS0JHyHrq3sV5AO9eEZKTpVpHbtLlW0E6Ey+MsY8ToJ55En8rthu9ZgVYAeDOZ
         JLipjgUoGj2D01tXyzSThRyztJ/Q1ac2bA98OMeEAYmf0F7THuqtg4JAtAHy4WfQ6+cs
         prANfRhO3HvHcKW5tlTc3wJx+fPCfYNH7uXcr1NopCT+tLrvs3t9AiNZrhlHb2JXfcwh
         vvvw==
X-Forwarded-Encrypted: i=1; AJvYcCUIzyZesS/qNZ0NjxdK6wveki9iKeITKHAvnCW9k+aARrQVy4E8hAvr0zn1oD/QKOxWeRR0FQ3Bo0nUn9NiBypEWwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhk5jkL7OICLNlhjbNkWST0YdbLKa6JKYw4J3wsvN2CTzZE/M5
	mhBugQRE3dAmWiG3AvZzJ0l/fj6wcofoX8Y9ojLXPku4LtJIvlQVdgGBCbxI6Uv66p8=
X-Gm-Gg: ASbGncu+HF4Xu5PW+x3Chu3NJlEmTTSNFSAep+jFY4WeF8S0O5w0Unh0AysYy5dnGxp
	zfkktksxrR74pYXoj0T6eMJbysPu8LAXUFYaikKF74zUqC60frtFgnX49qMB6uTA1wNuoqersD1
	NbNGhT9qTkkeCv0mnbjr4/zomy8YTfjbHJCGElZQrTL0V4UbQAP2acgulIQatR/Kpx225yU1VJ5
	C0sUUqOaGx2YIBBwkLwq+jG3X/ld59LLvUjR+j6QaArZhb2EoRgcohz2hZuZoyjB2EdN8yYgdqx
	dS8HVsDoAs88c03aUPez8Lxu68O+NSe7TISC4k8fcw40slLSedt7d9lHURfoCkjhsSxZVV0uxIq
	rHWxxo8S2+CwKNUQBJwkVZfS6RhkfiOchvM778QPQ6sqEAVt7rQ91x5zJKK/l4Nfa
X-Google-Smtp-Source: AGHT+IGVheM6RSlx3YE6NvwcvVuLtj6nTKyzR3btS5SvDL3E/dJ2MMO9/HKo8LarFebhRVCcSrUQng==
X-Received: by 2002:a05:600c:c4a4:b0:46d:996b:826f with SMTP id 5b1f17b1804b1-46e612dcfd0mr58976855e9.25.1759408578482;
        Thu, 02 Oct 2025 05:36:18 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e693c33adsm32449075e9.18.2025.10.02.05.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 05:36:18 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Eder Zulian <ezulian@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] tools/rtla: Remove unused optional option_index
Date: Thu,  2 Oct 2025 15:35:39 +0300
Message-ID: <20251002123553.389467-2-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002123553.389467-1-costa.shul@redhat.com>
References: <20251002123553.389467-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The longindex argument of getopt_long() is optional
and tied to the unused local variable option_index.

Remove it to shorten the four longest functions
and make the code neater.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/osnoise_hist.c  | 5 +----
 tools/tracing/rtla/src/osnoise_top.c   | 5 +----
 tools/tracing/rtla/src/timerlat_hist.c | 5 +----
 tools/tracing/rtla/src/timerlat_top.c  | 5 +----
 4 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 844f0468953c..df0657b78980 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -524,11 +524,8 @@ static struct common_params
 			{0, 0, 0, 0}
 		};
 
-		/* getopt_long stores the option index here. */
-		int option_index = 0;
-
 		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:p:P:r:s:S:t::T:01234:5:6:7:",
-				 long_options, &option_index);
+				 long_options, NULL);
 
 		/* detect the end of the options. */
 		if (c == -1)
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index defa1eb63bee..1b5181e66b17 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -376,11 +376,8 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 			{0, 0, 0, 0}
 		};
 
-		/* getopt_long stores the option index here. */
-		int option_index = 0;
-
 		c = getopt_long(argc, argv, "a:c:C::d:De:hH:p:P:qr:s:S:t::T:0:1:2:3:",
-				 long_options, &option_index);
+				 long_options, NULL);
 
 		/* Detect the end of the options. */
 		if (c == -1)
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 02d3ffd2cf4b..c432ef5f59e7 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -840,11 +840,8 @@ static struct common_params
 			{0, 0, 0, 0}
 		};
 
-		/* getopt_long stores the option index here. */
-		int option_index = 0;
-
 		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
-				 long_options, &option_index);
+				 long_options, NULL);
 
 		/* detect the end of the options. */
 		if (c == -1)
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 607b57f2f231..82e227d27af7 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -604,11 +604,8 @@ static struct common_params
 			{0, 0, 0, 0}
 		};
 
-		/* getopt_long stores the option index here. */
-		int option_index = 0;
-
 		c = getopt_long(argc, argv, "a:c:C::d:De:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
-				 long_options, &option_index);
+				 long_options, NULL);
 
 		/* detect the end of the options. */
 		if (c == -1)
-- 
2.51.0

