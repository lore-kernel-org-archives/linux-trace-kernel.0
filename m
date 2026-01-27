Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE4F2F3C3F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Jan 2026 23:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769557604; cv=pass; b=rfOsh9VfjPsxbMDJLBPfiVI+tBvuzdLInK73ZEtI2mU+XI8Qvmz+xyJernqNNIhrPFtBmHr8AXcbi2dkddYMaFjBsAAAF5Hm8pXn/ab39v7/4npPkQaaOBnwWUp6ZG3xN6nbfuVLoA9uu1wuNeQN2ewAePDKhhp/nBUHo2kl4XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769557604; c=relaxed/simple;
	bh=vst6t4peh/JV4Zuhoe6fbMyUDr/jcG7JxMjC1bUj/HY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9K2DgfCXwlKD3wCeUK2o/FFJS0em9GEtk81rU4p8Ol2AyuaeVJgUIRHhKm+D77kXRU7+mOkHlYYGiAuvf9d/VQalhDcCliZmXlQcEbQX6jvx3bWGg47jjU83L0YWMelmaKdNdqZcAhHrX1ELuJ3hNsuF7TuRuz8RvYX3/AD6vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Lt+4rDo; arc=pass smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Lt+4rDo"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5664634a27fso1009043e0c.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Jan 2026 15:46:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769557601; cv=none;
        d=google.com; s=arc-20240605;
        b=cCC/pVbTuQM1GEc3TM0mmMvZR+Bf+ERRUfe4/onDUxm9mjvyzF3/miz0QZqkL7joTo
         Etc4WYo3J7hFdLZ4w+MpVo81Fg/nO+/9pe9rnL09wx5DPvZXSwHDZVXddjdPTZysYjx0
         3WziouI+kaP60MVhxzxGDsMwmJvb/PYAbSewUbVifpCyspE5dJoGi+3ElVonHMEPmaE5
         oHmbbrEVl0Ld1qPD+jJuLit6UNaD55EzH0/l6QdjYwg5BCwIQQt/ojC6lLkPwXm4VglL
         VLZyhOpjWnv2yHT69gvsHSvvTpgmDRAbZvTIWj8snGo20oI0+V9ZK3D/ZmETvtcgCy1u
         Tv5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=3+EqNzQT9TNRk9U4Wm8Lp51VnBAV17bgK1qxop8j5Is=;
        fh=vwnPZwb7QzR5RtDAJAnyZcsHFEotmGEQinCEU2pdNlg=;
        b=SlpnEAtIrkAJ3b+c8bo+3PRno53WIGHxE/H+XpGE/6JFgfcUSdDhn7XKi0NaWCdUqj
         crN1dJc3VBVLub8ACSj/ZDRWEqTwxSUMyrCLp7cdwsWtS4+/6Eb72f4W0CWSjDUOpQdu
         uLRrd+nVecC0Zel/SFenluVzeZ42j7GVzCsMRo9g8Y2dNMh/q/m0doaBuyfMAfv3dJfE
         2z2smCpQ0C0NW6nXd7+12d06gj2KmAdw6Z3XHlkG9AGsXBlfsAyoEmz7cS3yJ89V2AnQ
         7hbrUe9qza6MaWu50qLaHaCoaao0Oj/SgsmEOinK9f2Yyg4QBac+5YXv8w1pg6byFx+P
         Jkiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769557601; x=1770162401; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3+EqNzQT9TNRk9U4Wm8Lp51VnBAV17bgK1qxop8j5Is=;
        b=0Lt+4rDoaKMjlorgXNJSZbKtSD8QTIqv8Uk8kW/hLwR7jTh345da5cqmBqwonI8PJg
         pCyLWieAavGaFtzxFx2pEnLmxyV0sVpKoYloUsqjgsfRGAoAQmpbknl9dpJQ8R7rujwm
         tBecnK/vg0k+wQrYkcrcRCYBIkul8IW6BaLgryzn7yK+0OA2wzpojMHgwioj7Ir1VMfi
         fGNwTJ48AuNLfWRtCA4pRTbwuE/NQTy2EmSu4eHLfTVRVrJm0exlP3/cPN5WcSFTahx+
         0jbO8xHlYZx5j/o24orPEtbxr581/wVk6Z5w+ryZAp+fwIUZaWNiwy+derf7O54USrI7
         IoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769557601; x=1770162401;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+EqNzQT9TNRk9U4Wm8Lp51VnBAV17bgK1qxop8j5Is=;
        b=hAfj3SLU3RPxDrzUouTUc4jQk9VPvgCF2BlUwRbAVaoXblwQae+AYYJzTS8pCoMoeh
         63kUQ3gQ9ix7NAo3W7spa6Rygzgp7N0tyYVrWh7JcXV9H44sCDZnQWuEBM4nubqQ9G/J
         j4IwpV4QKSzc3zIQhNljhtgTxKcNblGkvb2XZlzTvkapNDSz1HPmEGrBX4EU0xRS+4j6
         vzcr6cMFaK6lU6i/1HHfeRdJZwwYplgnAyF7pAvkUN5FRArOOGvqSa1un8IOU5e5D05I
         GNeh12Th4TZSQo8IjDfRf+aD15Lsski+AolNuM3RN7r/uM2IeaYDL49NeEdDyDFTvq8Z
         PORg==
