Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6EB3CB911
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 19:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782330912; cv=pass; b=cioD04ldNzgaYaIWojF54nWObd7Q3ZZTLge2N1e+6RMR9twQlzwQsxZIWz6VJ4lA1gu3dctlTyhHHYK6clwVvvsvq6IykfBQruqI5Z93A6ESrzemEZfAcOccc+zACj8Bq1ObK5+ddmBcgDDx96VCRmmT18AoAKQ7kZWyOdO3MKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782330912; c=relaxed/simple;
	bh=W1Q1ZIS1tK0GuoWOs7eGstZIyMHoTFwb+9lbpX5rjyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+Dj5iwgayZ49f0bIgm2H98E5Q3yAt7qiABCICULbjvkQsdLxnr45ZbvNriSFbo7XzLFisxxFf4TrVy0bxNCZKDPrJSMCcJ2x1+lpbqPyYW44HZ4w5bn+joVkqQBQ4JKgEbhfXgpGhR3g2xv9KwSGBbYsm3+r+80DbeMSK8VA+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IKFxI7AN; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IKFxI7AN"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51765331535so5441cf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 12:55:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782330910; cv=none;
        d=google.com; s=arc-20260327;
        b=QQ3MWsiJOpG1waet20VxwEJf0kCrKlSAi5VF5lKjqq3bXmDOSGpSUgMPW+za7MjXg0
         0Nx0hmCe5WsQ8gdoplUxFQHYOBs3o/pm2+VL0S3dLQpnBZjetnXNqt3zkIFI+wgGBQPc
         At+N7VoJQNxJSDhYPoPWkCz/cOPly5JIjy1NB03Ki20cAN0jYZ8TJEA2yEqhGlxlOUbs
         +Qvem/U/p3FjkUDUzDtsav58UbMfsuhS2XUbrtLetFHm6i3D5QSGOPDnu1mBoi7CYDlv
         0bHEEG/qCBfE9P58PoUNh0xXMr+uxjKIqIJdvPySH6YFuMqtdr7/7NP9hxAZsC9Le0Ul
         /Z2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CJJECXfHWYzxy9+jrHC2YkFB6UtBZdMEUotYUUXmsS8=;
        fh=Q8BomiWs9maphHi7o8vYlcg3XBSlnz2Gxik6JW51eCA=;
        b=SVVFwkfVyKOmCW1ZqpXRBSk7CfIyg0X5NjfHuOHT4IXUUoFSQ5y6qObQzpBIE+jMqf
         qQdxDb610Yxd9/Hc3rVHgVHw+dI4chGbNedcQr6gIfDdfteg/ZOvtdVPj4EZPfMB6w3e
         IUBNotWOHA6VZ/1yQVf+Ba/2oC3xcKkbZT6n/XLoP0YWXdNxP5j8RouAekI2lxpe2n4g
         4g64h+rMVkWPncH6lU+jKG7yVgngwO2LclxuP8nhUKN8xXiFMejS14lKk9fnkqyqtMR0
         R1azzbZEABTEjF7FUgxyCMD1k9Rx1vFbzfuveTVjT10liQmN/LrcfWXzRud3sQx6HdXH
         YV0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782330910; x=1782935710; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CJJECXfHWYzxy9+jrHC2YkFB6UtBZdMEUotYUUXmsS8=;
        b=IKFxI7AN91+Su44+nzY2J9cDEgCqiE9J+SIujBBBjaKcESFQBYMLk4NSnVfh4BHaTk
         fHp24xs2Z1426Qh5ujvz5rpTWPA4hI1GKASTogqqeosMvV40tjnb2dWppPw0oQSZUR00
         +R5TFV2iPHRtaE96mp7eEUB93YaIvSgCYlp588GveDYO/ZgbqoWpwpUZQ3CdQdifT9Eh
         /jtCFx9pZORu3/vioCHLYNAZ6FuoqFKo842YYo0T4KqBlY9XOyexra5zeC36h5CHUJrS
         5gu/5+hlYXpQd7JQBFMdPpR8EOylySyW5v+wM3eYy+hrajoD2OW3Af0bcZ+UuNcXPKwb
         hUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782330910; x=1782935710;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CJJECXfHWYzxy9+jrHC2YkFB6UtBZdMEUotYUUXmsS8=;
        b=I7ONDj20fBqaYurJSAOCCuycmvIZMumGOlQyGfPJ3VS6eIRsFKH9TyOr87K9PNUUUZ
         scP6ZjuxUj2NU5Wc67WK2trrWd/4g+RrUv0DMJohfC20TlA/o0bq0ReZ437lfkTnV8Vz
         dCJRUf0BUDsGrTz9btWNXGPsY4GQkWE8R1U126NbF+ROJ/gIKqJzdlqhYqVeiPClfsDc
         hd1wEP7JlwqaISDawyIwub1Wph8ASHOeLnQT3q/kikn4Dw84ytDN+vlipdjPA9pHKFUA
         IbVv7I5LahAz63+ajP136kRnKROiX8sLDzE2wzpW6bKe6HaxtlTH74xVTFQipdP582Qi
         G5Sw==
