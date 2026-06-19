Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8231F35202C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Jun 2026 08:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781856787; cv=pass; b=WXDkwUKGAEtCFjT1B+n+8jLiaqKPR8B/GNeMbpCWUPl24wQCly9ZJQFjUZK/NSoEVt3X/jbIMNCw7wT4AGEjVW/BbUqR60xmJ5lKeMVjEX2011Gkkbkm7hKq9ZR/EK9SzoJvjsdgBiyQezEf6E/o3gjxr8omdUiqwcqYz82A9P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781856787; c=relaxed/simple;
	bh=mhRQfYgewaEHTKhgMkBt4xMNRF1jHjLdpGKjwA/SfyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwzP/9Xf+dF6wvz+VY3NsPqDInoIvhw1XBDMpKzis3Na+XrhWJVjmv5Lk/v/tBxBcp9p4C/4ALW7vNkq10BO5IP/+ifaFhDYBqlhUrNCp9NzHuStTZaaOkpBFvf8jvGZmyYALZzwhIao7PW7gtaAo+xj15zhrPEFDplSQox1L50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sahczB/r; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sahczB/r"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51765531803so194701cf.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Jun 2026 01:13:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781856783; cv=none;
        d=google.com; s=arc-20260327;
        b=MVk1oIQ9HRkHRJhOOY/m8Y3j43Tio6TZnqKtIbw5OhBwKF2GApENNDWPSWaLlmq8c7
         P4ni+X6smOv+DBb8v8O3SIKL4PNa48oUCbSf/8EM+oJ1LDxsfnYFeqBvYLt2TD94Xan1
         RCrFGoNP0HKSgFoK3oXsVgU8AEfKF1Oza36sO2gDLNZGbJMTQDG+QJaQcmtqxaTF/HqD
         DCsTIKY4Q4zP0Y+Xm3RZSDsS2/Mf/IGMhxYG8hIfYz7K7NF6KzyGiYULEp5Mz+PO7lPf
         r9KlxCKzRtb+WCRFJVLa7fSrAtTDlAp8ZGeEZJ1LQ/KbtKqoGe5ikibXIRSrHuFfE/OA
         8WLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RFwtLOklkbcVKFnDpfEXKv2zd3HGlCKJCihUf5qCkBo=;
        fh=sbuTGCn5IPAQXhD4mhGwI12Mt2QiUwoAB17c+RDvMvI=;
        b=oGlFULhwnImqZnpKfRY3MDpLX9X3L8VtEjGaDKWbgiMXFbcqEsG4Jez7Cqe37HdlV6
         1j4uzV41jSSOTrl5MHko8i8fWSB2B03c8L19OLizb2HnQa+NXsr/3R8WbZoHKrC/85wL
         gximQjyqx4B+rtxYEAr0HufhG7hJn9GmjehPKQINLynmZouF2WoYJP8pfkM8qkLiyZyl
         HHgumd+2yCSeTa1JGKB8keB/e5BrH+1kbFdD71ud8hUhWDijL2zlGBeqTVPpPyTtrdrc
         RhVxFccVrP2GTxjl4gdqN+Oww6U6d2OnkZNGc9dTJlpwvF2HblH0EEIKT7TVsEorflh7
         F46g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781856783; x=1782461583; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RFwtLOklkbcVKFnDpfEXKv2zd3HGlCKJCihUf5qCkBo=;
        b=sahczB/rRnzk+ww2AZ1aNgNxt/nON3nOo+Wi824CuV3rJoCfe4RgPy9Elx7/zM/Vjk
         +8RH3kL/rA4+Sx/MXeSPmI9gj0wNz9nj1L5WFKQLCJdqgIdfX4PmOiESOl1iOo6Q4XDw
         sFuuoHhXCjsC03i9YUzkFoPPUhLZa5KWUFkLyDkzGTnP0icEdvlSY4EYgfzaN0ZEOJo4
         eNekKNaU8BYH5zAaXomtPwhTYdNjTggsd5rkZN7GJ4ftJPbItbsPKSPghimp/FGrA2ue
         mlt4+T3aY1PSAHL381lM2lqC1/Uiv9smlERNoSUXwXae7e6bJvPRki9+2p32tA5gzIdg
         hSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781856783; x=1782461583;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RFwtLOklkbcVKFnDpfEXKv2zd3HGlCKJCihUf5qCkBo=;
        b=pghX3BSGHhI7+pRtxBnxtZE0YebLjGpbC8AIkJNGJp00Z5A27wj7p2OzSscQmc8AzK
         5KUYdl7y2ndQH5p9Wms4OExvXN13nuoMFdF4CCJ3dSbgLFTA3aNeLWNsD6NcCRdxVfmJ
         DQddcTH/BM59/DRcRq1i3LBMSOvgCTAH8QOWaF1cHqFL8pnNICfym2sy85bxdwNl1FO2
         i+TKS26m9wQKUSFylvIwOkeCDIPEyuCG6eOAS0ceGALpbxEtLm43MeT3huABN92hB9HG
         Ap3EBGx6fS9p/j91lf0dDkz5qzEZs+xkznZOJ55V4CYGa+cFQbxJbY+TVN2DM38+9rJS
         5hzg==
