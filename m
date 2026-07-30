Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330DA3DA5D9
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 22:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450154; cv=pass; b=ubZAe7NgK+VByGxyg55UAJj4e8w/NNWHfo+kw2vzMulDKNUChLLkyfK/AXwBVZJsT17c+08SU+uYXOQAEGHOJpzRni60yiO5q1HxdbQ2r2f9xj0zffBKUNV+TS4jtPpVHLT+NGgmg3C1LMrfhnisn7W9lyUHcGZJcfBuwNW2t9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450154; c=relaxed/simple;
	bh=TwuTFoIIkzmwmA8oaGhsoy6UeQB2MH+oAc9PwYUacYQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7MTFMmB1vUTkqB/57E0BhtZAUyVq3QkeWme0mDcxKnFOAndS2yMxcdtXTnV1swu1qXeunNgZqM/Drcb9Hp0rx0uvwbGcb/wn0gM3aXurvbNxFLVC6daVqFIvgezZ1kAADh+R5lLl7p9FfMwEyREPiwJc18aaHVq7F2x0I2WEvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WDWBZ4VI; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WDWBZ4VI"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca80d708489so119322a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 15:22:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785450151; cv=none;
        d=google.com; s=arc-20260327;
        b=JpH/tHDH6WPtNpzoZZ2zbltmZeG+V9Zmr6v+BbNyHmFQRyi9hs/1OkZPpVlARpsaXE
         7pvumlmDRVfrF3g/XUXUaPmRnMuauzWhOSJgwsKlcprcN72CEGDQ/0bnHsIhQhdJhoG1
         W7uDxDmac5xB53q2k0ACPEK3Bl6sB9LPkDTpV5bxffFowjgtbyEHiQ1jXbQ6ZG/rUT+D
         fC1n9kg/cs7ETbHbzYqMCek233aC4aCQ+C7JzMF5Ch43TqR4LWCE9BJiufTjURhJjxE2
         3bXB7+IuNitPkq09MJMuUzPPHLQodZLKp33/wz1KHMx1neXtvneQdA/YW/wRROCiV2uW
         3ZYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=KKK3RxskpKfni5OmmKwhdX+l3ihKYPthumPMEB1IvdA=;
        fh=WcgzIrOZ+//k9UbspLGze6lWjfdwkr+xaIvxiywyoIw=;
        b=ouig3jhGGVQDNmVykRyYmkclGLd74j8nN6rHFvGhuwv93/HcjCyX30JAj/R+GHrVRn
         FXGPdC14rP5oPy1QT4EbzEDvbUc4R9QKLuEG7jCia4de5PFp5ndwdkdpKhPP4ODm4MC5
         ofuIRlP9zZHi1JVmYycdwXzkWHwVrI5cMfQ5AbK34CJShV7IkXrAHUaX9PgVL5OstfGo
         sfMOBUMSrq9xzxk0/Ek4p0aswgLmYyXXlwQzXWVTzmbefNfGhlZgCKyCspkOe8TDDqRL
         K9nM+HOfJzQusM46J6JkTeDaiC3OtZKRqILimQMdN7Lg9Gje13VT+UXUKcHj3aewjmo8
         UYiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785450151; x=1786054951; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KKK3RxskpKfni5OmmKwhdX+l3ihKYPthumPMEB1IvdA=;
        b=WDWBZ4VIMh3Ow1a+yhceUSQeY6vEwLZw5Nn3JutScqAqRVRkWEYlR5Mig1nBYs5XUe
         haQprMxiqiWLa1R7jmCp/NuQNkkFttPOiZLYHfutYjO5WtH7Vd4YCvpUBu/EhTFrGOIR
         cs/yztxzs9ycy+0j7EJQUnZvLHubkaJPy4MO3ub0tIIY8ESyV7024gxXzXwvfutuHTyJ
         L6v02gDP4SoWQ0FVLbGxKZxcR+qHOk8QXYnIa8tEgkylWDwMS6kZWho0yFJKDrWHLKvh
         maO0lL5rLij6qN76vyTFzf3CkR37gJR5/8JgKeL7opDcBpMGnfl6RheIjlvq0JJYKaEd
         IkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785450151; x=1786054951;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KKK3RxskpKfni5OmmKwhdX+l3ihKYPthumPMEB1IvdA=;
        b=SlFcpdSzEqT4YCM7o44S3Hk4IumHppgPUcy9bPdFxTmGdSFJsNBoqulspRE/xw+lLc
         r03Asqd7ZWmUVtjFBLPpbKuazQ2gJdvESJxz7wPwgLxDRZ+lLkZxJi5d3ZYPCHjT6817
         qkAFyGqw/P/+vfSgnJJkqm9kZYh2XOom7UMdP8Lge5yIlIoX5Pipk3vjGDnBs1mP5gXe
         ESThQDJ4zRCj6siceXKfJj6NpCOMBLPlaTAeEHexkfQ/Ahyl4NQL3Xp5htrzgSjEEHpC
         +hELMEQ4G19Vxd2jPco4IWUdpW/Td2MX3pK602T6B8Oq4WcD2EWmlzb25TnIz8ZU/5s7
         XhOQ==
