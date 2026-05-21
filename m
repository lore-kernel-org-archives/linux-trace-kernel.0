Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E5D2D7D27
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353646; cv=pass; b=Wc4th3IgLwxR2qAa236wz/yEAkasp1mM5BLNr8cMCndGGaTs1Lvb6DRBd8Lxz7mtO0M8/nLEM3eP9Hg9+pIN3J5e6/zGV08QDJR5B3AROckgquIYqOLKJxHg0jqiFVv6KSsCI0mDcPyOGcbANanyHm3lHk4HSkHUr4X36QnYX5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353646; c=relaxed/simple;
	bh=BlROpg/oMQ6qyw2CniwdkMcN/+oY12kcabYx5q1tsm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPPTwBDNOaFPKyXn23PhpaQNWzPsjIar/3M189Rvd9PZg0uUI6FUVVfqRPBPF0JbFbO9emSc6I/5NpkF0kbNuEX7K4AVlNo2HBgkeZXL5wRznsPMdukzg25IM17wc48HshJ4rHYPXms9y5Lb8E+Z8jH4ZiDMz7b073UVRrol7bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BN5jP55N; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BN5jP55N"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50d864c23bdso10211cf.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 01:54:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779353644; cv=none;
        d=google.com; s=arc-20240605;
        b=TuU3PFILgHa9iu/o2wpVLJ0ZMStX9l8IWko5cx98mJ+dK+X1o+i5XCDeWXo4UbG2ce
         D6Rz8FjvopoPKh1o8lW8oJHJwPBNcxell3zSxDJYxP11xUAg1N9zk1z1zNs5+5JKoNMf
         9PrrdTDoh2pZNEz9fTow52vXIjsyWNeL3SavBfy2kQ6vr3t6u+0oR2utWAfRVF5pTIGE
         GyISzVJXe39aN4DQTvXFHQBcT2rC1x6+gsPVOJ7Y+nj4CKh8SMJ1TUI1pLGMN6dw7P9V
         qJgy3N13AvfmkBLPdS5AxFhfoKQ0G2KcysZO5bEpoUOC9AOjFThOlK/KKxZe4LBNUDdN
         gO5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iMVZurvnpW2R3v2VYKC4plSUzv3+qTXQO7hckbnpapU=;
        fh=WqWdc4zgYBeiI32R5hVpegUfQDrtJRyxErmFUe9fI84=;
        b=LuHI1VgU8BDT0/c3ddOwxJ2P6y2DS6DtzBy/QRhN6ap+qfx8snVOf2WfoiSZZmXTTf
         PMWs44OUFFev55UbYQ1aVTGXClaxhz7YE/OMZwws3OgBlyE73Q4iuL9P1gTqzABMH9EP
         evPOHsckJaO58wDYwPrOb07nwVw6+lJFrMlLjgXE2qaiYxn3XKhUJZstl4Yj5iIBJFlI
         o5tJFctHJoke1ZQt5Z8vu8ivnVoMxKFQeZTvT1lGXr1Pji05dzlYu9+ELmrZdR0QBIPv
         pKVszky84lXK3KI4g11luAnbCBgOGR4Le6SWIJgSUn9FMR4pCJTESm9X66XW64DAjHwO
         hrJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779353644; x=1779958444; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iMVZurvnpW2R3v2VYKC4plSUzv3+qTXQO7hckbnpapU=;
        b=BN5jP55NPPw9UIZ2qVQVKD7Av3ym/lEOMlvrQqeFmhYNXnSy49oBoJ4Rl387X8seMj
         XJm5/p6PiZGxnb8qiNNXME6lr5o2U0E7Xw5FHeJaKmyXVTMbkXjZo/lXs73llKDnwZjY
         TjXDU8qACJ9aOsrcDt/rYFMO8uOgqjTJJxX2DNnV9X14uQT7IwAJ+3HCHHDwseyYCpfz
         fCl3qq+SYBr4v+yOtOHsd1EHeAuqS6s6YKUMc2c/P+Q4bRwyijR2MApo/T9BioJkSibu
         rrvOqFCyxohOlBjgGWqa+EZznn6TY+YbknPOA96lCJO/1TwVEMPvtTwD1Cc73ydAZbVQ
         9sEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779353644; x=1779958444;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMVZurvnpW2R3v2VYKC4plSUzv3+qTXQO7hckbnpapU=;
        b=Svad73bb4xjIuBOGljpF0Wy0B7uXHafrxpwgPU9Os1MigZv60VKp+uBrV4KRR3hBCl
         eb4BTwYv9oRHJDbnFaau1dV6Qliko/rihAF6r7HXtsbKC+c7E97fpJkEPzMi2P6hFpRc
         pKcWnh5xnF0d7HTOWRzEwydkird2f1dB9oXbONZwxvGzHXKJLpGUFsJpTvGlhb6FQvz2
         p8eWJIt3zrrEtyOksclT+ek3ObEqm2i9pHw+5HtTsEmu1vWrdCjr0jJfxw8VQaW96yM6
         qmAvt6hGl2KxkC95h0B2jhZrNT+R8t0uqDK9qEGFlIo2rHYWdsdq7XHFWTkOQMXHUBfp
         Egwg==
