Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F5B244687
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Jan 2026 00:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769647078; cv=none; b=ld7GHzsxcyHFj2i2SKPu6QhuaKVLt42jYLW1eTe5oPzJuJ60Yr0gYZMkc1nKwBbtpe+QjwYpw+4Q281tTw/YjdYoNRSagQC3jwnlbK3Lj177g5rh/9nEifiZ7so6apG972/z+XSdxRBlrq+t4iibfKqCCHFgzjbobeAwohlSZKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769647078; c=relaxed/simple;
	bh=tXNj0V0FG3jDHp0sl6ptuF//zDhb0DbdK89SgU01AH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaU3JNLIe3dWx6ToHTfW8gbKIJQ5AUks60DpF8Qgn1isaY+7fTGGBxOoGiwPr06DS9fcsTKSgYTA/BfQxUfN0pnHmtD7sn/mZcsnLlCnGBpF21cQscxbom8ooOh+ByMi9IgfghFisT3a7SPl0iBC0vYa8BAxvOtAXppmlH7h3rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=k3z974Mo; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="k3z974Mo"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c7146b0854so51156485a.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Jan 2026 16:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769647075; x=1770251875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1OWzBPKnyrz01i64zQ4S/hZaAIPcGy0JKcdMQLZXMgA=;
        b=k3z974MoBekrskW+4yDuSvtzoUeR4tzTJU2yvyD4rQigVuBdm4BzN3Xg8Zzela1ij1
         PtIBJOHG+48zicSasaJj88LsAp9Idss6arEvECeDPDvI1+/bGMecOxg2xZIYwnFVlh0e
         N0DvTFOVBrdLgm2SKMS+gRiwkBiRJcJWUntisKKjBYWClnHFRtNhDwWc+rSNwr+1UjqW
         hx681JKT5lyNNWCAUjt1BcDoxqd1Xi1LEySTm+fAhUY0zEB5n4V31HSnaVxU+vLpaw6P
         OslVl70bntspz23oY0Aox/yOyL0R7Sg8jXzzls2Zxn0sc+rXC4pcAybAV0qWKdtqzTn8
         u/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769647075; x=1770251875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OWzBPKnyrz01i64zQ4S/hZaAIPcGy0JKcdMQLZXMgA=;
        b=Swpd8PBdydUvNX7vt6lfldt7dSlI4RcScyBaeJh4c8/hcjNeG8ZEaxHiB4fyjLXaXQ
         WqOWCeealXk5MQmwrHwrUinzFK1msxgGIpmwwmFsWnBb9Xun41SjGys2qS6FC6LSVkOA
         aAeJAHN6KD5gwaCu9WgNougxERw2rDc5iWi76cNSbbRoC/0iSFv3MjQ5NavOBccWLrsg
         ovCXd1aidXjrq/GmDiwuanwhC5zhc2OlfGwPeKS8B+wB5FKg6Z2qEhhqwKN6IMxDJFP3
         goXDmPtVccm/RU9YEEIqzPpeRgAZTy0au6I4rB+S9qWF7+OP3CKnQvwKkyNrauo2v/aI
         qW3w==
X-Forwarded-Encrypted: i=1; AJvYcCWa12ccATvJHfwm+fxNgr3GE+MPQDiAm+IZOcMHb5IqaJ7jb1iST0vrrw1ceHjRce8vREflF08ElEhWkBtntvp/ioc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx4TGL5FTkbqrO8MuuBZY1HaizhSDZIo759es0eXIlje8x2FqA
	E0LgAXbEk7rTHa2Rhc0dUJQMScAI9wj3xMXdxi/tl+gjDlUrYwkads2gzpYNOHMrniQ=
X-Gm-Gg: AZuq6aKXanrOahUhrvov+1Z1tmUDQEvUSFSj9jIG6Ekk/ChAvUTXFJmo8Qndz1rkWDR
	limdpEuM0yx6od+Ik5sr3pfpKa+3jqGoXWGZcNmuXG8aAbqJ3zYZA+9pn/92gs/nI0Y9LN1rY5w
	z9abHfWYHviq902keG2nYuhdF3UuXfbKjRdw17aqQW5ONtgLbHD0+nbsn65uJ/zSKA8WNtwDzu7
	7cQl5OnVA3GA9Edk2G97MRvaHiYpPBgwbl4K2rHWgIbINW/sSVcT7Pr2Z0SC/YOG4wsWyk0w3pt
	FBG43+qdcW2tKyRGMa8cXf6qdOA6JYLFJmYuVQ/Fn2YA+1Xs1y8tccj46BJVr3LKpmseZl5+Bnv
	xdq+Wh76xE6mD3S1m5dit1+yXekd205JPli8RfUSEoZj+2/cxqQV6puxpoua0zeug6NnxyNjJrQ
	rA6cA6n/PjEjIB3Y2RpyeDJuhcnonKPJi2t4beXoJvjmu9E/2Chsp6bjM/4ff9tYcW6Jo=
