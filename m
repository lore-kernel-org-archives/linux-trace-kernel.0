Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9694401486
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 19:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773342709; cv=none; b=DAIcG4DlBIg9GiiAVGwCXCkywr3p1f8Q/IQ/NYtbMJu6mgVfe2FOXsD2GDRPJqnokLk9y80GWDCuS76M/6AlIxMZYLjd9FI7cmT2aINmFPKjogyv8l41d8PO4YL8xKIx8Oe195mztScE7fGxAahPf1Rl4qmTcEAEyh+SYsU1jo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773342709; c=relaxed/simple;
	bh=K7t6TixnSC5amlbb+BTN1wgZlFUmLS7pMFxwMr59PtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bguO3a+l7eILjd9mzMJPnRJNzQ/bc96WVMSg48r4PuCALEqN9Gx0wyGp+6tt5d70r9OiggeA5Wm97zYGIIqnsu3US7EAHz0tdGVyIOo6fAGPr8A9h03jh6Re69LgaZjrsMfr0qwGu5aGN2JcBc9fCKZZtViTbM0CiOEwVmXLA/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYmO7q1s; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYmO7q1s"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so1826518e87.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 12:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773342706; x=1773947506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSs15jicLNxatcInmbAogDjkpXKXGRLDfNz1kmJ6CQE=;
        b=lYmO7q1sbbgbMiLOMOXLnU7e8gcWBcRgYanoKlaomR0/nGWcXNhNdr0DN0hSt84mTw
         UOpPcuLW8uC69uj24xJCTacugzW+LDn9yEWLQX7RA0Vt9SBQRBffRp7PAhYBOTlJlYRN
         fn5FpQN4MqO/FK9o6bFqud4a6Zeh5WLOYVvTx6ljlHk66Adr3Gkk0yHsXbEZ4yP3XhZl
         J7dEAt59XExfvDw8nC9Lntvm0eyEqPw9JQDjw/sQmDSk5Xk9SzquSMD4bCRsBbYjVS8s
         rxUzORJKWx7uot3LCqu0YpfEPXnramZ9RKhhU2NJozaiJg+0e5pnds6YMos61UdGxBLL
         rcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773342706; x=1773947506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oSs15jicLNxatcInmbAogDjkpXKXGRLDfNz1kmJ6CQE=;
        b=NcqncDtTGjzsEW++yzND3//tvQ/lWB4cuZnTFeTU1TOhfPLgAvDvjKTVRYGvhm6wiP
         21kirw1d/eeqha1CpX8FDShgsXKF5IW4yY95OTDFxTevNHY5V9dMdAxWw6BVoDL2ytjD
         +Du6ijq/sGxd2/AYf7COwYN72/7nqvoxt9Ch+Fnr3dqQcCygItBHOC6Bqr/DgYxoylXM
         7y2fnJaLSt0r/ohZxvG81MjBqTWLhrRG2Gr3gZnGpV0AHUusni9cNEWhPJsc2LC5NJgL
         NZK2MGyFQsJsU6JZ11lA8ZrCrknff7ZSiIXoXZCEKifudN0iKX+F7khFmczVk7GBWiU+
         gN/w==
X-Forwarded-Encrypted: i=1; AJvYcCVGwEv52v/HT6AjRM/ymr3mqGEebrjYQQ/2kZQFAquLAsGjfx+wWNJjc5fSOjP3NA4CEH4SpgR0k9v/SkSIyMa0ZoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqfGvo86Lp3IWu8yh0MjvLSHd78EAIhOMTJ97Sd1VNWgkXyrNY
	QZTzTy6v6YWEeTFhWR61jAJdE48t/lz2E4epxFt+ItsLfOHDAWCXrEAMoWWH8Lr1
X-Gm-Gg: ATEYQzw9XVMgZGIi4Obj8BILpQ3XRav1WOGnJbiFhyRbcvrkbus6skH4WJ8cHj9xMtB
	CMdZ4onVl1eHofjIdMxIfON4AjvLSJEJnnGLRsoHx9uegz7SqyVYHvdCOO7KT4SjupYzUpb0L71
	cf2ncR2vfOTl0LCJcEXxqJpuwh9+sj8+WV+K84ftdqYAKI/TanKEnEm3MuLKNlmZ+4Mt12+ksM1
	z/8hORnFzsICeZWx4ldETdT0uJQIFBIQgGFMBW90NiiaMY17UhnrtEPF2QvA+ab1jNj/q4u7Q+f
	aaW5nYC0yG6N++Ds5YeKClbsgBFlfe1kd0tyxtY0GnBebAU/iFIfm/CME5s6F4t8iaxA3zB8pDS
	nudG2wTLzChO9EtUx1dAW3MNyAztdEPXns0cDo0BWetLG3wUkv4xibJIchY3AYOpMcqgmLzyRBm
	W39Rz8Zqned4g/etZt4haaDpdmpuGQKqiquCy+KSZ4JQxXlXLvZKMGNli0ps/q4Wv5+WVTC30=
X-Received: by 2002:a05:6512:31c1:b0:5a1:43cc:9fbd with SMTP id 2adb3069b0e04-5a162b06cfamr197164e87.36.1773342705775;
        Thu, 12 Mar 2026 12:11:45 -0700 (PDT)
Received: from ubuntu.. (static.159.107.27.37.clients.your-server.de. [37.27.107.159])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a156375198sm1112249e87.88.2026.03.12.12.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 12:11:44 -0700 (PDT)
From: Josh Law <hlcj1234567@gmail.com>
X-Google-Original-From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Josh Law <objecting@objecting.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] lib/bootconfig: check bounds before writing in __xbc_open_brace()
Date: Thu, 12 Mar 2026 19:11:42 +0000
Message-Id: <20260312191143.28719-3-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312191143.28719-1-objecting@objecting.org>
References: <20260312191143.28719-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josh Law <objecting@objecting.org>

The bounds check for brace_index happens after the array write.
While the current call pattern prevents an actual out-of-bounds
access (the previous call would have returned an error), the
write-before-check pattern is fragile and would become a real
out-of-bounds write if the error return were ever not propagated.

Move the bounds check before the array write so the function is
self-contained and safe regardless of caller behavior.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index a1e6a2e14b01..62b4ed7a0ba6 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -532,9 +532,9 @@ static char *skip_spaces_until_newline(char *p)
 static int __init __xbc_open_brace(char *p)
 {
 	/* Push the last key as open brace */
-	open_brace[brace_index++] = xbc_node_index(last_parent);
 	if (brace_index >= XBC_DEPTH_MAX)
 		return xbc_parse_error("Exceed max depth of braces", p);
+	open_brace[brace_index++] = xbc_node_index(last_parent);
 
 	return 0;
 }
-- 
2.34.1

