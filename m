Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99BB3BA22E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773416731; cv=none; b=M0aDi20J9I1eMfwTbRe0d59T83j+JwYDeh5pr0XkSeHBQJap7bJlf2TAbkMHzDUGhhII7A1NdXtsrmZDpFck0nyyslo/HxprtUh2/dfNriCYUxnVAhQHdjjJ5LdyCHe4mG1QRrFofR19kqEV+dLGbHI6TPIFOHGXFJHlQGYtSFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773416731; c=relaxed/simple;
	bh=ih3Rem8ez1m/UeZdhhbrirn/qXqZUnYA/rNla9ScMnk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ItU/gBI/g9TM9DCQze+iPMWawl1knflUdMtkDP8jhsSjdyjkciiO5Kp1EtwjcWm40fbj8rtBh3H1wPpupftHH9niHx4jtr6nI60kF2Z8gsL7fh4XQsQuh453KeqyIL0pRF/nHIz/8kOrpaWiOMAa1LM77oN48dSky9wo968ZQx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J+MyWJKm; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J+MyWJKm"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35a032cdd78so9793205a91.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 08:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773416729; x=1774021529; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qe2Sep21p9IzCULSaXAl1wdem+djxjYgrVntlTLH2o8=;
        b=J+MyWJKmq3TeYCE8dGWnkFvkTtg21IoJtTEY/WGCvGWRJfdlvFX4a+UVvq1xSOaXIR
         Ogl13w+WD9fZJ4kJoSstt6y1dFwu74p7Hq1IlSMGFJBWPtVT0FoJWRBSeuuAWNYVgexN
         Tk3BFyKK+c/N/I/cqyB9KFHLXiJzOfHXSEfaRe2q8BhDiUrBQNPUm6iHT5D60DTkl4ol
         CtsfWmQkT+L3WoENEiGNUENT7dZmgiUls7HJXks2NILq/DMuhrydOLzZ0M/3ks8UuSgD
         EBK99HKoFfFRTnXg0TtH8BBcuBNg757hPC6JqBrGBihIvRtybg68xRtfO+LNv7D9d81A
         wtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773416729; x=1774021529;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qe2Sep21p9IzCULSaXAl1wdem+djxjYgrVntlTLH2o8=;
        b=eQJafOR2iwfxma4wndJNXKYWVv7D3h1bTEVPosjmeyJIH4mrOIiJuGnotxp347gTgK
         woyODKnp0nyrqQYJRRKHVKoooeXhQ6uQt/pyrPfN0/DntgD88Zx+FEBNnZlhgOt815wb
         3NGs6cNbR5EEvJU3+374qc2T5ntlHutsXkg82Dz2K+497yOD8eAXv+nXHKgeT1QnP0yg
         7LzrT8JCjr/90bKT8O+deHNMaV9OVU3Hrnu6SBDuYNlc3XF0ZvrNz52yivHUmSTjq0Sg
         sk6RIziUs2hPyp0Bk1+WKa9ucj61EgZs8wFT0qnrWzKHmUpsMqxumKQoI0zS+zUfbXwp
         HcWg==
X-Forwarded-Encrypted: i=1; AJvYcCXbuuRc+21ZSjMkWzgeWSArQTjq4gfAPz5vEMV/sgjtue/Tz0LwWPZ7MEADMb2P8d5l4ew3qbOiILhLos9z+PcSrn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgrcCREaW481TNmLh5r/AfVT1yevB8gtVAc8FxivQW/jLbIbeO
	TgQOkwwHS5U+K9DtH8eerk57ZARiWaD6lgbSng1WbAiD/POgx3vHgWj5MZ2DVmysoEbV0WoKAso
	B9Y2EAw==