X-Forwarded-Encrypted: i=1; AJvYcCWX6IOohJ1IphJDT7qyT9BRVaHGfeZ34JEIEVnxu2qkQGpXS3AZpVW4nFvfP5uUpyQzCDgRe/6soOqli1+JIXcVcCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0O9fOiDwUhJILckDyTsDxb4gDAogw8nSHsO00gzU9/q9ad5jO
	0B2cCpXQ6y4xNEYI1X/OtHm1XwDSQY64hp7KuCGtlMP+BFPUezIpQyzdPwfNYfq1AwTYI2zbB0d
	gpfb9Bxh6b5A7AiuCZBnCQMDLVKNYVYnW+3n3egk9
X-Gm-Gg: AZuq6aJ385R/gUGUvdGE0vQrTNCMx0q2Qu7v3n1+fG9vaTxdMdc+IKV3PvTBLcRZBTt
	DOkhViWJJsFC0XQ6SK2+0BxkfEZ1M847tKeZjRvmOhVrOoEatR1YvmNQsNPszAFE8b0JtbK+xyE
	XU0gFQpP0TSPw7JQquRa0/LA6O5if16v5nB7BUk9OaWcoEzEkHS/5C4J8gXii7JB3d8m+Y6Jfnm
	LCA/QW2tv+3Gsnwx26HHq1xL0YINmvvuBt/W16u3DBqkolUbOVIH/pRW9QjQlfAL//Cz/7eKd0+
	eElRjdFp1Bqp6TbIl24y32dt+w==
X-Received: by 2002:a05:6122:488a:b0:566:36e7:8934 with SMTP id
 71dfb90a1353d-566795c5856mr1161633e0c.16.1769557600050; Tue, 27 Jan 2026
 15:46:40 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Jan 2026 15:46:39 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Jan 2026 15:46:39 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ce78da49-2525-44af-9cb8-301bf6a4658a@suse.cz>
References: <cover.1760731772.git.ackerleytng@google.com> <02aad35b728f4918e62dc6eb1d1d5546487b099e.1760731772.git.ackerleytng@google.com>
 <ce78da49-2525-44af-9cb8-301bf6a4658a@suse.cz>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 27 Jan 2026 15:46:39 -0800
