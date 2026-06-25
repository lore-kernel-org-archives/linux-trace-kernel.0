Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2D53C1978
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782381446; cv=pass; b=NRBDB8Uiw0ltyA/koa1Xj6yOPuVvcz+n2KUmv57YeDIrMCbBO2wmjU2Fwq2b+1Sb67uY5C2YwrR+L1yT0tdKI3/qgp7YrNGdKg5fXZQoseqMz437bsy99tQtiWq9i4QB/4POp5gdbr5GcQbxYYkd/EbdxfGJbkaEqJ8u6G5q/10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782381446; c=relaxed/simple;
	bh=qvhKJbkEFFfAWC+9rpTE+bYHpR0yaiYW1uDCpafn5Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpDNZc6oqx9mB3fqjqzrCuVd2KfVSKAf87ZAEgCDzNV+nocIMIanMah3J6t7q1WVUX3svC6Vw2IE71sAItuVXVyS/g1z7XF32lCbKa/xP0ExzHMbv5JMt+/Pu2ZhKeGTVAvN2NTPJLDONdxlxsMER6aV9TX2d/ek2pQjc4Pk/fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YeUlOIOo; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YeUlOIOo"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51765531803so203341cf.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 02:57:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782381444; cv=none;
        d=google.com; s=arc-20260327;
        b=AeV3+Ioa4EKdmbDZP203M/kk4q2bFWVaaHFIbKOddtG2ZhZfWCRfPG/zTsRmDEXZCd
         HIk9ka+KKW+beRQJItlLCG/3+kXbCRX5J9ukVChuAuCBC+I1x92GXUzNn1UgCtouVU/o
         dTCwT0pzjv2hK6b4v4TdE4PvmIqHUmAxQaCh54XQ9zKgxcn/7IlTs1Dii/J9O9YlB5Vk
         miqkCfQY1CoWBSVQZlGoGU0mPUvwbBm1+V9fZb8ZNGO3Az768e2xOQmEzG3gLznf8wja
         TSs1HAwTOw7v1EvEAcpcdVQ1wFj4cLv5KwHfqg5+v/AIx3zDljZllU+3YVu78trSBd7H
         EOug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=u/mrXMGknIREFr9L6V/jI2fkRAbyZYaUWGH07oXz/yk=;
        fh=65KeR39RafX0e6KMB/vy3LShTIFxAgrzcPHOq7LCgVc=;
        b=K4G/js1e8Fcu+U6hdBLVDJb5xfHdEzNFaYITVzLqWWKaUU4k+dI7T9lJSe3R0ck3I7
         vIzng3eIfj54+ywKvrLtIlNLF13NxDT6SCLZQzq2Ps6cXTLzXwz6MXHeX8ugWdDt3kV7
         kbQOTOZCkCNUnM5XllCNWjRRzpz9nICrqrCzQPaDSe6q+KJ2TIpEyHYpFQH7V00zJ1nW
         3gh8BZctljw6YBt2RyuXB01AzyBpg+4EtVnHASr0WQEdpqwuo0FitE+58Uuk8sTFAF9t
         7Ix0vYMlxYKHkY4/H/OE2JwEtprnEKhLBwZMYUubO4gZKEsMh39fMVfEC6EEmfMvh8wB
         hhrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782381444; x=1782986244; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/mrXMGknIREFr9L6V/jI2fkRAbyZYaUWGH07oXz/yk=;
        b=YeUlOIOon6VjIzRK28YIwDj/KMrSn+Ynb1pNhJc3HEY/y+OVC6W3hscXNXbix6osJh
         Zu6t+30Tcp2uooHxK4Ea/9Xm044Pzudjp6jpm5fs1q0oycEV2G1KpwXyhnu0QPMnY1Ru
         x7bNKT2UnJpHJSFalXcSsG3zCRKcYKAfpmDrw970D3JAedFRaYpm53T2rXIjRgS8L+nx
         STh4fc2vDih2hqwlqYO0BaliaE/YtSwwucxH1f5UZI1aswaXHcDqOUmNkJRO6gZAio5c
         rbmlVK2FZxXDjJU8mL/5FNbnnrjFzDbYMEEbHxAS7b5OiGvIEJk3K82phs3ezRKNyOii
         HQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782381444; x=1782986244;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u/mrXMGknIREFr9L6V/jI2fkRAbyZYaUWGH07oXz/yk=;
        b=OEOJgUbQlsD5c95p3KgUk3Scs5L0Z5b9S6y30NWjZKIfvx2V9Cb/TjNrvE3b1oSd9u
         1GLQ2FhVskXQ1EVOQpq2IL3vDrq//VK0ObJ2DYpmG9B7+uMCMYb1OhANsYgqimfMluOQ
         toVrBjaw4l87E48viDOrgdOvq9X5Jxkmutt1bdwfVF2WxPRRG5MkMOwxYtoJZecPZ79f
         SQelivqTd2fc1ivst4681KhrrURVgxAanabXlu5DPBQDwOqlwF8REAwBkD3aqr6VIe+k
         GB7Z3ZNpP+4DM+drIdGbMSVr728jubXnmL1iJWuWFGIgH8cmTQbxBz5nJS1vuMrditu/
         09/w==