X-Forwarded-Encrypted: i=1; AFNElJ8LSO1JOjRchWrKSffFVLI+2NQbA0bNuMEGNAbYhRQORYVkmUNevckxDvtHlp0/fNeuY+oevNjOBYfrgsfnuyHjZug=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzxR6fz5DKNDsz5ecUADoDlNAb+jiTMPvDPAFG6mofCbjCTI1y
	HrEbPHOnBN8mAkO1lV2l2WUExDaAysxmT06zcei5MNaw950gniY9TBhSftvYL6mh1f0153D/mig
	AEJKSqYBCCdr8DKE8jp1oU5dEg6CL9CQ6jxiQY+0o
X-Gm-Gg: AfdE7cmcgMMjR2WJLyXYbKBY4/5p5rRg9FHuKSa9yukY534OBWepuQ1E+2TKLoWNRXw
	Fr6SChXp0y7phNXn36qpXY/AUgK28LMD2aTAX2cw4XgBQIHJQuK4GMgs1oKk7zH1ES/64+o39oT
	3S8ivFrs77YODRGLJjnrmUjSsFvbID4XDsULGjfrPd8iEXGiGkETMtaVnVY25gDFA+ycftg9pxP
	dpu4pawNNs/ZRKkFXdIRegdIij/pcYZW9IOKBLwgNUbJrk534Yge/y9TME+tBa6jVRxhEMUpg==
X-Received: by 2002:a05:622a:64a:b0:519:df4f:6c93 with SMTP id
 d75a77b69052e-51a6ebb200dmr1920671cf.20.1782330909527; Wed, 24 Jun 2026
 12:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-32-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-32-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 24 Jun 2026 20:55:00 +0100
X-Gm-Features: AVVi8CdkNL-Bi4CuQeJBlP58vmddsTQ61Xm1xaJ4QXqFxTKdTVP42Qqva81y8NQ
Message-ID: <CA+EHjTwJYQmg6oTU49ObF5fQCThghn+TMau=g5zUP8w_KLuiKQ@mail.gmail.com>
Subject: Re: [PATCH v8 32/46] KVM: selftests: Test conversion flow when INIT_SHARED
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

On Fri, 19 Jun 2026 at 01:31, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Ackerley Tng <ackerleytng@google.com>
>
> Add a test case to verify that conversions between private and shared
> memory work correctly when the memory is initially created as shared.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  .../testing/selftests/kvm/x86/guest_memfd_conversions_test.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> index 8e09e241723e5..5b070d3374eae 100644
> --- a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> +++ b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> @@ -95,6 +95,12 @@ static void __gmem_conversions_##test(test_data_t *t, int nr_pages)          \
>  #define GMEM_CONVERSION_TEST_INIT_PRIVATE(test)                                        \
>         __GMEM_CONVERSION_TEST_INIT_PRIVATE(test, 1)
>
> +#define __GMEM_CONVERSION_TEST_INIT_SHARED(test, __nr_pages)                   \
> +       GMEM_CONVERSION_TEST(test, __nr_pages, GUEST_MEMFD_FLAG_INIT_SHARED)
> +
> +#define GMEM_CONVERSION_TEST_INIT_SHARED(test)                                 \
> +       __GMEM_CONVERSION_TEST_INIT_SHARED(test, 1)
> +
>  struct guest_check_data {
>         void *mem;
>         char expected_val;
> @@ -186,6 +192,12 @@ GMEM_CONVERSION_TEST_INIT_PRIVATE(init_private)
>         test_convert_to_private(t, 0, 'C', 'E');
>  }
>
> +GMEM_CONVERSION_TEST_INIT_SHARED(init_shared)
> +{
> +       test_shared(t, 0, 0, 'A', 'B');
> +       test_convert_to_private(t, 0, 'B', 'C');
> +       test_convert_to_shared(t, 0, 'C', 'D', 'E');
> +}
>
>  int main(int argc, char *argv[])
>  {
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
