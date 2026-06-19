Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA2F375AC3
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Jun 2026 10:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781866329; cv=pass; b=dZiijY8TyYPcQyih8ZoZHhdX1XGo3SzIChp3VLLWrSWUy1abK7YIisPPa5Q9XCeoea6yYcczp93cOCaDEuN2D/3fWi6R2fTdDql6d9unJ8r5brfYPiHZg0+Nma2OhYFVakMKoS/Psya1TWNi1cHiLqMUnkDi4utcDQPt6lP/iaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781866329; c=relaxed/simple;
	bh=FV+HhQxDLV3ClDVmAYwBBibFkDhfDGLaaVmYDJKEf4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4CWOBisyXfLqQf86KvTemYuPi/DFHKw5aYq+mGjEQrOlAEOs1NHfEXG9JK30a6euYhhqRpOOQ0EDqbkoXhWmv5+55mS3LdXEbt45NbeClZgqRfPkYut9xBuLGym65I2oYL1h82VfkQ6SSDyLj66pE4GU3A+PNxGeC7ctDJEL3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XxrQU6b7; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XxrQU6b7"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51765531803so233331cf.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Jun 2026 03:52:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781866328; cv=none;
        d=google.com; s=arc-20260327;
        b=P8w1yZqgcIv4qlvW2ccZ3A9FsTQwp4UoQk9wNGjcAMXVrTJIWJbEvTnLB1zjf1DkRr
         YOkdrrxd4eiG52brCGPj+P/Pykny4v9top70R9MKLIS9cPwtTKcOv9zwHiss/QUTQfA7
         t21FBMW6Ex8EHGP3PHgLh3uMYzzotMcHY0Cb3bY6tk7yu4EfF5fKSHb2qfzLXT6JTg07
         R0H/ns/4NRjTwzycVZgnX3fUrsZ/bDpLIeo0TA2NNKcN5tDkCwvXaqBwO3xnwVXqw78e
         sz1Rgs/+YDnbC0kydYHoVmHYKL+ethb3Nw9sFPBLxoXvlcw8rUK3Vd5D6AGi0NDOZbyt
         o+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qqrLJidqwZhWczfBA7HD/HFgW4vaG9cXUmJMg4P1TGM=;
        fh=CJ/VRTq0MolWzO36aON5y+sSmV+8ZB6ZX28fBm1aNw4=;
        b=B2G8XAwMy1uBm2C04zDCoZwwjCUCkIK8+h2doPg3JPk7hZlR/VEMlYXDtVGu2emciN
         2wVosOpEVr1s5vuf8lkrNvj0w831RE481+hPQfWbgV/mzEepto57s6P2wruA+78lIfEO
         hYnDYMilHfiaLX6oIeswWvxnAfKGVfR3cPzgVz51gGCj58sVOtGIjSBjk8ACwghbvQ5Y
         x3xRj78hrJVdjJbNCBKkS41IbgMjM0z7Y1GgKa4F+NvVzAY0qvXzQ+HJtYTLiyy+wJkE
         NU5jXDI5s+sN2LYNfdbblhVGEVbdG4oYHF4w59hdckUzkVQduA62nUFBm2uVhC8qX2QF
         5LOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781866328; x=1782471128; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qqrLJidqwZhWczfBA7HD/HFgW4vaG9cXUmJMg4P1TGM=;
        b=XxrQU6b7wwBSKKs8iV2lXnI+K1kmrUZPHm9Uusk12q3/cPL9QeXSfhDwfvnS9F1XQQ
         42BUxJ2S2rJR46489jxLV7/VywSARvYgAGKfd+D80jzxnLb8h87coJgV6L4OviiqfNq0
         2ZZIifXHxW3Z32MC2UJbYjO/Ea6NOMaK3NFhCdhDcspnFSo5KJRoRsAGivWp/UfyEUuG
         agPc4ait1pdKaqUQtt8a4rJhYLFRooIs90dHrQ2NemMT5lF+LlBUfpyWEPTIgWpn9mqt
         yJ5ArL467Trnampd6fpat2YOOAl16Kdn95it2E+DhgqXJeT1Pojj9Ro4PERav8rYyCBU
         ZAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781866328; x=1782471128;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qqrLJidqwZhWczfBA7HD/HFgW4vaG9cXUmJMg4P1TGM=;
        b=iNr82on+MNYKK8+nFn6O606l9TdBM3zP4Wd57SdgcLmbZivAE4mTAb3zIlu8ocINYh
         FefFfhN1a9ZDb52Qpj3T8mRIJwPfJobe3fzkInghfz4iqZ+JpZQx27fD891Z73vfXogy
         8QgUhm+bYj3m+GaElkaVYYObQetEE1oHQYAJGAoHRdLMmOyOK1bZTGq8ZR/6ReonS5hU
         gEJAJkfP+hjGDDd47bN1KzvqvuxPdGyvrwqCBKU/0wa8E6NmccJr0iE+xQY/nFDVBm1T
         Ik9GitrfK1lq+UfNa5eQGXZ1MCAx+YxVc78dRQLtWcowAoJ454mP0R865WGe4yCbkk8/
         nDHw==