X-Forwarded-Encrypted: i=1; AFNElJ+Aygftz4QIdQPzoiqXAmQagLZ7u8YbqwP6W6TW5g0MwP4UlZos985wWnZUtmIZgnzzACYh4cqWXjKDrpD4MP9rBcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx26jVyfhmOjR/nS4yysg+s+R8CQnHyVJ8uOOe5HUoAfMjCWdPH
	WQPHSjmSqpeCikbEJzX0C4v4O7nE7R7HlWBC664PNVwBCkuZOe3ie73kLPArEjSQQhfjaufcpTk
	cZtZzMpvCNhovp+gLQoQH+mydmLDVJJy0PoPSfDmF
X-Gm-Gg: Acq92OGS58sFLcf67JokswI4i+CMvOw2SydUSx+QXkhixonrpLdGgflctJxUcGD8P0j
	Hx9Jj9NdPxshUvIe/dZ9oU1QHVEmQ9BjYaMyo2p3KtSG1rDuROFHhvYzkLnGZIUKrxOf2ZL+2dp
	TfRVCxBh3fLeQPjs2e8VVATyq+PbIGTh1bGF/K5NzKQ0k/qf9P7or8aAr60FfdWWdgBxdYUbx8B
	xdX4o0RN3xSX3Gl0QXUpnLFB+p+E7YaG4YyhxiQmvZciYo0fzSFRYQKrJJNkGmuEFOLQGxcB3Mu
	oxD5lTm4kdWdMCF8hbg=
X-Received: by 2002:a05:622a:2682:b0:516:cc18:4760 with SMTP id
 d75a77b69052e-516cc1848a3mr1318811cf.21.1779353643586; Thu, 21 May 2026
 01:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-20-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-20-91ab5a8b19a4@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 21 May 2026 09:54:00 +0100
X-Gm-Features: AVHnY4JjgkDwC5Px9qxOcGZwEfL7vQEDZaLkFA7McDQJ3moR9Atjhj_tt-FGzFY
Message-ID: <CA+EHjTwkX_K4S4CHNFvoP=vDUnzW9MyLxBFZzDrR3tM6yuKNTA@mail.gmail.com>
Subject: Re: [PATCH v6 20/43] KVM: guest_memfd: Enable INIT_SHARED on
 guest_memfd for x86 Coco VMs
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 May 2026 at 21:22, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Sean Christopherson <seanjc@google.com>
>
> Now that guest_memfd supports tracking private vs. shared within gmem
> itself, allow userspace to specify INIT_SHARED on a guest_memfd instance
> for x86 Confidential Computing (CoCo) VMs, so long as per-VM attributes
> are disabled, i.e. when it's actually possible for a guest_memfd instance
> to contain shared memory.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


> ---
>  arch/x86/kvm/x86.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 1560de1e95be0..6609957ecfea3 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -14172,14 +14172,13 @@ bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
>  }
>
>  #ifdef CONFIG_KVM_GUEST_MEMFD
> -/*
> - * KVM doesn't yet support initializing guest_memfd memory as shared for VMs
> - * with private memory (the private vs. shared tracking needs to be moved into
> - * guest_memfd).
> - */
>  bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
>  {
> -       return !kvm_arch_has_private_mem(kvm);
> +       /*
> +        * INIT_SHARED isn't supported if the memory attributes are per-VM,
> +        * in which case guest_memfd can _only_ be used for private memory.
> +        */
> +       return !vm_memory_attributes || !kvm_arch_has_private_mem(kvm);
>  }
>
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
>
> --
> 2.54.0.563.g4f69b47b94-goog
>
>
