Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216563D0908
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373305; cv=none; b=L+1z8NRfmeyyenBGqAnqT/pxSEXeaGlLQImJtEURmVuCDg8XWkPZ2SoYw+PTjECXAaS8nDpg1hZRYnygZzcW1DEFJCVMBGTUnX07774H5u9T8jKz9U0TSSpLuTsecyZttfpF1wlLaFOgi90Mhb3Z7at+cH/BPqYBqMdWYAz4U+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373305; c=relaxed/simple;
	bh=+pL+rZ5hYnakVp3eViVhhlNGbB7Zs5h4PZn9WwK7upU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rvU9WBRo5Cb/tbZtFAEhFjoeTUDeXVfBa0nqPxwKGTmr97Zpbdm3jbxFcBRFNLpir7q4GTMxkNeEnc/fm1evbEnHpug/MWUqH2QrXO/hx1Yhhtd8DjQVMhAXY4ApyzPZRGa5CaqxzrS6K2Q8QmeIiqIoFd95AdYTg44OpRhHbe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SqitMEY1; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SqitMEY1"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-368edd5fec4so6876701a91.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 07:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779373303; x=1779978103; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Q5oVYYRVy83rEvyTZBhLaKBIsxHN0wptJNVngW/2MQ=;
        b=SqitMEY1JJoz/yFscBsnP6NOrJ50V22ksAYo3FayvTgFLjyqE+IZ7DK7t2atC29yeO
         3+kNIlP1m08q7kOhc6+vvbT9LYBFlZidNQVfZftYs+XCS3tTsmgxbx5fsBHVPoFLb55f
         qJHlmkh5Tn6mUgmXo/GoSAZ8pV+yFVtEeFJfsFFXM6323DjGULV9HF61o2wEZbutgqNB
         5xQA2gINrn6hVS/FffuJL4M/NJkV3RJuNFYHYBjyi+V0uLLPJ+v7bTNa1xDhJzYnjCrR
         gDHneTTt9q1maUrTeRREPGtrnQ/cG8FtWtFuVWr889bPevi4CfjoyvynKE0uJHDGpVvv
         ypug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779373303; x=1779978103;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Q5oVYYRVy83rEvyTZBhLaKBIsxHN0wptJNVngW/2MQ=;
        b=WkIDPpcOuVYEPhGfc7MSt/1sKZqbIteWN8t36qAqcNr7oYrUUaLEm9DZphoIwryPwh
         kt2R4Oh/wCJKfckNgzJCpqHvb1ZN1nF+PPIiNDh7q/1raN5L9qhsNx1soirSsezARcr0
         ePshGee2HV5mDkvu6tOxMh7VDTEuPH8npbXgtDO42alXC3te3s9IURmP8hBLUE4lOqsy
         SmK+GDcupdkafuGbg0UGiQcv7WnicXaXUf7MQY9f8w3h4CjFNYiu+Vl6NkHygsbPJkUu
         P4TKKgr5pa+Lo04ofS5xztW9bIMR/tHyElt1uTnN+VD1DxHlEhXyyOYGwDc5CYycKRHc
         X10Q==
X-Forwarded-Encrypted: i=1; AFNElJ9qkHBNNs5h8GdpP/0a7Lqzz97+3X/RkFOCIBnFeqGkpTnJgrk+mVybjuFRtJtoj4X5n+/HnNM0WldNIbsW1aMBLnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVp2UJQly+q3IUruZNk0ujLpE07sXw5T2NWjwBvmPd44WqbXd3
	Nu24VX7JS4B94jxFHRIMEI+LKdsy8qnchvfl9mhMinLllk5wy1n1bAhiYEX9SjPQouX2hkvcCAq
	pqX3UEQ==
X-Received: from pjjj1.prod.google.com ([2002:a17:90a:601:b0:368:adeb:4994])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2548:b0:35f:b5df:453
 with SMTP id 98e67ed59e1d1-36a45630166mr2922293a91.22.1779373302968; Thu, 21
 May 2026 07:21:42 -0700 (PDT)
Date: Thu, 21 May 2026 07:21:42 -0700
In-Reply-To: <CA+EHjTzu=28Sr3=9A9LmJEGz0tBEDbU9taznVV5kdL7s8Nw=Jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
 <20260507-gmem-inplace-conversion-v6-19-91ab5a8b19a4@google.com> <CA+EHjTzu=28Sr3=9A9LmJEGz0tBEDbU9taznVV5kdL7s8Nw=Jg@mail.gmail.com>
Message-ID: <ag8U9qIcTd_GykHE@google.com>
Subject: Re: [PATCH v6 19/43] KVM: Let userspace disable per-VM mem
 attributes, enable per-gmem attributes
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <tabba@google.com>
Cc: ackerleytng@google.com, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, ira.weiny@intel.com, jmattson@google.com, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, liam@infradead.org, 
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
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Thu, May 21, 2026, Fuad Tabba wrote:
> Hi Ackerley,
> 
> On Thu, 7 May 2026 at 21:22, Ackerley Tng via B4 Relay
> <devnull+ackerleytng.google.com@kernel.org> wrote:
> >
> > From: Sean Christopherson <seanjc@google.com>
> >
> > Make vm_memory_attributes a module parameter so that userspace can disable
> > the use of memory attributes on the VM level.
> >
> > To avoid inconsistencies in the way memory attributes are tracked in KVM
> > and guest_memfd, the vm_memory_attributes module_param is made
> > read-only (0444).
> >
> > Make CONFIG_KVM_VM_MEMORY_ATTRIBUTES selectable, only for (CoCo) VM types
> > that might use vm_memory_attributes.
> >
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> 
> Config files always confuse me, but Sashiko might be onto something:
> 
> https://sashiko.dev/#/patchset/20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4%40google.com?part=19

: Since this prompt does not have a default value, will it default to N
: and silently drop KVM_VM_MEMORY_ATTRIBUTES during configuration updates
: like make olddefconfig?
: 
: Existing userspace VMMs that rely on the KVM_SET_MEMORY_ATTRIBUTES ioctl
: for TDX or SEV VMs might fail to boot if the feature is unexpectedly
: compiled out. Could a default y be used to preserve backwards
: compatibility for existing configurations?

> I think this partially goes back to commit 6, the one I flagged
> yesterday. But also adding "default y" to KVM_VM_MEMORY_ATTRIBUTES?
> The default value should at least fix this issue, but I'm not sure if
> it would cause other problems...

Hrm.  As much as I want per-gmem attributes to be the default going forward,
silently breaking existing setups isn't great.  On the other hand, I'm *very*
skeptical there are any SNP or TDX deployments using a distro kernel, so I'm
still leaning towards forcing the issue and turning per-VM attributes off by
default.
