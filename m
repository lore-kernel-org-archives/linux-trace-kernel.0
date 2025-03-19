Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DBF254AEA
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383890; cv=none; b=TMwmWqCRkwmyOavNd/j1wVPyeG8JGpfDg//c1tvjfXhlgoe7VvvdMxDEFxmO51evkijtITgOR33Jz4UUboTb5Xa8/qVLzPVAVP4MmM0GkOkpYPMyw/AD6AKiTJhy4eTHM8g61EpiplwCZ628Zn84ZMNJSOPly5nqe6qi7o0CKx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383890; c=relaxed/simple;
	bh=uHypwcrRHl+SgqVLmPSjnzt1sQS71BQ4kVSWgN/L4Bw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XwY3jNTXTWjzz/zgMn1CCVqmXGJS9dRi00HSnmDLZQlwFEvVWVZokhQKtXdtJ1bGS41S2NJ1V7w8/yBW2puLnakrdHKDeBPNNGFgR6esl+S5GFOKS1OwMXmKeVYcRE5ZA7afMxUatldtPgv9UBQgmgdvqjavwHszwi/RPvPV+VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BcRrRpWV; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BcRrRpWV"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5240317b3e0so2498716e0c.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742383887; x=1742988687; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m+jLPHrj8ZPA3XVCoYQzPMElmxuzbulUtWiqu8pWMqw=;
        b=BcRrRpWVb7MZF3k/jM7ouDfaXOufcFIbdwq73Fpk+3RYA7/zUS8U11k7iJqR7lIEw/
         DmrkNfVno29assWrVc9OEGLqP0/XgAGHdCa5189zpSCVcQ0L1b7Vcl9ELG5mYNYVLLf7
         294PAR6GO29Hyw56iy+n0akVz6nsBRxCq9aDRTlCngSr7W3nYZLGG4Mf1F1sTmiZ0AN7
         I5HzvOZYzcLUr61o2NnTaj2KOEjdLurdsw2SzB/hYeb385Ol6CiJhtw20QS4SM+HtUqO
         c+F72XGDEuY752GsrHRz/mpGvIX5dJA2AXuQSjTrBWYdWNwRcvLhEQfpcZMxUdwave55
         JVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742383887; x=1742988687;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m+jLPHrj8ZPA3XVCoYQzPMElmxuzbulUtWiqu8pWMqw=;
        b=EMxZsYXZoAa6qNh7sJ/L/l95DQyeV3hX45CxJmnFVgUezeHELh9QVAk7aMPxZIM8D9
         tzr0vXb/EcNZc4Rh9biqvO7Dr8khJ/zLfppzMg0WIcScF7B6y7dbqWxFrswZu8Iq+Z9S
         wlxMyZrlHjDtaLY7H0RB0PPVVVdbtzO3Tmf+3rbRH0Ua65MssqmBZENnm2iYktXM5g2f
         +acLIaIrEvtcV/3gPgJuIzCfsKBfi6STjviCLehrI4ox5A8GFlgXtQmdDRZyNGd82QyD
         mGGU6P2KN7+yjDRAU+FavT6Dd35plDEvo5nqtzOqdXOgtUbKwK9KxLr358YAzayv+r91
         AJlg==
X-Forwarded-Encrypted: i=1; AJvYcCX27V4+XMMyc4XJ7NTyC9PFT8U71ATHFSFaknEDLpkzxPoV68NCz47J3N1OHekhkPy3IXAjhL0TNDWqutQsxUKsIVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpYD57Pd2Pzk+sXD37mnfvf/L+qtXmAB/bG+AlqRpDlLCNyBmd
	+2u8xTxy40LjuS3xuDGGlLcoAJXrCkxNVjed8OnRU6JlKPHUMLntC0XoMawyl3+XXQfxbDOnE2a
	+rGpi6JPrFEabBpm58xJ9LKpBWjzNaJe2VxPPZQ==
X-Gm-Gg: ASbGncuH67kZ8I1M1YBWLGtdnyz0vuPitz1S5391oyKQn8HXcrSlESE7CzcqECbCxud
	8Y/VokZjpIAgke4Oew46DfVRC3GUGd5gZEs0ksrYHlQXcJXIPLP/RNGfLc/+S4DMJCJYubwvmDz
	RnRVUbvt597c3Ab7kjtwdoCB4hbRA6rXps+8YR3KzevdMkGJ5CVh6mo9eW3Rj0GiAACpNLUA==
X-Google-Smtp-Source: AGHT+IEafdpVOBAa5pTQIO6t8jfUeEW2i1TdUhI5BgPgwIlXHBkKShF7vYcOGmK23Sd3ddxvxbUeCyPxJMm1D573itI=
X-Received: by 2002:a05:6122:309f:b0:516:230b:eec with SMTP id
 71dfb90a1353d-5258912107amr1143140e0c.5.1742383887486; Wed, 19 Mar 2025
 04:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 19 Mar 2025 17:01:16 +0530
X-Gm-Features: AQ5f1Jom0KVj0bHEN5s3vaEzIeI9v3O6c6_HQfHuayaz3HGWB-1p8XHKc-Q7AtI
Message-ID: <CA+G9fYs62qxt1PajEp2A8uUmQFeAsC2JBV2wuspbAxz_hFF7CA@mail.gmail.com>
Subject: next-20250319: arm shmobile_defconfig trace.c undefined type 'struct module'
To: open list <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Regressions on arm the shmobile_defconfig builds failed with clang-20 and gcc-13

First seen on the next-20250312
 Good: next-20250311
 Bad:  next-20250312 .. next-20250319

Regressions found on arm:
 - gcc-13-shmobile_defconfig
 - gcc-8-shmobile_defconfig
 - clang-20-shmobile_defconfig

Regression Analysis:
 - New regression? Yes
 - Reproducible? Yes

Build regression: arm shmobile_defconfig trace.c undefined type 'struct module'
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
kernel/trace/trace.c: In function 'save_mod':
kernel/trace/trace.c:6036:45: error: invalid use of undefined type
'struct module'
 6036 |         entry->mod_addr = (unsigned long)mod->mem[MOD_TEXT].base;
      |                                             ^~
kernel/trace/trace.c:6036:51: error: 'MOD_TEXT' undeclared (first use
in this function)
 6036 |         entry->mod_addr = (unsigned long)mod->mem[MOD_TEXT].base;
      |                                                   ^~~~~~~~

## Source
* Kernel version: 6.14.0-rc7
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: ff7f9b199e3f4cc7d61df5a9a26a7cbb5c1492e6
* Git describe: next-20250319
* Project details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250319

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250319/testrun/27672563/suite/build/test/gcc-13-shmobile_defconfig/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250319/testrun/27672563/suite/build/test/gcc-13-shmobile_defconfig/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250319/testrun/27672563/suite/build/test/gcc-13-shmobile_defconfig
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2uX2E69ngTqvrymzOdYQz0JQ16z/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2uX2E69ngTqvrymzOdYQz0JQ16z/config

## Steps to reproduce
 - tuxmake --runtime podman --target-arch arm --toolchain gcc-13
--kconfig shmobile_defconfig


--
Linaro LKFT
https://lkft.linaro.org
