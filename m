Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5891799F
	for <linux-trace-kernel@vger.kernel.org>; Sat, 15 Nov 2025 00:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763167979; cv=none; b=VdY98ZTSkvpKqPMIl3LNMd2qoOikWcqa/ZOKtRwnRrDxF5D14M5VboCyTj1Sc5kIbMFkemnp4SVdaxKDho34e5D7b++hjicrcc/JGbc4ri8eorbZhT6g7NdEnBpZqIY5RlgEwGr2/3QfzAp4OPMXSQj2ZvMRuU14fFOxGHlOm0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763167979; c=relaxed/simple;
	bh=Zt6gL3AszafFvMRDqHPmrtZZuuPTg89Q67zHxC/2ZRw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UvRjH/kEkr17GeLazUgG5dkd/umrAkmxGMshPFVlg1VbfhDrAB1/CcNwGPP57RmG3sarHFS3XYPlInWx5Psdwxoiw+vOIXjFa4S3NtVHPQj3Qxb1A3BRWBwOVhnEaug3bloDTrxMYq/ZN6KHN8v8OB6KqjaA8ZRbguVCpighyRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KssO1vHO; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KssO1vHO"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-343e17d7ed5so2773268a91.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Nov 2025 16:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763167977; x=1763772777; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U9SSTkCfK9gXlKFXxpFitF3UmgPFfqReOkQFg2JXAv8=;
        b=KssO1vHOaxB0iZyyyzHkQoFSFHxdym+y7nD/4/2IFsnqBdOnGAozASkzlk5qsBgw7C
         RmwOUA2hlrauPMZU7y6qzvx3oH0nQVwyOlRR4dtHb1DGJfxa74mWSDvQSd0nP99OM541
         y/AObdqYNBmYLifTZK6m5T7SmHFHkoBjSjsXqhOo/rmxZ/IY5FU9xUOB5GYqa30liK8j
         qWlYplMet9f7a+DBMVbcOUqGavFSUEGKdH/uzLku8KWKCBfIEITxraeKpX8bC8M+Gwpe
         DmAWLVCjttbF2v0+6J5rGWFaQZyIjxhd0y3hI0YRIWLu87TVdDpUH835MdkjPQfQJzbA
         E5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763167977; x=1763772777;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9SSTkCfK9gXlKFXxpFitF3UmgPFfqReOkQFg2JXAv8=;
        b=ioilvak/intfzRUuFcQH5D7K08bbj9ZED3KpAMEH/46yvin2VthFHQHzoId7jIPyAg
         9BBxfYjC+ThSsH0RO4WOxXsc8eRCoF/9shI+HwcUjgUqtkWcEB2zEgYhQkqOspnTWRPE
         xh6YttPEmBt88bKQzLPlSQt8XvPJJ7mMVDj2VFY3D2AOG7YruypCQjNq3dy9ImBIjB75
         /vg52u6M/k5ha6zavsJWW/khmEDyZgwEKR1Fc3dwwGd9330JO6smzQq1+Z+kXDdS6I32
         VfK2K/WnefIoZ5sQLOr//KEBeAmN8xnC9JRimKOyt7F4jcoHqwENVq+1vRrAn9pVgTox
         oPIA==
X-Forwarded-Encrypted: i=1; AJvYcCWXJo6G3PmbZL6mPvrqkv28BCklLZKx5AhpxA/jpe4bekeR7ZjNCEemE3LQCBRXoyMiqSFueIHouJ/3/uvH4dkfcKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5PCMgCett6cdLnuI86v0rw7AA9xzKQiQ0iOm4oyIJ48hoA2Qp
	+LQ4KT2YFJbthEH/oKDShKdX8obOVx9NBfaJRxUsDv0YjF1Wco/SlCaNBk9nHocUiXjQag3SoCX
	81aFM2dWc5XHRp0x7utbqPAJyqA==
X-Google-Smtp-Source: AGHT+IFQ6ztt0EQFHe4KI+3WuxtLaazXI8OcEuS0OZM8dxl+4bnHUaopiO2H4ku8y1VZu9JaoG1ZZurdE58bMYL0dA==
X-Received: from pjbpm10.prod.google.com ([2002:a17:90b:3c4a:b0:340:a9b3:320c])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c89:b0:339:cece:a99 with SMTP id 98e67ed59e1d1-343f9eb3128mr5188244a91.13.1763167977228;
 Fri, 14 Nov 2025 16:52:57 -0800 (PST)
