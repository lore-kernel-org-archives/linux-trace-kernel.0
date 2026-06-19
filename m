Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1751B375AC4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Jun 2026 10:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781866009; cv=pass; b=YF3s8ckfpSf60Ytp4LUhEGvOcDzmM0hPbf7ZBvo8BntQeCD51tyd1SozYhuce5soG2eaWdj8j9yQCr0vq6yHFXcCPtaayGlOnvkj3gnpso9bAbMP1LIOkRci8bLM80sOA2q4fZhWR4GbNBiCzG1z0mWstnsqN/L0IALzuHR0pPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781866009; c=relaxed/simple;
	bh=GBE1TgSby7J232lUKGK26nn+IlCCdnbJXDX5316EbVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKlkoDPbOrbVPsjtobcY17yLOZKiapjxf28yiNITSJE86oqLMaQqICFNiZVHbQ6eO1x/a4wO/712CB2IQkV7xkd9Rh0vapmifb2q+BveSFM9p7csJih0fUspkWwvmBc3RR7DJk345TkgjzR/NWVTZKkTLvblgTn7BpcqeUFVQdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U75CQJbP; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U75CQJbP"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51765531803so231921cf.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Jun 2026 03:46:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781866005; cv=none;
        d=google.com; s=arc-20260327;
        b=eL+kI+mESIX5QHokcx2ZnnyFgXZ7xkHj6Vd275NXVugzxeHl2hCkNP05FxkM8fAD1b
         05tjyCJJJU2JAvj9eM8jqpJ8JEc9vpg88uyYHLLq5xdMlTxcTt8dqQfLfhGqjIQbKP6I
         ar+2q7GNFNg9qh0m36oGWbnleaJ7nIccOQJKdMeyQZKHpDDVLZEMgB7WDiyOgsxrHYkA
         pGYrY2fjGDVbm5fOG33w+29waMztC0E3xwThm9FP1X6R0toACFRyraQ9IZIF5jW+7FKa
         cM3m2/NHJaNBK744/Rzq80AyL3Dg4Wtx7/ZT2qq7yefOn8T48wPp3lFd3C1zpjUCAOKG
         7V/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tqVqdR7eGLFAsCQYmX5JI1ornwlzeYgCHzhYfEkLeRM=;
        fh=n9xqHJJlyqO03ePcsgf9Y4Tgbo69/3m+F5HCnZG+Y2c=;
        b=JL5FksNDNYpsrB4ytrtCoQd+JjT6qdMizsLTA/kar4hY+vMHruGKb3uLpyvHKpbmGh
         dvsenrB4eG+B14UArjWRER6HDRMLCNZ3HBJX6/pMnHIr2/uU698vJXG3LMK4tek3exSf
         qWRRJn8NaT/FRz+g3wxQBt5l5MlxTLrxl9NYR7gGog1YMUxGqfK/M4O7iHeaFuilDq7c
         yaAclJp5P8JAzfNhbUoeRXJJzFVkSZGkxdcRC7BNtiEbfG49LmUoWqRSgDars2UsdvhH
         V39b7dLQ8A3PJ9KUeJYvX4zY/PDdm+O3ifu4XWNg/nj/VvwxkLNmLhRlBw2yN/QMjHrx
         UhKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781866005; x=1782470805; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tqVqdR7eGLFAsCQYmX5JI1ornwlzeYgCHzhYfEkLeRM=;
        b=U75CQJbPcSNy7b3rqNQlOkqM3d9AAFeN+w9Y+3TxossyxgYPBaPMs5YymOB1n4gKgk
         fEjKdJv4RFKQtPh9n/tPH5u2C4dUPWhS8cieaRDcY9tSSgEuNkb03E9A2RLCFmqcA+kg
         Q2TvuYSvO41PrHwye+FSfBAENNXa4JUMv/GVmnCcN+r2gnmI+HXnldQVnpHtCJtcWnDN
         DXRz10L6pTc5gzwRTRJQ/yUvGtzmOFdn8T/Jsnbdo70Mu/AhB1wFr0G/NPHtXJkm8bWN
         Q9dF3ArHPxIlJy2gGqv6ryeGx+XhZ82IXM3bnz7n6pJylDpY6qQuzbseg7375z7kxqr0
         mk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781866005; x=1782470805;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tqVqdR7eGLFAsCQYmX5JI1ornwlzeYgCHzhYfEkLeRM=;
        b=lU+EIGEBo07VxDakz0BWkgT3V05CuvLpMzGxoX7So2VCBNoNBTdHV6lHU+IhCEG0qO
         jp5RLtu6o5BJpaZD7f9VKVPx0ouS2+lcBM6ZRI+BpPBboIS3xNBD9pYGIm93qEDjebxm
         hmCNLPsRnA8cZS0fctNdYBkzFaNjIETk3eqmdYwe9D7iSxvU4GY95jGqfR40x31ptd8D
         mjTXhaHdw3pIGw/Ra9OHSzj6LaaWuFdsswWZlVvNG5Is05Xpb4YqJNuFHPJdv+kNnf64
         ShELY2u3hqhpE8YTf7pNWglnW/vDyMLm7fxiy93nsDY9HQPW2J9BDFcevsTdpsvvKJtw
         rLWg==
