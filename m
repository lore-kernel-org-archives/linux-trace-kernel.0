Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437793CF21E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650363; cv=pass; b=lBdIdxCHxTGzKbKypx+7p6HG6IRrRSDeqTJl4M6vbGjb8LgxG4fX1xRUmFhVjI2ZoSwC9YDzCe+bjTantoyM4RUvo4Vn0vXKXIFQLO+YrZ9048/JGY6QNfVj8lSS0n3NvEfIpjpC9mQXxkTGQJBtgfMdXrhNLGznyuDFuA7jHNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650363; c=relaxed/simple;
	bh=JmR/CB4xNI+jcLTEmH96suuAwtFrH/css1uIDKyeEDE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4jpds9GbGevkjEeFasVYmEqMEaVISLTU5yqYpNfNoT13t8WgM1lUBmAk+SjASOhArrm335Qtug+MUOl/wvWK+HEVVmAIk8cijJTcwwOS3/TAzZEebl4+CKPmLgKFewq4dEmayRgMb1hAtuEYcBWUcfSztvy3fn6wAOtM5GNl0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=COhK4qYv; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="COhK4qYv"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c928bf172so33354041cf.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 02:32:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787650360; cv=none;
        d=google.com; s=arc-20260327;
        b=NOIBEOqS8J6mO9tWUyM6RNVuQ6//HjRNIYS0tp6cFe9rm01kq+qGiyZcSNM+u2Km4S
         947VCnAYby6CAqgtcr28hzonhTytz1YNR5rokvRL6hK+ZPUuSVosd5R+Ep39UYGKp88t
         qfln8KJVNnd+X6qu6OVPEs04jBhFG6vN8uvBz5bD92x3Kwv01l+/sftbhqJFbDDW72fZ
         oXd9aCJvvK/OtqrdRxATm3dOKGFlihNdMGeaU2qP/4d2tcyZLWkHXwbL4L70JGCXtLFJ
         hJLwIpC0k00Yk75dtpVaByzqPXTeE/TaEBbl0k1/nku0lkejtipgtY/hjuAYdYJIMCEL
         saXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=uGYcelPQ9NcToBmCcA1Af+U2AVoIV7KPe08HWX7sjzg=;
        fh=vOR5X2A0K3Q2vulHu9VzJI/AECnV479zsdIq2cQWKhs=;
        b=eMc6UPA8Wzrh/LPgQCUd7AsY85Cf+2VXYpNg2zCN5/xfjn6Ayl9UVJedcn2RRC5Pfv
         VPF4oQxuMJDnZkosyFe18D7mpgQprmYCYJpfR2mqdsuV+WgvGNg4qyq/AedTbgyxrNC5
         XvYKPfF52NyB+Z5X8omBO2LTodgM9UTtAF1O+t4z3pVF8lfAmGlFPGdGfKip1F6+AOr+
         HKAwdWgRaIACNR/A1Ogr8OgNtD6jOVM7TKThLN/UMlrgQWqzJ07WCu8hM0gcoaY6y//V
         SjwUu/8pGSSEWLwGSyCnkg2XOievEhQqWqVKgW41bQWCCzitn1g2rwDEJxM3ArbbRS46
         gISw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787650360; x=1788255160; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uGYcelPQ9NcToBmCcA1Af+U2AVoIV7KPe08HWX7sjzg=;
        b=COhK4qYvOoJJr+D43V/gT5xoxYixhbuEW3sQWFOSU/YW0eMfUsn7zourAB5zEVeqU4
         0Z+t6WDhX1//5aq5h0a//I/JnlYDqcQSDi1bKpFWXYtKmMuCMMiOCvWm5LDq/Oxlf25r
         ZzNOAZyfhlRKJEan2HpB3IaWqkW52eWyIopB7wRfq9X6476P7foLCSa6fJOK+0VuKbpd
         vUbIsefHSCFqqq3++sDiLAKYscX/2UWlR712PtWS5O/PaQbqx7z0uNmkyw/E9QcvhuBV
         cEJZj0GWoUq+wO8//74+Kk1TD8EkZMoU6TI5qJIDroligGGwhyYEruhOX9xUkiRJSIrv
         UYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787650360; x=1788255160;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uGYcelPQ9NcToBmCcA1Af+U2AVoIV7KPe08HWX7sjzg=;
        b=TdJ9ahiRmR94bmvNwEOWafT22YIQq0R6x1wKsgc7/PBHlVtLCbM/WN9hU66huiUpql
         0lI6oec0OcBqoc9VTPA2aVRN9+0+pqtrFcVmvAR4fqGZ7yqoJeZTp09LbmFEa7nF8GaN
         7pnxn/rq2CgV7YkYO3NqqA0ZyYmegAGkyTqOZTBum42lhFXiIDPBIP1Nw/I42VROK1WW
         j+0ScYLNyvYCNWp/dEMMU5xVUumytohzQVAqEspbT9n+l8gpei2JlKQJ+KubB18VWm4V
         zsiaXqEW7lg18qd3myaXhbrVxFguANaOx6nbZSZe/F0KTdKWPiMnROABGL7tS9fhZA8o
         IeYg==
