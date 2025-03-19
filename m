Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5EC33985
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393577; cv=none; b=Z8GqbgQKO/WlNSqC1rBIXB2OvP2YQ0aHfzLLz5E3VnKmDvybrSlfFCPclBEgSyEBk2iXpaI/aGvz/YmGEvq708AMUGF+CSppMznB8XicQjQwk/5kNQ5C+KOgyUGlN/o3SZhmXtCNFRdONsVj1EUqx9wr8lRV34+avzf6EDWJBCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393577; c=relaxed/simple;
	bh=ySDIr9l2m+Jd+JGPVdUPTZp2zqmRa9iBEAfWtXwnmIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AjtwuPY8XRm2Vs3lB3dH+/aOrICWtuxO4mb8af+hlHpfIU2dg+mRxEbDBwzXrBpbusLWqaMpwwLhfLdcN+qIg1rJSPAKBlGeXuzC1L9ueoZ+G3OcGe2sveCHDXXd1LV2L0h5l8la/yrbY/3XUOs8n5EEHI+OX1sOLbCIJFzKcTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T3UJOVdh; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T3UJOVdh"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-476a304a8edso64135181cf.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Mar 2025 07:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742393574; x=1742998374; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g2YfTvD2/55hm0SOc6xswXVwrnt/aq96H7eHmopxRao=;
        b=T3UJOVdhePtqWcBn6rRP8Pm5Q0w7tlbtpFm6adG/YKGfRcl10bXJfMSDWnh2/2OIWL
         nUPSSp/1oZA83tcx3HSZfRUpdEXe5PF1N1O6o/mKVMQ0QYJsUBf9yBHf5VxE39WrWOck
         uTDDUbRYF4fXVFH9Rp+JCatxj46rN0sgU8urxg7ecDefYYb1mmW5VrUvwvTww5npAuAr
         DNdTiJzS4YaGcbLmK/Sc8DvJhwMiawfMiVutwNAkkU5906BiTmmPUMld+KxWS/6bw0Xk
         fuyYcmBNpQ0GsH0VVUSNtMi5Nv9E/VUd/AUjhpXCBD5WxW/1XeWZlZS7Op458eYVWEvR
         5dTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742393574; x=1742998374;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2YfTvD2/55hm0SOc6xswXVwrnt/aq96H7eHmopxRao=;
        b=dRTqv5ljdFD0OPPTaNwihq3AgVqmFNsJXC/cQaZCnNstYI33jrxxytWXym50JMXP+T
         NkABHzMl5ETL0scFAO+5uPDD+HYWLflFt6UtBEKdiHjMUHFOqzlVMTY58UwqTBmhTWZ7
         JArooS4QWSXEJjHbGIKe1NUxNMxjAOiwX93UJpXSvUcz6M3kkI2Gnv3EzzyWb+jpEVRA
         Zf51XonOo1nxj5q0SijNFZY96Av7iZLBLauPOBq/pRuc5QCXI5SYRv5bhaT2V0FMAn41
         A1LFqjMZZnoHxzK3lRcsH2DnzCK8VTol0NOcdQvWZIThIQ2cAVMw+/0u2R/Qk0KfHSEE
         97ng==
X-Forwarded-Encrypted: i=1; AJvYcCV9det0zIyp6M1yH1Fko3AdvlHlhJMi2NE1460c8uNWpKx7pA926ul2LxbsMl74apE/IfKAMtMwhFGcoQAChx9OMYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqVoA2AX0OT62lEo34N1y5dDeCacpAboFkrM/QnjRAE4R2ZzFw
	m2r4S0TmnS8LFef9hyIPxQeRC4BoYaCImIabjEKI/B1/n8GmpeE/C/c1JMLOiZcTuHN8Io50LhS
	/8KV7rxlAqL9BG2vYw9hHkYEAdRyqshaTsTfWvw==
