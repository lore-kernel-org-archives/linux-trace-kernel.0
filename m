Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E06E32E696
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 22:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782340217; cv=pass; b=a7hmnw4agStfWy1FS9sd3JoIIOKjyaHjZq1BXMo6xhzWt3ZxgvLCfW+1Yf+dm0By99a5EE06tXAaoycdp6cVDgs8qcKkfpLKh0Ub2fFvCh8ks5ZcB5F32TAGy4NoHy8BhD4DguIV/FZzYG3vS+WvNCSf3mSDBZRcRxGiV86WmSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782340217; c=relaxed/simple;
	bh=Cryz59YAm4hKcZvNvNbTkH+hut/Wk5VenNHAj/cSfOQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pUhg5n8XxTSKQezCbAzXmB1+7/7ySmInU6Nr9/9rr+qrGpiFMmuT9AuSNLe+6mVjdlIFHfq60KswZkoBUxytPdUsxSdy3DeL3sEDZlyuTG3AYKh1m00WewrwN5nsjUTRQC+q50xcprPB4EqJitVHTIUTjimmHZXDy60LJ/pe1SM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mt+d5S8C; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mt+d5S8C"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-13981833e13so1991158c88.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 15:30:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782340214; cv=none;
        d=google.com; s=arc-20240605;
        b=JoUiSAottKCvsrtYkdvrhUCadQ8Y8iNFD94Tfws+knIH170OKZTdSGBp5OLfrJYHVJ
         9qd1Y2HQGukTYEqN6JcbO5s/jkypbXO4fU4/wk7/YNZdfpDVyyWhhBbZXz7s3kJ6XZUl
         zneORjqezcN277NapD513fenaB1XQ9X2Cul5B33Vax00IpSZnT4DzS4X3lWjJw7eMKxs
         ivOlWJ5ip4uTR8FgTi0s1EpsJIIPHTB7xPlaiVpGysh46HkJfnofXVgxdZgTbXbODL8t
         /Ht6uoCm14khm2ZuRCE/n1qQX6Ng46xQkvH4WvvsRVZaOi6rn9JqRj5GEXEAt4Hixsys
         ssGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=oVosxF/7uHKl1pdZQ4oI0wtR65vPmKvzzWf+IZ9YyQw=;
        fh=ZVBLNmfuiGebSBBp6WbVVcCIiFicGeWFg5S4rh/vMi0=;
        b=ifhMtS2sfOWlI+JpYMin/tR96kNHjmhcCzAVj5YFz1PsXbgTff4qnXQDCDcnE/k29A
         SZOoVJMgLOTa7P/S23yIpftMmhT2MUG5Z9xW0lGs/+Ijieoyvf+EvZhqFo95Oth9kkAy
         NhGFAv68llN7QIwwbzvxsefpxhamImTKErQas1VpJUoQjiK5P0v9atT0TJjRQiD29qod
         qWY4Ax0ykty7NTawJCNxh6zFyLn9JGwUQUYMctzN8MTbJfHcz+UTWnuMnjJgvTyXbAMt
         sz8LcpAcBie4vqYzLOvTa4QjrGlf0cpVi9Qz4/d+veCUXertyetRX/sS3qOvLYb6FIAz
         XWvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782340214; x=1782945014; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oVosxF/7uHKl1pdZQ4oI0wtR65vPmKvzzWf+IZ9YyQw=;
        b=Mt+d5S8CeVyF2uzGbd/9JRs3fsdMoDQplep/243tDeeCK/0viIoreyIvZcomm9oFbc
         osynA3dqv1S/DHst+neAr2nnckPTMGSsR9x/VWNduGgtd3hbI0IfDb0tvdIIRFXegKHc
         F9+5XdmXGx4YFP5WMZU+iCNLYnXl3s5oXgwyZFLzkcQqd8L0W7aRV/+ooPtJ1n58PieV
         ntjs2EoS/iHYsL1LDjxKZj24m+kHe8Ztctu93X6yp0krBWnoiRVrb2A8yEv75Zb2B0jh
         Ze/glsnOlcOHOoI1SgAH6AYIMaGlaWoLyLmhkHDQjfQQ+iEr8XfE/a9xE3hKqQPNtJci
         TZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782340214; x=1782945014;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oVosxF/7uHKl1pdZQ4oI0wtR65vPmKvzzWf+IZ9YyQw=;
        b=iMCEqpxaGnHU2FoMZE/7Ac4/DweUWRGN6yi+3WboKSBfTPIJ2zc7F+ErYeJg4v2NJI
         mvCNnIRNGgX0yGHgDTUGmjdCUTIy2mHeHO9BFCDHikycGa76lSLmuXKh/R/pLV/Dskrx
         pIHI7PJegl/1vupfaWsf7phubEChuYBRAPTjIBgxsnlHcm8im2D2fkNl+B1BS5hJFvJD
         uogPgN3ZqW+b/GBsy/ranxMypJeHaOv0W0WRJmajYB0qb9kpggSbQCiqkIKzX0uzQZg3
         bTagOc5brZqJLuReZxgNsqSS06w3HzUkc2xEH1tb6M0MEE+o33p0++Hb23qEaJ8rV2VO
         JBsw==
