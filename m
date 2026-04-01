Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112CD3939BA
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Apr 2026 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775077500; cv=none; b=YyVueprq9LIjsrptP+x97fC3v7QlTE43ky5KrODXK04AI2Ic4qSmSq3hHW5RtUdhtMX9/E+zyNdzQqMDNq6YgfEeoq0s1qbS5P+Cb4Ce/94GysSF/KC67rGQNK2HNkML3uIr7SuIpa8LQqNAzEA0WABZN4fqGKMRYzDngEISBx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775077500; c=relaxed/simple;
	bh=nKoM68jymx43xt6viB2FGyBTxfjzpi8jc7eXGmyt4Vw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gG6YUBadAaZ0OU/d/It66PhF4sgooVEcB2/t7NiMYBAHNj4vxY9yLuGYzKui77pvnwwrUU7UxMKFFgTsOBYFRzoCY7tO2Q5rIKLCte06tKDksIAGfudJXu7AfinyB+dZctzhmtss4AmmDoD9Wq3YuyFTqqez79OQBUdkcpPXefE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qWOh+Jiq; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qWOh+Jiq"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b2489af602so1125505ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Apr 2026 14:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775077498; x=1775682298; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2G9uSQqW1t77mVxoAaIkc05+KXCw20NeU1W0ypS1GQ=;
        b=qWOh+JiqtqWNw2VFOt9n9NXE+60ueErcIVNA0FmQzkZp4PTa7PBIFksiMndKSIT58y
         vtK/FXvcOzEBMKtAZWEdNOnzouiRW8fDJg7V7lb70WU1O3QKW/6DYSwxM8JmOMKzQhAW
         w5XBQTEnuOwNEhx5gd3QKb8aE7P7i4lJDWEI3ynUqWP8lbuUNK+IVsgr7WcsH74nU8CU
         JBAde1z6Z1Z+qQvpBTdqOuIzljIS5cO1zYyhZuY2j2bW2jJL74dPyOiU7ZoVdn+qGDSh
         0AhBdJ9XKXS9D/QYWakz11lo0ol/T1WykuXAhJisaejbIjXkN0Sv9fF/tMiMBqnEKBPD
         Snmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775077498; x=1775682298;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2G9uSQqW1t77mVxoAaIkc05+KXCw20NeU1W0ypS1GQ=;
        b=VkbB2V6KAlvC8hyi3LkxExyGRrljETUxbKXKZYS3d3GNVLU25OyL8uC/3kZHe0O8fU
         k2zCuZJE8vi5gfZTR9HDD0NE+rT7Q1URWBnuG7m+rn6smtSjDbL7WdhfULC5fF+htAIq
         KVB+/hkuITK4KtA3NKbpZNjIkgdjk9k6brl679SpziKGidP6kf5rBbqp0rntew/n++jS
         nb3viAmBZQlJmKzddvqpI1FX6eONXMti1h3uiIbmI5fHhza1ys7xYy8gzML1NAmQOBbG
         M04Xc+Nt99KUadjYMfL7N77bvmVKqqQz1nhqMp3YPfwo5lkBp5O0Qp9WZRlK5xuxJgnI
         /MYg==
X-Forwarded-Encrypted: i=1; AJvYcCVPAcrZ8a9lD4RtEX7zYOUVYQMXVf/y5QGbj2sWAW5vmEwjKM2wYEq2MhY//URG642KqjkUGCH1ZmbH2T0JN1sF/RU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH39zdHlOZGPkVsFtQgvDcqA0RNIQZGrwbO2m8i+hM/QFuJ3hB
	V6nWVYsmmhsj09S0+Y0i80d0eOdOBb2Axdz/KKpysk0WJ5DJQkjog06Xcy34nM+zpoiHQvxEBw1
	xafoLWA==
X-Received: from plhk15.prod.google.com ([2002:a17:902:d58f:b0:2b0:6c44:fc55])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c48:b0:2b2:4f43:b49a
 with SMTP id d9443c01a7336-2b2698a1054mr47624785ad.22.1775077498214; Wed, 01
 Apr 2026 14:04:58 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:04:56 -0700
In-Reply-To: <cxmtst7txfodp6lo4ipue3trohx2ge7nkagkfzfixfdnlf5qlo@e3jw3tmbe272>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
 <20260326-gmem-inplace-conversion-v4-8-e202fe950ffd@google.com> <cxmtst7txfodp6lo4ipue3trohx2ge7nkagkfzfixfdnlf5qlo@e3jw3tmbe272>
Message-ID: <ac2IeJNrrBuKtYn2@google.com>
Subject: Re: [PATCH RFC v4 08/44] KVM: Introduce KVM_SET_MEMORY_ATTRIBUTES2
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

