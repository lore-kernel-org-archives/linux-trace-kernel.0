Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947F62FD7B9
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760347669; cv=none; b=s5yo9YM3uKX2V4XMjn0x33HLFVhiEVN6nlS3f39NKc45h9DCYiXSRtUIR23sOFriKYu1TMeKPNHq8LniEkIShJs/w9DhJxLA7xz7rCABpogKWTs4gXE5bHxl2ZrBYtasO+kzw+3bM9MszOEjlqyMEIHCSf4IoGF80K4HT17vbdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760347669; c=relaxed/simple;
	bh=0so9Nv2w1Nst29QNWmqGECw2nex+MrB15ihNyBFUgkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z9k+NiUwcoDJI8Al71eR12peXhlKaDFTvqtgxyoBFLNNt8ll5Rvsuzo3cLjKPLwEPSEdEQt7KnAywvsvKNx9pblYU/agvBwb5EaVw3W9HwsyLeM/9P9fIoJ2UO/Dx9uJDHiUiagkUzAzOVyJoW+9M8IhsjPr5Cv9BHbcXKGvONU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdUyppxd; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdUyppxd"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b58445361e8so3285773a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760347667; x=1760952467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=33Yue8BtCN77Y+mpJdjQyPFAqeEOnq6m8WWwr+VUWDQ=;
        b=VdUyppxd09r+n+zqg1ksN4uUZSdzc0JuXPPTTVxWDhmp6RPrmifPzON60FJ60Yp+KQ
         Qz2+V1d9qA9ROUM4KCsNyyc4vRN2tuFgpnEExd2Wl6vhVyU2R/88FyuxtBoJjI0a9Xuc
         95vVibctTcZi5e/T4J7AxAbKimHcQZZAQaAb7PYZBquFfkpYqnmYjwlWotR+L9r9tMdm
         cKplSHyrIb3CfxiUCrmEVEeh/qXrpQBxCTbySqdylh2CvgEj7E+/ot5JCONCkP2CWk0q
         vckBhzAMF8pOHe/blYshEHHIJh6ftnzjdf0Hcb7BVAUCmlzrX3Spglzy/IdzZQB7tofb
         UzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760347667; x=1760952467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33Yue8BtCN77Y+mpJdjQyPFAqeEOnq6m8WWwr+VUWDQ=;
        b=Jr/GshMv6YN/U94RLpZEnt9BE1dLSz1wybh9KhOTgnfvJmTsAw6WElK0GW6ZkaBcBP
         2vYbUYfwMrSfDafl746Ogq5I1wzCWJSYg5kSDfzh1aSb/7GW9oJvIjszk3h4Y298bCL+
         p/H1FNXoL+g7v57hXnVgHKNhiiMEgOVIoFrVha4UkBF8FytNi06NI1eyKFdNoUR6IDt5
         baUa3k0L4OHVzFegE5kAX+u+Vx4IpMJFs/n6HnfYackavE56yfIlYdlPhi+3VaRk0fYN
         dN63x+bwe4kBb+qv4gA1XKIquHiOZK19H0ljCp+x67c+SDT4PUa2XodyNmhnwRLQsBhP
         BLZA==
X-Forwarded-Encrypted: i=1; AJvYcCXpLESP0GxlfM096s1sw1Z99egRfnu+KPw1iIhjJHPnxzbw/hgC5IMTGycadSkbV4PBK4Z+IuJwN9iQLJJH7t3Yf+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ+7t1mFffYGntd2vhp47NIKykBR4MAWZMQnES3T2VwvuCmGaG
	GO8LedjMKMNWKUIL0M77fFDlwcOPExCFQ9Q79ONKyvrOv4XOpAhRZiTNLKHnq0Vs
