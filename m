Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEAF3AD50E
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 22:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440084; cv=pass; b=qvAC4z5sJagXAoQYrnqos2OjkspVWXYnZb83OI9XLoNkSNcth9opRIMpucgnvH9aIJ+IVZusSBI/rKNAB0Y6qKn70/xoU8Jr6siY8tRq6Yl6meRDZXBXdtrjvLVIA6pQb5nho0wdPFTF2c2uhE2Q9mkG4sJj9KJldonCldtx10A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440084; c=relaxed/simple;
	bh=JN5w0VLC4CArOs/YqYBchGdpeM2L7REgIk+BeZ3c7Nc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFPAGPk+1ZeKQ5ukR3IDvp2wSynPw1YmpMO5+2ZbZwbtQYin5iKltPC32nc+AuVe+6TmS6tQ2BUJsPWf8sAmLLl/Bg2YrZseFrTtQLsx+3moU9QqYiILNkAKWezlEodGz2a4OfncIIKgcvLUaNyG6xq+MQiUtiSOXlrIqoZ8Ubc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OLdpuuzZ; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OLdpuuzZ"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-137dd523634so4883182c88.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 15:41:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780440082; cv=none;
        d=google.com; s=arc-20240605;
        b=cle/OvxU1mIWGP6/G6aYpThTWKEgihyWzP0u1Iqoa3jYLsOiGKUFcoJT4laESIBAdu
         zoaZ8HuINftbqldENiATR8nTEEvgauBbZGdxX8PCouTWJZvv+DE9/UKmq9e/VTRkCvGY
         I4/az7SzlQ30/CMbl0tA49bx+TeuayF4nSVgWa8gjSlEldjMUaHqNMRobIsrmoYLTP5W
         bRDqeRHDr+1BoID1tbCneuLMaj1df70r/bAjyRPAPEl/1nnvVEZGCFYZ92SMQCfQIO92
         4wZ0ZQVy+If+bBnMD8xmAoenTNca3RIsrnFleKVjIDXNcmPxRUFRLSMk0jY4gg8F1oeK
         t4xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=9Zpj3jj8aTNr4p/iPSCl+ydGEAQL1021/sdQMyQbGis=;
        fh=g1IWwCJnZYqU/oe8VCSCN20qimaLHXUskeLwrJez3zA=;
        b=fRn1zjPN2t6lFL35k0T/dQu4D3eZqW1ZK+PR/huauNte2uw+Vg3GndL+gHBo/Kp+Xq
         pBj4pn4zYfKYZvIHLftNWq1TcxfVCtALFOQ8zy/UgJzRB4Q1N8sct2UPIPPrK4rhft1J
         HLJ5Lgm/5qW9cDj9ekcrSIQ80qojwS4E0dRLxaWDj7PlOqdUhqyCR5hvBaAHaA1bLebN
         4bOJ7KIG7mTj69lmH+EEkMIfegMYYsx/1UMruao1+6+AZlnaMADd4FMkYTxfOF4HMvpC
         BCxudwaxwg7F6G6ux5LCTl08VhZNZPEIaJO3TdFtJTbltJkOkDZ+0I2evT2lYbqHTC3H
         8XVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780440082; x=1781044882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Zpj3jj8aTNr4p/iPSCl+ydGEAQL1021/sdQMyQbGis=;
        b=OLdpuuzZDB47YplpmtAP4MJX6E8SIykbgJ59+5rm698PCRhUth1naGUs65Lu/IeH4N
         ktaZJLkhg0AECim8CAiss+raZ1tL3+xj5x8J4vTFCWyH52UwhtKMpUP3YFLnzflInGxe
         gBlAw0xf3m0ndFGggP8kAVwB7KfALltPNU6hF3FzGQf7wJmpllivrfKTMNoruZDSXoZS
         339scviSYJyk3gU8ZYDJICqQKcYeYM7F5gqrNqVreAcke/GozMlRPW+ugYZJd3OMUm6l
         QQC9Z8QHO2nEEXfI6mQFaJR6s1lg852u4+rNjjci7JsAhk0fCfrr46LzOkPwmjaJ9JgS
         VlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780440082; x=1781044882;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Zpj3jj8aTNr4p/iPSCl+ydGEAQL1021/sdQMyQbGis=;
        b=I6zH6LoHzLOxVVTgtLI8M+Oc6DQzTDAM8oh1HExf4+/OvXUqHS2VJmnTL4IrqDwWNm
         Duy3cdGCyHZstXg5jJLm2ghRDzvglDpW1fwcvw81XSIYb2bArx8nJUzerByYdizB8oZE
         ebi9QfbVQBhCZqLwdmkOOW4pX0GQ/XNCrbQp15wF3NAng6W4d+nb34Wr9r3vK9iL8uAP
         +f9ZY3pzLK8aJXz/YtGgcJ38HgtsBeC6ykDKuQw2SZ8K4BLjVaFTYv7Rnlnqqxciv14B
         HFggpkW8/KgpjY7yTR2zUMFrtr8mx4igQ/dxbPWEHqvrQ/hI19RblGa1sI5xsB7YXjLA
         eSJw==
