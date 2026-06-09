Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4381EB5FD
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Jun 2026 00:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965894; cv=none; b=L8gPrDUFVpDGrqCQMGNozfPxzVRs5GrQGet9hO92csaZLeJBEe7XC6hIxxJ43FlRnevukeovIl4xvYC2vjtV15b5mmYMGDHJWqwLVUPHy09SYzHhqke1Tl66hJ210FP4e3lNJDaIEkGNzd2x88SXK8Cb63SDIlwgM7CrJER4FPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965894; c=relaxed/simple;
	bh=2s5QXwCjNF7CBLpvtDMmAQrtvHlhbjbdH8HK5RUzxPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jELQd5TGvSahFgfMPg2K7+cnvTmnUrTbCdZtgm/+ZDOGmEaS2bbyFMA/Us5+pcHufEAj9ljTn1M0rCey7q87wHKpDrAL1SiTxEdo82YzdnCoiEBd0OpgWBmqrFXhB+9Qea2K4ldIfSM1GOoGhiAdLnKTt0bZnndxyzUoB2HwGOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=GmNWk2t7; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="GmNWk2t7"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8cce8873b56so43145926d6.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 08 Jun 2026 17:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780965892; x=1781570692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nPaJ0Bp8d0wUqVOdniJtx4ojd3GCMIKZlv6eOQsYOyM=;
        b=GmNWk2t76y6zoAM4yrQCrp9RS/nBoAA9DVkujsVE16ei/ogOqui7Hzh8C/aosAMx2z
         31sIAp4W0ZraGhXSlTvKrKNk1QWwQxSDH8/MO7kvu+3hxrzflApmWlTd/sCNnujGo/Vg
         z407gpEp/3FOR7Ib1M4WG2NrIg84hQYOffBTqZl51djaiMZ9o2lw/4vldAjGT2ULMwTY
         cO4TZ4qxGPCF9ceeNrh+aRkUoc6o5l3NZ8YTHTZaXaTlET20ltrSYZdqRjSFkP8wQROj
         Sg0hcSSqDkBz4JpRjm7V/T0O3DVDKhuzVoUaU1nfBAPpvo5lYFW+ze/AKcxIneCLWnfK
         CsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780965892; x=1781570692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPaJ0Bp8d0wUqVOdniJtx4ojd3GCMIKZlv6eOQsYOyM=;
        b=TPOb/45VNKOqvgK5aFHS8m5SoadQsdd0vFekVfv3dMN0jaBega697IrEpLu+V2atDE
         3o4meN4s4ArkHkjGkUcGwWR6BiRF6bXPEcl+qtNOF9OVUnajT5NddiwxMsm/ijq2BCOi
         tjPgrvutREr5KIdDKivVNziE/uv5BNHIkwofZ/ONKS1NAW3JyWsvLedkbZiCzSWI8jtp
         Ldxdg79Q6xT6unRWNJpFm11vEovJf/2QNHFT3t/ViPXkesHn7I34a2A7r4lclV/LH1kO
         ZHK9mlviQueaY4FyzGFHddSxg4SqVcWuuS1mTeDolIMRg3LvNekixMWCimVG4fqukmsk
         S36Q==
X-Forwarded-Encrypted: i=1; AFNElJ9s5w10mO72wjPHnMPwdF69ZkcDLQaRKsccbPWhifppHirTm0vSa5k3HIWImVcQgUHp42qf7kzFTij2GGSQJGH3slw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAmy6zz59xVjEAmz55xxTBeQB8l9eKJoi8lR6I7WH56xfK5R5E
	/0pA2JA2SGAtJy4JZmF0SYOatVPyYVcW26/+as+rc5nlNLpvKFouk/k9NT4+d2XdLYnU04TKFDS
	dXW4OYf4=
X-Gm-Gg: Acq92OFA9qXU3B1NL0B8Bek9veivy3fI7a3YQ8Ym+BB9nFbgFFGlONkMUE11Vz3GnTw
	R5hOyzJ4/OATFt4QWsR73ylFjGedh5v1rOqMZMzNZfWJXnYWQ/fgTzSj1KDECJt/nVRzRiHXURs
	TvY0xpA25820rs+9b8OPDFxCiHPO1aV8TyRHWh/4F1mCpFnv83QAskynbptP/VpHhIQrklSjJDm
	fFV8keofYTyy9oU0fye44N9RYhniHKzV+zLU+R5Uk73QOwpLqRyjJZBcmdFDqHqketHkkLjWuRf
	eFdA6PeQkZxJ8Hw18qb5+PQidopzCw9rS7fl/5NGDiE1Xq83G+LOKXFoXxLtFGwG9lv4wE+ARAH
	lnVtodw4f7C/TLlvchW7OuUCYiO+stWhi3lJPXKGlby25wBZu3mkFLMRgo2HQbPxHXafucOhuZ1
	rWv4/VfXhLFGF0CXaVoIU/KJj0T8j/ZGvd/npVEu6o4C2iTmUB
X-Received: by 2002:a05:6214:3d9a:b0:8ca:1757:7ac4 with SMTP id 6a1803df08f44-8cee8c6a466mr225853946d6.27.1780965892600;
        Mon, 08 Jun 2026 17:44:52 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8cecd0535b0sm182302006d6.28.2026.06.08.17.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 17:44:51 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org (open list:FUNCTION HOOKS (FTRACE)),
	linux-trace-kernel@vger.kernel.org (open list:FUNCTION HOOKS (FTRACE))
Subject: [PATCH] samples/ftrace: reject zero ftrace-ops call count
Date: Tue,  9 Jun 2026 00:44:23 +0000
Message-ID: <20260609004422.1239735.f6c06011af32.ftrace-ops-zero-function-calls-div0@trailofbits.com>
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

Reject a zero call count before registering any ftrace ops.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 samples/ftrace/ftrace-ops.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/samples/ftrace/ftrace-ops.c b/samples/ftrace/ftrace-ops.c
index 68d6685c80bd..d5adaa61484f 100644
--- a/samples/ftrace/ftrace-ops.c
+++ b/samples/ftrace/ftrace-ops.c
@@ -190,6 +190,11 @@ static int __init ftrace_ops_sample_init(void)
 		tracer_irrelevant = ops_func_count;
 	}
 
+	if (!nr_function_calls) {
+		pr_err("nr_function_calls must be non-zero\n");
+		return -EINVAL;
+	}
+
 	pr_info("registering:\n"
 		"  relevant ops: %u\n"
 		"    tracee: %ps\n"
-- 
2.43.0

