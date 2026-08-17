Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0585D470E83
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 20:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786997528; cv=none; b=sGa4OGBDTRFPAQP9g8gKoxVmMhijk4HHTG+GzeVz/pxj0qxti6W+h4PxraXn4FlR7W+thqcxmu59ON+130irFKS+LHf5YAhtPWRfbdxzvROKbOPOZ7HP7foxXxei8VcdvBnjK8eRrClYQ9gpuUxpL9PTiWuIXRChmNueNptWf10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786997528; c=relaxed/simple;
	bh=21kzg6NN40Ce/8AdJ6lIoY6WV7VpheLmKQXAIMBvZso=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hsGsiPj3Lk4uT3+uxuDGRfE87RVJKTqaKRisqbLLXavReDyrvHTCaBvCuLsaBl6GcRIw6GAg7RmqI8BB+uPGcB/TPMSWetf9v6YzksdgDwzEFM8PMZICNVyhpb6BneIE0+C9fJ5oUD/7peqTN1OJ1QsODOK4aV94OyIGU4mFGHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iJTodV0a; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iJTodV0a"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84e01a62d99so4472855b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 13:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786997526; x=1787602326; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N0+O1Vxdvyhj7pmjvbt8iDMZ8zrd75NX4nQ7WNMkzm4=;
        b=iJTodV0aKmCVsLMnddLyz/1Zki4oM726DwxCPiRebwkqR3bRk4Lf97qwgRfOmmBtUm
         89fv2Wy2Y+O8Ih7dA2cbg+uPsLVXTeIOIsljApkWJ8IUWLvjOCzh+J2q8cIc4sXYPxcl
         7EeRr0HyYjvPOrLfPvTOyigo9kHGTPFs6L8nKfrxwmOowgmd3lra7KdGkfcivsDe4p8e
         USYbY3VXHsXhMGOo6KsQ60WU4blkAf6iW5CrHy6couujo3s8Gf/A4glUpkXcnCSAy6z+
         UywIsUzWcRVKSNG9DYbFBoloOW0QikRNOJ/sTZYyDd2ckL25Y2LeDyXcnlw7xfBKni07
         2wDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786997526; x=1787602326;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N0+O1Vxdvyhj7pmjvbt8iDMZ8zrd75NX4nQ7WNMkzm4=;
        b=fXVGzSun5BM9bmoJO69YXFU7my5uDOc7KbSnM0jVzGCQf6VJWazkewavasS1hycacd
         lHQSJL9d+htiNAwcPMqY2RGZvV5VMe9sZ81d94T1jl2OX8CZA7sGQY9KYOE9Wr2XviI0
         0YGMDaaMnqm9h6bs1iF4IMZxZjx5XWVz+pgVLTLLYB0v0diIpmjVpAU8b9w1gEA8vtW9
         hsyIqN9F/uhs5ksZXRFAAFYQ2BNEnHyd8Eli2n1tEaEY6t43WIKL0p2TjCb+IZb2zUF7
         yYySVGGn/E2Y+tXADv4Vyzv3HqdbMnoLKRlXcxpqQqLgX+P1Eiui0SR6aPXoLEvqThoW
         Ujow==
X-Forwarded-Encrypted: i=1; AHgh+RqnYqmUHfF2FtN518iGX/QATuMAtKWjPRXnftRxxQSShY2tVnOf/t+bY7jlV6z2d2vuYt61ZktFQZvFqD5pJox3ijg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/xQ2pwH/6U7H2uR0ESgO3qhlyRsZIkuZp3fO/aejkW1I5owdd
	1IUjGSZ76qhaQ47OYPfKNm8aReJeXaBaUU/6y+U46Kz8b2u0mYHQifB+hnW7msFboWG/qzC7IMN
	GPz2kcw==