X-Forwarded-Encrypted: i=1; AFNElJ9nRiHCNxWK1MW0nWW+OxzEoznXHQjrw5NMl6gGeC1+r1buNEZM62pxxip0HZSQ251dH/sDgcKjj2oILjDf+GIjzsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFocDmH/2qPoMBPXitPOS9wp/6QedB4dxvlV1axvnu5JmlWIpU
	vXa3j/2UBO1QL9F9uxI6x3pjdFFI2A21iZYpP23XFv8rvZzaV2nGEmFzi4tknCkQsptGLXCaPWl
	bnMOtF2xuOFZZU1yikejcFsr3kaZ0iV9zmp/9wbxG
X-Gm-Gg: AfdE7cmMLnNMyidfzZc67nyjPZfvOOxdVkWe8KFU1p9bH0dj2ZCUh1h7qzJ/K36xF+a
	ScyqpleytbG9YiDeot985/gDYDIJziuutkzUhf6Jh+sB3iQk5D/zVZGQwblIML2/u2WI6E5t2ft
	4eJft2Mvc54VZcVcWNv5Shtp3icPe7agk2tKnKPYxSZf2nJhVlvC86ErPDVenKh8xqCfmP+BgNT
	cy6+69rR1T4awHn9phrVl3WFtC2Y/9wYyshkISKW2nPzzHJw0dUVXyhu7Q2WkC2UdWrBJK/dJH1
	47y89Rx1
X-Received: by 2002:a05:622a:1804:b0:50e:38f0:ccb2 with SMTP id
 d75a77b69052e-51a7097b73dmr6249471cf.15.1782381443129; Thu, 25 Jun 2026
 02:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-46-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-46-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 25 Jun 2026 10:56:00 +0100
