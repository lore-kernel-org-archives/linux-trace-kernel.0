Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788371FCF41
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jun 2026 00:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782174155; cv=none; b=lvui+AIKFNRysPOPlu1u94lRTej7BxIZajV7Y1NwqUfmNGs1xUVLqYXxdhRKN425QtPWneqwYFqv8tV0zCf8a3fptGCJVJe0XoESKAkGIJjzOwCbnwhmTBjr74m3KFx5hixqFO4iCvWOC7jSS0FvUwZp24zW2HBhyRcl2f7Ig9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782174155; c=relaxed/simple;
	bh=hET3RaJtC6ro7NYZPXmQUq8MQF1p6emzxm3gNcm+1IE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lghZ0zfGbh5GTmtZ551jyJTDi8WSAjjebVu7ZXHaLxxb1zF8pjRlziLUTSUQFL33l1H9VbdWMDzXBWxlEnP7WvMvFcpKhe88+MgJmX3KfhW4pnNDf/UJVnPsVO7UPgMjlv9+Ypner5Le/jYHb8mtRSITOsEt6kbWdpQm5/Eu+xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wllk+GYm; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wllk+GYm"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8423970cb30so3698875b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 17:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782174152; x=1782778952; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oQLsIF+iVXLuEt9X7AENLYAj3zuZSbHkrs731kL+O+A=;
        b=wllk+GYm+EcPaLMqRAaxpHRRtRZ0Q/IyHzUTSmFlbcacCXQtWC8B+jka/SO7+rasPH
         IvJZt3iJORGm6GWMR6ppQvXrCZYe3NODpAb1VHkl81ygp8TwuTBZFou0JKx0xy0S6Wbx
         eNIK4953Mv6nu4rmza73z6JWCn7kAP6qLAmMXDJbtRTJyDM2cRvT/+hbWdn8m8xbNg9e
         SxeYaXQLGAXn3a3n3XmBcFcUotqTGjnKAhRZBvfhW409OTYhcCKlOsmC9/caJ7GL0nRr
         beQe6huDjy2ytOl44Tof/kOk7zrPADRCETaCBu3kf95UGEA1UjnKfevPtUiQ6s9sCOor
         qgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782174152; x=1782778952;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQLsIF+iVXLuEt9X7AENLYAj3zuZSbHkrs731kL+O+A=;
        b=hbGOrPCw/IB5/ES9uUfqclxhU4Ku8MEjZj+jRSvwZQj4cu/0qLTfezfp+ldd5qiL77
         /jxVdJ9XRdmGrOgDBzvzyxa08mH3EDA5gR4wsZ4ezto6YhtX5DfSVpaK292u/xPtyDs2
         +1EE3lKoNQiatl4iO3E0WBIVCJU7xyO7wz2kx2mFVQ//H3cu4OdWDoeXW8l9ftFf16wl
         k8wE/GocXAvEGCL/TtWjHmwawYSPpqB4OjOwqp6xSCaVXqr8cPf2642HNSTuKjD3+NoH
         chPnjQW6otEQ+guD8rIBK8szr6+g5P35TVjGfejFbO2LqWzOEECUgu/QPc1/I1B18xmJ
         OKuw==
X-Forwarded-Encrypted: i=1; AFNElJ9Rb4QCGK31WHVjKQ+Uuo5AzYyoMI2y3sR2D2JTT6DhNrSEVAgYdGfkYHfC/mepICgbbBjIxxW1hWm8yztS7FJPnUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA86JO/WzwR+JHnrMYixqZ1WoiC9ZkdWDa4FUuZWMR6qLi48HC
	a5GeCTvKLsYmxyUyqxdmQVmdr6dfWqrStePLaqLgelPyuqM2XTm6lQUNWlRnsefk/jztakpI45X
	DqwHmwg==
X-Received: from pfbk14.prod.google.com ([2002:a05:6a00:b00e:b0:82f:8cba:4285])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:855:b0:842:3be7:4d55
 with SMTP id d2e1a72fcca58-84597094577mr199419b3a.11.1782174151143; Mon, 22
 Jun 2026 17:22:31 -0700 (PDT)
Date: Mon, 22 Jun 2026 17:22:30 -0700
In-Reply-To: <CA+EHjTx2xKjheiW5VzHw_TdWFUqdJqfgu=dOPa=_yaYBMY8uyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-13-9d2959357853@google.com> <CA+EHjTx2xKjheiW5VzHw_TdWFUqdJqfgu=dOPa=_yaYBMY8uyw@mail.gmail.com>
Message-ID: <ajnRxuJ19OzZ8zJC@google.com>
Subject: Re: [PATCH v8 13/46] KVM: guest_memfd: Add base support for KVM_SET_MEMORY_ATTRIBUTES2
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <tabba@google.com>
Cc: ackerleytng@google.com, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
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

On Fri, Jun 19, 2026, Fuad Tabba wrote:
> On Fri, 19 Jun 2026 at 01:31, Ackerley Tng via B4 Relay
> <devnull+ackerleytng.google.com@kernel.org> wrote:
> >
> > From: Ackerley Tng <ackerleytng@google.com>
> >
> > Introduce base support for KVM_SET_MEMORY_ATTRIBUTES2 in guest_memfd, which
> > just updates attributes tracked by guest_memfd.
> >
> > Validate input fields in general. Guard usage of KVM_SET_MEMORY_ATTRIBUTES2
> > by making sure requested attributes are supported for this instance of kvm.
> >
> > A new KVM_SET_MEMORY_ATTRIBUTES2 is defined to support writes (unlike
> > KVM_SET_MEMORY_ATTRIBUTES) in addition to reads so it can provide error
> > details to userspace. This will be used in a later patch.
> >
> > The two ioctls use their corresponding structs with no overlap, but
> > backward compatibility is baked in for future support of
> > KVM_SET_MEMORY_ATTRIBUTES2 and struct kvm_memory_attributes2 in the VM
> > ioctl.
> >
> > The process of setting memory attributes is set up such that the later half
> > will not fail due to allocation. Any necessary checks are performed before
> > the point of no return.
> >
> > Co-developed-by: Vishal Annapurve <vannapurve@google.com>
> > Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> > Co-developed-by: Sean Christoperson <seanjc@google.com>
> > Signed-off-by: Sean Christoperson <seanjc@google.com>
> > Reviewed-by: Fuad Tabba <tabba@google.com>
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> 
> Note sure if it's user error on my part, if I'm applying this to the
> wrong base, but I found a build break here on patch 13:
> kvm_gmem_invalidate_start() doesn't exist in the base tree. The
> function is kvm_gmem_invalidate_begin() here. The rename
> (190cc5370a8b6) landed via a different merge path and isn't an
> ancestor of the stated base.
> 
> Patches 19 and 20 have the same mismatch. Fix for all three is
> s/kvm_gmem_invalidate_start/kvm_gmem_invalidate_begin/.

Ya, Ackerley used a slightly older kvm/next to send the patches.  I at least was
testing against kvm-x86/next, which does have the rename.

Other than noting that this should be applied against the current kvm/next, I
don't think there's anything else to be done?
