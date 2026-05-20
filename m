Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF1E348477
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285142; cv=pass; b=OOLZTQ38HuvoSMe2EpYRndaCV0R1z0SbhBL67CjQiBIOhOaZPbisuy5PSvsoJ/bs71/MudZirZNTuD8QW8/Vn1p3i9K+l/yG8dSfDG4+NJODnHqUDZGZWWa6sKhpw2mSQjjz9jGqP867IkYh2M/OZ/2YJz/TIQOAEsdt+B8He0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285142; c=relaxed/simple;
	bh=w4JDDKhr2QiuCMCCR6/SASV1LBSfLF+z9c67ox8kPyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zxpnsqv5VJnST0G3EzAKWLC4FoWf91AkNWI/c9Cp8yz/z+sFvFWUKCg6ZR/l1LyaRQk/SCsA+hif9pb3zlaaFjEfizuvc1pqV/bFo9zlD1LcFRFtL31shOSn3VNkwRPTnrNswprOdVSxA/cGXipz7yer5gHk/XonuD72C0QLK5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a2Ft0HL0; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a2Ft0HL0"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-515548f390fso16121cf.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 06:52:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779285139; cv=none;
        d=google.com; s=arc-20240605;
        b=j/tf40CoUGJ8RxaooyEcuaykbl/TeKxLcolKK9R78yPvX3lCGda6wg6OndR3WDBY6+
         ls/xTUos3RZMJJRNdqIzGc0WGURaX5yoDqjI5N+ff3MKYrMfbQr9ukcj6eAYZwE2jmTP
         hdfrEbCmPj+z/QAHCOVt2mKfZq5qOmQBy3fhMJQea4g7FL72ckRS3n5J53YXKMY+/5n+
         sUCcxJrr09UC0ygSzAQi+MwsvkGx8sM7p4RhzcVHLfWaJHeR338MYxwfLOQgVveDGCE7
         dQSjhWMWDPWn8i4OtRO53FV79/0rvo/JR+wzIHgS7JpAp52CXEyAg4GwK+lzg0E8gIvi
         wQew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Worh2JLSPSAyI17eyly2xWvvXK0uXozd+nOzIiXznLs=;
        fh=jLXpAuWtPbXRcWHyUSZ4WHCxTOTaa9L0Bi6+NvgbrIE=;
        b=ednX0vV4r+z48+IQNaIWWCBUT3A6AHGrabMGlbLdsusmN92d/No0EUXI0eJnCS+1BV
         MTRB6giCJXCYicemiqpf6nyNg3EIbY2vUkfG36sNNJsybEiHdRg+GyGxYiUiSgS0i7y7
         V5BpsgfQVb4hQpGCvHsb711HECSpaU49pOIxNV6DfVKPmsPwSFsAhp9qJh68vxBHGPqi
         G9zf+As4BClc5kWGLRawHfvgPybwdHd9iE3aJyVkyVvZ8lwySKwoRO+uGUOVQOheadvz
         B8GHFQ/ZHO6Iw5cdiBfY8Y2RVqGph0x2K3qqVHr9bYEn05ai5AP6t489QwEoLF0P8yNy
         lFRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779285139; x=1779889939; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Worh2JLSPSAyI17eyly2xWvvXK0uXozd+nOzIiXznLs=;
        b=a2Ft0HL0pC1eYOIQcvNBz88Gn+nwwcWG9ItrsoXV1uF2+k/Luv4BHBWm4i03dfToZH
         ELiDekXwMn7OgysNbkSK6RY3V7sB957mkgn/NHuz8EHlyy73YRU8D1nDfmSY5FcCEqWO
         p/YQ4K0K+dvCgSnkfdWKMEOy3MIgNzzYdsFjNPVjL76skwQrX2OLJiXWsveFSpzqEzMS
         kw7xfDoXye9xPPX6pTND9oC0nNWanr+Pp7Y40gGF5SlSkUnGV44IIYmn8pJcmFINzN82
         0vzGqEF9G2Nmey4biWosRwDRfml8YLmeAhf5jjkL0VNIDZjk3cRwyzHZGysv8UdGeI7n
         EziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779285139; x=1779889939;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Worh2JLSPSAyI17eyly2xWvvXK0uXozd+nOzIiXznLs=;
        b=ltnbHhOJQsr2+9389Io/YMPY0GEaESMCtEHeQo8Yn2MQLjf01aP+eLc6yS9yF0xOWJ
         2PMcx04/8eLb4hqD4tgFJLCgunYK60iEdUNAyY4ttt4RUxHEC4mwUahUr1XBaiJ/bQm7
         T+UP9X3msRgyta6rRNRvljr38HUqBiK8usUxZYMJJZaspVCXX2aW6+JeY3sOOT4yDVkO
         +R1Z0gcn2BufaFCU2jvmftWfGsYVayXcRnEBFzmFuZRNAqiHJqjqgpcGpDVCPH+g5Ljv
         i7nczxc0Akmht/dd4HZ0Wyi5AqOhTacyjeFQDd+UVm77YKVWNZbYXOrUABSWr153twgq
         NZGw==
