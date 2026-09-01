Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4443F49B21C
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788287209; cv=none; b=VfKC7RsHly8pDiJIDCPzql0UJnWEYfpFxCy1+38SA92naa6igGKLMGKpjqnpOgWeqKcyX8J3glkWv1eNP+EqVjTHhQ4OLnhqQyXY1F5+5mawcdh9kQpDhJvhPGnELEdB9vlReugd9wwabgxVSjoDkEul3qOVZj93vh1AH0qsfc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788287209; c=relaxed/simple;
	bh=vz7vfk19Z+bqyE6zKwD5krwa/0p2VNqmkC4gZJtUZS4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=izyMS2fkKCwT3HCDHaTx7R1E7AoqBYEQ/HLxtLQQUd0Rxy5x5PsPMZu62cVazTXTxHsdWObtuZIUWUowwShsIIplIdZMRRh2W2gMPrQuSdocewGsFeF5TdrNQ42AON7aJ0vq21dgD6XsW5gJERiKrec6qUUdmsY7yItgXfHXcaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nxB8465w; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nxB8465w"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbb92868263so150897a12.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 11:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788287207; x=1788892007; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5v8dwO4qIccjpXs9ZdhBw1lluA5t2BNdQSYlylga9bQ=;
        b=nxB8465wd02jxyXSBEDLq4Idb0QJSWjaR0KxrjK2ITfpNGuKegdz1Pxa76jdytfIiw
         vYUIkwuZECZXAAw/H8tlVTN9/2hyvUIw7K4/dfIFKlWMzJj0OjpEfHayidTeqvIX1lik
         j686n8m+uMuii79vRA5CZ+1nW7KzMnQYulgg6tzwqzIOhGciNmX2N+CDq1xTc1SWbmYQ
         gh0doBDhGcEtYsePeLeaJtXCW17bN6xhNnW0ctQZlmikL9WyGNtiicLPFHmHRhoE38+5
         YU2YIJ6IF0SgyeoerLjvTX7NZDrLYgsOdnaG8uVl7J/azPKP4e/UbC8p1qrCp++Umqz0
         yuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788287207; x=1788892007;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5v8dwO4qIccjpXs9ZdhBw1lluA5t2BNdQSYlylga9bQ=;
        b=VSSx2a+3UNfTfVFNoThJDJJPt7MR3HP2weGjo19NGkBkMTpzQgZLBks+md6WWzZy8d
         6JxRt3B7+LR90BfeE1xUCEw2IpjJKLaQ5DuthjJcklYUH7bLL9ONnRapoOeKCKRGk5xo
         moCj77WLdGt9tNdBB0kZQYhKsDNtl7nJRvat32LZ4JYuraGJ1j4zBZQ5SiYyWSR/nDJb
         mI6jy/JURJvEq6sLoEoTANIQqy53/22tdL0y+HZxxn6w0159L31PSgwr301JwgVknQIx
         BgRD00K17bhq74Sdvmk1ZAD7XvmQOy5aA6QF9aJXbDERsIK7WDYdh8F14p8BHxkIn4J1
         AlGg==
X-Forwarded-Encrypted: i=1; AHgh+RolVQO/aHw6yA/k+Jds4n0euyXEsluy57GseJDHEEwWtJ3zcfKIUt+wT67CN2uD0+LFfoHEFRwgmp5h0GNBABHOcoo=@vger.kernel.org
X-Gm-Message-State: AFuF++lPWUfZwAYR/ha/zxS9OzAcUPMx3BdJSjudy2MeYXS0BARF0jey
	vuyAZWdO/lyg5Co06v4CRgqaHLOKr1dR2ybtJYTGnJ2gS8wpxYtkt7MpFXkGV+KupSOrmVjOVO6
	8jXoJ8g==
