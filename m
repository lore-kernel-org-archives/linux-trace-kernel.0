Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BE93B14B7
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 22:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005257; cv=none; b=KwHH6If+ordiEW4U6F1U2fe7OkcLtMGJQIm9XkpHYqBdqhpWPuB5rZ1Ozd6nxXoU0+3Bg5xC0/XJG5Aklzw8IKTxk2jzHFBLHvkn0om0XS+092yZxab8ogJ5YkfPtKzrLDpUi0qWwWnWpjpK2QxdW+1SXvr3+Ywe2BQPr1RJniI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005257; c=relaxed/simple;
	bh=HVO2gWIaxzA+bK6MQldJkeSZrAesQZSo8QAWoKoMJBg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dQKyFRKkipsyn9bXuiExOCzmmBHH7muL9Nl0mxG0b6W2Fn8SH2mQ1YNswsrDJptW0VC9dj/Ju8puI+vBBTkRRdgWlq4acbxbqPKVP6c3qtYe3oDeobWrIc99V7OZ2K3T/sRdC4aEQyE24El2zRlYzdApkp+IKLSPOKBXwyl/hn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Agy9gbGf; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Agy9gbGf"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ca8aee88725so5976885a12.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 15:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787005256; x=1787610056; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4QnMwcUHFkDNVo8ywONCXuoDqyMfQDcpXyu7v/SbVys=;
        b=Agy9gbGfbCqaYdum/88WaBXR701ZG6wE3VoLdV+R0te4hPKhEzLN+mzvw3XGJFcF9M
         5UMFU8S80FJizxl3OxHbvP1q0B09OL4KI7b6VF8lGVYREgZrwMXcltAD0tD528kfHWKI
         eC5ROWe8WJJ4Yyu8oGeguwhyA3O+Ce8Mv05Oi9J+1WUa2XaZfNbSlHmesthDerGJXFih
         5ZJFt7awxaYvWvxeX6KJDVczUgTgTY7WVn4PEXOjWnwmDqhVq8mnnrtY6/81KDV+UCf3
         b/RjawCiqCjO61ctEPhtVnBoSC7NSN4wJRoujN0FYuIHx2lhOUuzZhOqk6nX9eGKmRKY
         MfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787005256; x=1787610056;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4QnMwcUHFkDNVo8ywONCXuoDqyMfQDcpXyu7v/SbVys=;
        b=UT6eN2/FXzllF141cplhhEprUHxGIhFe96IIvhmw2nVaIkpUXlvJ/AcQ9fP/6KPWKU
         03LIjMBDqz4wEFL6UEnvlQtSSeaKvZRMLoC4voWy84LylbpjpnU7a7wbBRSVHTh5i9QV
         cKA9basWi17Unx7uyDBos6N1GiHXAOcLJRfLO2e9WeUmRA+Ywf7em/vwFyVFT6vt0Q+W
         STX0yALpt8384G89uvtln7p07A1QLNmyrGF0I94VRhLRBrSaoFF0mc2GwtPLoEbs/Rra
         OLxXGlbDzxAs/329ErhRzKyKVfCNM/OHZCx9QGss2JR5iKruzkLy/5FJFgYwCD97IeVR
         95Ag==
X-Forwarded-Encrypted: i=1; AHgh+RpOFQKAOWJK9WIM8ovwu7Wpq6N4RJYupnAXbu9KRsThuvenFBPS1l6Pw8J9LTtY9fNC4fQMXvi3N7dbt9wz46JTwfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBjORKOVJ5tPxB4v5USvGAws3BB397PhPWe/ToHv5sa95vRjiY
	80Kf21ZzsxMyIM7CzdyMEELDl4S4dD+z4xGoPVDrnazZoktxAm4VeYVYcpaCBhjE6wUNoDSf5nx
	dXUpBCQ==
