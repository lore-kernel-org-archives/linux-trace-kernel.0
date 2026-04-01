Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B248C2F1FD0
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Apr 2026 21:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775077972; cv=none; b=oQZgwTkAcW4M8TD5mUNOUVMu6127ZcqfsdFYSDPEVTLydlqYAdI08g7c7f5B5I2ANNENhPDbHJWDfORcO6WJ9Ww7xkZJpK2/hr1ZgBYcxoIHGbWwtexZ5h1lAklFLe2p5m1obBEXr146a30QebuAO8pjD0F89fxm08Jhj5a8khU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775077972; c=relaxed/simple;
	bh=jHr1hj3c2yB3sDc5e+7Fsc3y1i+wAYJMQ0SyKmFoIMI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uJvDbQQq/5dOsJ4tjepWgsNSUcKQngvy3wGZ67EshvSnerAikD0kPzNM+JZdpzzRGqze4D72gIJpeLpNfzDAv4+5EYSpOYqkmt/+0li2Y4FvhWiwp1a89aEEiLpKsjLAmfUQLuA3YecI4YWsYfenXa3Roe0X7+a+aV96FvjF96Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OTlW0bkS; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OTlW0bkS"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82c613194caso104279b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Apr 2026 14:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775077971; x=1775682771; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L2hTe6/qAASYky4w9/7qUWXPsVepZndGTLTeQA9+UIs=;
        b=OTlW0bkSqgXE3dUioitPbQH+plsaBZ2Chg8+LMd2AphjT17Hh0vJNM/3FIs6hwqvy/
         QZNs9UjTx4eu0fCMxYsJGHl6+nGSyfmh0lsJ0DCALvLbHZWQeXGQa6zSFk7ZThdbiIXq
         /iHQxC2gB3MfUX5lRYZgOODK9wBkbE6ROnps/4dsAvi2Gx+eeFWFPiJyCKRPOBz2hiWq
         BpcqGomwu97z8uRjDAj8Cc45bFWazhyJIU6bzSeZXciP4Ow/EZiyjOUi6rWkKZpSg63l
         x12criIchU7LN1wnFnOR6DoGeODlHGiK78ChIaD7NpTdFYc/A6GowR+n/2/KV8swr6+j
         xiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775077971; x=1775682771;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2hTe6/qAASYky4w9/7qUWXPsVepZndGTLTeQA9+UIs=;
        b=G+gt+izm2EfVyvJoxeZcOZ6wegv1/tMKwNLxM6ehVG6eq5m8FFi1zk0KsfHC63kxXI
         zhmstfyDIQZ+EEyjUhh1emROyLdkmIw2pWAU2ViLC5xIKTs0W41XkqiER/LqFEdGNfqd
         q+QES+YUnmk7jOQI8E6n69yCH3RLayYUZR1MugqbK44TPUC6eMqeoQ/1RDIPDjQ/PpjS
         7mlvC3PbDqpbGbOK1PwZkSboVCf5Op3NvnCzrMpdMS8Ab5e3IlaozoFt/d68CwPjOrfs
         We9fqghkDtyP0kPcV1jEokkNxeC51AEgqtB/rwWFxsupG9HFVZeqkNEbMOQUris5sP2z
         LY9A==
X-Forwarded-Encrypted: i=1; AJvYcCXnhtWM8506lOdgb6IEH3FcnEH/cpPDqma7VpyfzzbataN77NFqXBOyq8gDHDfQ06swXKMucuYBqq6Lu+XlF0lEWHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd2tHuhsHVNu2HflhFZUm5Bb9WoCEjGVJOWQ4HIOrOIFMLKVYE
	yfHZmRB2S2fzv4tPKn4S+YFLBQROHXBv/rHJKgDb1f3g94pxrW/o9fAnYnF00gQhcV17zWNy9mT
	WW3Gx1g==
X-Received: from pfbhw14.prod.google.com ([2002:a05:6a00:890e:b0:82a:ff5:27be])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:84d:b0:82a:fc5:fb81
 with SMTP id d2e1a72fcca58-82ce88c3336mr5445243b3a.5.1775077970623; Wed, 01
 Apr 2026 14:12:50 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:12:49 -0700
In-Reply-To: <2r4mmfiuisw26qymahnbh2oxqkkrywqev477kc4rlkcyx7tels@c7ple7kdgpo3>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
 <20260326-gmem-inplace-conversion-v4-10-e202fe950ffd@google.com> <2r4mmfiuisw26qymahnbh2oxqkkrywqev477kc4rlkcyx7tels@c7ple7kdgpo3>
Message-ID: <ac2KUaWxpVxmfUtY@google.com>
Subject: Re: [PATCH RFC v4 10/44] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: Ackerley Tng <ackerleytng@google.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, ira.weiny@intel.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 01, 2026, Michael Roth wrote:
> On Thu, Mar 26, 2026 at 03:24:19PM -0700, Ackerley Tng wrote:
> >  #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> >  static unsigned long kvm_get_vm_memory_attributes(struct kvm *kvm, gfn_t gfn)
> >  {
> > @@ -2635,6 +2625,8 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
> >  		return -EINVAL;
> >  	if (!PAGE_ALIGNED(attrs->address) || !PAGE_ALIGNED(attrs->size))
> >  		return -EINVAL;
> > +	if (attrs->error_offset)
> > +		return -EINVAL;
> >  	for (i = 0; i < ARRAY_SIZE(attrs->reserved); i++) {
> >  		if (attrs->reserved[i])
> >  			return -EINVAL;
> > @@ -4983,6 +4975,11 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
> >  		return 1;
> >  	case KVM_CAP_GUEST_MEMFD_FLAGS:
> >  		return kvm_gmem_get_supported_flags(kvm);
> > +	case KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES:
> > +		if (vm_memory_attributes)
> > +			return 0;
> > +
> > +		return kvm_supported_mem_attributes(kvm);
> 
> Based on the discussion from the PUCK call this morning, it sounds like it
> would be a good idea to limit kvm_supported_mem_attributes() to only
> reporting KVM_MEMORY_ATTRIBUTE_PRIVATE if the underlying CoCo
> implementation has all the necessary enablement to support in-place
> conversion via guest_memfd. In the case of SNP, there is a
> documentation/parameter check in snp_launch_update() that needs to be
> relaxed in order for userspace to be able to pass in a NULL 'src'
> parameter (since, for in-place conversion, it would be initialized in place
> as shared memory prior to the call, since by the time kvm_gmem_poulate()
> it will have been set to private and therefore cannot be faulted in via
> GUP (and if it could, we'd be unecessarily copying the src back on top
> of itself since src/dst are the same).
> 
> So maybe there should be an arch hook to check a whitelist of VM types
> that support KVM_MEMORY_ATTRIBUTE_PRIVATE when vm_memory_attributes=0,
> and if we decide to enable it for SNP as part of this series you could
> include the 1-2 patches needed there, or I could enable the SNP support
> separately as a small series and I guess that would then become a prereq
> for the SNP self-tests?

If it's trivial-ish, my preference would be to include SNP as part of this series,
_before_ KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES is exposed to userspace.  I think
that would avoid the need for pivoting on the VM type?  I.e. don't advertise
support until all VM types play nice.

> Not sure if additional enablement is needed for TDX or not before
> KVM_MEMORY_ATTRIBUTE_PRIVATE would be advertised, but similar
> considerations there.
