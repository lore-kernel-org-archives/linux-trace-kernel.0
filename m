Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AB93E8345
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746801; cv=none; b=cIbmM1rLr9Obilf7CLTeweeNIVZZZfGwwA8VZ+91tBwwsXxbC0NyuXOf4BPeYZFOnQ2NAp5sWz1lNxHjHAEJqF3+KFZwi+W37fArHdsNsfAkTCO0bcOfTZLgvNm8GJOjZKoEWA26Ycitq7jK9FgwBv5sneRl4VOugs2HiWQ8lms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746801; c=relaxed/simple;
	bh=53qVlCkjPEAghXQTAvM5OIhcWm/iMVOx3RjSY83UM3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dL4yxf0uxw+r3nvHgZS+E2aQQI3SSPIZzzqxAU7TdUhOma9PKxXjDCveqpugN4xc1trhcujpvvZMf1gI0R+QDsYKe9BRivpdkfLw76pe1YolwMKuuPlfUEfs5sMbKWHpdRbbR4AKC2X5SDozpALEiVQzv6kfucaz+IBGxI6wR2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=ek+mBRNi; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="ek+mBRNi"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51bfb91795eso8030271cf.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 08:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1782746799; x=1783351599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uo9qqQT1HhLcaACp/Mr7EDXYSbliJVG9YBYTx1Ho1dY=;
        b=ek+mBRNiUItbXo8UFGciZcBKkFMvaZAeRA+kl8pjKEUNrTL91jPdQs0PafS1spKIYo
         HGPk4h6wvDWSelNP8uZ4U8yckTOjdVmS5nwekV/q87mv6homyk8YAc6VGq+o4IY3OSjg
         b5bHJXcDjR0jc732FqhtmhkgqfRY1HwYVi7aPcYPpwQrZ4jkfDhPV2aNqprrGTPrdGdG
         fWGWy6INry7g0Mq9Z90kB2nVJXoVXnwsG0OrDwaXMyNl/DtWksyiugpnVYlBnjklt3LN
         CzfGBor1GAWp71gW4SkFYgiGi1m3KZAFfIIrtuOTlg7AwrQwvRPgK5xtd+KWJj/0QWAh
         P4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782746799; x=1783351599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uo9qqQT1HhLcaACp/Mr7EDXYSbliJVG9YBYTx1Ho1dY=;
        b=LqinV/DMTIPevdjdA1JB8jx04xOHt95EhF+gkh4Jhnngdz/kfjgaklI1r9X0xZyYpa
         2PbMwggQX0BFsQaPwP5ahdZD5yD1vgIlMzTuDUL74LoHSwDleHCg1adLU+QIoNQqtJY4
         9XTaWSCGBRxxcBbutElIAb6eAYsmivYCsYa6q4WbaUxZ8tBPK0oP7XxDrQA+4nXWs5hc
         +hA7tbYsTMJunqwhbrB5nvGTRHZGPCrTtm1QkD1c4keCRWzylpOxiSIwyVp9rz1Em5P7
         VBSiXp7jf9LI7MwKZv8FkYwMQpWDTfhxTDg533hClyn3Q45hu6a3/GMlRdjRaaaToSz2
         UdKA==
X-Forwarded-Encrypted: i=1; AFNElJ82cnbT6zFnHYm4mF58MEpPpnaZNjEaXy18thlCnLiKi34B/lGDNPZBExD/9J48csBHw/eZcpIw3k+ZdeugkTj6cUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrex1AwgWmgcW6HfJJDzIn0ykJh2paeqZbJqoygn/tcxJfvUfG
	pKBwJaF8ZqtT8yTkAx23f/co3gdm6LFQmtkmp2JqVFrX2ToPtXYNquGYbd4GJUZ83dk=
X-Gm-Gg: AfdE7cm01Hk5zVW3NTebRf2/YwBzld89AUMYXpYFC1MxjtWyZ0lqIBp+1ep/eR0kxsm
	F1Gt2RNJeFsyyDXe7EgFjqoshJLkxZ+9w94huwq4Qp1QY4k8qxwk2OVRbjiTwswf5z4OGqoEqAg
	XJdiPLwl95MdVn0BuCkKnLHB93I6nBI5m2feNw4e5yKR3Dcr0GowylkWRs1iPC0+mAJHeAN0gU6
	sssXIRzbMuiNcR9lb33+BHshwHUrO/zIO8V52NOR2OyuvMDi2KkCa4QZIg3/JGHIuwXNLIEZepj
	uEukB0ooe1v/6IJsH4kZmzkmi62dkNk813q5Uz18L10+J3JE/8Srh1Sva4t/8zZVGmRsVGLhg38
	EKpgrO6mLpmKPTWvRFmuUyaaaM9PyMJTBP0/DmipnI6bLkM+7dQ7yo8qShkEGtL13esU4isyuOn
	T9n4Ah96Hc4IVnpYdg
X-Received: by 2002:a05:622a:1f1a:b0:51c:f3:34e3 with SMTP id d75a77b69052e-51c0c9ac15emr17841711cf.28.1782746799141;
        Mon, 29 Jun 2026 08:26:39 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-51a514b5271sm173231731cf.5.2026.06.29.08.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 08:26:37 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org (open list:FUNCTION HOOKS (FTRACE)),
	linux-trace-kernel@vger.kernel.org (open list:FUNCTION HOOKS (FTRACE))
Subject: [PATCH] samples/ftrace: Prevent division by zero when nr_function_calls is zero
Date: Mon, 29 Jun 2026 15:26:17 +0000
Message-ID: <20260629152616.107080.e19bfbed249c.ftrace-ops-zero-function-calls-div0@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ftrace-ops sample exposes nr_function_calls as a module parameter
and uses it as the divisor when printing the measured time per call.
Loading the module with nr_function_calls=0 skips the benchmark loop and
then divides the elapsed time by zero, crashing the kernel during sample
module initialization.

Keep accepting the parameter value, but report -1LL as the per-call
duration when the call count is zero instead of dividing by it.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 samples/ftrace/ftrace-ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/ftrace/ftrace-ops.c b/samples/ftrace/ftrace-ops.c
index 68d6685c80bd..e6c07da407cc 100644
--- a/samples/ftrace/ftrace-ops.c
+++ b/samples/ftrace/ftrace-ops.c
@@ -223,7 +223,7 @@ static int __init ftrace_ops_sample_init(void)
 
 	pr_info("Attempted %u calls to %ps in %lluns (%lluns / call)\n",
 		nr_function_calls, tracee_relevant,
-		period, div_u64(period, nr_function_calls));
+		period, nr_function_calls ? div_u64(period, nr_function_calls) : -1LL);
 
 	if (persist)
 		return 0;
-- 
2.43.0

