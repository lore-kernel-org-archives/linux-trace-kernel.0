Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8352BB04
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Apr 2024 21:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713560825; cv=none; b=MUnYSjmN6hL1JlK4gDcGv2Yuk+neC98ibCRqPySoHW/kLlS0eQfSo837QhzRKPJn+jI+NqNpUvSpdG5dr0UpZKtuKjcMuv8pG/4MrLLJz5dEfCj9V+t98E23MK2kTxnXRWEVqxWJ/THyIz1P9A6nHFxP+B24QhKnvX4Dut6ufBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713560825; c=relaxed/simple;
	bh=5/awzNU8HVXAcVpqIF8P0kyvvgiFFv7R/U2Ux5fpBds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TodzDBKZcrIiyPTxBAWoYHP1r++Vgh5xT75A+MoMdgNSvtvovHclO9KPOLAdUuu2HbYayXhG13YQxn+MDPCtbwVcklOzJi9r63O8xz44+6nlVwGPOQDqqJKnCmW3SMpGWxPtBdXhfAHsIEUM6k4qKumiSjq7LZKFndhrYxNZtk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UyiD4e+s; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UyiD4e+s"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ed20fb620fso2152501b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713560823; x=1714165623; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vDccPRw3/PnxvI5b+QrmqH79otR7qScpzAtcfP56j+c=;
        b=UyiD4e+sYdCmol3yECapDAUgCKkJS+GjtQB7oqalmWfuAOP8IAuAu7+AGWTa6yIHGO
         IAL3VvXD34IKQVK+65JzElC+D4aIE1kN639i9j849/GvV3xnIE/aM9EINQjDCL5zBYrP
         P6bKXJYYdgnNacSEePA5KgKZwDNzMKI65+Cjec+++BrNxUcGO4/ztADow+ql7plb0VZb
         /FqbS3Fgp4U5gdMEU6k1NBvvv748oLHpKRbxV+bEQfpfoPicYxle5cVYHv3xtSJ8bpKT
         6AnfHHKEtPT6WvTXnyNnzrcl11uOzPvPBcYZ+wWnneyZsptuushQPIMDQhOu1lFpmAcV
         HZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713560823; x=1714165623;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vDccPRw3/PnxvI5b+QrmqH79otR7qScpzAtcfP56j+c=;
        b=OXuFesGJBqeW15TaB/ccvqfQDJByiyjT/E+nHGdpI9lqlwUTbowWH61GqHzGizIeRu
         SP67ZYJF4HRriGcYZYVB8+cU6Jj+X8PffjRuir2j5cT35DOf4jC37OqE1zwBEmE2aWic
         WSsYtFCOwB0aJLD064XJPaWiBffibXPbbYJNiUXyP2plrKys0qxBW4d7lCGDOb1YukIy
         mnHiG9uwGQQam9mqYQ/vYSN8x4hFg7AFU3uK7dYFViZtX8DIJ4//9JchfNdEb7gH2ToL
         6QiaARBnYcTYiQoQ7ohwg6KHrWnHAR5/FiZ7UGyT18Gv3ySeBhJXfxxhkcFDtXOAa2eE
         pznA==
X-Forwarded-Encrypted: i=1; AJvYcCWTm4LSg8XJErqJtG784/tHFmYi5/EthNVQ/jDYeFTygWYPhtFs3iUml0m9sOyRQ1MdF3YFX+cERtnUNFz2ZJgnWep2pe8y6u3yaQQVw5DgOyjK
X-Gm-Message-State: AOJu0Yxz8TJ36IDha5RdPVaWrKRJncgOrjXI3CUut9z8kbcJMHF2R4oe
	FTHmMEvFS5ued+EO//G6+18556AC51rXDehYWzm/R6r9UZhxSta5W0icvhG0UA==
X-Google-Smtp-Source: AGHT+IHw/NlYfJI+uhC54L32I8Lr7TROJVo7EQ9Q27rPiTvl8C0kR92yS8I4f6VA8oYKT2j68BaI1g==
X-Received: by 2002:a05:6a21:6da2:b0:1a3:63fa:f760 with SMTP id wl34-20020a056a216da200b001a363faf760mr4253434pzb.14.1713560822638;
        Fri, 19 Apr 2024 14:07:02 -0700 (PDT)
Received: from google.com (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with ESMTPSA id go20-20020a056a003b1400b006e6233563cesm3661623pfb.218.2024.04.19.14.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 14:07:01 -0700 (PDT)
Date: Fri, 19 Apr 2024 14:06:56 -0700
From: David Matlack <dmatlack@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Yu Zhao <yuzhao@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Sean Christopherson <seanjc@google.com>,
	Jonathan Corbet <corbet@lwn.net>, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shaoqin Huang <shahuang@redhat.com>, Gavin Shan <gshan@redhat.com>,
	Ricardo Koller <ricarkol@google.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	David Rientjes <rientjes@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] KVM: x86: Participate in bitmap-based PTE aging