X-Received: by 2002:ae9:c202:0:b0:8c7:126e:e901 with SMTP id af79cd13be357-8c7126eeb1amr465687985a.22.1769647074488;
        Wed, 28 Jan 2026 16:37:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d29aa2sm294243485a.35.2026.01.28.16.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 16:37:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vlG2j-00000009g5p-04Lm;
	Wed, 28 Jan 2026 20:37:53 -0400
Date: Wed, 28 Jan 2026 20:37:53 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, cgroups@vger.kernel.org,
	kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	akpm@linux-foundation.org, binbin.wu@linux.intel.com, bp@alien8.de,
	brauner@kernel.org, chao.p.peng@intel.com, chenhuacai@kernel.org,
	corbet@lwn.net, dave.hansen@intel.com, dave.hansen@linux.intel.com,
	david@redhat.com, dmatlack@google.com, erdemaktas@google.com,
	fan.du@intel.com, fvdl@google.com, haibo1.xu@intel.com,
	hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com,
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com,
	jack@suse.cz, james.morse@arm.com, jarkko@kernel.org,
	jgowans@amazon.com, jhubbard@nvidia.com, jroedel@suse.de,
	jthoughton@google.com, jun.miao@intel.com, kai.huang@intel.com,
	keirf@google.com, kent.overstreet@linux.dev,
	liam.merwick@oracle.com, maciej.wieczor-retman@intel.com,
	mail@maciej.szmigiero.name, maobibo@loongson.cn,
	mathieu.desnoyers@efficios.com, maz@kernel.org, mhiramat@kernel.org,
	mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com,
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au,
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es,
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com,
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com,
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz,
	qperret@google.com, richard.weiyang@gmail.com,
	rick.p.edgecombe@intel.com, rientjes@google.com,
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org,
	seanjc@google.com, shakeel.butt@linux.dev, shuah@kernel.org,
	steven.price@arm.com, steven.sistare@oracle.com,
	suzuki.poulose@arm.com, tabba@google.com, tglx@linutronix.de,
	thomas.lendacky@amd.com, vannapurve@google.com, vbabka@suse.cz,
	viro@zeniv.linux.org.uk, vkuznets@redhat.com, wei.w.wang@intel.com,
	will@kernel.org, willy@infradead.org, wyihan@google.com,
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com,
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Subject: Re: [RFC PATCH v1 05/37] KVM: guest_memfd: Wire up
 kvm_get_memory_attributes() to per-gmem attributes
Message-ID: <20260129003753.GZ1641016@ziepe.ca>
References: <cover.1760731772.git.ackerleytng@google.com>
 <071a3c6603809186e914fe5fed939edee4e11988.1760731772.git.ackerleytng@google.com>
 <07836b1d-d0d8-40f2-8f7b-7805beca31d0@amd.com>
 <CAEvNRgEuez=JbArRf2SApLAL0usv5-Q6q=nBPOFMHrHGaKAtMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEvNRgEuez=JbArRf2SApLAL0usv5-Q6q=nBPOFMHrHGaKAtMw@mail.gmail.com>

On Wed, Jan 28, 2026 at 01:47:50PM -0800, Ackerley Tng wrote:
> Alexey Kardashevskiy <aik@amd.com> writes:
> 
> >
> > [...snip...]
> >
> >
> 
> Thanks for bringing this up!
> 
> > I am trying to make it work with TEE-IO where fd of VFIO MMIO is a dmabuf fd while the rest (guest RAM) is gmemfd. The above suggests that if there is gmemfd - then the memory attributes are handled by gmemfd which is... expected?
> >
> 
> I think this is not expected.
> 
> IIUC MMIO guest physical addresses don't have an associated memslot, but
> if you managed to get to that line in kvm_gmem_get_memory_attributes(),
> then there is an associated memslot (slot != NULL)?

I think they should have a memslot, shouldn't they? I imagine creating
a memslot from a FD and the FD can be memfd, guestmemfd, dmabuf, etc,
etc ?

> Either way, guest_memfd shouldn't store attributes for guest physical
> addresses that don't belong to some guest_memfd memslot.
> 
> I think we need a broader discussion for this on where to store memory
> attributes for MMIO addresses.
> 
> I think we should at least have line of sight to storing memory
> attributes for MMIO addresses, in case we want to design something else,
> since we're putting vm_memory_attributes on a deprecation path with this
> series.

I don't know where you want to store them in KVM long term, but they
need to come from the dmabuf itself (probably via a struct
p2pdma_provider) and currently it is OK to assume all DMABUFs are
uncachable MMIO that is safe for the VM to convert into "write
combining" (eg Normal-NC on ARM)

Jason

