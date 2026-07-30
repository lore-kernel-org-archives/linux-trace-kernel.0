Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCD92DC76A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 20:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785444161; cv=pass; b=SNXkLjhOujVSM52L4oKQ1tmDUZ6uT/RJ6s8NPimWmjPuBeqFVJ2Pt3rwRN9xk21J8/NpVWNh6Ura4sizZUp6Zkv9L1TSsX9HGpMuN/9km1xlp4tAhnXAdbkojNgbdkXmiET1enVG5l+38NBLp3wtxr5XF9ijEOhZooGKVstAWYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785444161; c=relaxed/simple;
	bh=1jiZYsqBtrcmi7eIwfzyaU0PYhHwikLTB018QmEsrns=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rscvkEnAQutu0Wh/cr65K4/VhJ6Fq1+UVrX/cniAeuZKahKOEUytcSBSddUSZaOaxR0yOcQLywXr6KFYjDzML/Za2KQkMRVly341psoMvKijRFKQK7qrXmM/m+CRB2Ecz4chY5LEiAiiH1LBhNE844Br48/iSxxgkHIxvNeC0x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bAglTDAX; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bAglTDAX"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso352727a91.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 13:42:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785444154; cv=none;
        d=google.com; s=arc-20260327;
        b=IDm7JyOa3JfAv9worvokEWjjco4ZVGOHzzUYUaFTW0B9avz2xsLEtVpAZhneWilApO
         RvVaHZ7VgFSpdu1OjoilJJyEeRIe+CJbihClZ7iRzQPvBYxWyprfN6745o5nb/dS7y8A
         RAU1mXcyA/EOBe9/YQWYbIi+xcCFx7Sub6JQbpFBhMcpYSByEqd07L9/jrecbwwzKuqE
         jVAnxAgXLlkSg8/XpxTO3mCd36YL2z57kfrEniicK1+AikOnJPC4Dcc1dmBY/D1XYw5h
         SNDw4fZYd1AR0ECBiHsp6++Sve2WETiYvMbvLBgQxERV4Rfan+tEy/XZyyd4g4nqbbfc
         Vk6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=tzyXsfKQYVbe7kXvY8Z4tL4HbFmN3e4/nufnZYtx15c=;
        fh=x3wkb4/89yoLPiybK7RCkljlKv9ayOVWs2jq+8X+DPA=;
        b=IsnT4MB/IT+Ng9PFddwBKv/D3TKaOU+bpy88jQMWakE7bEjWs6MuGxtUzxruJ6lhL7
         u5WeVQaWvCz7B16f/bOR/T4wbGcHOR0WcxWKvaxl//JXuftMBqswpsXmqzCWqb2cXVKh
         ULEYVgDuP2kWdZw6xN/cZpSja8xM1Aiel5PnCYHLaTW0N34CGocXzLJRZIh27Q2MDBEG
         2/HAGzRw2Ove1SUXvzRgByLI9RZ3RUGxrq2YuTQ6wlDuWoTIpajKbQ0YPCmz+f9nEhIF
         7tYkqbEkVfX1Fnb1TWQjiy1YaHoJw8QV4Q93Z/FNRzOCnUUvPo248bjRoEqfA++mUwnL
         0X8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785444154; x=1786048954; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tzyXsfKQYVbe7kXvY8Z4tL4HbFmN3e4/nufnZYtx15c=;
        b=bAglTDAXQTyF1QI2urJYdnQYs8AM7oEMOFaamKRGTXVUqR2kvlhSYLANE+d08MWXvY
         nH3U/5zIqj7sk8JavK1qY4WQyUE4KjKMu75Q7fLdq7yY6w1OJCYfzweSk1qmbMPhKVVZ
         LHeCrmGUtloTLYgTBcXHT8nloWIEDNKayMdM1tsGLGcwG1GPZwqk2ummotj3qcBFilKS
         wN+KGKMX7AoE061dpWKP6L6+2clcbI4cusCuSM8+MtTLGcV/v8ZBH73kROmEwzuuSCOC
         6IA85V8LUtz3zJIhOnqDgluEM/dUgrVv4aKwoABQplbtx6bIy4V3/MK3H8e2FCF9FERc
         YXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785444154; x=1786048954;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tzyXsfKQYVbe7kXvY8Z4tL4HbFmN3e4/nufnZYtx15c=;
        b=h40SrKxbXOirTe4kUgQzLe/T2POqLSOnT0HbKgGPs6oh6putEFBWJ75WhR1zHsHckG
         I6Ko3MD4Sp9vvDnVp8CEy1g8I0JG941wqeXPnQJFMuX4Fbt3YqAjNOxxwqQ20do7fYoq
         v1E61OtRl37GQ4g9kit2meQWTvE0kw6mtpXHjce4v/3Z/cfZ81QhUphPdr8PT4enNS6Z
         sKvfsFQi1J5uPM7/Dwyrka/tbRyYg9a/ffIppVCVRbfIBVipsKfJCdJWNMyNRTjqauQ1
         2buwSNcEwgJDtPt9BGdYpgWJ6H2+iXWo1Hm9TZETdTIDzjhLoWye6VCFha7YjJQx8Jf6
         EEGg==
