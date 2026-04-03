Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829E93BED24
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Apr 2026 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775227821; cv=pass; b=G522Fy3tuxK2uyv1MCK5G2PV+4WaUufREQ8Su5RU1kpFHecCV8NjmqEzYndJScViotvDlVsyOj1ydBad5ZUchGpwlJJR6qL4OqgOnmg9RKmh0mhHTBgWedS1Bt69NIhjCSv2ZEYOkoY5oXTFY+hf1Zcmr3O3OgM4VMdG+r5Skts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775227821; c=relaxed/simple;
	bh=I+MWzIcjsJY2NaaxS4ZYHOH26kmrsRv9LK+RJfKkIC8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u8zb0HW3ekbTn2H2X3uqqCqs0v2Ynv+S7QNGsqsVizzxJ8Q/1BrTSHP/Gs1iTNQsVxr1msahjhQ3z2XpXHXe3SQQKqa1aEGpLbgaV80BNSYgMmzLEfACzBJl13OUvuxggU4Y2QAZfeo6po3m9ybRFhp8JSUUY+kZ4diFkZ0M/MU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NGK1DH3y; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NGK1DH3y"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-953af2af419so615317241.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Apr 2026 07:50:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775227818; cv=none;
        d=google.com; s=arc-20240605;
        b=SLbhEnnJd7+6xw2yjEV4Tnn53euI3wCMS8Wg1DkTHhkPBAgozD6xU2zbvki+0lZi3f
         CCIpJUwUH3wY1psdRj62Y7BEf3U5hogWGlnvDioqs36gep2bALiJTVooj9IxyUPQeo5Y
         BmT4zdnd2WqB1yJp0MVpDz1xd5JLAue+TLp+NeAXXx18JxoX9mBKXLjNZYODGPPC5waZ
         c17MGfIFh4NwhgqeGi+hMrXS0IkOiljT7/1WkwafFh9R00FXPf7NHHzPCunHdQEJOieP
         Ww4hZ/oCSd7KczjaiC3TeC2IdsWo9aCQbvBHzQr0dvNDYatZz3MW41AQtK2R9r/kdyvI
         Qqmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=2nO332cdhj8pkWKcB2XgZGKk4lKtIFb9kXIiefVqdlI=;
        fh=NDxrbsyClV4TNrWdQRhbrSO7ie5eDis45SpL6A4QxEk=;
        b=P+PjpcX8AIodZvBQar+16yMxO5qaiFtfu4q9j5XcymfWksRZoKtJr6pmPxNICf7JbS
         tCN7Voi+YB0muCLNVXhZ0awhwds76gs1aHAYN3+EUqLoRax+j/sYGmLlaRBv5JFaZQo3
         6ElrAOWZo2q8bd08vUi75ObMPQ+4a3k03j6GRygXI7F808UHnavx6u65hrLeveGer9oi
         bFFtoJ5ERGDVDu1O0B3SoAhzEiG0qCHNLbVddwBL2oKmmliwrtkQ4f2W2L8xNfnACIP8
         wbI0GPU5Gsd5hANd7BTDnHBbwmZbK7hjQfymuwUII7EBbzMmFvEH61L9cuytTSP0JuR9
         oLQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775227818; x=1775832618; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2nO332cdhj8pkWKcB2XgZGKk4lKtIFb9kXIiefVqdlI=;
        b=NGK1DH3yyn5nUejSMB0t9cy6aOLKsbYkj6IBg4L7FqZ3yr+oMSxT420e2LtcIR0DlA
         By/DZyB05YL4mTfMOYOa6OoIIpRgTpGraEMBlr9hoDuF0EyUEibEdUK0DJG5cnSncINA
         MIpweP3nBuVSyvKHWc/S30NLstZe9iqAgnOGq2obdA5dIWj9tU7IIV/9FVhuR72yh9Xd
         TgNIFM1nZielDcKTROVl/BGJ1K7Q9N/9gQz4deGgtbn6FTiRIAd/cEIOYPDbBZD2EkPu
         3GTfomPcbI5Op/tNJ/0JjEWkVbw3eJB4+Mbrmb1YxEcdYJQWUghr/EbW+A4G0DsL78F5
         OM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775227818; x=1775832618;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2nO332cdhj8pkWKcB2XgZGKk4lKtIFb9kXIiefVqdlI=;
        b=JpMINcgPjb00U18Jz4CS6SaHKWc2ZVwZGNhC2+I0SuSLGubA0X8V/K6MeSBfiMgivy
         EHsVXMG3WeO2Fa189zYI+Dk7tnqfkEUyDsaXp80O1ZoH4h0YIYYGC5uI8JGUK7uOmGmm
         UKjokaOBBhQn+KuNXF8DQEMpm27cR35Bypy9yAJPxQrfIDCHtDjEnfcXlKQBgQsNjKye
         GfCsTTv8MvH+BeV7NEna7jh2V2BuYxq39TpuFxVAuM+ymattWf7gzZiBMICsHl9obwvo
         duRe/OyTv2IeSS6idKVS88OV830JVYS8dWh76EKUecwLxzNm+oetIPSZbn1SGCsMyuTS
         FWWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6ZXFbT2V7DP4t+dDxXxnCrD+G2ffd8ZDmWK4TxLe/OadzrfFmduLZB99X882ypTReAQXjtahGdY8W43D5O0Enln4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLIRGq619AFOjWDlrxwVtTMdGiMvYwqX6Bn3GpGwGFIYqOtWoJ
	QgVrH109MAwdClVjWG3LB00sr8fcd4sozUahUFGHEe3/UknUnnhemullet/v57VuEBNbybwSx3P
	MBClZHQ1qyLe++BQOAEat5Zfba492TK88Ky3pNpfl
