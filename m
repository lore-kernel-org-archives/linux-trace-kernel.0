Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77508397B1C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 07:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350267; cv=pass; b=hkMvcGFV2IzMOy4TbynNmYQdkeQhiWYB6zTSMS37SDn/ZcbvWWdjgwCQNyYBWCYMhaGQfB07pP9xgWXkZReelfHkUa+auqFwBVqUZhPEtejAafrj4n0jVSBIJtm4tiE/eOrS5gTmtM2M2z/AAPvxrBnh9EI8Wpa1Y9ZRWN89jWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350267; c=relaxed/simple;
	bh=4KcT8rdA6d07iJNq3wBXNazPyISKqsHOcKPYno1GuIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MO4R9XnUze6JtgeT7RSAOp3zLJ0aAoFKls3cnncW7rv+cUa2q/ZBqf5jAAg72KLYhoB4UVvjQt2bpstzXJDom1x5opZQS/fDjdccEIv7+ttV0EUd86pLlfGyTdAYSuqCm+kVq+pChd9adEMgQ3DXu6o40pCPV2YIuLZ2g3WS8+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PkK3X4dc; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PkK3X4dc"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50d864c23bdso5401cf.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 00:57:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779350261; cv=none;
        d=google.com; s=arc-20240605;
        b=Lx/S/drYrEBxeC9eM0gUrSFdW8p69Quqn6lbZRxbhP1LH+AJUwjry4Et6pvYfa4RbM
         +z8N8Z5UV9Z0dbq+sBd2Rzd5UeWRzMLE3GbEyljzX2pEQURfTyPs1diBjBshdbzRyGLj
         3ruEj+HjpWcqCe+J9D6sayZQ1bwKRtOvtpWAha2BZBBY8j2jtmOSP/QwuNuWSmbkhTII
         VmzZ9HZ43dSX5pszrmUAU/Y8A2eA/GkGfIZ/R/DSP95tXLjUbxPeUkf1cYIxepdyvjgZ
         IrgdTf+oyoU6RZNOLgeci475MMiJQZZZCigfQSW8kQSQ3uYHqKjk7gSYy/CnOuy4PwLj
         /XbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tSn2g3kUTBO9UyvrMevDMplllFpiZxqy7FxTUXL/Xlw=;
        fh=n7Ffii7HqDepWT0SLResIdRg73lOwBfAmEwfXt7ZXdQ=;
        b=GxADYmxVuhGDuSkMYJgZUTzdRZll0qA1rt01UW5MPHqbTbfjkiQ/YVbY1+qxiHcQTK
         iVJjJVe3MGIhzRFIH2NHHd5SnE7hp0EcGueHjSAiRU970CPnDhk10q09I5MePioHcwV+
         bLIzA/GL8p6/LXKCp/ZNxwm6p45vOiVP0x5a5zAtgG2oGLd2yWtogLLyefj1tnLxg5KE
         AE78WLYq3LySOJPIFNkpy+6UGw3f5tSYr+wcaHQmfSTD3oCS0tgHgNJnRa/IFM/wsWE7
         aWp1Wd+c902s/xu35dXp8Ks88bBM1/xUQwDPHcUSuFCPWV6l0R+s+8b0w7oD2U4CgqrL
         aVxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779350261; x=1779955061; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tSn2g3kUTBO9UyvrMevDMplllFpiZxqy7FxTUXL/Xlw=;
        b=PkK3X4dcbhXxrjoJ1fcTfQCLtnoA6MwpGGLw/Nqy69HN+eFeKKnsX92ARB5CK7/YrG
         DXfmjOlnO6qjQFt8qZ5I85bxhc9gbSWZUx+RKVeYhiN+IIakoeunnIow5DYBRSJzH9fY
         EWEeu3gHxlH8+iQ3eU1Y16A1prp7cTfIfVAjjpEESLlYX02fqBvuN+Gi2EfEQPy+Liqx
         xrAI64RCYUX8ZKse/1yUNRQ1NCZHtjtkDWnZCN0ZXeR8MQwI3fKs/Jefh8hQfSmvQvwf
         QCZantvkGbwFbT4UqXcxyf3i05FWqvJezxEtDZ86TnXNGIPY5UR1qmgHsWC7T5pUHsGl
         PTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779350261; x=1779955061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSn2g3kUTBO9UyvrMevDMplllFpiZxqy7FxTUXL/Xlw=;
        b=lEa0+fJd/PDFT4PwGGJ640K3E7AYWFXkyy0a460fJt3L7+ayZwySpKiVbJhG7v0h8k
         IyGGRtBfsgfd4CV71GKU0q/gh4d3fXiGAGV2KpR/fwKpHiaw2DMNBM0KjqGbMkhoaF5O
         5yLo6nWhgNuXhUQhkuTTXIufOFz7hzHg/+Jm3+3PJXAcR69g1lGf6+UhPMmecAvMmgwe
         8usPK98Vi+PiR7zGtdB2xaoBVbn/iK9zD1DI9Txyn9mgzLFQekmWsTiSupE0KewAq2d1
         st6NZkAtzgupT+gTVRX/I+GLHPt5F9mbGJno1s/5A8RJwjcfF5NDbkM/U1oW0eg46ljg
         02Gw==
X-Forwarded-Encrypted: i=1; AFNElJ+3IW0AhbV1OeSPCCn3BGaSKuprTs15AzIOykH9E6c6LqBeDsRxtxQaw+vZeiyMYBo24p+4AbRw6wGDQw+vwR/QgQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznoi4P5nF+CrxlGd5i64nosCVSVrUHiieg0McWifL5ie+BxJ4U
	UnvCxYCM//CTfo+LRwNFV9fBErEdlY1+qdluCe5emqBBwS90zRy35Fp1D5Kuohea/RlDqb3Gs7V
	PpLQPo+UgoJwWhigaaIx4fr03Hnjp+Ht3NibqvF9K
