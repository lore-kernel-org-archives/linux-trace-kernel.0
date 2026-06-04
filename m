Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E483939D2
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Jun 2026 21:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780607676; cv=pass; b=i6/t+xCI3cJTnUj7SPyHZpWByoVgxl+osXchhy2h149p9lFzJ4HRUiRE4tWXOhUgA/jx65G3FCIT5aWnWiUE4rwEqzt6FrvCEcv7RxHn5wk8rq+ko24/UK02lkD630t5K7Gt/FRXI/EYEvbfSLMkZMl51FekruWIh443XvJadqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780607676; c=relaxed/simple;
	bh=3EQQ6v/Jh1n3vmJAx1K0KnEtPJfjxcjgCdoh94k7jVc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NdZkIlcypAS0PHkBLEsyZmL89LS6ZaUq+arPdEI025OuuMoncGre000kuyoVdOln7cgP4LSVlGcPeaVr5JDGJ57Tg1b0UTk1dE35Tpj9P4lYAN2aSWJ5AVN+gX4QIPxd65vaYmCTj0SCm/Ug82HebUYwcNAE3Zu77KtU//vGknM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HSRVmStj; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HSRVmStj"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-137f3cb3f46so2189008c88.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 04 Jun 2026 14:14:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780607674; cv=none;
        d=google.com; s=arc-20240605;
        b=UAx6F1KnEuJmXm3a33sc2gidKcl+H1VJfueMu1Jl1fKPREefP4DnHqLCd+sr+y3zQV
         WuUukTRIFQW9tN6rRzO6Muj6vthLFMP6UPrTKP8jgY+4VaaNhDDY67VzcOViLf6xqK6F
         /8ibrTnL67X9sp3wqQ6+JSub2tCGg4G1XnFujdwpQpC4iZOvsZCEYVXJXrpWay0Q4T4H
         5yrSZNA5kFyeEZL1TACODpZtLgC02eGq2MD34HBxVQqv0GfSPUwGxTJ81nitmlCM912m
         6lYMjL6NOwvas4jrOI5gv9Kli9Tr4WAUdp3r8nhIjoZLiYQy2UhrhUzi2bj8vUnCHy1p
         qDnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=lyPEsnWgMEwVBTMM4vHE6GHrBW2HxmanLD1B4poadMk=;
        fh=xDuDbUDASPmivmCQSsTNKZcr8LL6xd9bj+mHAnq9rS4=;
        b=DnW7moOiNBdq/NEWnh3sFRBbQ91gjWZnI4nM+BUGEh/MlcTVliwcP//HeSPVHo0EPb
         aUlTj7Tjxb3JuBsAv5bazXDZxZgeqgmnpcdwy2WPVcxhaW8Xdtx9SfKzE6z3VR4KhIUd
         XRH/k/UL7+AhrWvMj0HLShwuZbJ1Mip0o+oFzhvhKNq/HQNgQojHwutuv8j17rFmVYva
         BAiIh2NAPqowO98tt8e/8gLctZg8TdnqLavelnxmdvVI2YRhG9g2/F+PyaGHmkP2HCxU
         HJtkYzJmk17vjlUFdrvQ4/DBActvTVW5dtk1UNTYamUjbmd53BBqpGuc4pFlB47B/U9L
         TUZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780607674; x=1781212474; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lyPEsnWgMEwVBTMM4vHE6GHrBW2HxmanLD1B4poadMk=;
        b=HSRVmStjClcx3bpB0Nbb1WbyCagVBGV1o7cutwUR264MGwQtzC2eb77Y4bg1tLolFP
         UxRJgZO+x7uVz755belwPYpkKr0fa/sLsswY6U1FbRuGSq+FRLZFV9E37egIdz3AcdQD
         Y6oth/EnlnZP+/as2xeBZe3f7YSCyOc+HK+OHIlR+MxlsswubTEXHxmnK/Y/SXtN+RNO
         jjIk9ygzfucGJ4Lbodc642V544cS1eVP+enD/KpsMBJXgJncUfmlXv1lk0kIwxMlnR97
         hDrSM1KDXGTYGLzCh7o2tGiU31yb/ExLLod3UWlbUSsGzNOsH+nfF8R4e8YKs+r5EgoY
         Z6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780607674; x=1781212474;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lyPEsnWgMEwVBTMM4vHE6GHrBW2HxmanLD1B4poadMk=;
        b=bYpDYfE8BcFeyO3nkXxQ5d4+ZXKtZtOaXasMDXflTDbRy0xOKovSegyMVJnJzlBRpY
         h/TxRU6NTdBxbnPXJWFmhXX2l638oJrGNmskhoMOSmiBulj3T+YmOsBa9IDjpk1lqzZi
         xNEx1YZH7tOWpiNlobSePp3O2G9G7lvq1Y8/FT/xmsBbHKlJlIk9AA8n96t4BZT8nbfU
         Al0l7f4CAk4m+QKi7HAk0LxtXaGSGDv/LxlIBgV28SmaOackUVwiR45SHxzlBamffKxs
         vxLn4urbV9K2RIzLDFpmAqdt6Tn8QtC5T9qZJwTnhdWB/mylMg5dPMAlfYdaivZkXtIt
         ObmA==
X-Forwarded-Encrypted: i=1; AFNElJ+9bcThLFbfd3pG8QYG3VwpbXJZ8ay0UUtt6jBf/AGHnrutD8ztfdhqogqKewQl7y9eRdAuX440G7gAwDRDohYUkWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhBgjWAYSpQi7lYMQNBVXgWCem7UZ6+S1SrI6h6iciiZ0/LFek
	i7WdPsjbh2x8U50puE32vddlQTD1py6hyqw9IlSWi7M3D9hcB3TLP0GCij7JIKVaOLoMIM3Gsc9
	/xymldGsDt8dNr4uNaV/ktf+55CGvg60rbsMIz3e8