X-Gm-Gg: AeBDiesT6bL7lE2RnieYkcAdJCX6cET+AYIguViXw09rWzTlJnFGh6+HJ408hvc56dT
	ZkhcyJt1E8I9jNTfzMUmcpXHghCEDyRmbEFPhHLSm96iF9E4D0R88cxK4a7sfM0aDEbNXmcJ3aQ
	/HfuFi+vMB0y5iHJYEReOCC4Gu+vLtBbGvAO9l6tkT/jDMv4Waky55zgEkkTYmj/uUqUxmutzGx
	NV0rW3D6/OO7WCepiFBkc/R2IfKCTP2qbWIyfLRKIKatfEJ8S6MtahI79+SOjo+QGSnAHi0Nm/y
	GwON9X9US9/6hsoyx48u/0RiMthPZvcGuY2suQ==
X-Received: by 2002:a05:6102:5a92:b0:605:8280:5e68 with SMTP id
 ada2fe7eead31-605a50e2a2bmr1113935137.16.1775227817848; Fri, 03 Apr 2026
 07:50:17 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Apr 2026 07:50:17 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Apr 2026 07:50:16 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <CAEvNRgGm9icDK8sK5ZfqHEOEqSbvjwtihE4p9d3vpBq-NfVjmw@mail.gmail.com>
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
 <20260326-gmem-inplace-conversion-v4-10-e202fe950ffd@google.com>
 <2r4mmfiuisw26qymahnbh2oxqkkrywqev477kc4rlkcyx7tels@c7ple7kdgpo3>
 <CAEvNRgFkusZeKxGctUpTTbYjdi7nZL1ZZar-gT7XRUOCZ2xtpw@mail.gmail.com> <CAEvNRgGm9icDK8sK5ZfqHEOEqSbvjwtihE4p9d3vpBq-NfVjmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 3 Apr 2026 07:50:16 -0700
X-Gm-Features: AQROBzCC-hVilK2nAfJ3eE8zmQqqNa0fWthx2SZG4jgOFPeFQ_7rmzXurA8c2f4
Message-ID: <CAEvNRgEtigp7+PVDkyu_DH947CUqDt312d+P+hWjjd2fHONiag@mail.gmail.com>
Subject: Re: [PATCH RFC v4 10/44] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
To: Michael Roth <michael.roth@amd.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
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
	Wei Xu <weixugc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

>
> [...snip...]
>
> guest_memfd's populate will first check that the memory is shared, then
> also set the memory to private after the populate.
>
> [...snip...]
>
Looking at this again, the above basically means that the entire
conversion process needs to be performed within populate.

In addition to setting the attributes in guest_memfd as private, for
consistency, populate will also have to do all the associated
operations, especially unmapping from the host, checking refcounts,
and the list of work in conversion will only increase in future with
direct map removal/restoration and huge page merging.

The complexity of conversion also means possible errors (EAGAIN for
elevated refcounts and ENOMEM when we're out of memory), and error
information like the offset where the elevated refcount was.

It doesn't look like there's room for this information to be plumbed out
through the platform-specific ioctls, and even if we make space, it
seems odd to have conversion-related error information returned through
the platform-specific call.


I agree with the goal of not having KVM touch private memory contents as
tracked by guest_memfd, so I'd like to propose that we distinguish:

1. private as tracked by KVM (guest_memfd/vm_memory_attributes)
2. private as tracked by trusted entity


Currently, in TDX's populate flow, KVM doesn't do any copying, it only
instructs TDX to do the copying.

"TDH.MEM.PAGE.ADD Operands Information Definition" in the TDX module
ABI spec says the source is accessed as shared, the destination is
accessed as private, and in the case that source and destination are
the same, the "In-Place Add" section says the source will be converted
to private.

In SNP's populate flow, SNP-specific code in KVM does the copying from
shared memory into the destination, then makes the destination address
private in the RMP table before telling the firmware to do the
in-place encryption.


I think we should think of the populate ioctls as being
platform-specific ioctls that, when called, accept

+ destination address: private (as tracked by guest_memfd)
+ source address: shared (as tracked by guest_memfd) or NULL

KVM doesn't touch private memory contents, even in this case, because
it's really a platform-specific ioctl that handles loading, and the
platform does expect the destination is private for both TDX and SNP
at the firmware boundary.

Since SNP (platform-specific) only allows in-place launch update, and
KVM had to provide an interface that allows a different source address
for support before in-place conversion, then SNP has to continue
supporting the to-be-deprecated path by doing the copying within
platform-specific code.

For consistency, guest_memfd can continue to check that it tracks the
destination address as private, and sev_gmem_populate will then hide
the copying code away just to support the legacy case.


The flow before in-place conversion is

1. Load memory (shared or non-guest_memfd memory)
2. KVM_SEV_SNP_LAUNCH_UPDATE or KVM_TDX_INIT_MEM_REGION (destination:
   gfn for separate private memory, source: shared memory)

The proposed flow for in-place conversion is

1. INIT_SHARED or convert to shared
2. Load memory while it is shared
3. Convert to private (PRESERVE, or new flag?)
4. KVM_SEV_SNP_LAUNCH_UPDATE or KVM_TDX_INIT_MEM_REGION (destination:
   gfn for converted private memory, source: NULL)


TLDR:

+ Think of populate ioctls not as KVM touching memory, but platform
  handling population.
+ KVM code (kvm_gmem_populate) still doesn't touch memory contents
+ post_populate is platform-specific code that handles loading into
  private destination memory just to support legacy non-in-place
  conversion.
+ Don't complicate populate ioctls by doing conversion just to support
  legacy use-cases where platform-specific code has to do copying on
  the host.

>>>
>>> [...snip...]
>>>
