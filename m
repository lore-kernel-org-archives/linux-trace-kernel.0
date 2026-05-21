Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A9F3F20E5
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373783; cv=pass; b=hgIRc1beCF/P3liSn/cUrCngf8AwP4CEt0EFOogAS+hUYCGugFcffhPB+kLHi9katb/9RhSOUOywmB9EzctbQNwd+L1D/5LrPXTZyFbu6pq1joFGTRLJ63rkKCzEPR7ByC/JN+Byj3swPPfDV/lGsCfOBHAF+XswWSPL3x1pXWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373783; c=relaxed/simple;
	bh=yfN1Pt92cq1NUORJuQ82dwA8T7lKFnYQEXa3cFZE1Ms=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AnLGoffrUFYRlYbTqiWvR8gMxXlx8T4yWqWrwXRbildZfNBlqNqVncBZ5E6VwSfsHIiHlKrw7BrliFK2x6nPHCki8cmshRlpX68msflkrT6IQkQketzKIDzLHryMaNHiin/5oR7fjOt4Fvng9P0A467o+0vXFfAfXN7QsJ8vpr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M9M/68B9; arc=pass smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M9M/68B9"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56f6afbd205so3758710e0c.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 07:29:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779373781; cv=none;
        d=google.com; s=arc-20240605;
        b=M8NflYedyUPd/Sxil/w5Ppcq3Ck/RkMjgsECvXNif7VNLJVIQWl2RQs8ckeh9/MYtU
         O+8UNmDqCXjUwomKm6fjCcKc2u+FKsc2EQ4s7VobwppGDgYTSfJFuW4iToClS+GiDonC
         f2lAuvdJ3YWK8f4FMArsCzgopVdriFISBKZ39wkgMRUCTuK+AJcKVfeolvTigSMQk8mI
         /HAhz0TQNH64Rl4UVq6CWCagegCrk4i1xS2vEjDEIfawvPLSxvq40jWeRIo/vmZEVFCH
         4qCHxlGs/Btzd9TQU8y65IJedOUePM/b79tHoKlgMkJhFcq4Kr3jNG/PL6iYTsSOJcSF
         11dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=1Wo6mylBSliDlwCJngQfhikHW93XVCjTkYwG+w8Z6n8=;
        fh=Sh/4ETfWH1vM+SqpoA98U91h2ZcDqiVXmjxc03eDpf8=;
        b=fE60SfhwK1v0+l6sdg7FzEKaS/YsCdQmyM/cwkw8NLHSPrq6y63U1F4xHn1A8ypvVf
         O/IawnzwcCHEWlrFuXl3vyMuefIju6naUTu+IAfxiB46uzXKnfX+V0Br77GcaB4Oy+ku
         TmC6ysny3dFMb8TxesKnDyGdQPJKUdq/mn7i+/Fjiaw01KqZK3QQGXl0Lu2BVADfHJfM
         HL0MuFSAIgS4DDOWpnYeVYQ8rTw36IN3Xd1yTgAlb+tduDhC7nyZsOLjvjHj0ZvycYfb
         pyb85/6LSbSAsgG4yN5kZd96zTCIZ1K/Sm4/BgwMVOu2ckrMT7mWNHTMI2sX9bGnrzPC
         GbJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779373781; x=1779978581; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Wo6mylBSliDlwCJngQfhikHW93XVCjTkYwG+w8Z6n8=;
        b=M9M/68B9coEcNJ4eVPzf1wGC7pbZq6wv8pv+vAWrOB4fq2Wgz6DCwnnaXVUDSmkZRT
         OaPJceWG4n9RBtqTkVWdu6fbcWRzyLpDEBNeg27242q5Jul+bFgLBXEN4KhNgbmjNHz9
         XY+GHzvGOa37f//SwWlyfr6zfUPRBRU6PnzsGCQJIH3BtwZ+zNDX3L3Z0yzjEdDj+F8F
         zUScIW7IccmP4XjKOJWzDplJHVxAjI3pHq38E9Y9J6bQg3EQZKvQxl5PugV7VSRC2h4l
         MfHooWVn7mLbeWkj2qXohBUVwDomZXmQ92FUzSElE4IFEWgwGQOQ2tExMh5Lx+hdZXaQ
         YccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779373781; x=1779978581;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Wo6mylBSliDlwCJngQfhikHW93XVCjTkYwG+w8Z6n8=;
        b=AOcmAJN1Ofq+QGCHJdj6RQHCJecaY+l9kqkOnvsOAWucsXbmdKgk4djuT2g6DrWGRA
         0uEfp08T6w6L09D3XLlySjeRX6VzP3enCEp1UFYgP37q8i6fNqMBzDxa3FhrEnnHt6Kv
         A6QbTY7Wm1AK/1uRY7T6rscZRDvNGg13zFD5+Q3ua2iieIpM3O/Wq5j0PqkdUDPBfOh7
         WPdQ2M+qaPp2UBAOTpe/L3m9Wml2fq+U7jinp1gYf33izHbCQudW+gCFzJ2DtIDmmNOC
         r4z7OvG+FtKRQaK2ZdyylUTn9pCEmEGg7gQSwcoxLsoBK1FJyEktQsyZxs+3EeiYl9z8
         E+1w==
