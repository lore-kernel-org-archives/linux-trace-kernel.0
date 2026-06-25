Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EAF382F10
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379222; cv=pass; b=Ggcv4jnOO4DylfUlYt9tEW9l9tJnO5rV3rL07PQ7gvOMjWCC2foLINAbssH/4pNUchokKlRJuE9cKeGmDPK3vwWXDTJTYRlaUYDpaFBNN+UYgapHl/4aeyNeJ5eO47vXs2D/Q1hAjAUefMdrSc9OgCem0qpROWeW8WJI3ZP+BOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379222; c=relaxed/simple;
	bh=VvJfZbIRil3c4qUEVncM0B4gssrwDmoZt1aKoqwRohw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5Jh7TbPb/QheUJjTvLS46rQOV1WITKttfZDvqJWcJ7yO1sbNFBE2LEWZSj9UwGtH6d6pAHuUYzyXrJ99oHPtBHtf5qeRHLziPoMeQdCIQYGWm+DJp1N4ZLjoMi9kXWcpJtvD/Kb7vYsUWD0lAO/fWW+vmxEnY12ieBUvH8CdCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sHoCqtxc; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sHoCqtxc"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51765331535so162561cf.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 02:20:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782379220; cv=none;
        d=google.com; s=arc-20260327;
        b=S8cQ3a6klCzVIcd+lnpB/79gZiF6q+umwLquJMO/0DFQqiLdInoauVE2I8LPJh+vl2
         62BujKMMHvzH1odn7nGGIMqQwGklduZ/OvOK96KXZhsRfD1N6lTODXDc1Qa3giDZPNQl
         mgxCLc7DGxePoMIs3ysHYr6lStCR2fWOwaS5vhtCvd4mKAxZaRF87Z+VCGkoR6ZvZ9Bw
         YGjRmDrMsVWM06woYzT25A+K6W3hSrmzS73j2xAgC44XBF8qm8PWYqnbucZRB7/02uYu
         kFRG3o3nP+XVIBoJVg6WAu5t1LjUduCFPAzJe9v9lykvpFUAZgxM3rhLBSHndeWCgUvL
         GA8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9sNVNZ83P6g0a7P8tPRt1nDyKQGm49SitMTFhdy7JFs=;
        fh=3Xz8IjoTlsQjLhN2aqcMn/d6M4338BOezPD4qzkxxiU=;
        b=E+VBR2aF7tffww4dBxAUvWLMZn5R7AXuG5ISGcuOswo295OG0cYE6hLKPVag0fJ8N2
         EOtuAes4iDXwwsdYDMrzdDBmPEajHE71cT6dHcQLc4NEQY+hrHJcA6pTEc8QsYzrkFOY
         ZV2oOgqc/9w6BlEYyl2zMkQPTOh54JuRI0pg8JjbarmyPqipFR7wR3n2N/vd8Q9oEWY0
         qe1Tbjxh9tIcQeZPhqgR+sR6ovvGYHQ45FwVsakFvJktaNhqyQE3T2AhqqOqAbhBtPss
         FTJ/RGCZ6Uy7juODNoU68umu8d6ispzyUsTJZ0gCrnqF55ToNLzBNs+7B2OeCBDDZKRj
         imVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782379220; x=1782984020; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9sNVNZ83P6g0a7P8tPRt1nDyKQGm49SitMTFhdy7JFs=;
        b=sHoCqtxcsBpRGQR93WwrL4Rprcr1QwyvppQmBSKllNaiQKveEBRjCnonKRFZa7Z6m9
         +oOVGonFyUHMnZb+kZnS6iUCwNoCqG3Ny8+m7LrN8WACHABB83NkHapybUKORqHCauZF
         SEgIM9jSGnc+bD8NUFUGz81LgV6IFzMywzmXIVngK14vKU+I5M9ORDekRXX0DrnMltd9
         qORudEJ4Opzx/t8Gp+odaQo5QAgGZqIQefx7RHmiEHMkAlLgMrYdOBnsUqUDd7HTl566
         qSkdexSW2GvQXS6JErTD/Yu8fd0w5H+0Rg1WIRe7QcvxoG3iGKpgA4jH1NReHf+IqfRo
         sCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782379220; x=1782984020;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9sNVNZ83P6g0a7P8tPRt1nDyKQGm49SitMTFhdy7JFs=;
        b=mVxUd4PNxh8oI5E9CXTipbSFOGzLzL386jDVwg+hdY6Epot4XHHkjOgCl6dKA7mlWY
         q/xX6QdPpDxXJWFexJuyRP6TbYQsHZ5EcOtry+dmsQF906tVFXKS7Ubsnde2nxpOiJ5A
         uJ03DGMY5oIGiZWBLdWRNfh48G8XX22wSCeq3NG5GS3RMvXWO2EiJ1jPhWLVSNcKorLr
         73EAgfvsMC6BnudRslNvBfcRqvjAI1PNL8ydKVZ+91Cz53MSaKSpl+12j+IllzhOgLTv
         AHp0LMsFooiPQ1HADKUSF3GgWzA6A6X8r0g+k6JEbBuRqFZL9jEx56QeBo0OrtwlzOx/
         iK1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+uZJ/Ilia/3lU1kgQ2PjQ8hx6EPMC4GjDYg2XxvMhEtJuiRpkYENg7mRK2wRg0nDFG8NBOMDLWnts7zacc+IYk8nA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ36Cc8MAe/ttcvGDnXShRxd2wUfM2uS3Zn1VUdXhzoNXUly7e
	hBFzpI+730SsPiames5YlxGnO2yRjpn6x3dxDmUg49AGuUnv1t8ZoczUaWgb5nACOHeSLpIW0TB
	R7RCZMmMa7Xghyf+PewLKsXknH272UUA+yFn0Cb91