Date: Fri, 14 Nov 2025 16:52:55 -0800
In-Reply-To: <aRG35j3OhMvQo85n@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com> <a3795f7fb4f785ced19abe18c2f33aa478c4d202.1760731772.git.ackerleytng@google.com>
 <aRG35j3OhMvQo85n@yzhao56-desk.sh.intel.com>
Message-ID: <diqzzf8oazh4.fsf@google.com>
Subject: Re: [RFC PATCH v1 06/37] KVM: guest_memfd: Update kvm_gmem_populate()
 to use gmem attributes
From: Ackerley Tng <ackerleytng@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, akpm@linux-foundation.org, 
	binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, david@redhat.com, 
	dmatlack@google.com, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	haibo1.xu@intel.com, hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com, 
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	liam.merwick@oracle.com, maciej.wieczor-retman@intel.com, 
	mail@maciej.szmigiero.name, maobibo@loongson.cn, 
	mathieu.desnoyers@efficios.com, maz@kernel.org, mhiramat@kernel.org, 
	mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, mingo@redhat.com, 
	mlevitsk@redhat.com, mpe@ellerman.id.au, muchun.song@linux.dev, 
	nikunj@amd.com, nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com, 
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com, 
	peterx@redhat.com, pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, 
	qperret@google.com, richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, rostedt@goodmis.org, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shakeel.butt@linux.dev, shuah@kernel.org, 
	steven.price@arm.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, will@kernel.org, 
	willy@infradead.org, wyihan@google.com, xiaoyao.li@intel.com, 
	yilun.xu@intel.com, yuzenghui@huawei.com
Content-Type: text/plain; charset="UTF-8"

Yan Zhao <yan.y.zhao@intel.com> writes:

>>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
>> +static bool kvm_gmem_range_is_private(struct gmem_inode *gi, pgoff_t index,
>> +				      size_t nr_pages, struct kvm *kvm, gfn_t gfn)
>> +{
>> +	pgoff_t end = index + nr_pages - 1;
>> +	void *entry;
>> +
>> +	if (vm_memory_attributes)
>> +		return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
>> +						       KVM_MEMORY_ATTRIBUTE_PRIVATE,
>> +						       KVM_MEMORY_ATTRIBUTE_PRIVATE);
> Can't compile kvm_range_has_vm_memory_attributes() if
> CONFIG_KVM_VM_MEMORY_ATTRIBUTES is not set.

Thanks! I will fix this in the next revision.


We've been discussing HugeTLB support in the guest_memfd upstream calls
and I'd like to add a quick follow up here, with code, for anyone who
might be interested. Here's a WIP tree:

https://github.com/googleprodkernel/linux-cc/tree/wip-gmem-conversions-hugetlb-restructuring

This tree was based off kvm-next (as of 2025-10-08), and includes

+ Mmap fixes from Sean
+ NUMA mempolicy support from Shivank Garg (AMD)
+ Some cleanup patches from Sean
+ Conversion series [1] with some cleanups (Thanks for the comments and
  reviews on this series! Haven't had time to figure out all of it,
  addressed some first)
+ st_blocks fix for guest_memfd, which was discussed at the guest_memfd
  upstream call: slides [2]
+ HugeTLB support without conversion: this stage does not yet take into
  account comments from the upstream call. This stage provides support
  for HugeTLB to be used through guest_memfd for private memory. This
  has to be used with the KVM parameter vm_memory_attributes set to
  true. This stage can be used to test Yan's TDX huge page support by
  setting up guest_memfd with HugeTLB just for private memory, with
  shared memory being taken from elsewhere.
+ HugeTLB support with conversion and folio restructuring: this stage
  also does not take into account comments from the upstream call, so it
  still disables the INIT_SHARED flag, although HugeTLB can now be used
  with in-place conversion for both shared and private memory. This can
  be used to test Yan's TDX huge page support.

[1] https://lore.kernel.org/all/cover.1760731772.git.ackerleytng@google.com/T/
[2] https://lpc.events/event/18/contributions/1764/attachments/1409/3715/2025-10-30%20guest_memfd%20upstream%20call_%20guest_memfd%20HugeTLB%20support%20overview.pdf
