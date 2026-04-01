Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95301A9FA4
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Apr 2026 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775052322; cv=pass; b=jhrmliaCGNP23LqihtoFrOojIzeME2QhHxhz70IUS8YRH6YcHLaAMRk9D5xPcr5GGvwAIfFVIIpiKo+xlGHQJcOfTHmGo4/SHnNIPAJt8AKWoNCzrYQFdbJWMqlz53c991YTrvqZfMvrL0pP4BSBcWA2CNT/DxO8ULUxLDWilRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775052322; c=relaxed/simple;
	bh=3T7GMoC0fS9mqAo2YBiLIAD1sZxRlz6N0Q1xMegEdoc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZ2oEMrXLAbW05uD02OPBuY6H7mJAT9rDNaUsQ4yDt5ofjYD89qowuFeQdGaCMQmpuQarAEE0/JdpKYsRDzGf8VvHvvpSnrSPTMTBILoJnFLVaoaeudm0hfItmbC/3G3e4OpNE1HjfLrIt+kiGdTY6xXl6JFdpzp7gr5rKC0xMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EYLQj4Dh; arc=pass smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EYLQj4Dh"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5673804da95so2510778e0c.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Apr 2026 07:05:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775052318; cv=none;
        d=google.com; s=arc-20240605;
        b=FuLWd5Pd2tGeOJtadTbCavBvm1OXI6jjyyUP/1k+jl8FKJNXrv+KSK8X/mMFjfaW8P
         qTIK5oC4DecU7lZVd8uq1jvwWdIBIWkIc/LYsp2HF7OYKgNjOMxVXCrEdKrghWyvge6q
         cYOafucWrw/uoSEB+W2StAgtKfw2jP8b2CMO8advPnAQuRFoSXEYB4Vs3DF9LHWKjcHV
         1r8dTlJq2Yvt37vo0LEsBxxHblg2ldEAx64Z94Tio/thgp71pG9bfhevMoXmHhfX+v/j
         q0cghGopxTjM1Gxe/qHrXEt7rNuJBaMEoP932sgEJ02dsiKr0EXuy1UJnX3qbCfD9WfK
         6Ymg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=cok0tTO+M9AY7GrL3ZPCAkrKaBzewD/gpEZeNzSpUo4=;
        fh=DFmRJ+gHXAuRtEDDQxiYbepyJbNv2MspY+15Km4H1CU=;
        b=TdUboGE2bGvaU387JXFVCHv3pjeewd5tQXDlp0i9nIxI6WWBqkTS3ipQGVj9xHiyIk
         sKO7uoGGg8Xozhze48VixuV62hVkhpx25jamkMzOpN3voxktbp71dDYESEZ6faMwkTEk
         5o2+ZC7jLHrxbCUaG3uoy3m1SBakUKVMLVJd3iYdb733ZQCtNfw7wk6z5Av53vbEBB4K
         7FWXoSauk7vMFxzY/1WXEOrkn2zIQfmtZBctZG2m6a8FP/7of8jm+khIqOSnD0DdZe4K
         Xh6yHBN6l7zaljjDhr7qBtrnjcyiLl06ZM+83OB+DDDeTqFYUt9DdYwREOZnDdal3+MT
         I2oQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775052318; x=1775657118; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cok0tTO+M9AY7GrL3ZPCAkrKaBzewD/gpEZeNzSpUo4=;
        b=EYLQj4Dhny63Ff/pV2FGIcuXjBIBXXubDiwrYFSWrrKaXz6kiuUMYDaa1XNmmVHiG4
         7sOApBTxaJrj9nLFd/hCCXL8NuGA3gDNQE7QAdzzNba+qKrFZLh8L0zBAv8QOB53PHnV
         yJUS8oKR0jjomFrVwZtutMBSNKQjMtS1F+pmKYchoYexsK+eTadQzUIKmp3t7ZrzKN6W
         R9RyG3CUQ+u5TJHJjZ/P8qBciP/CLYzR9yVKj5hFZNSdN9ll8Kzwn3ob3Ayhoqn9LtoI
         RdS3DoDXeem3TKxNoTwEjoQ4OKjez1g/8weDLG2wog+O/cnXrIkXiAO+Ofi4u2GXFgCX
         iHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775052318; x=1775657118;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cok0tTO+M9AY7GrL3ZPCAkrKaBzewD/gpEZeNzSpUo4=;
        b=n5tctuowjFebg6NrxQM+sfDvzYfJFdlp4QCHlcCyvv0LMy+D8QJ8AAYLNiOw8yM1vK
         pkY8GwBfCeyIWMVMVwb5H+Z7dCBaRKuc7nsVjVrgQlhlOBQHc1bes5EU72fxJOU9tMWA
         ZqyeGgrw3TyoHKlPDwQyK0VqBCCeMOSxx3moFLEiVjITxD1r8umEIQrhI0fXXVrcAmHD
         h2DZKQK9HpBxogXF1bBrd16Zrg9OroPtlRsNa16mggQyBqLE8iCCkDibcuQ68GnSzkSn
         zEtqycrWYTfHiFAQRKmlgKnSIgBlWhea74pbW8tYbSAn1L4qVBbQAZjXMKJaRUyvj5A0
         Wc6A==
