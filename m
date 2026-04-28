Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7911338424B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Apr 2026 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777419659; cv=pass; b=oQ/8YiSNl5efkfvnpr+F6CYD6fFubxp+SsePNg2xoWlbWOXfY3M9/MuV93r4WQxopA+2h3FeLAMg4NKLZcLNpmeERN83xJOoVd/Mqg1+TenufpVTbsb1WcMgONWRyHxzWdKRVhZCVKddPG2LbYXL9bqck9G87B8J5PNC1xDuFg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777419659; c=relaxed/simple;
	bh=U3ahQduobNenu2MyiCXv14Q8IImIIVCNH9OIRKPH1FY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gXN73pzUihUPOWfacmEQ1yFSnM/NoqBRNQMxye6dPs9l+czhPPeAn14cXDY/wBZVc+GNIUPX44eqXAcY1/Mmsb/Y+izIEUb1uCbN4EFyn4XLT+/EopjhshIK/Hpk+IUaYeElNS5SlJmvckVog0QSZbF+2CgrMZKYXT4wWCF+BBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hsmFq7DF; arc=pass smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hsmFq7DF"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-60fce51aa55so3722804137.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Apr 2026 16:40:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777419655; cv=none;
        d=google.com; s=arc-20240605;
        b=MpBncHQ2GXvYmI5prIulPQGAHu7UVeUKbpiSE+CzYORASCGyZLKECFcH93ZSVhLRu+
         /49EBktGGDmeQ+IE+xRICf5JT9mH29Qija8nmphyJ7SudH2yprw6OOwOY2VuNzJsbOwt
         MwDXYmgvABAzCJggmxwpemcJL4/KUmtbHLWOZ7cfdozA0yioAzC9+4xKhBvI7leRA+9p
         ZG3FExrSeFunR1VJUzayrzeUNO76yT2mUQkbHjeqDcjnfb1NOCajH4qN2nmlYQxmTqgs
         wtR/3HX/VWUKp1iflAME9Akrwp+vh5yFj4Bcc+OJNtfJIjiofHE8ExzN7uKRgBwHQMpC
         Xtuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=fSQsiZsSkLpyfyftl7NX7sITr7YX8npk81aNrWQuVW0=;
        fh=81GrXMlzLiBfcl8fvU1Dx+7T5pe7K3NZlcVpT5UK/kI=;
        b=Hw9RncHeb+mmgve67KKbDA2MERmkP7p0hYzfwSoxYT6DnlC8pBuraVYuxEH2SGvRBB
         KnBudW/Uf6hU/jBU31ZBFtnwQinDfM5Qr0uZSsfiNnnVuBdlMjewUP/qYWNT5P8aq8oV
         pW2c/Y55bUP9kFxiZC+qpJdRu6hMwgQodBB6yR/mmxk/CWGnvzLLRNoy1pWUZ/Ek+5I6
         cYXy224QpiAHuyp+pFso6H+MJOrmFFPSA2OwPzGMbZ6WQFtKobQtemuPCEs8BH+PF7NG
         yj3c8ElGUfQML1AUfMb0EnynGod58NRGvB9ICLKD+p+I9g2SrSf9S6dBN+vJuuNsNjOF
         OifQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777419655; x=1778024455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fSQsiZsSkLpyfyftl7NX7sITr7YX8npk81aNrWQuVW0=;
        b=hsmFq7DFMBfAwtb1IZ6VAuUFHbYwGJe7T0YGoC2CKhGIdjx03B6Mtva/uC62TfY3WS
         MmLL3e6YwiFrJZCe2ef7t+xrcR2XxghUK1J9+MA+2/7GY0Kv6SiMlyXY3elQUFAQeYwh
         +TT3HVmfTWZ8OgqvASfAFZ5JbpMU+zuyrahpa3beA3dcT/5NtNlmlhNTUvuQRi2tPGGt
         m0X9RTmx7ze8yVGzOECOZQOaP+HaBZpOrTA9MBKHH7H7dIwkWZ9xYfeHKrj2OLaQm6sH
         177ukz6mlxPHpdy9ilHl6aV/WYum4uGcKUbdHIrqTCVwaxU0rQX9FIolN1xsa3CdA7+E
         PeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777419655; x=1778024455;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSQsiZsSkLpyfyftl7NX7sITr7YX8npk81aNrWQuVW0=;
        b=Yo96PGt/xDb11+0mbWoUjOGEHL8ukXewe2dLAJMqYK8sba/qXOe1UMPUJqgkmjs5Zx
         iKl2lFXPb1fRTu+BNDdogxkonevHTulcwcHZXKBNFfkpjzhE/R+hpNShUY/0+a4PjWDE
         T/TmwLD2BU1bJcEu/pT7Fec7NX8dRmKiYjNDINUMe6Zvud1qgXL3QWPd1Y5WvJDZEcTk
         vy0flXFd/GvH33gRv+Mb/Ld6H5teUGmfjoe1cVOyAg1PsZ5OefLjwifxdFzpG4P3pf05
         bIjzEuQYoPMDIlq1zk7UMSFbLrLR9IhPHLGQ4KSkyQTTEAw/sskPpV3d4+clTDeZL9JR
         ulLw==
