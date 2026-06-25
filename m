Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA73917C220
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 06:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782370720; cv=pass; b=j6PyIzjw1CAAhab88t2xegWR0tTps82aaDGV9HSZSgbbROmhoHIvZvL0WuBpTUR75GMPoCyny0zek9g/I90TYDVUx/MZvpEQ+LnhRsQtU4MEK0NdWVUqHGvcr4IUGTX6r1KtD5+NIpSUxFKsvo2BM0+ugysAO6eFS+tMfl3Jsp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782370720; c=relaxed/simple;
	bh=SyGSbXNz8q/qDroqw0sxRk5+NR5xp21V4hgaN/9L/0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aMmRQiaWkwHdZIttnReHBLqGu69OxUx75B5jgmg5j5sgdadtE0ylMNctSsI6xwJvx8f21tZ4DqAMQJcVUtpJkM0blSiZZycQye4UCEWRHXXdAIf+LIIk1st9haQ+EHXvPjpX7W/kCx1gQLOVbe4LfLCHNjwPUAVJ3p2tQviWQQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tGupKp70; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tGupKp70"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-519ed52bcc6so180601cf.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 23:58:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782370718; cv=none;
        d=google.com; s=arc-20260327;
        b=kpIiQqud6bzlY0G5SOBwGiGoL/816K7Nudh3dJakWI7j78UvMYsUg6+/t2f013vC0O
         ITXlNMxkhnzMRSxY2Io4tUDmDqFelUWH0cJo3NNKANQa2KiHC/YW/DiWrmzjFY8cA0bg
         QE4CFSK+q9cLjVn9dm1MQoRMxtlnDtVCQ7yoTXS0aBFXmwSyLVHVnq6GpqfgYdQv5eof
         cJY2B9RU+eeHOye4Jm8eDfj0Rq7/aK/eGl9dBAhoS1xIyqkAZ36zLZZl94zxCa/V5EQH
         WrvmfLstFcpjP2z4MjDO4yTmvFB6Ka57kL/Lms4o6bqtnwDHX5IR9FiQgTDMy6NXdehK
         /Txw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KdGqwRZEoBZlGth5crGGDiriD2nf5vVEe54PRH1YZ7s=;
        fh=fhcS/O5sEVNjBtfTxaH63kWtGnhC+qd84yfwAYbs+3Q=;
        b=FOfTzfr9CNrrNu0dpZAMihG/VVLkfSLLqZqlLImN/H8Nk0rsSEYxztg6STY7Egj5Gk
         TFR7SIqEnKuVMMFq404+0mz1xJjQ+fi4IBa60zsIffbI2CAYobaBVwwz8E/ebAqx0Zq1
         gHIVNQ6imXrFUvMPn3c8wQcAQG0o6OeaUeuqxhs1zOnlsU5rcJggqjBZtz4fVemXk5hH
         C1EuOLxfx3ZQ3KF7MTKXbQfGZOyD8l109RuKdOif1302qQhk/c+SyE8Xw5rcgSG44mlh
         foXjoPQInuD225wyu33JxheWIWYfLkyQNWGvz8Lf/y3ptrdhlDVmJWxWDfxnQuy5TMy8
         wNoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782370718; x=1782975518; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KdGqwRZEoBZlGth5crGGDiriD2nf5vVEe54PRH1YZ7s=;
        b=tGupKp70o6smKJB8ePSOk+DwlwWcKNkV93oqRQ/I7T8w4llXQ8DAjcl+v1KxTs6GEc
         HleWAcUwm7Zz3qU7x/6LvN62bo2nfqUMm32TbZJPVxdg1Ylsy9e/f7YJX0/SQ0N0frEb
         ZMSajdlg3t7RHxislDw22vxIk9zH1iZqdT6HBWFZX3+yTArPMREusZu8MukaMwPlgdiN
         nDmw7b7Nzm8AsOjrJ0SDU2ZSKy0Mz/TiRPvbEOG1m4VLeVnxmM/n35xvmil5lUXHjRZ8
         q7Su8DZjXg7vPYSucskLr3bfG2lV1HrS3tBRS1xGr6P6jseZXvaB+9n1WUJzyAVywNOe
         BQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782370718; x=1782975518;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KdGqwRZEoBZlGth5crGGDiriD2nf5vVEe54PRH1YZ7s=;
        b=TKQpIZvdFv2XJhFFLH8Xb0F7cS2m1gYmSj6d1kElm6WggxVytfvlBvYNK5HiTiJ92E
         leDdyM7il7wulwxwo2+0GIQYWtYR/pQU4RE2QqK7a8iSPQwJtJFfY+3A2V2b9ICqX8Qx
         G1hQthgKrz5dMa/iApd7tye/1i5iyQR/cVYmdjXE0bhYZVHQFWSVs2cczwt78NHoXh/K
         FeESBH+rE73maTnG08ZlgTRL37wOJJQqW+94x2wFKBUl/eLUnFy/PwaL8ViWfGw8xFvg
         JQM32zdXVkBYJMT6ncaa4/KNwsmPfFYB17sV5O4mUYDaNh5mBRPNP6P1mxarvz6SjqN4
         3e9Q==