X-Forwarded-Encrypted: i=1; AHgh+Rr4rTxEWx9yfjcrqmwANTKOcFTW+FMU5MslMZv2mXTwrnq/UJUSW/kqjS3Wgd5qwGdToxkOGJxrjpmuc6r3DNMO+DI=@vger.kernel.org
X-Gm-Message-State: AFuF++leh02estTHcfcFQJ+pwm0MX7fJ0MnEiB4yyzwIuw/uLlZZAi/P
	ugvRlWWFT7ZeUR3Q4s1YJgSp5E7GOtYFQ1YFDgYuWVDW2X09EJg1oOHn1ylorMzUGHNvs4AMIBQ
	duIn6sH73K4POpn4YejeJEOHM9ocncVdFwoCEGXoq
X-Gm-Gg: AR+sD11QYYPGAH/ETCo8+w03BnEPw5Q3aJHohswA+Qkxp2rkdrJhoUSK65caURibqgE
	o9SLjBuuSxO+UbtUlzyRu38vB6nBwoxsEex2jTBoVBjNmMAXL7h5zpWBIB+IW5b9Dn6IuDGCTc4
	msjrmz7GOtXU5+iDmD2P5R7HjMfTfmK7zVQ95uvZCIY++tYjLGEQNiIRJzEVLv0vGhKz6+mOMkq
	1OpHNlz31Fz+gstir/f3YdufXsdNzQgFuQNm7GrLtz8D6N0Y/Jg0fLM5LkZ2ewwEaeLFba45GLo
	XkkRPfhz8svxv/G69R+X4Zy9F3iSzehQ8MN4dnDvq7mZAA9GoB7nvGws0Y5pS/CvUIYNnQ7Tbu1
	wQbRyigADU/cq9hGvPKGb+4Uckjh0IYE=
X-Received: by 2002:ac8:5a8f:0:b0:51c:1eef:4fb6 with SMTP id
 d75a77b69052e-52df572d04fmr316920051cf.10.1787650359267; Tue, 25 Aug 2026
 02:32:39 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Aug 2026 02:32:38 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Aug 2026 02:32:38 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aohEz_1JFVDtlSnE@google.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-40-2fc18ee6d3ba@google.com>
 <fe1c6359-7371-4ccd-9807-1d81c160d12b@intel.com> <aohEz_1JFVDtlSnE@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Aug 2026 02:32:38 -0700
X-Gm-Features: AcwNN1WsNauanv_gwVuUewgYIPtJyz0xA7nijfgKendDL3I7JaxAnreMY2X_gzc
Message-ID: <CAEvNRgF8XE2Xsn-g3qzPxcdfLdvJEc1FZw9LQ+deeXsFpdZsOg@mail.gmail.com>
Subject: Re: [PATCH v10 40/41] KVM: selftests: Update private_mem_conversions_test
 to mmap() guest_memfd
To: Sean Christopherson <seanjc@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
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
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Aug 21, 2026, Xiaoyao Li wrote:
>> On 8/8/2026 5:53 AM, Ackerley Tng via B4 Relay wrote:
>> > From: Ackerley Tng<ackerleytng@google.com>
>> >
>> > Update the private memory conversions selftest to also test conversions
>> > that are done "in-place" via per-guest_memfd memory attributes. In-place
>> > conversions require the host to be able to mmap() the guest_memfd so that
>> > the host and guest can share the same backing physical memory.
>> >
>> > This includes several updates, that are conditioned on the system
>> > supporting per-guest_memfd attributes (kvm_has_gmem_attributes):
>> >
>> > 1. Set up guest_memfd requesting MMAP and INIT_SHARED.
>>
>> If I understand correctly, even with in-place gmem, the model that shared
>> memory comes from the userspace_addr and private memory comes from gmem can
>> still work without passing GUEST_MEMFD_FLAG_MMAP flag.
>>
>> Since this model is not prohibited by KVM. I think we should keep the
>> testcase for this model to ensure test coverage?
>
> +1.  Deprecated doesn't mean unsupported.

The original test case was for non-in-place conversion, which wasn't
removed, it still passes.

Is the ask to also test, under kvm_has_gmem_attributes aka
gmem_in_place_conversion, to have guest_memfd used as purely for private
memory and have shared memory taken from somewhere else completely?

I can rephrase the changelog and change the code to clarify that this
patch is meant to specifically test in-place conversion with MMAP, the
intended usage of in-place conversions.

The ask to test gmem for private and something else for shared seems
like a different test that can be added separately, perhaps in a
follow-up series?
