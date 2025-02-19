Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B5A1E885
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978260; cv=none; b=kekuvSceQhKBZw6q7tBcSBn/a7sW6NNIiexmz+FF8mq+WbmhfxffHQgIWYG2GovTwkNkxvSjlGo4P0PZgnDjALyaYIojMBcdxp/ei9COQKxavgWla3yvyNm2xxmq/d/BiTf2DhJvDzp6xPFOEeODqwxqeGQz4FFfBIRQRO0iVpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978260; c=relaxed/simple;
	bh=WdGj3mg26niazdgEpCLUBe5M4rDcTiqLPV6+jLJxCFM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q83XpFuPvtjmNlLYHkQRLnO/p0oDx7UzpygagOATpR5cjwZlB9NBXnNjZ6ptI28ap/udWH7bYo8V6e70RVeqf82KY3hJXOvzAXL25LUwShivDGJww6Z4FQisKV0f/j2w+Tsva1Z3rPYwrB7DJJBcDXkQb8PwazPP6RvSOL3ROmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XRvSHVDE; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XRvSHVDE"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc1cb0c2cbso19572744a91.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Feb 2025 07:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739978258; x=1740583058; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lr0FQ+nYVzOkkkQbsOIsH4v20fYzY6BEtN0DQJbkPgo=;
        b=XRvSHVDEdz5XsuTDNMtGI0NP01Ti8dc3XPgsiwmHhIKEXQI70rixKHjXXZjCE+P8EY
         RGD2TZPoT6KHufpkILd2BRI8A/8iXbHhNi/exh7Y1Q/fXuTHE8r0cnEejYmg5Yz/llSc
         wkns5oqZetP5TScABKi3w2kCCpsQq6pYjC0l4tfj7Oun7VM5n+RzhUq9SgHzZRlAdtlk
         TqLBIZ3HxP9jTK9TU2z8/8qh7ckfSnt/ouXClq4eySgjgsJQ37ZM/eDpqBNzFTOYaVrO
         Qz95FF9dmtaSs1uq1dW/r/ONBcecGIvaTdzJPAsshGCK7eUvZPklBHR5KIPvBSGFvedi
         E6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739978258; x=1740583058;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lr0FQ+nYVzOkkkQbsOIsH4v20fYzY6BEtN0DQJbkPgo=;
        b=Yu03ZkIT64HcJSjmwm6yqXaIPETywGDPHUjZDvSn7h1ebfGehXswTVoCj6D0ZYZfAk
         bKpAeGoqMbwlTKr2oDzJbzTrVbn3u38FoTeQ6Ky9WnvUCgrubuME9+aTcehR6hYwnLHT
         lKjR6T94L4w8NNJ/ZqYDxklvChJ5NDhGhgC7w4MbkmlYRBikgRceHGznc1zZLSvZIzun
         RXem/U/MRZbLHuiTqDdLrU4b9qXkojKTA/LEsOPyWDPgj33QzIURd6OxkxD49sTVed10
         HRPl5y4vuQfORut13T6AIidNTiO9LNva6kpbYAnf9BJi94YyIyGZYwB8A4w8LvuCyrV4
         VuVA==
X-Forwarded-Encrypted: i=1; AJvYcCXUv6AA3tvmzGpTmorpmqucPgoHIuGaOz/QUmeCQZjdl+TBUOFhAjPQ+oAukXBu4AHUK4xmxIW4+VG38/BJbJGR7+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPdGfzazmhvVuOSvCxNScBCvm8VnUHi05XnDiVeqVJwvw1nqRe
	MULsODdF1Ty2fhN8wmckKgdWhwj/062vOzIzKqoJ3ml041WUQcP60Ja1oEQjnHZYKu3Kj0D8d9p
	dQA==
