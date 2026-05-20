Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354CF39BFE6
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 13:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284074; cv=pass; b=Zk9QnJVL4FJJM7an0vr973y68A+yvTK8NxLwOORp2Jl4OKuIbWkUMT1kHuJeoklf181F1dMtwiwcmEKQBdYl7Ce6KYkFR996fZ2J8TK0hRZP+wSC++C1MNl24pVAemvDcBCLt8IACzPQt+wuPW16EGJsMnkLdhxtmgDNAuuRwKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284074; c=relaxed/simple;
	bh=qQiJNamxvq/HKg+2DcbBfJZDz4xq8G4yBXbE6YWO298=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAhsN/D84zWK47yDslu7DEnqyEmujMEEIRRLc6/BGYY3E2LkkDrmph+HapMkdzhqoGeAtvTwI5byCx5X21lQMPPPmgYpvvv9uPDKvd8zQ71w5yqnBKqUJMCDXiyIPS90aqpMuJ2CmA5ZShp90t0Ha6BAw1lkzJIBKzuRgWji4/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZBRT6gnh; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZBRT6gnh"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50e61648f10so10401cf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 06:34:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779284072; cv=none;
        d=google.com; s=arc-20240605;
        b=Ajp4KvvmXYG2+fujDOSlmgvIuGQUu1onOh2UzJxZGPH3DjwsOpL6cramBId6Ac7ZX5
         fu9eDuPhBOw0+kpe/YTryx6QjI/F152yuNlSyTNUG/Hc70k0WzB+rN6RfETE06pAtcke
         JmtUd+nHuIEcyhDz1OhC5Ly1yIrvhEOIU3bqSLGJuLJnzGIy2nrAhn6GGCsDiyrkN4rT
         2r+srLRH7WIrCvDYNqMrvDLOy3WnLswv4bdHqbXo65Js3W0LMIUMVPmpG59NLADuO1HS
         VKgMk/nDHZ+NJstdlrXkbZt1RIS7U3sA0XveusLpKfcYDq4QRBmxTQNMD7zhQnOMMrc+
         efPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gg6EIejukVN1UskEcFFGr4CnqhwTYz/FF3EfBDzQQN0=;
        fh=K6NGchVszjSW6QXHvOWIt7YA5niCZJAMedS1Q6IUyxU=;
        b=LpKhZFIBSXpKVONwGwArzZm/e/5bEe6lvuT85UjB1oNnoRQOiS/U4+9DEvZdW0POUU
         X4ZNATWPP3/WBJGVOPQmf1fOKUBhe9IYISrqpPBZMGNyurMoC9nGv5gcEcfFVj4+sRRx
         KUMijFnBiGDjqwmh4k8O7rpghKLDzSTTJ2j9L0sumv5Ncvi/j1QstsTlpJrUk36GpGwP
         fp+3E76adIp8HuDai0FTb4P25x6IgHNWEShCIRxYiI8iRWOZ6Spea4XCmfL6jSyydqzQ
         YSw5YEp2GBAo6pG6yo5rkMwU7h2DjN6gvXxt24A32E0IdIU6sxonBgEUaTOegQxgAU6Y
         TSuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779284072; x=1779888872; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gg6EIejukVN1UskEcFFGr4CnqhwTYz/FF3EfBDzQQN0=;
        b=ZBRT6gnhCXkmGh5E5RtdmLG01m9cbItQ+fVl69SplNV7tKGs61gKG5ulpXLXI3m0CV
         VqWRol0J7UEu6kw0wTYeDnN+bhK5PkKcjH4IZBDJu2QnESW3xcrRHKQ2NmeBb+e1z20y
         40TGM7LDeKzAVQk0C2z1InDN9opgFG0aYQ5pizLD3zEjBmXu75tCjgpzS9Dy8ZtoRAnd
         mseFVCUD2+xzRKgDKks5GSd74VjJhvBSzB+FU0Ij3tsu9TVKxjNcRfZ9s+XTod4gwuja
         f443+uL+BI0rx4m5EKNYjDSE3d/gPxIpxLnXDYygGkZmTghLORiiVzj/Vuc5sYqrnefo
         LX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779284072; x=1779888872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gg6EIejukVN1UskEcFFGr4CnqhwTYz/FF3EfBDzQQN0=;
        b=m13itUsBSn6G405rWhj4Eq9POsECnly4+HF2ZEUae7rjYeJHZyORSg9DE9rpI1xwZX
         q8D0zwk6wRltp2J4a0JEtRRsSiILnDe52rb+OXMszaQomOeHeTSl7J9SYSfOy0U05vDU
         HvqjeHQccCFj0BijDZdzSkUNH/uH9U+ZQPbnK7tQy015yb3daVgf00AZ8pkB9Wi+kKNA
         z44L2eIbvqc4j3P1BuhPtCPEnZ2u/0psO4c+FeWEeLaSGwNFA8Pw2EaWvMK24o8/OlAH
         yJC5vwaav+hCLAVZO00W3kCO9b8lf1elHjqpemz25bRhlVQ/+raX42uUA7Y6JADbdDkG
         3fug==
