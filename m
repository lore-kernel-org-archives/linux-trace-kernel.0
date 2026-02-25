Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E906A36402E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 11:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772017261; cv=pass; b=aHrYuTAc8VEcSWvkSnvqIAdQ+zCmd4tm4Vb1d3Bt5/J25KX/1aJ7DQtY+CAc8bYTPzd8mq0kXkZ7zIRm1lEbqvQ0Ow195izgw/579T8LJAYSt8yN95hp74EU1JFccss96Ojxj04lbzYYYldU4G70yjfxEANSp19+526qIYCMAgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772017261; c=relaxed/simple;
	bh=rFIoBbCtPAaUUxXQN/i55hNZCBkKJS12wFLo9V6DMr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uVH+JQ6TpOiHeeat4y/NzLOdI1KaVmKBGfIWwRBJU1YPBYOvXfEcCcph79wGEB3+XUjBnV+p90woW/pNrVKlazVuYc2a4wG/Gmo2q/VWWHYKmwTXigKPmRrA/XG/M+T3tjcShQm6I9f8IlW51p/pNE3Q8Iax51Mv0BB8thuEgG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T2oGZ0n2; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T2oGZ0n2"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-505d3baf1a7so391001cf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 03:00:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772017259; cv=none;
        d=google.com; s=arc-20240605;
        b=LP9IL08mfSzDlG/g8P9qW5H0t8Nj//DWvq1fDntCsaxVgnVNDBVcOhHqt2t/Vx8FS1
         P+Lw0vzY5975O8YZaNfyQKz/ccfO7EaLDwvv2Snrzmp2RJvRurx3mWLem1NTBD05fS35
         xoGsKZa5J8o0/nihsN0+0144Ri6t6s0S1e0RQZtRJaUti8UnXDywqKhJNlm5y/JFXhyo
         zggOf6N3Hse7QKcgjk1J0jMD7b+BD74dSkHHcE2ZKQXESQMpCtP9WWRvPueeEeRy51MG
         y24a+Wq01R6lIYPK+DRik5/XMCPKvUbYZEN/gtI7vJs3UO4tzqxiBZssAfAhpt8oqZjv
         kBTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aWkoDd2c7adv4SsXtWJWrFlb9EmJVdv0DDRUAC9G+VM=;
        fh=L19CGuE/nf8wWgzr+CPGtTrTUbRcM6Bkuipw3TEznV4=;
        b=SpTwjbbycGQdnj7Up1Jy8uSCE/y2eUYZw9HVqoNhPiCL0UvBNX+IpMWQNPZ7iqezoR
         aMdiYFbseTNaoAH9zwf4a0/2uMvwcPfz3arjJUbhqnhhby5IO1oN6/M2hfXmduLNMso2
         sFc0vDsyNw1BbMixhkptClTFzm4j0M9a6If1rXe14nByZZ30ynw6GEYdivRe0GYI3OXt
         iv/k22P0pie9YzZVyVimu7Prr6lq6R5rqHljWtwos7U8QNxXgQY+vuPyPNLPt0GI2Eif
         LziwG/AggMgNp7zhrVqCfzpL1PiQK5vPkV99OmfDv58c74d6WN/0Ab0rWZQDJ6kdkvxE
         ocxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772017259; x=1772622059; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aWkoDd2c7adv4SsXtWJWrFlb9EmJVdv0DDRUAC9G+VM=;
        b=T2oGZ0n2r1stSk2XfcVdVJkpqgcbmN0fziB1D/5ce1tGB5qM0fsgvPbOOEDTcfS8BG
         52gBbuwlZmASU67EobymLLNUDPBrHpguolSyQIs7UDKK68C0HYEPSj9mXYfKMDJUIPpw
         hGLX1Ht7TA7KQ6bfphjgIfGY5pPqB8QRCBdHgT6mgDK4SAW3a6vPEkl5t7VOMxVdJ5Je
         tjgOsMC5dSJS8TIAfD6WoHW6VsWrcAWLAxOqHmbHmq5iMPkc+uR7VSmz3LVcywWBSUEu
         OKox80NEGeLyC+3xWi0Hx1Noj5QL1+DBFt1gU0LHCJCn33z9fjvvIX1kKEhOkmLHMoLv
         sXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772017259; x=1772622059;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWkoDd2c7adv4SsXtWJWrFlb9EmJVdv0DDRUAC9G+VM=;
        b=ZVeeD1v4z2gDCKZtqbZqcVgf8uhHK6rhBi1z2BxfNsD0Pn7yD+aVw5cdqibcpYE/+A
         9dw4nz9p0MzlwHwRqhkmk3MJ6TuwTBAToaV8C1+mipJbSe8wbvnK6eY5KQK5qKx8kft0
         hUsmuIiRi6V1+AJ+HDRbixTR76XeDIzU7PtAKrhxT+NIYVI69hD4AIcnfGro+zww1E7g
         UpZM5H+1HCPDAR2R/wzs0xhfoXtR8fQQUdWfJUSMtC2NK0m208J7OcbASNi2G1OZbVi+
         dzDmzwDQDU9Eye3/zu7TzXqpOJ0iluFrznhoqrKKvq1SoPYOkuBlc2MzlmZ0ZyibVUCF
         TmSw==