X-Forwarded-Encrypted: i=1; AFNElJ+XxpYT9LdtqcfNKbjdbXFYtzj476H523LtwWm+4kfOtcyOiWUiPAVbindOOjoAU3L0qOK2jgTJZd8qQmZmAodmxuE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5lgm5WwgMm1YsHlKUU/D1WTbTDdcOOIuHdI8LF+iz5baTBs37
	xYG4w267Q9s/w7np38LiW7tTIJNshSQ4ICbHuhSUlfaThEhsnSMwacU8wyXcqYL0jtv/16O78tr
	xuZm2Oh9h8oZS0eSZLlbJl0tvCEnJUiMo1j9HRBqi
X-Gm-Gg: Acq92OGIkY1k+cZjbahq0IKogXFrtcdxke7HobRhMidI29d8Q727NRN0T5QllVqSzFh
	+QGIofShie3mHjQLPfYy/zNEHuiH94/WfLqXdYp3iMixB3YrUm/e8B9kkgZApHuXPuG141t6MZh
	xJEgiikHWu6Jiu6ZN29ou0ov876j4BT85aPGbE1Oxc2eMZbvaGychh3rGxnqpPCEvJzRRqDwKWg
	2wVom8C8YT2BSAgY2uomUiVrfp0OfvS3SokbgAlKXWiNCR/YhA8ecDD8LAg5AhYt/qbECIxaoL9
	KzWL47LgXLDTwoeryjYP6TvM3Qq2WhSXUIp/Bx1ItxeL6paXao2EpFkhZGORAH2JL4JJ8Fwg0u1
	0e5bY53X8CDNAGm0=
X-Received: by 2002:a05:7022:6ba8:b0:135:5d4b:2096 with SMTP id
 a92af1059eb24-137f6bd71e0mr275458c88.36.1780440081068; Tue, 02 Jun 2026
 15:41:21 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jun 2026 15:41:20 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jun 2026 15:41:20 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <144bbb9f-39a2-4c90-8903-51521e022da0@arm.com>
References: <20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com>
 <20260522-gmem-inplace-conversion-v7-7-2f0fae496530@google.com>
 <d01cf1ec-b85d-4af6-9810-8107c0e2a4ec@arm.com> <144bbb9f-39a2-4c90-8903-51521e022da0@arm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 2 Jun 2026 15:41:20 -0700
X-Gm-Features: AVHnY4Il1A6xpCFYh9Ccj4ryfsVj2nvlEe4xvqbfHFojqcjHjss1rOCXb44vh2I
Message-ID: <CAEvNRgE1dCVAxJWd_hyFa8N=m9JLfn97ip9tAmvHxspWJ50oGg@mail.gmail.com>
Subject: Re: [PATCH v7 07/42] KVM: guest_memfd: Only prepare folios for
 private pages
To: Suzuki K Poulose <suzuki.poulose@arm.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, ira.weiny@intel.com, jmattson@google.com, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
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
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Suzuki K Poulose <suzuki.poulose@arm.com> writes:

>
> [...snip...]
>
>>> @@ -914,7 +916,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct
>>> kvm_memory_slot *slot,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 folio_mark_uptod=
ate(folio);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0 r =3D kvm_gmem_prepare_folio(kvm, slot, gfn, folio)=
;
>>> +=C2=A0=C2=A0=C2=A0 if (kvm_gmem_is_private_mem(inode, index))
>>
>> Don't we need to make sure the entire folio is private ? Not just the
>> page at the index ?
>>  =C2=A0=C2=A0=C2=A0=C2=A0if (kvm_gmem_range_is_private(, index, folio_nr=
_pages(folio)) ?

I was thinking to fix this when I do huge pages, for now guest_memfd is
always just PAGE_SIZE, so just looking up index is fine.

Is that okay?

>
> Or rather, we should go through the individual pages and apply the
> prepare for ones that are private ?
>
> Suzuki
>

IIRC the plan was to make kvm_gmem_prepare_folio() idempotent, as in, if
a page is already private, just skip. Currently sev_gmem_prepare() does
a pr_debug(), which I guess is technically still idempotent.

I'm thinking that the information tha needs tracking to make
.gmem_prepare() idempotent should be tracked by arch code.

Does this work for ARM CCA?

>>
>> [...snip...]
>>
