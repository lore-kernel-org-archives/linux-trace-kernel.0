Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37970225417
	for <linux-trace-kernel@vger.kernel.org>; Thu,  7 May 2026 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778178718; cv=pass; b=U4ALRrrvJMuEYpR6Ho+DuhJbLTiEY2AEAsdfkkaDzc3VeziAh5NaGX2QHtHMyb0TeL2hJhrbD8EgEuSha9T/i5VWZapbk2i7I93nvu8O5Ff7iFRV+VFbTgns4P5SvTmzITNFRVEUQmpB0KJ35O1LNp5XAtB9Q/2d0JFRfWD0m/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778178718; c=relaxed/simple;
	bh=9Gtd+5W8SMTR25ZmPIeA+8FPrVOqTlN7XkJgDdQpNlk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tIqW1t6ZaQme5wOUnaBm8XMglKb1JQSxQ1fA34Zx8PAC514V3PD/abk1sdBPYRuokoeCgfiZtcXK67XDR4pgdj8V101zklYGIhz3uWeiqvu2Tmtu/eG4JYuP9gSWKcOYC5ap3Emie1aaaufLOoxW2NPHm3E1a8crSAcWNllmaxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y9cxe9a7; arc=pass smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y9cxe9a7"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56f72d27e7eso2126400e0c.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 07 May 2026 11:31:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778178716; cv=none;
        d=google.com; s=arc-20240605;
        b=G3rD0DM7XmcbxO69piIHsJDyr7BjNQ4SJBjo/yFuROq/pn+RxYcL3XOoeXhKMtdH1C
         oiotdHkatDSRdEIuzSZVCg337NqqraGCHKVVqAQzAtsUPZbnxEESQRJdCfWc0z0owFTK
         VEtvVbOhUYHcx0fialy8bX45uiuCxs+JocXF63sTSHG5NEfz+dmfghVmHzKZ6nUqtDxI
         7C0xRwW/7JcFMJ+1grkv8FqdSL4AljxgsX4n/RWElyAgE4JW/6ROgsxMooZ+GfspKP0e
         kfsS/Nlc1pX7SwU+ue7l8MDN9wheKgShoEXrzZDeeTrvtknN2pZ5HB1NjB4qUdLx9jsE
         79Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=goCC1MXS8+Hmwnd2WWRAT4Rp01B0ycJCM1C1lBpTnIs=;
        fh=eOlQOqJlD496keuce3hSnYHBKsYa00ips5uJqGnZ1QM=;
        b=Fa9OShA/rZF8R6VlXjhFc+ghtByqmsmQNzebhjiHIbKNQfSsBtcHWHvxor5pXTHreP
         cP//EVQcuu0g4EXBITL04siM1LJ+W7osw8uO5BGa4RC+WiscbkCIjyLCPJdCGdyPbYPy
         8PHbplAcabQEEMYiCeVDA8X1IVmlPnT6TLFvdPGn6YYpdL/Fwg3PZw9P3VaGPKJta5+i
         xX1wbnz59Zsw3gC0SOFVUOBqdsMqsRvZfedOFC51eQzwpUCkZD7vTwzPU2/vTEJf0I1P
         4pEkMPcAXqtbQ1yi+mNtAWqBwMyCUGsUl3O3Ah7I/0TRG7q/+uOpWpAvuyKR3snc6GuD
         s/Hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778178716; x=1778783516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=goCC1MXS8+Hmwnd2WWRAT4Rp01B0ycJCM1C1lBpTnIs=;
        b=Y9cxe9a7HFizfWlIgAijSTg+sNOKPTCIfD5vBOU8y8Mz/QzE/FeerqQ/A2UvBuNAw2
         SBJCjy2e9x+XrkotisFuXDN1fRpLDdslnUKMz7KTp+mWIp5ZjnvluGkicFwv0WLNLI5k
         W521Q4uM1HXHMZDeGy4rTjT3wadbifQg1CiGsO9Sg+r07nzPaM9y1jf99mIjsHCP/qlx
         eAQwh3MNgEfls42ChDhMIMwg1OxbbKaY/0UCXoxdsH1YSSv+/YKUdiT/XB1WlHklBfW2
         gwgP37FB3EkaYPkfJ/o0nlF6PrzisFdCh5IOg1DrZctdmHN1lrUn6ml/EJIZzIjwRbAG
         6MGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778178716; x=1778783516;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=goCC1MXS8+Hmwnd2WWRAT4Rp01B0ycJCM1C1lBpTnIs=;
        b=MkDrl4K0KjAnQMoDKtZQn5MgY/QBozR6tkq0n6Lap5Agp5yS9EOpXj22UNvALnmrUG
         MmLZRLVSMXK9JFSVRMnT4+lCkGudMGA00LlagXV2SLcs4NWYS2soNGPdxFMdrQArXrEs
         78Q23L2HmuxJIhK5TDktTtSwfVSMfLLQoEKdO60ChCLUaU7JUbB9oPtCH0vHVPB/ZKVE
         4ftIVRPyYjGU0txBUvav7oBU1U8d39OesowCqPJTxzUaX7J3s5obD/1ISba3PMgnvQZl
         WnvJb8LZSLqZwSEa+nMe7izHdKUZn5Aja8sZyRfaHrL7xBzOldreY+XgIZ9KM44c2Szj
         LDbw==