X-Google-Smtp-Source: AGHT+IFm8swAf6amSZphHdCPuf7jq3DdJqtSa9LycPSODogg0yG2aBnIIzAy7tiqpzumfMEInPxKCrl9oII=
X-Received: from pfbcw22.prod.google.com ([2002:a05:6a00:4516:b0:731:9461:420e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d807:b0:1ee:6a20:1778
 with SMTP id adf61e73a8af0-1ee8cb85299mr28927616637.20.1739978257735; Wed, 19
 Feb 2025 07:17:37 -0800 (PST)
Date: Wed, 19 Feb 2025 07:17:36 -0800
In-Reply-To: <a7080c07-0fc5-45ce-92f7-5f432a67bc63@amazon.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241118123948.4796-1-kalyazin@amazon.com> <Z6u-WdbiW3n7iTjp@google.com>
 <a7080c07-0fc5-45ce-92f7-5f432a67bc63@amazon.com>
Message-ID: <Z7X2EKzgp_iN190P@google.com>
Subject: Re: [RFC PATCH 0/6] KVM: x86: async PF user
From: Sean Christopherson <seanjc@google.com>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: pbonzini@redhat.com, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, jthoughton@google.com, david@redhat.com, 
	peterx@redhat.com, oleg@redhat.com, vkuznets@redhat.com, gshan@redhat.com, 
	graf@amazon.de, jgowans@amazon.com, roypat@amazon.co.uk, derekmn@amazon.com, 
	nsaenz@amazon.es, xmarcalx@amazon.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 12, 2025, Nikita Kalyazin wrote:
> On 11/02/2025 21:17, Sean Christopherson wrote:
> > On Mon, Nov 18, 2024, Nikita Kalyazin wrote:
> > And it's not just the code itself, it's all the structures and concepts.  Off the
> > top of my head, I can't think of any reason there needs to be a separate queue,
> > separate lock(s), etc.  The only difference between kernel APF and user APF is
> > what chunk of code is responsible for faulting in the page.
> 
> There are two queues involved:
>  - "queue": stores in-flight faults. APF-kernel uses it to cancel all works
> if needed.  APF-user does not have a way to "cancel" userspace works, but it
> uses the queue to look up the struct by the token when userspace reports a
> completion.
>  - "ready": stores completed faults until KVM finds a chance to tell guest
> about them.
> 
> I agree that the "ready" queue can be shared between APF-kernel and -user as
> it's used in the same way.  As for the "queue" queue, do you think it's ok
> to process its elements differently based on the "type" of them in a single
> loop [1] instead of having two separate queues?

Yes.

> [1] https://elixir.bootlin.com/linux/v6.13.2/source/virt/kvm/async_pf.c#L120
> 
> > I suspect a good place to start would be something along the lines of the below
> > diff, and go from there.  Given that KVM already needs to special case the fake
> > "wake all" items, I'm guessing it won't be terribly difficult to teach the core
> > flows about userspace async #PF.
> 
> That sounds sensible.  I can certainly approach it in a "bottom up" way by
> sparingly adding handling where it's different in APF-user rather than
> adding it side by side and trying to merge common parts.
> 
> > I'm also not sure that injecting async #PF for all userfaults is desirable.  For
> > in-kernel async #PF, KVM knows that faulting in the memory would sleep.  For
> > userfaults, KVM has no way of knowing if the userfault will sleep, i.e. should
> > be handled via async #PF.  The obvious answer is to have userspace only enable
> > userspace async #PF when it's useful, but "an all or nothing" approach isn't
> > great uAPI.  On the flip side, adding uAPI for a use case that doesn't exist
> > doesn't make sense either :-/
> 
> I wasn't able to locate the code that would check whether faulting would
> sleep in APF-kernel.  KVM spins APF-kernel whenever it can ([2]). Please let
> me know if I'm missing something here.

kvm_can_do_async_pf() will be reached if and only if faulting in the memory
requires waiting.  If a page is swapped out, but faulting it back in doesn't
require waiting, e.g. because it's in zswap and can be uncompressed synchronously,
then the initial __kvm_faultin_pfn() with FOLL_NO_WAIT will succeed.

	/*
	 * If resolving the page failed because I/O is needed to fault-in the
	 * page, then either set up an asynchronous #PF to do the I/O, or if
	 * doing an async #PF isn't possible, retry with I/O allowed.  All
	 * other failures are terminal, i.e. retrying won't help.
	 */
	if (fault->pfn != KVM_PFN_ERR_NEEDS_IO)
		return RET_PF_CONTINUE;

	if (!fault->prefetch && kvm_can_do_async_pf(vcpu)) {
		trace_kvm_try_async_get_page(fault->addr, fault->gfn);
		if (kvm_find_async_pf_gfn(vcpu, fault->gfn)) {
			trace_kvm_async_pf_repeated_fault(fault->addr, fault->gfn);
			kvm_make_request(KVM_REQ_APF_HALT, vcpu);
			return RET_PF_RETRY;
		} else if (kvm_arch_setup_async_pf(vcpu, fault)) {
			return RET_PF_RETRY;
		}
	}

The conundrum with userspace async #PF is that if userspace is given only a single
bit per gfn to force an exit, then KVM won't be able to differentiate between
"faults" that will be handled synchronously by the vCPU task, and faults that
usersepace will hand off to an I/O task.  If the fault is handled synchronously,
KVM will needlessly inject a not-present #PF and a present IRQ.

But that's a non-issue if the known use cases are all-or-nothing, i.e. if all
userspace faults are either synchronous or asynchronous.

> [2] https://elixir.bootlin.com/linux/v6.13.2/source/arch/x86/kvm/mmu/mmu.c#L4360
> 
> > Exiting to userspace in vCPU context is also kludgy.  It makes sense for base
> > userfault, because the vCPU can't make forward progress until the fault is
> > resolved.  Actually, I'm not even sure it makes sense there.  I'll follow-up in
> 
> Even though we exit to userspace, in case of APF-user, userspace is supposed
> to VM enter straight after scheduling the async job, which is then executed
> concurrently with the vCPU.
> 
> > James' series.  Anyways, it definitely doesn't make sense for async #PF, because
> > the whole point is to let the vCPU run.  Signalling userspace would definitely
> > add complexity, but only because of the need to communicate the token and wait
> > for userspace to consume said token.  I'll think more on that.
> 
> By signalling userspace you mean a new non-exit-to-userspace mechanism
> similar to UFFD?

Yes.

> What advantage can you see in it over exiting to userspace (which already exists
> in James's series)?

It doesn't exit to userspace :-)

If userspace simply wakes a different task in response to the exit, then KVM
should be able to wake said task, e.g. by signalling an eventfd, and resume the
guest much faster than if the vCPU task needs to roundtrip to userspace.  Whether
or not such an optimization is worth the complexity is an entirely different
question though.