X-Gm-Gg: ASbGncvVHdaGr4jiVzcL8VF4IrF214HKczS6E8TdI/YUWN9ZqKBBXQ9ojDzJ67uXthP
	bZwhZFg0Dr3aba+Xi42QCpUIygwWiJiKR+QaTMepgJkllV0ttiFNC8phM4nRzL7MnqPlvdO9m0P
	48WlZ64MqqbMcHm1vzcIoLUBNfpeRNXnhk3MGC85wohJsy3RwX4mxtNpQogxVyHjxJCz51Pw/+0
	LueJG7ZR6wW+2wuTPhr+fkxLABiAdROqRMk1yvW0UgE6Y3gT1GeX5ZjkCQeFUkgqnI0YwJ/B0X9
	Ffxhv5xw72ruLV+DpRg7NplGJ34c2o2Rbt1cb9MWMYGBO9EAFr4aBW/CTjzsjovmxvZyESgUQsW
	9KffmEMmpi+8bkhoaqH+kTm+XabjrSgF79YkxW+gxQ4l2
X-Google-Smtp-Source: AGHT+IEVOVjuVmGlAswunThnXgHEbstlR3zgA2EaNSi9B1tFIwcbWkyGD5c8pcJmY6UIxDqFiEkzGg==
X-Received: by 2002:a17:903:298c:b0:267:9601:dca0 with SMTP id d9443c01a7336-29027f3b996mr240561515ad.27.1760347666660;
        Mon, 13 Oct 2025 02:27:46 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de658bsm128507125ad.22.2025.10.13.02.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 02:27:45 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id B1BED409E678; Mon, 13 Oct 2025 16:27:43 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Tomas Glozar <tglozar@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Gopi Krishna Menon <krishnagopi487@gmail.com>
Subject: [PATCH] Documentation/rtla: rename common_xxx.rst files to common_xxx.txt
Date: Mon, 13 Oct 2025 16:27:20 +0700
Message-ID: <20251013092719.30780-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13395; i=bagasdotme@gmail.com; h=from:subject; bh=gSBGOKA6gSHb608cBgAu3Jqy0KbAHZwaPbwuL+Hj0/w=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlvjk6suDiN48ZH7TirrMXr/T6fL3l0kvPeNSEO3o/z8 pZEnJod31HKwiDGxSArpsgyKZGv6fQuI5EL7WsdYeawMoEMYeDiFICJ3FFjZDj96cbnbW+Mpry1 Et/t7Lxvy51D7Stmb/x/TPLRpHUvZ4pPYfjDmenDKp//jeuz9NZdtV5nGd56zC1vazz2yHhP+he GZf84AQ==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

From: Gopi Krishna Menon <krishnagopi487@gmail.com>

Sphinx reports htmldocs errors:

Documentation/tools/rtla/common_options.rst:58: ERROR: Undefined substitution referenced: "threshold".
Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitution referenced: "tool".
Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitution referenced: "thresharg".
Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitution referenced: "tracer".
Documentation/tools/rtla/common_options.rst:92: ERROR: Undefined substitution referenced: "tracer".
Documentation/tools/rtla/common_options.rst:98: ERROR: Undefined substitution referenced: "actionsperf".
Documentation/tools/rtla/common_options.rst:113: ERROR: Undefined substitution referenced: "tool".

common_*.rst files are snippets that are intended to be included by rtla
docs (rtla*.rst). common_options.rst in particular contains
substitutions which depend on other common_* includes, so building it
independently as reST source results in above errors.

Rename all common_*.rst files to common_*.txt to prevent Sphinx from
building these snippets as standalone reST source and update all include
references accordingly.

