Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7484137107E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Jul 2026 05:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784871904; cv=none; b=eh0OwWVNV85zjogQiXwdeE69m9GRwe2AeZm8uE4U7aWDLpLwio9Bl9m/+0kVLj6UTBuXPtlD9zmfIU90fRe0tCZI0uTSniOSyBcpuZ3YDoquaFdXXWlzRQuIrIrnamdp7/XXmCYLraur64P+5Jxpc9n3U0xeK2Z1T9UNZcgWlfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784871904; c=relaxed/simple;
	bh=yp2ixHulnRwQjml/J9icvdHP60hwOOjL5mg46RkEjQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A4WuD4G7mnm4994bR+uKPT/UO2TLU4EwOBIaqI9AoxjZyRPjrPBYI5mGi+2fM9TaeNMwyuf/ft7J/uJC5o8sTMaCO3Lr3HqXHNwICAoWZCKpguZnAkXukwzjaG7nsDxiB7OLbHSOflWe7Iy8EpLn64WW6XfUXQyouXllkU8Lqd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcLBy6eM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcLBy6eM"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cca0c5799eso875535ad.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 22:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784871903; x=1785476703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HkKqVuUdfMR112SS1ZnVHkoYFYO3AQyC+rGlEIbNqZ4=;
        b=KcLBy6eMY5zghjqTGpvyPfBgKlB6Pbl8DNGEPEuRcP/JcSvGo4pc5m5ippDMh1gThr
         JwnQ2Mn7VJJecM8C+C5Ce/E+046O0PfWRAV/5OqG9tHYexKi/w4ymh8c3OfQAJme7EQ8
         I8Af2a3+DTjecKxoW/eBRlHzZLy/u3BP391XL4Y1al5hjQ7Y8ruKHu2HAjuGYRamA8WB
         ATIJAW3MQlYjMJjth2R9IQynqDkbMuFYwuIhlXk4lNvpvET8jM8dZdmQhJXAqN+s2qYi
         GV8YXjW7QNNODRZCaGM4THx5efw9sRblkC4cx4w3Ztjt86aSIDd4COZcSuDmTeBgefCw
         aLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784871903; x=1785476703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HkKqVuUdfMR112SS1ZnVHkoYFYO3AQyC+rGlEIbNqZ4=;
        b=VN/+AqxL9t8Fly5uhjCMYAvS/y03Cyk0XBVOo8/9drLIc99RYIILReYVDz4dEoqvTE
         VyhoHqwtcJEBD4rEiQax4c9wlh6StyUMJONi6xVl7W7W0Rdd+dee0gzIn9X3trDifpDh
         qU5wpDVYNAjk/ZEUPbJZZQiNrt4NmJx9wxWpViFjF558netanGS1vaKPjhfvw2cTgmQg
         vc/L+kj9jWyocprjW3Dc7Ls61E0HrXhilvfnCvlN6Qon1oLBLT93nsSXgor3QlIePvCd
         Z/jFWLmINkLR5yCAx2RkKDSWTDxGVKLAqnAcqtuk+jKOoZ8ZyhmtPc17TEBkwheU/+5O
         1vnQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro/+BBcD4gXIYSjSWBh+fm9Rvh0CKSiewXfvS849zl0iEYN5O5k0RaW2zGVWMSvF/t3qEZshSmUa5nEbvlJZMwXYuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YymGf4khKyezpomnPDApSBnZrblBzuF1YmBa3Rrm5gnyA3vvjp9
	gwW5YuMKyWMV/FsJyKZjsgBoltsKlhd7ukD5/ckVG8CplCqXccbCEQp0
X-Gm-Gg: AR+sD12zWPl+EW5spKe6HZHaiODt3ebjrNS0LXSmHaQPqmbq/QomO6LYoBtGE9H0yOw
	8GYV+F43Qfq49wKrWivUOb8sWzkUHl13jkq1dE+YuPAH/ByRdCezPeZgdhh9AL+rLS+4kH1I3q5
	zQvr7t4xW5iTCVCSRb2JNQ4UUpBq7dp8xuRTKksWNMm9wNxjTuja6OevqDpwUNSuzTu4acNmJrM
	wgGTJM3pepNfxm+HfvpXwUVIINuPmzZt3ETvqHqn9fCwN8FuItoD8wEdEM0wwIsu/VmwDfHgy9Q
	mwHYAsTrovQeoUqmjPvwsvdPq7dZPIaUJGhMTKuVQAVujAgxHZafePLSYh+3TZz4PgJA6Bs/E2t
	Gqufd8w9fkheg/FnZtIw+xmnBTwFEUS3G78i9eiZuguo9UiZ68i1zL72kulN34vutnv/wKYmTZY
	lj56px5pjZySulnAvscA==
X-Received: by 2002:a05:6a21:a4a:b0:3bf:a489:1483 with SMTP id adf61e73a8af0-3c44b047bb1mr6643146637.33.1784871902688;
        Thu, 23 Jul 2026 22:45:02 -0700 (PDT)
Received: from lenovo-thinkbook.lan ([114.143.209.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147df097e0sm26776551eec.17.2026.07.23.22.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 22:45:02 -0700 (PDT)
From: Raushan Patel <raushan.jhon@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raushan Patel <raushan.jhon@gmail.com>
Subject: [PATCH] tracing/probes: Reject $arg0 in meta argument expansion
Date: Fri, 24 Jul 2026 11:14:35 +0530
Message-ID: <20260724054435.146279-1-raushan.jhon@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

traceprobe_expand_meta_args() parses $argN with simple_strtoul() and
calls sprint_nth_btf_arg(n - 1, ...). For $arg0, n is 0 so the index is
-1. Because ctx->nr_params is signed, the "idx >= nr_params" guard in
sprint_nth_btf_arg() does not catch the negative index, and
ctx->params[-1].name_off is read out of bounds.

The normal per-argument path (parse_probe_vars()) already rejects
$arg0 via its argument-number check, but meta-argument expansion runs
before per-argument parsing and substitutes the value first, bypassing
that check.

Reject $arg0 explicitly during expansion.

Fixes: 18b1e870a496 ("tracing/probes: Add $arg* meta argument for all function args")
Signed-off-by: Raushan Patel <raushan.jhon@gmail.com>
---
 kernel/trace/trace_probe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 506e6037e163..c8fd9b946f44 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1901,7 +1901,11 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 				trace_probe_log_err(0, BAD_VAR);
 				return ERR_PTR(-ENOENT);
 			}
-			/* Note: $argN starts from $arg1 */
+			/* Note: $argN starts from $arg1, so $arg0 is invalid. */
+			if (n == 0) {
+				trace_probe_log_err(0, BAD_ARG_NUM);
+				return ERR_PTR(-EINVAL);
+			}
 			ret = sprint_nth_btf_arg(n - 1, type, buf + used,
 						 bufsize - used, ctx);
 			if (ret < 0)
-- 
2.53.0

