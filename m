Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A5956853C
	for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Sep 2026 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967523; cv=pass; b=cnV+geSOS2u0l4xOkTjsYT1B1sKsEshDXCPHs/fcEGpIfXa6NUe4Jm4IggFnEOqI4LjmbAmOR9xxClaGsqGcoeZVwkVKvAoxzuqnn2f/Qvvgm7fzJrLJFHPhWoFS2U7jfNvXWQCUPnnFdS1lF0yYqdGFf1zispGLHBS5KlveIE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967523; c=relaxed/simple;
	bh=uTvLvNOiD2VaPyg22uQpYQwhoB6nWQlo6kn+/rYg9tw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcy5Ng5/AsCuTYmO/F3cx+g3htvrapg+EXg5kqC011JEmOPIhxBGgQID3waOu/ZhkPZJwyQqR/OiN+8kEOO4yyAmJyRZ8mwGvihyDWd/HsXP6dis67i39hCouzgwRD6UnCG9e+Egyk0TSzvJyyun0RXy2yn5x2KeEB0S5rcN4Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RWGxi4+l; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RWGxi4+l"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66c7e3a2332so4747511d50.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 09 Sep 2026 08:25:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788967520; cv=none;
        d=google.com; s=arc-20260327;
        b=Pa1mzMlzLCUfhAuVYz08fKOCnCzKdHIiQtr9wjPkFqf9/Nw6pD49QAbVdmO3wtM9iD
         ekl2kLN5saZlSRSYZGBf/eePRAXXqyO9c/qL5uIGYSooJGukLNvOq1cyiX+2ZbSZ3g9z
         gJLDZxbJkjI+lAevNlLie3XDZLiivbsxSHTuM2w1mnh2A+P7kxmAMcSPk0mIwmE5CtHU
         amRGwPSgyzejarUyb8ypFx/ysGftikTcuUDaPHyUJmAcBKF7V9zdAIJ9gI9IxE+5rD1H
         7xTg6kiwW2KMyk/lUXuhIOzCUmAWtSTqOPyrXr+D5ipMiehSLwgvdbHrB4/juqtq/dc1
         pfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=m4jJh3TX4gx98qaUfn3Q4oVt1KTvxUkS7IflLLQjx2I=;
        fh=nXonjZePumdrbaog6T8SQ7PhzhWO1dI4kRj8yBY9huI=;
        b=IONaLrV0NeEH3k7FPT6QRlIkuUdkuM4nOjn8MmvXMJnBa7cAv5vuqU7Zbm3SikYSnd
         fkCx88fp0utBlJuzTjEkfFHhTU0f/9mcbr+1c9VefKsvX0dFSUMp8CoOkUnZ6jopXXKs
         nTF7auFh9/jio0czs8KPMjWLUAsygi52tEHTWn/c31K7rM5HYmTn7ms0FZyVA4OGv5cJ
         MXE3o2g9fd4H3JU0tbHmuVlUqpT6twKt+HL+L13EDZzEp6nLMXSo18Ke/sqKrduP0k8y
         gYyxwuoht7eGBwYsvpKvKBmD74+4uF8vyA0hg2Jml47msHj+leCdgmw55PBs04wLfE1B
         4uMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788967520; x=1789572320; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m4jJh3TX4gx98qaUfn3Q4oVt1KTvxUkS7IflLLQjx2I=;
        b=RWGxi4+l5Cws4SFBhyNBgN2rFBHxmaxLWMrmyyZmD3JtS10IR3RUc7Gr98Jo/elm7I
         55ELv6Ef9Qq4Opc0Qc2GFDnU2OAdCkh2UlLN4NzMNJCN/t4vCaRmF0jrEUtJrFCXWi6Y
         N73zfAqP4/tLfluPAC8hHPMqUAwDywdNwqYB1WlPUQBdJTUvGN6jpeHr/eawNaBNRjhk
         MVZ0idlk4IZivD1Cg2jWvIYhyZByOzYvsMplov25jOi1/1u3tDEEs1iM5I0w4o6GkPFe
         Cur6YqY1HxeSvlA6EZnyevxos/F9kmfQX+RrieN3itAafB3dY4NPpJ6Q62sQQM9GWjkf
         AsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788967520; x=1789572320;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m4jJh3TX4gx98qaUfn3Q4oVt1KTvxUkS7IflLLQjx2I=;
        b=Br8mJbbyW/qCsQtQLMCm2Zp3vuezZcOIa0hsc8/PbglwobFYvR/h+NMwQNevgvsUUM
         TsTwqmtPzZjIixWW355aGtjJ/tqRrxEGJUq/mJU7BHOrhJKGm0/gFQYNCpp1uYOQL5DO
         tVN92p7KtmhfV1eFyylqEXUJWlQ7UStuTma3IBiMapiXaARYdP/xagdIri6Mpotn3euB
         x5/8NW5eqbP7XJqoMJEiakna2fKQpBKqvF6G1duGHpvlCfh9QrqyVsA7XzvKy6gJkpd5
         kfEmcY5gJrPvSmw9O+1/HaY6s7rjQ4724yXZnkMyjZk2RPgDQd/zlzitMPJHMZzKDzKr
         x2xA==