Link: https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#substitutions
Suggested-by: Tomas Glozar <tglozar@redhat.com>
Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
Reviewed-by: Tomas Glozar <tglozar@redhat.com>
Fixes: 05b7e10687c6 ("tools/rtla: Add remaining support for osnoise actions")
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Link: https://lore.kernel.org/r/20251008184522.13201-1-krishnagopi487@gmail.com
[Bagas: massage commit message and apply trailers]
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
This patch targets trace/fixes branch of linux-trace.git tree.

 .../{common_appendix.rst => common_appendix.txt}     |  0
 ...mmon_hist_options.rst => common_hist_options.txt} |  0
 .../rtla/{common_options.rst => common_options.txt}  |  0
 ...escription.rst => common_osnoise_description.txt} |  0
 ...snoise_options.rst => common_osnoise_options.txt} |  0
 ...common_timerlat_aa.rst => common_timerlat_aa.txt} |  0
 ...scription.rst => common_timerlat_description.txt} |  0
 ...erlat_options.rst => common_timerlat_options.txt} |  0
 ...common_top_options.rst => common_top_options.txt} |  0
 Documentation/tools/rtla/rtla-hwnoise.rst            |  8 ++++----
 Documentation/tools/rtla/rtla-osnoise-hist.rst       | 10 +++++-----
 Documentation/tools/rtla/rtla-osnoise-top.rst        | 10 +++++-----
 Documentation/tools/rtla/rtla-osnoise.rst            |  4 ++--
 Documentation/tools/rtla/rtla-timerlat-hist.rst      | 12 ++++++------
 Documentation/tools/rtla/rtla-timerlat-top.rst       | 12 ++++++------
 Documentation/tools/rtla/rtla-timerlat.rst           |  4 ++--
 Documentation/tools/rtla/rtla.rst                    |  2 +-
 17 files changed, 31 insertions(+), 31 deletions(-)
 rename Documentation/tools/rtla/{common_appendix.rst => common_appendix.txt} (100%)
 rename Documentation/tools/rtla/{common_hist_options.rst => common_hist_options.txt} (100%)
 rename Documentation/tools/rtla/{common_options.rst => common_options.txt} (100%)
 rename Documentation/tools/rtla/{common_osnoise_description.rst => common_osnoise_description.txt} (100%)
 rename Documentation/tools/rtla/{common_osnoise_options.rst => common_osnoise_options.txt} (100%)
 rename Documentation/tools/rtla/{common_timerlat_aa.rst => common_timerlat_aa.txt} (100%)
 rename Documentation/tools/rtla/{common_timerlat_description.rst => common_timerlat_description.txt} (100%)
 rename Documentation/tools/rtla/{common_timerlat_options.rst => common_timerlat_options.txt} (100%)
 rename Documentation/tools/rtla/{common_top_options.rst => common_top_options.txt} (100%)

diff --git a/Documentation/tools/rtla/common_appendix.rst b/Documentation/tools/rtla/common_appendix.txt
similarity index 100%
rename from Documentation/tools/rtla/common_appendix.rst
rename to Documentation/tools/rtla/common_appendix.txt
diff --git a/Documentation/tools/rtla/common_hist_options.rst b/Documentation/tools/rtla/common_hist_options.txt
similarity index 100%
rename from Documentation/tools/rtla/common_hist_options.rst
rename to Documentation/tools/rtla/common_hist_options.txt
diff --git a/Documentation/tools/rtla/common_options.rst b/Documentation/tools/rtla/common_options.txt
similarity index 100%
rename from Documentation/tools/rtla/common_options.rst
rename to Documentation/tools/rtla/common_options.txt
diff --git a/Documentation/tools/rtla/common_osnoise_description.rst b/Documentation/tools/rtla/common_osnoise_description.txt
similarity index 100%
rename from Documentation/tools/rtla/common_osnoise_description.rst
rename to Documentation/tools/rtla/common_osnoise_description.txt
diff --git a/Documentation/tools/rtla/common_osnoise_options.rst b/Documentation/tools/rtla/common_osnoise_options.txt
similarity index 100%
rename from Documentation/tools/rtla/common_osnoise_options.rst
rename to Documentation/tools/rtla/common_osnoise_options.txt
diff --git a/Documentation/tools/rtla/common_timerlat_aa.rst b/Documentation/tools/rtla/common_timerlat_aa.txt
similarity index 100%
rename from Documentation/tools/rtla/common_timerlat_aa.rst
rename to Documentation/tools/rtla/common_timerlat_aa.txt
diff --git a/Documentation/tools/rtla/common_timerlat_description.rst b/Documentation/tools/rtla/common_timerlat_description.txt
similarity index 100%
rename from Documentation/tools/rtla/common_timerlat_description.rst
rename to Documentation/tools/rtla/common_timerlat_description.txt
diff --git a/Documentation/tools/rtla/common_timerlat_options.rst b/Documentation/tools/rtla/common_timerlat_options.txt
similarity index 100%
rename from Documentation/tools/rtla/common_timerlat_options.rst
rename to Documentation/tools/rtla/common_timerlat_options.txt
diff --git a/Documentation/tools/rtla/common_top_options.rst b/Documentation/tools/rtla/common_top_options.txt
similarity index 100%
rename from Documentation/tools/rtla/common_top_options.rst
rename to Documentation/tools/rtla/common_top_options.txt
diff --git a/Documentation/tools/rtla/rtla-hwnoise.rst b/Documentation/tools/rtla/rtla-hwnoise.rst
index 3a7163c02ac8e8..26512b15fe7ba5 100644
--- a/Documentation/tools/rtla/rtla-hwnoise.rst
+++ b/Documentation/tools/rtla/rtla-hwnoise.rst
@@ -29,11 +29,11 @@ collection of the tracer output.
 
 OPTIONS
 =======
