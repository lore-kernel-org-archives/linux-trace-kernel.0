Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D411384CD4
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 08:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377258; cv=pass; b=acdXc8I0giPTZbjSMNFWrcP2eArypECbJ4UQHWiYjhu6+XbePongxbamsZ11x4n5gue6/cgMIDyXYQZZ8TJPjUknSmxqS4ZOkg0pN6uNAw4nJBID0NHmmWr7GfK7e1S+bIHzUFwgaeeNL+wbNmjGwven5C9/SYAduyd1SKM8OAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377258; c=relaxed/simple;
	bh=rcYaGj7kmNHFT5KlkfLFAP87Gtcx0zYbs6pHF/7fSTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVuZFqc6K8u6fk1gpB4UnFIzCHjeJ/PV2RmYdW5ZOWXqTF4TjtvA/1t6PF8vNkwH2twgq8NtKFFEC1S/eWHROFbcaWHmaJ+b1vglwvar0Vfn32IYogJVh7OydjLZoRyntz3X2FdD1V5blufzIHhCAPB9d6YaZ0qkWrs/gzjTEq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i18uyhwP; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i18uyhwP"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-519ed52bcc6so209311cf.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 01:47:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782377255; cv=none;
        d=google.com; s=arc-20260327;
        b=VEOMTDOfYF+y27r25H1/GGP364duXUu1YCoPNjChZs0FNWVH44sbgIuImqPycpv3jY
         TWdZgwFYZt7Be/AcBicd0h8aUo7BlHzWIYVN4xD9Mtwgzh0R027vExIak9aZ+Or/ISQL
         VXVaVM70S3rtPwG6z5QnR3f7yx4NZKqxmRy/5J1hRkvJvcPC9Xzw5JhdidaieQ21GUrV
         wYwacfR3RnV8bCkeYwhJFk28rWbivznGOuyr2jZhOX4xw9tvWZ+h3/JoBTNV39jH4ddv
         dj8OpOeY7dHRUgDHHt9lSnKzDfnnnqzhLftYwBQPtRGRI4MyUgWGyYILdhRjTTRCAXdg
         6w9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=L1P9iL5yW4BU9W6Dd1onnqzvZzuIUKT6XldZibc3Vyw=;
        fh=l+MJaVFIejFfajOkfdZmFoJ651K2vs2O4CEYon03rDM=;
        b=aW3yW/U+J4QIkc/pAZ+Roy2mTXrjEhvnUl0C7Uk6Cqm8Y10UrCVzgLsQ5geC3YqI0A
         wpdiEkXM6wS8uWTjrAMTWM7838oQ9IHD+8Qt4LLDL7k6djUL8oXJUDNh2IfP8G9IGGre
         Gnf3Ks2k4qndFZz82K/Xh0bPXXprX3esCibTL3bIUngDjIYW3gI1ED7xffc0LrYSSDi/
         slWkJgGyUYwhpTiFNeANzedFuHg7LmIt/b2cdN1cBU0vdwFZ9jF59+lOKp+DNQseZMzK
         Q7owSW0TJjytIOpayGTNaBKVwhCuA/8+xaPaCwMoNPEDbZRzmtVJS8NaZmAVSTH7Ecc4
         S7ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782377255; x=1782982055; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L1P9iL5yW4BU9W6Dd1onnqzvZzuIUKT6XldZibc3Vyw=;
        b=i18uyhwPSpt4uOmX4NzfZvIwT3wKQ8maf2CpLRcblIiKYCl4LpgjDCxqeaPyJvJqRq
         a3GibJSiFgkgs8ou1X9pvIBasPVKaewpazNJ3Rg+OJ3V6uDPV5KWcqpAgjXlqdAog4dS
         OPrLnOOl+2ZO7hnaNrc8CWabV+UgTU+U/yLL2HVK+bACuk1NP+RiDIvqUtwBQxMZ4KQx
         Jk+dubmF0WFdVv93v0QUt4BWfvt+2h8khGN9fD4BVmOd+kt2T219A9MfzXyCr0daSMp4
         Mo9GTDeDZA09xHIxhUrT3g6ycUbAAgKZqYOWA2OYFHfsXd/6aoqzWx1G01jfWsqUWsPD
         KDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782377255; x=1782982055;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L1P9iL5yW4BU9W6Dd1onnqzvZzuIUKT6XldZibc3Vyw=;
        b=amqwICrEFrAQ5ZPkjtycn1kJ7wtn9Rot4bq4rEPHhyYbgPfJys3TN76p2cQzuR7EAS
         l+ycrE6xt0bxgveJIkyXSm8a1xwhhELabGOVzSdgNhryI6gbBYD+90OJA4aPuCVqDulG
         NRduB66WxvYuD6zyChoJcLpPV9kXsZfJbgvDl8SHC/7xLQXN11AxgEYNwPHVglYYcKqS
         TInROTyeCyeRsxHPbQs6HL9SlVY2tTKMMAY2l3F4arJtHdtR27EFofFHvY4r8kWm3RlC
         74qS9MNVrqzObt6BYVZUe1lbtr2492UZLd4YLxQdyDIXZ6T4Ypm/PasTQm0nCwXVK3Mt
         mFfA==
