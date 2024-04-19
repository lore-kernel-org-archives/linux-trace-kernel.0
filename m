Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719BE12DD8F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Apr 2024 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535090; cv=none; b=jsfhWYcw4Ap3fNRR+ufCvvHqAmx77Vx+JmA3MwKRmTKJZXAJW9LmQG15P+tckxS8PuLf0dSVCrBS04hSJw8okBGFhGx+vWOYA4dQcEiKabG0DxVA8Nbw+F7zXEgMwYc6rTmtuUKKxjhneUE0LmW/W2hGUyyEoWL2CDbyjqKArj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535090; c=relaxed/simple;
	bh=gKtJtEltb2GnPLMyuxs+G7n5EiHdmrtpBSJFJerWnT0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kAlK3knYqUKpRf+kIwuGZdvsWt/1zhRU07KTHqCxlwX2xfrnamjLS7cs3Vu7xJS2MFFIOnOJ9ILW/IxDgIMLsKFs6thW1v0265Yt4PRhadhtnFyCQl+FP2H/pBP16agPXLXtnGA2f6IRRHUFLgw2j1yYafK/pGEU9xVny3Vupj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mRlK2Ozk; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mRlK2Ozk"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de468af2b73so3536034276.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Apr 2024 06:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713535088; x=1714139888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KgrnEQ6mmP0jFk5Zb1SZY9boKJybsIIVble8n571sqI=;
        b=mRlK2OzkuCq05+LZ6E5NEHj0g7bbqBqXyiw5zvOi0650htfNDK/xcglrJEONnshNq3
         RAXI+oelN0PRLcdYSG+4zJWj5Qj5CBp+/AvPbL75WEDb28f1b/vBFJESveRYjsBtonuV
         6Drn/gFl76UCFwd+THW35DDFtxg1LLTDK/EVb8+cNedWfQ1aT7E0h0ehChwzJ1qGeyLd
         aoL+6WmsQoGrsbAxulbqCHsC4T8xOmamYs02X28bpDHbyssO1+2CK/YcMMqi+VgS4S3h
         WoqIHzO4si2L4Bt0bXtdA6Y+u6dKFOPx0RoNMfULHtspL7n2dg+IMQeWze1L3oa4iL3m
         G2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713535088; x=1714139888;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KgrnEQ6mmP0jFk5Zb1SZY9boKJybsIIVble8n571sqI=;
        b=SV3KJYZ7MYST7j084BVte14Nl+ZdbHiE9uuFWAraUm+ZSK+0blCodn8/AL85WFED9O
         kkmcH2qPuh8csWRVKW2BHn0sHL8mWO+AwWz4FvInkAeCJSZg4HHrSs2mhE7ScUirf6vb
         0PJPlEEEz3bkZhMQx5oZeRqUwN9AL7nivvTjjYmoZXRbzmsZssbZUdfK3pL51qhBnaCP
         WNxeYTmBx+YFaFyIggmU/72QTSntqeWkbF4j2WYX4UCmR2l5Lv0eZnSMbZ0jggqF1myr
         7B+eVwrpL4sRyRf9PiD2s9tXCxtZOGdPFZMBVqVWNJJtLpAeif6N5cj5ezGFlK4tAeu2
         tlQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG8lZ1VVcRJ5qOnRjDzrf2c2vACA2ny73iD4RwIBRb12Q0f+RHV1/9PUIkdCpayfdaRTpt5ZGrEEa+Hg2FODJdXmzY29WQjnO7M/BFMN8gZH1p
X-Gm-Message-State: AOJu0Yznubv9QWXOKKEL3zYTSruKT8bVVedXTRIiZV5baNZuOrGbKZeI
	iaTPilCQ8nbLicdHH2dqHgXu5E9ZltvQo5Ak0KyNsnAyepLYOoPajonqJ3zIW+rAQCCHdf5T/r+
	WSA==
X-Google-Smtp-Source: AGHT+IGomtDJcb51lvQMFTT5YaGoxW/vZTzkUSuhiTLoa8vZxcxiKEVXH4dmB1G1pZ9i7NSp+ryn6A1areA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ad8d:0:b0:dc6:e5d3:5f03 with SMTP id
 z13-20020a25ad8d000000b00dc6e5d35f03mr543024ybi.4.1713535088599; Fri, 19 Apr
 2024 06:58:08 -0700 (PDT)
Date: Fri, 19 Apr 2024 06:58:06 -0700
In-Reply-To: <20240419112432.GB2972@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405115815.3226315-1-pbonzini@redhat.com> <20240405115815.3226315-2-pbonzini@redhat.com>
 <20240412104408.GA27645@willie-the-truck> <86jzl2sovz.wl-maz@kernel.org>
 <ZhlLHtfeSHk9gRRO@google.com> <86h6g5si0m.wl-maz@kernel.org>
 <Zh1d94Pl6gneVoDd@google.com> <20240418141932.GA1855@willie-the-truck>
 <ZiF6NgGYLSsPNEOg@google.com> <20240419112432.GB2972@willie-the-truck>
Message-ID: <ZiJ4bqrBUPM0E8iq@google.com>
Subject: Re: [PATCH 1/4] KVM: delete .change_pte MMU notifier callback
From: Sean Christopherson <seanjc@google.com>
To: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nicholas Piggin <npiggin@gmail.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 19, 2024, Will Deacon wrote:
> > @@ -663,10 +669,22 @@ static __always_inline kvm_mn_ret_t __kvm_handle_hva_range(struct kvm *kvm,
> >  					break;
> >  			}
> >  			r.ret |= range->handler(kvm, &gfn_range);
> > +
> > +		       /*
> > +			* Use a precise gfn-based TLB flush when possible, as
> > +			* most mmu_notifier events affect a small-ish range.
> > +			* Fall back to a full TLB flush if the gfn-based flush
> > +			* fails, and don't bother trying the gfn-based flush
> > +			* if a full flush is already pending.
> > +			*/
> > +		       if (range->flush_on_ret && !need_flush && r.ret &&
> > +			   kvm_arch_flush_remote_tlbs_range(kvm, gfn_range.start,
> > +							    gfn_range.end - gfn_range.start + 1))
> 
> What's that '+ 1' needed for here?

 (a) To see if you're paying attention.
 (b) Because more is always better.
 (c) Because math is hard.
 (d) Because I haven't tested this.
 (e) Both (c) and (d).