X-Forwarded-Encrypted: i=1; AJvYcCWV5BVaB5VXv9PtdZh1C2lnL0JflufTdQnvhdrxdiddbNSVdFZRaZL62MRPy33xQC5HD6aFfrHbT0tshRvAb24VJ68=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ1VLW/J27XmwdczIPVEVMXE4lIzp8XPNNJa8qJWxRKQSZTg+i
	TsN/lBmK+kDFziQSxO5VcKcqNNuwPCgpz6fuMIaKqJBBa1vwf/3lph6LJ4PjioBJ5vrs6taYRoP
	1TKMBXennxwxUn7vi7fOvUGoSSnnbCRqCGwDS3+BT
X-Gm-Gg: ATEYQzyFV7+nh5as5Z5gU7fFvv4p0sb65dTPLs7yUfniwxKKafPA3ng7h6gJS3EEDhf
	a+fn7z9dIQzc7oxtJu5JHZzQkRfcD2lo+bB3hXR5hMnZ1ySt5hAeZPfBMQr3dpqAqrbrXkP1XJ7
	kwHzE0wVN1wlhawRxsiBZGoCasHZCEYFm0qeeRwJYC2IQDFU4K0rPddJbv5K0A8qwPOX8cuCQ41
	NzXF/KqsRWGEyEfkHAioQxI1G9fPBbex7BUPfUVmcGk3WOOfhgByJMj/Q4O8oyOyvW5F09ahuul
	nadH8xdc
X-Received: by 2002:ac8:584c:0:b0:4f0:2e33:81aa with SMTP id
 d75a77b69052e-5073a3356a2mr846691cf.11.1772017258079; Wed, 25 Feb 2026
 03:00:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770071243.git.ackerleytng@google.com> <86ad28b767524e1e654b9c960e39ca8bfb24c114.1770071243.git.ackerleytng@google.com>
 <CAEvNRgFMNywpDRr+WeNsVj=MnsbhZp9H3j0QRDo_eOP+kGCNJw@mail.gmail.com> <CAEvNRgFBLgvYoR_XTH-LiN1Q00R9u1HGC5URbstLPxYtedS0MA@mail.gmail.com>
In-Reply-To: <CAEvNRgFBLgvYoR_XTH-LiN1Q00R9u1HGC5URbstLPxYtedS0MA@mail.gmail.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 25 Feb 2026 11:00:20 +0000
X-Gm-Features: AaiRm50WQiuIi1kbMajZ1ibI5GcJzILcOFsYF84COJs9arnL6chtYw6R9I20_qA
Message-ID: <CA+EHjTxDSW=y=sPRwW70Bz9RVYM3kSCLSbWc_X4v9hz6zj=mcg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/37] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
To: Ackerley Tng <ackerleytng@google.com>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, bp@alien8.de, 
	brauner@kernel.org, chao.p.peng@intel.com, chao.p.peng@linux.intel.com, 
	chenhuacai@kernel.org, corbet@lwn.net, dave.hansen@linux.intel.com, 
	david@kernel.org, hpa@zytor.com, ira.weiny@intel.com, jgg@nvidia.com, 
	jmattson@google.com, jroedel@suse.de, jthoughton@google.com, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	mlevitsk@redhat.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, prsampat@amd.com, qperret@google.com, 
	ricarkol@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, seanjc@google.com, shivankg@amd.com, shuah@kernel.org, 
	steven.price@arm.com, tglx@linutronix.de, vannapurve@google.com, 
	vbabka@suse.cz, willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Ackerley,

Here are my thoughts, at least when it comes to pKVM.


On Tue, 24 Feb 2026 at 10:14, Ackerley Tng <ackerleytng@google.com> wrote:
>
> Ackerley Tng <ackerleytng@google.com> writes:
>
> > Ackerley Tng <ackerleytng@google.com> writes:
> >
> >>
> >> [...snip...]
> >>
> > Before this lands, Sean wants, at the very minimum, an in-principle
> > agreement on guest_memfd behavior with respect to whether or not memory
> > should be preserved on conversion.
> >>
> >> [...snip...]
> >>
>
> Here's what I've come up with, following up from last guest_memfd
> biweekly.
>
> Every KVM_SET_MEMORY_ATTRIBUTES2 request will be accompanied by an
> enum set_memory_attributes_content_policy:
>
>     enum set_memory_attributes_content_policy {
>         SET_MEMORY_ATTRIBUTES_CONTENT_ZERO,
>         SET_MEMORY_ATTRIBUTES_CONTENT_READABLE,
>         SET_MEMORY_ATTRIBUTES_CONTENT_ENCRYPTED,
>     }
>
> Within guest_memfd's KVM_SET_MEMORY_ATTRIBUTES2 handler, guest_memfd
> will make an arch call
>
>     kvm_gmem_arch_content_policy_supported(kvm, policy, gfn, nr_pages)
>
> where every arch will get to return some error if the requested policy
> is not supported for the given range.