X-Forwarded-Encrypted: i=1; AFNElJ+UjyOV4a6fiBEYCP0NN0Hy6VknP7Uso5m7YeiZhXSzscJYM3sfFJDz39ffUJE3MfVV+IwNeDW0o4+FOBKZSk/KFLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaZciEUdKHvOVVdt9FyMunLgQJk1Xjc5o1oWzyYiaFWBy/CNYP
	E7iqosNnOm2HFGDPdkMppVo0v2rMSIUpBy7+YZ9lLxXk5IAUkfDcSMXiClJSaJPygTj2miYB1kg
	e0gCDfMA3dRhv+eg2GFmxEt/HpRH1hnlKwQWx+WCe
X-Gm-Gg: AeBDievVS1vOlnF9gL46jzhYIGKYm99FhZn+/WksbQ9vYTaXIcK840pvtSmAX/Wq0ST
	4BwPS65WYSTEicx7y9BBLQazSc/e0bld4F/rC1YKpNjhIykdJJPzENpRYPYX5dDSTOvpoZcH5nb
	Kd4H8j6H97QuHaAFcStuzkuZ4XKuz+TJ/0rv0NtobWHmMZwWN/C+3FIt9V9lv4aqlZj8luuM3Hk
	UjnoEvZjLjmRT/KlBwjrYfrq9xUbWfeOY2YHNtSPiNwdeDqsKntBo4tp/wIETlz4+fUqwwrLx8m
	WeVVih7wnb7eNgrIx0osb6Zo/biSVj+Z+sIWUDopkWy6BAXlOG/DA466bIgypDVClZVMu//Q9pM
	m6DFL
X-Received: by 2002:a05:6122:6304:b0:56b:a7de:7129 with SMTP id
 71dfb90a1353d-575702cc825mr1528185e0c.7.1778178715530; Thu, 07 May 2026
 11:31:55 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 May 2026 11:31:54 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 May 2026 11:31:54 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <byywwfin2aenobdwuesqihm6nzxyx6ecedwgbt7f5tvaaul6fi@u7bmexpavwdn>
References: <20260428-gmem-inplace-conversion-v5-0-d8608ccfca22@google.com>
 <20260428-gmem-inplace-conversion-v5-1-d8608ccfca22@google.com> <byywwfin2aenobdwuesqihm6nzxyx6ecedwgbt7f5tvaaul6fi@u7bmexpavwdn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 7 May 2026 11:31:54 -0700
X-Gm-Features: AVHnY4IrLeBlt83AneVyVg35mAkmDcan1kch_gmoyAe0Nsgg7IVb__9uDe3mtms
Message-ID: <CAEvNRgFGc7SRy_hkfSH3X=Cu00CP6wMHBJO0+55uebKTezWVnw@mail.gmail.com>
Subject: Re: [PATCH RFC v5 01/53] KVM: guest_memfd: Introduce per-gmem
 attributes, use to guard user mappings
To: "Liam R. Howlett" <liam@infradead.org>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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
Content-Type: text/plain; charset="UTF-8"

"Liam R. Howlett" <liam@infradead.org> writes:

>
> [...snip...]
>
>> +static u64 kvm_gmem_get_attributes(struct inode *inode, pgoff_t index)
>> +{
>> +	struct maple_tree *mt = &GMEM_I(inode)->attributes;
>> +	void *entry = mtree_load(mt, index);
>> +
>> +	/*
>> +	 * The lock _must_ be held for lookups, as some maple tree operations,
>> +	 * e.g. append, are unsafe (return inaccurate information) with respect
>> +	 * to concurrent RCU-protected lookups.
>> +	 */
>
> Can you please elaborate how you see inaccurate information and which
> information is inaccurate?
>
> Your comment is incorrect and misleading as append will not be used in
> rcu mode.  Note that you have not set this tree up in rcu mode.
>

My bad. Thanks for clarifying about usage of rcu mode.

>> +	lockdep_assert(mt_lock_is_held(mt));
>> +

In the next revision I'll remove this lockdep and use RCU mode, and
kvm_gmem_get_memory_attributes() should get a stable result.

The other lookups using mt_for_each() in kvm_gmem_range_has_attributes()
and kvm_gmem_get_invalidate_filter() retain the lockdep since those
operate over multiple ranges. Those are called from paths that require
holding the lock to exclude other operations anyway, so the lockdep
requirement does not cost anything more.

>> +	return WARN_ON_ONCE(!entry) ? 0 : xa_to_value(entry);
>> +}
>> +
>>
>> [...snip...]
>>