X-Forwarded-Encrypted: i=1; AFNElJ/Em5+uH+F3avpkVLtGFP/P9vPObITXhwoR8m94ArNlEz8lSlyyfzl6ifPZYFRnW+ZiutpIY9VuFubDrTNmNtLFg/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2sQT1leo73noSUU8n+4ELx/lin+Dl4tQ0wPf4Ot46Wbq+wIyn
	bty0Ed7GdMT2wwb8kPII5+Z0VVTM4Gn68igLVUs+M/GCFFKkW1uF9TkJL43R2Ub3o4LUZLHb1ah
	oFzyMPFU0nrDsPVYfWr3TTrOvXyx5oWvg8mXTVRqu
X-Gm-Gg: Acq92OEyllZAQWZ2UMQxWsslNBbxlBXwN/W3KSbmyLh68zP/gBcXAYSRi9PyOjnqJ4d
	vkBLAfnlU1OrY/M8bgv4Zxp7BokF8DSfPz/afQ/F7OvakqWOmrXyDds6pZAlrH2yFE/1BBfKVyC
	Zl3gV0vDI9AoOzZvzd3AGzHOyexxwNbRLR/x1vri7zyFg2VMOVUv7gGk21Ucc6H7/CJrSfcv2z5
	zxyLCcJoqVAMd8grJZ1/jcWMe8f38GhOEvVbPQVe4iIL2aUc7DVmCSwpK2lqMgTu4Ps3Oib4aOx
	FDTP9iOai/KgTIOSnFvtJWcBXqzq6M3Jlpnv0bYIr1q4ifBIWw==
X-Received: by 2002:a05:6122:3110:b0:575:9f5:ac57 with SMTP id
 71dfb90a1353d-5841d681791mr1479571e0c.4.1779373780196; Thu, 21 May 2026
 07:29:40 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 May 2026 07:29:39 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 May 2026 07:29:39 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ag8JIlHjohAOC3-g@google.com>
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
 <20260507-gmem-inplace-conversion-v6-5-91ab5a8b19a4@google.com>
 <CA+EHjTw-cUM=FrJevtSDtR7K6MwUfGfOx21LMFDn7DAy5bFzYw@mail.gmail.com>
 <CAEvNRgGQvMdDmVfbk42EY_PGN0ybTp-x21Zj+pg_X1mk9iCRtA@mail.gmail.com>
 <CA+EHjTzLCD-dU-euZKgzwyEr2ecPqFDNutcaHm2fCDGA+MHVXA@mail.gmail.com> <ag8JIlHjohAOC3-g@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 21 May 2026 07:29:39 -0700
