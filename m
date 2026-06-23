Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5C7396D15;
	Tue, 23 Jun 2026 06:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782195320; cv=none; b=NvfLqY6jvxEH0Gs8pCxPJgAVibLfQ9g1bDCo5N3tOOEDDD+ProRR7/i8TQ60lcooK5OvGQeySnZKDbNpBRMzFOdCufxGiV9mrTsfqOfEsJJHZWsUA8Tm3rMaleht2xEHEBGVtpLQAToNyMO6JD630Om2jUJCJ94aEGsmE3jtAIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782195320; c=relaxed/simple;
	bh=iDJQ8q9y8/lBVlCSKCHv2KFuzeprLfn94oYskcqsbro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nA6PqsNDCUybHLtJpNOFn9NEhOi32UlveO0eIWYgP2q68h4Lh7vM8k7FjWQGJmljnm20YKicoMgLIV1rFO6MC15VeucgT0ey6Dha68NDQxyEcUyKwSdFT4ie3QCp2yrVqzFtAtEYWR0Wq+GOYE0TUlk5okgTyOaWbgPB825FUxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EW0G8ol9; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EW0G8ol9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782195318; x=1813731318;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iDJQ8q9y8/lBVlCSKCHv2KFuzeprLfn94oYskcqsbro=;
  b=EW0G8ol9BtzNIz6smi8tAUi3HcP9KttzCn3jMZ6QW05V7AStaHkI0jtP
   U2hiK80Uotz7Ym/oUoTa3eJCsVJRFVfkbQRoQOH1ZW3qzp9dT0q84mlIY
   NJOm9uPElbkugpICVqquohNUglq6RkJ4ZitxlbienuUJKgLa7wSkr/cK4
   XQpNioFwFeaOF2nFsBneyAoXGEcwxIeFt4ky1M1RdfxMNk40ryc0Hxtdk
   Gv17HASbDZGdPsBWPMuJ9Xs9DcygqRcSCkWZdHIkA5yPC23nEQJecub2g
   +2m29GxwR07fuPcVMRaQ0Lg63JQcIDNVvGqnTpIJ2tEwHQf1reumX6JhX
   A==;
X-CSE-ConnectionGUID: FsIqkeOnSvCf/ZSa9t2B3g==
X-CSE-MsgGUID: nXUwkrN5SOSuLi6+ual4sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="93293247"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="93293247"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 23:15:17 -0700
X-CSE-ConnectionGUID: HBGg64mmROGLAXtatw76Ug==
X-CSE-MsgGUID: FlT3tdEoQW+kTfbe58pb3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="248278935"
Received: from unknown (HELO [10.238.2.81]) ([10.238.2.81])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 23:15:04 -0700
Message-ID: <2ef455c3-a3f5-4ba1-86ea-b96416d163ce@linux.intel.com>
Date: Tue, 23 Jun 2026 14:15:01 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/46] KVM: guest_memfd: Wire up core private/shared
 attribute interfaces
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, brauner@kernel.org,
 chao.p.peng@linux.intel.com, david@kernel.org, jmattson@google.com,
 jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org,
 pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com,
 rientjes@google.com, shivankg@amd.com, steven.price@arm.com,
 tabba@google.com, willy@infradead.org, wyihan@google.com,
 yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org,
 suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>,
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-coco@lists.linux.dev
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-10-9d2959357853@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-10-9d2959357853@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:

[...]

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index bca912db5be6e..e0e544ef47d69 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -926,6 +926,24 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
>  
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
> +static bool kvm_gmem_range_is_private(struct file *file, pgoff_t index,
> +				      size_t nr_pages, struct kvm *kvm, gfn_t gfn)
> +{
> +	struct maple_tree *mt = &GMEM_I(file_inode(file))->attributes;
> +	pgoff_t end = index + nr_pages - 1;
> +	void *entry;
> +
> +	if (!gmem_in_place_conversion)
> +		return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
> +							  KVM_MEMORY_ATTRIBUTE_PRIVATE,
> +							  KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +
> +	mt_for_each(mt, entry, index, end) {
> +		if (xa_to_value(entry) != KVM_MEMORY_ATTRIBUTE_PRIVATE)
> +			return false;
> +	}

Patch 1 noted that "Ensuring every index is represented in the maple tree at all times".
So I think the queried range should not be a hole in the maple tree.
However, there is a inconsistency: in patch 1 kvm_gmem_get_attributes() explicitly
checks for holes, but this patch does not.

> +	return true;
> +}
>  
