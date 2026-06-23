Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5445386562;
	Tue, 23 Jun 2026 02:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782180915; cv=none; b=a+TYmyT0edu+68AMA/ZL72lY5XUJQDQ/EwrgsGAjlDnn+pB5Oc303WzkzAwwOjzyZL2OWAvVnY8rHrsEC6L0p3liXDAOyZJX6ECX7mEhRQXd4l1x1JsUANfA0fyUK9ujQ/LjAmINczIIaTWPjNuRuU9SjGHArOpLZ0U9XTd1T1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782180915; c=relaxed/simple;
	bh=d5AgO5tMzxYFDBtDlIOi/5Ij485uiyqm1kvbZMmKbDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhYx0gO5c5R4thjBW8DKsFwDARmIb+1fb0WQ/qflj/g67q55tS/m022m726bxED+4MdhcwuSIWPf+p+PoxrMxmiXscveA4Zzbe43YBFiB/nOBg92S5GWEPABR17mls/3VSscdjU+lv+8cDxXEj/Igc9ouem1MoOXlkXokmyk0C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KJhX6aJR; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KJhX6aJR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782180914; x=1813716914;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d5AgO5tMzxYFDBtDlIOi/5Ij485uiyqm1kvbZMmKbDQ=;
  b=KJhX6aJRXHNxbvK6Wf+vrRi0I5/kz1MSPLUZUGYIvnWKdOUbIinnMoIx
   Ezv1XIq+GWOAxiMpDli51zo3xOEQe0dM8PreKi2C0EL5+PGyfTMm04AOM
   Hc557z68R4TX5DR9lRvI5bOPjTRrCpb1Eqmu8i2VLs5fVxdeyN+p0X6/1
   qMml+0WcADGUF9/46QNNwZGADv3PTwqzyJZMbewNLkKKPo8H1ugG6wKwq
   abXJ3wY0dgmxpiejYTjpqRepHVxW+/+aq3E4uMkpcKnSXm4nKM2nbIRlz
   VzWdwff3/owCzCe2E048V665MD78bHTP9hJ5AQDwMo9eHYa1rniwKmNWY
   Q==;
X-CSE-ConnectionGUID: IvBhI7PFS2y62KlL+kDd5w==
X-CSE-MsgGUID: uQWQLIs2Q8+yUxz+saOM9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="100467932"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="100467932"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 19:15:13 -0700
X-CSE-ConnectionGUID: tGc2qhuAQciVN83fjDT2Dg==
X-CSE-MsgGUID: 2ZnM0rp0RyKyL7OQapoTMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="247044499"
Received: from unknown (HELO [10.238.2.81]) ([10.238.2.81])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 19:15:00 -0700
Message-ID: <cc2fbb22-e70c-4f97-9c91-ac1f4dfbe48a@linux.intel.com>
Date: Tue, 23 Jun 2026 10:14:58 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/46] KVM: guest_memfd: Introduce per-gmem attributes,
 use to guard user mappings
To: Sean Christopherson <seanjc@google.com>
Cc: ackerleytng@google.com, aik@amd.com, andrew.jones@linux.dev,
 brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org,
 jmattson@google.com, jthoughton@google.com, michael.roth@amd.com,
 oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com,
 rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com,
 steven.price@arm.com, tabba@google.com, willy@infradead.org,
 wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com,
 pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org,
 liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
 <20260618-gmem-inplace-conversion-v8-1-9d2959357853@google.com>
 <aceb07e1-77bc-49b6-a932-5fd9b5a21727@linux.intel.com>
 <ajnjTJdQKD1Kz3tf@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <ajnjTJdQKD1Kz3tf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/23/2026 9:37 AM, Sean Christopherson wrote:
> On Mon, Jun 22, 2026, Binbin Wu wrote:
>> On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
>>
>> [...]
>>
>>>  
>>> +static u64 kvm_gmem_get_attributes(struct inode *inode, pgoff_t index)
>>> +{
>>> +	struct maple_tree *mt = &GMEM_I(inode)->attributes;
>>> +	void *entry = mtree_load(mt, index);
>>> +
>>> +	return WARN_ON_ONCE(!entry) ? 0 : xa_to_value(entry);
>>
>> If the entry is unexpectedly missing, returning 0 means the attribute would
>> be treated as shared.  And then in kvm_gmem_fault_user_mapping(), it would
>> allow the userspace to fault in the folio.
>>
>> Should gmem deny such edge case?
> 
> After several bugs this year where a WARN_ON_ONCE() fired, but was entirely
> insufficient to prevent true badness, I'm definitely senstive to making the "bad"
> behavior as harmless as possible.
> 
> However, in this case I think we're just hosed.  If KVM treats the memory as
> private, KVM will incorrectly do prepare(), incorrectly allow populate(), and
> will caused missed invalidations (though I suppose __kvm_gmem_set_attributes()
> "only" lies to userspace in that case).
> 
> That said, assuming SHARED is definitely odd for cases where guest_memfd *can't*
> hold shared memory.  Ditto for assuming PRIVATE.  

Indeed.

> What if we instead fall back to
> the "init" state, e.g.?
LGTM.

> 
> static u64 kvm_gmem_get_attributes(struct inode *inode, pgoff_t index)
> {
> 	struct maple_tree *mt = &GMEM_I(inode)->attributes;
> 	void *entry = mtree_load(mt, index);
> 
> 	if (WARN_ON_ONCE(!entry)) {
> 		bool shared = GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED;
> 
> 		return shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE;
> 	}
> 
> 	return xa_to_value(entry);
> }
> 