X-Received: from pgmp38.prod.google.com ([2002:a63:1e66:0:b0:cbe:e160:452d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:23c1:b0:847:968d:b101
 with SMTP id d2e1a72fcca58-851b88ce701mr2522658b3a.21.1786997525814; Mon, 17
 Aug 2026 13:12:05 -0700 (PDT)
Date: Mon, 17 Aug 2026 13:12:05 -0700
In-Reply-To: <aoKnmW9St5zCoTD3@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAEvNRgFzRj_=GVy8T4P8ehhQjYomYxkngzwtKBF0iEL0Cv6fuQ@mail.gmail.com>
 <anp1I64K0KeyQuyo@yzhao56-desk.sh.intel.com> <CAEvNRgFWcndQKJE_q+ZATFZEMYd=6uRLygozLvg7L77bPX0cEQ@mail.gmail.com>
 <anqqKH6kuwpvuwp9@yzhao56-desk.sh.intel.com> <CAEvNRgGWDY_fxbyBM-5sMdYMevMe0HzVP9kbC1cCGLE_dV=_Gw@mail.gmail.com>
 <a71d4fccdffd1f6a12332ddd18fa812542ea2118.camel@intel.com>
 <CAEvNRgHxda6XK_XqWaqqVnA7oW=Fhp_C5gF4vNcL+-HfwfXMqQ@mail.gmail.com>
 <0c80b9b0e13e3ab2cbe4f9eaf4a02ebba25a7001.camel@intel.com>
 <an5RJYTwlYeym--O@google.com> <aoKnmW9St5zCoTD3@yzhao56-desk.sh.intel.com>
Message-ID: <aoNrFX9yLfsM7KQI@google.com>
Subject: Re: [PATCH v10 11/41] KVM: guest_memfd: Ensure pages are not in use
 before conversion
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, "david@kernel.org" <david@kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "steven.price@arm.com" <steven.price@arm.com>, 
	"peterx@redhat.com" <peterx@redhat.com>, "forkloop@google.com" <forkloop@google.com>, 
	"tabba@google.com" <tabba@google.com>, 
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

On Mon, Aug 17, 2026, Yan Zhao wrote:
> On Thu, Aug 13, 2026 at 04:20:05PM -0700, Sean Christopherson wrote:
> > On Thu, Aug 13, 2026, Rick P Edgecombe wrote:
> > > > > nicely so we actually just run an old branch's TDX selftests against newer
> > > > > kernels. So the branch is a bit of a pile, and not really suitable for sharing.
> > > > > We plan to clean it and upstream it when the path clears. So it would really
> > > > > help to get those basic ones upstream. We remain happy to help, so please let us
> > > > > know.
> > > > 
> > > > I guess at this point I'm hoping y'all and Sean are okay that this
> > > > conversions series merges, and we let this stress test failure be
> > > > handled later. I'll be around to fix things :)
> > > > 
> > > > I'd say the line of sight to fixing this would be when the KVM MMU only
> > > > gets PFNs (and no pages at all) from guest_memfd.
> > > 
> > > Hmm, I think we shouldn't upstream a uABI that we don't have line of sight to
> > > making robust. So it would be good to settle this thread at least.
> > 
> > This isn't uABI.  You're talking about hitting a race condition between one task
> Hmm. Perhaps it is not a uABI issue, since users are allowed to retry. However,
> it is hard to convince me that it makes sense to require users to retry a
> private-to-shared conversion before a GFN has ever been mapped, given that a
> retry is not required when the GFN is currently in use by the guest.
> 
> > converting a page and another faulting in the same page.  An NMI, SMI, or IRQ at
> > just the right/wrong time, especially on a preemptible kernel, could lead to the
> > same test failures, even if KVM drops the refcount "immediately".
> Could you elaborate on how an NMI, SMI, or IRQ at just the right/wrong time
> could lead to the same test failures?

Ah, sorry, my bad.  I was speed reading and missed that the key to your suggested
"*page = NULL" change was that the reference was put _before_
filemap_invalidate_unlock_shared(), i.e. before dropping
the invalidate lock and thus before __kvm_gmem_set_attributes() will walk the
folios to look for outstanding references.  I was thinking that putting the
reference right away was just shrinking the timing window, but putting the
reference while still holding the invalidate lock closes the window entirely.

So, I take back what I said about this not being ABI, and about this not blocking
in-place conversion.  It most definitely affects ABI, and so needs to be addressed
before merging in-place conversion.  The only question is if we want to commit to
guaranteeing that conversion will succeed in this scenario, or if we want to take
the easy way out and formally document that conversion can fail with EAGAIN at any
time, even if userspace has never mmap()'d the memory in question.

I'm leaning pretty strongly towards guaranteeing conversion will succeed.  We'll
still need to document the EAGAIN behavior, but IMO there's a massive difference
between conversion failing if there's a lingering reference acquired via a VMA,
conversion failing because a vCPU page fault raced with conversion.  E.g. being
able to assert success in a very curated test, as the stress test presumably does,
would be extremely valuable for helping detect/prevent edge case bugs.

The argument against guaranteeing success is that we might make our future lives
harder, e.g. if it turns out there are legitimate, hard-to-solve edge cases.  But
I'm ok with that risk, as it seems highly unlikely to be problematic in practice,
and there is real benefit to guaranteeing success.

> > As for in-place conversion, this is not a blocker.
> Sorry. I didn't intend to block in-place conversion.

LOL, what we intend and what happens aren't always the same. :-)

> I encountered this issue during testing, so reported it.

Thanks for doing so!  I'd *much* rather sort these issues out *before* merging
code, even if it means delaying the merge by a bit.