X-Forwarded-Encrypted: i=1; AFNElJ8ORHOY6WDS178EXfOKOVYAf2Ra/LTknZ7CYQPM0qz/sKhEZhZsWHouyKN2Ofa0ptX72xSRpXMaCK9wF3tNh9/wmoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCHMk4X8lViPSqY6kwBM5qcArSGwcS68locKjtu4DzyeEOrISz
	o1yNDXWTTBf7f7NylkTnFh31mlmplkbVU641WWsJ3uPK7x7P6qVuQqpaht6au3pfT78SbLZznDd
	vdcCUWLgR2vL/Qbhn/m+mXvF/PNruanFo7hcXv596
X-Gm-Gg: AfdE7cn1JBPjote9vUKtP/bKW+P8Hf+ONCHoxMqPYrCZe0N9tnfBfEHY5qSb7f6khrn
	3P8ZulKmL0W7RFtdMqQ8hn2zktAtMVEaHeJOCIzU/j47jduUZcj74Q69yRhgiWtveKTKGQ7dVM8
	hr3a5u/PEJBl9/ENibAg/xBn9g5dsH7PXppAMQBX77izeFZeydwiecF20sqG1VGLdW2KfKb9kGc
	v1qkOiwXrBjhjqskyYsEXNvIdU5XVDsukyY++rxe7hhuoRenDiwggPBx2ouCWOHL3JTajAZFA==
X-Received: by 2002:a05:622a:586:b0:519:f8a0:16b4 with SMTP id
 d75a77b69052e-51a6eafc644mr6248791cf.14.1782370716783; Wed, 24 Jun 2026
 23:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-33-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-33-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 25 Jun 2026 07:57:59 +0100
X-Gm-Features: AVVi8CdlUqqm7utRrODu0hzmedC063K0MES5T7_EuttwZUvfcmHiCBLx6crELI8
Message-ID: <CA+EHjTw=-yzY+SLvLFwJx+73OeYcBmT3YHYQmuf9=fx_KoebmQ@mail.gmail.com>
Subject: Re: [PATCH v8 33/46] KVM: selftests: Test conversion precision in guest_memfd
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
> The existing guest_memfd conversion tests only use single-page memory
> regions. This provides no coverage for multi-page guest_memfd objects,
> specifically whether KVM correctly handles the page index for conversion
> operations. An incorrect implementation could, for example, always operate
> on the first page regardless of the index provided.
>
> Add a new test case to verify that conversions between private and shared
> memory correctly target the specified page within a multi-page guest_memfd.
>
> This test also verifies the precision of memory conversions by converting a
> single page an then iterating through all other pages ensure they remain in
> their original state.
>
> To support this test, add a new GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED
> macro that handles setting up and tearing down the VM for each page
> iteration. The teardown logic is adjusted to prevent a double-free in this
> new scenario.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


