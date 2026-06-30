Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511C23EA942
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826029; cv=none; b=sC39Owu979uSnA6x8zzrnTpaGon5xSQW7r3oMLp9mkK15xWTHr+w0/yUbTq6tECHP6R/PI/rm0HXqZIXTKAjh0Gxm6ZpRUzqhBCKklXo419+GGtIqKunEwtuE5IeuTFHFCAgw65OPuHilNCQeNXsskYFRlFgOQTFAY85xqXMXX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826029; c=relaxed/simple;
	bh=kfZMo0p6hs1cAypJ2ukMYvmmWfmbsMXBTl6UnRGRZI0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oR3uMb9weYW0TINxYgIRjC3kbhoD3tRTXfDRDGi27cKsqrnxMLilkPqqn8DVoCA+UxmUargOOEqDl3hQskenZU2QqOL59Fw1uUF2lWWEDvg/yVxAc8Rtxuo1wPkkU9YljkXHPkK3dhV5KKTpHFJWOFgHBXkCr3hDG5o8aFncjSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vbTNfpwp; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vbTNfpwp"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8478d2bea7cso597534b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 06:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782826027; x=1783430827; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AhLYh/cBIA1fFqX5RYZRm50yWfU0LfaJB+fi+NtWOq0=;
        b=vbTNfpwpTjalJknxI+tlYlqfWqrvuhra6xbl8pSkBmpk7DDaYEaMG7BBBJ5oytQaM3
         aCApDzw5WAm7up9RG4nE5tMWR/z9n83YWdSkogblMs4HhDZ0pNhYqle79o1d0AHFkYp7
         EMr3QWLyYMr0ZERrsEBMijg1zEa+o51TFYcpwpk795Hlh+qtGijeNembBBdUIUB9EL32
         D0ZMfTQBU64qtCZM4tbpeVJ+63+AUb5FJP5Qyq9At9vHjZqsFJhn930RxoPjQrJ56MU1
         PU9TRtlaSsyGsJ7JYMeh2C/wmJG0vbJ053fJeh8jpimlwr0PrAxO1lk588E6hIyjx6GO
         0vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782826027; x=1783430827;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AhLYh/cBIA1fFqX5RYZRm50yWfU0LfaJB+fi+NtWOq0=;
        b=We0f8BRMgUGdKJAhhDg5QXiO3KTA8v6johK9L8RmM02blAWQJlQdIQ+xLz98MYwKOs
         Nn2KybHUZGYkJ57lGvzSkclvUpaKxHYkZSLaoEXiVHEZqA7/vVGlY6tAvYGmw8i4ar0H
         I0C45xPNMEbpq9fhY5jgKQM4Bb8s8CRpzgaWGh3H7eKp9r4Jv3nC1tTCEp8RO/KOD8l6
         PA/jsv/r751ZXbYCvUfNLR3ubMkyyhdxyhdVRgIB0fphFeAOvrLaWkglxnNAEDMZymjW
         uUPcQSkvkYi7GUQegz5Q9BdAPiX4HP8hXQF4lR3q1ZBaeW6L1N4eTlEkp3awEUlcFt7a
         8Pig==
X-Forwarded-Encrypted: i=1; AHgh+Rod8K5Hsf5JT1MPnjRyn0AgYOiEp07Ew9S3bu5USoyT1AFtBQEM2DoaOWTeDZ0jiSMHsqOc42YKeXdRQ5bmrMdZM2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmmSODAhZCXB7qNH3ckgEq86xq2w+IYav+8kWu9jqBnD+bz/g2
	p0ebILRTe1A6rGPiADUy7q84DTxJ1aW/yfnlLF552x6tulssBomWrTA09vVv3g+CbcD1Ggf7DC8
	gxM52zQ==
X-Received: from pfqy13.prod.google.com ([2002:aa7:9e0d:0:b0:845:ec34:5047])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1143:b0:845:ebe6:417d
 with SMTP id d2e1a72fcca58-847a8224797mr1270415b3a.24.1782826026676; Tue, 30
 Jun 2026 06:27:06 -0700 (PDT)
Date: Tue, 30 Jun 2026 06:27:06 -0700
In-Reply-To: <akMoFqj/8Af2i/Al@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ajpGxu2uQys+S2F8@yzhao56-desk.sh.intel.com> <ajxasFBzp_9KnQLq@google.com>
 <CAEvNRgG1nHipzw4=eBgwhvyXi8xYo7FQD_sy9Ax6FDf7YDu3Og@mail.gmail.com>
 <ajyRg3BwGu5dCfOn@yzhao56-desk.sh.intel.com> <CAEvNRgH5KOHoemnC9QOn_oK97=KeAH1XuX3ps36-pJ0Fn0aBHQ@mail.gmail.com>
 <aj3TGLGWT1kMFIVH@yzhao56-desk.sh.intel.com> <CAEvNRgHb6WmOha6Pct_Tn8Ucuov95L=fj5=2R9gcHfx=b2V_+A@mail.gmail.com>
 <akI9m02jgKAdi4gX@yzhao56-desk.sh.intel.com> <akMPZePBdwQlD74H@google.com> <akMoFqj/8Af2i/Al@yzhao56-desk.sh.intel.com>
