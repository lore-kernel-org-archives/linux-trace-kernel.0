Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837BF158DAC
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719575320; cv=none; b=QCyqUu9L3K+wWWIZkc49Odr3k+DJMwCS/BH/0jSLSfKkoOlFONvmh40oD4lr1TL+D06oY/FIFL1sitnwlgnShiKfab0zndSH637wkF5vY0ppQTJB1iDt/biG0gqMu8jIPON+fXn1Yeydzq5WPqUgMHWgWw5ZNgzRfRDhv/xVkpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719575320; c=relaxed/simple;
	bh=EqvmK9erXdF03YXwNF5KKlTIlFwBGkwfT2afCjCPw2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eyTpo1hKz3vljSDv3Zzgpht44lCvG8tB0XcWv0zLYp0wDmIK56Tt8PnOwFwJOCFguu2KfadDi25m29fSsAHju3+2zPocjkZg4L7JtvAvEtSJhEdm/r/FhbWRTHFGGpTSAp4NIpRS+Stuol3PsuamQkV8jtYVJxb0HdJi+gdhJU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KS5YUiOC; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KS5YUiOC"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-25caf76158cso277576fac.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Jun 2024 04:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719575318; x=1720180118; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cVz6x8zHD2e0o5+zukG3kv+msINNXHhJ2RLc+xaoywE=;
        b=KS5YUiOCKXmH6/KkTDKyoiJiK90z3pggHKwTtomy/mC+J6ijlWoqmiXDSULgcFxxHY
         vr7BJcihIHYFX1yEfRbHhvpa6VgYTdfvfC55Vz93rX9Ia6PLjFuwC8Vj4XXnCAFza5Ux
         McEvf8AyafLDP11tseDn5HLZpoxDhkOuEQKUiQ/xCMfpzyWmyY1ZCGDePcESY6NNjF5N
         7lTrp2oOzD4nU0jJd3zHFaONbENRO5o3ZV8jTUQZQU070ANwknf35uj6mPp7GETQbrwf
         YEW8nwxxCYif/1FkHYQ1W5BhXZge+zT0emFrj1v1doTOM4wy23saXNPnEjdoAx6pM2vu
         jS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719575318; x=1720180118;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVz6x8zHD2e0o5+zukG3kv+msINNXHhJ2RLc+xaoywE=;
        b=jqu6Qs6rEIpfk5HNHt4gpeW1zHcr6JFNBS080H+BSbXoZVNFx5opjfcK1QyA4eU+xg
         EhUatIujWQZlwqeh/h7FsZkYqD9yTKl5pxJGERSXNa3CIoat9PKiUzQW/yb3niLijN06
         Co2dAgdD1LnBHlnLTLnaU/U10QdW8zkrJPhLcR8djKus+Gx+CDI6SQCuxd3HKQHE9enu
         2j7YBALi9RYZ087ex1eaVTJ1B1uDInxxEGi2IxEUk9uUlUldwb3G/D2/C1WONWXgA86o
         BH838D72eP7KCBf/aDgA1BjK+iQEpp7x6lTqlELPclh2zZVR2ZwZZNwosngpjKZ2j2A6
         IrSA==
X-Forwarded-Encrypted: i=1; AJvYcCW6tyYsyBgq712PQK2XV7K//AzNzHv5dMnHp9fKdv3pq5uzz4zUAa00fC1N1QTrBJMPfHhIZTQsQrkwC7hXL7i/XqCniKO3mKvnBTuoVACdZ6b/
X-Gm-Message-State: AOJu0YyTPXUHG0j0hE0kWFI47+O6/Qsh0hZux0kJ5/O7qYugUuI0WuGs
	fP26VOxlarSSG5TMTsuAVK/nBbbMjL0SeWKRV5HLN3vHyZunhpubIzVtFzuTdtc=
X-Google-Smtp-Source: AGHT+IFOBKDdLVvGH5/U1B4nvMFkuWHQzKcK9o5xnO1lPmAh4a3+NRC7pmcUXvg9Bib/B2yboEQX6w==
X-Received: by 2002:a05:6871:3a11:b0:259:8671:2530 with SMTP id 586e51a60fabf-25d06c5118bmr17606779fac.25.1719575318592;
        Fri, 28 Jun 2024 04:48:38 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecfb90sm1377775b3a.139.2024.06.28.04.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:48:38 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Fri, 28 Jun 2024 19:47:49 +0800
Subject: [PATCH v2 6/6] riscv: ftrace: support PREEMPT
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-dev-andyc-dyn-ftrace-v4-v2-6-1e5f4cb1f049@sifive.com>
References: <20240628-dev-andyc-dyn-ftrace-v4-v2-0-1e5f4cb1f049@sifive.com>
In-Reply-To: <20240628-dev-andyc-dyn-ftrace-v4-v2-0-1e5f4cb1f049@sifive.com>
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
index 55c70efbad0a..881ea466ff52 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -139,7 +139,7 @@ config RISCV
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