> ---
>  .../kvm/x86/guest_memfd_conversions_test.c         | 66 ++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> index 5b070d3374eae..8e17d5c08aeb8 100644
> --- a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> +++ b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> @@ -61,8 +61,13 @@ static void gmem_conversions_do_setup(test_data_t *t, int nr_pages,
>
>  static void gmem_conversions_do_teardown(test_data_t *t)
>  {
> +       /* Use NULL to avoid second free in FIXTURE_TEARDOWN (multipage tests). */
> +       if (!t->vcpu)
> +               return;
> +
>         /* No need to close gmem_fd, it's owned by the VM structure. */
>         kvm_vm_free(t->vcpu->vm);
> +       t->vcpu = NULL;
>  }
>
>  FIXTURE_TEARDOWN(gmem_conversions)
> @@ -101,6 +106,29 @@ static void __gmem_conversions_##test(test_data_t *t, int nr_pages)                \
>  #define GMEM_CONVERSION_TEST_INIT_SHARED(test)                                 \
>         __GMEM_CONVERSION_TEST_INIT_SHARED(test, 1)
>
> +/*
> + * Repeats test over nr_pages in a guest_memfd of size nr_pages, providing each
> + * test iteration with test_page, the index of the page under test in
> + * guest_memfd. test_page takes values 0..(nr_pages - 1) inclusive.
> + */
> +#define GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(test, __nr_pages)           \
> +static void __gmem_conversions_multipage_##test(test_data_t *t, int nr_pages,  \
> +                                               const int test_page);           \
> +                                                                               \
> +TEST_F(gmem_conversions, test)                                                 \
> +{                                                                              \
> +       const u64 flags = GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED; \
> +       int i;                                                                  \
> +                                                                               \
> +       for (i = 0; i < __nr_pages; ++i) {                                      \
> +               gmem_conversions_do_setup(self, __nr_pages, flags);             \
> +               __gmem_conversions_multipage_##test(self, __nr_pages, i);       \
> +               gmem_conversions_do_teardown(self);                             \
> +       }                                                                       \
> +}                                                                              \
> +static void __gmem_conversions_multipage_##test(test_data_t *t, int nr_pages,  \
> +                                               const int test_page)
> +
>  struct guest_check_data {
>         void *mem;
>         char expected_val;
> @@ -199,6 +227,44 @@ GMEM_CONVERSION_TEST_INIT_SHARED(init_shared)
>         test_convert_to_shared(t, 0, 'C', 'D', 'E');
>  }
>
> +GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(indexing, 4)
> +{
> +       int i;
> +
> +       /* Get a char that varies with both i and n. */
> +#define combine(x, n) ((x << 4) + (n))
> +#define i_(n) (combine(i, n))
> +#define t_(n) (combine(test_page, n))
> +
> +       /*
> +        * Start with the highest index, to catch any errors when, perhaps, the
> +        * first page is returned even for the last index.
> +        */
> +       for (i = nr_pages - 1; i >= 0; --i)
> +               test_shared(t, i, 0, i_(0), i_(2));
> +
> +       test_convert_to_private(t, test_page, t_(2), t_(3));
> +
> +       for (i = 0; i < nr_pages; ++i) {
> +               if (i == test_page)
> +                       test_private(t, test_page, t_(3), t_(4));
> +               else
> +                       test_shared(t, i, i_(2), i_(3), i_(4));
> +       }
> +
> +       test_convert_to_shared(t, test_page, t_(4), t_(5), t_(6));
> +
> +       for (i = 0; i < nr_pages; ++i) {
> +               char expected = i == test_page ? t_(6) : i_(4);
> +
> +               test_shared(t, i, expected, i_(7), i_(8));
> +       }
> +
> +#undef t_
> +#undef i_
> +#undef combine
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
