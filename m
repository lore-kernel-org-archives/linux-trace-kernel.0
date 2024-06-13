Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5193D13C9D8
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263969; cv=none; b=IfJ4Yge85+ihLZbW/gnnmQlEYBH1r2nx5zlsWUudcz/sn3gjW5HRQcY/7QvYcjtOyBPku3psSvNVMeio6bWz7Gu2JJF4hypzDO1FMEx2bnQ2o4mMD4V+CbMsXLokzhKVlSgpBqEyxANcGQSfQQSZE/phYb3BNEtXZ+UrPws0fr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263969; c=relaxed/simple;
	bh=vgghTaDxluToi5kVZZlG6AV2uIZ41UbFwSgx4K8n064=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DYflUeXAooeKX4ixWzLOYA4DkJUhB9rtyPjSUH+2yUBNfm+YX7cNX4Ss6ZZENrFA1OJaVadzu8BGJqVP4FT6ohCsvpw0aMGeHY+i5SEnOO5Odi1bcWgaJngwVdkKjEqWY7cBpQytTxAA1H+xrIGOeH+I6mVvWdoQhPXRhXuXC3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=etP/LdQK; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="etP/LdQK"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f4603237e0so519953b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Jun 2024 00:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718263967; x=1718868767; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FQsuZ21+9cGptdlB0BPgeEv8WU9oI426BLaNkf2S+w0=;
        b=etP/LdQKyC3qb2zXfttY13aPyp4lbQJSHThwPFHEZQmKBlrzDRfA1y6lR4uMZYATe6
         V+OCUa/8NMQONuM38CD388H5XUH/WZa6pTNxoYx2wKr9j3+RQkjchGBgInGwMxnGtzmd
         cbbUU1FD8S5KoyaGrqyKIMWY/4i5vQr5fUM3mn1JduSSaptEMQqIj4AfFJhxWPzry+MV
         huaa4WT5nzwFIDPP4/06hjQrXtThG/37yjeUIBNdr7Lu/rJxC8ucf88tLFTeRj/VH+/O
         m0jR20ArNZH4xunC6yqvVdkLzewbY37UM3hMzfgLirBtsKzsHIrPk01ozwGKRywAwOo1
         l4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718263967; x=1718868767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQsuZ21+9cGptdlB0BPgeEv8WU9oI426BLaNkf2S+w0=;
        b=XvqwNVe/ADdA5au4a6KodkSreblXhjChRSnyrze+I4jghVqcyJ2Pruh7FMw3/drPth
         JLCOthrtjkINN4WI4BJ+YZH9Fz/eb6h8dFtORtna/aDsGwV6qWRm7EZLwAxUi9sFEJbe
         J7Qx+mIQc2UHyY2doO8ImWo1vFLIbI7N72xGi526gykQWiLT78VOj659U2czBCiHlxaX
         xr9+ujtlM8Wk+qxeRTSEJUlxNb/4spOvfwgHMk6CuwYoqjhF3DcPdxMz3umj+rt22Q24
         n8Hl9v4RudzcSsLPmsc3g4NfLF1Ha1IYanyvmA2hr8H2qtQWx0RF3ucdzqYZjSRqawdk
         g0NQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5NLplGMDfSRUPaDEMyi3PmEHfW7yO6keU4OVHIEmfBt1yfASIlHMToPvwydmqOzCaJq603AhLQ7nvoLmZT5lxt/7uQnmWXjtU3k8hIV2BlDdJ
X-Gm-Message-State: AOJu0Yz+D9teHLGYOTASn4JJfXz82HGZaZSxG3FuKCdCqB3ZUojt/ARU
	XWTLWSS6dXPLJM7EWMURnad+rC0z9mbC4Tj6DWCWk+Do0uoCWkVFLk45sWxvV34=
X-Google-Smtp-Source: AGHT+IGkMW8dM0M3dwKshtF1f8Z+mSNjVPk7wRBBSBrIqzVVkpK0qMV/aHa7vJh7XzX910Gr5qBw7Q==
X-Received: by 2002:a62:ab02:0:b0:705:d101:90ff with SMTP id d2e1a72fcca58-705d101919bmr283959b3a.16.1718263967547;
        Thu, 13 Jun 2024 00:32:47 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc78a1a0sm730028b3a.0.2024.06.13.00.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 00:32:47 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Thu, 13 Jun 2024 15:11:07 +0800
Subject: [PATCH 2/8] tracing: do not trace kernel_text_address()
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-dev-andyc-dyn-ftrace-v4-v1-2-1a538e12c01e@sifive.com>
References: <20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com>
In-Reply-To: <20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, Zong Li <zong.li@sifive.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Andy Chiu <andy.chiu@sifive.com>
X-Mailer: b4 0.12.4

kernel_text_address() and __kernel_text_address() are called in
arch_stack_walk() of riscv. This results in excess amount of un-related
traces when the kernel is compiled with CONFIG_TRACE_IRQFLAGS. The
situation worsens when function_graph is active, as it calls
local_irq_save/restore in each function's entry/exit. This patch adds
both functions to notrace, so they won't show up on the trace records.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
 kernel/extable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/extable.c b/kernel/extable.c
index 71f482581cab..d03fa462fa8b 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -74,7 +74,7 @@ int notrace core_kernel_text(unsigned long addr)
 	return 0;
 }
 
-int __kernel_text_address(unsigned long addr)
+int notrace __kernel_text_address(unsigned long addr)
 {
 	if (kernel_text_address(addr))
 		return 1;
@@ -91,7 +91,7 @@ int __kernel_text_address(unsigned long addr)
 	return 0;
 }
 
-int kernel_text_address(unsigned long addr)
+int notrace kernel_text_address(unsigned long addr)
 {
 	bool no_rcu;
 	int ret = 1;

-- 
2.43.0

