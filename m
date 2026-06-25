Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635252DF136
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782370843; cv=pass; b=IdRComLz0L8MlwKCFXqyMCWL/15CN52ymTF5Gu73kORxLwB5jkPJ7RCadNv7mVjgKlQWIxXgOyczX0AMEwYw22sQ3psclYLT2Pm0bSjWZnkFKULGMbQbdUTqv9JNnyIFDXmvakmmF2g5u7BHu+lDo67lh4lAfMum1ywvkepNb2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782370843; c=relaxed/simple;
	bh=7JJoQZtiGk7coUfKOMj2B/mrqYm3H457ckdZcSJc6Os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHqomrMuYgRz00ka6RhAqPZ3/SUog3mWe7OPpxsmVu6rZo/9eCO/f9ZyuiV8T6PPIjhBGNgACcH8A5DHco2hYl78iqVovXH7sjYKFhKR8G+hBkw7Pqrab8ujkee89qWh5aS+GKRHmh1gRlenxJIaqho9+y/LdbdBkJWvb4FOuYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e48O1c61; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e48O1c61"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-519ed52bcc6so181331cf.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 00:00:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782370841; cv=none;
        d=google.com; s=arc-20260327;
        b=HVn05Pkcrj0GvfmwqaleQeK45ES/HYy5XGN34/313T4N1PcE883ZrBh+YmQUlkO+gw
         hcV9m5BN79LvGkv1cF7/nNUOzxEUKw1oMHOGLxP7PW30KXSSbqCInteVkAaAe8fJFfwB
         UxMN9ifHRgbU6K+EHjRcZGqGm+TLgIF88raFThNee1mu2ZtPZpdQdnb8xWIrXZjtMOEf
         yEDHRKVSGWiDzgSKq4ZWt46j4FP177y24ILtWUQXW7hXLISTxLk8cjiLs5HTsg8e5Y+v
         XgvTdXli0KJZrqt8ylQR0VWCD348OYBuRvs7bt4NnERJ27FH7cgxtb303jpSHbu4MwvR
         Tblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7itwZj77OJzx0Nbk553L+ihvDTrBn0KieHsapLPAjLw=;
        fh=cUjEzv2Ry1aDpS0w4Dy8RLfPoq1VJXh2PYHMEOYFoj0=;
        b=BZOyT4PZO1LCjiwo1oNn7Lb+uANhofozAyClRmVHGUp2LUGjr4fb0Md3euCcY1yDAY
         XWj1i9kBf4lVOrJwu7298lo2j3wOXu3JgPbgAqwe3gFADgrT0/zTTYgxTzuP8olzq5v9
         p7f5eSa7okeXcx+o/Hb0oLcYDBS8+oTeXe8VqArOp91CTDwXGKO0BskVaIRIaHRSS9je
         MjfJiGlSeoAwQvzoLbxcWyke9zUo8vxi5HgS665b0eG4dzqwIG4bF8JxknlXHnGv6EMM
         oiA8BVyizpl2OMpxPHIAy2X6oLyOixnXvLG8hUpRwCs8VU4VrMpD+GGh/q7/8KifgapU
         O8qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782370841; x=1782975641; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7itwZj77OJzx0Nbk553L+ihvDTrBn0KieHsapLPAjLw=;
        b=e48O1c61mYFrJJ81UCyvgdSdCRMUrJWKUOd8+jsx9qjU68Zcoh1u+PQte4S45rUz81
         eHZ+XntRnpu4a7oXwrvix0ys07R6n29mCO7WpJ4pMesJZZmqTBYJl+mw9RP/9h9H/3t7
         nlt/rRYvNDdcxkMakXg5R/+fUu4LyB+2NsyWK/Ub2RPN9gHe6OWORyk8QxfYetkxXojt
         Mal9Rdm7KC5htW7jw1+QzZmtpFp9ZwNVJeqDtsTwZCigGmcA5X+V77yaB84hQCixhRlm
         SLw9tUwCXaIMpCJ1P69ROgK79CI6kSRUa+j/rsyWSdnxfVp8o2ecDTbc3X8XsT/ai109
         6eJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782370841; x=1782975641;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7itwZj77OJzx0Nbk553L+ihvDTrBn0KieHsapLPAjLw=;
        b=EZlq3xz2dmZclEiFz04r9/Wletuyv0ra1yt7BKoqSAuVoS19e8H/ZKq3dHmuRt5uuA
         Utez9A2ICk5CXj6Snf6iRd8bPUhxDnJTpaEQIaUOvoSTYlQ618sacFjjxQOXpKNXGQ9f
         5Q62/ryfaR0PTFoie4CpDN3/Qp/r22NUN2xXSoKOdM8YKrgZmHPT/0s2eTxPgLsO1p95
         2hmmL4b4BjuGlgsCAgDiHyQTiGdhpcn5RHvOEEBeL0q4XtYESAW38UhKQb/auyP6pK2/
         Y51O+wd+IuYkPHsPguNeon0es+3ZaTmO/vnqkQ6i+Yi1vgSThocSkeZIXP75J+wp+RXu
         5/KQ==
