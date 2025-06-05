Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F35202F83
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Jun 2025 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749128062; cv=none; b=Qx01xO3eZDv68MqqnUX16+MBI0d5gu+VIyFWblgEM3rX3FjHKf6oyWtmbrl1wObXb+38OtPEzt8Z/K16OGoAhg3EvKWlG6FDouG2++dPQsnh4Hndqnn4MdOMe4YIUWhAyAwzwsQKQ1EyWbHItSnTyzBO+fR0lynVc52MRphjZpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749128062; c=relaxed/simple;
	bh=QX0gMKK2fb9bk8Iy/QzzFbeOOw2rVcgJRZUiONaQk80=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mwdEUO29JH1OMNomTjuh/I06/yIuTN2R2QeiaTYK9VLtP3kkgxA1WbetN+xZ6oO2QzINGrUnMdXtE5CJYea1dmkzwoarlSPEE4rdcBzjeM82/kKVFM2TgpUBKAz/nIbvXMtgqAyJBzGdQjoy/TXifCP/Zvvs9Mn3HbxmvRzvoeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gMsnOgcz; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gMsnOgcz"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-530d764149eso241532e0c.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Jun 2025 05:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749128059; x=1749732859; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a5KI/5DaUypnvVC78JIsjLazY3rLFhSBhgB60nYQ728=;
        b=gMsnOgcziIJwrnja9EEyrEoNUJyWnfPy2Oho4+tuD1SP+TwDcxsII4hRZ7slAhbyF8
         pNHkm0rVDVd9LdtcmgYLK2z/czYSDxHyUqSNwC5+x4RU4dphI+F2MKVhS9M8zKA0JXL4
         Oeur+/aTx/TtQQ2FtvesQGcI56nW4VqO5ygDZ5y9u9GZ5NaHziTPKf6DzEq6d03dE1kI
         yP/h6Y3vCovuBP00RWaowCBdGPY5KjCKqg4cOmrRJNICvbOLI6lRdn0kaG+08NcDfd72
         qRJxPFHMNDGVy+Xa+S6Yy22+p2koO+DMH4csz+BJPquCK1tXmJlgyuqjLzkWaRvwm2V7
         5Qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749128059; x=1749732859;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a5KI/5DaUypnvVC78JIsjLazY3rLFhSBhgB60nYQ728=;
        b=Z5nZo8T34uieDgkrit1w37biv7SG5gCMNn759U33hRNdDhB2AhBbwhRkR5+JO2PHrU
         7PhlWsM7aJ90zPoP3p8clFloA5ognUMac5AKjGDpaX5qgxI/CfrJdLl5JBuoFgEc+uhJ
         hT3wea5bL5mF6N834IwRafd7lVwxQBsq+Mbm8qoSb3Ije5iZDPPpKJRa7Bejh+SMOuDO
         yAIP9z8uCxH5E7bKqt3OSWB8hHJqiT0A5dEiqJnv/w6Zu7mtLSLkTkAngudDWIILb/ky
         YPL/hjfQbX2bvs4Ok6idNB4MWKYqrqf5l2EDmzFrDy0Y5cPRGvVQgcrO3LhyoMA4+kMx
         wtmA==
X-Forwarded-Encrypted: i=1; AJvYcCW82inhogopGMGoM5nAOjNH1+L9RTlv7z7rehccYVxlLvavdhDaJge7SeVZdeWxLDuvB0nAbQJbxmJeUur7X3OMlnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzib9P3cGgBNActlY2xAFdc6z1UVgU7cEg6fYXewK9XHq5ZX52B
	pqaC6rIIrjl7gw/BJhs2aVNNDf74639q1VvzLsExw1blNp2sqq70nltMOsXZJ/uspWglYj4D26/
	/AzwoEA0/Cu7L/JZg1GybSVMG4p49cVoaUkV3FS6EeA==
X-Gm-Gg: ASbGnct2y9uQ0tTPwD3qt2A/pWWTVpCnGdFa6aM5rL5xkwqjzVCUQlt4KMRgvf2M4dk
	r44RqAO7QJgiwT2zrtTaTGM22dmFIy3Y1T0SmTtvpUMT9plnBbe2OaAQ6Q1B3FJlmCbaZikrKQn
	PHaVikfpNizIBNgCkNLZnZAF/WJwfRmBN9W8SiW4HAJkk3dT2+yQ/9onHDkQORRrpBWA==
X-Google-Smtp-Source: AGHT+IFScV6XSj0OM4gUEtQIR1BY62vpL3tVsGuFOiFWLyyMM6Aw09PHdk/Hbo6hoDuG4Pgt4Rm7Fg3yADaVtlnEHgw=
X-Received: by 2002:a05:6122:311a:b0:52d:bbab:2055 with SMTP id
 71dfb90a1353d-530c895d2eemr4796732e0c.10.1749128059355; Thu, 05 Jun 2025
 05:54:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 5 Jun 2025 18:24:08 +0530
