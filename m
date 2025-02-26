Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFEB2222CF
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Feb 2025 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740597240; cv=none; b=PM8RXU8lTFqxoynHv/Mog1J43xgjxCltP7xNRxJdaMLCEo9qdIhaE78iYQUezLiCwsnN8mCpOTYCZiqjbK0donVNLXoUbgmKaAHivD/KDFeGX5XRheNysVbjFLsQ756qK/exD6iqsiWhKcUXsskNpBulD5wooxgwJCjsOieUla8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740597240; c=relaxed/simple;
	bh=vHzrEzooH4K8CcIGUei7pRVS17MmHjHrMcmzZoer/Ec=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Vwv7/duPdovlsEbPkdl6J/PeIdmV/XpRu7pA1fEuGn1W8sJdK8XkeOmwQp70PkxMpMBtkzP4vItdXnlc2mzuoMuCwcOefEGGvl7a2d6pyQ0/nbvDJTDnbLTQS/Q9+xVbRVSMSJZJjEbiP000OwW0hWiY/bWWmnUyw0aY0pUQis8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PrgrgjIB; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PrgrgjIB"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-471f4909650so1293021cf.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Feb 2025 11:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740597238; x=1741202038; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/7HubgIS3yguXLFwagiKL0MIanaDsiXeL1ZcDJnpI0=;
        b=PrgrgjIBDzFyuCW0/BkssmUrWr+ejDo9K2GOMxCGaRhnW6xhcbtTD1JwwVGKLo/83P
         3dM9rKUsAMq62CVpok1RfQHA2wfcnXMzJ18qMcZcYUdGiwaEKk+ikc6U0hO+hXP5eQ2E
         NyqwDG/QmtPKzQkkLdTGYwhvbp9CTaW2CN1tiR+JGk13bm+x5+rLq5IqlamFPgOFO8PM
         HjoHxNDXIv68a/z/4EiqGgLE/s9X5kBDvYWorhxzCCaJ/Ef6jGrbARuL5iiZvdsP0RaR
         Wk+ZOlH0gvpRUqepXN07eMUzObSySHsdNfhHZlo1wCex2FQyD78d2/r2De4OapeVF9iC
         RAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740597238; x=1741202038;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O/7HubgIS3yguXLFwagiKL0MIanaDsiXeL1ZcDJnpI0=;
        b=nqKjq5Q9a/aLadga9t8B7gTjnZmUmHW9FCR4NLDTg3Jgn95rjJMzBSHMGxr9ch9A78
         nLMoZg68PN7P/1ytdMVApu9SfmTQt3AuKUvBXx49khOQd+6Hs8CpVeptCvflKCZEIHJj
         e+Pq12ZuO3WJIQZ5ZGuq1UTW6LpKHttudSUq7Tr2rZFZuu/PqYFtxwLH1oXqL8fkZKDn
         QWXBiG7Zpr9EK1PWvFO3h9r3Tnqb96d/Vg9tJ81k7wHMhl3lXgPpe8Iky5p3rQMjZOC9
         VhcY4JpfpiyOsHAcCbspO4W5T/x8oivrG1mt4Dh30OBFbPclo3bjRY29bfrNFJlYzWsW
         qCPA==
X-Forwarded-Encrypted: i=1; AJvYcCX498G+HQlU8fVOe+vBcbDz8t+OX8HbUcLKUrJoVKVQ8Pj5dHeUM26+B/5hwZk5z24BHcVpG8UdY3kqCKN62O4E9Ys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws8nzxsId0w2QuX2ZNz0rd1jsIhTgOBgejJ3l3QBmaPbdhhhxK
	z1/ETlTFvVFOHlPp06J2GBO31nLjNhiCjkQWwblqt7Gt+S56IgNzdmmlH/jyVA==
X-Gm-Gg: ASbGncsvwuQxPElsnaSuDYuJ18xgZ+Ty3SEU1PDPXLWoFkuMY/HeXGmz62Fwa+TOY/B
	/NtU1FiJS7MtseOmRuM4BJqKhmGQFdyF+nODFLYXom7t9HRXGtFto7ZwUEOZzGiPkAaZK/kA3un
	Ys8pJ83wcGAjsfbVXgWZQXsufsSh0D3QyMk5qqnVJWVsjD3ZUP8BlroyFt6kObkXIlyOgOAKGih
	yrEMyoRa6bI+KMiKn1+7gWpnkFrQbbUtq/fVJsY67cbp07PYwOz8UG2zdrrspeDx+ZTZ+eyC8jH
	RmiwUHM6PE7Iuaaj1nnSeMyuJVnyys4bRA+jclykRaCsuy9ZhGtP4y/QsC3JFHGgHVsxuiU=
X-Google-Smtp-Source: AGHT+IGZKQ763FRka4tXmeqX9uwcpJ0v96pIEchafXYFD2cwhU7ih42tfW2HHRWzr2HQKaEkzBO+qA==
X-Received: by 2002:a05:622a:1a07:b0:472:201c:aa45 with SMTP id d75a77b69052e-47377116ed2mr109013401cf.9.1740597237709;
        Wed, 26 Feb 2025 11:13:57 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47377e1543csm28407591cf.27.2025.02.26.11.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 11:13:57 -0800 (PST)
Date: Wed, 26 Feb 2025 14:13:56 -0500
Message-ID: <41cb98ddf724ade0fc529b8c952f3efc@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250226_1339/pstg-lib:20250226_1339/pstg-pwork:20250226_1339
From: Paul Moore <paul@paul-moore.com>
To: Luo Gengkun <luogengkun@huaweicloud.com>, peterz@infradead.org
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, will@kernel.org, jmorris@namei.org, serge@hallyn.com, rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, stephen.smalley.work@gmail.com, omosnace@redhat.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, luogengkun@huaweicloud.com
Subject: Re: [PATCH 1/2] perf: Remove unnecessary parameter of security check
References: <20241223070650.2810747-2-luogengkun@huaweicloud.com>
In-Reply-To: <20241223070650.2810747-2-luogengkun@huaweicloud.com>

On Dec 23, 2024 Luo Gengkun <luogengkun@huaweicloud.com> wrote:
> 
> It seems that the attr parameter was never been used in security
> checks since it was first introduced by:
> 
> commit da97e18458fb ("perf_event: Add support for LSM and SELinux checks")
> 
> so remove it.
> 
> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/events/intel/bts.c     |  2 +-
>  arch/x86/events/intel/core.c    |  2 +-
>  arch/x86/events/intel/p4.c      |  2 +-
>  drivers/perf/arm_spe_pmu.c      |  4 ++--
>  include/linux/lsm_hook_defs.h   |  2 +-
>  include/linux/perf_event.h      | 10 +++++-----
>  include/linux/security.h        |  5 ++---
>  kernel/events/core.c            | 14 +++++++-------
>  kernel/trace/trace_event_perf.c |  4 ++--
>  security/security.c             |  5 ++---
>  security/selinux/hooks.c        |  2 +-
>  11 files changed, 25 insertions(+), 27 deletions(-)

Now that we have Ingo's Reviewed-by, I've gone ahead and merged
patch 1/2 into lsm/dev, thanks everyone!

--
paul-moore.com
