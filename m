Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6F1383993
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 21:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787003242; cv=pass; b=SlHDMB+BfUdh5Aj7fR01W9Kezimf+bzOlgafA25e1tOxDyHwJQo4qxTSWucd9e+vXDBXmnj+18dyXqhp75Zx/RCf/RZtj/n6kMyRiJo7nxh82alU8jWOL/vGrtRogxLsfQHdSlhbpnEF96QNq7x8z3GiJsBZk30n+nUXFAli0AI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787003242; c=relaxed/simple;
	bh=j6Qa8uIPND6iLrLwjaLqK1ckynXO6fLL8sTaD5Q9NIQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cStpibJbxRd7TF+ov6ADdHw2wfAtFuOXK8hyl7wXurpAY8O0jdKMH41eTOZGlKJCr70Z0julpB6F3EusW+lRXQPWENALmq8plwcfj1VmdnMfQrNhFcjOqbhfrlubAb24VKrW3OHKj/TAyijCxxgP1kb7uErgPcxNsLFePz0jlwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cr04oULF; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cr04oULF"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38759bcd877so4623515a91.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 14:47:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787003240; cv=none;
        d=google.com; s=arc-20260327;
        b=r68Tl/EwnFFbZCdzWNowoCZAHLXV/G3fIjvqRM5OtR7Bx5Rr6oumtLQcMqo/a7pbUQ
         joSR/iF/GkZSNU/2LBohkUKeccgGhf9bSD3V9v6rSLDE8zrkmMNsTXusOMmIvl//g13C
         hE9J53M98lKU6B3Hk4oJWNjYfpoU8RwH9xirD1tn0ol7/vYNIAtlS6IMOzrNB31ScBq2
         aBoAnt/NFNqqsG3TATk7ApkKEXZYg04+WT2jhL4WzzvF8q1cfVQvaUtEct2qF3Ppst0q
         1sYlI8I7bda96y+5NVMSqPHH4iow5CqLLxA/ghXDo98dSrkTMwzGC1NYNIdYUHoXjqS1
         Pd4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=DxYBvhey30XUfJ4ax9nYh/jGztjdRvDgSMhAvB0aQsU=;
        fh=JSigKHWQDuwOkc9UFLzX3DPd1gqeBvekCnLIvJoaphg=;
        b=TMwpHZj5Bv3g1xosZjZeZxObor2/je/Xti6I/ekgBJEs++eDwDERX032k3O+7N1dfc
         kwOE8hOjxtWIzDemmDaXHI64JTf3Gx9i/UZ5dAMH1lpoxR6TnftpOO/m7gcT6cvYD2W/
         2JsPljHc1gAr3nWnmwQpILBhiHE6rBTiGJ83RDaOzjJYTLQ/R2jbpsuwq/iUmPP6Rmd8
         jVWcB1rja4wZ05XZPeeyjylpFWHl/DPpynOzk3rUqYhNouA9qRb767RDz+ZKx7ITet6b
         LWBXGoBZTPfS6rnJObRw+rhOQknfNcbFvdEo0I5E7+atjpY5lNM+yCgTVh2MRiWpls8N
         oj/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787003240; x=1787608040; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DxYBvhey30XUfJ4ax9nYh/jGztjdRvDgSMhAvB0aQsU=;
        b=Cr04oULFAfy7blelK3JLlSkbEF8OCyB+21N3qbrSWGyWxu/INwo0tWauue5OOVUUvh
         mrzuC+v2h5WeiEyVnxRe46tT2DY9zhxQ3ieYRDoT8pv95OrLlqrr3igIKpod7cH3jGJN
         VdpMxW2O5or8BultgqnjORT4Y9Wwn8OdverkSdXory3lAKsjT6KDR2LRzE78W0csz43/
         v+ANYb5ujnXb7pIP9pHBfsXKC5DFlm4vNSqXYSos7DDJY5pUppluaNvcY656yvdTG8jY
         ndKhr10hDXdOJUpgQ+/FoTvziV+575YQCTujjK6YjDt4GBOPlTqP69gdqriLHGEbS9g5
         u/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787003240; x=1787608040;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DxYBvhey30XUfJ4ax9nYh/jGztjdRvDgSMhAvB0aQsU=;
        b=MKpocK1I/ZlKC7gWblXyNDGxqn2JM6qC0Aeyg4TZdRjERUgKt16J9nFtvjV6Ytkvam
         Zi6+FLuBN+HOcec3/YG2dYbzfDvi9BGNSEaCnl6sDf9Cu3Am4AFlBXv0OkbGo2PmWNXo
         aftbjwjiyeHZ4WzvkazbVF7YmpaoDY8+e/8Van4ZGah1FZTFTj7iqif5RQ3ve8TyfcVd
         RGTAw06LhXRHavEnznPbJBkqJviVwBdhJK6qmc0EuLe1T0J0bjWeKxnkGusH6Yybpfpb
         kp2SMp/o5TeXPgoiQsk05/+5N2mgE4aA0tgK8qZjueDxccQKMEBnqgWZld81PtLx17NY
         H73g==