X-Gm-Gg: Acq92OF0c8wYyAYDXpm975D2LPdEI/qdOVrWLCUxowqLSWPU66Yo5DlFtucg3IqbyP4
	S/XirQu9FTidOzLQQp7y+Xzz5OKfKDiN3P/NUyTE/Md8wYO6P5wY54Bnq4Vs22uf8WpVyhD6CuR
	9cxHdwJZg7AQpobnmiTZLq9X7nCXyF/qxXNXELHXrbmF9wIkkIpYnwhWxYDHfQvzF/wUfu7YDKz
	24ryuey1++iuY9uiEpXcR6BwQy3ef7wvnrvNFs4MMdiaNPVhobMv/r8Oszsfocilcr0EY8UHtNn
	cx9OPN/3/HB2V+A2ULaZSRPU1+ODMPhXWv47JU4Wis+mEv5h7GEkNz0s0j/9faKqeVvTStddy3+
	eRsI=
X-Received: by 2002:a05:7300:5b83:b0:304:acc:f086 with SMTP id
 5a478bee46e88-3077b7ec417mr207174eec.33.1780607673246; Thu, 04 Jun 2026
 14:14:33 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 14:14:32 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 14:14:32 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aiHeDZEPkAcWcSkn@google.com>
References: <20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com>
 <CAEvNRgGpaggjd3=ooyzv7iEbmA-x1mWJHgjLSjPi8=5CPrk-yQ@mail.gmail.com> <aiHeDZEPkAcWcSkn@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 4 Jun 2026 14:14:32 -0700
X-Gm-Features: AVHnY4J7O-BvLwAbWwmNVfQCapmW0Jz58QA9MN7lFJVjBHp7oGK-p6NKEbfSA24
Message-ID: <CAEvNRgHz5GDjq0GqRmpQdHc-X45gCNr39VYWZH-T7XhPEtN5CQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/42] guest_memfd: In-place conversion support
To: Sean Christopherson <seanjc@google.com>
Cc: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, david@kernel.org, ira.weiny@intel.com, 
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
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Jun 03, 2026, Ackerley Tng wrote:
>> Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
>> writes:
>>
>> > This is v7 of guest_memfd in-place conversion support.
>> >
>>
>> Here's the outstanding items after going over everyone's comments
>> including Sashiko's:
>>
>> + KVM: TDX: Make source page optional for KVM_TDX_INIT_MEM_REGION
>>     + Need to move page clearing into __kvm_gmem_get_pfn to resolve
>>       leak where populate can put initialized kernel memory into TDX
>>       guest
>>     + See suggested fix at [1]
>
> That fix works for me.  The initial guest image will typically be a tiny subset
> of guest memory, so unnecessarily zeroing a few pages isn't a performance concern.
>

In regular usage moving the zeroing in [1] doesn't change anything,
since the same zeroing would have first happened when the host faults
the pages to put the initial image. When populating, there's no more
zeroing since it was zeroed.

[1] covers the case where the host doesn't write anything to the pages
and directly tries to populate the pages to the guest.

>> + KVM: guest_memfd: Only prepare folios for private pages,
>>     + s/non-CoCo/CoCo in commit message "INIT_SHARED is about to be
>>       supported for non-CoCo VMs in a later patch in this series
>>     + Use Suggested-by: Michael Roth <michael.roth@amd.com>
>> + KVM: selftests: Test that shared/private status is consistent across
>>   processes
>>     + Improve test reliability using pthread_mutex
>>     + I have a fixup patch offline.
>> 	
>> I would like feedback on these:
>> 	
>> + KVM: selftests: Test conversion with elevated page refcount
>>     + Askar pointed out that soon vmsplice may not pin pages. Should I
>>       pin pages through CONFIG_GUP_TEST like in [2]? I prefer not to
>>       take a dependency on CONFIG_GUP_TEST.
>
> I'm not exactly excited about taking a dependency on CONFIG_GUP_TEST either, but
> it probably is the least awful choice.  E.g. KVM also pins pages is certain flows,
> but we're _also_ actively working to remove the need to pin.
>
> Hmm, maybe IORING_REGISTER_PBUF_RING?  AFAICT, it's almost literally a "pin user
> memory" syscall.
>

Hmm that takes a dependency on io_uring, which isn't always compiled
in. Between CONFIG_IO_URING and CONFIG_GUP_TEST, I'd rather
CONFIG_GUP_TEST.

>> + KVM: selftests: Add script to exercise private_mem_conversions_test
>>     + Would like to know what people think of a wrapper script before
>>       I address Sashiko's comments.
>
> NAK to a wrapper script.  This sounds like a perfect fit for Vipin's selftest
> runner (which I'm like 4 months overdue for reviewing, testing, and merging).
> If the runner _can't_ do what you want, then I'd rather improve the runner.
>
> [*] https://lore.kernel.org/all/20260331194202.1722082-1-vipinsh@google.com
>

Good to know we have this!

Thanks, I'll work on a v8 to clean up the above.

>>
>> [1] https://lore.kernel.org/all/CAEvNRgEVC=fFuKVgZYvWyZD7t_zvUZihFG8hrACjvtkD5cwugw@mail.gmail.com/
>> [2] https://lore.kernel.org/all/baa8838f623102931e755cf34c86314b305af49c.1747264138.git.ackerleytng@google.com/
>>
>> >
>> > [...snip...]
>> >
