Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF3F50A67
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710832757; cv=none; b=A7zgy2RB7ll0mLzfHe/I6OUjReLzTDcf7wfZZx+R6mfzf4Z/F+Z/Ofs2EA+48MGxe7FbtQrI0NM4Bz7lr4Bqcq9b+a7fxVLMWTCIp8U952aTYu1gaKlAzns//vcUJhUP+a3mIxIRCGtY4CzSEx1+fNHK3fzZPCuDfac0EZh0pCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710832757; c=relaxed/simple;
	bh=uO7a5RSHom5olgldMLQaTTAudWCy0XAl0qtilTciP9U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GQj+/7HNjJeaimJf0cEJzxieuxmXWBkba4kSBfRVcueyGWbSv/GnCr90rf+J5h3O3SWQoqBUnTxvHG+lFLb1gJDU1e4z7UnFX5wYxVYTJ4+MoexIcpOZMUWq8fUvcWRkdZuMSHFN0oYVhOxKdAlQMb4w/Q9FYpfnRrywwMaBds4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B7ubGowJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B7ubGowJ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-414618e6820so6074635e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Mar 2024 00:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710832754; x=1711437554; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QVvgM7GGeSUf7bYuhFVhif5oXMSin2tIGGHRDZ4YN+s=;
        b=B7ubGowJzIKASF99PhA/LefdPKn8/hNRsBmh4mMBf/xGPZMMvn2SC4PYhbRkNuumTw
         4sdV1EE0apYazksppKFGNTrZ4pHt0rS2qxrFtjdh7NGNhy6Wv6ZhM2UW24Jeq8T5kDK9
         jWITjtGf8c7nuhmYMu0ZI/5yTmFOkBy+wGcEfMRUmhpDBH+GneMlaSBhvH4WxX7sNJuF
         ZFAX3qpX0LjJGaGSs3qCHcycLOWGWb45+hxz9VFIH2Z3L4tOCMx8bsZsQ5Cbw4Nx56nA
         3H8SAv7t2S/SFaiOLwtUaqO3K3UNTvQdc8YbIie8xsrUG06pvgjKzONQxOIgSkt3PB9w
         NuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710832754; x=1711437554;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QVvgM7GGeSUf7bYuhFVhif5oXMSin2tIGGHRDZ4YN+s=;
        b=P1pQqgBiamF3xx/gLPhYgv1F/0HVNwv0ujrHvYBgKncAajIbKtsaH9F/qvCTld1OCN
         ny+bIF0XyQAFuSSbY5nw3jwIC/7QvwQZAD6y/joJIXY/5pNfXmrYMJ2MjJKnXdyW4Jur
         qs5raBqXJ9s4QRXKZjQzpt37moFV9ymq7EqDET6VtlPAqnh0sfZajtbeD7i3WZtQ3kVd
         obrJ6ErWFWTcLlUMRzcZtxATYZ6P/MKZZqco/h164OEImhG6y1gkI2ZYHzvxvFYmtjk2
         E4JHANyj+VF6rrp3gNkiG/g1C7t8NcqDe+uvn1Ha7tEmci2LhQShIy+Maq3BqzR2vX+a
         k4Jg==
X-Gm-Message-State: AOJu0YyutM0wWHmg5j4/Z49/K9/XXB4kAeSY0jS4D5F8RfStRQuUB7JF
	RYFG60j55i1/43t0zZYPcDeRstbXJ891elOQQ/uFFl0Rj+7p7KkiF7pzV7Sva5/Cl76h3N+zaur
	a
X-Google-Smtp-Source: AGHT+IHO3AGegTf8LybUwrtw17HeufgEeVf392mo/WzCCsJ1QdGG31N63l0U1zH3fdu3mOHP6Vwwkg==
X-Received: by 2002:a05:600c:4449:b0:414:e63:4d20 with SMTP id v9-20020a05600c444900b004140e634d20mr1291978wmn.16.1710832754095;
        Tue, 19 Mar 2024 00:19:14 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id f4-20020a5d5684000000b0033ec6c8e780sm11513458wrv.102.2024.03.19.00.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 00:19:13 -0700 (PDT)
Date: Tue, 19 Mar 2024 10:19:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: mhiramat@kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Subject: [bug report] tracing/probes: Support $argN in return probe (kprobe
 and fprobe)
Message-ID: <b010488e-68aa-407c-add0-3e059254aaa0@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Masami Hiramatsu (Google),

Commit 25f00e40ce79 ("tracing/probes: Support $argN in return probe
(kprobe and fprobe)") from Mar 4, 2024 (linux-next), leads to the
following Smatch static checker warning:

	kernel/trace/trace_probe.c:856 store_trace_entry_data()
	error: uninitialized symbol 'val'.

kernel/trace/trace_probe.c
    846                 return;
    847 
    848         for (i = 0; i < earg->size; i++) {
    849                 struct fetch_insn *code = &earg->code[i];
    850 
    851                 switch (code->op) {
    852                 case FETCH_OP_ARG:
    853                         val = regs_get_kernel_argument(regs, code->param);
    854                         break;
    855                 case FETCH_OP_ST_EDATA:
--> 856                         *(unsigned long *)((unsigned long)edata + code->offset) = val;

Probably the earg->code[i] always has FETCH_OP_ARG before
FETCH_OP_ST_EDATA but Smatch isn't smart enough to figure that out...

    857                         break;
    858                 case FETCH_OP_END:
    859                         goto end;
    860                 default:
    861                         break;
    862                 }
    863         }
    864 end:
    865         return;
    866 }

regards,
dan carpenter