X-Forwarded-Encrypted: i=1; AHgh+RrQ8kiH9ihRSeiyNwsKalVdov89pgAHLcw7CgkW9bdTHEZ8A4DMnyrlye7R0krzh02PWiUyD8LXmVaxitwkk21pKEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHkRreFgF7M8Gy9gGf/EYutQmhmAhWYl1ZELzVcoZT8eYP+knx
	XjImowds3VxxZyEQxfiLb0Jfa1ArRhPUNZoFcmPRLH7ilU2CfWHQqPaiEwR3spc4iOaP8no8+Z9
	Xsh4caTRgNLa4Gjde+GcBTKxl9eHK/xzAQaG0pttT
X-Gm-Gg: AR+sD128Dvs3dfLr0KYES1Ph7mBeSuesQitY2K5vbo73+IbX01vnI23K/yFH4BjUM9c
	bzhWQDOwAR+DS5hcmPfy954X/0hh2ytI1rRZRDPaz1aUhpnQ6ViJh3T+rYca0JyNLBrE0D3HIEb
	zvCsAytt7BkJwMnBl3gXQH3fUIWrjGbWmYFWzIwhCrBuOQcBLA1KuWek128AtQ6orn/ii0B41ax
	eyJ4EvTWIs1z1wudzvDvMkj/T22hn6lvdMf4Z/k6zj64gVeQ08z20OQt5/1JICI0lj6GxU+A+xX
	9pqA9OfmKsWEGccxKp6cKVKvLQZHHJWBlyHHEEq6tdUXKDhAODwEM9jyOPpqdzBvSGm3GkjkaYt
	8G3aOSiNGEvvU
X-Received: by 2002:a17:90b:4cc1:b0:37f:be6c:f3f2 with SMTP id
 98e67ed59e1d1-3933bd0dd0fmr33755002a91.2.1787003239624; Mon, 17 Aug 2026
 14:47:19 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 17 Aug 2026 14:47:17 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 17 Aug 2026 14:47:17 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aoNrFX9yLfsM7KQI@google.com>
References: <CAEvNRgFzRj_=GVy8T4P8ehhQjYomYxkngzwtKBF0iEL0Cv6fuQ@mail.gmail.com>
 <anp1I64K0KeyQuyo@yzhao56-desk.sh.intel.com> <CAEvNRgFWcndQKJE_q+ZATFZEMYd=6uRLygozLvg7L77bPX0cEQ@mail.gmail.com>
 <anqqKH6kuwpvuwp9@yzhao56-desk.sh.intel.com> <CAEvNRgGWDY_fxbyBM-5sMdYMevMe0HzVP9kbC1cCGLE_dV=_Gw@mail.gmail.com>
 <a71d4fccdffd1f6a12332ddd18fa812542ea2118.camel@intel.com>
 <CAEvNRgHxda6XK_XqWaqqVnA7oW=Fhp_C5gF4vNcL+-HfwfXMqQ@mail.gmail.com>
 <0c80b9b0e13e3ab2cbe4f9eaf4a02ebba25a7001.camel@intel.com>
 <an5RJYTwlYeym--O@google.com> <aoKnmW9St5zCoTD3@yzhao56-desk.sh.intel.com> <aoNrFX9yLfsM7KQI@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 17 Aug 2026 14:47:17 -0700
X-Gm-Features: AcwNN1VpUAMbtXtdgh721uPhtQzbHJAxofv-9Na5pJ24kSfJuEcCQlHEnwy5G0c
Message-ID: <CAEvNRgH_=8YqKHb_OJfT583ZJ346cceRimd9YJ762Vv08uJGHQ@mail.gmail.com>
Subject: Re: [PATCH v10 11/41] KVM: guest_memfd: Ensure pages are not in use
 before conversion
