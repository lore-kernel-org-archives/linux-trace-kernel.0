Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793831516;
	b=1J9/oYE81wuSKHIBPeLHcXLx1/A+BmeO15hv+QIUe2UQJLIfU9T1cdhbaaOQX3ZSPuUD
	 e7+FUcjzoPBTsdt9Zi/8q+jfC3CCACcOjyaGzIQ05JLiGcPQOxZTk08SgiDWqCSWFK0aB
	 25r7lyj3+UPPUT0CULgOKrJojUCuSAUSYfMUlqZiMN7pIKmR1HknJecw+3ARD/PmT0DvC
	 J85/NcTu141V6mHnNxFmL53quIVMBWNUAxl2OwszO7kLP6b+nxiHwVKo9j8B/ES5iw1Oy
	 HkLV7WN9FEft4u+cs58i3ATrbHQb/zbkezZgqznrVCcTslCxsTzBI5ovYv1ewFtinXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793831516;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IZQGrkSDxvYhOH9fwbZBQNsu+CCHkAHmzOvW9coQa1A=;
	b=R4lgxQSun9I5twS45Dw78vP+H3m0wCvNfuTYxtDE8t0paOUSgaCYqflXE6DLqwGsuEAb
	 RA0ZHn5QETe/fRttrkWybhJt/Oz+mUsfOJXghC7cyB+I5sa4sStKsPBe6whyJcU+PKsqp
	 suN1tNrK/MiFIeTuwWYBV7XeGk6tq4S4fFGXgjq+qIgMx1056Y8BTWmEZv9/X0YvpQaIL
	 ubKdAVonYU1dcUHJDJrUxtUYKX1XDEpj0Uo3L/SQaQi3RrmwPF3HJEIgRShh4RW1dzHNd
	 XALCjbQEQaX1Ylkct+P7GVUpwRre3UBpYPGpdRjqIKxW7j27Bq/2ecIkGGtxQPuzirA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oJ2Pr3YC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C5F606A33A
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Nov 2026 22:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oJ2Pr3YC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E521F00A1A;
	Wed,  4 Nov 2026 22:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793831516;
	bh=IZQGrkSDxvYhOH9fwbZBQNsu+CCHkAHmzOvW9coQa1A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oJ2Pr3YCv8dGpxd1xuaOrMwBYV5a9uJr7xhfDvM8vD7VPOlh8TaPvZKNZpepXtr1N
	 f9aLC7HUTzzF9ZB0C/3KBjub7+Ms40UFnUqCjaL055Wwqp7XGDFW+c+sMTyZxhghO6
	 4L8fvkKe6BUWGHiFDUK7vJR8JyvB9nEFAiFlh2fGtbAA2aQDVAGtAveu7Wq3e5+r7z
	 g/thipPF5Vcukvu5HkKuDNwQIFqBF/HyGAe0zbFsqZJlpx6lR0WczSy9qBrZ/u6jT8
	 35qox3c7eqNJHZ4D+YPLBmar7ocYtv4uzBvf6J6Llu/3Vam4xvYgWykqpC9dipK+ue
	 0CFkN7/FKW7Zw==
Message-ID: <sashiko-outbox-198230@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 1/3] mm, x86: support copying a folio using
 non-temporal stores
Reply-To: sashiko-reviews@lists.linux.dev
To: "Huan Nguyen" <nhuhuan@google.com>, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, trondmy@kernel.org, anna@kernel.org, ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, jackmanb@google.com, hannes@cmpxchg.org, shivankg@amd.com
Cc: rientjes@google.com, dave@stgolabs.net, nifan.cxl@gmail.com, fvdl@google.com, jic23@kernel.org, rkodsara@amd.com, bharata@amd.com, sj@kernel.org, weixugc@google.com, xuezhengchu@huawei.com, yiannis@zptcorp.com, yiannis.nikolakop@gmail.com, dimitrios.palyvos@zptcorp.com, alirad.malek@zptcorp.com, ryan.roberts@arm.com, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>
In-Reply-To: <20261103223025.2482227-2-nhuhuan@google.com>
References: <20260730-rfc-nt-demote-v2-0-452dbe3b5073@zptcorp.com>
 <20261103223025.2482227-1-nhuhuan@google.com>
 <20261103223025.2482227-2-nhuhuan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 22:31:53 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] x86/mm: missing KCFI_REFERENCE() for copy_mc_page_nt()
--

commit c8614f6dfdf00a57c43828a75e8413d839e5a48b
Author: Huan Nguyen <nhuhuan@google.com>

mm, x86: support copying a folio using non-temporal stores

This commit adds copy_mc_page_nt(), copy_mc_highpage_nt(), and
folio_mc_copy_nt() to support machine-check safe copying of folios on x86_64
using non-temporal stores.

> diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_6=
4.h
> index 1895c207f629a..f37126b562390 100644
> --- a/arch/x86/include/asm/page_64.h
> +++ b/arch/x86/include/asm/page_64.h
> @@ -114,7 +114,9 @@ static inline void clear_page(void *addr)
>  	clear_pages(addr, 1);
>  }
> =20
> +#define __HAVE_ARCH_COPY_PAGE_NT 1
>  void copy_page(void *to, void *from);
> +unsigned long copy_mc_page_nt(void *to, const void *from);
>  KCFI_REFERENCE(copy_page);

[Severity: Low]
In arch/x86/lib/copy_page_64.S, copy_mc_page_nt() is defined using
SYM_TYPED_FUNC_START(copy_mc_page_nt) and exported from assembly via
EXPORT_SYMBOL_GPL(copy_mc_page_nt):

arch/x86/lib/copy_page_64.S:
    SYM_TYPED_FUNC_START(copy_mc_page_nt)
    ...
    SYM_FUNC_END(copy_mc_page_nt)
    EXPORT_SYMBOL_GPL(copy_mc_page_nt)

When CONFIG_CFI_CLANG is enabled, SYM_TYPED_FUNC_START(copy_mc_page_nt) emi=
ts
a relocation against __kcfi_typeid_copy_mc_page_nt. Because Clang only emits
__kcfi_typeid_<func> symbols in C translation units where the function has =
its
address taken, and EXPORT_SYMBOL_GPL() in an assembly file does not include
the C-only __ADDRESSABLE() annotation, nothing in C takes the address of
copy_mc_page_nt() (which is only called directly from copy_mc_highpage_nt()=
 in
include/linux/highmem.h).

Will building with CONFIG_CFI_CLANG=3Dy fail at link time with an undefined
reference to __kcfi_typeid_copy_mc_page_nt unless
KCFI_REFERENCE(copy_mc_page_nt) is added alongside KCFI_REFERENCE(copy_page)
in arch/x86/include/asm/page_64.h?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103223025.2482=
227-1-nhuhuan@google.com?part=3D1
