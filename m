Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D813F9F5D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Apr 2026 19:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777057729; cv=pass; b=FTcNWx+vFBw0RwAUNcctfWGWemEJqTHTn2UEX08PMpgGMa+oykIJReegZKSJf5lFpMO2c4bUHPzanwVtZIwtXpuMx8BVzHjNZs6Hy5HXW8Pt1pBH5wyQ1B8ILHkS6nNyFLad2Usi5bjgvRckfeed5vhpPfF2pH0pJuQCS1+XdWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777057729; c=relaxed/simple;
	bh=RZtEXtNhHfkNb6REgZmVRn/FfCDvY0I1XuFnEkLVDpk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nN3BXZbu/bwWVg4K1PqqspO9LBGX299naQj1eAz4MKZQh8+6qjnECkwRX89Izg23zUn9KrjFHirh1ICwYTC2chUFc10teGLBe23DDAu0FyXH+u5oAF8mvsJd/wqRyfXAnFjJa7lqga0Q0GpeEl9QVzVUTmHqCd8yd4IbXmFq8c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wn8Zmut6; arc=pass smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wn8Zmut6"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5637886c92aso3342928e0c.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Apr 2026 12:08:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777057727; cv=none;
        d=google.com; s=arc-20240605;
        b=Gn+YSVhwFw60dgyFEKIy2DkyvM3MIhjymauSDzen5+rqhHx4Wr2tgUICbYud8uMMU7
         GYAwFPcJys8o0fEbBjlGi/CKQZgzkGJ1XUrsI62r6m4atRsTSXCDncIfp2PXvGvnGqRl
         abxLee9PeO/MiXOAhJkQCIRieez1jvFuk5dB4IBj70iU9WLNTkO7EM10TZT4p8FyG3Gh
         W/OD+HtVkVmxbZNe/cyBSzcVhQnsSw7Cbak2U5Ipt1gjJF2TXDc5fPII1RJoqPizN68F
         FhBhPCnayANyCUbxZIjYgotjD6EnpOu8lveDFF/CmfhXyZqjxG3HwbnTM1vdZt8jvZ1/
         Wx/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=RZtEXtNhHfkNb6REgZmVRn/FfCDvY0I1XuFnEkLVDpk=;
        fh=wFqFPJLw1cuXwh09/+Or/sraaICmZ7DIP5XSEeptC+M=;
        b=Hpy3mZjptR5LrcRNv6O3jAsfU1j1Y+Ryub9rrmyGx//PilSnMhWrJOLjVEq3vtAjN9
         BCr/j6M+3j/bmuTB+yDvobstf/5wmLF6W6XXHceHl6npiEiIEaaAQ14I0GGXtr0ecrhm
         CC85XPZgvtQW1dhCeXqqMIz28rC511+xA3bsS3YgCc44HXOPNq7mYYlYXNj7bHZOcVzf
         57+etmPXs+5KuiFdI+ENvDZIuBnXhNrCLWlqu7IyLipSgaXrWo1lvs220hv5OAWUzlbE
         oitvcnGwV9IaFVfRq9GsG98zFVoXdp4R+7zTszhHm8ODpwvH1GFWKfNjkoiR4ja6kiwQ
         Sz6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777057727; x=1777662527; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RZtEXtNhHfkNb6REgZmVRn/FfCDvY0I1XuFnEkLVDpk=;
        b=Wn8Zmut6TaIcmSg3y5Y5a+blYeLvO3T/F4cHcw7Y8e65aB9j3gDdqe6JDEYmFaxXsZ
         uIQGVA2a08X7iOx8+HCedIzhEYlzfqxt7TxqduTtq6glVAcYLTiwX5qcK2CUN/+nHq+4
         Jo13b3vYy8hS6wAtD1oyrYQ4hn8tPCncQFjs+VGwm7irmd1cXip0GMtJKIO+Db+OMYLQ
         eSgAOsZe9TTW14NiWWp0Y4karM6mZgVQLZQJ4E5+zz9bwtbeNA8z4rQe8troqd28vD4S
         fDYrv12KqJkch1N8sdlTMc7ddWq5+lsgB3TbbljGW6d1Er6BANNXjsQj0T96BTN9ztdB
         jvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777057727; x=1777662527;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZtEXtNhHfkNb6REgZmVRn/FfCDvY0I1XuFnEkLVDpk=;
        b=lpRz4IpiNl/CRofcToLjjFgk/hiB5na/T6U2mPo+CrjoQ1tRkdkU2gTPL6vznG28fN
         Dd4+60DJa7trSjTTUJQtn/WM/OI8fZ5lWLghjIBMn+DB69Pq6RGE7CJhtYMCVefClslZ
         IHL0XeVnFcm7nz3vTXGGkd/5Iqdlw6UMnJicfEFzi89BkG25/9CPWpuwYIhZPqYaY4p3
         ev7fj81YfuoisQhRFLQwPs1u8qYpl0nAiKIJovHXiau4dGG0XMJ5/q7zjLrr2MXoKPaD
         rpe3WpsMH/Ix9oGwcL4Xvxi+9i2lVxconV15q0KTVOTvhPflCG0j63jIn1UEh1AskMt4
         /iGA==
