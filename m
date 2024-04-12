Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0F2146D71
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712933666; cv=none; b=ZPOtBwBt9AmSv/TGPkt94mCX9/GOnXlyN9LtYhA9IVzGuUFHYWYa8Ie5iBBY+JSUim4UeZak2DM+E1HFuwnuc0JEKn6CV4XBnyh2AOEU8h8rWsc1Y0p9gfKHJJG69WDsqJmieiCII8IKbPf1jMNJoWfdodTQyZZVkLpisvY6PFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712933666; c=relaxed/simple;
	bh=ZtUMxIcPii7SYptK1bsvjnMTv2XY+8o/C+H99TV4mko=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HIXOA/KRT2CZIZmBrbTz/+pjgNy6r3I0elDpFHaq9urgmbQT+n9lyckIhuIYmTEhESe/viuczcQAUMz+PDLfCn+KhzD77rOooVQmbPk/XjyOgl6ePE8qajIytEORDaG8wAli6h6y04X+5N6HciwlnEZqpgi3dTf/zG1+p01xlR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jZMOLO9M; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jZMOLO9M"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6edddd0375fso809942b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712933664; x=1713538464; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrmdCrVWtwb7lFW6AyHWbgOgdloa5ymd2fy0iQuLqTo=;
        b=jZMOLO9Mr0xDTGxrxV8mIoSXOfsy0NmwYQW0zI/ASTTgNcMfwZ1UQ+4+EWeTJclvO0
         Taso9FlZRd68oNAXtsEXqF+Zh6esim3EnEM79tEAtREazLVZQ6C9RcZr2bB6YXUecyGS
         i7mCDGukKBi1YWkZxqotQaPbtcMhvIO0ZTKV6N8znDXDGxWCjC5OU7bIOqzfxP3fuG1U
         E2JP1zqWTjEE923qoZFUYQEtzonrgr20LU+ra6Rlt0Z1LsoznWEvbR4GBs+l5h7rbR0e
         cIJ7OWbCRDSO7twJVl7NouedyjTGtc284+QIYkl4d3Zq7NLXu8Bt0ccYTnihc37Pwxpl
         yNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712933664; x=1713538464;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrmdCrVWtwb7lFW6AyHWbgOgdloa5ymd2fy0iQuLqTo=;
        b=Sk+aF174J7qqGUTdkZo7gdOF8uE2iutYg/5qiXk3CYaz/N/bvKUovpJxh8AUywJ/QE
         bw8a1NgVHElwZC8DF6FBFDNGFjaVlDotO3cibWth5QC1G64TphKSIqolfxnl5W00M2Ys
         Vvx6Z4A7KYjlzVn5KzOkIRXDOiCSCF6HF87+apiGjy7XGZcqsks4Uu/P/BnBCDFp6iQN
         Hq4VnAkOuAh8qLg6ISLqswV7n6J1gwYtkkSIJt0pu0BQT2zKziJApM6irJaVp9spxJum
         Pf5U2XcdYxgFHXJoyFoAFZv/3kec9pKDvTx2QnLFvxiQRkm5u8WSQXqoWFvap1OZu6xy
         rYRg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ/6jloQU4PimnKn+nU7AmhZn4LT376+QQdAgNhjSylD/KJAlR7424VPg/O1cMR5IVFEXZUWC7a9Zg1eHGyaUlLKK1eFx14zOUKV8u1cuLaFza
X-Gm-Message-State: AOJu0YxtM8eEYDBo1An4zFiIvbL79xzlfObRwA5wA4JI9G1NsB741m2E
	i4iGpcZGycHmAncHfhcEN4UT+zR4xqIlH23wYmHJJDO1HXKl6UgXXwT3wCQZZk/ke/N4xVFIfpf
	MZA==
X-Google-Smtp-Source: AGHT+IE8CrGE6yHurBu6oRRUdhNStzcxsQMqGws9O1toyt+VIrjo1lbnGIr3E72VqB9zErBllk+K4v4iLAw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2d94:b0:6ed:95ce:3417 with SMTP id
 fb20-20020a056a002d9400b006ed95ce3417mr191844pfb.5.1712933663717; Fri, 12 Apr
 2024 07:54:23 -0700 (PDT)
Date: Fri, 12 Apr 2024 07:54:22 -0700
In-Reply-To: <86jzl2sovz.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405115815.3226315-1-pbonzini@redhat.com> <20240405115815.3226315-2-pbonzini@redhat.com>
 <20240412104408.GA27645@willie-the-truck> <86jzl2sovz.wl-maz@kernel.org>
Message-ID: <ZhlLHtfeSHk9gRRO@google.com>
Subject: Re: [PATCH 1/4] KVM: delete .change_pte MMU notifier callback
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
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

On Fri, Apr 12, 2024, Marc Zyngier wrote:
> On Fri, 12 Apr 2024 11:44:09 +0100, Will Deacon <will@kernel.org> wrote:
> > On Fri, Apr 05, 2024 at 07:58:12AM -0400, Paolo Bonzini wrote:
> > Also, if you're in the business of hacking the MMU notifier code, it
> > would be really great to change the .clear_flush_young() callback so
> > that the architecture could handle the TLB invalidation. At the moment,
> > the core KVM code invalidates the whole VMID courtesy of 'flush_on_ret'
> > being set by kvm_handle_hva_range(), whereas we could do a much
> > lighter-weight and targetted TLBI in the architecture page-table code
> > when we actually update the ptes for small ranges.
> 
> Indeed, and I was looking at this earlier this week as it has a pretty
> devastating effect with NV (it blows the shadow S2 for that VMID, with
> costly consequences).
> 
> In general, it feels like the TLB invalidation should stay with the
> code that deals with the page tables, as it has a pretty good idea of
> what needs to be invalidated and how -- specially on architectures
> that have a HW-broadcast facility like arm64.

Would this be roughly on par with an in-line flush on arm64?  The simpler, more
straightforward solution would be to let architectures override flush_on_ret,
but I would prefer something like the below as x86 can also utilize a range-based
flush when running as a nested hypervisor.

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ff0a20565f90..b65116294efe 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -601,6 +601,7 @@ static __always_inline kvm_mn_ret_t __kvm_handle_hva_range(struct kvm *kvm,
        struct kvm_gfn_range gfn_range;
        struct kvm_memory_slot *slot;
        struct kvm_memslots *slots;
+       bool need_flush = false;
        int i, idx;
 
        if (WARN_ON_ONCE(range->end <= range->start))
@@ -653,10 +654,22 @@ static __always_inline kvm_mn_ret_t __kvm_handle_hva_range(struct kvm *kvm,
                                        break;
                        }
                        r.ret |= range->handler(kvm, &gfn_range);
+
+                       /*
+                        * Use a precise gfn-based TLB flush when possible, as
+                        * most mmu_notifier events affect a small-ish range.
+                        * Fall back to a full TLB flush if the gfn-based flush
+                        * fails, and don't bother trying the gfn-based flush
+                        * if a full flush is already pending.
+                        */
+                       if (range->flush_on_ret && !need_flush && r.ret &&
+                           kvm_arch_flush_remote_tlbs_range(kvm, gfn_range.start
+                                                            gfn_range.end - gfn_range.start + 1))
+                               need_flush = true;
                }
        }
 
-       if (range->flush_on_ret && r.ret)
+       if (need_flush)
                kvm_flush_remote_tlbs(kvm);
 
        if (r.found_memslot)

