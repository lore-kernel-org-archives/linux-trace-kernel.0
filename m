Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com [74.125.231.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7DC46D08B
	for <linux-trace-kernel@vger.kernel.org>; Sun,  4 Oct 2026 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791133580; cv=none; b=tP8i7Q3w9xQsYiShmCleVN06H55mYFhNOJb+EBLU/021UC3V3J6Q676zTwVJZNwrrOxg3/OEBGuH4xylPgXJqQmhgYmlZt5xv9EN3bndzvTxG/QyR0eur1HIZJTyM/aiVffd9cN7Sr6DfXsjMDsk6hj6ZaRMm4ixIDqfuoec+7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791133580; c=relaxed/simple;
	bh=Fvw3a11k1H96MSgvLcQCHxdBO3T96s8ZzddX0DVJ1pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=quvF4/VtyYzBOhfDMe+2a2RGGMhddwehJuigM0ZtLUb5J43KOVuroiy2yfcbeqN7wjMjfJZejEzc6KKhTWX+ZVt7CNftkNa+6+wjXkfGM4Cxq/V/Z1OrV7eMJ4okRVaMvb3Q6uLdjRRlnZkEvLtjw2CsrY5q9jsPFXP48FQEn8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFZaQnRB; arc=none smtp.client-ip=74.125.231.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFZaQnRB"
Received: by mail-oa2-f35.google.com with SMTP id 586e51a60fabf-466ccde2a99so503326fac.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 04 Oct 2026 10:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791133577; x=1791738377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fvw3a11k1H96MSgvLcQCHxdBO3T96s8ZzddX0DVJ1pA=;
        b=iFZaQnRBTxHhqkgur48WM1HO8TyCe0zFlpgzDitYmGqCC3fb+elMjTXxXq9/DAoMwn
         uYMZgh9L6Xvd/vjeMw5O7Nnz+qdGxQKq+05bL35efQDKxcB/ruQdiRxkzkyV2OYt3eqE
         yJ5qCSikCwFrL59lARRgJbA+bn3wdwUS9o1e8BH2+NG0OGm8joR+Yk8PsSK3Pxq0wRoo
         syuVd4lPFVyVQOAl1M+EvKRIpEI160smZnOGEb+xh7F1o1L0Pl8nWJ8WXopkm9GO3FtU
         Iy8ReazmqfhQqDEY5+FH1JS0BU6S4qdabo2aR23b7fYHUditNSYJV95Ys7+OO5N0rXq9
         Dtqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791133577; x=1791738377;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fvw3a11k1H96MSgvLcQCHxdBO3T96s8ZzddX0DVJ1pA=;
        b=Wa/yttK1O/lJ/jqr9oSYCJ88LBIi9M3fVug2ELt+GEBEdP1rdbssOk9LRkbuZq+ZTz
         u9NcLH7UUcMjF2C3mw3zeVZjGtGzsNQOnOQosO10gmhPjYeSxlqjVmY1vrnX7ILCoDcD
         1Wbv2Ul8e7E+XR1vRb4giPoAWRGdrONh/CrYzrPV/3pzKtUaMeHxxeQpJe0KFYaIaFb1
         l89tdKGIOkRe6XIDM1rjBqPH1ioHz80czSC6H1VWe+p/WjxIh3MRkWHcMACnpogQzzTA
         bQWyxW99GXL+40LZz8+Xc2awc781O5ackqZmTbbteu/i0QxGwFMcRW6NxKRmtjgaZp/X
         x8eQ==
X-Forwarded-Encrypted: i=1; AKwUvByIDGGwaN1AsbHBgNbYka3Q/wDbpKnln2WoXoUxVyghQ1gApvQPS6AU2r+40LJqbUoeOHIZBkx6b3tjoM5hWFW6xGY=@vger.kernel.org
X-Gm-Message-State: AFuF++mjscEf/HIuLneYgXPi/Jyc5m4Pm0S750WdAVYH0uA5M7QSLcu4
	WPy7knzyBlzCGctNiJLp03njyui0yMyyh6N8cByf/JI8O4Mg4krIkzYI
X-Gm-Gg: AYBFou0brIvVfvCll4HnPIFkBxb26kWZlWS47LgBSJnWFxpqa9kNjruo4czctyG6+Z8
	5zQfuymOJdlW/ZEpzOSQDpSFJFHuQ8vvCCiUQBGRUcw2dLn7HsBZX8AptK8pH/3UQ2ZoI2qOrn2
	Yft1Ee68J1Te9LSqJQcl4pdHdk4KbXBtYJUDV95cCJp6Sb5zG32p0Eie/XT43cyUQ8Iv1J2mSkN
	5m39zN/qwUDOyLkMeMBZswUZGaOvYL5jhy9lKq0gMwrrdGgIAj9jPGLxUtd65Hoih5/rCzdb0By
	xb/fVuWa5Di1gApKLK5cvzrGpFaWGmI3u8//fkJ6fvSxL3IVveLqD8IipwlO8SnRV11nt/4PViX
	yve6L0qeGKn5+TGN8pl1UIfmsgLRU/Ud6LS5h+aMVdJkPHk5dOKkaND1ZxkUWb4ou7rs0EJw8aV
	2XtrtiYC/26TqB32+g+COg/+G+R6qogChIEc+UUrZiVQW44E9RVQl7aso+Cke48tIDOU+sWkTp8
	PBt1zkK7WIphEj8f16dmVMkzgdPjIfEOeLy++f9Cuj3nME6mQTzrxYr/VexC4z1B9G3ccUW4HgF
	ub1WRNEz4Q==
X-Received: by 2002:a05:6870:b50d:b0:485:d31b:7767 with SMTP id 586e51a60fabf-49e15dc52bfmr7641789fac.37.1791133576582;
        Sun, 04 Oct 2026 10:06:16 -0700 (PDT)
Received: from starship.unifi.local (107-216-42-6.lightspeed.austtx.sbcglobal.net. [107.216.42.6])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49e16545353sm7403626fac.0.2026.10.04.10.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 10:06:15 -0700 (PDT)
From: Lawrence Lin <deduce@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	linux-modules@vger.kernel.org,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Avoid quadratic symbol lookups in ftrace_module_enable()
Date: Sun,  4 Oct 2026 12:05:58 -0500
Message-ID: <20261004170600.1541723-1-deduce@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004050904.06a5ecab@fedora>
References: <20261003-ftrace-mod-bsearch-v1-1-92e2fd2d80ff@gmail.com> <20261004050904.06a5ecab@fedora>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 4 Oct 2026 05:09:04 -0400, Steven Rostedt wrote:
> It would be interesting if it actually triggers (finds something). If
> it doesn't, then I think we should just remove that code instead of
> adding more complexity to it.

It does trigger, but only for modules. On x86_64 v7.2.5 with kvm loaded,
available_filter_functions has 18 __ftrace_invalid_address___ entries,
all of them in [kvm] and none in vmlinux. Each one is a __weak default
from virt/kvm/ (kvm_arch_vm_compat_ioctl, kvm_arch_shutdown,
kvm_arch_dy_runnable, ...) that arch/x86/kvm/ overrides inside the same
kvm.ko. In kvm.ko, no symbol covers any of the 18 addresses, and each
body is a stub that returns, returns a constant, or tail calls.

ef378c3b823385 fixed this for vmlinux at build time, but sorttable only
runs on vmlinux, so modules still depend on the check. In its changelog
you wrote that "the real solution is to not add a weak function into
the ftrace table in the first place". For modules, that can be done at
load time, and it would make this patch much smaller.

ftrace_module_init() runs after the module's symbols are set up and
before any record exists, and ftrace_process_locs() already sorts the
module's locations and skips zero entries. A location is valid exactly
when some symbol, under the filters find_kallsyms_symbol() applies, lies
within FTRACE_MCOUNT_MAX_OFFSET below it. So one pass over the module's
symbols, with a binary search of the sorted locations for each symbol,
can mark the valid locations in a bitmap, one bit per location. The
remaining locations can then be zeroed before the records are created.
ftrace_module_enable() would then drop its test_for_valid_rec() call,
and the weak stubs would disappear from available_filter_functions the
same way they did for vmlinux.

That keeps the work out of ftrace_lock, avoids sorting the symbols and
replaces the 500 KB array with a bitmap of a few KB, at the cost of a
small iterator in kernel/module/kallsyms.c, since the symbol filters
live there.

Would you take a v2 along those lines? I'm starting a prototype now and
will measure it on the same machine with the same boots as v1. Then
I'll post the numbers with the v2.