On Tue, Mar 31, 2026, Michael Roth wrote:
> On Thu, Mar 26, 2026 at 03:24:17PM -0700, Ackerley Tng wrote:
> > Introduce a "version 2" of KVM_SET_MEMORY_ATTRIBUTES to support returning
> > information back to userspace.
> 
> Hi Ackerley,
> 
> Not trying to bikeshed below, but I'm working on getting related QEMU
> patches cleaned up to post soon and was working through some of the new
> uAPI bits, and plumbing some of these capabilities in seems a little
> awkward in a couple places so wondering if we should revisit how some of
> this API is defined...
> 
> > 
> > This new ioctl and structure will, in a later patch, be shared as a
> > guest_memfd ioctl, where the padding in the new kvm_memory_attributes2
> > structure will be for writing the response from the guest_memfd ioctl to
> > userspace.
> > 
> > A new ioctl is necessary for these reasons:
> > 
> > 1. KVM_SET_MEMORY_ATTRIBUTES is currently a write-only ioctl and does not
> >    allow userspace to read fields. There's nothing in code (yet?) that
> >    validates this, but using _IOWR for consistency would be prudent.
> > 
> > 2. KVM_SET_MEMORY_ATTRIBUTES, when used as a guest_memfd ioctl, will need
> >    an additional field to provide userspace with more error details.
> > 
> > Alternatively, a completely new ioctl could be defined, unrelated to
> > KVM_SET_MEMORY_ATTRIBUTES, but using the same ioctl number and struct for
> > the vm and guest_memfd ioctls streamlines the interface for userspace. In
> > addition, any memory attributes, implemented on the vm or guest_memfd
> > ioctl, can be easily shared with the other.
> > 
> > Add KVM_CAP_MEMORY_ATTRIBUTES2 to indicate that struct
> > kvm_memory_attributes2 exists and can be used either with
> > KVM_SET_MEMORY_ATTRIBUTES2 via the vm or guest_memfd ioctl.
> 
> The guest_memfd support for the KVM_SET_MEMORY_ATTRIBUTES2 ioctl isn't
> added until patch #10, and to scan for it you sort of need to infer it
> via KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES reporting non-zero (i.e.
> KVM_MEMORY_ATTRIBUTE_PRIVATE), so it's confusing to state that
> KVM_CAP_MEMORY_ATTRIBUTES2 means you can use the struct via a guest_memfd
> ioctl.
> 
> I think the above is trying to simply say that the corresponding struct
> exists, and remain agnostic about how it can be used. But if that were
> the case, there would be no way to know when KVM_SET_MEMORY_ATTRIBUTES2 is
> available in the first place, so in the case of KVM ioctls at least,
> KVM_CAP_MEMORY_ATTRIBUTES2 is advertising both the struct and the ioctl,
> whereas for guest_memfd it's only advertising the struct and not saying
> anything about whether a similar gmem ioctl is available to use it.

+1 to everything Mike said.

> Instead, maybe they should both have the same semantics:
> 
>   KVM_CAP_MEMORY_ATTRIBUTES2: *SET_ATTRIBUTES* ioctl exists for KVM that utilizes
>     struct kvm_memory_attributes2
> 
>   KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES: *SET_ATTRIBUTES* ioctl exists for
>     guest_memfd that utilizes struct kvm_memory_attributes2
> 
> In which case you would leave out any mention of guest_memfd here as far as
> the documentation does, and then in patch #10 you could modify it to be
> something like:
> 
>    4.145 KVM_SET_MEMORY_ATTRIBUTES2
>    ---------------------------------
> 
>   -:Capability: KVM_CAP_MEMORY_ATTRIBUTES2
>   +:Capability: KVM_CAP_MEMORY_ATTRIBUTES2, KVM_GUEST_MEMFD_CAP_MEMORY_ATTRIBUTES
>   -:Architectures: x86
>   +:Architectures: all
>   -:Type: vm ioctl
>   +:Type: vm, guest_memfd ioctl
>    :Parameters: struct kvm_memory_attributes2 (in/out)
>    :Returns: 0 on success, <0 on error

As discussed at PUCK, I think we should omit KVM_CAP_MEMORY_ATTRIBUTES2 and
vm-scoped support entirely until it's needed (which may be never).

> and *then* add in your mentions of how the usage/fields differ for
> guest_memfd/KVM_GUEST_MEMFD_CAP_MEMORY_ATTRIBUTES case vs. KVM ioctls.
> 
> This avoids needing to issue 2 checks for the guest_memfd variant vs. 1
> for KVM, but more importantly avoids subtle differences in how these
> similarly-named capabilities are used/documented that might cause
> unecessary confusion.