X-Gm-Features: AX0GCFvf2AhSfNDvaokQSmWFSQ1v0Gpj8_ag9kF1ImYBbbkf0sVxFmSuh0yaUoQ
Message-ID: <CA+G9fYuXxxPG7YY4ffbJ=hrBvBU4171J_FykYC2xoPV6uUB2sg@mail.gmail.com>
Subject: next-20250604: qemu-riscv64 ltp tracing warning kernel trace trace.c ignore_event
To: open list <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Regression while running LTP tracing on the Linux next-20250604 and
next-20250605
the following kernel warnings found on the qemu-riscv64.

Regressions found on qemu-riscv64
 - LTP tracing

Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

First seen on the next-20250604
Good: next-20250603
Bad:  next-20250604

Test regression: qemu-riscv64 ltp tracing warning kernel trace trace.c
ignore_event

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Test error

------------[ cut here ]------------
[   28.134981] event 'ma_read' has unsafe pointer field 'fn'
[   28.135550] WARNING: CPU: 1 PID: 302 at kernel/trace/trace.c:3823
ignore_event+0x1de/0x1fa
[   28.135609] Modules linked in: drm drm_panel_orientation_quirks
backlight configfs ip_tables x_tables
[   28.135937] CPU: 1 UID: 0 PID: 302 Comm: cat Not tainted
6.15.0-next-20250604 #1 NONE
[   28.135973] Hardware name: riscv-virtio,qemu (DT)
[   28.136072] epc : ignore_event+0x1de/0x1fa
[   28.136115]  ra : ignore_event+0x1de/0x1fa
[   28.136147] epc : ffffffff80151ca4 ra : ffffffff80151ca4 sp :
ff200000006ebbe0
[   28.136164]  gp : ffffffff81c61428 tp : ff60000084efd100 t0 :
ff200000006eb9b8
[   28.136181]  t1 : ffffffffffffe000 t2 : 205b2d2d2d2d2d2d s0 :
ff200000006ebc50
[   28.136197]  s1 : ff60000080066150 a0 : 000000000000002d a1 :
ff6000008103e730
[   28.136213]  a2 : ff600000fffcd980 a3 : ffffffff80104e22 a4 :
0000000000000000
[   28.136229]  a5 : 0000000000000000 a6 : 000000000000003a a7 :
0000000000000a00
[   28.136245]  s2 : ffffffff81801608 s3 : ff60000087cd8078 s4 :
ffffffff81bebe70
[   28.136262]  s5 : ff60000087cda090 s6 : ff60000087cda054 s7 :
ff60000087f9ea40
[   28.136278]  s8 : ffffffff81200000 s9 : ffffffff81800000 s10:
ffffffff81bfa290
[   28.136294]  s11: ff60000087cdc000 t3 : ffffffff81c615d8 t4 :
ffffffff8001f8e0
[   28.136321]  t5 : ffffffff8014156c t6 : ff200000006eb9b8
[   28.136337] status: 0000000200000120 badaddr: ffffffff80151ca4
cause: 0000000000000003
[   28.136395] [<ffffffff80151ca4>] ignore_event+0x1de/0x1fa
[   28.136456] [<ffffffff80157548>] trace_event_printf+0x46/0x88
[   28.136471] [<ffffffff80d2d54c>] trace_raw_output_ma_read+0x5e/0x7a
[   28.136489] [<ffffffff801530f6>] print_trace_line+0x1c2/0x438
[   28.136506] [<ffffffff80153948>] tracing_read_pipe+0x1a2/0x2ee
[   28.136522] [<ffffffff802f3eb8>] vfs_read+0xb0/0x294
[   28.136538] [<ffffffff802f48ac>] ksys_read+0x78/0xde
[   28.136554] [<ffffffff802f4934>] __riscv_sys_read+0x22/0x2c
[   28.136569] [<ffffffff80d49cd8>] do_trap_ecall_u+0x1ba/0x392
[   28.136584] [<ffffffff80d56b6e>] handle_exception+0x146/0x152
[   28.136654] ---[ end trace 0000000000000000 ]---

## Source
* Kernel version: 6.15.0-next-20250605 and 6.15.0-next-20250604
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: 4f27f06ec12190c7c62c722e99ab6243dea81a94
* Toolchain: gcc-13

## Build
* Test log: https://qa-reports.linaro.org/api/testruns/28662756/log_file/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2y1tW4N08hDuUrUZt7mmMMyQJag/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2y1tW4N08hDuUrUZt7mmMMyQJag/config

--
Linaro LKFT
https://lkft.linaro.org