X-Forwarded-Encrypted: i=1; AFNElJ8BzG4Wd3IgHWeU8sW4OhA3lG74YFCrUB5AOcDs68DYC9XTf2B1keEPkgiNiycJvA2DjUEUCnlemDl0EBCCvzmqfvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZrv/0tq+TOrca/jhG+vvn1zBZT03M7+TWl4JswIHRO9B7LVdE
	Ps9UDq5+sp7VWOaDONS/wttRBjfzZanBMEA67qDaWCf534380cXNEaI5KSuMEQkFgDgMCnoIF05
	vmcWiaqNx/Pc7F5XV1tB+d1qocYHyqu3RC0wHF3lJ
X-Gm-Gg: AeBDiesrL6SifhDEuV+Kb4n9C4DXGd3MRJg12nv7uTxIU35rse6FhS6XB2L9wVoWR6m
	2DWLdyoKhOzv7PjAQFJpNIyFTpF/+0v5NjngoFQneHaFegA/gmXsejMtIcm8XFYllsw269zLxjU
	UAkCaFhqReW3MNH0byYRQVNnR0npGXD/Ic4cSf6i3j8HYaZ5H9oSNJ/2POMIxfso/MVW4jo9xk3
	r9byvTX+keoCKIv6M+QX+q+SnYAR7ppPqVKuaqEF5bG/4FCXrR4ZmcixW/Mn12QY5OO6yNxWvvl
	2ruwUcXSqYmrObT68hlNk9pJ4rtbH228zGg1KGNNTMjWDigPM4DMFSVvPaSn0W69cO211iaJclR
	L5IG1cqgdFswvQUE=
X-Received: by 2002:a05:6122:8b8b:b0:56c:ddbf:57e2 with SMTP id
 71dfb90a1353d-56fc6816e2amr12940121e0c.11.1777057726762; Fri, 24 Apr 2026
 12:08:46 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Apr 2026 12:08:45 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Apr 2026 12:08:45 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <3blpenhpvysb2ig7efegedx4v3flppl5ftnz6vhpqlatfk3ycn@vmmhs7mvjieg>
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
 <20260326-gmem-inplace-conversion-v4-10-e202fe950ffd@google.com>
 <2r4mmfiuisw26qymahnbh2oxqkkrywqev477kc4rlkcyx7tels@c7ple7kdgpo3>
 <CAEvNRgFkusZeKxGctUpTTbYjdi7nZL1ZZar-gT7XRUOCZ2xtpw@mail.gmail.com>
 <eiiecl7jvywvqb4drq7cchmcabcrdka25wxr77uavxqineeedm@rfcnhdz6xoxf> <3blpenhpvysb2ig7efegedx4v3flppl5ftnz6vhpqlatfk3ycn@vmmhs7mvjieg>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Apr 2026 12:08:45 -0700
X-Gm-Features: AQROBzBye4IStJFmb-zjsEcLePEkodFuzsfbkbSYLrRwBVn_bPHs_yld_lwLStI
Message-ID: <CAEvNRgGbMhkX310CkFY_M5x-zod=BDTiuznrZ0XvFPUK7weL1A@mail.gmail.com>
Subject: Re: [PATCH RFC v4 10/44] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
To: Michael Roth <michael.roth@amd.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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
Content-Type: text/plain; charset="UTF-8"

Michael Roth <michael.roth@amd.com> writes:

Thank you for your patches!

>
> [...snip...]
>
>>
>> I also did some minor updates (prefixed with a "[squash]" tag) to advertise
>> the KVM_SET_MEMORY_ATTRIBUTES2_PRESERVED flag so it can be used by
>
> Though I'm not sure how we deal with it if SNP/TDX at some point become
> capable of using the PRESERVED flag *after* populate... but maybe that's
> too unlikely to worry about? If we wanted to address it though, we could
> have both PRESERVED and PRESERVED_BEFORE_LAUNCH so they can be
> enumerated separately from the start.
>

Not sure how likely it is, but if SNP and TDX can honor PRESERVE
semantics after populate, I think we could implement support under a new
flag like CIPHER.

CIPHER can then be used to mean "do the encryption or decryption", and
for platforms not supporting encryption, they'd stick with PRESERVE?

Should we redefine the semantics of PRESERVE to be "ensure that memory
contents don't change while guest_memfd tracking is being updated" and
avoid making a commitment on how the guest should read the memory?

The above update would be aligned with ZERO not being allowed for
conversions to private (because KVM/guest_memfd does not make guarantees
about the contract between the host and guest.

This way, all of those (ZERO, PRESERVE) will focus on KVM's interface
with the host.

This lines up for SW_PROTECTED_VMs too, since reading memory that didn't
change in the guest is the contract between SW_PROTECTED_VMs and the
host.

>> userspace for SNP/TDX in the kvm_gmem_populate() path as agreed upon
>> during PUCK.
>>
>>
>> [...snip...]
>>
