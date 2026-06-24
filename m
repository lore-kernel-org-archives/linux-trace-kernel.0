Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEF1374756
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 19:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782329203; cv=pass; b=DHQ62WFkTLqE/uSvuTI21H40GvTmYoRqMZwCo4tNb9Tw2V5zXXOqSqA4r2xOu8P748FGQhBa9zzJ2HYAKb3Bj9vMO64C8i15tD8kZSbeAvYBYoJdQBztBp4DcmFXm8FapVxmDp/ShI/SitBjHIe8PfXqHAPn2yA2Gmu7IJgz4Oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782329203; c=relaxed/simple;
	bh=twcHfAFi0y+ft7B9oCr1+JB4Kl9qeBvn6Oj93bDxxCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGs9fcIMx6PzX8FHKxgDL3KiBks12THvN9x/3SWZvZKkDQZtm9q5MgjML/eSQLBOG1wZQlzYgEsP3IkkMWplOCjPIB/DuXvuQ36k8mGBLsLZJSYVvAnZN9BY51PKFjYKy56vWsB9mfV+8Ur/TatMENGG8NhfqdWnkm/jvfDLPDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MgQ7Fw79; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MgQ7Fw79"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5177d1ff061so58451cf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 12:26:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782329200; cv=none;
        d=google.com; s=arc-20260327;
        b=acAh/846mLUzedOOGrunNBchX5UB8mYjsxEudmdGu3k/C92o2DVCGBh4vg++98Q/Gh
         EKh2OclRZ3vtWFoQ+td1FqnaLwvVwdeA5LCQMs6qGiVA3YGTO9qxs1ee3+M/M4Zv/Coa
         ES9yOGwrl2XZdmHnAsVaWuZ8Xkng5+tdl4J7beBGpIdT4n0JTxEt/WRfyaqoqFuWUKbZ
         ZWAqjilLi/vXKh6a73aFQn8Re+VaIxkGhSmCWCWbwFRUmjZaOMiwZUEoykmxu8jSJlPf
         6wv7RaNu6xgr8OrSSprHvvMbVNsr/tZNPuwj7k+Q8P7IGWvCkav9HNh1gW1pGmjjl7FS
         E7Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YjWrR34fw6nkV452WVsUflbv5W3gEPx2vCWL5i8qEHs=;
        fh=ollUYnddHt/MX1G2QDVJw9fOLJKrbcW+on4xwn9UTVs=;
        b=q+GQjTMdIKkbeEQyB3gbWCvFKfBr1agJl5YFtQkpSPqc/FLw/9NI1QXIqQrRBVLX9n
         5FMcHXZ+9C+pgfTtGatmtggBMgjff4V444XyS8cZ/QR+LnfqAzcxlxcWV4Aw3bn0TBUl
         LN0/V+FtdWg/qxCxFxLq9ml7u0HtH7C5Pjs8GmSdCk57bcIVqfPM0mzq/Bmam3XOAkdl
         yGPKNk7Wco/Xfn8eQFQI0JHbQr917ra7SFAwH59PZSb7q0d43RboUkSEOV70ozvm259V
         jRhhoRN8IRuNXIOhurPepUt9Te7UvFGFUbAANVL3mm2GSnDTJSSqhmq1a6aB9xOvvOSq
         99jA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782329200; x=1782934000; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YjWrR34fw6nkV452WVsUflbv5W3gEPx2vCWL5i8qEHs=;
        b=MgQ7Fw798vij/H05tNvvBq3PKRUwX6PUnhO3oKP52YtAhvCXKJ5DYxWv0fn2RjuX79
         74XZEzqYCkVz5rllDIOzrlOgACt9ygzwiukBgPjaCyd6nosd1mjXK3lXS9jxI2a+t6Pf
         rhRZHc6Wfi/JISDedsIFFGACUaPsZg6+yw4XmOpx25amBdHweNxSM79xMwyoY/Mg1+Lo
         nI2auJk/n5qUIsd2NHBU+5jbqphLCj+X8Z+L4TXm3gaBo4gAJjJV5e8uP8dxfwjXSniq
         e5u7dAZ3pWT149JrXUEDsOLOzDTbWwDIo6B05RJTJQBpKI3V90ss/XZ/YS+1h8+uZkc6
         t+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782329200; x=1782934000;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YjWrR34fw6nkV452WVsUflbv5W3gEPx2vCWL5i8qEHs=;
        b=Qh4dD1BeolSiNqHTV9PJhACmG60GbnO/LU6QAg5OYW/pq/R1q73KlpBnaXCdf19cXq
         OWKvKwI0JNnjKSr+62wxPiSJo8BYsymfpA1oQ1/ugHzO137gYUkOooBttjfcLwRcbT8P
         ldxs0lJOIjYU1aU5p89Lz2EEKfWT4GzUlpWTkZ3KgaJfsrt99Uox8hBGzcYY5GMA4Tf2
         L5ia7Z/l9c2A0m4+Gpvv9S/QkdKIYDsrRFAdN5aePvWTXukEnoV8lV2i/7l6himm6kF2
         9XMFim6kB0vRIW/8OGrNjJeiwVJTjceLL8v7mS/Pj1rxUDf6DWkoqHur6+EPbsEng8wg
         UTtA==