X-Forwarded-Encrypted: i=1; AJvYcCXtNrv7AvV2bdoTaQFg4ryhA77tLBPpZyHLudS2DhHLeZYI4F6MrJ3nHdlupJhx5hX8XlJLK5wPn6cFyRYYIf+Lbes=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy042b3WsZeCoqjib+h/M1Hs898DaJjxRt63jm2xEdsoLHjVniJ
	g9w7+dnBmnS0UgW2n4ZWRz6nca8LbrjfLbwP4RTBva7dw7RYHyu3GCPzzc6YS9+6ig8yT+W77Lj
	Pa6WEobB57P8A2Ti9EUTX4SRosNGo3VeL5Sg9SANb
X-Gm-Gg: ATEYQzzHwS7IUk0nvXrvHZcjmdwo/V5enEhQcG2+EzfdH70V0KVRVWc8xLEwsy0mcwP
	chmEES2jmplUOd6Qie9wpInMxC/ys4bHP68R87H7dEmlfNuP1NjDrxJMuuJNEguomnoJGYhjk53
	P7JXE0F/KWArzy2bx2GwH3m/RC3nlRyI8x8ggynYoCSzvSzwArqVTxTpZK219vZFhwb6MLKlvWg
	Bh1kkn04NNs77Z4r1XExnaMf2LnzKQX2kO8rPxR0PJQOOLjgcHRp0YkWLTkQQ9yVNI3psZfXC3P
	IEM3C3CqVvzu3JxiTxhF3BnXUTYhFyxt8VFqtA==
X-Received: by 2002:a05:6122:ca1:b0:56a:ef89:34fc with SMTP id
 71dfb90a1353d-56d8a81bd48mr1423992e0c.6.1775052317094; Wed, 01 Apr 2026
 07:05:17 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Apr 2026 07:05:16 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Apr 2026 07:05:16 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260326-gmem-inplace-conversion-v4-7-e202fe950ffd@google.com>
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com> <20260326-gmem-inplace-conversion-v4-7-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 1 Apr 2026 07:05:16 -0700
X-Gm-Features: AQROBzB8ZjEkM1kRtGYPSYrf1SL2xnDWxbzougnTteAKEFNAbNZQz2YVpzx5v1o
Message-ID: <CAEvNRgF+FjJ1EWSR_rzD1=N040ZitiRrM2O3N0Kj5yN5rT3h+Q@mail.gmail.com>
Subject: Re: [PATCH RFC v4 07/44] KVM: guest_memfd: Only prepare folios for
 private pages
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
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
	Wei Xu <weixugc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

> All-shared guest_memfd used to be only supported for non-CoCo VMs where
> preparation doesn't apply. INIT_SHARED is about to be supported for
> non-CoCo VMs in a later patch in this series.
>
> In addition, KVM_SET_MEMORY_ATTRIBUTES2 is about to be supported in
> guest_memfd in a later patch in this series.
>
> This means that the kvm fault handler may now call kvm_gmem_get_pfn() on a
> shared folio for a CoCo VM where preparation applies.
>
> Add a check to make sure that preparation is only performed for private
> folios.
>
> Preparation will be undone on freeing (see kvm_gmem_free_folio()) and on
> conversion to shared.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  virt/kvm/guest_memfd.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index b6ffa8734175d..d414ebfcb4c19 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -900,6 +900,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  		     int *max_order)
>  {
>  	pgoff_t index = kvm_gmem_get_index(slot, gfn);
> +	struct inode *inode;
>  	struct folio *folio;
>  	int r = 0;
>
> @@ -907,7 +908,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  	if (!file)
>  		return -EFAULT;
>
> -	filemap_invalidate_lock_shared(file_inode(file)->i_mapping);
> +	inode = file_inode(file);
> +	filemap_invalidate_lock_shared(inode->i_mapping);
>
>  	folio = __kvm_gmem_get_pfn(file, slot, index, pfn, max_order);
>  	if (IS_ERR(folio)) {
> @@ -920,7 +922,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  		folio_mark_uptodate(folio);
>  	}
>
> -	r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
> +	if (kvm_gmem_is_private_mem(inode, index))
> +		r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);

Michael, I might have misunderstood you at the last guest_memfd call:
sev_gmem_prepare() doesn't prepare a page for being a shared page,
right? Does this work? That prepare is only called to "make private"?

>
>  	folio_unlock(folio);
>
> @@ -930,7 +933,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  		folio_put(folio);
>
>  out:
> -	filemap_invalidate_unlock_shared(file_inode(file)->i_mapping);
> +	filemap_invalidate_unlock_shared(inode->i_mapping);
>  	return r;
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
>
> --
> 2.53.0.1018.g2bb0e51243-goog
