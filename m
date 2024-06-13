Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED8613D52B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263994; cv=none; b=GFqaRwtjGW52ugIqk6K2Duo5osB80+a8GB8ALo3pHyBCFBCh7K86KIjjykkaQd8zAGj2JyD9WiIh63PWzbnTLUaOu1kcouNXsG+mmyywZ8GJoBBdgbEz1Kd4DRZSMC/NihA7amriruiiR8gApv7sWah2p9GzoFAY6x9SC12XTS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263994; c=relaxed/simple;
	bh=uoTnrqYSg19kqb0lgMH7SLS/qe9dnaqbOD+HJnS87Ho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=haQr3eVJqzHK/IG0iGhtYKVhWU73HwGgNhwP66rmWcD4pf6YedtqBrU0z3R73mGEGMawb4YFw4623GCb70Zr8LzFXeND1Ciagq4Mp8FmiwPpyyG3ED78jWTR5Sw4cip1zl/JJEUfsqJ7bZ7uYIQh/TlQbm8ZdvFqLTdOUPngYXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=WlfE5jC2; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WlfE5jC2"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6e4dbca52f0so525214a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Jun 2024 00:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718263992; x=1718868792; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RlJIkXaRaXYEOo0FtAy4w5B+d0jhj99dMDrjOpWfyi4=;
        b=WlfE5jC2GSHvYdL9YEYEFvD537xrYazzBJ5mcLQhpz6eXYU1TCCthCwF/9Cx4OGZG5
         M5dcRHbYBN8zf7QyWPprIZvpyEqDCAGabmxG0cpu47t9F+v5jRoLq54svsMPwYaSYXxo
         MbqkKkVE76RkQOkzbk9o1t+nlNWyD/mSjNxXvgmD6kdWjHRL4UiNcm6dbFjq6HcHb8ht
         jnNHxiZFEfy0Tl1Da6DlSmvzTiKMPMUdoWO3weOiLfM7Mhi/Xg9f3c0rjAToPMUvEsVy
         byUqA1iW/vapQZGso9cMJL9g//EPx1sODvCJLndZW0DRbnp8AB80IqtZXCNGcBByQluk
         XS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718263992; x=1718868792;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlJIkXaRaXYEOo0FtAy4w5B+d0jhj99dMDrjOpWfyi4=;
        b=Ur7GAjYajI6qy7REdXhflZfiPBxMfG5fiQHRaKR/irl1EnY2Qof1E7ffsV7LvaUP8O
         RyLLzelZjL47bWhmreNsGTH8y63iCVX5FIvfBK6jt8EB2qfOI9sq4PGCrmwD2pCJmUEY
         ZNJAOWVni274RatbeYApGMX8la8q5h9g8+E1vZpbcaPsOqPHQo/x475eg/Trllp1ex81
         6M8KWSARiexhBrAZ5pUh00r+ivDPEVcfca0qbTGa9fo3iQeOz6BTc/Sw3V7szElPmlIK
         gUdkAXiUPO+wcIlc0q9Z4MUAND47//cLiVSV3FdGtr4p6K4qA2Shlnmj5xRac4/fmBhU
         5UsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/8XoNY1b2GI3G4UqD9+UnyntKYfmuWMutjkLTu2J7nuhuCix4Unz32EvI6nSXCMqhC+pdcTJBOo16/UOIGTNR4fOL5MVZRUOl7wkYEvF0iljq
X-Gm-Message-State: AOJu0YwMSAhOyCJp71MPVA+RgJHEYsYyLWcb4am48JL4TNGteZvDrrSW
	IuJcG64NtpuNwFMom5GQyfECMUS0gjyezQk16yLhMI5EkUIQfwlylLgez1rOSNg=
X-Google-Smtp-Source: AGHT+IEyM0ONI7ICTx6DjS1SeAdMKnjMDIyvhgY/AOB26Jk18oYzU1QW75t2bRm257+1EVhnYwVCTA==
X-Received: by 2002:a05:6a20:3d88:b0:1b2:a889:f7da with SMTP id adf61e73a8af0-1b8a9c887fdmr4702279637.55.1718263991983;
        Thu, 13 Jun 2024 00:33:11 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc78a1a0sm730028b3a.0.2024.06.13.00.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 00:33:11 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Thu, 13 Jun 2024 15:11:13 +0800
Subject: [PATCH 8/8] riscv: ftrace: support PREEMPT
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-dev-andyc-dyn-ftrace-v4-v1-8-1a538e12c01e@sifive.com>
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

Now, we can safely enable dynamic ftrace with kernel preemption.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
 arch/riscv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 80b8d48e1e46..c1493ee1b8cd 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -133,7 +133,7 @@ config RISCV
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
-	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
+	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
 	select HAVE_EBPF_JIT if MMU
 	select HAVE_GUP_FAST if MMU
 	select HAVE_FUNCTION_ARG_ACCESS_API

-- 
2.43.0

