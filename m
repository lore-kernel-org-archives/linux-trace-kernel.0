Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD02378839
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782378558; cv=pass; b=UnGrO+bpAqr3y1CMgWjU1ZWnW/aG9PtnJa0k5eV1/yExRQe+qWJOdd5ras4EhBQPmJJvJA8RPBriXG0PNrdMcfuw/Sk03P/tLMMcOfBcQ+s8fbxrXdtDQc9BSt+bbFYrrK9dWaZbhpIqLfSsXdBe8Cil3BOK2SaIBhzGNc0gjcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782378558; c=relaxed/simple;
	bh=9leBl/vLIM3qHmEH/Edw801DRnY2C/1n405lmvRfXQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qXg20S7Uu8urx1EK4VZb0pYTCdJOx5LrIvpJkKlffEfcXBs2gSmz04/p43Rl60t7vkBRVuyV4+HCoAX824efbOABnAH7b/Ljf0Yn7pnZcLGWsC7zcKRV/EA1Z8HyisdeBJ6Yl6qd78AkZrlv7OnARZqOwIInowPO6VvWAQRu2Lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jpT0TDwQ; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jpT0TDwQ"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-519ed52bcc6so216221cf.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 02:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782378556; cv=none;
        d=google.com; s=arc-20260327;
        b=PT39A9dXn2EurvZ6Oy4sSzXBEqZNskT1vJ45OzUkwFL7rDVvNhfyRIIoF2jfRGkP/d
         lpDA4uBFP//2i1HQsDN9FqPbQOgrpxp+bgsunuhz6s44qOIjIvVGvmHXzZfqapPjmFyU
         07wjzhPVCBRCd5w6+o6uvrxV0n1D5xlpqAzKxO1nhGC1Px/UqPuKtXszuDzcGp2DNZrT
         8drWZWnKArMSPw8j6REfxxqVe1bC+bc7oIV8tikM9Bx9EpDh+zZHc0xfM9kqQfLOxBZH
         y+AKDZl2UqFdYdHFk3IgmJrV8remdAuneXsJYolvTQv8N9bwPXArp64mJyfubZCahB+P
         B2qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=R9slP6pRfRJTNIoqGcM2r5fRlSRzSJ4pkgblOXA4Ai4=;
        fh=WgTT/N6fj5e/iMloAt5cZI0UV/I8ZhsvEs65s6MwB4Y=;
        b=ixsOPvDaYlI4XS1IkkGe9W88R3beyUeeh7NLaWI76LfO9CdqmSQfKOKApTB0mE5lJz
         Hyl8DfMl1fkunF0L/5Zyjd6rhM1BF6B40Kd08Ul5EBn5LaCtG93aRZgDRxoWYdn+jiNX
         m7vJ4/nlo4uT6bNwJWM1VwHHikYzfjp4udJq5idQ7HH0GGWN3Id2mekboo9QtEFKVNs2
         slmd3fqRy66NwKg6Cv2YtAF0EmqBTub/L2va+jJYfEvwqT0VNzXKW4NDbP+MduTFU88H
         ID/QlXlLC0U7bGXRqP+o0E6x4TApB/KXCCZROX5L020CG21WXh5OHopWVXAEvCsZewKF
         ZEag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782378556; x=1782983356; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R9slP6pRfRJTNIoqGcM2r5fRlSRzSJ4pkgblOXA4Ai4=;
        b=jpT0TDwQT3t7CUx6TFKaPvx8pzy3kqZNAnwNo3v/FtmjwPMt8CNpkexIECC4GRbNXt
         ZpdoCi+k4hgjOoctyKbwCqJMgdxvnwKal/F/OTEfAqwUDwVybCT1+g/jiZTMmXhHNFuB
         zSfjrcN2RdZm45Hfu3HWBxfD75T5rCZzk7Zu6XHCK7YZXmllAmbkfn3dS5WFcVFaF8/A
         xXkt87dr7DR1xrO2xk0FP9vDipnxyhsfthpJG8XbW/KI4eHpq0oXe2W42i7YLjALBVuT
         z8HBPcujycIVxiVsWxeCu7FsOzADV7ZfA31gEedZtu4vetGOGXTRx0nzjS2nXHJjtlsJ
         LrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782378556; x=1782983356;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R9slP6pRfRJTNIoqGcM2r5fRlSRzSJ4pkgblOXA4Ai4=;
        b=JY/0SStTEMRJ6iKCh+0unt6YP1EsWqv83+vaQ/B9qJlGRVCPT7uh2o63JGrw+357e1
         EHb+8YUqS/O7C+8gcMBWpDsFbLfqLKPJk0xTsFTifVWyYJhCByISazK1LbirVt7atGUj
         pT8alrIcN48n10uxv2jKJu9JbJi7uKcyGHoMcq0yusYfApfnH+B9HY2LH4qb+dl2Cufj
         mr1lh1vv+XTFAcp3e2534wSM4op4VHo9t0bD+jYFGUWvieVMBjBiksV+hhpdE9wxmWxc
         6eM6HiBQFNBGvwAcoNHvitN/5urXRBFrPtgzDbmqnaAPcPwrvgqYhyEV92SqTC5BHKWN
         aCTQ==
