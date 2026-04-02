Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DC930E84B
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Apr 2026 01:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775095183; cv=none; b=Cui7KLmld84dNjOBvaUDkngkonRZIFKEi/6SpTx1t2C2O+Fg7PYq78AWNUzH0WxcB/PF1i+yHfSVlFBO8+YOvk8wSvcYF9F8MEJSJ4/KF7Knn7s3jyxgfIpzAmUNBQBal98PcV1uqbvBuM+BzI+Sgl6MXW+FW78HlCeEl/aH0ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775095183; c=relaxed/simple;
	bh=BDcoGzUEgpCGDfndnWpejoVBe/vKuqQ4SnpVtpHMd0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NmFpaKvRSh/k5FMoKooCobSDwhtbOU0rsk5YFwFr/1JCWdY2T4gaSx2O4MAtO7Yb95WhCVB1j0tzsKuTO3/wGNkGJp1+Ez1b+WgTMfJp1JbYtU/JXkcLXwfpunPc5OKjIJkwQsZo3zUU0mi7k3rY2ys2/fbJDQw3kRS7qmA41Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JyUMCfsE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JyUMCfsE"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ab39b111b9so1301645ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Apr 2026 18:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775095182; x=1775699982; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzHrAn4/x3CwheBfg3e0ZTKZNKx+9iUkLN9KNaFrA10=;
        b=JyUMCfsEzJUvnAMUaH8pFk7JOJz5S6j4yc2RPRMEDvcR7+AHkR2RcjSaIaWqcS1bk1
         pYXgyC2RR8ANzfyWQI2dZu03PBe2k9eQDah7UHIYUoXK+HKo+CrxeS0+HybIbbmEtud1
         M3Tr2cQDeNwYp6bFGqBDUUyAFrSsM5AQoXgXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775095182; x=1775699982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fzHrAn4/x3CwheBfg3e0ZTKZNKx+9iUkLN9KNaFrA10=;
        b=dKygdltMN7KvHs4jCVSiGgvOzGe5Dmjb4X/1aAwU2FYRt8AmW44YO+bTXtxSDjdRBk
         ZEUFcvwkmGz231T238heXVRaAZRdgA3vc8v8/W9AE4R22KfKdGinJ35kX56VffAJT1LZ
         PI2dpVGGVE78vA/DQExKvvxFCrpxsOUJlsXlUd+Nmkjq3X1fKniJFPC8a4Uy+CeX+S68
         I40DaSRkIeULn2NYRPePzx+P3JA+q7rK1tfHRKEmykMMPc7B56zZ1l5eG/QTnnKkYO71
         aJ2QYF8xsTpekVxxKd0lxD7rK5J4ichnH55QI2aq5E3mrTCTGdTBmU1zJmAVaWzzD2BW
         1nHg==
X-Forwarded-Encrypted: i=1; AJvYcCXAXL5TJuGmdDLo4OUGiugSGV6deCPSYAeJF+qOQvmICMReCZmW+ATsv/USM35iomBiqvQ8w3TpQEBleyJtFyTqw/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4M2zOu3cy9Bay8GHKnNHFlJv20j1Qc9bY/p+CxCN1SBSW3HBS
	wH2aqsmCTLaf1ctNYSsKpr5NZZm9dIlWqweJqY5tw1PDbQYFc/+DRPvWAJ2eb32rlQ==
X-Gm-Gg: ATEYQzzUZdgzflZnZGLKLAljk5RX5Fi+ZuAASBzw4uIt+bT3uEoy3fE0zotAVQw3gql
	mUQEWxUxpkZxTApIwQ7I1NcQ+0DxkM8ppFzxQFTskEmRBnshzRGtN0hj750oyFm7/Gj0LJ7j12m
	HeFe+5ElmH6O9ptxyl1CDn1dITUP0ii10ZrCin1VgBlEo7ikQmNqTiSS0IXRj2zF8aolxelGMmg
	bTx4h0e39b0LjHnwoVF1pKRY4jfZHFTUmGhzN0dLCwkjVB0ftAmyAEguaWChSyiajyTderzre1U
	IoQikxgkfFgLc3I7PPvGsUwfbSsR3bG6ac+8h66BBy+q8yai9SAN5ZZ/eNP/t3NIfVUBbRysE0T
	ccGMpcgY7nMYlJXulavKsSMC1w7NVj0O6mRb4fEr3GRHUOCVty01Yp32VY7b8bYdXQ897kQRqGj
	FGxXVEpTKWhFsl3WqaICX8GqQaN8DH1jZqRc5BzLkC/4EbRDn2cKtf0r7c06+pExdm9WWzEQD7f
	RQ+6NwE+MivgzIVFbEXqEz7/aEDo5LZ7Q==
X-Received: by 2002:a17:903:b8d:b0:2b2:65db:8c5f with SMTP id d9443c01a7336-2b269c9b80fmr50932815ad.27.1775095181703;
        Wed, 01 Apr 2026 18:59:41 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478cb4fsm11187535ad.29.2026.04.01.18.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 18:59:41 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Thu, 02 Apr 2026 01:59:38 +0000
Subject: [PATCH v3 01/11] Documentation: Correction in HID output_report
 callback description.
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-send-upstream-v3-1-6091c458d357@chromium.org>
References: <20260402-send-upstream-v3-0-6091c458d357@chromium.org>
In-Reply-To: <20260402-send-upstream-v3-0-6091c458d357@chromium.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 hbarnor@chromium.org, tfiga@chromium.org, 
 Jingyuan Liang <jingyliang@chromium.org>, 
 Jarrett Schultz <jaschultz@microsoft.com>, 
 Dmitry Antipov <dmanti@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775095180; l=1213;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=sHkk34xkCVNuYNvgvLM4yfgwiPvB0kDmMlwDb9gzQSI=;
 b=sWAbum2KtSMvIZHpotQFRl3qPX0w5lDPo0wVXGjdcQZ4Iy/Q1lBj1M1z1kObb2Say/DR3abDE
 qMXRcGAYSZjCwmC4SoKf0troiioLGh8ZBZYI6TTyyS5zWbVHFTQHQ7k
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Jarrett Schultz <jaschultz@microsoft.com>

Originally output_report callback was described as must-be asynchronous,
but that is not the case in some implementations, namely i2c-hid.
Correct the documentation to say that it may be asynchronous.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 Documentation/hid/hid-transport.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/hid/hid-transport.rst b/Documentation/hid/hid-transport.rst
index 6f1692da296c..2008cf432af1 100644
--- a/Documentation/hid/hid-transport.rst
+++ b/Documentation/hid/hid-transport.rst
@@ -327,8 +327,8 @@ The available HID callbacks are:
 
    Send raw output report via intr channel. Used by some HID device drivers
    which require high throughput for outgoing requests on the intr channel. This
-   must not cause SET_REPORT calls! This must be implemented as asynchronous
-   output report on the intr channel!
+   must not cause SET_REPORT calls! This call might be asynchronous, so the
+   caller should not expect an immediate response!
 
    ::
 

-- 
2.53.0.1185.g05d4b7b318-goog