X-Forwarded-Encrypted: i=1; AFNElJ/HS4zRk410i2EZb23dhjPwTaE7oOvxbQ5xiBUtUUguE9PHHmIOLJY/epUThB3itl3H8yGIvFr44fQlDM6RxG2E+lU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyMYpfS5fIWtUaK1OzXFGme7CAHHZkaQz6LZy9uGseuJcD+FSF
	nvhrGhPIduYKJco2ii9cBRRcRF/A0188hoVDxwZVWzTa42ubijd6Be08I9e0qiHuHuddQypmcD3
	oNAloB1F2LlLM1UynBLgdst/3TNnmD6sU3DXaqMKy
X-Gm-Gg: AfdE7ckjC3sfkHEOr8OSSIv2/KwELZbygqj9BdIASZ0zBVUzrbuAVHZCFipJ38q/nQN
	vNNvRAp6yOKStIpmDK5MIdxe5G7d/DqJlg8hMlWU4Ord8vzYhkTg1RO4QE4cDRR+6Ib3ojlhrzs
	c0Wjlw87waHmJu8f6umiGTqA2ufMfJ9BO7oPpnUXHvqA8XHGc3DHQoPQgsA63dO3AnlOLu7oSy+
	tYKDsnT7f5G4f9WfNTPi88piVwW7PhsRAHXRZbVP64AT1zqu+yXSo72iB+gnMuHpdfRccBDcA==
X-Received: by 2002:a05:622a:1b1d:b0:516:3def:1cf4 with SMTP id
 d75a77b69052e-519e877e8c5mr5598281cf.1.1781866004326; Fri, 19 Jun 2026
 03:46:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-19-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-19-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 19 Jun 2026 11:46:06 +0100
X-Gm-Features: AVVi8Ccyp37Iml659Lz9n-v90nTTG1Iev3H81NTyrRm5pUpcj70uW3l4zFQ5-a4
Message-ID: <CA+EHjTxr1KrtZDakniWCF+c0E6s9_YbQ_gMVqCFnwEP3USEXXw@mail.gmail.com>
Subject: Re: [PATCH v8 19/46] KVM: guest_memfd: Use actual size for
 invalidation in kvm_gmem_release()
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
> __kvm_gmem_invalidate_begin() and __kvm_gmem_invalidate_end() actually do
> not specially handle -1ul. -1ul is used as a huge number, which legal
> indices do not exceed, and hence the invalidation works as expected.
>
> Since a later patch is going to make use of the exact range, calculate the
> size of the guest_memfd inode and use it as the end range for invalidating
> SPTEs.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>  virt/kvm/guest_memfd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index d163559da0235..d72ecbfcc3144 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -366,6 +366,7 @@ static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
>
>  static int kvm_gmem_release(struct inode *inode, struct file *file)
>  {
> +       pgoff_t end = i_size_read(inode) >> PAGE_SHIFT;
>         struct gmem_file *f = file->private_data;
>         struct kvm_memory_slot *slot;
>         struct kvm *kvm = f->kvm;
> @@ -396,9 +397,9 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
>          * Zap all SPTEs pointed at by this file.  Do not free the backing
>          * memory, as its lifetime is associated with the inode, not the file.
>          */
> -       __kvm_gmem_invalidate_start(f, 0, -1ul,
> +       __kvm_gmem_invalidate_start(f, 0, end,
>                                     kvm_gmem_get_invalidate_filter(inode));
> -       __kvm_gmem_invalidate_end(f, 0, -1ul);
> +       __kvm_gmem_invalidate_end(f, 0, end);
>
>         list_del(&f->entry);
>
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