X-Forwarded-Encrypted: i=1; AFNElJ+mKRD34NzV1RfRMNzNh2Nuri3oiKImqBjpRDd3UvRQ14km1CVzaZINtxQYZOaqsEzY+m4QOWhJ7qI906RKobsnShY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE2KVU9/FasvV4ukrmf82++XhYChCQBRiyURM+8ZneaxywLFwp
	qFsz2xdUFLf4TwcOx1Jzd66AryZV/HEXycuyiI9YwzK8usfZSrwFM30qrytG1YnouPnIfsexVcV
	7J8TYTaeSeeAHfiJjk514cLZzA7lx7qhMY2UiQx/I
X-Gm-Gg: AfdE7cnvHmdBWc5Kku9JAHi8JpAozvTTwuKV8rxVs1ZLZtoRT9eak+TCUB10+e+BZcb
	eqCrvjhNXMVxZV+FzkD5TASijs6RhSsj8oZIpDbhWnhiR9C2bUqiVdMIm2WzX7pL6rf/DGg6DOT
	5qkyAEhLwxF+rhTGL8mYetEMel0D86A2JLbBlI2JW/Y+jKJk+naPzvMuHCX4gKZpKj/VquZkpkE
	om/WXQtDBEunU9J3XptzrDTL78M7pvkbT3CTPwQ3T8598km1ul6zD0KRwKFe3xvOUR5PZhfWC7e
	yXi4b/teTxt5dW21++AVcWp6EQlcDFCZ2Yoq5QVvAgdvbtsH9PBEqt8xiTQ=
X-Received: by 2002:a05:7022:fe06:b0:132:5d42:55ba with SMTP id
 a92af1059eb24-139c5d0503fmr6919345c88.16.1782340212554; Wed, 24 Jun 2026
 15:30:12 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 15:30:11 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 15:30:11 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ajpKK/SyRh8LExrY@yzhao56-desk.sh.intel.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-21-9d2959357853@google.com> <ajpKK/SyRh8LExrY@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jun 2026 15:30:11 -0700
X-Gm-Features: AVVi8CdqNo4bRyAdjZ4VoxTkK6AK5USFMYju6TEGtZz_v5HiC3fCw0ntlVpZrZ8
Message-ID: <CAEvNRgE=-cdbiToHEu-FCks2XSh3inVDdW3r+h9VYYbE4REttw@mail.gmail.com>
Subject: Re: [PATCH v8 21/46] KVM: guest_memfd: Zero page while getting pfn
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
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
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Yan Zhao <yan.y.zhao@intel.com> writes:

> On Thu, Jun 18, 2026 at 05:31:58PM -0700, Ackerley Tng via B4 Relay wrote:
>> From: Ackerley Tng <ackerleytng@google.com>
>>
>> Move the folio initialization logic from kvm_gmem_get_pfn() into
>> __kvm_gmem_get_pfn() to also zero pages if the page is to be used in
>> kvm_gmem_populate().
>>
>> With in-place conversion, the existing data in a guest_memfd page can be
>> populated into guest memory through platform-specific ioctls.
>>
>> Without first zeroing the page obtained using __kvm_gmem_get_pfn(), it
>> might contain uninitialized host memory, which would leak to the guest if
>> the populate completes.
>>
>> guest_memfd pages are zeroed at most once in the page's entire lifetime
>> with guest_memfd, and that is tracked using the uptodate flag.
>>
>> Zeroing the page in __kvm_gmem_get_pfn() is chosen over zeroing in
>> kvm_gmem_get_folio() since other flows, such as a future write() syscall,
>> can get a page, write to the page and then set page uptodate without
>> zeroing.
>>
>> This aligns with the concept of zeroing before first use - the other place
>> where zeroing happens is in kvm_gmem_fault_user_mapping().
>>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> ---
>>  virt/kvm/guest_memfd.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index 90bc1a26512b6..86c9f5b0863cb 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -1137,6 +1137,11 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
>>  		return ERR_PTR(-EHWPOISON);
>>  	}
>>
>> +	if (!folio_test_uptodate(folio)) {
>> +		clear_highpage(folio_page(folio, 0));
>> +		folio_mark_uptodate(folio);
>> +	}
> Note:
> In the __kvm_gmem_populate() path, this folio_mark_uptodate() call makes the
> later one after post_populate() pointless.
>
> __kvm_gmem_populate
>     |1.__kvm_gmem_get_pfn
>     |     |->folio = kvm_gmem_get_folio()
>     |     |  if (!folio_test_uptodate(folio))
>     |     |     folio_mark_uptodate(folio);
>     |2. ret = post_populate()
>     |3. if (!ret)
>     |       folio_mark_uptodate(folio);
>

Good point! I'll remove the folio_mark_uptodate() in the populate path
then. Thanks!

>>
>> [...snip...]
>>