X-Received: from pgbd18-n1.prod.google.com ([2002:a05:6a02:64d2:10b0:cc3:28ba:e8b1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7284:b0:3d0:cc29:ff63
 with SMTP id adf61e73a8af0-3d7ae4ed97emr13763648637.12.1788287205983; Tue, 01
 Sep 2026 11:26:45 -0700 (PDT)
Date: Tue, 1 Sep 2026 11:26:45 -0700
In-Reply-To: <CA+EHjTzALzghuG5J-LFuG5pXJ4WgEfrMHgwkMHnq1U-D6yS7Pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260830-gmem-inplace-conversion-v12-0-85e5fd25252a@google.com>
 <20260830-gmem-inplace-conversion-v12-23-85e5fd25252a@google.com> <CA+EHjTzALzghuG5J-LFuG5pXJ4WgEfrMHgwkMHnq1U-D6yS7Pg@mail.gmail.com>
Message-ID: <apcY5b2o5k04XffH@google.com>
Subject: Re: [PATCH v12 23/45] KVM: Let userspace disable per-VM mem
 attributes, enable per-gmem attributes
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Randy Dunlap <rdunlap@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev, 
	Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 01, 2026, Fuad Tabba wrote:
> Hi Sean, Ackerley,
> 
> On Mon, 31 Aug 2026 at 01:25, Ackerley Tng via B4 Relay
> <devnull+ackerleytng.google.com@kernel.org> wrote:
> ...
> > +       kvm.gmem_in_place_conversion=
> > +                       [KVM] Controls whether KVM enables in-place conversion
> > +                       support for guest_memfd and tracks the private/shared
> > +                       state of memory per guest_memfd instead of per VM.
> > +
> > +                       If enabled, KVM enables the KVM_SET_MEMORY_ATTRIBUTES2
> > +                       ioctl on guest_memfd file descriptors and disables the
> > +                       legacy VM-scoped KVM_SET_MEMORY_ATTRIBUTES ioctl for
> > +                       private memory state tracking. Only the
> > +                       KVM_MEMORY_ATTRIBUTE_PRIVATE attribute moves to
> > +                       per-guest_memfd tracking; other attributes remain
> > +                       per-VM.
> > +
> > +                       This parameter toggles KVM's in-place conversion
> > +                       capability support. Whether a VMM uses separate backends
> > +                       or out-of-place memory management is determined by
> > +                       userspace VMM design.
> > +
> > +                       Note, this parameter is only available when
> > +                       CONFIG_KVM_VM_MEMORY_ATTRIBUTES=y. When
> > +                       CONFIG_KVM_VM_MEMORY_ATTRIBUTES is not set, in-place
> > +                       conversion is unconditionally enabled.
> > +
> > +                       Default is Y (on).
> 
> The parameter is only settable when CONFIG_KVM_VM_MEMORY_ATTRIBUTES=y, and
> in that config gmem_in_place_conversion initialises to
> !IS_ENABLED(CONFIG_KVM_VM_MEMORY_ATTRIBUTES), i.e. N, not Y. Is the doc line
> wrong, or is N-by-default not what was intended here?

The doc is wrong.  The intent is to maintain backwards compatibility with existing
deployments if KVM_VM_MEMORY_ATTRIBUTES=y.

> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 05c518c9b8078..929fd3e1a01e6 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -103,7 +103,10 @@ static bool __ro_after_init allow_unsafe_mappings;
> >  module_param(allow_unsafe_mappings, bool, 0444);
> >
> >  #ifdef kvm_arch_has_private_mem
> > -bool __ro_after_init gmem_in_place_conversion = false;
> > +bool __ro_after_init gmem_in_place_conversion = !IS_ENABLED(CONFIG_KVM_VM_MEMORY_ATTRIBUTES);
> > +#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> > +module_param(gmem_in_place_conversion, bool, 0444);
> > +#endif
> >  EXPORT_SYMBOL_FOR_KVM_INTERNAL(gmem_in_place_conversion);
> >  #endif