X-Forwarded-Encrypted: i=1; AKwUvBwlRP61AJf5MMKl4huNhyZm708kk+8a+V99TVhcz7V4jMW2bSYiyez2/6cdiUoESRdiHHz5EBU6JQMicQof7lqtKnM=@vger.kernel.org
X-Gm-Message-State: AFuF++lHAdrkLuPcnqcYSrVnjMN9k4AtDqDzw2EPyLCdI5Jb4yoFrCvB
	mas2m6PPocjuEBwk5j66QsITPA1bj+IxnUIScncgJpOr+aBEalsXjXoRPsesJWbE26K5rp5YbjM
	nFZs5LIBupbsMrzI41Zu2IzC1S6/nCPydx8bFX0p2
X-Gm-Gg: AYBFou2Qd1YcxDR50XmllAu/6kuz0sxiKAIC5di4D2tpDnc2/c1x0gCTABVnNxNWkni
	rjJHBIiaKBd0FPjL6PUblQr6aPGjI1xe56Pl9Kq1qJNO1zFbOtjiokbIOnPeWtckMzjr5erTKkf
	1DXe8KTPWmqVaAiODxXjU/e6hkf6MR6l5POVEpHtD9qukwPfpUvbwk0egxgBmap5kgYMQAOS0vP
	LuKQSx0aBr/NWHlFiQq/dBbjjTYPeMnQpzeT3aSPVIG3mXtbEfft4N7AMOHqiRa+GJnC6z/1Lwj
	wyclCP2bJuqKLK9TisvivpZTY0VRwyKCsfNmgEknVl/ndVSe7JGzfOSvctITClIoXmZZby4qjPU
	RcxZXzH4EMdt9
X-Received: by 2002:a05:690e:d0c:b0:66c:c7e4:2ff1 with SMTP id
 956f58d0204a3-66fb59519a7mr10665340d50.15.1788967513698; Wed, 09 Sep 2026
 08:25:13 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 08:25:12 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 08:25:12 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <bd6c9c74-e374-a9d3-ba1f-8b6f430894fc@google.com>
References: <20260830-gmem-inplace-conversion-v12-0-85e5fd25252a@google.com>
 <20260830-gmem-inplace-conversion-v12-18-85e5fd25252a@google.com> <bd6c9c74-e374-a9d3-ba1f-8b6f430894fc@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 9 Sep 2026 08:25:12 -0700
X-Gm-Features: AcwNN1XO0ky4otDKucsugFRBan2HEERm69mRZ8ScY2_txSdjnOuds0rILhuqOBo
Message-ID: <CAEvNRgEkkvk11_atVj9=+OBym-7SbSMB7MpHcoN6-Q5KS3Lb_A@mail.gmail.com>
Subject: Re: [PATCH v12 18/45] KVM: guest_memfd: Handle lru_add fbatch
 refcounts during conversion safety check
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Randy Dunlap <rdunlap@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hugh Dickins <hughd@google.com> writes:

>
> [...snip...]
>
>> @@ -926,6 +927,7 @@ void lru_cache_drain_for_folio(const struct folio *folio,
>>  			*drained = LRU_CACHE_DRAINED_ALL;
>>  	}
>>  }
>> +EXPORT_SYMBOL_FOR_KVM(lru_cache_drain_for_folio);
>>
>>  atomic_t lru_disable_count = ATOMIC_INIT(0);
>>
>
> I don't mind about the virt/kvm/guest_memfd.c part of it, but I'm finding
> a KVM patchset modifying mm/folio.c there hard to deal with: and notice
> Sean also suggesting to separate this part out.
>
> As you know, I've worked up a patchset "mm/fbatch: drain lru_add_drain()
> and _all()" which finally removes the problem lru_cache_drain_for_folio()
> works around. In the initial version posted a week ago, there was no
> lru_cache_drain_for_folio() in the tree. Now 7.3-rc1 has it, so I
> intended a replacement 13/25 in my series, giving you just an empty
> inline lru_cache_drain_for_folio() stub (and enum lru_cache_drained)
> in linux/swap.h.
>
> But that won't work for you, if you're adding an EXPORT_SYMBOL_FOR_KVM()
> in mm/folio.c, and of course conflicts with my removals (in context both
> above and below your EXPORT line). It's easy for me to remove what's in
> mm/gup.c and mm/folio.c, but I cannot remove what is not yet there.
>
> I've wasted hours on this, hoping not to trouble either of you; but
> seeing now that I shall have to rebase anyway (an unrelated mlock fix),
> I'm electing to take the only clean way out: I'm going to submit this
> mm/folio.c part of your patch to Andrew tonight (with a shorter Cc list!),
> in the hope that it can be accelerated into 7.3-rc2 (or at least get an
> mm-stable stable base-commit id) which we can both work off independently.
>

Thank you! Will use this in the next revision of this series.

> Whether that's acceptable to Ackerley and to Andrew, I don't know
> (just as we don't know when either of our patchsets will go further),
> but let me try.
>
> Thanks,
> Hugh
