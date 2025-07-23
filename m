Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363E92E36F5;
	Wed, 23 Jul 2025 01:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753235570; cv=none; b=XSPAt0hUBynaNh3m8/ODg8ROFOhVkyA4WsmSkNxCL3d5dJfRnqscigoAieIRW+ZZF+PPCFhRcNFsAAcpncJNlyQ4rW3oB601g5SWGO4tzYm+xh/KUkntEtyXButlY1NhEdn2Pn3fa/gJOJYEalX0QMDfBWFeYzX0yr6WpzxKg2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753235570; c=relaxed/simple;
	bh=2qXmmy+cTdFP6seZe08xkBb+fmz0NjiJaLtfuIQQVAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BEAirnpO7UpHjJQ61SCdI9TZKmdGznc+3MeIr7KK7AzVw4VrKlQDtY6Dx7YWRljkXny9ODZ7/vvE58gavCFWsrRAoZC9iXwUnI33hbggPv9iXSwdjDPghAZojOWX1L2wMvNFzER8RRQ6TzdAM6o8LbcXMWzokeIArPU5Zy9L/TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXz8uHzh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXz8uHzh"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23f8bcce78dso18093145ad.3;
        Tue, 22 Jul 2025 18:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753235568; x=1753840368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y9U+s2a1F3chleG+uTMkQSX43augvoYTOtLwmtd5xsg=;
        b=iXz8uHzh/52Kre0LLXxrmSUzSw0XrXtd3wkXocEx0YNaqelCJPqXdRTltJE44XjnHd
         8ez1GEZsXwXZ2VyG3MFIE22z7HVrWoBI1/KNsa+c9KM6Nzx4Mt8eWiYdmHCcmYSvfELj
         Y++SNkHY60z+vWcM8YUaqzNghHduXmCKmGt1mmtq5F8u2L0ZhgPkfJnaSZixkxzqkRmk
         inH4MDjCSQ60Bi8HyxCItanTZjDgwM9fLlZ7VD/TRwv/sEUp/5HvuO2xZSjv7/1/N5J6
         J4BP4IFehVLH86S2QCajNaAJ7neo9MOa2szzaisiUerXoI/1XzRGYcYM9GYtJ8tO0wVc
         ktTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753235568; x=1753840368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y9U+s2a1F3chleG+uTMkQSX43augvoYTOtLwmtd5xsg=;
        b=usqzZts+tfgzF0Keny+a9IndtzS633EwTXGarLvfKR2tUqHh0+7N2ikglEJ8ss13QA
         SdASUCHS8lTL9WhHQS12b5DjBDuanpQjbHgufZSrqMmE5yGosw79DSi67pt0WdgGKSm+
         h7S07Lz/fwjxkOc7aWfYmChxZdcPKFT3Q/wMpGesaK5MJFEgem/Cb0nPvYhs+wq8+ldD
         dSrMyS9x9eROv0vr2SEDI7FoTjqf9JGMgCI6eSXL4tfmELl0uCgtI54qx5GSCryEpMxD
         KXxCDC1ggoTNJI0cbb93pSdRSsk1GsmCwHqvtX29qb2Rv0FUpYGvg5sMCJZlt6cy6Aro
         DDjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXy0qndSxVefIe6rwr9q4TlWDxa+nfH9KEb45PprOZsVHPJeWUkCrmMgAV5xylagFMmXf6w3oioN0=@vger.kernel.org, AJvYcCXKTSjUMf0ndozTzA9QR7wVozdLeVhvXeSWYyqm8znNGtqT07FTI6GG9EUCvx+1wmRfs8CwQm4K8/eOm0p/@vger.kernel.org, AJvYcCXQWtoMVjgkjb7kMHEvg5mATW9uoXfiJgNRIOIfDaVN4QWnkKGnoHLig2yJcJ7DSG9jmxHZr+3RCaRm7pggU1WFlMI/@vger.kernel.org
X-Gm-Message-State: AOJu0YzG8Cg7+I49tjhY+uEohjyVAU2fkMnGC0qO2oE4a7OqarJt/hxk
	Hc42PBujbxY8eO/J1JfJpvLLaCEJbdVMS7GGAniQeP8NX0QgGiNzA8GtFDo4PIb9
X-Gm-Gg: ASbGncs4NQvyuWgifHlv0eJW1+3TZw3RATXmVJSZOtwEWRT0YyOp9Lf082SHACgmqfK
	4VA7bjO6HHTBm2aQIY2lyuCtIfZgSN0XD2bn1C36mt17oAk2fPd7xpBWfBxL9r6YVngEJbeT1tb
	pJ2fwSLyiFw2KToc/VWE9+QFcES5GMfzw7eL1RRqEB3EwHk1uI33y2ojpAOmii9evO7++9PU73k
	dX8ihqlwXL4llxzfYtjkG91IOQEN3DIK1c+IEqI8e3pazuKuvGFRVuZG3kjU4CpnMnTcV++mB+f
	n/5DmtMYYa6k6KquSTuG0G3ltpm4cOZgaTqmvATV69L7p5fJgvTkeo13kBgkSgMISKijBuCBjbE
	tF9aLdUU47SBGJBpDz8hf8xiKSF0pPNDitG0vAkIifsUFjuvvcvtio8Hyhs6Jkvugd3t7T1faNF
	9gfhpciE2niQ==
