Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A1C492525
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786730269; cv=none; b=B5JIFxyZ4WSDetjapwbOkr4Q09l9UUKcAweRIjTXA3NgjQ1e4x8cF7q1wqjoL6SmDpdFFsL2UUeVbnCF/3VgrrVD9XCNb32ESNiPM4H1zfuYZUVAXIy5CosRKlauD3x/p3zMm4MixVE9+KFm089LC93in3JN/lmpnK8pgEQiTjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786730269; c=relaxed/simple;
	bh=vfWVk5cbC2alWZ2RcQ2gPFo+PGPYjPxWOtNwHPYXyoc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A0xwpdi+BUcJ4cbZ1GAZ1mbInXjHHh/LkwIOQ8eYLtVGGQC6BMTt8yTgsb7QzQT48MfA8CV27skqPQsL9+ymS29kakaNB56fROKHJXpf7atumcZ9vnOCHBCdJbsRxg6P04yye4nDzotqdV7PMPF8n1oXKTE0PVTL4UIuAVm0MjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T+cbN0QJ; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T+cbN0QJ"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ce8a76df2dso26629485ad.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 10:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786730268; x=1787335068; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FTRpQbBcuIQQHhR/UQMYNM1PA+jfAXsDHcYqcmWTXOk=;
        b=T+cbN0QJAG39Q+VhsESLtUVozx52DEwrqTIq1n7m3RCErpkB/FlaWzlNjYiXyph4p4
         bKL8YGFd1mAZmlWpS91ETHhFpnGGg99yNovCiBsn747I9u5UWB5IDDrSTg8g0fyTpqYw
         axNYimylIvtry/W8h3GAaTobIjj8h/aJpGVQPHk2j15NK6HwdD6WRu/Q2ngNigNdw1Qt
         EWf/HZwIi296XSK0LRAiHEdIFBwfaF/ZVReRFYpClR+4WUywxdkuD/J2Mr+AHNauhpOD
         tqIR53WxMONQHgfQXrPoGJgzNPors3Nlf8gj/T4mLWK4JbFnsGNT2CpngcYgtHCWtlAi
         5DOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786730268; x=1787335068;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FTRpQbBcuIQQHhR/UQMYNM1PA+jfAXsDHcYqcmWTXOk=;
        b=jfZNF8EesepsMg2mql/HO7SEdt7EvxeBlsQakOEpWxuqy/dDmnpTg/ffyXqy9zLGjZ
         vnCXX24yqsIdDqXuGYSbNVs5m9zHsrsJvR/t1ijQ9SdkzCuJyaLyQLCgl5yfJfsjlXGo
         JYwWwi6TlzhYQs82Pp3sr5KvzmkFWZwGR+jpl/37yQmoHnq3j6v6AG3TXnwXxy0z4K2M
         F+UiTSiCoY4Jg+mOTqrRkFUILGf4SGw7eyw1bnd0snRBhvYB+t0l0hJXTFU2YlaA8/ZE
         3PyNri1z9NLyi53nnvjT1g5SelLFHLsGJ+ok6eSbQt/exC9I1g5xq6+JjchlP6WxAsqy
         IQDQ==
X-Forwarded-Encrypted: i=1; AHgh+RorDgKd2ums3rJ3kUQkMbyi5Mm8jiCe2K9rOs4kKi1YKwwLRTzBqSzISQFzInmzwqXZQD/t/8TRUK2gEzSpYDyu8zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgEz8yHQlLdlK1y9FwsS5hIUFuC7a1VFInySBIF1DkbdPe0JW1
	dFIxUTP2yJeLV1to/eEljsi3EuAqS8THQxFS7BNs6m1cAW3A2r9WHhY2Z19r7KInEnMbbinbVn2
	HB4tWQw==
X-Received: from plbmt15.prod.google.com ([2002:a17:903:b0f:b0:2ca:5dc9:51d3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c6:b0:2c0:db23:4c4
 with SMTP id d9443c01a7336-2d3b0c8852emr91417425ad.16.1786730267363; Fri, 14
 Aug 2026 10:57:47 -0700 (PDT)
Date: Fri, 14 Aug 2026 10:57:46 -0700
In-Reply-To: <36baf0ec-0b7c-4ffd-9a1e-dfe9617e057d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-18-2fc18ee6d3ba@google.com> <36baf0ec-0b7c-4ffd-9a1e-dfe9617e057d@linux.intel.com>
Message-ID: <an9XGrcPw3h-ExA9@google.com>
Subject: Re: [PATCH v10 18/41] KVM: TDX: Make source page optional for KVM_TDX_INIT_MEM_REGION
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
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 14, 2026, Binbin Wu wrote:
> On 8/8/2026 5:52 AM, Ackerley Tng via B4 Relay wrote:
> > From: Ackerley Tng <ackerleytng@google.com>
> > 
> > Update tdx_gmem_post_populate() to handle cases where userspace requests
> > "no source page". To handle "no source page", populate (perform
> > TDH.MEM.PAGE.ADD) using memory in-place at the target PFN.
> > 
> > Allow "no source page" only when gmem_in_place_conversion is enabled,
> > because retroactively adding support for out-of-place conversion would mean
> > requiring a userspace update for a feature that's being deprecated.
> > 
> > Also, KVM supporting "no source page" without in-place conversion would
> > effectively be an obscure zero-page optimization that relies on the page
> > being zeroed when it is allocated by guest_memfd.
> > 
> > Rejecting "no source page" without in-place conversion scenario is valuable
> > for KVM developers since it helps newcomers understand what exactly is and
> > isn't possible.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> Nit:
> Is Sean's SoB intentional here?

Kinda sorta?  I handed commits to Ackerley after rebasing them locally at one
point, which is how my SoB got here.  I think it makes sense to just drop them
from the patches where I'm not listed as the author or Co-developed-by.  In the
end, I expect to apply this series and so my SoB will get added backon anyways.