X-Gm-Gg: AfdE7ckJ4bOA5+VeB2yMBO4tH1xDAYRMboayAzEc7ilS/yp0coBwIC11vnpS0sxJG/N
	jE+N4ljQAe9OMKyPQXibNKIpgrrLItUYrGu7pfesY7/6guYXTU93WjFHTE5v7ZXy7EcLbumRqdR
	gsIN11hM38EQQNkP7m7svtW4C1QUB5arZ5EKgPu7tlJGQwGCIUoIbYyDIQAUiDERX0R3K4HQjTw
	rREryMWXHX5MJXz9PplKQpe7NYl1v8DwRPGEAsDZ10JCVxT8fxDmYr2/115174fyr5j8Y8tnA==
X-Received: by 2002:ac8:58cb:0:b0:4f3:5475:6b10 with SMTP id
 d75a77b69052e-51a6e9af205mr7810381cf.8.1782379219049; Thu, 25 Jun 2026
 02:20:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-43-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-43-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 25 Jun 2026 10:20:00 +0100
X-Gm-Features: AVVi8CeL3q_KiSPnBQlDtTbHhecm2C_9dXyC0RdNzrEqsxqa92mG6-FntXo0Q6U
Message-ID: <CA+EHjTx3z48aykAeQ36d=pOGEEcChWst9_T5+rOFNcxP3n9vZA@mail.gmail.com>
Subject: Re: [PATCH v8 43/46] KVM: selftests: Check fd/flags provided to
 mmap() when setting up memslot
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
> From: Sean Christopherson <seanjc@google.com>
>
> Check that a valid fd provided to mmap() must be accompanied by MAP_SHARED.
>
> With an invalid fd (usually used for anonymous mappings), there are no
> constraints on mmap() flags.
>
> Add this check to make sure that when a guest_memfd is used as region->fd,
> the flag provided to mmap() will include MAP_SHARED.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [Rephrase assertion message.]
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 0b2256ea65ff9..6b304e8a0e0d5 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1110,6 +1110,9 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>                                              src_type == VM_MEM_SRC_SHARED_HUGETLB);
>         }
>
> +       TEST_ASSERT(region->fd == -1 || backing_src_is_shared(src_type),
> +                   "A valid fd provided to mmap() must be accompanied by MAP_SHARED.");
> +
>         region->mmap_start = __kvm_mmap(region->mmap_size, PROT_READ | PROT_WRITE,
>                                         vm_mem_backing_src_alias(src_type)->flag,
>                                         region->fd, mmap_offset);
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