X-Forwarded-Encrypted: i=1; AFNElJ/ceo+lItekZtRTQvo8Kss9LJHv5OTpXrHTFnxDyYUo9j7zgsem/7KN8SXmxrVC9zgEUpTUMfifflXeIR/USrdIz8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyreLGFaHwCPKF3DJn/MYlIHJhyHu04F/89OVEBqd4wVCU3fQd6
	ZfRDA4b34x0X5QWAmShyNzJp3/c9qOz34rTwIYz9Vu8NXOzsBdXDHX40p0JhUP6zHybJcIZE+Ur
	bjeWUSdN3nZFBndw8FbWo1CmZ3DagSh15TuKRAQ3O
X-Gm-Gg: AfdE7cmdrLl81YSs+IjQPQRUwZfm2FF2AA1RQgiNPycWvN3JQHfPvZDeyXlZWF0MdJS
	yHUYUhwvrqYo+FblzZsk7Ih8mvsVF2CK9i891Pju3P8EB+WCOjNNvqJnl3g1JaDryuufJC8G0Zg
	0cEXaRjo0gw4RIXE9wpID5NQV/N1FkZ2tJgfE84nV2/PAJTSHIdXmJhjP4KCMVdQvfnQXsRBcw5
	OCvRj7iILrL0ySYApIL1fY0uBAFfirq1Gov74zYWOHl1GqauFA7X8PYSWcDNrNvwtz5RuFAAv3C
	L81Cn+E7
X-Received: by 2002:a05:622a:250c:b0:516:d25f:f038 with SMTP id
 d75a77b69052e-51a6e9b48c8mr8613301cf.10.1782377254458; Thu, 25 Jun 2026
 01:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-40-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-40-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 25 Jun 2026 09:46:57 +0100
X-Gm-Features: AVVi8CfgbrnQMIfXiVsNJJJ0xVsuAP4drBRXl96LSWEK0lsp_b9ZqLBB6cNHuVM
Message-ID: <CA+EHjTxw-28BpsSbPTyuhBEMSzzJa=AWMtrT6Bw=3P+SfBKvLA@mail.gmail.com>
Subject: Re: [PATCH v8 40/46] KVM: selftests: Reset shared memory after hole-punching
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
> private_mem_conversions_test used to reset the shared memory that was used
> for the test to an initial pattern at the end of each test iteration. Then,
> it would punch out the pages, which would zero memory.
>
> Without in-place conversion, the resetting would write shared memory, and
> hole-punching will zero private memory, hence resetting the test to the
> state at the beginning of the for loop.
>
> With in-place conversion, resetting writes memory as shared, and
> hole-punching zeroes the same physical memory, hence undoing the reset
> done before the hole punch.
>
> Move the resetting after the hole-punching, and reset the entire
> PER_CPU_DATA_SIZE instead of just the tested range.
>
> With in-place conversion, this zeroes and then resets the same physical
> memory. Without in-place conversion, the private memory is zeroed, and the
> shared memory is reset to init_p.
>
> This is sufficient since at each test stage, the memory is assumed to start
> as shared, and private memory is always assumed to start zeroed. Conversion
> zeroes memory, so the future test stages will work as expected.
>
> Fixes: 43f623f350ce1 ("KVM: selftests: Add x86-only selftest for private memory conversions")
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  tools/testing/selftests/kvm/x86/private_mem_conversions_test.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
> index 861baff201e78..289ad10063fca 100644
> --- a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
> +++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
> @@ -202,15 +202,18 @@ static void guest_test_explicit_conversion(u64 base_gpa, bool do_fallocate)
>                 guest_sync_shared(gpa, size, p3, p4);
>                 memcmp_g(gpa, p4, size);
>
> -               /* Reset the shared memory back to the initial pattern. */
> -               memset((void *)gpa, init_p, size);
> -
>                 /*
>                  * Free (via PUNCH_HOLE) *all* private memory so that the next
>                  * iteration starts from a clean slate, e.g. with respect to
>                  * whether or not there are pages/folios in guest_mem.
>                  */
>                 guest_map_shared(base_gpa, PER_CPU_DATA_SIZE, true);
> +
> +               /*
> +                * Hole-punching above zeroed private memory. Reset shared
> +                * memory in preparation for the next GUEST_STAGE.
> +                */
> +               memset((void *)base_gpa, init_p, PER_CPU_DATA_SIZE);
>         }
>  }
>
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