X-Forwarded-Encrypted: i=1; AFNElJ8KHhbYHvGvg/PP1vtp+bCBL3p4IdpSAMjXKUaHX/KAteJJs1PAX8CXQemU/t+Djaolp/dI0d8seViWVhdQ4cDmJlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2S3OG4kg0ted5oMyF2bySPAwh+I+s0QgyOJYsnsdeCLsl3YbK
	o30ucgZICFPF8mfC1Q+XZ7ojwX6fH7avLSdIGwJXWSGE/jP2l+6sD9XuOj4zbF67Bbo2B5SAvZ9
	UP2ypW2CqMpT48t0mIhtyOD3PxMQu+l7+31DHVzsG
X-Gm-Gg: AfdE7cnSmTmTbrFw4VhUaxZtmWFaak0M593hVfQq4r+T8AnKqiN0pDyV8LVIg3eD3Yc
	awl11AH/kzbGebceFMBBMeg5vkG2Rvz0oerMCwg3FgpHh3pRlssK0ps0FbnnrIfGqlzmUkBXghr
	p9tVCWC1K49sAdi9BmSDy4cfyEY75Sv+TTyTeKzfFcP9eir07K5QzTpyiKlI0Rd+LtQlpQx+FZd
	6EVkPSm7uuviTWpiPH4NmEaw3i3DNkpcrC40utSbkcVAlTRj2k4HK8x+NxDwJrkJLRAhdDBsg==
X-Received: by 2002:ac8:5e0d:0:b0:50f:be7b:923a with SMTP id
 d75a77b69052e-519e890f9bfmr5827961cf.9.1781866326641; Fri, 19 Jun 2026
 03:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-21-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-21-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 19 Jun 2026 11:51:29 +0100
X-Gm-Features: AVVi8Cf7maLTmO8Ms_Jrooo0n7Lq-o--etDJs7TRVCXqEuhsxAt-xpYkzSdEOcg
Message-ID: <CA+EHjTxOYWNeZ=2Atxn0iGQTOskR+Y3uiujWEOOfGLGcWadoUw@mail.gmail.com>
Subject: Re: [PATCH v8 21/46] KVM: guest_memfd: Zero page while getting pfn
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
> Move the folio initialization logic from kvm_gmem_get_pfn() into
> __kvm_gmem_get_pfn() to also zero pages if the page is to be used in
> kvm_gmem_populate().
>
> With in-place conversion, the existing data in a guest_memfd page can be
> populated into guest memory through platform-specific ioctls.
>
> Without first zeroing the page obtained using __kvm_gmem_get_pfn(), it
> might contain uninitialized host memory, which would leak to the guest if
> the populate completes.
>
> guest_memfd pages are zeroed at most once in the page's entire lifetime
> with guest_memfd, and that is tracked using the uptodate flag.
>
> Zeroing the page in __kvm_gmem_get_pfn() is chosen over zeroing in
> kvm_gmem_get_folio() since other flows, such as a future write() syscall,
> can get a page, write to the page and then set page uptodate without
> zeroing.
>
> This aligns with the concept of zeroing before first use - the other place
> where zeroing happens is in kvm_gmem_fault_user_mapping().
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad
> ---
>  virt/kvm/guest_memfd.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 90bc1a26512b6..86c9f5b0863cb 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -1137,6 +1137,11 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
>                 return ERR_PTR(-EHWPOISON);
>         }
>
> +       if (!folio_test_uptodate(folio)) {
> +               clear_highpage(folio_page(folio, 0));
> +               folio_mark_uptodate(folio);
> +       }
> +
>         *pfn = folio_file_pfn(folio, index);
>         if (max_order)
>                 *max_order = 0;
> @@ -1166,11 +1171,6 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>                 goto out;
>         }
>
> -       if (!folio_test_uptodate(folio)) {
> -               clear_highpage(folio_page(folio, 0));
> -               folio_mark_uptodate(folio);
> -       }
> -
>         if (kvm_gmem_is_private_mem(inode, index))
>                 r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
>
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