X-Google-Smtp-Source: AGHT+IGtqGnR/DHB65wgefBnCF+0kio0fXUcp9jVe1tqMPc9wUGybr3jLOEt0yzlpErVdv8w0GK5qA==
X-Received: by 2002:a17:903:2281:b0:236:748f:541f with SMTP id d9443c01a7336-23f98195113mr13332355ad.33.1753235568287;
        Tue, 22 Jul 2025 18:52:48 -0700 (PDT)
Received: from ipravd-Nitro-AN515-55.hsd1.ca.comcast.net ([2601:646:a000:5fc0:f2ad:809f:6123:b09c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e475bsm84754475ad.29.2025.07.22.18.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 18:52:47 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: bristot@kernel.org,
	rostedt@goodmis.org,
	corbet@lwn.net,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>
Subject: [PATCH] rtla: clarify trace option syntax in documentation and usage help
Date: Tue, 22 Jul 2025 21:52:33 -0400
Message-ID: <20250723015233.173630-1-ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using `rtla timerlat {top,hist}`, the `-t/--trace` option is
optional. However, when providing a filename, the long option requires
an equal sign (`=`), i.e., `--trace=<file>`. This is because the
command-line parser treats `--trace` without `=` as a flag with no
value, leading to unexpected behavior.

Valid usage:
    - `-t[file]`
    - `-t=[file]`
    - `--trace=[file]`

Invalid usage:
    - `-t [file]`
    - `--trace [file]`

Clarify valid usage in documentation and help message.

Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
---
 Documentation/tools/rtla/common_osnoise_options.rst  | 2 +-
 Documentation/tools/rtla/common_timerlat_options.rst | 2 +-
 tools/tracing/rtla/src/timerlat_hist.c               | 2 +-
 tools/tracing/rtla/src/timerlat_top.c                | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/tools/rtla/common_osnoise_options.rst b/Documentation/tools/rtla/common_osnoise_options.rst
index d73de2d58f5f..0b73a55f1d1f 100644
--- a/Documentation/tools/rtla/common_osnoise_options.rst
+++ b/Documentation/tools/rtla/common_osnoise_options.rst
@@ -26,6 +26,6 @@
         Specify the minimum delta between two time reads to be considered noise.
         The default threshold is *5 us*.
 
-**-t**, **--trace** \[*file*]
+**-t**, **--trace**=\[*file*]
 
         Save the stopped trace to [*file|osnoise_trace.txt*].
diff --git a/Documentation/tools/rtla/common_timerlat_options.rst b/Documentation/tools/rtla/common_timerlat_options.rst
index 10dc802f8d65..8d55b590c7d0 100644
--- a/Documentation/tools/rtla/common_timerlat_options.rst
+++ b/Documentation/tools/rtla/common_timerlat_options.rst
@@ -22,7 +22,7 @@
         Save the stack trace at the *IRQ* if a *Thread* latency is higher than the
         argument in us.
 
-**-t**, **--trace** \[*file*]
+**-t**, **--trace**=\[*file*]
 
         Save the stopped trace to [*file|timerlat_trace.txt*].
 
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 36d2294c963d..b6e1275b0e71 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -730,7 +730,7 @@ static void timerlat_hist_usage(char *usage)
 		"	  -d/--duration time[m|h|d]: duration of the session in seconds",
 		"	     --dump-tasks: prints the task running on all CPUs if stop conditions are met (depends on !--no-aa)",
 		"	  -D/--debug: print debug info",
-		"	  -t/--trace[file]: save the stopped trace to [file|timerlat_trace.txt]",
+		"	  -t/--trace=[file]: save the stopped trace to [file|timerlat_trace.txt]",
 		"	  -e/--event <sys:event>: enable the <sys:event> in the trace instance, multiple -e are allowed",
 		"	     --filter <filter>: enable a trace event filter to the previous -e event",
 		"	     --trigger <trigger>: enable a trace event trigger to the previous -e event",
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 7365e08fe986..19ee98456e3f 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -496,7 +496,7 @@ static void timerlat_top_usage(char *usage)
 		"	  -d/--duration time[s|m|h|d]: duration of the session",
 		"	  -D/--debug: print debug info",
 		"	     --dump-tasks: prints the task running on all CPUs if stop conditions are met (depends on !--no-aa)",
-		"	  -t/--trace[file]: save the stopped trace to [file|timerlat_trace.txt]",
+		"	  -t/--trace=[file]: save the stopped trace to [file|timerlat_trace.txt]",
 		"	  -e/--event <sys:event>: enable the <sys:event> in the trace instance, multiple -e are allowed",
 		"	     --filter <command>: enable a trace event filter to the previous -e event",
 		"	     --trigger <command>: enable a trace event trigger to the previous -e event",
-- 
2.45.2

