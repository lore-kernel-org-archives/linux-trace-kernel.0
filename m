Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F727BAFE
	for <linux-trace-kernel@vger.kernel.org>; Mon,  8 Apr 2024 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584589; cv=none; b=cdxYiN6D7URg2MHxcjggPg0QN8dd9E3GhSUmdNCN2ZWcI5KbHEsoZaPPBgPhsz1LJ+kEcocWPJbwDY0Zk2TxrGcLp69S8pRxDe1ZletqKe1NhV5HLKQff5RkzOT30VdCZHdugUO17NINaLtycMcoDMo9cw82+/8+VQxOL1zsF3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584589; c=relaxed/simple;
	bh=Sv1lonJMRVR+UVuirFpH2YmZNDikOQMGGjjjY3UJLc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=s4HmnpxVIrDODSQFtrMGvV7STpTAzTQkzNqA8Yw1aNReC6oXVZSpDMESbxA1FTmho8gyH8pu+0LzRBlV5wZUjGUI3oJ3YCr0HQbRK8fy7EwDcLpVF3wnFN5JB37Lz7h1kD817yxoTQDkVuiBzo2Vd3Iqd+5S//etu2mST/OjC2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NHI6vsau; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHI6vsau"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712584587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rmNJpHW5Hyb1elegWpLMoq/S1yVvTDK8DJLj5yKd5mI=;
	b=NHI6vsaufjkxY3p91hcNMoc6KF6VIBovGIlmprHI61ILY3k+3h0jgU4tQD6b83VuqrmG9R
	WtEsJZRSM0B5DlvHE5Cpr2YHfgZxzGOVsKPYwHou2hsFwrn4EIELYXh50AcnGJY3cXN67z
	ossLzxq4nXqf8TiyvTczi5C7G6FmNbg=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-DGzdA1ImOUKUOEU-5PQDQQ-1; Mon, 08 Apr 2024 09:56:25 -0400
X-MC-Unique: DGzdA1ImOUKUOEU-5PQDQQ-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6ea20a966b0so46695a34.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 08 Apr 2024 06:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712584584; x=1713189384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmNJpHW5Hyb1elegWpLMoq/S1yVvTDK8DJLj5yKd5mI=;
        b=AXNwSXQRdkXrTQ2m6YomGtlUS0lRIi/bnq6fv892MmhQ0ysCiMQuWcHkG4QUX9LzXB
         jBokDKYQzP7nRn2W/nGCZ9Ze7PxYOv4yfyh4B3WDMp7t8n8BisobnDYShd0o82nANXV+
         fcB1eYtqGKzLyJu01qVF0HbpDuK9DfqFlMn4722fO3OaFCVxCva4fC6vhHrcMRoy3bH4
         4S4yMF3p0qYv0ymbGOlbwwnUyw4AC+8QsVNfL/0riXwy9ObEs/fwFalYCI802CN8uREx
         i/BsCFwHkKWSnb45RbrcpOFid417Ozgwh4+BXjLYQODOiL0ou+bVwwDnGiEyCSTZYjGN
         vldg==
X-Forwarded-Encrypted: i=1; AJvYcCV3lvsQDIdq8Qhlpe68+bf2QVLHlGrxZYzKHEHb4XXPVhSyAd5/e8kodoo1B2kuE2j1i7mvntozurEwk7L4s3gUTqkp3mE64+nEPnOeraU9COdk
X-Gm-Message-State: AOJu0Yxr4ffFN8N6DPli+FMvEkKWHQioe5nENOuOLQYchcwizjDDureW
	TOE22RentYolZ1SxjD5RktxXIWKSLHXWViGv+HxDZknfARnWtoF9pgeHUC5+Xtr0WncCTZuWdED
	X5+tBxMifP1JDF2uR74JjPe3nalr42kTSgFLEnpGs0bL/zJQ8ticAuJkKJ1gvVkp9Sf7HTQ==
X-Received: by 2002:a05:6830:a5a:b0:6e7:592:87ab with SMTP id g26-20020a0568300a5a00b006e7059287abmr9702522otu.2.1712584583703;
        Mon, 08 Apr 2024 06:56:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/6cZVOu40ZE5XkeceEvB5GWIk5ESL9MdZGK/RmwIM5NG0Lyufyd1ejET8K1FRMeVweFzXgg==
X-Received: by 2002:a05:6830:a5a:b0:6e7:592:87ab with SMTP id g26-20020a0568300a5a00b006e7059287abmr9702473otu.2.1712584583118;
        Mon, 08 Apr 2024 06:56:23 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id vw25-20020a05620a565900b0078d63baf516sm1301217qkn.129.2024.04.08.06.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 06:56:22 -0700 (PDT)
Date: Mon, 8 Apr 2024 09:56:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Nicholas Piggin <npiggin@gmail.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 1/4] KVM: delete .change_pte MMU notifier callback
Message-ID: <ZhP3hDhe2Qwo9oCL@x1n>
References: <20240405115815.3226315-1-pbonzini@redhat.com>
 <20240405115815.3226315-2-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240405115815.3226315-2-pbonzini@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Apr 05, 2024 at 07:58:12AM -0400, Paolo Bonzini wrote:
> The .change_pte() MMU notifier callback was intended as an
> optimization. The original point of it was that KSM could tell KVM to flip
> its secondary PTE to a new location without having to first zap it. At
> the time there was also an .invalidate_page() callback; both of them were
> *not* bracketed by calls to mmu_notifier_invalidate_range_{start,end}(),
> and .invalidate_page() also doubled as a fallback implementation of
> .change_pte().
> 
> Later on, however, both callbacks were changed to occur within an
> invalidate_range_start/end() block.
> 
> In the case of .change_pte(), commit 6bdb913f0a70 ("mm: wrap calls to
> set_pte_at_notify with invalidate_range_start and invalidate_range_end",
> 2012-10-09) did so to remove the fallback from .invalidate_page() to
> .change_pte() and allow sleepable .invalidate_page() hooks.
> 
> This however made KVM's usage of the .change_pte() callback completely
> moot, because KVM unmaps the sPTEs during .invalidate_range_start()
> and therefore .change_pte() has no hope of finding a sPTE to change.
> Drop the generic KVM code that dispatches to kvm_set_spte_gfn(), as
> well as all the architecture specific implementations.

Paolo,

I may miss a bunch of details here (as I still remember some change_pte
patches previously on the list..), however not sure whether we considered
enable it?  Asked because I remember Andrea used to have a custom tree
maintaining that part:

https://github.com/aagit/aa/commit/c761078df7a77d13ddfaeebe56a0f4bc128b1968

Maybe it can't be enabled for some reason that I overlooked in the current
tree, or we just decided to not to?

Thanks,

-- 
Peter Xu