X-Received: from pgmr19.prod.google.com ([2002:a63:2053:0:b0:c73:cc95:c0e4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d8a:b0:359:1821:b4e3
 with SMTP id 98e67ed59e1d1-35a21ec0e6amr3676826a91.15.1773416728908; Fri, 13
 Mar 2026 08:45:28 -0700 (PDT)
Date: Fri, 13 Mar 2026 08:45:27 -0700
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Message-ID: <abQxF2Gbd7sSsCcq@google.com>
Subject: Re: [PATCH RFC v3 00/43] guest_memfd: In-place conversion support
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 13, 2026, Ackerley Tng wrote:
> Hi,
> 
> (Here's the motivation for this series, which I realized was missing from
> the earlier revisions of this series)

...

> I'm intending RFC (v3) as a basis for discussion of flags/content
> modes (name TBD) to allow userspace to request guarantees on how the memory
> contents will look like after setting memory attributes. The last 6 patches
> implement content mode support. These patches will be reordered, and some
> of them could be absorbed into earlier patches, in later revisions.
> 
> Here are the discussion points I can think of (please add on):
> 
> 1. (Might hopefully resolve soon?) Should ZERO be supported on shared to
>    private conversions? Discussion is at [6].

No.  There is no use case.  The entire point of CoCo is that the VMM is untrusted.
Having the guest rely on the VMM to zero memory makes no sense whatsoever.  There
may be a contract between the trusted whatever and the guest, but that's between
those two entities, the VMM is not involved, period.

PRESERVE is different because the intent is to allow the guest to operate on
*untrusted* data.  Operating on untrusted zeros is nonsensical.

ZERO for private=>shared is different between the VMM trusts the host kernel.

> 2. Do we need a CAP for userspace to query the flags/modes supported?

Yes.

>    It seems like there won't be anything dynamic about the flags/modes
>    supported.
> 
>    The userspace code can check what platform it is running on, and then
>    decide ZERO or PRESERVE based on the platform:
> 
>    If the VM is running on TDX,

No.  No, no, no, no.  I have said this over, and over, and over.  The contract
is between userspace and KVM, not between userspace and the underlying CoCo
implementation.  Anything that requires making assumptions based on the VM type
is a non-starter for me.

>    it would want to specify ZERO all the
>    time. If the VM were running on pKVM it would want to specify PRESERVE
>    if it wants to enable in-place sharing, and ZERO if it wants to zero the
>    memory.
> 
>    If someday TDX supports PRESERVE, then there's room for discovery of
>    which algorithm to choose when running the guest. Perhaps that's when
>    the CAP should be introduced?
> 
> 3. What do people think of the structure of how various content modes are
>    checked for support or applied? I used overridable weak functions for
>    architectures that haven't defined support, and defined overrides for
>    x86 to show how I think it would work. For CoCo platforms, I only
>    implemented TDX for illustration purposes and might need help with the
>    other platforms. Should I have used kvm_x86_ops? I tried and found
>    myself defining lots of boilerplate.
> 
> 4. enum for ZERO and PRESERVE?
> 
>    Pros:
> 
>    * No way to define both ZERO and PRESERVE (make impossible states
>      unrepresentable)
>        * e.g. enum kvm_device_type in __u32 type in struct
>          kvm_create_device
>        * But maybe someday some modes can be used together?

Huh?  Oh, you don't mean "enum", you mean "values vs. flags".  Because in C you
can obviously have an enum of flags.

I don't have a strong preference, though I think I'd vote for flags.

Practically speaking, I doubt we'll ever have more than DEFAULT, ZERO, and PRESERVE,
i.e. more than '0', '1, and '2'.  Perhaps I lack imagination, but I can't think
of any operation that we would want to become ABI.  ZERO is special purely because
various CoCo implementations already zero memory on conversion.  Everything else
fits into PRESERVE, because if the kernel perform the operation, then userspace
can do the same, and likely more performantly and obviously without needing a
contract with KVM.

The only other option I can think of is if a CoCo implementation wanted to use an
specific value other than '0' to fill a page on conversion.  Given that starting
from '0' is by far the most common state in computing, I just don't see that
happening.  E.g. that's be like adding k1salloc() in addition to kmalloc() and
kzalloc().

So, we're likely only going to have DEFAULT, ZERO, and PRESERVE, at which point
whether we use flags or values is a wash in terms of how many bits we need: 2.

If we use flags, then we can have a single CAP to enumerate all FLAGS that are
supported KVM_SET_MEMORY_ATTRIBUTES2.  If we use values, we'd need a separate CAP
for flags and a separate cap for conversion operations.

Using values would allow providing a dedicated field in kvm_memory_attributes2,
which _might_ make some code more readable.  But for me, that doesn't outweigh the
disadvantage of needing another CAP.