X-Forwarded-Encrypted: i=1; AFNElJ+5JsHC9h+dZKGaF+8JSoB0TqPvr0IxN3eWhxlxDXMLvSGxn6GDemsb181+fynU3UMgL5TN2QmNbdIN60/CZDRaXy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Qw6SJNH6yzn0fzeaeQjclnBiVxgCrAxH9nxvnpE4UcOahohA
	vmU+kxm/BoRlVqkU+70XryNy+19ZUfHIno0QuXZbErrLMZ7JZtXKJowNj+1BkpbVjMIdaYrTdpw
	I7x8ONNu//4WLgVZ/6juhQ+ZnR2qjLsFfXrJEtIMW
X-Gm-Gg: AfdE7cmH2ibt4ImaIYK9wp+5d4OxWnl1xFs0oDPpirq4IXR+YixfLlk+xjsjcfjNCYZ
	0cYxu08ycHjAAcHVCAHVIco+mQEEyx38waFJEf3zP3bdg3cLNWVkVV75wG96uqk1ZOooy+QtvZ9
	xIUJ3dgUAd+7RMBuDUY4XBljXCs58A9j6FDKXVz28Z6LOCv0H0jd6JAldBMg+aGWaBnWJh9tSLv
	CaleowaMD0WaLUWt3ZZgAdG4Mihd8XDCECV75eUt+Ctd061YgqvZy7s3Y/WFM6I7qIZ3gQus33+
	jQu/l9Hz
X-Received: by 2002:a05:622a:53c4:b0:50e:5eba:cadd with SMTP id
 d75a77b69052e-51a6e9b5655mr7053121cf.2.1782370840588; Thu, 25 Jun 2026
 00:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-34-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-34-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 25 Jun 2026 08:00:03 +0100
X-Gm-Features: AVVi8Ce3XGRWH9AR3rw80vlHynjgwNotwUVdlcJvIAaDUMJb2MBvPhhdMigDY2U
Message-ID: <CA+EHjTzR9r97Brau5KMmUf7UZvevmhpCKhTEt-9wT=0YXFLpFA@mail.gmail.com>
Subject: Re: [PATCH v8 34/46] KVM: selftests: Test conversion before allocation
To: ackerleytng@google.com
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

On Fri, 19 Jun 2026 at 01:32, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Ackerley Tng <ackerleytng@google.com>
>
> Add two test cases to the guest_memfd conversions selftest to cover
> the scenario where a conversion is requested before any memory has been
> allocated in the guest_memfd region.
>
> The KVM_SET_MEMORY_ATTRIBUTES2 ioctl can be called on a memory region at
> any time. If the guest had not yet faulted in any pages for that region,
> the kernel must record the conversion request and apply the requested state
> when the pages are eventually allocated.
>
> The new tests cover both conversion directions.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  .../selftests/kvm/x86/guest_memfd_conversions_test.c       | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> index 8e17d5c08aeb8..b43ac196330f1 100644
> --- a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> +++ b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> @@ -265,6 +265,20 @@ GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(indexing, 4)
>  #undef combine
>  }
>
> +/*
> + * Test that even if there are no folios yet, conversion requests are recorded
> + * in guest_memfd.
> + */
> +GMEM_CONVERSION_TEST_INIT_SHARED(before_allocation_shared)
> +{
> +       test_convert_to_private(t, 0, 0, 'A');
> +}
> +
> +GMEM_CONVERSION_TEST_INIT_PRIVATE(before_allocation_private)
> +{
> +       test_convert_to_shared(t, 0, 0, 'A', 'B');
> +}
> +
>  int main(int argc, char *argv[])
>  {
>         TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
