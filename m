Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C523A05C2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350901; cv=pass; b=KnfFIpXiwdMH03gamKSpJV+h2ERkMNRQa7is8HCAvYmZ4uaXrRKlR3HzyCOiWM2FfY8aLcoKqkQD7jaGpTxl7w+GRoT3KkSDdOnEOrAb8e3MNeVtxzjm9IqYEaSYDLLAIoV+1DI3KqbDB+HdK5ngAuHViTLicfbi5NiE7GJBjcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350901; c=relaxed/simple;
	bh=1GakT4SLC90WzEHUaDnF34eVqI2fpwRSLI5kegyTcEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRoSIkf2wswNibTe9VqsSJ7VzfzJNFvxrcUdy4UmcmN8DTcwCpU5yIMbiEeFz31cNkNBbYrM+5+c4dC32BwpNZIXPQsTkI0uZ/CCSbD1I+2Jgwr6UDWrafgElIQnVI2fRYhgamhfSyvwBdCQv+1Ze2fDKJgY1u9sRLMmQ+EqoNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vNa4ncl4; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vNa4ncl4"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50d864c23bdso13231cf.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 01:08:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779350898; cv=none;
        d=google.com; s=arc-20240605;
        b=h75I9SKkdzLHz8Nc3vTzNsym0tN4+vtPGczriaT2hfGBSYJoIKVAwZu68mf4YucAm/
         /qjBxD7ztlM7nNRjqqbek2IJCixGdnzVEDIyxEE/RFcGPdW5Xa2JAiLN0oDK6gLoS4oI
         yZ9s0vxwJlHqsCLtTvhuN9sqap2ZpsrQSxDF7ozr39NuSn6L68ayZ1b4xtlXqF/BIQ5h
         gGedweX74umvOQ/PND0h1NsrP/zmzHd4o7TEOR8wQNdIu42HYQ5bRswkuVq408PVWBxd
         BF+evWHfT5AfHzXyRQFYrPBL6bc1KIMpgOFiVLSb6tf1LEx5AHKLqTRXM+4ID+bUOxpv
         HMlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7RmlTBsfZu7jfSANKVaOagnr+/jgA52gkBUY+7wdM10=;
        fh=ErpCMGLZsvxdNUTz1s2fOhNhwH+g7lIgs3nclEfNGJ8=;
        b=T78uNA+OLB0c/3v2jyCIcGOTatcgtDX27gkSd0yI4Z2KG7L+wP2iQnC/C2YN/JhCZ/
         UYAN2/WpwoCSdXwn8Wlnkj/5pUfY4K26twqqh5KF1y439ZHtpNKcqPou4pwnIoEnUfWS
         pJ9c9G9p3V0KWy90pTwLbih9kEIsJAuy/5pYjs/rV1jyGht4l6/m3ReABxCOmUSvCTy7
         2DFBlbocLkKB2JtT/H5ny1craMKP6P2wl/UKdWKgvGMQ4arqvMfY53pt+4abiCp9hf4s
         tuDVk9KXYOFtG6ojpVQz14VDhCu+7eyhqASJNR4IkquOsT/10hQmqcmDufq5Iy7/SABu
         uQ+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779350898; x=1779955698; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7RmlTBsfZu7jfSANKVaOagnr+/jgA52gkBUY+7wdM10=;
        b=vNa4ncl4w88J0jNq6h9uTpV/yc3viKafNMSoFRv6ne3V9rhUNFugVCeiSMRdIx/87D
         TVFSXh25D2vRuEtzLjkCsEviLgn1jWIyr112ltrat3Ol0r9CgYXKsOz6sjZ8E+LlQxI8
         0sbsHWLfeiKOjg5/NxkMrywhvNdMzSesGb2xdpJAc8EM4JpMQlZYtFrCu/sDiIO5i1Tb
         sumwZJ+82jOgNXR0ZZBjdMBODKRWkxYb1xTde73+1INALPFNgnvtbTISnB566JM4Ef+x
         RyR6IGvNcp8HCvqOy7t8rll5A3cZmb/D44ZjFB0Deqh5Pl6HH/xnGZVfChInXyOa6gWY
         herg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779350898; x=1779955698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RmlTBsfZu7jfSANKVaOagnr+/jgA52gkBUY+7wdM10=;
        b=R/eQLeT9t+DEoCZhB7JCd4XhtX+WunDFUIQpPYJBLZPONiNWYpOYz6t2AqAvpRzN16
         3QRYkNcmYt00LkANINxR/mb7ESycWvnHoo3zUwqOOkK/uMOBP6d/sAV0WpEu6y75Hoj1
         Bx/x2JXpiDZiJg/lAZ8wrOdhYKjmFfVX0zCYE4lBJWjHqnhLL3cK5TbCsigaWYf3gmUX
         5bAXhLXxBoj6sfBGek7HHKbPPpqafVyHcB5ninpOcTTpUsOITL75o3t45JQUaiLFxU7e
         mmdo670Oo3KU2WboUqpxI1zJeyi5SyZ++CeuyA5Gh2xR/eKduZuRk32AvTidC0AB4q3K
         Mh9w==
