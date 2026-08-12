Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF93450911
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786541717; cv=pass; b=EEEW44BqSmAQlQW1Uh2RF8cIRc7AcQk99WdV1XzkqU2zeyo2FU4coR96TOTAlyLvbgLK6GpXa3SdlvcIXwARMiOilInh62zX8aFlVRCdn1BysjTKFwrHpUSNeHv39jheXzhZ9ghgbBsMlHlqlJEP8NENaEaPSIY6QtTuh4mPKsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786541717; c=relaxed/simple;
	bh=Qd0DA5nheV/pXBjB/+20R2YQSj6wjwSeW68i3S2Fko4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9tkUQY2UQ252fTIJSy34S8nFUfGA0o8Dl7UaN19BRPqH0aXL/rtWlS4pItEaJJSDJcIq1gVfxrO8qw2UvSZfv9uPOe5V85bLWE23MUDBHF1WEXT39a7aPSKaM9WtgtAfvxVNcoCCmYx6wAB2abQIySDs3hxShrVTLb/F25dUMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d6cdPoRv; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d6cdPoRv"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c15a5b265so227991cf.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 06:35:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786541710; cv=none;
        d=google.com; s=arc-20260327;
        b=KFbhEzKKaiPtosv7SE4iVGuSjCui8R4JtORn776NaMl76uyLY64AoPmgqn5ijRCjsm
         TaFVuOtuDjs843il8cc3AlJytOV9NU1iGZN/HMoqAlhp5idMOoMEOQ2MmKvxXeDOGgV3
         UuXxJFml4xa6wWVUqqn6Q5GKFIjFgJz4/zVLDc6AHsS0KfDEGb551GZiFCu62dDTCTtv
         o31XSAjuuYpAzVgtRenOxdrHbEBmurtPRyZR3zVG0jNiOhdc2oo+xPftrmojEGs7Vg9h
         LjZmzfgnSZD/0HNhmJFuBrWvpoxLG0MTbX9b73ZC0hpbMoSyybwTUM6QdFo00UwrMWYL
         dBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=btatRIN/qVx6m6u+kKi9+q5rHWXBFe/go9/mpyrKKkA=;
        fh=id9LblxTxyjiA+tLzM2ZtANvbKS7NIvLvCQSY88LrHg=;
        b=jHaTlBgzMapxigcXCJ5ArUjL3q7sk7lRivqb3J8XjNsmhzSyIjRqClGOfG0XbTAAP2
         PM8AkkY0PWGi+toCAzWq4W4d55p7pcPpQdrhFncZuC+8GljAkz0lKpoKbMVWlG4v1RWn
         D+bWBJ2U4WaBGwoOlZ4F/5IU9jKJCjhJTIkZ/XXD2oymYSLGTyt3fgTqc9krXQaPEMG8
         v9oghIh/dmoRAsZhZfgPFpcbCE3nCwSfzRrcreh7cLMV2TNr+Rl4U5CvYJ8Iji/kFMfe
         2AzVzjtx/Ybzim9/yThnelB24hc0swQWt9mUJCsIINtclNxAeXQSqIe86WcpbCmLjPuu
         tsYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786541710; x=1787146510; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=btatRIN/qVx6m6u+kKi9+q5rHWXBFe/go9/mpyrKKkA=;
        b=d6cdPoRvZLtbyQOxdILVtHHSWKF/GQGf/zERGvY3/BzBHVWvov+zxPMSX2kyHlICNu
         +0hb1Nac+n4kZVPFWD5giqXCajCunsRCxt3aVabQ6aKBx2CRzoOoXdnr7AwOmeGgKpuD
         udDmOnfv1Ksi+hQQpagcD7i0GvF7ESEKICfUMOVU3Xwq8UrMX99Dbx/92eUDY8+8IO0z
         YYBIegDZhK3t5vFWVOnteSqfDRmGzRB88bIhUECPjxnmW+NH8yGh8yKO9DClXqgcwY5G
         URk9cnGcr+4GjGWJAodya56YhUG2tlfuyU5JR8ZNi4312tTS5EMPTLJwCNjHhwxF4plp
         k/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786541710; x=1787146510;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=btatRIN/qVx6m6u+kKi9+q5rHWXBFe/go9/mpyrKKkA=;
        b=jQQ5It0KBRnPYIM8YRt6FcwXdVqt+IWC4T8tWfPxDR0D27Fh/mvKFFUI7Sdg/acVHo
         Icp0BXnTiq9luHJ8hzNUa9iT1RwXt472dClOV13qLfifVG0stY3yjssXmjHk2HfA9oOi
         tcyjf3HTOjW6A0x1VHyQOiCYvRRo+XI6OG+T3AxcA5lTer3/9UO9RViU22hQ6SR9Hgef
         XdddXkRSToCzVhhXJbf7fBYtn5YqDESGALT8N8ASS19SAv/L0nBvxHHJozsyTX0ajrM7
         CXxZFegsOmvH8gl2EuJv0wPf8J5T3906lwfQyHH3MqXFXrWdg0Tvu1MV8DkBWXT2K+WE
         yvrw==
