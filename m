Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914BC4921B1
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786731199; cv=none; b=tPypLGkad77+cDSFp1zIvhOj2SfrgRWpVVecYOEAeYizc2jm+lywFV5qsJ/bUpveRiWxQRvZQG3ouMQpmfdumWhtAa5Ot+UgwM4mcQMxCJ+QlxWbeloDj8xUy9CYLDw8iquCnEDPYINZg+6b0/rCFasPq19b/DiAn13/zVycRNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786731199; c=relaxed/simple;
	bh=OGjC4lU1LA7/XzaG6yfv4mKkKwAbvoqsVMSYuVRL2fk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uEj1ZJa5idVEitoarzYsUzCPVeexlc1d/7xP/yeDuyAYtrXjgyVGzumvxJhJS0s1Y84sOkByumE8ZvmuTlzfcwAg/gpUyNt7ek245SF+PN1kNwpYMEg8LNyhI5dP0v3+amvNFwraytCHJjA1b1GosbytdtRsgdfJvLhxIedYpr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZSbW2En2; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZSbW2En2"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c89704da8c7so1646146a12.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 11:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786731197; x=1787335997; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IXgZWbJY+AFNvGsunVK4VPpL85oG6gcjHAIado0UDKw=;
        b=ZSbW2En2KcTkVZRa6xD5qWELlYHpboqrxgh02e2JgPBb1SOig+KanT6qe58sUaPiWo
         wh/f4dkLRF/r6XiCaNquo5CDDfVcsAvB/b2gG6P45O75XRiY5x1ZMWVorH/imzJW7xFE
         un2Ts1kjLA8usg4wQyiYMg8Zf+sT9x80SpotqP0pvTTAeikHgNFO/z+cWAzDWbbbGYnr
         svJb8Uk4IebGj+EuJUdpE7z0mmwD8RbDusiGpqcEssCkUCkgKrHBt7YgotonIlNoE/IC
         eWb7ygH14/ELtAKzUUhNGKFjEZxqPnlUrv8MhQooYL2VJXJBeMW2eTFBPQtCUAtNxzBe
         g7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786731197; x=1787335997;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IXgZWbJY+AFNvGsunVK4VPpL85oG6gcjHAIado0UDKw=;
        b=kNU3xyUc5oQdXGcp5hUr2SPKOMPPo2hyXxq+JnhGphxJNc5HvhTzOx/hCJAyR67ckB
         +9H7HUtbniRqdrbK6dHfNpl7AhmTYoQwwbqPnC7vwwn3EjAnvsBOZ/M+My8bprjIAfT7
         Wr78eZy61Lr2ww/x9bMmneNc10NCTisUhbBFPOaEfX51pCwkp2xzqCvO1QzVQJTsUhG+
         Se9Z8ZEPulv2Ch4CTBRtADcTTa5qBFVROqAoQkEifUj2FKU1HkUjCGuKyP2YrxUpiqlV
         ItwrYURWsRwaS1QMMxzViACM8HxrlsBCtSs208zR+F+a3l9hmNR2d/QwGqnvJxy5itxd
         ngiw==
X-Forwarded-Encrypted: i=1; AHgh+RqwQekoqkAO5If3+6NRrJc/Qwc87GIbI5wGsXW0mN+HZSrHFj79kAzw0JONftFhz9qkPO2+uckwVUkVrX7/CE+PAVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YytyRgTu0Xr3rbKi9dq1QSDyaQ+x2/wc/jov4TBcVbr8fTzP8SL
	kCjbSghSBjKZF9fHpPUHV1eKS2L6fhSekWfzlo/JWq+T3s2OYrWjPLv1Ql6afiUakqYD9053vi+
	H5gnZgg==
X-Received: from pgkg8.prod.google.com ([2002:a63:fa48:0:b0:c9a:d174:5315])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7316:b0:3c4:de3:816c
 with SMTP id adf61e73a8af0-3cc71ed56f7mr9388112637.37.1786731196579; Fri, 14
 Aug 2026 11:13:16 -0700 (PDT)
Date: Fri, 14 Aug 2026 11:13:15 -0700
In-Reply-To: <f41624da-8461-45cf-b555-241091faeb63@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-20-2fc18ee6d3ba@google.com> <f41624da-8461-45cf-b555-241091faeb63@linux.intel.com>
Message-ID: <an9auxaZBuTJCAr-@google.com>
Subject: Re: [PATCH v10 20/41] KVM: Let userspace disable per-VM mem
 attributes, enable per-gmem attributes
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: ackerleytng@google.com, aik@amd.com, andrew.jones@linux.dev, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
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
	linux-coco@lists.linux.dev, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 14, 2026, Binbin Wu wrote:
> On 8/8/2026 5:52 AM, Ackerley Tng via B4 Relay wrote:
> > From: Ackerley Tng <ackerleytng@google.com>
> > 
> > Make gmem_in_place_conversion a module parameter so that userspace can
> > configure enable or disable the use of VM-level memory attributes. The
> > module parameter is only available if CONFIG_KVM_VM_MEMORY_ATTRIBUTES is
> > enabled.
> > 
> > To avoid inconsistencies in the way memory attributes are tracked in KVM
> > and guest_memfd, the vm_memory_attributes module_param is made
> 
> The description is stale, since there is no module_param called
> vm_memory_attributes?
> 
> > read-only (0444).
> > 
> > Since selecting CONFIG_KVM_VM_MEMORY_ATTRIBUTES disables in-place
> > conversion, 
> 
> "selecting CONFIG_KVM_VM_MEMORY_ATTRIBUTES" doesn't necessarily disable
> in-place conversion, it also depends on the setting of
> gmem_in_place_conversion.
> To be accurate, maybe add "by default"?

+1.

Ackerley, please write changelogs in imperative mood, i.e. state things like this
as command, not as a passive description of what the code now does.  And I would
omit the blurb on changing the kvm_arch_has_private_mem() definition, for me that
falls into the category of giving a play-by-play explanation of the code change.
I.e. Let the diff speak for itself.

E.g.

  Allow the user to disable KVM_VM_MEMORY_ATTRIBUTES even when KVM supports
  PRIVATE and SHARED attributes, and expose gmem_in_place_conversion as a
  module parameter when per-VM attributes are supported.  I.e. let userspace
  enable in-place PRIVATE<=>SHARED conversion of guest_memfd pages.

  Provide both a Kconfig option and a (conditional) module param so that
  deployments that use a custom kernel can fully disable per-VM tracking,
  while not forcing distros to ship two separate kernels in order to provide
  backwards compatibility for downstream users.

  Don't allow running VMs with mixed tracking for a given instance of KVM,
  i.e. disallow toggling the module param after KVM is loaded, as the extra
  complexity needed to handle per-VM behavior far outweighs any potential
  benefit.  E.g. neither TDX nor SNP supports live migration, so in effect
  the requirement is that existing deployments that want to support both the
  old and the new models would need to tell their VMM which flavor of
  tracking to use.