X-Forwarded-Encrypted: i=1; AHgh+RqROvI6QYcQMIkhVCpxUakiom7GWES5QRHt31/fcqw1uqpa7nMCMZ+wL9PnoMpq3KCFEAg6nEW/YlZ6+Kqn3eErVUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVGp2o5NULTA4/7P/Bd6EEeT5rdZAJM0M8sq7X8uL7myZJTf1v
	TdYVfRC+THqvn4bm0wQLfQ5ZP8ph39uxRjoLDlDfFZkR9f41gDffIuDkqUPromvdggGLhnzpQGK
	7bPAz1xNCYJ+//SVAuHJR3coLQcQb6gkjilPJXXwa
X-Gm-Gg: AR+sD13Ak4tyNz2FdQXFYTk5pqUHQClxos3uIwi00OA1bdserv0B+xKBfCqafIDb2IC
	Wm98yES0NbXEDUtwWglis7wEZN79l3aeisqVfSzgzOxvftWT4OEeiv1ZxRDTbGJQ1nLF/e8u7xJ
	PuneOpPiEYlFwY52S7nRZ1kjK5/jUf8K8wrtncdPZvdER4EdfsNJuufEQSviQo9bDmt6xWngH1z
	kRCOrCG6qLl1ovToI+7XaPnoI6MYgVsMYUZeoISgbJIDbMxuF9bTiUdysfOjPdkSkXCGj272L9e
	9FnfLuM7TMe24Yx8dgiCqoB8PZZzK45lyij+W3NeIRDknuTi0j3xh07YZX2BcaSFXfg+OcFHGPe
	6/biwK5ksSQymOYFktbIwr5qZi0R7Ajooz4E=
X-Received: by 2002:a17:90a:d88d:b0:36b:bec8:94c5 with SMTP id
 98e67ed59e1d1-38f9bd790e8mr3699903a91.10.1785444153113; Thu, 30 Jul 2026
 13:42:33 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 13:42:32 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 13:42:32 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <60d19013-d6d7-4eec-827a-2622e22cec98@intel.com>
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
 <20260728-gmem-inplace-conversion-v9-7-35f9aec2aed2@google.com> <60d19013-d6d7-4eec-827a-2622e22cec98@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 13:42:32 -0700
X-Gm-Features: AUfX_mz2wy3LvLLQqF5XvT23FybAB1M_PJOCVj4Bbwu3P1vsWolBi1Qny-gSolY
Message-ID: <CAEvNRgF0SxmoMtqq69tUih54A9K7j_wcMFRrq=r9w6TnAGAUQQ@mail.gmail.com>
Subject: Re: [PATCH v9 07/41] KVM: guest_memfd: Wire up core private/shared
 attribute interfaces
To: Xiaoyao Li <xiaoyao.li@intel.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 7/29/2026 8:35 AM, Ackerley Tng via B4 Relay wrote:
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index 33c9830190e2e..89cf922232920 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -893,6 +893,27 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>>   EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
>>
>>   #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
>> +static bool kvm_range_is_private(struct file *file, pgoff_t index,
>> +				 size_t nr_pages, struct kvm *kvm, gfn_t gfn)
>> +{
>> +	struct inode *inode = file_inode(file);
>> +	pgoff_t last = index + nr_pages - 1;
>> +	struct maple_tree *mt;
>> +	void *entry;
>> +
>> +	if (!gmem_in_place_conversion)
>> +		return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
>> +							  KVM_MEMORY_ATTRIBUTE_PRIVATE,
>> +							  KVM_MEMORY_ATTRIBUTE_PRIVATE);
>> +
>> +	mt = &GMEM_I(inode)->attributes;
>> +	mt_for_each(mt, entry, index, last) {
>> +		if (kvm_gmem_interpret_entry(inode, entry) !=
>> +		    KVM_MEMORY_ATTRIBUTE_PRIVATE)
>> +			return false;
>> +	}
>> +	return true;
>> +}
>>
>>   static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
>>   				struct file *file, gfn_t gfn, struct page *src_page,
>> @@ -913,9 +934,7 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
>>
>>   	folio_unlock(folio);
>>
>> -	if (!kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + 1,
>> -						KVM_MEMORY_ATTRIBUTE_PRIVATE,
>> -						KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
>> +	if (!kvm_range_is_private(file, index, 1, kvm, gfn)) {
>
> It's checking if a single gfn is private.
>

But with huge page support we'd need to check a range of gfns... I guess
there's the argument of not keeping complexity for the future, but in
this case it's undoing functionality for this series and probably adding
it back later.

> We can just use kvm_mem_is_private()? And it seems can be a separate patch.
>

Do you mean that this refactoring could be a separate patch? I could
refactor out kvm_range_is_private() in a separate patch, then put in the
mt_for_each() check in this patch together as part of all the rest of
the "wiring".

I considered that but it seemed like the refactoring was too small to
separate out into another patch when the mt_for_each() part is going to
be in this patch anyway.

Or, I could add an earlier patch to first replace the call to
kvm_range_has_vm_memory_attributes() with a call to check just 1 gfn,
then this wiring patch would be simpler.

Let me know what y'all think is best. Thanks!

>>   		ret = -EINVAL;
>>   		goto out_put_folio;
>>   	}