X-Gm-Gg: Acq92OGSYd7xvnfFxP+xmfBvfH/XWx3PyHaWXQhpZh8qYtRA4q8e0pl6MlZP3cb0Smm
	BQJjfL9w6GxWVqMlGSlU74VghMlObm3dAJzC9q43xwaR65XbegBoECEZKZ0izN8F3wk+DUi63Vl
	prKTlkNpzrbJNu4rleatqL1lheB+SblTPmYSpq6zHSb5Hp4MniWcuxIteM825lw9m/xO7vEPWcz
	PhLT+j/zkRrmeigQjfOrYlThNLl/5taQmQx8gDB9bxQnwBoKLkZG+H4HP5Mvfi+U0bLshL3fS41
	mSX0Nvr0L046X0oY2HP3TwHUfF5h/A==
X-Received: by 2002:a05:622a:9005:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-516c53118ecmr5321871cf.1.1779350260836; Thu, 21 May 2026
 00:57:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-17-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-17-91ab5a8b19a4@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 21 May 2026 08:56:00 +0100
X-Gm-Features: AVHnY4ISxUZam6iBDjV_4hOaNzbNB8xZ_iFXhRAdE4nHy2L3vqI7KoUo1cTBaB4
Message-ID: <CA+EHjTyArkNd7cWC+OAkvkcPyM9=XUxzjg1fxFFV4GSP4wLALQ@mail.gmail.com>
Subject: Re: [PATCH v6 17/43] KVM: guest_memfd: Determine invalidation filter
 from memory attributes
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
> Before conversion, the range filter doesn't really matter:
>
> + For non-CoCo VMs that use guest_memfd, they have no mirrored tdp, so
>   KVM_DIRECT_ROOTS would have been invalidated anyway.
> + CoCo VMs could not use INIT_SHARED, and there's no conversion support, so
>   always using KVM_FILTER_PRIVATE would have worked.
>
> Now with conversion support, update kvm_gmem_get_invalidate_filter to
> inspect the memory attributes maple tree for a given range.
>
> Instead of determining the invalidation filter based on static inode
> flags, iterate through the attributes maple tree for the specific range
> being invalidated. This allows KVM to identify if the range contains
> private pages, shared pages, or both, and set the filter bits
> accordingly.
>
> Update kvm_gmem_invalidate_begin and kvm_gmem_release to pass the range
> parameters to the filter helper to ensure invalidation accurately
> targets the memory types present in the affected range.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad
> ---
>  virt/kvm/guest_memfd.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 9f6eebfb68f6b..c9f155c2dc5c5 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -193,12 +193,24 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>         return folio;
>  }
>
> -static enum kvm_gfn_range_filter kvm_gmem_get_invalidate_filter(struct inode *inode)
> +static enum kvm_gfn_range_filter kvm_gmem_get_invalidate_filter(
> +               struct inode *inode, pgoff_t start, pgoff_t end)
>  {
> -       if (GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED)
> -               return KVM_FILTER_SHARED;
> +       struct gmem_inode *gi = GMEM_I(inode);
> +       enum kvm_gfn_range_filter filter = 0;
> +       void *entry;
> +
> +       lockdep_assert(mt_lock_is_held(&gi->attributes));
> +
> +       mt_for_each(&gi->attributes, entry, start, end - 1) {
> +               filter |= (xa_to_value(entry) & KVM_MEMORY_ATTRIBUTE_PRIVATE) ?
> +                         KVM_FILTER_PRIVATE : KVM_FILTER_SHARED;
> +
> +               if (filter == (KVM_FILTER_PRIVATE | KVM_FILTER_SHARED))
> +                       break;
> +       }
>
> -       return KVM_FILTER_PRIVATE;
> +       return filter;
>  }
>
>  static void __kvm_gmem_invalidate_begin(struct gmem_file *f, pgoff_t start,
> @@ -244,7 +256,7 @@ static void kvm_gmem_invalidate_begin(struct inode *inode, pgoff_t start,
>         enum kvm_gfn_range_filter attr_filter;
>         struct gmem_file *f;
>
> -       attr_filter = kvm_gmem_get_invalidate_filter(inode);
> +       attr_filter = kvm_gmem_get_invalidate_filter(inode, start, end);
>
>         kvm_gmem_for_each_file(f, inode)
>                 __kvm_gmem_invalidate_begin(f, start, end, attr_filter);
> @@ -367,6 +379,7 @@ static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
>  static int kvm_gmem_release(struct inode *inode, struct file *file)
>  {
>         struct gmem_file *f = file->private_data;
> +       enum kvm_gfn_range_filter filter;
>         struct kvm_memory_slot *slot;
>         struct kvm *kvm = f->kvm;
>         unsigned long index;
> @@ -398,8 +411,8 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
>          * memory, as its lifetime is associated with the inode, not the file.
>          */
>         end = i_size_read(inode) >> PAGE_SHIFT;
> -       __kvm_gmem_invalidate_begin(f, 0, end,
> -                                   kvm_gmem_get_invalidate_filter(inode));
> +       filter = kvm_gmem_get_invalidate_filter(inode, 0, end);
> +       __kvm_gmem_invalidate_begin(f, 0, end, filter);
>         __kvm_gmem_invalidate_end(f, 0, end);
>
>         list_del(&f->entry);
>
> --
> 2.54.0.563.g4f69b47b94-goog
>
>