This hook provides the validation mechanism pKVM requires.

> ZERO is the simplest of the above, it means that after the conversion
> the memory will be zeroed for the next reader.
>
> + TDX and SNP today will support ZERO since the firmware handles
>   zeroing.
> + pKVM and SW_PROTECTED_VM will apply software zeroing.
> + Purpose: having this policy in the API allows userspace to be sure
>   that the memory is zeroed after the conversion - there is no need to
>   zero again in userspace (addresses concern that Sean pointed out)
>
> READABLE means that after the conversion, the memory is readable by
> userspace (if converting to shared) or readable by the guest (if
> converting to private).
>
> + TDX and SNP (today) can't support this, so return -EOPNOTSUPP
> + SW_PROTECTED_VM will support this and do nothing extra on
>   conversion, since there is no encryption anyway and all content
>   remains readable.
> + pKVM will make use of the arch function above.
>
> Here's where I need input: (David's questions during the call about
> the full flow beginning with the guest prompted this).
>
> Since pKVM doesn't encrypt the memory contents, there must be some way
> that pKVM can say no when userspace requests to convert and retain
> READABLE contents? I think pKVM's arch function can be used to check
> if the guest previously made a conversion request. Fuad, to check that
> the guest made a conversion request, what's other parameters are
> needed other than gfn and nr_pages?

The gfn and nr_pages parameters are enough I think.

To clarify how pKVM would use this hook: all memory sharing and
unsharing must be initiated by the guest via a hypercall. When the
guest issues this hypercall, the pKVM hypervisor (EL2) exits to the
host kernel (EL1). The host kernel records the exit reason (share or
unshare) along with the specific memory address in the kvm_run
structure before exiting to userspace.

We do not track this pending conversion state in the hypervisor. If a
compromised host kernel wants to lie and corrupt the state, it can
crash the system or the guest (which is an accepted DOS risk), but it
cannot compromise guest confidentiality because EL2 still strictly
enforces Stage-2 permissions. Our primary goal here is to prevent a
malicious or buggy userspace VMM from crashing the system.

When the VMM subsequently issues the KVM_SET_MEMORY_ATTRIBUTES2 ioctl
with the READABLE policy, we will use the
kvm_gmem_arch_content_policy_supported() hook in EL1 to validate the
ioctl. We will cross-reference the requested gfn and nr_pages against
the pending exit reason stored in kvm_run.

If the VMM attempts an unsolicited conversion (i.e., there is no
matching exit request in kvm_run, or the addresses do not match), our
current plan is to reject the request and return an error. In the
future, rather than outright rejecting an unsolicited conversion, we
might evolve this to treat it as a host-initiated destructive reclaim,
forcing an unshare and zeroing the memory. For the time being,
explicit rejection is the simplest and safest path.

> ENCRYPTED means that after the conversion, the memory contents are
> retained as-is, with no decryption.
>
> + TDX and SNP (today) can't support this, so return -EOPNOTSUPP
> + pKVM and SW_PROTECTED_VM can do nothing, but doing nothing retains
>   READABLE content, not ENCRYPTED content, hence SW_PROTECTED_VM
>   should return -EOPNOTSUPP.
> + Michael, you mentioned during the call that SNP is planning to
>   introduce a policy that retains the ENCRYPTED version for a special
>   GHCB call. ENCRYPTED is meant for that use case. Does it work? I'm
>   assuming that SNP should only support this policy given some
>   conditions, so would the arch call as described above work?
> + If this policy is specified on conversion from shared to private,
>   always return -EOPNOTSUPP.
> + When this first lands, ENCRYPTED will not be a valid option, but I'm
>   listing it here so we have line of sight to having this support.
>
> READABLE and ENCRYPTED defines the state after conversion clearly
> (instead of DONT_CARE or similar).
>
> DESTROY could be another policy, which means that after the
> conversion, the memory is unreadable. This is the option to address
> what David brought up during the call, for cases where userspace knows
> it is going to free the memory already and doesn't care about the
> state as long as nobody gets to read it. This will not implemented
> when feature first lands, but is presented here just to show how this
> can be extended in future.
>
> Right now, I'm thinking that one of the above policies MUST be
> specified (not specifying a policy will result in -EINVAL).
>
> How does this sound?

I don't think that returning -EINVAL is the right thing to do here. If
userspace omits the policy, the API should default to
SET_MEMORY_ATTRIBUTES_CONTENT_ZERO and proceed with the conversion. I
believe that, in Linux APIs in general, omitting an optional behavior
flag results in the safest, most standard default action.

Also, returning -EINVAL when no policy is specified makes the policy
parameter strictly mandatory. This makes it difficult for userspace's
to seamlessly request clean-slate, destructive conversions. Software
zeroing ensures deterministic behavior across pKVM, TDX, and SNP,
isolating the KVM uAPI from micro-architectural data destruction
nuances.

Cheers,
/fuad
