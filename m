Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793876617;
	b=pQf0DwqpS4z1+uQBI8N0M4W/gGyYR0cxkhqjm4UnylDlMocvEfUFGTdbezBwMeW/MdHU
	 p00o6hMG/Zxxsetnkt92LwQyl6VVyTCXQ87Smu/KEsPW+eMTZqROTStvEo9vQrcggNiGW
	 yfLUcnL1QENCIlGwUlyNztKBX1+3rXVTLKgdhC/b2p9L3dUhwnuc8Tc3HA/oNa5PFfCs3
	 9LWY01/0FGtdHzM2e3SGSjcMuUSY1kd2x/5Jt97mpAlTy7gMKeqoW83sYpGmeAT5PNRr3
	 a5Ul84G1D9zXK/CP/QekDMX6FSslBADKxK7gXrBWCuWfWFo/CGrnEQ8WxwciVF+pfHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yX5s7D9zQjVJIVM16uZ610BYYXHAt3Bx8DUuT1rWOwk=;
	b=SeLpL/53PL/bdTAtXZE1bJ3O3nxTmW3wIoJLKll7ZSkW96mOHCqFHTcuJGBreGld+MYp
	 E8YPgRmvDCvFvrqXVzHtiC+tpecul9sDmtUWjB9XF9742/ffuusua5UbOUIbxRYwyy11m
	 EoM6mfDYs/o1CYMN/CB9xnSDeRd2PF3LUklYNEphYdAh8ZEJbHcI/uYpOCPbplwqfuQfc
	 uPWfFLLHeW5PpLLRSGzWJObx95+d172Jo5xijajR8YEihG4kznHDMJaTJqB/hAKqbtM9G
	 xPlU6yXqweQOFuWRuKTQFHWfafvis0tyLa7E6Zj/ZzE0iKHDxsL+RgEtukk7ivp2IoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="n4HtF/wU";
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A9D606A31B
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 11:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8A9D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n4HtF/wU
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so18804875e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Nov 2026 03:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793876615; x=1794481415; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yX5s7D9zQjVJIVM16uZ610BYYXHAt3Bx8DUuT1rWOwk=;
        b=n4HtF/wUtAa+dXD9MvE3PvN5R0dmBuCwH8LXJ18qdQ/5bRA+4dbljhoIEgom3+FESK
         2nWh85oVjoLzpZHMpA0/L3sovQe7ZiDCnUTPEDhbMWDazfMNpbMspUxPucnV/qZDKUJl
         8t0ZZjmaoFqt5WNAK22Q2C54f5/ouNIv40UZZr5dm2jPlet5q+6lu8bHzaAfFcGqbERs
         zAavqTu8AWBewo6LC+jrAb31ehj12KXi17xfOSS8KIC2fPTyEC6KzgKy222X780JY2Ax
         zG6OgtpeUgrFI7pqPjbNjdvkucbxKIq2fWC68+GcPMaC61Y6aswfopL3Zkqildj5Xa+m
         q7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793876615; x=1794481415;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yX5s7D9zQjVJIVM16uZ610BYYXHAt3Bx8DUuT1rWOwk=;
        b=kpQynZYx1nsTO6ATmR2/cvbplCKQEhebACGrFrazUMSCHEfT03lEy1eHvTCyqbpEbk
         CduEeKF17otYt63wdBYQXXdK6xrtkj1yDr+k7nX8T7CYm8D5LRfIA0hyMlsLcaS/i5O+
         XHjxkSp02ZOvhrvvsl5qprCwF/Y8NWDnj4gcMED65M6NJVz7x0yYKFNs7hPvZlOF0RaA
         OAodnCkXEMc0P13L4Q4r6nR+uTL8Ny+nvPLRKs6CnWcTqxsCDiYj0wemkAkif1nZaPSt
         qwyDF/sz133zJljimDFPlbK0jm6YPFeYPRgR8Qblaksm8Gn4yDfk2VrVqSKaXuG0qKNX
         ft1A==
X-Forwarded-Encrypted: i=1; AKwUvBx6EyBK/lRb4gzBIAqZSMXWQG89kyK8kaoP5AAIcdeg68NU+aL2Z9uqlhXJYKF6w9Hfmc06oOBqAfzTrkJbBBQc+rM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xnedvPLhLbrCXf5GSiwz8H7bqfS8kKAr0Yq5FvXN9HwjcZb2C
	JRG7s7VE6bR56Kzyn3MRSwTzEGf9zdO1uHTlxt7DDNI6W6yK7+fO54Pt