X-Received: from pfbfq10.prod.google.com ([2002:a05:6a00:60ca:b0:84a:3bc9:3bcd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1149:b0:847:7ffd:ce35
 with SMTP id d2e1a72fcca58-851b87eaa83mr3450412b3a.8.1787005255291; Mon, 17
 Aug 2026 15:20:55 -0700 (PDT)
Date: Mon, 17 Aug 2026 15:20:54 -0700
In-Reply-To: <CAEvNRgH_=8YqKHb_OJfT583ZJ346cceRimd9YJ762Vv08uJGHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAEvNRgFWcndQKJE_q+ZATFZEMYd=6uRLygozLvg7L77bPX0cEQ@mail.gmail.com>
 <anqqKH6kuwpvuwp9@yzhao56-desk.sh.intel.com> <CAEvNRgGWDY_fxbyBM-5sMdYMevMe0HzVP9kbC1cCGLE_dV=_Gw@mail.gmail.com>
 <a71d4fccdffd1f6a12332ddd18fa812542ea2118.camel@intel.com>
 <CAEvNRgHxda6XK_XqWaqqVnA7oW=Fhp_C5gF4vNcL+-HfwfXMqQ@mail.gmail.com>
 <0c80b9b0e13e3ab2cbe4f9eaf4a02ebba25a7001.camel@intel.com>
 <an5RJYTwlYeym--O@google.com> <aoKnmW9St5zCoTD3@yzhao56-desk.sh.intel.com>
 <aoNrFX9yLfsM7KQI@google.com> <CAEvNRgH_=8YqKHb_OJfT583ZJ346cceRimd9YJ762Vv08uJGHQ@mail.gmail.com>
Message-ID: <aoOJRk5SXBzzT24K@google.com>
Subject: Re: [PATCH v10 11/41] KVM: guest_memfd: Ensure pages are not in use
 before conversion
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	"david@kernel.org" <david@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"steven.price@arm.com" <steven.price@arm.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"forkloop@google.com" <forkloop@google.com>, "tabba@google.com" <tabba@google.com>, 
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	Vishal Annapurve <vannapurve@google.com>, "willy@infradead.org" <willy@infradead.org>, 
	"tglx@kernel.org" <tglx@kernel.org>, "wyihan@google.com" <wyihan@google.com>, 
	"pratyush@kernel.org" <pratyush@kernel.org>, "aik@amd.com" <aik@amd.com>, 
	"jmattson@google.com" <jmattson@google.com>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "rientjes@google.com" <rientjes@google.com>, 
	"andrew.jones@linux.dev" <andrew.jones@linux.dev>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "chrisl@kernel.org" <chrisl@kernel.org>, 
	"shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>, "oupton@kernel.org" <oupton@kernel.org>, 
	"mhiramat@kernel.org" <mhiramat@kernel.org>, "baohua@kernel.org" <baohua@kernel.org>, 
	"tarunsahu@google.com" <tarunsahu@google.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>, 
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "jthoughton@google.com" <jthoughton@google.com>, 
	"yuanchu@google.com" <yuanchu@google.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"shikemeng@huaweicloud.com" <shikemeng@huaweicloud.com>, "nphamcs@gmail.com" <nphamcs@gmail.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "shivankg@amd.com" <shivankg@amd.com>, 
	"shuah@kernel.org" <shuah@kernel.org>, "youngjun.park@lge.com" <youngjun.park@lge.com>, 
	"kasong@tencent.com" <kasong@tencent.com>, "pankaj.gupta@amd.com" <pankaj.gupta@amd.com>, 
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"vbabka@kernel.org" <vbabka@kernel.org>, "weixugc@google.com" <weixugc@google.com>, 
	"michael.roth@amd.com" <michael.roth@amd.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "qperret@google.com" <qperret@google.com>, 
	"brauner@kernel.org" <brauner@kernel.org>, "bp@alien8.de" <bp@alien8.de>, 
	"baoquan.he@linux.dev" <baoquan.he@linux.dev>, "corbet@lwn.net" <corbet@lwn.net>, 
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "liam@infradead.org" <liam@infradead.org>, 
	"axelrasmussen@google.com" <axelrasmussen@google.com>, "kas@kernel.org" <kas@kernel.org>, 
	"qi.zheng@linux.dev" <qi.zheng@linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 17, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > On Mon, Aug 17, 2026, Yan Zhao wrote:
> >> > converting a page and another faulting in the same page.  An NMI, SMI, or IRQ at
> >> > just the right/wrong time, especially on a preemptible kernel, could lead to the
> >> > same test failures, even if KVM drops the refcount "immediately".
> >> Could you elaborate on how an NMI, SMI, or IRQ at just the right/wrong time
> >> could lead to the same test failures?
> >
> > Ah, sorry, my bad.  I was speed reading and missed that the key to your suggested
> > "*page = NULL" change was that the reference was put _before_
> > filemap_invalidate_unlock_shared(), i.e. before dropping
> > the invalidate lock and thus before __kvm_gmem_set_attributes() will walk the
> > folios to look for outstanding references.  I was thinking that putting the
> > reference right away was just shrinking the timing window, but putting the
> > reference while still holding the invalidate lock closes the window entirely.
> >
> > So, I take back what I said about this not being ABI, and about this not blocking
> > in-place conversion.  It most definitely affects ABI, and so needs to be addressed
> > before merging in-place conversion.
> 
> I thought back then when David suggested that conversion can return
> -EAGAIN, one of the core ABI benefits is that this leaves the door open
> for things to gradually improve. If we can improve stuff within the
> kernel, then the the kernel would just return fewer errors. This retains
> backward compatibility, since extra userspace code that handles errors
> can continue to exist, it just won't be used.

Ya, that's definitely one of my hesitations to trying to guarantee success in
the kernel.

> > The only question is if we want to commit to
> > guaranteeing that conversion will succeed in this scenario, or if we want to take
> > the easy way out and formally document that conversion can fail with EAGAIN at any
> > time, even if userspace has never mmap()'d the memory in question.
> 
> I don't really think there's a need to commit to this, IIUC in principle,
> ignoring that on many paths of those guest_memfd may be excluded, refcounts
> can be taken even if there are no host userspace mappings. For one, memory
> failure handling doesn't care if there are mappings, the refcount will be
> taken for a short while and could cause this conversion failure.
> 
> Here's the relevant part of the documentation added for conversions:
> 
>   If this ioctl returns -EAGAIN, the offset of the page with unexpected
>   refcounts will be returned in `error_offset`. This can occur if there
>   are transient refcounts on the pages, taken by other parts of the
>   kernel.
> 
>   Userspace is expected to figure out how to remove all known refcounts
>   on the shared pages, such as refcounts taken by get_user_pages(), and
>   try the ioctl again. A possible source of these long term refcounts is
>   if the guest_memfd memory was pinned in IOMMU page tables.
>
> > I'm leaning pretty strongly towards guaranteeing conversion will succeed.  We'll
> > still need to document the EAGAIN behavior, but IMO there's a massive difference
> > between conversion failing if there's a lingering reference acquired via a VMA,
> > conversion failing because a vCPU page fault raced with conversion.  E.g. being
> > able to assert success in a very curated test, as the stress test presumably does,
> > would be extremely valuable for helping detect/prevent edge case bugs.
> >
> > The argument against guaranteeing success is that we might make our future lives
> > harder, e.g. if it turns out there are legitimate, hard-to-solve edge cases.  But
> > I'm ok with that risk, as it seems highly unlikely to be problematic in practice,
> > and there is real benefit to guaranteeing success.
> >
> 
> Is there really a need to commit to anything? This is already documented
> as "can fail", and it's orthogonal to whether the memory was mapped.

Yes, but the above docs also say "it's userspace's problem".  Which I generally
agree with, but that's not a very good story when it comes to KVM itself taking
transient references, because then the answer becomes "Stop running all vCPUs",
which I don't like.  E.g. in a very pathological scenario, it's theoretically
possible that conversion may never succeed.  That's what gives me pause.

> The transient nature of refcounts on pages in general makes it hard to
> guarantee, and this stretches outside of KVM. I mean, anything could take a
> refcount on a page in future and we can't be auditing the entire kernel for
> no refcounts on guest_memfd pages ever.

True, but at the same time, if there were never any VMAs then I would expect there
to never be transient refcounts, modulo memory failure.  And it'd be easy enough
to document the memory failure angle.

> >> > As for in-place conversion, this is not a blocker.
> >> Sorry. I didn't intend to block in-place conversion.
> >
> > LOL, what we intend and what happens aren't always the same. :-)
> 
> I don't think we're ready to guarantee conversion success when guest_memfd
> pages are not mapped to userspace 

Yeah, that was too strong of wording on my part.  The needle I was trying to
thread was "conversion for this specific scenario, in a controlled environment,
is guaranteed to succeed".

> without dragging this out way further.
>
> I'm all for KVM not taking any references on guest_memfd, but I think
> eliminating KVM itself as a source of transient refcounts can be a
> series in itself.

Yes, it would definitely be a separate mini-series.

> KVM not taking any references on guest_memfd memory is definitely welcome,
> it'll pave the way to using non-struct-page memory in guest_memfd.
> 
> It'll come, can we not block on this please?

FWIW, it doesn't have to block initial merge, just the final release.  E.g. even
if we decide that this is a blocking issue, we can still land the in-place
conversion series, so long as it's not exposed to userspace in the final release
of 7.4 (or whatever kernel) without fixing the transient refcount issue.

> If we find a way to strengthen the guarantee, wouldn't that be an iterative
> improvement?

Yes, but we do need to draw a line in the sand.  E.g. if conversion failed 99%
of the time because KVM was taking spurious references, I think we'd all agree
that needs to be fixed before the code is released.

I'm still leaning towards saying this one has to be fixed, because it would give
us a solid baseline from which to start, and a way to enforce it going forward
(Yan's stress test).  I could certinaly be convinced otherwise, though dropping
the transiest reference seems straightforward enough that hopefully it's a moot
point, i.e. we land both in 7.4 and don't actually have to make a decision.
