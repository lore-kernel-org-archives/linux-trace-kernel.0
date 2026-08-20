Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA351F09AD
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Aug 2026 00:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787187056; cv=none; b=RxBiyGsHOwxIDYs6MgrYA5abEU17vD5SYNgaDYWKMM1aTCUSPQRvBbIr+ywx+n2DcRaVFKNB7qM55F737T7sgGWEH/Ryyn+g8nJLADw+kmTe34dniVmKaAPrNCEv1vejy0fp2NxG2iZ4Jmad8b9WzVfemeBD4V3FhAx3k8WWdgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787187056; c=relaxed/simple;
	bh=TE/HKcGQjHB6nV6Ri5aq4h/uJG1E970OIzgK0+7AObE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J/O94aXzZV9PimK+mGk/ZnJgk+7o7qqRdY1Ek83GGT14ELwQuKDuaxfeiqPjI1lah5T6EfJBDxUX+jAFnPULO2QPisDISN9QLvOeAmGPwN44iO7S8QlxmvUPF8rSerlLicunGFDuqWp+o2iIVb5HbKZjO35vxnQVtyVeA6ZRhdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OkVdO9uY; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OkVdO9uY"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d004f13426so23572745ad.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Aug 2026 17:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787187054; x=1787791854; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WeiRdUabSD1784CoNk4W8kzu7y18u8HhbtUkTWVxO9k=;
        b=OkVdO9uYnJB7WXn0GhsabkN5WWxIjhNz/cfyOALTaHD5jKWWOsg6CdTjzydtCNi6KK
         OELLqjLttpnqXzjUikkhvn89klKceHcH2dRrknRN4/SLkivGMmeVZp7DkVKoyFZiW/8d
         rlyfaIrGap4aY1GiJwumWw8m5ytQq6+fgrAukZUrcnHSJ5hWvsCnrNqRucw4onzjSMLV
         lWRxVKO9+Y3sS4YCf6M9yf58Vb6vyExsG+AEMC0qUl28MbpdQNH9c/0mYcV3DpHxp2wU
         dpMH4J04Kkxx7kutefnz2RI7wFdPkpo6Ft1Gcxd1d7YwbusypAayZmgNh2aJss2+/Un7
         hgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787187054; x=1787791854;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WeiRdUabSD1784CoNk4W8kzu7y18u8HhbtUkTWVxO9k=;
        b=hhchCo5boZqIKy4ojG4yX98ohh/vLy+7Se7fxzVYU6oEMWU+Px55L2mulbMJnn7hpu
         ZPPEecsHSkQ41f5EiSULz5LdFs0FHQtoN2SiOM8ED9FcP5o5KfjDwpwQ3D3+rompgJ6d
         gmomUmwEpmLdZChdyCr9vwlWR5pgL60eRg3N0E4eVqz9eb7VU+H0yeYDCsxO20iu/s+P
         aZjGSYSgO+RL55+j8xZiTB6m8zaQtuJMSmhVb4Lbu7EkBp2yuDqMNNsFI0ceQzsFWWvl
         mEZAa+yd7RZzztJ4T/VAl+DkUAxEry7rFzO7iD6GpI9co3TUFK6KYsHmlkGHHUUwosk7
         ZESg==
X-Forwarded-Encrypted: i=1; AHgh+RrVjiO5Xr4oUC6uOUx7c+7A8nUK2g0fDIclYhj+15brrnxarruUVfJK7+l55y+WrmNvbJx2MDZdZoiIpAJBj9QWX1k=@vger.kernel.org
X-Gm-Message-State: AFuF++nIuTZN99NOhaR9xnx/OTSm9ief6RcyrBtCBOPNljiYOXZAl3u6
	vYShv6d/WBUQ/+wdeZQvGDcFcOZR7/dmrlQhWDeHW2pPYPPo3DeFynl36lzLuBn4TuwxOcqaXty
	ICRMgDg==
X-Received: from plbke14.prod.google.com ([2002:a17:903:340e:b0:2d0:de7f:1ccb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f687:b0:2d3:2e86:647a
 with SMTP id d9443c01a7336-2d5fd6b24camr145291955ad.5.1787187053833; Wed, 19
 Aug 2026 17:50:53 -0700 (PDT)
Date: Wed, 19 Aug 2026 17:50:53 -0700
In-Reply-To: <CAEvNRgFd-6-QxR7w8SxPRa0UU+AAF7pDupLP8cPbQ9y3m=2QVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-7-2fc18ee6d3ba@google.com>
 <ed483d25-d908-4248-b8c7-862dd35dc6d4@kernel.org> <annnrGR1noVuBkCc@google.com>
 <cc44c9d7-a6cd-40a5-9f68-4822fb9c9d0c@intel.com> <CAEvNRgFd-6-QxR7w8SxPRa0UU+AAF7pDupLP8cPbQ9y3m=2QVw@mail.gmail.com>
Message-ID: <aoZPbZZx2UVGZ-D1@google.com>
Subject: Re: [PATCH v10 07/41] KVM: guest_memfd: Stub in ability to enable
 in-place shared<=>private conversion
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, "David Hildenbrand (Arm)" <david@kernel.org>, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, jmattson@google.com, jthoughton@google.com, 
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 13, 2026, Ackerley Tng wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
> > On 8/10/2026 11:01 PM, Sean Christopherson wrote:
> >>> As mentioned in v9, the name is confusing.
> >>>
> >>> 	kvm_gmem_mem_is_private
> >>>
> >>> ?
> >> Ya, +1 to kvm_gmem_mem_is_private.
> >
> > So kvm_gmem_mem_is_private() calls kvm_gmem_is_private_mem()
> > internallly. Ummmm.
> 
> How about
> 
>   kvm_gmem_mem_is_private(kvm, gfn)
>   __gmem_mem_is_private(inode, index)  <== this is a static function
>                                            anyway, though it calls
>                                            kvm_gmem_get_attributes(inode, entry)

Hmm, what if we do:

	kvm_gmem_is_private_gfn(kvm, gfn)
	kvm_gmem_is_private_mem(inode, index)
	
And then to be consistent with the non-gmem code, slot in the rename you suggest
below:

  KVM: Rename memory attribute APIs to prepare for in-place gmem conversion
  <rename kvm_mem_is_private() => kvm_is_private_gfn()>
  KVM: Provide generic interface for checking memory private/shared status

I would also be a-ok with:

	kvm_gmem_is_private_mem(kvm, gfn)
	__kvm_gmem_is_private_mem(inode, index);

along with a kvm_mem_is_private() => kvm_is_private_mem() rename, though the more
I look at this, the more I prefer scoping the external API to a gfn.  Especially
for the guest_memfd code, where KVM needs to query shared vs. private without a
gfn.

I don't love kvm_gmem_mem_is_private(), it looks like a typo (though as above, I
do like it more than kvm_gmem_is_private()).

> or
> 
>   kvm_gmem_gfn_is_private(kvm, gfn)
>   kvm_gmem_is_private_mem(inode, index)
> 
>   (rename the vm stuff with the suffix gfn_is_private())
> 
> or (current, it is actually weird)
> 
>   kvm_gmem_mem_is_private(kvm, gfn)
>   kvm_gmem_is_private_mem(inode, index)
> 
> or
> 
>   kvm_gmem_mem_is_private(kvm, gfn)
>   kvm_gmem_index_is_private(inode, index)