X-Gm-Gg: AYBFou2MydyRPI3XSCH94q6GgB3WT+gjUSPwuNBYpFr1VRyINCJBPgLlL5f6f9pdAwK
	EUElnuvj+4yDlmK9aEHrqNicGHJNe5gmc3xlZbOPhpfbIiaBtSdE5U0whaTXHpuOZQGbBXU3mUv
	m68e1MfohrFLU8u+OYEgFeKP0K20a7xq5Hz/PRPRQXX84KwYVuBBnQ3t0M9qlGyfu+GA5jCaZmC
	8FhfycRfkm7zhkmV2u2HEQSKIfdKRGZdCFESUu8qkod0V+jf91INffAPDDebgjIfIc46NgOmdGd
	JGkXLYy54rO7AWoiy2MRze8VR2D82HWM0IXe/Bkc4VjkrbWTVLbRhMFYRvY66jaeCJUH8WSIxvC
	qQbgoctrUoEHwVbjUtUItqWBkccgN61MzyuTM2k7S79shYsqs6O7kRWHGEGL+vkEu/yx5LOHHay
	XMyObRIvN99cQXthC9HoMbq/AFUr337arynGGnafU4oLi36UtgaJYarjFYu9HtwOzt47L1aRs7U
	C+P+eRNcGWa9EZuEBcj0LBvq5k/Qs+3fiECOX0MCw2L+SCl/1nBiS6Ov4QccpfHji3GlnZfQM0w
	u9cV7z4z/pKmbpkEOdmvJWu5FKKTePtk0FNGfcAGuXlrrMisw3cAw5HVBF0GNjZH
X-Received: by 2002:a05:600c:34d1:b0:4a2:133:45e1 with SMTP id 5b1f17b1804b1-4ac183d136dmr405416325e9.24.1793876615021;
        Thu, 05 Nov 2026 03:03:35 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed084f92sm9474430f8f.29.2026.11.05.03.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:03:34 -0800 (PST)
Date: Thu, 5 Nov 2026 11:03:33 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 linux-trace-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/user_events: cast pointers through uintptr_t
Message-ID: <20261105110333.0fa21741@pumpkin>
In-Reply-To: <20261103163913.640876-1-sashal@kernel.org>
References: <20261103163913.640876-1-sashal@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Nov 2026 11:39:13 -0500
Sasha Levin <sashal@kernel.org> wrote:

> From: Sasha Levin <sashal@kernel.org>
> To: Steven Rostedt <rostedt@goodmis.org>,  Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Beau Belgrave <beaub@linux.microsoft.com>,  linux-trace-kernel@vger.kernel.org,  Shuah Khan <shuah@kernel.org>,  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
> Subject: [PATCH] selftests/user_events: cast pointers through uintptr_t
> Date: Tue,  3 Nov 2026 11:39:13 -0500
> 
> The tests put pointers into the 64-bit fields of struct user_reg and
> struct user_unreg with a plain (__u64) cast, which warns on 32-bit
> architectures:
> 
>   abi_test.c:182:25: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> 
> Cast through uintptr_t.
> 
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
> Found with 32-bit builds of the selftests (gcc 16 and clang 21 with
> -m32, with and without -D_TIME_BITS=64 -D_FILE_OFFSET_BITS=64);
> KernelCI's 32-bit arm builds show the same warnings. The changed files
> build without them now, and the x86_64 builds don't change.
> 
>  .../testing/selftests/user_events/abi_test.c  | 10 +++---
>  .../testing/selftests/user_events/dyn_test.c  |  6 ++--
>  .../selftests/user_events/ftrace_test.c       | 32 +++++++++----------
>  .../testing/selftests/user_events/perf_test.c | 10 +++---
>  4 files changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
> index b71813eaf5c04..21e1e3cca1979 100644
> --- a/tools/testing/selftests/user_events/abi_test.c
> +++ b/tools/testing/selftests/user_events/abi_test.c
> @@ -179,10 +179,10 @@ static int reg_enable_multi(void *enable, int size, int bit, int flags,
>  	}
>  
>  	reg.size = sizeof(reg);
> -	reg.name_args = (__u64)full_args;
> +	reg.name_args = (__u64)(uintptr_t)full_args;

I'm sure you can't need both casts.

David

