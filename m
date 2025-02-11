Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F381266573
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Feb 2025 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308638; cv=none; b=kcnjXJs3yQCpJLbF4SBuDvyJR/NYusGowpPux5cZNWGP42ZEnzSvQrL7wLt2w1/welVIL+pjim6vx3T80kDwEqL1SRLwEbYCFCJadrKuu29aC8btTRP+373hS0QD1qRgEC79c2W/IGk09kH+5LwdE4mwoB3lEa6WemtMWtX1qFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308638; c=relaxed/simple;
	bh=9wpSlaYQ+3T+GSVJ+uTjY7BZltuAqSqWdmPAKYj3qso=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S4LQFpGyufIvNcv15WwT1XLtIaM/rZd/tuFbpgbUIP7Dh274+lwfW8HFS/wZC5/7OuIDkmNByEIbhtm+IZ62su6O8MD4QUi4mTRcrLeyBTOsSpmeqLsZpu1tukCI8NW53+0KTP/HnOeU5LmRezwNWWq1pdxAG+KjhuPtqix49qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lNDRcdMl; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lNDRcdMl"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fa3e1f08a0so11838052a91.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Feb 2025 13:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739308634; x=1739913434; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KIfvgky9veY2hzjiVBclsLjtmap1/nd7ereBYnmFQjs=;
        b=lNDRcdMlMowlwOXgqgLIl/uq4rQvIuugHZxHd/ydkSQ8RB2Jnt/BjFifnpnFl4gWcd
         o3R7CgfkVxEet/oveZGsiCnBlsVW53+9iBNC/UGWuSpax9LXNUazNUusPBVjZbI+/S8S
         DaQ0paEdOfOiu+tCaiHnOJve9xntxjZ3SyvCzMq7Jxoc/4/m/OcV/qfLduM03HLyXODI
         mXMwYObNJOEsKqrH1Kn0Xx0jkQqZfJHdtZhACZQYWoWgz/NBzI3YV/Ke54auoNXRTplP
         4GWQ9Dxa7z+yKQaPEFzsw+17FI3KrMf1KVCLeO70UpthPXb5/MvJ+nQgnHJZtuiBQbAS
         +pmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739308634; x=1739913434;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KIfvgky9veY2hzjiVBclsLjtmap1/nd7ereBYnmFQjs=;
        b=IruSEJAG5sD8wXEtD32FEBS1aH9zLYSbu0b49r8AcJXrACrusLVszkRbAVkYsFNurG
         oT4RXyWizGaLdIM+jpTyvp+ciZ4bNw5xRzvmTj7XXUKhZsG0mYWg04HS6JzeZPeA5S+U
         Y05M4T79DVUUfLsLTJL41zBdg5/kEqyK+ERfDQcXknC7X6Fr0zdteAlco3Kfb+r6BFjh
         Q49A5R0ij0Y0NSDGSlfd+AF/b0WYpSrcwYxmiCSgupqpOUowITJJq4wjc5FYMglVzSmR
         LfMdaz0xP0wTQFB/O4IIh0ZOZ46iE2EADvaToQHogT+0YWmZ5rowLSrnsr9ZKf2MmgPd
         KJIg==
X-Forwarded-Encrypted: i=1; AJvYcCXN5BL2icRQpcUlgeufNWETfuHtWn5iHCDgNzpkucrLk5nNrZli7pOGGHAWUnml1NhnUz921n6kWSrIMx+wfsd4Yc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkaowPWkBeRYZpoBAsqbCfzcksGCl4oa0JwOfqJM6CMMN0U8Hx
	9kg8uV2bL0I+souG+MXWN+GwHuhjljjfPPCuY/6KSDSF4YGHXoS60BxdE25w6SmT0AiyxGEMGMp
	/YA==
X-Google-Smtp-Source: AGHT+IFET9IWVHjPlxyGR2feK6f9TwBvVgVNbG99vGLbfBvsF+l1UXScJabTFFPnkEjUA0nLxtM9c4Ik/Ws=
X-Received: from pfaz1.prod.google.com ([2002:aa7:91c1:0:b0:730:8518:b97])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:788d:b0:1ee:4813:8a93
 with SMTP id adf61e73a8af0-1ee5c8410f6mr1165733637.27.1739308634574; Tue, 11
 Feb 2025 13:17:14 -0800 (PST)
Date: Tue, 11 Feb 2025 13:17:13 -0800
In-Reply-To: <20241118123948.4796-1-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241118123948.4796-1-kalyazin@amazon.com>
Message-ID: <Z6u-WdbiW3n7iTjp@google.com>
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