X-Forwarded-Encrypted: i=1; AFNElJ+FfTFVVOD/jxwTW93tsReKpoaJ35bS3O9h46FO7FATIY3TYic3PKsrKmMA7IITXsh8VLKWrkalA2Oh4XLvFM7dO7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY3AhSzoQaNI0nhLR9JAbUMAdgz5FBcQfw0IctDor8kbjEIkoT
	fWj6mM7TNAh7Ajot30IhczCyNnoeIuKBr5R82wpYUw77dTeazDvoN1cW2j3HCVVusw08pB0FO5Q
	egpgwFGwCEn9bOVlmQ3fKjwvNfFu5YzzmeIYT/Mgm
X-Gm-Gg: Acq92OFv63zRbGymq5Cunstsh9EUiRGfqDF2/cgfPm82IzLZM2zSXC+PqDyNUTAO1Sf
	2EhTvu0YHRMPcxOMkNRvFOuW9WJXKga2PXlyp7moAN7fpEyh1OPCX7WLBxFhnbHq9MvS0hgKsOI
	xUHl9AtqeTuPxuGU2uab2sBTf6hcue88f4/pwYkF7qZ/kfAzufIitP8XLgUcDvjgsktbPVWYVPQ
	3mI8E9WPwhcwDfHNuanppF5fiTZwF4ZyDTYygYTgj6fAY2c/DWiqFvG7bAsu98uUNE6AoXIg8bN
	QIoupo8Xl9Gt14HHatg=
X-Received: by 2002:a05:622a:588c:b0:50f:ce97:3b84 with SMTP id
 d75a77b69052e-516c534d1f0mr6941501cf.6.1779350897637; Thu, 21 May 2026
 01:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-18-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-18-91ab5a8b19a4@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 21 May 2026 09:07:00 +0100
X-Gm-Features: AVHnY4K_Cpc3lp6TF05Y1I39E-kRC-mXXncMC4rrkZH8FAVJjZ2CPai0rhLiTAg
Message-ID: <CA+EHjTyiAgmBQgmrAHAHx3G1yKsP7tSgd9r-y4oPKQM4Nn_Kjg@mail.gmail.com>
Subject: Re: [PATCH v6 18/43] KVM: Move KVM_VM_MEMORY_ATTRIBUTES config
 definition to x86
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
> Bury KVM_VM_MEMORY_ATTRIBUTES in x86 to discourage other architectures
> from adding support for per-VM memory attributes, because tracking private
> vs. shared memory on a per-VM basis is now deprecated in favor of tracking
> on a per-guest_memfd basis, and no other memory attributes are on the
> horizon.
>
> This will also allow modifying KVM_VM_MEMORY_ATTRIBUTES to be
> user-selectable (in x86) without creating weirdness in KVM's Kconfigs.
> Now that guest_memfd support memory attributes, it's entirely possible to
> run x86 CoCo VMs without support for KVM_VM_MEMORY_ATTRIBUTES.
>
> Leave the code itself in common KVM so that it's trivial to undo this
> change if new per-VM attributes do come along.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad
> ---
>  arch/x86/kvm/Kconfig | 4 ++++
>  virt/kvm/Kconfig     | 4 ----
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 26f6afd51bbdc..b6d65ee664d0f 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -80,6 +80,10 @@ config KVM_WERROR
>
>           If in doubt, say "N".
>
> +config KVM_VM_MEMORY_ATTRIBUTES
> +       select KVM_MEMORY_ATTRIBUTES
> +       bool
> +
>  config KVM_SW_PROTECTED_VM
>         bool "Enable support for KVM software-protected VMs"
>         depends on EXPERT
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index e371e079e2c50..663de6421eda2 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -103,10 +103,6 @@ config KVM_MMU_LOCKLESS_AGING
>  config KVM_MEMORY_ATTRIBUTES
>         bool
>
> -config KVM_VM_MEMORY_ATTRIBUTES
> -       select KVM_MEMORY_ATTRIBUTES
> -       bool
> -
>  config KVM_GUEST_MEMFD
>         select XARRAY_MULTI
>         select KVM_MEMORY_ATTRIBUTES
>
> --
> 2.54.0.563.g4f69b47b94-goog
>
>