-.. include:: common_osnoise_options.rst
+.. include:: common_osnoise_options.txt
 
-.. include:: common_top_options.rst
+.. include:: common_top_options.txt
 
-.. include:: common_options.rst
+.. include:: common_options.txt
 
 EXAMPLE
 =======
@@ -106,4 +106,4 @@ AUTHOR
 ======
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla-osnoise-hist.rst b/Documentation/tools/rtla/rtla-osnoise-hist.rst
index 1fc60ef2610677..007521c865d97e 100644
--- a/Documentation/tools/rtla/rtla-osnoise-hist.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-hist.rst
@@ -15,7 +15,7 @@ SYNOPSIS
 
 DESCRIPTION
 ===========
-.. include:: common_osnoise_description.rst
+.. include:: common_osnoise_description.txt
 
 The **rtla osnoise hist** tool collects all **osnoise:sample_threshold**
 occurrence in a histogram, displaying the results in a user-friendly way.
@@ -24,11 +24,11 @@ collection of the tracer output.
 
 OPTIONS
 =======
-.. include:: common_osnoise_options.rst
+.. include:: common_osnoise_options.txt
 
-.. include:: common_hist_options.rst
+.. include:: common_hist_options.txt
 
-.. include:: common_options.rst
+.. include:: common_options.txt
 
 EXAMPLE
 =======
@@ -65,4 +65,4 @@ AUTHOR
 ======
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla-osnoise-top.rst b/Documentation/tools/rtla/rtla-osnoise-top.rst
index b1cbd7bcd4aed2..6ccadae3894570 100644
--- a/Documentation/tools/rtla/rtla-osnoise-top.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-top.rst
@@ -15,7 +15,7 @@ SYNOPSIS
 
 DESCRIPTION
 ===========
-.. include:: common_osnoise_description.rst
+.. include:: common_osnoise_description.txt
 
 **rtla osnoise top** collects the periodic summary from the *osnoise* tracer,
 including the counters of the occurrence of the interference source,
@@ -26,11 +26,11 @@ collection of the tracer output.
 
 OPTIONS
 =======
-.. include:: common_osnoise_options.rst
+.. include:: common_osnoise_options.txt
 
-.. include:: common_top_options.rst
+.. include:: common_top_options.txt
 
-.. include:: common_options.rst
+.. include:: common_options.txt
 
 EXAMPLE
 =======