X-Forwarded-Encrypted: i=1; AHgh+RqGaL3GlLkxuNCX3ro0JDrmwBi/zALDoOWrHVnc/YSxLGWQ1QTsOS2NxNgWWbHpFxlEs4tIEGwur1tUjcr6rem8frI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/0EFZqZa5UYPKndNmgcQmzfTCLt9Kl0Xd4QsJda1xb01WLDX5
	BDyezSyyGyqsG3wUcAKtXl9D+tIAOhODNRmZDxIVaFf1O0HDtNUC5BtVJ/yAYz0GKHRpqRNo5nF
	1WDnqPXAgqH+rZQT2SCyGlV0CiHLnORrP5nttm012
X-Gm-Gg: AR+sD13EkDCFRDCNC3OFwn+ag+b3PLw9h2GfdXvlccVbS8ryJ0VE5DtwmcDua/i5TcJ
	nC2jT04B5k4w4zByDkaCSle0lwEjWBhfuVURkThoejThh77nQQzfm2p/GHBmGMt+LxYzaMlHi67
	Ppkt7M01tykeuYqftcBXdm709X/dvTBQjeE/mVpsXL1gQk39nvkpgKMNEEVpZhrh1HY4typHx+V
	xs45/1PuvuhwrqIB2fCpHqKKeO2fYT7O4PbeklbT4pGqwjxm0uoaYP4f93pz1orWhcd08FWh5UE
	bBFHx4H/yb/v/4G9QZqlFabhTkvPHxxGtrpzIZG9bsSw5IdlW1paF8nrkGer3kNZ9aeeRUnC5M+
	25oFhlWBSzCFt81krJyW8YzmVaXvlzvh1jpA=
X-Received: by 2002:a05:6a21:6da8:b0:3bf:9e85:b423 with SMTP id
 adf61e73a8af0-3c90da9f0e9mr1921619637.34.1785450150418; Thu, 30 Jul 2026
 15:22:30 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 15:22:29 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 15:22:29 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260728-gmem-inplace-conversion-v9-10-35f9aec2aed2@google.com>
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com> <20260728-gmem-inplace-conversion-v9-10-35f9aec2aed2@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 15:22:29 -0700
X-Gm-Features: AUfX_mw9STeH1QmcRlHkiOeSUMR5OU477trBpGu6VFzJOghNh8UuiEXaLRojjC4
Message-ID: <CAEvNRgHEDMnz7Fc7iyegC9wrc1R_AMHiWUN_rx=3Ly67bg1dNQ@mail.gmail.com>
Subject: Re: [PATCH v9 10/41] KVM: guest_memfd: Add base support for KVM_SET_MEMORY_ATTRIBUTES2
To: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, david@kernel.org, jmattson@google.com, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
writes:

> From: Ackerley Tng <ackerleytng@google.com>
>
> Add a new ioctl (and matching struct), KVM_SET_MEMORY_ATTRIBUTES2, using
> the same base ioctl number (0xd2), but with R/W semantics for the kernel
> instead of just read semantics.  "Officially" documenting that KVM writes
> to the payload will allow KVM to support partial/incremental conversions,
> instead of all-or-nothing updates (which requires complex unwinding), by
> recording the failing offset if an error occurs.
>
> Opportunistically add a new struct as well, even though KVM could squeeze
> the error offset into "struct kvm_memory_attributes", as there's no cost to
> doing so in practice.  Pad the struct with a pile of extra space to try and
> avoid ending up with "struct kvm_memory_attributes3" in the future.  Use
> the same layout for the fields that common to version 1 of the struct,
> e.g. to ease upgrading userspace, and to provide flexibility if KVM ever
> adds support for KVM_SET_MEMORY_ATTRIBUTES2 at VM scope.
>
> Introduce KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES to advertise the
> availability of the KVM_SET_MEMORY_ATTRIBUTES2 ioctl.
>
> Update the KVM API documentation to define the new ioctl and its behavior,
> and add the necessary UAPI definitions and capability checks.
>
> The process of setting memory attributes has a clear point of no return
> because, for CoCo VMs, zapping stage 2 page tables is a destructive
> operation. Unlike regular VMs, where re-faulting pages into the stage 2
> page tables merely incurs a performance penalty, CoCo guests must
> (re-):accept pages after every fault. To preserve CoCo security guarantees,
> guests will not accept pages they did not explicitly request faults
> for. Consequently, during memory conversions, any operation that could
> cause the process to abort must be completed before the stage 2 page tables
> are zapped.
>
> Zap only the ranges that are not already in the requested state to avoid
> inadvertently destroying (CoCo) data. ARM CCA guests will try to mark the
> entire DRAM as private at boot. If there are no shared pages at all, the
> to-private conversion can be skipped, but the existence of a single shared
> page would require the conversion process to proceed, and if it proceeds,
> zapping both shared and private pages would destroy data and break the
> guest.
>
> Co-developed-by: Vishal Annapurve <vannapurve@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Suggested-by: Michael Roth <michael.roth@amd.com>
> Tested-by: Shivank Garg <shivankg@amd.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>
> tmpo

tmpo is a stray addition from my rebasing/squashing.

> ---
>  Documentation/virt/kvm/api.rst |  63 +++++++++++++++++++++-
>  include/uapi/linux/kvm.h       |  15 ++++++
>  virt/kvm/guest_memfd.c         | 119 +++++++++++++++++++++++++++++++++++++++++
>  virt/kvm/kvm_main.c            |  23 +++++---
>  4 files changed, 212 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>
> [...snip...]
>