Message-ID: <ZiLc8OfXxc9QWxtg@google.com>
References: <20240401232946.1837665-1-jthoughton@google.com>
 <20240401232946.1837665-6-jthoughton@google.com>
 <ZhgZHJH3c5Lb5SBs@google.com>
 <Zhgdw8mVNYZvzgWH@google.com>
 <CADrL8HUpHQQbQCxd8JGVRr=eT6e4SYyfYZ7eTDsv8PK44FYV_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADrL8HUpHQQbQCxd8JGVRr=eT6e4SYyfYZ7eTDsv8PK44FYV_A@mail.gmail.com>

On 2024-04-19 01:47 PM, James Houghton wrote:
> On Thu, Apr 11, 2024 at 10:28 AM David Matlack <dmatlack@google.com> wrote:
> > On 2024-04-11 10:08 AM, David Matlack wrote:
> > bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
> > {
> >         bool young = false;
> >
> >         if (!range->arg.metadata->bitmap && kvm_memslots_have_rmaps(kvm))
> >                 young = kvm_handle_gfn_range(kvm, range, kvm_age_rmap);
> >
> >         if (tdp_mmu_enabled)
> >                 young |= kvm_tdp_mmu_age_gfn_range(kvm, range);
> >
> >         return young;
> > }
> >
> > bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
> > {
> >         bool young = false;
> >
> >         if (!range->arg.metadata->bitmap && kvm_memslots_have_rmaps(kvm))
> >                 young = kvm_handle_gfn_range(kvm, range, kvm_test_age_rmap);
> >
> >         if (tdp_mmu_enabled)
> >                 young |= kvm_tdp_mmu_test_age_gfn(kvm, range);
> >
> >         return young;
> 
> 
> Yeah I think this is the right thing to do. Given your other
> suggestions (on patch 3), I think this will look something like this
> -- let me know if I've misunderstood something:
> 
> bool check_rmap = !bitmap && kvm_memslot_have_rmaps(kvm);
> 
> if (check_rmap)
>   KVM_MMU_LOCK(kvm);
> 
> rcu_read_lock(); // perhaps only do this when we don't take the MMU lock?
> 
> if (check_rmap)
>   kvm_handle_gfn_range(/* ... */ kvm_test_age_rmap)
> 
> if (tdp_mmu_enabled)
>   kvm_tdp_mmu_test_age_gfn() // modified to be RCU-safe
> 
> rcu_read_unlock();
> if (check_rmap)
>   KVM_MMU_UNLOCK(kvm);

I was thinking a little different. If you follow my suggestion to first
make the TDP MMU aging lockless, you'll end up with something like this
prior to adding bitmap support (note: the comments are just for
demonstrative purposes):

bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
{
        bool young = false;

	/* Shadow MMU aging holds write-lock. */
        if (kvm_memslots_have_rmaps(kvm)) {
                write_lock(&kvm->mmu_lock);
                young = kvm_handle_gfn_range(kvm, range, kvm_age_rmap);
                write_unlock(&kvm->mmu_lock);
        }

	/* TDM MMU aging is lockless. */
        if (tdp_mmu_enabled)
                young |= kvm_tdp_mmu_age_gfn_range(kvm, range);

        return young;
}

Then when you add bitmap support it would look something like this:

bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
{
        unsigned long *bitmap = range->arg.metadata->bitmap;
        bool young = false;

	/* SHadow MMU aging holds write-lock and does not support bitmap. */
        if (kvm_memslots_have_rmaps(kvm) && !bitmap) {
                write_lock(&kvm->mmu_lock);
                young = kvm_handle_gfn_range(kvm, range, kvm_age_rmap);
                write_unlock(&kvm->mmu_lock);
        }

	/* TDM MMU aging is lockless and supports bitmap. */
        if (tdp_mmu_enabled)
                young |= kvm_tdp_mmu_age_gfn_range(kvm, range);

        return young;
}

rcu_read_lock/unlock() would be called in kvm_tdp_mmu_age_gfn_range().

That brings up a question I've been wondering about. If KVM only
advertises support for the bitmap lookaround when shadow roots are not
allocated, does that mean MGLRU will be blind to accesses made by L2
when nested virtualization is enabled? And does that mean the Linux MM
will think all L2 memory is cold (i.e. good candidate for swapping)
because it isn't seeing accesses made by L2?