@@ -60,4 +60,4 @@ AUTHOR
 ======
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla-osnoise.rst b/Documentation/tools/rtla/rtla-osnoise.rst
index c129b206ce3484..540d2bf6c15247 100644
--- a/Documentation/tools/rtla/rtla-osnoise.rst
+++ b/Documentation/tools/rtla/rtla-osnoise.rst
@@ -14,7 +14,7 @@ SYNOPSIS
 DESCRIPTION
 ===========
 
-.. include:: common_osnoise_description.rst
+.. include:: common_osnoise_description.txt
 
 The *osnoise* tracer outputs information in two ways. It periodically prints
 a summary of the noise of the operating system, including the counters of
@@ -56,4 +56,4 @@ AUTHOR
 ======
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla-timerlat-hist.rst b/Documentation/tools/rtla/rtla-timerlat-hist.rst
index 4923a362129bbd..f56fe546411bd4 100644
--- a/Documentation/tools/rtla/rtla-timerlat-hist.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-hist.rst
@@ -16,7 +16,7 @@ SYNOPSIS
 DESCRIPTION
 ===========
 
-.. include:: common_timerlat_description.rst
+.. include:: common_timerlat_description.txt
 
 The **rtla timerlat hist** displays a histogram of each tracer event
 occurrence. This tool uses the periodic information, and the
@@ -25,13 +25,13 @@ occurrence. This tool uses the periodic information, and the
 OPTIONS
 =======
 
-.. include:: common_timerlat_options.rst
+.. include:: common_timerlat_options.txt
 
-.. include:: common_hist_options.rst
+.. include:: common_hist_options.txt
 
-.. include:: common_options.rst
+.. include:: common_options.txt
 
-.. include:: common_timerlat_aa.rst
+.. include:: common_timerlat_aa.txt
 
 EXAMPLE
 =======
@@ -110,4 +110,4 @@ AUTHOR
 ======
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla-timerlat-top.rst b/Documentation/tools/rtla/rtla-timerlat-top.rst
index 50968cdd2095a1..7dbe625d0c4243 100644
--- a/Documentation/tools/rtla/rtla-timerlat-top.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-top.rst
@@ -16,7 +16,7 @@ SYNOPSIS
 DESCRIPTION
 ===========
 
-.. include:: common_timerlat_description.rst
+.. include:: common_timerlat_description.txt
 
 The **rtla timerlat top** displays a summary of the periodic output
 from the *timerlat* tracer. It also provides information for each
@@ -26,13 +26,13 @@ seem with the option **-T**.
 OPTIONS
 =======
 
-.. include:: common_timerlat_options.rst
+.. include:: common_timerlat_options.txt
 
-.. include:: common_top_options.rst
+.. include:: common_top_options.txt
 
-.. include:: common_options.rst
+.. include:: common_options.txt
 
-.. include:: common_timerlat_aa.rst
+.. include:: common_timerlat_aa.txt
 
 **--aa-only** *us*
 
@@ -133,4 +133,4 @@ AUTHOR
 ------
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla-timerlat.rst b/Documentation/tools/rtla/rtla-timerlat.rst
index 20e2d259467fd0..ce9f57e038c37f 100644
--- a/Documentation/tools/rtla/rtla-timerlat.rst
+++ b/Documentation/tools/rtla/rtla-timerlat.rst
@@ -14,7 +14,7 @@ SYNOPSIS
 DESCRIPTION
 ===========
 
-.. include:: common_timerlat_description.rst
+.. include:: common_timerlat_description.txt
 
 The **rtla timerlat top** mode displays a summary of the periodic output
 from the *timerlat* tracer. The **rtla timerlat hist** mode displays
@@ -51,4 +51,4 @@ AUTHOR
 ======
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla.rst b/Documentation/tools/rtla/rtla.rst
index fc0d233efcd5df..2a5fb7004ad448 100644
--- a/Documentation/tools/rtla/rtla.rst
+++ b/Documentation/tools/rtla/rtla.rst
@@ -45,4 +45,4 @@ AUTHOR
 ======
 Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
An old man doll... just what I always wanted! - Clara