X-Forwarded-Encrypted: i=1; AFNElJ/ToH67M01wMGhs6C0pwSK4/wd2bhOVyuvpn1a+aswXSHPx7T9syhlIs0Gkcq8Q1Ux9+bDdc58EzUs++wPAvhrHcpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOf1VbYw7p8DPsVlI+jUN/0Wru1scZBvPGGubrOm/ZhwvEdEYz
	bQy1QCiU/eTciLRcewXBK5FoqtSlq32Mteuo6NtpNOfpu4k39QXPAURqGhubQHvra1I48WBq2P0
	HBTyc3NBm/GexmP0RBLoypDmEjxcgBmrQY5zpMlc7
X-Gm-Gg: AeBDieuCubcJoQYzi51Z61pzRyZTd4h2Tzu8DX+4T97Q20sBwR8E6RGiFAhsLL96jji
	947sKo58JGomA0jnl54dARtfpouju2dHjyPKF8hl7W0i67VjrwzmyiiNYjtChaCtni0iPILVxmo
	7nb3WJhTk1H3h76zgaHxclVAlHq+yhf1EKoJmxQmA5ymQRFP+rb2PV7SH0FDoT40ngvzPYhbmk+
	MmUUAeJH+2dWhuD7xPXnWzdUUk5Xd5DCkl+/z1NOxNu3/o19PPinVjz2kDEOzTtHUXkoos+uzf1
	Brve9goINWZBGI2mDzYARvqHTh1aXEZNf/x9DizbpCFTShT5k9rVmvUgBBdUWCNoWvbdVEDf/+G
	KWUOvB3hYo1uZNs4=
X-Received: by 2002:a05:6102:809e:b0:606:49d:183f with SMTP id
 ada2fe7eead31-6280b1df187mr2828068137.26.1777419655062; Tue, 28 Apr 2026
 16:40:55 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Apr 2026 16:40:53 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Apr 2026 16:40:53 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260428-gmem-inplace-conversion-v5-24-d8608ccfca22@google.com>
References: <20260428-gmem-inplace-conversion-v5-0-d8608ccfca22@google.com> <20260428-gmem-inplace-conversion-v5-24-d8608ccfca22@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 28 Apr 2026 16:40:53 -0700
X-Gm-Features: AVHnY4K8zc89tOubY_FIZvJs5RqMpzsyiDSJNy3Ts6m6f6GRhz2hBKqCaZ_7fHQ
Message-ID: <CAEvNRgGv3RZipinpQLCGUfBCAfS0PRc1mCx2yc3JgjfEu=QhdQ@mail.gmail.com>
Subject: Re: [PATCH RFC v5 24/53] KVM: SEV: Make 'uaddr' parameter optional
 for KVM_SEV_SNP_LAUNCH_UPDATE
To: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, david@kernel.org, ira.weiny@intel.com, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
writes:

> From: Michael Roth <michael.roth@amd.com>
>

Thanks Michael!

>
> [...snip...]
>
>
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index c2126b3c30724..bf10d24907a00 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2343,7 +2343,15 @@ static int sev_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
>  	int level;
>  	int ret;
>
> -	if (WARN_ON_ONCE(sev_populate_args->type != KVM_SEV_SNP_PAGE_TYPE_ZERO && !src_page))
> +	/*
> +	 * For vm_memory_attributes=1, in-place conversion/population is not
> +	 * supported, so the initial contents necessarily need to come from a
> +	 * separate src address. For vm_memory_attributes=0, this isn't
> +	 * necessarily the case, since the pages may have been populated
> +	 * directly from userspace before calling KVM_SEV_SNP_LAUNCH_UPDATE.
> +	 */

I dropped the #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES from [1] since
vm_memory_attributes is #define-d as false when if
CONFIG_KVM_VM_MEMORY_ATTRIBUTES is not defined.

> +	if (vm_memory_attributes &&
> +	    sev_populate_args->type != KVM_SEV_SNP_PAGE_TYPE_ZERO && !src_page)
>  		return -EINVAL;
>
>  	ret = snp_lookup_rmpentry((u64)pfn, &assigned, &level);

[1] https://github.com/AMDESE/linux/commit/7e7c29afdf3763822ced0b7007fc0f93b8fb993d

>
> [...snip...]
>