X-Gm-Features: AVVi8Cdu5TEy7e9mOJQzpvO2gtGAQsCwELbue-J7rOmw4IFWddPVfZNy_ZtxEUs
Message-ID: <CA+EHjTw3MrKXdOjC10Q6rrxehwYZjFv7J45wK2E2PBWtSBwCRQ@mail.gmail.com>
Subject: Re: [PATCH v8 46/46] KVM: selftests: Update private memory exits test
 to work with per-gmem attributes
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
> Skip setting memory to private in the private memory exits test when using
> per-gmem memory attributes, as memory is initialized to private by default
> for guest_memfd, and using vm_mem_set_private() on a guest_memfd instance
> requires creating guest_memfd with GUEST_MEMFD_FLAG_MMAP (which is totally
> doable, but would need to be conditional and is ultimately unnecessary).
>
> Expect an emulated MMIO instead of a memory fault exit when attributes are
> per-gmem, as deleting the memslot effectively drops the private status,
> i.e. the GPA becomes shared and thus supports emulated MMIO.
>
> Skip the "memslot not private" test entirely, as private vs. shared state
> for x86 software-protected VMs comes from the memory attributes themselves,
> and so when doing in-place conversions there can never be a disconnect
> between the expected and actual states.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  .../selftests/kvm/x86/private_mem_kvm_exits_test.c | 36 ++++++++++++++++++----
>  1 file changed, 30 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c b/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
> index 10db9fe6d9063..70ed16066c63e 100644
> --- a/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
> +++ b/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
> @@ -62,8 +62,9 @@ static void test_private_access_memslot_deleted(void)
>
>         virt_map(vm, EXITS_TEST_GVA, EXITS_TEST_GPA, EXITS_TEST_NPAGES);
>
> -       /* Request to access page privately */
> -       vm_mem_set_private(vm, EXITS_TEST_GPA, EXITS_TEST_SIZE);
> +       /* Request to access page privately. */
> +       if (!kvm_has_gmem_attributes)
> +               vm_mem_set_private(vm, EXITS_TEST_GPA, EXITS_TEST_SIZE);
>
>         pthread_create(&vm_thread, NULL,
>                        (void *(*)(void *))run_vcpu_get_exit_reason,
> @@ -74,10 +75,26 @@ static void test_private_access_memslot_deleted(void)
>         pthread_join(vm_thread, &thread_return);
>         exit_reason = (u32)(u64)thread_return;
>
> -       TEST_ASSERT_EQ(exit_reason, KVM_EXIT_MEMORY_FAULT);
> -       TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, KVM_MEMORY_EXIT_FLAG_PRIVATE);
> -       TEST_ASSERT_EQ(vcpu->run->memory_fault.gpa, EXITS_TEST_GPA);
> -       TEST_ASSERT_EQ(vcpu->run->memory_fault.size, EXITS_TEST_SIZE);
> +       /*
> +        * If attributes are tracked per-gmem, deleting the memslot that points
> +        * at the gmem instance effectively makes the memory shared, and so the
> +        * read should trigger emulated MMIO.
> +        *
> +        * If attributes are tracked per-VM, deleting the memslot shouldn't
> +        * affect the private attribute, and so KVM should generate a memory
> +        * fault exit (emulated MMIO on private GPAs is disallowed).
> +        */
> +       if (kvm_has_gmem_attributes) {
> +               TEST_ASSERT_EQ(exit_reason, KVM_EXIT_MMIO);
> +               TEST_ASSERT_EQ(vcpu->run->mmio.phys_addr, EXITS_TEST_GPA);
> +               TEST_ASSERT_EQ(vcpu->run->mmio.len, sizeof(u64));
> +               TEST_ASSERT_EQ(vcpu->run->mmio.is_write, false);
> +       } else {
> +               TEST_ASSERT_EQ(exit_reason, KVM_EXIT_MEMORY_FAULT);
> +               TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, KVM_MEMORY_EXIT_FLAG_PRIVATE);
> +               TEST_ASSERT_EQ(vcpu->run->memory_fault.gpa, EXITS_TEST_GPA);
> +               TEST_ASSERT_EQ(vcpu->run->memory_fault.size, EXITS_TEST_SIZE);
> +       }
>
>         kvm_vm_free(vm);
>  }
> @@ -88,6 +105,13 @@ static void test_private_access_memslot_not_private(void)
>         struct kvm_vcpu *vcpu;
>         u32 exit_reason;
>
> +       /*
> +        * Accessing non-private memory as private with a software-protected VM
> +        * isn't possible when doing in-place conversions.
> +        */
> +       if (kvm_has_gmem_attributes)
> +               return;
> +
>         vm = vm_create_shape_with_one_vcpu(protected_vm_shape, &vcpu,
>                                            guest_repeatedly_read);
>
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