To: Sean Christopherson <seanjc@google.com>, Yan Zhao <yan.y.zhao@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, "david@kernel.org" <david@kernel.org>, 
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
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Mon, Aug 17, 2026, Yan Zhao wrote:
>> On Thu, Aug 13, 2026 at 04:20:05PM -0700, Sean Christopherson wrote:
>> > On Thu, Aug 13, 2026, Rick P Edgecombe wrote:
>> > > > > nicely so we actually just run an old branch's TDX selftests against newer
>> > > > > kernels. So the branch is a bit of a pile, and not really suitable for sharing.
>> > > > > We plan to clean it and upstream it when the path clears. So it would really
>> > > > > help to get those basic ones upstream. We remain happy to help, so please let us
>> > > > > know.
>> > > >
>> > > > I guess at this point I'm hoping y'all and Sean are okay that this
>> > > > conversions series merges, and we let this stress test failure be
>> > > > handled later. I'll be around to fix things :)
>> > > >
>> > > > I'd say the line of sight to fixing this would be when the KVM MMU only
>> > > > gets PFNs (and no pages at all) from guest_memfd.
>> > >
>> > > Hmm, I think we shouldn't upstream a uABI that we don't have line of sight to
>> > > making robust. So it would be good to settle this thread at least.
>> >
>> > This isn't uABI.  You're talking about hitting a race condition between one task
>> Hmm. Perhaps it is not a uABI issue, since users are allowed to retry. However,
>> it is hard to convince me that it makes sense to require users to retry a
>> private-to-shared conversion before a GFN has ever been mapped, given that a
>> retry is not required when the GFN is currently in use by the guest.
>>
>> > converting a page and another faulting in the same page.  An NMI, SMI, or IRQ at
>> > just the right/wrong time, especially on a preemptible kernel, could lead to the
>> > same test failures, even if KVM drops the refcount "immediately".
>> Could you elaborate on how an NMI, SMI, or IRQ at just the right/wrong time
>> could lead to the same test failures?
>
> Ah, sorry, my bad.  I was speed reading and missed that the key to your suggested
> "*page = NULL" change was that the reference was put _before_
> filemap_invalidate_unlock_shared(), i.e. before dropping
> the invalidate lock and thus before __kvm_gmem_set_attributes() will walk the
> folios to look for outstanding references.  I was thinking that putting the
> reference right away was just shrinking the timing window, but putting the
> reference while still holding the invalidate lock closes the window entirely.
>
> So, I take back what I said about this not being ABI, and about this not blocking
> in-place conversion.  It most definitely affects ABI, and so needs to be addressed
> before merging in-place conversion.

I thought back then when David suggested that conversion can return
-EAGAIN, one of the core ABI benefits is that this leaves the door open
for things to gradually improve. If we can improve stuff within the
kernel, then the the kernel would just return fewer errors. This retains
backward compatibility, since extra userspace code that handles errors
can continue to exist, it just won't be used.

> The only question is if we want to commit to
> guaranteeing that conversion will succeed in this scenario, or if we want to take
> the easy way out and formally document that conversion can fail with EAGAIN at any
> time, even if userspace has never mmap()'d the memory in question.
>

I don't really think there's a need to commit to this, IIUC in
principle, ignoring that on many paths of those guest_memfd may be
excluded, refcounts can be taken even if there are no host userspace
mappings. For one, memory failure handling doesn't care if there are
mappings, the refcount will be taken for a short while and could cause
this conversion failure.

Here's the relevant part of the documentation added for conversions:

  If this ioctl returns -EAGAIN, the offset of the page with unexpected
  refcounts will be returned in `error_offset`. This can occur if there
  are transient refcounts on the pages, taken by other parts of the
  kernel.

  Userspace is expected to figure out how to remove all known refcounts
  on the shared pages, such as refcounts taken by get_user_pages(), and
  try the ioctl again. A possible source of these long term refcounts is
  if the guest_memfd memory was pinned in IOMMU page tables.

> I'm leaning pretty strongly towards guaranteeing conversion will succeed.  We'll
> still need to document the EAGAIN behavior, but IMO there's a massive difference
> between conversion failing if there's a lingering reference acquired via a VMA,
> conversion failing because a vCPU page fault raced with conversion.  E.g. being
> able to assert success in a very curated test, as the stress test presumably does,
> would be extremely valuable for helping detect/prevent edge case bugs.
>
> The argument against guaranteeing success is that we might make our future lives
> harder, e.g. if it turns out there are legitimate, hard-to-solve edge cases.  But
> I'm ok with that risk, as it seems highly unlikely to be problematic in practice,
> and there is real benefit to guaranteeing success.
>

Is there really a need to commit to anything? This is already documented
as "can fail", and it's orthogonal to whether the memory was mapped. The
transient nature of refcounts on pages in general makes it hard to
guarantee, and this stretches outside of KVM. I mean, anything could
take a refcount on a page in future and we can't be auditing the entire
kernel for no refcounts on guest_memfd pages ever.

>> > As for in-place conversion, this is not a blocker.
>> Sorry. I didn't intend to block in-place conversion.
>
> LOL, what we intend and what happens aren't always the same. :-)
>

I don't think we're ready to guarantee conversion success when
guest_memfd pages are not mapped to userspace without dragging this out
way further.

I'm all for KVM not taking any references on guest_memfd, but I think
eliminating KVM itself as a source of transient refcounts can be a
series in itself. KVM not taking any references on guest_memfd memory is
definitely welcome, it'll pave the way to using non-struct-page memory
in guest_memfd.

It'll come, can we not block on this please? If we find a way to
strengthen the guarantee, wouldn't that be an iterative improvement?

>> I encountered this issue during testing, so reported it.
>
> Thanks for doing so!  I'd *much* rather sort these issues out *before* merging
> code, even if it means delaying the merge by a bit.
