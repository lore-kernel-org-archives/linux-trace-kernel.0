Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D60341B342
	for <linux-trace-kernel@vger.kernel.org>; Fri,  8 May 2026 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262059; cv=none; b=YsJSK0wqt4KISlbhklsrptJsUEqKJFNkiUXLhER6Jo/MdLBreiIy/P3hiVOGWSgdTR++SlyZdp83Rnrz+tAGEg+XCFTuvTwLpJbY4SCGdq6rG7MZsyRbPurrqh/XfoESd7sIaHAODn1uIqAF6bfcKEJ9/cdub1Q4QZ5kHP8h2JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262059; c=relaxed/simple;
	bh=zYlTeDh9G9IT4nS+zWqxNxxmSss2n8WYffkvXEx9Akw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CDDhpzVqDy/Csol29cWTEH3NKWbb+CLqor3Fas8i5WhtXuIMF3lCb904OvSFryq/jircYgExzM+f92mEf6k/sXDNJdiPmpGpcjJmuTFdo746sPhUn1TEMVV1/fgtlQrZJZwu6KC0o1stoJdiFwE+TOw9XxMu8rY4KW2HE7wexBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XdMv1nBY; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XdMv1nBY"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-835417ba8c8so1285774b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 08 May 2026 10:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778262057; x=1778866857; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uhr4BNU/ilo4uYM728zx4k0/Id92bF2OOCtFb+maHuk=;
        b=XdMv1nBYootU71I8CC7idKoT/q4s58ElcQcNrrSb8qo3Lm1TbCwJMn1iT0rT6UhqTi
         00TqgaGCcfGiiuy5Iq14bMrIc7PAd8gDBc83/luLvScZobTZQlQ7GYukU0Z4Egi3z5Pm
         hsd5OTUodnJI/xDf+5O9A0yA322l+MmCQnnbdgEVb/0lurgQ1I4dYlZrf7TnjizCi8rC
         5ffGcnqRAuV1I38RGHEU6GegmWCuql/dqgZA8ypovvpIC26qd2iaxhgKtZaPGlgJVHSy
         2JJfk9ynavCkyodLfDGapmewkFVtD9eszEkVbKXy3jwo+HzgkWQzTTYB6B9ghlAXatwS
         S48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778262057; x=1778866857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uhr4BNU/ilo4uYM728zx4k0/Id92bF2OOCtFb+maHuk=;
        b=hqT3ZlNqwIZ4NQxM31Ae4eka4K7uavcJ2Y8mVT/ajVe2QUNmPLxJhVeLX0T1GP4xxy
         2ERHnG7Kp0igtnrEHRKITepQD4T979561HYAN2ue2x6UA/Se8M7Oyd03Mi8C8nsa1g8a
         TUBOBYsBRj03Bjoio6ekHptU8qqrTGcDdfVD8/+7muLI2utrVHR+jAAfKJaatTy41opH
         bLCUeOTsLxbHCD58cO65EgheKowzCVzZvPFuASbyXOX8slt52tWc+5TYhq0Xvf+pMDVa
         eeNaH+po+z02+iwwAO51EBucKMvNgc+ZzwmGzVnpMA0vqW7Fu5r+2lO8aaZiCgEF6tDV
         cVDA==
X-Forwarded-Encrypted: i=1; AFNElJ/MplsDwcZU6qXoarUbh8UDs405SM7GG9J9aAHUdOFaVGVV5wDJfCHzN5n+esPBlaaX/US33E+3LJd0Bi4w9EJHRao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4j6Ye1fkOybTw1c4mlR0uFIr4Sxk+X7Uo6IIM6WZ9bj4lGaG8
	v2VaPiHK4Yyn9pS3BJrleatYwb+HnBYUnYM3VF77EzTxJzk2Q4hnFqu1Jhvh2meAmIwUFGaJ/3k
	0yGXUMA==