X-Gm-Gg: ASbGnctOiVw9rmndAIiC0SKnCw37y0O5vmOaHCfd6EKOUf91Idd8Bglzpg8zXvhtyQV
	um1LBNhN6H0t7SzNkryK/99F8Pbt68kHHbO7QXYTA4Lq9o2DD7YWqoB8P97IUr5vZTq9Bzj4t0Y
	XYOsgO+6y8iILCdVh2AfC0NqBYovxOU4D09XCXP3c5x6gPj8Noo+/8uzxi9jliXVaQJg==
X-Google-Smtp-Source: AGHT+IFokCZxMSPASeS8sQO66AH68XgDDa6uTS9Ilh1ggsKHJfollpOIDEvb3Q7KWsiQ8o1LIpGUf6eLM3TI1GjCf84=
X-Received: by 2002:a05:622a:5810:b0:474:db2f:bd32 with SMTP id
 d75a77b69052e-4770838f052mr55210591cf.38.1742393574179; Wed, 19 Mar 2025
 07:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYs62qxt1PajEp2A8uUmQFeAsC2JBV2wuspbAxz_hFF7CA@mail.gmail.com>
In-Reply-To: <CA+G9fYs62qxt1PajEp2A8uUmQFeAsC2JBV2wuspbAxz_hFF7CA@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 19 Mar 2025 19:42:42 +0530
X-Gm-Features: AQ5f1JrgZ24_4kYc02QojtSn0ALivXm4du0GI0w4tWVdst8x-N1I8HCsYB_V6UE
Message-ID: <CA+G9fYu54p6zQpX3Kw4dy+Yy3BM66r_iawvLchPvsB_Sq_wCNQ@mail.gmail.com>
Subject: Re: next-20250319: arm shmobile_defconfig trace.c undefined type
 'struct module'
To: Steven Rostedt <rostedt@goodmis.org>, open list <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Mar 2025 at 17:01, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Regressions on arm the shmobile_defconfig builds failed with clang-20 and gcc-13
>
> First seen on the next-20250312
>  Good: next-20250311
>  Bad:  next-20250312 .. next-20250319
>
> Regressions found on arm:
>  - gcc-13-shmobile_defconfig
>  - gcc-8-shmobile_defconfig
>  - clang-20-shmobile_defconfig
>
> Regression Analysis:
>  - New regression? Yes
>  - Reproducible? Yes
>
> Build regression: arm shmobile_defconfig trace.c undefined type 'struct module'
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Anders bisected this build regression to the following commit,

# first bad commit:
   [dca91c1c54686914dec4dabea8bae4f365c02007]
   tracing: Have persistent trace instances save module addresses

Lore link,
 - https://lore.kernel.org/all/CA+G9fYs62qxt1PajEp2A8uUmQFeAsC2JBV2wuspbAxz_hFF7CA@mail.gmail.com/

>
> ## Build log
> kernel/trace/trace.c: In function 'save_mod':
> kernel/trace/trace.c:6036:45: error: invalid use of undefined type
> 'struct module'
>  6036 |         entry->mod_addr = (unsigned long)mod->mem[MOD_TEXT].base;
>       |                                             ^~
> kernel/trace/trace.c:6036:51: error: 'MOD_TEXT' undeclared (first use
> in this function)
>  6036 |         entry->mod_addr = (unsigned long)mod->mem[MOD_TEXT].base;
>       |                                                   ^~~~~~~~
>
> ## Source
> * Kernel version: 6.14.0-rc7
> * Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> * Git sha: ff7f9b199e3f4cc7d61df5a9a26a7cbb5c1492e6
> * Git describe: next-20250319
> * Project details:
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250319
>
> ## Build
> * Build log: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250319/testrun/27672563/suite/build/test/gcc-13-shmobile_defconfig/log
> * Build history:
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250319/testrun/27672563/suite/build/test/gcc-13-shmobile_defconfig/history/
> * Build details:
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250319/testrun/27672563/suite/build/test/gcc-13-shmobile_defconfig
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2uX2E69ngTqvrymzOdYQz0JQ16z/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2uX2E69ngTqvrymzOdYQz0JQ16z/config
>
> ## Steps to reproduce
>  - tuxmake --runtime podman --target-arch arm --toolchain gcc-13
> --kconfig shmobile_defconfig
>
>
> --
> Linaro LKFT
> https://lkft.linaro.org
