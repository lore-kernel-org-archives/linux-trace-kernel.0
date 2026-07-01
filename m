Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5FA48A2DE
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Jul 2026 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782918440; cv=none; b=ZEvcJ5R/lpbW/tahSrZMRS+4YMzgWO7hi3Hv7aHL0tn124QE3Er/flMHn8WsG9tV4S/+bNWEQQ6XQK9gQ4eyyiHDzLD/f+54848YIAn1YpwHvRDupB2OeNhdUmrgKM0Cu0v7grSaE13SWaetuhNOMwBv9SSoV9sOINSKB0PjjXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782918440; c=relaxed/simple;
	bh=mtle515uIyp+O7vElJnFWYGr1uuE1TQcAdjdXN5Vo4c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ckj8v1HwJm3ePFeaUlDeY6jkEC+PaxSpKnmxNW9GTdBqpddw9GYXXiyV2QsAUBaHBv+9Ayii5w4mSueVpU/wU2MorLxFRNCjAWl7N834DvGyUuQNGlMglnOrVsHXCgazD/rKeg7m/rIJdMfEOeIOvfD++9KV4ScA93c+ckuprS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=du7ybx56; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="du7ybx56"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-38001e788d6so743977a91.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Jul 2026 08:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782918434; x=1783523234; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=35ip1FXhxTsr49Tf+Elt4WaaVNO58PfZuNT2YrZrg5w=;
        b=du7ybx56GtUFlXWVU3O9LfpHYDV7/+pOAfpsOn3bikOwU9q6VYbpvER6Ii5TEfbid4
         cVGaR09SdjsrGJzsKmN/yk+v0FhRORty75rVyokNjzxK8TyhzUilW2xLkb2MgKmKPMCc
         AXL6zeLlvcL/k3UL1pnt14R02XyU25z7yY2LH3R0yT8o4mSPH07QIRNQ63+5HlF+6eNe
         Mee8dMbugJRGxgfV3FBChkSW8XFiQktTpoNkk2YpP4HWAnrfvv0FNB5p9iNhvlXcNi0s
         p2XwqZKe8gw2bF282V7CByNKa9hR9GbqUKZyqCWl8VM5fLHE9dY4omhI4shhIuROgFUV
         uEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782918434; x=1783523234;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35ip1FXhxTsr49Tf+Elt4WaaVNO58PfZuNT2YrZrg5w=;
        b=nS945ezhgMMBUj4RaAeI6eoXVQdrZ+0kd4g0Ty4Wh9a62hXAthBlgNcTWfeMzG6uRG
         VaxISJAhSSd3bo5FuY5Hx8WrJEDxxI0H27IXaAs04CYQjljFzY4SCj//iOjDWC+HUsvb
         m/CeflBxSX1tyV2cLk4xNHSDQDp+U5lvjtMTutMfioFBAa8SW45BHHjjVQT24PKh4TTk
         8a3KFySIh8kAM+v/E+axhKSY5nx/QBCA9gGaHbHLxflvkZtBtuGoIj4UDqri4E3Z2D8O
         354jrN2aKzPZg1HtSGfzyEmf6tvsTggFoupKeX8lRWsimBNoqHXUs1iOYiTtBasuS8WI
         1Keg==
X-Forwarded-Encrypted: i=1; AHgh+Rru2UHdbdQe6wra4gpuaEKEnQm+LfdaLVwMHw0rJNetzLol/l+2PAoTCMJjLUyYNOWefWu2RsBS5vCjop8F/g10YMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQZkNq37hlfCrGD0T5C1BxMYrbOo/tZzFjlApgOsJsWHvZfE+L
	67FSjn2k38pynLO9pPmS4swi7UA7Ap7SoUV/9PrONJO93SXiJJugaJsWGyuF4X9V4H4viDfLVM/
	iKHf0zQ==
X-Received: from plbl14.prod.google.com ([2002:a17:902:eb0e:b0:2b0:aef9:a5a2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c50:b0:2ca:e5c:7fcf
 with SMTP id d9443c01a7336-2ca7e654686mr23268045ad.3.1782918433131; Wed, 01
 Jul 2026 08:07:13 -0700 (PDT)
Date: Wed, 1 Jul 2026 08:07:12 -0700
In-Reply-To: <e5876e41-a11a-4d5e-958f-9e247c19d387@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-7-9d2959357853@google.com>
 <a1b06afb-af6e-4666-8c7d-990e7fa150fa@intel.com> <akP9Qv_IPVEh7GAB@google.com>
 <e5876e41-a11a-4d5e-958f-9e247c19d387@intel.com>
Message-ID: <akUtIDdRiU9YOr8-@google.com>
Subject: Re: [PATCH v8 07/46] KVM: Rename memory attribute APIs to prepare for
 in-place gmem conversion
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: ackerleytng@google.com, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
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
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 01, 2026, Xiaoyao Li wrote:
> On 7/1/2026 1:30 AM, Sean Christopherson wrote:
> > On Tue, Jun 30, 2026, Xiaoyao Li wrote:
> > > On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
> > > > -bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
> > > > -				     unsigned long mask, unsigned long attrs);
> > > > +bool kvm_range_has_vm_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
> > > > +					unsigned long mask, unsigned long attrs);
> > > >    bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
> > > >    					struct kvm_gfn_range *range);
> > > >    bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
> > > 
> > > We have
> > > 
> > >   - kvm_pre_set_memory_attributes()
> > >   - kvm_arch_pre_set_memory_attributes()
> > >   - kvm_arch_post_set_memory_attributes()
> > 
> > Yeah, that's probably for the best.
> > 
> > > left, do they need to be renamed as well?
> > > 
> > > then the interesting one is kvm_vm_set_mem_attributes(), which contains "vm"
> > > already while it means "vm ioctl". Do we need to rename it to
> > > kvm_vm_set_vm_mem_attributes()?
> > 
> > I say "no" on this last one, the fact that the function is scoped to a VM ioctl
> > is enough to communicate that it applies to per-VM attributes.
> > 
> > Actually, since it's a local helper, we could go with kvm_set_vm_mem_attributes()
> > to be consistent with the other functions.  That just leaves
> > kvm_vm_ioctl_set_mem_attributes(), which I think it appropriately scoped.
> 
> If we finally choose to rename kvm_vm_set_mem_attributes() to
> kvm_set_vm_mem_attributes(), I think the trace
> trace_kvm_vm_set_mem_attributes() needs to be renamed to keep it consistent?

Ya, good catch!