X-Forwarded-Encrypted: i=1; AFNElJ+ADfLeReTAqg+6Hnqz3nzHTAIJhRr9xzMp8Koiapg0L2OYgYcq3qkUjDEdYoJb1U92DoYoR0ZfqZ/5UfZ/M6WVzug=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOPhBEVeLK8cb/pXqZaEXAHLxphyZUAJ+8m1Z4pJiiWC+B46Mz
	dvGqt41n1oWdHPz+YZpv2Z3TSLTJeGb1+pIYdu/VCVd+KHpXYadzrhdft6tB/awyu40ufkLdroD
	tKWd5wWvqp/XjLZGDVnc/meoLQ5ctty6aM0KysRjF
X-Gm-Gg: AfdE7cmb7TBC2W/nuelmCI0LROOtbFVcpt+/9vl65NEiuDMevrmwbbVAtbySr/23NNe
	5diMOwmPzMpVV/9apbTbMd7xtM9HBEYQ5GM/NQyx+xhGRDioA1LrVl0ih3yfXCQkNTltFcN8PLn
	N7ey2nGc6p5vMa2LrTQb4qEP+F6d0TsYTCWfLLh/iPv5s5UKZUJT8gd4sQCYwlpuHsu7TDd/hok
	F8MNEZ5oYTsHYJWHImdAxiu5gu0epO0fp2Xzju2jfQHzsbkXiZaTGReI/uJp/AHT3r3pEM2gdik
	RphkTWpw
X-Received: by 2002:a05:622a:1906:b0:516:4f62:85ea with SMTP id
 d75a77b69052e-519e8d3111amr4387331cf.21.1781856782436; Fri, 19 Jun 2026
 01:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-5-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-5-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 19 Jun 2026 09:12:25 +0100
X-Gm-Features: AVVi8CcN5N8mHAFYGVLMZrPjXc2jn5V9jAAbKlAQIrOrX_OPU6MaDRc17hIP_FI
Message-ID: <CA+EHjTwrfont5S84MpiwSLfk5doD_RwS96EX88e07c4-1DeMZw@mail.gmail.com>
Subject: Re: [PATCH v8 05/46] KVM: Make CONFIG_KVM_VM_MEMORY_ATTRIBUTES selectable
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
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
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jun 2026 at 01:31, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Ackerley Tng <ackerleytng@google.com>
>
> Make CONFIG_KVM_VM_MEMORY_ATTRIBUTES selectable, only for (CoCo) VM types
> that might use vm_memory_attributes.
>
> Also document CONFIG_KVM_VM_MEMORY_ATTRIBUTES to specifically be about the
> private/shared attribute.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

You're missing a SoB, but with that fixed:

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  arch/x86/kvm/Kconfig | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 24f96396cfa1c..c28393dc664eb 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -81,13 +81,16 @@ config KVM_WERROR
>           If in doubt, say "N".
>
>  config KVM_VM_MEMORY_ATTRIBUTES
> -       bool
> +       depends on KVM_SW_PROTECTED_VM || KVM_INTEL_TDX || KVM_AMD_SEV
> +       bool "Enable per-VM PRIVATE vs. SHARED attributes (for CoCo VMs)"
> +       help
> +         Enable support for tracking PRIVATE vs. SHARED memory using per-VM
> +         memory attributes.
>
>  config KVM_SW_PROTECTED_VM
>         bool "Enable support for KVM software-protected VMs"
>         depends on EXPERT
>         depends on KVM_X86 && X86_64
> -       select KVM_VM_MEMORY_ATTRIBUTES
>         help
>           Enable support for KVM software-protected VMs.  Currently, software-
>           protected VMs are purely a development and testing vehicle for
> @@ -138,7 +141,6 @@ config KVM_INTEL_TDX
>         bool "Intel Trust Domain Extensions (TDX) support"
>         default y
>         depends on INTEL_TDX_HOST
> -       select KVM_VM_MEMORY_ATTRIBUTES
>         select HAVE_KVM_ARCH_GMEM_POPULATE
>         help
>           Provides support for launching Intel Trust Domain Extensions (TDX)
> @@ -162,7 +164,6 @@ config KVM_AMD_SEV
>         depends on KVM_AMD && X86_64
>         depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
>         select ARCH_HAS_CC_PLATFORM
> -       select KVM_VM_MEMORY_ATTRIBUTES
>         select HAVE_KVM_ARCH_GMEM_PREPARE
>         select HAVE_KVM_ARCH_GMEM_INVALIDATE
>         select HAVE_KVM_ARCH_GMEM_POPULATE
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