X-Forwarded-Encrypted: i=1; AFNElJ90fpegAwARcxxGQtXgMGNgodUPfzDCNFg9SBGN4JNzb6zV5xYdNWhLztjo6zs6IuerqRfidRvozR/4HWlqqWQb+X0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEpr4hohg/FuxtayHsjxoXVxa4vOvg80XYXXSYhobcNfrO8Qxa
	WxGF1ZwIZhjKM+ApoYwrA8VmaioK5uXxRH/wbl8qgJvDWxUrvl21L8R+ua3pSerMcyWDLKrs4qM
	NI4Z3S4q7r+juLeXUEY1a353ZsYgh1Fz5QGvWS1ou
X-Gm-Gg: Acq92OHP0/dfIdKby5+922bVGy1ZYz0/txx7wzQP82Ms6AM9wlRGCcnR7nWV3H8Bo/L
	POkZhrKBfkpMkis7oIPZcnhBw8/CGJQLJRQV0fOTWjuMUqYEf3WxMWhMME8pfihmhLj6oQxbiln
	Qd8DtSf7rHD4RoXyb4G4N2yI6hzP1cib4RplH0KERBFDEVF0j4eRcLc6UsPg0ePCuuVVjFK3JgS
	jwTe4NRj9knAubLOzRHTyxnAmGI62hun9yXT6JTOrIHGwaxAR4Hnz3b6PkiZUvoq64qFBp3aN8g
	wpVA3maB0tJOkJunWFE=
X-Received: by 2002:a05:622a:1f18:b0:516:5709:45e5 with SMTP id
 d75a77b69052e-516794404famr42713051cf.14.1779284071144; Wed, 20 May 2026
 06:34:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-6-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-6-91ab5a8b19a4@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 20 May 2026 14:33:54 +0100
X-Gm-Features: AVHnY4LNSFj0RfEZst7XJ-H9igWv5oxnJFnr1A0Uux_hrTg7SmxNRLrzDdjcxpU
Message-ID: <CA+EHjTxvLU4XDPXDXYXXWJES1OFQgN8VTRLMgCCNMwBE6Hk8tQ@mail.gmail.com>
Subject: Re: [PATCH v6 06/43] KVM: x86/mmu: Bug the VM if gmem attributes are
 queried to determine max mapping level
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
> From: Ackerley Tng <ackerleytng@google.com>
>
> When the maximum mapping level is queried, KVM's MMU lock is held, and
> while the MMU lock is held, guest_memfd cannot take the
> filemap_invalidate_lock() to look up the current shared/private state of
> the gfn, for these reasons:
>
> + The MMU lock is a spinlock or rwlock and cannot be held while taking a
>   lock that can sleep.
> + In guest_memfd's code paths (such as truncate), the
>   filemap_invalidate_lock() is held while taking the MMU lock, and taking
>   the locks in reverse order would introduce a AB-BA deadlock.
>
> Currently, the maximum mapping level is only queried from guest_memfd in
> the process of recovering huge pages, if dirty logging is disabled on a
> memslot. Dirty logging is not currently supported for guest_memfd, and
> guest_memfd memslots also cannot be updated.
>
> For now, bug the VM if guest_memfd needs to be queried to determine the
> maximum mapping level. This guard can be removed if/when support is added.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index a80a876ab4ad6..153bcc5369985 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3357,6 +3357,15 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm, struct kvm_page_fault *fault,
>                 max_level = fault->max_level;
>                 is_private = fault->is_private;
>         } else {
> +               /*
> +                * Memory attributes cannot be obtained from guest_memfd while
> +                * the MMU lock is held.
> +                */
> +               if (KVM_BUG_ON(static_call_query(__kvm_get_memory_attributes) ==
> +                              kvm_gmem_get_memory_attributes, kvm)) {
> +                       return 0;
> +               }
> +

This directly takes the address of kvm_gmem_get_memory_attributes,
which is only compiled if CONFIG_KVM_GUEST_MEMFD=y. This breaks
ARCH=i386.

Cheers,
/fuad

>                 max_level = PG_LEVEL_NUM;
>                 is_private = kvm_mem_is_private(kvm, gfn);
>         }
>
> --
> 2.54.0.563.g4f69b47b94-goog
>
>