X-Forwarded-Encrypted: i=1; AHgh+RqH4T/PNl0piSij4QBqEJiAniNpXoGnfZUmuyEjQae3TfN0+p+rZ2CwqxTyMhbCaYFVezWn9eAGPWUX2gQQKJ3PgNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzljxMagcrarDg3+ORwrW/x0SG81MWnl4pcB5ILLMVjxqcP0GSG
	Gp7L2g4anOOd/Mp6c/7wpcr1moUlEPtBhYKOhfSx0JyeRIdlhsr8wwP+/pM2pSR3AvfzrzNvmOi
	B9L2DFCnrLri2tmXquQWfO38TSBgeFpNhCnYyMcXe
X-Gm-Gg: AR+sD13Gyxfx5JCZW3VZYNE2MQJRU+h0QIVaJUieQN6RUdyTR+52y4xYVpitLDwDT+D
	n1BRKK1tkv6dtiD9aL+6QymFgA/jTYzflXyWeXJ7PmQNvoDobmUpHUc9m1NjIAAg141aAgU/x3x
	wWCnQ4B+3KAZ8U67bXJ8GaJ+dixzcoFo2PPEh7COs4WSbTmWGQklAhkQ73I6FjYHBPvM4V1WGFY
	BE56tbkBDPibJsrcb1U0mAwGOopLY0cbdOAAM/55A89awgwCBUfO6an5F0/Z+2h3K1USLeerToJ
	5RCbk1uvgn/3b+wXeDjxO+sLwaMx01yrzmyOQaX7x/jtqw==
X-Received: by 2002:a05:622a:e198:10b0:50f:af60:3496 with SMTP id
 d75a77b69052e-52d65464646mr13714571cf.1.1786541709957; Wed, 12 Aug 2026
 06:35:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com> <20260807-gmem-inplace-conversion-v10-1-2fc18ee6d3ba@google.com>
In-Reply-To: <20260807-gmem-inplace-conversion-v10-1-2fc18ee6d3ba@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 12 Aug 2026 15:34:32 +0200
X-Gm-Features: AUfX_mzDGNX5m7h-J9AcKRPzqX1cpxh6BaIQgAnDEV-ghyjmfpFsGGynIKZZ1iE
Message-ID: <CA+EHjTzkOQD0YddPUs=2=yThG6s3=jQR2xwm+CeAedjyFaANZA@mail.gmail.com>
Subject: Re: [PATCH v10 01/41] KVM: guest_memfd: Use kvm_mem_is_private() when
 populating guest_memfd memory
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Aug 2026 at 23:52, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Sean Christopherson <seanjc@google.com>
>
> Using kvm_mem_is_private() when populating guest_memfd instead of using an
> open coded equivalent.  In addition to simplifying the populate code *now*,
> this avoids the need to provide a range-based gmem lookup API in the future
> as well.
>
> No functional change intended.
>
> Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
> ---
>  virt/kvm/guest_memfd.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index b596486d184ca..a11cf6dc785da 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -811,9 +811,7 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
>
>         folio_unlock(folio);
>
> -       if (!kvm_range_has_memory_attributes(kvm, gfn, gfn + 1,
> -                                            KVM_MEMORY_ATTRIBUTE_PRIVATE,
> -                                            KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
> +       if (!kvm_mem_is_private(kvm, gfn)) {
>                 ret = -EINVAL;
>                 goto out_put_folio;
>         }
>
> --
> 2.55.0.654.g21b8a5bc05-goog
>
>