Message-ID: <akPEKslqAhygyjhg@google.com>
Subject: Re: [PATCH v8 23/46] KVM: TDX: Make source page optional for KVM_TDX_INIT_MEM_REGION
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Ackerley Tng <ackerleytng@google.com>, "aik@amd.com" <aik@amd.com>, 
	"andrew.jones@linux.dev" <andrew.jones@linux.dev>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "brauner@kernel.org" <brauner@kernel.org>, 
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>, "david@kernel.org" <david@kernel.org>, 
	"jmattson@google.com" <jmattson@google.com>, "jthoughton@google.com" <jthoughton@google.com>, 
	"michael.roth@amd.com" <michael.roth@amd.com>, "oupton@kernel.org" <oupton@kernel.org>, 
	"pankaj.gupta@amd.com" <pankaj.gupta@amd.com>, "qperret@google.com" <qperret@google.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, "rientjes@google.com" <rientjes@google.com>, 
	"shivankg@amd.com" <shivankg@amd.com>, "steven.price@arm.com" <steven.price@arm.com>, 
	"tabba@google.com" <tabba@google.com>, "willy@infradead.org" <willy@infradead.org>, 
	"wyihan@google.com" <wyihan@google.com>, "forkloop@google.com" <forkloop@google.com>, 
	"pratyush@kernel.org" <pratyush@kernel.org>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, "liam@infradead.org" <liam@infradead.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
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
	Vlastimil Babka <vbabka@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 30, 2026, Yan Zhao wrote:
> On Tue, Jun 30, 2026 at 08:35:49AM +0800, Sean Christopherson wrote:
> > Gah, I thought I had sent this out this morning, long before Ackerley's response.
> > But I got distracted by a meeting and forgot to get back to this... *sigh*
> > 
> > Sending what I already wrote, even though there's a lot of overlap with Ackerley's
> > mail.
> > 
> > On Mon, Jun 29, 2026, Yan Zhao wrote:
> > > On Fri, Jun 26, 2026 at 08:28:32AM -0700, Ackerley Tng wrote:
> > > > Yan Zhao <yan.y.zhao@intel.com> writes:
> > > > > But if a user configures 0 uaddr as valid, writes to it, and then passes 0 as
> > > > > source_addr(not from gmem), I'm not sure if it's good for the kernel to silently
> > > > > treat 0 uaddr as an identifier for in-place copy from the private PFN in gmem.
> > > > >
> > > > 
> > > > I'd say the original uAPI perhaps just didn't document 0 as an
> > > > unsupported uaddr. Given that commit 2a62345b3052 already merged, uAPI
> > > > was perhaps accidentally changed and no customer complained, I think we
> > > > can move forward with 0 as an invalid src_address? I wouldn't think
> > > > anyone relies on 0 intentionally being a valid address.
> > > > 
> > > > I could document that, if it helps?
> > > What about just documenting that 0 is an unsupported uaddr which will be
> > > re-purposed as an indicator to use the target pfn as the source, regardless of
> > > whether gmem_in_place_conversion is true? i.e.,
> > > 
> > > if (!src_page) 
> > > 	src_page = pfn_to_page(pfn);
> > 
> > Because KVM can't generally use the target page as the source without in-place
> > conversion, it's not supported today, and out-of-place conversion is being
> > deprecated.
> By "out-of-place conversion", do you mean using per-VM memory attribute
> conversion?

Yep, I couldn't come up with a better description.

> > > I don't get why the two scenarios should be treated differently:
> > > 1. gmem_in_place_conversion==true, shared memory is not from gmem 
> > > 2. gmem_in_place_conversion==false, shared memory is not from gmem
> > > 
> > > In both case, a 0 uaddr could be mapped to a valid page not from gmem.
> > 
> > That's immaterial.  KVM's ABI (that we're solidifying) is that an address of '0'
> > for the source means NULL.  The fact that userspace could have a valid mapping
> > at virtual address '0' is irrelevant.
> So, I'm wondering if we can document that 0 uaddr could always mean using target
> PFN.

I would document it as saying "no source page", and then state that a source page
is required if in-place conversion isn't enabled/supported/allowed.

> i.e., for both scenarios 1 and 2, al long as 0 uaddr is specified, we always
> use target PFN as source for in-place add.
> 
> > Again, just because something is technically possible doesn't mean it needs to
> > be supported by every piece of KVM's uAPI.
> > 
> > > So why not update the uAPI to handle both cases consistently? :)
> > 
> > Because retroactively adding support for out-of-place conversion is pointless
> > (requires a userspace update for a feature that's being deprecated), KVM can't
> > generally support using the source for out-of-place conversion (it's effectively
> > an obscure zero-page optimization), and IMO rejecting the out-of-place conversion
> > scenario is valuable for KVM developers, e.g. to help newcomers understand what
> > exactly is and isn't possible.
> Ok. You mean per-VM memory attribute is deprecating, and source page from !gmem
> backend is also deprecating, so we don't want to change uAPI for scenarios under
> gmem_in_place_conversion==false. Right?

Right.

> 
> > Side topic, isn't TDX broken if target page has already been added to the TD?
> > IIUC, kvm_tdp_mmu_map_private_pfn() will be a glorified nop due to the page
> > already having a valid S-EPT mapping, and so KVM will incorrectly allow a double
> Not sure if my understand out-of-place conversion correctly.
> Given target PFNs and GFNs are not duplicated, what would cause double add? :)

I was working through what would happen if userspace did KVM_TDX_INIT_MEM_REGION
on the same target page multiple times.

> 
> > add.  Ahhh, no, because KVM will return RET_PF_SPURIOUS and
> > kvm_tdp_mmu_map_private_pfn() will then return -EIO.
> My asking was if we could document uaddr always means using target PFN, since
> TDX's in-place add does not rely on gmem in-place conversion.

Yeah, I was on a tangent, ignore everything from "Side topic" on.