X-Gm-Features: AVHnY4L1QQsQd0FYhhV2GOCZxkOSXAeihTuLPqsZRThJ8u9A5XK7N3qOGhZF0xk
Message-ID: <CAEvNRgEZ9vCKkoMC11tVrueAonGWH2x6OeaYYxXGEj2gwHUaKw@mail.gmail.com>
Subject: Re: [PATCH v6 05/43] KVM: guest_memfd: Wire up kvm_get_memory_attributes()
 to per-gmem attributes
To: Sean Christopherson <seanjc@google.com>, Fuad Tabba <tabba@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Thu, May 21, 2026, Fuad Tabba wrote:
>> On Wed, 20 May 2026 at 22:44, Ackerley Tng <ackerleytng@google.com> wrote:
>> >
>> > Fuad Tabba <tabba@google.com> writes:
>> >
>> > >
>> > > [...snip...]
>> > >
>> > >> +unsigned long kvm_gmem_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
>> > >> +{
>> > >> +       struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
>> > >> +       struct inode *inode;
>> > >> +
>> > >> +       /*
>> > >> +        * If this gfn has no associated memslot, there's no chance of the gfn
>> > >> +        * being backed by private memory, since guest_memfd must be used for
>> > >> +        * private memory, and guest_memfd must be associated with some memslot.
>> > >> +        */
>> > >> +       if (!slot)
>> > >> +               return 0;
>> > >> +
>> > >> +       CLASS(gmem_get_file, file)(slot);
>> > >> +       if (!file)
>> > >> +               return 0;
>> > >> +
>> > >> +       inode = file_inode(file);
>> > >> +
>> > >> +       /*
>> > >> +        * Rely on the maple tree's internal RCU lock to ensure a
>> > >> +        * stable result. This result can become stale as soon as the
>> > >> +        * lock is dropped, so the caller _must_ still protect
>> > >> +        * consumption of private vs. shared by checking
>> > >> +        * mmu_invalidate_retry_gfn() under mmu_lock to serialize
>> > >> +        * against ongoing attribute updates.
>> > >> +        */
>> > >> +       return kvm_gmem_get_attributes(inode, kvm_gmem_get_index(slot, gfn));
>> > >> +}
>> > >
>> > > Doesn't this imply that all consumers of kvm_mem_is_private() should
>> > > validate the result using mmu_lock and the invalidation sequence?
>> >
>> > Let me know how I can improve the comment.
>>
>> Given Sean's context, the comment is good I think. I would quibble
>> with the the "_must_ still protect" phrasing being a bit too strict.
>>
>> Maybe just soften it slightly to acknowledge the exception? Something like:
>>
>>   * lock is dropped, so callers that require a strict result _must_ protect
>>   * consumption of private vs. shared by checking mmu_invalidate_retry_gfn()
>>   * under mmu_lock to serialize against ongoing attribute updates. Callers
>>   * doing lockless reads must be able to tolerate a stale result.
>>
>> That aligns the comment with how KVM is actually using it today. That
>> said, this is nitpicking. Feel free to use or ignore.
>
> Hmm, I wonder if we can figure out a way to consolidate some documentation,
> because this is _exactly_ the same pattern that x86's host_pfn_mapping_level()
> deals with (see its big comment below).
>

This would be great, are you thinking an actual comment or something in
Documentation/?

Perhaps we could iterate on this a little with me providing the newbie
perspective. Do you want me to take a stab at writing something up?

> There's also the stale comment in kvm_invalidate_memslot(), which, stating the
> obvious, speaks to the memslot+SRCU side of things.
>
> Maybe it makes sense to to find a central location for one giant comment about
> how how MMU notifier events and memslot+SRCU protections work?  And then refer
> to that in paths where some asset needs to be tied into MMU notifiers and/or
> memslots+SRCU?
>
> [*] https://lore.kernel.org/all/agcbWe8s9lmPuJwG@google.com
>
> [...snip...]
>