X-Forwarded-Encrypted: i=1; AFNElJ85hX9BfHJOOEJuQT0AA0nW6yS4MAfIf9/IwFjVIE0gQyacq0kO/z4ONLlTenbOfuOvA3jsovIZKYes9NdEkEmKBGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkQV0ACpD/vKZabNeSc/RCOK/1YX7b60S+ylJku3jdu8jmlfNe
	DCP5mnXzVpHfv1jipqzS/H3L/tX5+Iq16fEJgsNvOR9UfhrrkfzUm4PbcHbF/LLJCoLzbMTSeWF
	kZxDNLV5GbTEypT9pt6Rm/YMCJS3fET8qbsCG0sbl
X-Gm-Gg: Acq92OFGQyyxeqXDERXBkfr9/NhT5GCU9DYY/kHfloIooEWKhydaaUaMlTW1LKlwFVm
	qoCsLoHBKmatL2Hsw9MWueU5Ex7v9nVD0rfBt6KPPRMa+MUb+ns5pqRTKNUWy6gdO+Zj3YKe+ie
	VkEHo/XwgiFddXvdjNuPAd5AJozySXbzEYtgaTavkJGa3oBdX4oReZYvW5EM5JzGogKCP5uNc+a
	48YnpvAUPuN/fsCoKu9mQV1H/sAy/9odbfDgRRJkE6W0VUpOV3k+t3kSFE1F0m7fEE7gw1k1Btz
	3ENzJqfWd6cdPEb+I6I=
X-Received: by 2002:a05:622a:5d4:b0:516:4197:361 with SMTP id
 d75a77b69052e-5167937f111mr19778701cf.4.1779285137735; Wed, 20 May 2026
 06:52:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-8-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-8-91ab5a8b19a4@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 20 May 2026 14:51:41 +0100
X-Gm-Features: AVHnY4J85RRb6CNplqSCM30M3DMf1Y3bV7iG1C3rTvm3LWaftfTfmZz57_1_-Dw
Message-ID: <CA+EHjTx+WbsKB66_0_1a3=vBkEdoeqJG9QOfZcUTuT8MYc=TtA@mail.gmail.com>
Subject: Re: [PATCH v6 08/43] KVM: guest_memfd: Only prepare folios for
 private pages
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 May 2026 at 21:22, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Ackerley Tng <ackerleytng@google.com>
>
> All-shared guest_memfd used to be only supported for non-CoCo VMs where
> preparation doesn't apply. INIT_SHARED is about to be supported for
> non-CoCo VMs in a later patch in this series.
>
> In addition, KVM_SET_MEMORY_ATTRIBUTES2 is about to be supported in
> guest_memfd in a later patch in this series.
>
> This means that the kvm fault handler may now call kvm_gmem_get_pfn() on a
> shared folio for a CoCo VM where preparation applies.
>
> Add a check to make sure that preparation is only performed for private
> folios.
>
> Preparation will be undone on freeing (see kvm_gmem_free_folio()) and on
> conversion to shared.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad
> ---
>  virt/kvm/guest_memfd.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 9d025f518c025..4f7c4824c3a45 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -888,6 +888,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>                      int *max_order)
>  {
>         pgoff_t index = kvm_gmem_get_index(slot, gfn);
> +       struct inode *inode;
>         struct folio *folio;
>         int r = 0;
>
> @@ -895,7 +896,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>         if (!file)
>                 return -EFAULT;
>
> -       filemap_invalidate_lock_shared(file_inode(file)->i_mapping);
> +       inode = file_inode(file);
> +       filemap_invalidate_lock_shared(inode->i_mapping);
>
>         folio = __kvm_gmem_get_pfn(file, slot, index, pfn, max_order);
>         if (IS_ERR(folio)) {
> @@ -908,7 +910,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>                 folio_mark_uptodate(folio);
>         }
>
> -       r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
> +       if (kvm_gmem_is_private_mem(inode, index))
> +               r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
>
>         folio_unlock(folio);
>
> @@ -918,7 +921,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>                 folio_put(folio);
>
>  out:
> -       filemap_invalidate_unlock_shared(file_inode(file)->i_mapping);
> +       filemap_invalidate_unlock_shared(inode->i_mapping);
>         return r;
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
>
> --
> 2.54.0.563.g4f69b47b94-goog
>
>