X-Forwarded-Encrypted: i=1; AFNElJ8cWwVomnlAQOWF+rKO+E63tCzPy+jrTOwQ5MS6rZFKcWpznlnXeJeu6UWq5ilsBeZZV/pJU2pPF9Pof7Osr/ba8vI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU7fjEMpCkg0hS8yRYnd7SvRv6yIqQRN6GEUXBLi+LV7FSdy7l
	SBaKFVXdjfndT8FoytxfiG78dS5EtmlOvYbZ0jprOToZBRuOfPhmDOeV2pZHr7F25E4rII6+Fqy
	rKFL64juQcOohiQpZTQn9REeSQ3ES0aGg1CKC9U2B
X-Gm-Gg: AfdE7cnTCrPKm8LeOzmIXeBLzmpGwCBWJdBIcpgyh2Scw+6/8+ACvQhDUXfkLBrtyCx
	IN2/U7zc/RypQEJknGWPv5IdQip3z+yxt+WuXQulgy7xtGbPIVT7xaMksbmAc/mR6SjxXhm5pZG
	JMffnQH7vLxGEZdwxRirHkUr8CsxoOueSp+2hbmuqoYZXrRYhZbydwhtFidlL2zjqiTfjEmopvo
	bYB3DDFfNIUfJRkvDysIic2L07fDDcktb29DnHZ6+VCYleiIpGgKMNUGP4sOargG3BquBxxDQbZ
	aTVe9rPg
X-Received: by 2002:a05:622a:a0b:b0:50e:38f0:ccb2 with SMTP id
 d75a77b69052e-51a6ec5b17emr1608501cf.15.1782329199083; Wed, 24 Jun 2026
 12:26:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-29-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-29-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 24 Jun 2026 20:26:02 +0100
X-Gm-Features: AVVi8CcGG2L_WGfgpW6JtuTQk7CHKKes1x1HHlBx2_zfm1i0mgNuuyxx0bG7ikM
Message-ID: <CA+EHjTw5dJ4HRoN5OxeKaFTgQrstUTVcb6-x3xgWEa-BBk3ZQw@mail.gmail.com>
Subject: Re: [PATCH v8 29/46] KVM: selftests: Add selftests global for guest
 memory attributes capability
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
> Add a global variable, kvm_has_gmem_attributes, to make the result of
> checking for KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES available to all tests.
>
> kvm_has_gmem_attributes is true if guest_memfd tracks memory attributes, as
> opposed to VM-level tracking.
>
> This global variable is synced to the guest for testing convenience, to
> avoid introducing subtle bugs when host/guest state is desynced.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  tools/testing/selftests/kvm/include/test_util.h | 2 ++
>  tools/testing/selftests/kvm/lib/kvm_util.c      | 5 +++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
> index a56271c237ae9..51287fac8138a 100644
> --- a/tools/testing/selftests/kvm/include/test_util.h
> +++ b/tools/testing/selftests/kvm/include/test_util.h
> @@ -115,6 +115,8 @@ struct guest_random_state {
>  extern u32 guest_random_seed;
>  extern struct guest_random_state guest_rng;
>
> +extern bool kvm_has_gmem_attributes;
> +
>  struct guest_random_state new_guest_random_state(u32 seed);
>  u32 guest_random_u32(struct guest_random_state *state);
>
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index d5bbc80b2bf1c..b73817f7bc803 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -24,6 +24,8 @@ u32 guest_random_seed;
>  struct guest_random_state guest_rng;
>  static u32 last_guest_seed;
>
> +bool kvm_has_gmem_attributes;
> +
>  static size_t vcpu_mmap_sz(void);
>
>  int __open_path_or_exit(const char *path, int flags, const char *enoent_help)
> @@ -521,6 +523,7 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
>         }
>         guest_rng = new_guest_random_state(guest_random_seed);
>         sync_global_to_guest(vm, guest_rng);
> +       sync_global_to_guest(vm, kvm_has_gmem_attributes);
>
>         kvm_arch_vm_post_create(vm, nr_runnable_vcpus);
>
> @@ -2286,6 +2289,8 @@ void __attribute((constructor)) kvm_selftest_init(void)
>         guest_random_seed = last_guest_seed = random();
>         pr_info("Random seed: 0x%x\n", guest_random_seed);
>
> +       kvm_has_gmem_attributes = kvm_has_cap(KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES);
> +
>         kvm_selftest_arch_init();
>  }
>
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