On Mon, Nov 18, 2024, Nikita Kalyazin wrote:
> Async PF [1] allows to run other processes on a vCPU while the host
> handles a stage-2 fault caused by a process on that vCPU. When using
> VM-exit-based stage-2 fault handling [2], async PF functionality is lost
> because KVM does not run the vCPU while a fault is being handled so no
> other process can execute on the vCPU. This patch series extends
> VM-exit-based stage-2 fault handling with async PF support by letting
> userspace handle faults instead of the kernel, hence the "async PF user"
> name.
> 
> I circulated the idea with Paolo, Sean, David H, and James H at the LPC,
> and the only concern I heard was about injecting the "page not present"
> event via #PF exception in the CoCo case, where it may not work. In my
> implementation, I reused the existing code for doing that, so the async
> PF user implementation is on par with the present async PF
> implementation in this regard, and support for the CoCo case can be
> added separately.
> 
> Please note that this series is applied on top of the VM-exit-based
> stage-2 fault handling RFC [2].

...

> Nikita Kalyazin (6):
>   Documentation: KVM: add userfault KVM exit flag
>   Documentation: KVM: add async pf user doc
>   KVM: x86: add async ioctl support
>   KVM: trace events: add type argument to async pf
>   KVM: x86: async_pf_user: add infrastructure
>   KVM: x86: async_pf_user: hook to fault handling and add ioctl
> 
>  Documentation/virt/kvm/api.rst  |  35 ++++++
>  arch/x86/include/asm/kvm_host.h |  12 +-
>  arch/x86/kvm/Kconfig            |   7 ++
>  arch/x86/kvm/lapic.c            |   2 +
>  arch/x86/kvm/mmu/mmu.c          |  68 ++++++++++-
>  arch/x86/kvm/x86.c              | 101 +++++++++++++++-
>  arch/x86/kvm/x86.h              |   2 +
>  include/linux/kvm_host.h        |  30 +++++
>  include/linux/kvm_types.h       |   1 +
>  include/trace/events/kvm.h      |  50 +++++---
>  include/uapi/linux/kvm.h        |  12 +-
>  virt/kvm/Kconfig                |   3 +
>  virt/kvm/Makefile.kvm           |   1 +
>  virt/kvm/async_pf.c             |   2 +-
>  virt/kvm/async_pf_user.c        | 197 ++++++++++++++++++++++++++++++++
>  virt/kvm/async_pf_user.h        |  24 ++++
>  virt/kvm/kvm_main.c             |  14 +++
>  17 files changed, 535 insertions(+), 26 deletions(-)

I am supportive of the idea, but there is way too much copy+paste in this series.
And it's not just the code itself, it's all the structures and concepts.  Off the
top of my head, I can't think of any reason there needs to be a separate queue,
separate lock(s), etc.  The only difference between kernel APF and user APF is
what chunk of code is responsible for faulting in the page.

I suspect a good place to start would be something along the lines of the below
diff, and go from there.  Given that KVM already needs to special case the fake
"wake all" items, I'm guessing it won't be terribly difficult to teach the core
flows about userspace async #PF.

I'm also not sure that injecting async #PF for all userfaults is desirable.  For
in-kernel async #PF, KVM knows that faulting in the memory would sleep.  For
userfaults, KVM has no way of knowing if the userfault will sleep, i.e. should
be handled via async #PF.  The obvious answer is to have userspace only enable
userspace async #PF when it's useful, but "an all or nothing" approach isn't
great uAPI.  On the flip side, adding uAPI for a use case that doesn't exist
doesn't make sense either :-/

Exiting to userspace in vCPU context is also kludgy.  It makes sense for base
userfault, because the vCPU can't make forward progress until the fault is
resolved.  Actually, I'm not even sure it makes sense there.  I'll follow-up in
James' series.  Anyways, it definitely doesn't make sense for async #PF, because
the whole point is to let the vCPU run.  Signalling userspace would definitely
add complexity, but only because of the need to communicate the token and wait
for userspace to consume said token.  I'll think more on that.

diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
index 0ee4816b079a..fc31b47cf9c5 100644
--- a/virt/kvm/async_pf.c
+++ b/virt/kvm/async_pf.c
@@ -177,7 +177,8 @@ void kvm_check_async_pf_completion(struct kvm_vcpu *vcpu)
  * success, 'false' on failure (page fault has to be handled synchronously).
  */
 bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
-                       unsigned long hva, struct kvm_arch_async_pf *arch)
+                       unsigned long hva, struct kvm_arch_async_pf *arch,
+                       bool userfault)
 {
        struct kvm_async_pf *work;
 
@@ -202,13 +203,16 @@ bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
        work->addr = hva;
        work->arch = *arch;
 
-       INIT_WORK(&work->work, async_pf_execute);
-
        list_add_tail(&work->queue, &vcpu->async_pf.queue);
        vcpu->async_pf.queued++;
        work->notpresent_injected = kvm_arch_async_page_not_present(vcpu, work);
 
-       schedule_work(&work->work);
+       if (userfault) {
+               work->userfault = true;
+       } else {
+               INIT_WORK(&work->work, async_pf_execute);
+               schedule_work(&work->work);
+       }
 
        return true;
 }
