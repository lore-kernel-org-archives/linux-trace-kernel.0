Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509642153FE
	for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Apr 2025 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744993144; cv=none; b=e0EyuwE2Wp7upvuzAT9KApoxU+dEL8p+W2I0ePar7U0zQAiNFn1Z2+I3hbk2lrU4JK0hTD8wzWtx5AnNzvF7Ac3MNYFlh3H2pgZGzF14zIO2TxJU2co5y3zMXqDX11CHKVW73GnmF3KqXtkM8fx+Jjuz3onwIf58oZ2EpxJ0+mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744993144; c=relaxed/simple;
	bh=pEQkVLsnkE1RxkW4tmeDCCG5BRacLN6ef5ZA7YDStxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GCNeI9196xvUKGE12rq+QsFJ/mDfJ0rp70dWZAZpU7w/sBVWJGgQfafvLcIvfYIfad1Y55Ava845QpaidAB93O/doUA8NgodyfOyUt6zy8D5QOMPnG7fstseG+gkTQRccsImrZP/e4jVOBwUmHBg+q4GtjMK5ZAz35Qs6OuA0rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=F9VzvW29; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="F9VzvW29"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d8dcc7cd17so2132115ab.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Apr 2025 09:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1744993141; x=1745597941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ePfKgP0uKVNFgoT+zVQWJDPRxOOn/U+ue7Il0AVta4I=;
        b=F9VzvW29U6wQHoo+E3S3SpoJdx1O3lIlgWoLnbGvyuqd/iQtSbqhnurCQKIq1AqJRb
         BSez9qC7YwFvvGq9Epe1jRhpRFCU230d1H6jL++NlhtwYSdkfkiUY4gHe8ToKwdyVJ0Q
         79GQFUyDRawqqZ8CLEMmq4OwaNG9Wo0O7NnZIFFAAnkqBnOcm7z7hM7kRMDyzMoK9GB3
         7i15k31q9pMIS6BjZi8Kcz1msdQvHWm8u/coCXjywHezwKz8JjxcxQms0ykV5Xr+3Nxp
         Ab93uEQwwj8V4Unw/VYQctLFNY6ADIwXLJN1GKhSgiJFQ9YSuzKRCJ/v5bGuN/smq9iM
         1qqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744993141; x=1745597941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ePfKgP0uKVNFgoT+zVQWJDPRxOOn/U+ue7Il0AVta4I=;
        b=Oo9V5q6JX1u3yjyL1gD1nZO9XTSCWLVSfITpNZlHDQ3148E8I6d16n/I2/pbKGycP3
         AtWKVDIzaRv9cCfcJCdWSFki6763SkXbARK9IdRgXpjgAwvwU4HUfeOY8PGEQgQNO3F/
         /hJEbYIROXS/Bpbn1nfK/hZPBF3vWud6M7/q83A77PLR+mGlgD29S71+3gS7Vut3mUkL
         MMoiNocZEo7ca0dCeo34c2wQTSRIJjtYfiDd+vAHNp6m4BGSuPubaGccwk23xO6GyKZK
         ebxN/p5ywqF6KP+N/89GbTpUembmaUsoTPiyRk9r8iYNBuTpXDzg5qvfSmmOFcP+LnrQ
         koZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+Sk5OHoKUL8m9sGKMqpgim2NHTtowGqCcB51EMjbywVLVpP2QiKEmyeJ0vfrfp7IWItpxUsg6pt3vy/3AZSI6pOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznI/98r7qFSWC3Oj12yARirkj07h2np7m1BrVcivfHznKP3jKT
	E9ETUQmsdbHQk2C0fzwvRRfugkB8HUA0SIIuI2clE4pGX11UBsKOODp9tczss0A=
X-Gm-Gg: ASbGnctqYTs/XQ9W0m6xbP9olOk8bT6BVr8qawY3ae8o02dRQO2qPDb1rENo2zyQYzU
	bIXbul67p1ElW44zdstNPV74q/cb9JnCAyjsQRGqx9SfYAl2Lg/apnH2tOtiK5m6dghyuA9WJ6Z
	Vkx8BdRsbgrBI2FhNhuZTo1dDdBTNzqkP8H41ALhrKd8jTTyotyaoniw1ojRGKrZpQiJwsv89if
	Dxr63CvhaAcQq+Flk2wqmHvCNwUbaqAsQwsmxRYPEkWdp/Od/4zjgjJuXtvaK9MPysOqpWOcAF7
	HsYa7+w32masSpErSZd4xFuABdkUK0I6KtQ4kOENA/daa4WfqGIT3Ayx6w==
X-Google-Smtp-Source: AGHT+IEvYD8CyOarFeAdARgzHXcquFCOFcE3q2vpY4E/2mOeo90KFv9nv8xpCX6+Lrf2zXFCiqzeag==
X-Received: by 2002:a05:6e02:178b:b0:3d4:6ed4:e0a with SMTP id e9e14a558f8ab-3d8b69608b7mr23960585ab.4.1744993141239;
        Fri, 18 Apr 2025 09:19:01 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.166])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d821d43a1bsm5092915ab.32.2025.04.18.09.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 09:19:00 -0700 (PDT)
Message-ID: <b864fc90-1297-4e1d-8487-61049e23e405@sifive.com>
Date: Fri, 18 Apr 2025 11:18:59 -0500
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH fixes] riscv: uprobes: Add missing fence.i after building
 the XOL buffer
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>,
 linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20250417074952.1315641-1-bjorn@kernel.org>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20250417074952.1315641-1-bjorn@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Björn,

On 2025-04-17 2:49 AM, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> The XOL (execute out-of-line) buffer is used to single-step the
> replaced instruction(s) for uprobes. The RISC-V port was missing a
> proper fence.i (i$ flushing) after constructing the XOL buffer, which
> can result in incorrect execution of stale/broken instructions.
> 
> This was found running the BPF selftests "test_progs:
> uprobe_autoattach, attach_probe" on the Spacemit K1/X60, where the
> uprobes tests randomly blew up.
> 
> Fixes: 74784081aac8 ("riscv: Add uprobes supported")
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>  arch/riscv/kernel/probes/uprobes.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
> index 4b3dc8beaf77..4faef92dd771 100644
> --- a/arch/riscv/kernel/probes/uprobes.c
> +++ b/arch/riscv/kernel/probes/uprobes.c
> @@ -176,13 +176,6 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
>  		*(uprobe_opcode_t *)dst = __BUG_INSN_32;
>  	}
>  
> +	flush_icache_range((unsigned long)dst, (unsigned long)dst + len);

This works because flush_icache_range currently ignores the range, but
semantically is not quite right, because of the line just above the context that
increments dst. If the range was respected, this would only flush the ebreak,
not the preceding single-stepped instruction.

Regards,
Samuel

>  	kunmap_atomic(kaddr);
> -
> -	/*
> -	 * We probably need flush_icache_user_page() but it needs vma.
> -	 * This should work on most of architectures by default. If
> -	 * architecture needs to do something different it can define
> -	 * its own version of the function.
> -	 */
> -	flush_dcache_page(page);
>  }
> 
> base-commit: 1a1d569a75f3ab2923cb62daf356d102e4df2b86