X-Forwarded-Encrypted: i=1; AFNElJ+OXYWu6xACVzHEagqsEM1JCCe4MCrE3qQRnoSc1l6CwDF+SO05f5pYz4SuX0k/NW/HZKAL1tqanJX14N+pa2o7vLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgHKbcAS5uP6aBMx9RkFz7GwmATRv47/cgCp92qMlreEXTTCRi
	xvVPhyFXnb8/kQMmmFfPgQRaCdjH3YqP++uGf8znUwoSHHM3SgZoqM17GazHOOz8yDIPeAG0yhd
	35rOVcQVA+6FOjq4qt566kKgzQacAzDyOh0n9pF4K
X-Gm-Gg: AfdE7clqfOvJM/RY1IpGWJ0oXoiHPpOIwpdahkAe1nx6r7adJivI5cEtk4D7txvZ5Ii
	AeIOvQIkQGcW0YX76NebVxGMUr1eC0nJh1ejMfyaw5e404scbMQcdxUsPLXGqjTotK6RYSh67MU
	v968peA7wdXBfc6+Yz7IWKEQv2UwuVUerqn0KznXiaAAQX9V/m7Th2N7YAwGWgepdzbSmRwOSC2
	Tfe4IQvgLtI6qx5NNPkBAJKCV44OTohZyP949d0E5GIE1846IQZWtshZmJyJ23J/nxNuXoGMg==
X-Received: by 2002:a05:622a:681b:10b0:51a:713c:7444 with SMTP id
 d75a77b69052e-51a713c7d5emr4672591cf.18.1782378551258; Thu, 25 Jun 2026
 02:09:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-42-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-42-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 25 Jun 2026 10:09:00 +0100
X-Gm-Features: AVVi8CetvJC1Xv6WjNcu210fkMycJkdRkSQWNh7yK6lGtnxBBkgdQs08aLwNOyo
Message-ID: <CA+EHjTyHQa2Pmgc=0zf6emtALxAN5f8gUXoV11mShz2qdrqjTw@mail.gmail.com>
Subject: Re: [PATCH v8 42/46] KVM: selftests: Provide common function to set
 memory attributes
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
> Introduce vm_mem_set_memory_attributes(), which handles setting of memory
> attributes for a range of guest physical addresses, regardless of whether
> the attributes should be set via guest_memfd or via the memory attributes
> at the VM level.
>
> Refactor existing vm_mem_set_{shared,private} functions to use the new
> function. Opportunistically update the size parameter to use size_t instead
> of u64.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  tools/testing/selftests/kvm/include/kvm_util.h | 46 +++++++++++++++++++-------
>  1 file changed, 34 insertions(+), 12 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 3a6b1fa7f26ef..db1442da21bb1 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -454,18 +454,6 @@ static inline void vm_set_memory_attributes(struct kvm_vm *vm, gpa_t gpa,
>         vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES, &attr);
>  }
>
> -static inline void vm_mem_set_private(struct kvm_vm *vm, gpa_t gpa,
> -                                     u64 size)
> -{
> -       vm_set_memory_attributes(vm, gpa, size, KVM_MEMORY_ATTRIBUTE_PRIVATE);
> -}
> -
> -static inline void vm_mem_set_shared(struct kvm_vm *vm, gpa_t gpa,
> -                                    u64 size)
> -{
> -       vm_set_memory_attributes(vm, gpa, size, 0);
> -}
> -
>  static inline int __gmem_set_memory_attributes(int fd, u64 offset,
>                                                size_t size, u64 attributes,
>                                                u64 *error_offset)
> @@ -532,6 +520,40 @@ static inline void gmem_set_shared(int fd, u64 offset, size_t size)
>         gmem_set_memory_attributes(fd, offset, size, 0);
>  }
>
> +static inline void vm_mem_set_memory_attributes(struct kvm_vm *vm, gpa_t gpa,
> +                                               size_t size, u64 attrs)
> +{
> +       if (kvm_has_gmem_attributes) {
> +               gpa_t end = gpa + size;
> +               off_t fd_offset;
> +               gpa_t addr;
> +               size_t len;
> +               int fd;
> +
> +               for (addr = gpa; addr < end; addr += len) {
> +                       fd = kvm_gpa_to_guest_memfd(vm, addr, &fd_offset, &len);
> +                       len = min(end - addr, len);
> +
> +                       gmem_set_memory_attributes(fd, fd_offset, len, attrs);
> +               }
> +       } else {
> +               vm_set_memory_attributes(vm, gpa, size, attrs);
> +       }
> +}
> +
> +static inline void vm_mem_set_private(struct kvm_vm *vm, gpa_t gpa,
> +                                     size_t size)
> +{
> +       vm_mem_set_memory_attributes(vm, gpa, size,
> +                                    KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +}
> +
> +static inline void vm_mem_set_shared(struct kvm_vm *vm, gpa_t gpa,
> +                                    size_t size)
> +{
> +       vm_mem_set_memory_attributes(vm, gpa, size, 0);
> +}
> +
>  void vm_guest_mem_fallocate(struct kvm_vm *vm, gpa_t gpa, u64 size,
>                             bool punch_hole);
>
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