X-Received: from pfjg10.prod.google.com ([2002:a05:6a00:b8a:b0:835:62a8:bbc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2998:b0:839:46b8:86be
 with SMTP id d2e1a72fcca58-83a5d686f07mr13095922b3a.33.1778262056375; Fri, 08
 May 2026 10:40:56 -0700 (PDT)
Date: Fri, 8 May 2026 10:40:55 -0700
In-Reply-To: <foi2zvv5qrfdcspnx4fstrvzl74m6xp6zrsw5omlbprxh4jrhx@vxnwk7fr46gu>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
 <20260326-gmem-inplace-conversion-v4-10-e202fe950ffd@google.com>
 <2r4mmfiuisw26qymahnbh2oxqkkrywqev477kc4rlkcyx7tels@c7ple7kdgpo3>
 <CAEvNRgFkusZeKxGctUpTTbYjdi7nZL1ZZar-gT7XRUOCZ2xtpw@mail.gmail.com>
 <eiiecl7jvywvqb4drq7cchmcabcrdka25wxr77uavxqineeedm@rfcnhdz6xoxf>
 <3blpenhpvysb2ig7efegedx4v3flppl5ftnz6vhpqlatfk3ycn@vmmhs7mvjieg>
 <CAEvNRgGbMhkX310CkFY_M5x-zod=BDTiuznrZ0XvFPUK7weL1A@mail.gmail.com> <foi2zvv5qrfdcspnx4fstrvzl74m6xp6zrsw5omlbprxh4jrhx@vxnwk7fr46gu>
Message-ID: <af4gJ6xZ3e7UXOuO@google.com>
Subject: Re: [PATCH RFC v4 10/44] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: Ackerley Tng <ackerleytng@google.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, ira.weiny@intel.com, jmattson@google.com, 
	jthoughton@google.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 29, 2026, Michael Roth wrote:
> On Fri, Apr 24, 2026 at 12:08:45PM -0700, Ackerley Tng wrote:
> > Michael Roth <michael.roth@amd.com> writes:
> > 
> > Thank you for your patches!
> > 
> > >
> > > [...snip...]
> > >
> > >>
> > >> I also did some minor updates (prefixed with a "[squash]" tag) to advertise
> > >> the KVM_SET_MEMORY_ATTRIBUTES2_PRESERVED flag so it can be used by
> > >
> > > Though I'm not sure how we deal with it if SNP/TDX at some point become
> > > capable of using the PRESERVED flag *after* populate... but maybe that's
> > > too unlikely to worry about? If we wanted to address it though, we could
> > > have both PRESERVED and PRESERVED_BEFORE_LAUNCH so they can be
> > > enumerated separately from the start.
> > >
> > 
> > Not sure how likely it is, but if SNP and TDX can honor PRESERVE
> > semantics after populate, I think we could implement support under a new
> > flag like CIPHER.
> 
> That works, but it still makes things *slightly* awkward due to special-casing
> the PRESERVE semantics for 1 guest type vs. another.

Summarizing this week's PUCK call[*]:

Scrap PRESERVE and ZERO, and simply rely on vendor specific semantics.

My desire to enforce PRESERVE and ZERO semantics and avoid relying on vendor specific
behavior (i.e. on trusted firmware semantics) is a pipe dream.  Unless KVM does
a truly insane amount of per-gfn tracking, KVM can't know the state of memory for
a given page, and so can't guarantee PRESERVE or ZERO will be honored.

If userspace requests PRESERVE, just because it's _possible_ to preserve contents
(e.g. during the pre-boot phase on TDX), doesn't mean the contents are _guaranteed_
to be preserved.  If userspace doesn't actually ADD the memory to the guest's
initial image, then the contents won't be preserved.  Ditto for SNP.

To guarantee PRESERVE, KVM would need to track per-gfn information to know if the
memory was actually preserved.  And enforcing PRESERVE would be all kinds of crazy;
KVM would have to kill the VM or something?  And that would still require userspace
to be aware of vendor specific details.

The same holds true for ZERO.  On a private=>shared conversion, KVM can't guarantee
the memory is zeroed by trusted firmware unless KVM tracks, per-gfn, whether or
not the memory was actually fully assigned to the guest.  E.g. if userspace does
shared=>private and then private=>shared(ZERO), without the memory being faulted
into the guest, then the TDX-Module won't have "seen" the page and so wont' have
zeroed it on the private=>shared conversion.

And trying to special case SNP's "validated CPUID" behavior, where memory can be
preserved on private=>shared after a failed shared=>private, would also require
tracking that the page was never actually converted to private.

Note, regarding ZERO, someone (Mike? Ackerley?) pointed out that userspace typically
doesn't rely on the kernel to zero memory, and so supporting ZERO for private=>shared
isn't really all that valuable in the first place.

[*] https://drive.google.com/file/d/1w0ifzh5PmNViJ1SKru9jK9x52MybXSNa/view?usp=drive_link