X-Gm-Features: AZwV_QjMPyTn9KuYIeoCwzon32JStKYHl7N-mpSbapwuTdPZlfrcWu1xEKHINOw
Message-ID: <CAEvNRgE07d_TaSVpkWO8gMfGgPsP9sBzrqMPCte8PET0THF=QA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 09/37] KVM: guest_memfd: Skip LRU for guest_memfd folios
To: Vlastimil Babka <vbabka@suse.cz>, cgroups@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: akpm@linux-foundation.org, binbin.wu@linux.intel.com, bp@alien8.de, 
	brauner@kernel.org, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	corbet@lwn.net, dave.hansen@intel.com, dave.hansen@linux.intel.com, 
	david@redhat.com, dmatlack@google.com, erdemaktas@google.com, 
	fan.du@intel.com, fvdl@google.com, haibo1.xu@intel.com, hannes@cmpxchg.org, 
	hch@infradead.org, hpa@zytor.com, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	liam.merwick@oracle.com, maciej.wieczor-retman@intel.com, 
	mail@maciej.szmigiero.name, maobibo@loongson.cn, 
	mathieu.desnoyers@efficios.com, maz@kernel.org, mhiramat@kernel.org, 
	mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, mingo@redhat.com, 
	mlevitsk@redhat.com, mpe@ellerman.id.au, muchun.song@linux.dev, 
	nikunj@amd.com, nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com, 
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com, 
	peterx@redhat.com, pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, 
	qperret@google.com, richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, rostedt@goodmis.org, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shakeel.butt@linux.dev, shuah@kernel.org, 
	steven.price@arm.com, steven.sistare@oracle.com, suzuki.poulose@arm.com, 
	tabba@google.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	vannapurve@google.com, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Vlastimil Babka <vbabka@suse.cz> writes:

> On 10/17/25 22:11, Ackerley Tng wrote:
>> filemap_add_folio(), called from filemap_grab_folio(), adds folios to
>> an LRU list. This is unnecessary for guest_memfd, which does not
>> participate in swapping.
>
> IIRC guest_memfd mappings are unevictable. That should mean they are not
> ultimately added to a list (see lruvec_add_folio()).
>
>> In addition, the LRU list takes a reference count on the folio. With
>
> IIUC the refcount is temporary while being on the percpu
> &cpu_fbatches.lru_add, added by __folio_batch_add_and_move().

Thanks for pointing this out. You're right about this, I misunderstood
this refcounting earlier.

> When flushed
> via folio_batch_move_lru(), the refcount is removed and there's only the LRU
> folio flag that remains. The fbatch flushing can be triggered if you see an
> unexpected refcount increase.

The new plan is, to update kvm_gmem_is_safe_for_conversion() to drain
the fbatch if it some elevated refcount is found:

static bool kvm_gmem_is_safe_for_conversion(struct inode *inode,
					    pgoff_t start, size_t nr_pages,
					    pgoff_t *err_index)
{
	struct address_space *mapping = inode->i_mapping;
	const int filemap_get_folios_refcount = 1;
	pgoff_t last = start + nr_pages - 1;
	struct folio_batch fbatch;
	bool lru_drained = false;
	bool safe = true;
	int i;

	folio_batch_init(&fbatch);
	while (safe && filemap_get_folios(mapping, &start, last, &fbatch)) {

		for (i = 0; i < folio_batch_count(&fbatch);) {
			struct folio *folio = fbatch.folios[i];

			safe = (folio_ref_count(folio) ==
				folio_nr_pages(folio) +
				filemap_get_folios_refcount);

			if (safe) {
				++i;
			} else if (!lru_drained) {
				lru_add_drain_all();
				lru_drained = true;
			} else {
				*err_index = folio->index;
				break;
			}
		}

		folio_batch_release(&fbatch);
	}

	return safe;
}

I hope this is what you meant!

> So it might be feasible to do without this
> patch (maybe it was already tried and there were substantial issues, in
> which case should be mentioned).
>

The patch "KVM: guest_memfd: Skip LRU for guest_memfd folios" will be
dropped from the next revision, and "KVM: guest_memfd: Don't set
FGP_ACCESSED when getting folios" is no longer a requirement for this
patch series.

>> shared-to-private memory conversions for KVM guests dependent on folio
>> refcounts, this extra reference can cause conversions to fail due to
>> unexpected refcounts.
>>
>>
>> [...snip...]
>>
