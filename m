Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDE43EA977
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287343; cv=pass; b=jF30dXFmgA/sZ6z+V0Z7UI1YrhnP46WchoLdzBMlI1op1brWWYQmRz72V+VhU6KI6cvACoOsjA86P/e6G8/Qxqul+7d+7EYp7A6VHD7zEsQv8QYz4fq9VucTigVXnl8Oxw86vohyzMWsYoZPL/zDZLJslYMx3293JjjtDju4+2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287343; c=relaxed/simple;
	bh=Tzu5wTH3o6S2Itis2xyipHfLS/Tdxrt1OgQQN3z2k/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lj4w8znWM0WcOnfKg+4Kad+SCFf+EH24s3A75+N2iAzy1mgN1dYx/juOxYpiyI3mzCwyJYcctivHwB4i6C1euHcLfbRV4EEhDJrC44CmaWvLLBuE5nKH61hO6Tb++7nPOGwUEu/MkDknkPtBwuDC6v67jPplKdRWDw5H6J2dj98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t1fw0aXM; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t1fw0aXM"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-515548f390fso5261cf.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 07:28:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779287338; cv=none;
        d=google.com; s=arc-20240605;
        b=Y6Btozz0yDXf0t8m4FPSi2QT8eORynkth5UliR5jI0NtX2ltX/+NElxLyr4Q9WVrLT
         DRaGvrNBT2kNLqTfYrLFBitbX0VrODc35lwfYmYftQKpNhMX2GB4/rSTR4SeC8uZbz7I
         EaA95OdH5MU3r9j4HsCaE6JSUqrDgVF0lvQtoNW/f/nJsIQCOqYbVzcMaULQLeBG67l7
         u+zQj1xLLbKwAg08jK7e61g9Wf3PXjKT4sbgJDrj0FcUBtPcg9ZGqvL6OKlvbvouMudt
         Ull4q+y5vALLrIF5uf/c+fT/z6kIpzsOzi9u5n9IZh615y3DqPxafgg8+E+REIloKM3g
         cTUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SDMj41/pkYi0SiyY6zKgWY/JIbItQ876cBH7lhvdwcU=;
        fh=Bg99xi2gISPq4IPNJTUTchseIUpRKfMhEaownPFNNmY=;
        b=iUfHwIL9J5ymA+n66HqlyQAZ9bT6ett0IpHwe6KB1wFETeShLffcOq5eZo+OtjsnYJ
         3mzudOYBYNhqon1aUHzs3f1DME+P8IN9IbQ7nUIPmeJPwA4f+pQ3lzeYRNbP/HeuoJ0F
         2uI0HeXY+MqkixPRJ76bMsKvPTcU4meHD7jboCU+ML5VACd709qNw90nBgx/H7PcFNMz
         /PbTfOktl7eyt1Ptu2e/351869G6d2FWujCWnRP/SxRn8NV/lYGDXO/v+jq849m21WnI
         198K/gojGeRDUzKlDR1tNm/wZZvx8pkeoM0sVXmhnLc1B5UC1RVLZiHGrLntuZyhRhIz
         yQig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779287338; x=1779892138; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SDMj41/pkYi0SiyY6zKgWY/JIbItQ876cBH7lhvdwcU=;
        b=t1fw0aXM1Ap9k7oaEbUnWmIrrxYO3exbwApRFGwEWwV9gzSMxIndWDA9ACaPyiRPXX
         xlrQvYtIEyoXspvBPOAi6CfY59OYA1D3ydIDB26dGdoKc0xRPZGfRt/UC/3I+0CWG3hM
         eyFKYUlU7/poD35+u/7HIz+aU2Y/nC5dgZcL6xkGx31f72xwtNCDdMUyvf1XWAhKRno/
         tBCNRgO7JPbHQeCUkfx9OVl0Kz4bTThlhp9xh0hP0RMfE7UvJIp6liSLF9HLhqemqZYJ
         EblvFF4DZlbDe3TuBvLSCC4gWgdcaK6iEeMPtD871mgd8O6KlD7BsKDvHSHaixJG43N6
         upjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779287338; x=1779892138;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDMj41/pkYi0SiyY6zKgWY/JIbItQ876cBH7lhvdwcU=;
        b=KsTuAww6f8sFheucFJDOMd/e9Sct12jrFOWSMEFanuNRFeUVz9jKrsMBpmf4Sv+7/W
         Q/Hm/qJE15lA7K5cZY5g1OzAaa+Wo69MOPl7lVuQf25O+jlBijyF6keQutiKmIAu5Ywo
         I7cyCoSZ9IJt8/zJGMnfWqXbHp6uwa+jYBFboW99y4wzIV0gcZu3xxy0vkacSmSuBpQR
         wKG47aUyCSQA4gH3xXv9Gwkw7hSirVYkIhdxcixEoWMatHg6d0dZOFnV34LDm7SDI9Ir
         98E3yRTfxn3WQKx0te1WES0PadXhWM3B+HJaTHyX4n7q2tHshWxdBYDtvBG2rygOJVSV
         LuWg==
X-Forwarded-Encrypted: i=1; AFNElJ9AuzKF8tHsg9Gno/OCoeLNu+r4w7L74kkkp51Qg9HXMZXvzmD7aBYc4kQAIOTclpGTq73r9mFbSefdyGG17UpJTWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+nG1qIwWYHxkeRSJFymaFEdRQLu2vfI3SpET2hL7/y/zE0TCK
	1DYifDi8itsJl839oFVPBYQ/4ehQ4n7lv51SGs+iTsTTAeww+qmCpgFal6A/lQBRCIBKGjAQ0Np
	YGe86yBPIqR2HQjMTpUSnic5zwXsbf5apzUDFpyM0
X-Gm-Gg: Acq92OEy86STq7Lv2pzexm4viGa7CDeIr5Fppj3xU0P7ILzGPl+Gfi+ulDl5aYgrqrF
	mOMDQSvtM2x+MaRO8XFNK+tN3HKY0KikJ6ZP2OkKu32nyNne+DwG4Lj4AsNZSq4ABzC/cOhlhzL
	q9n8DultXp1pEKkmtj1oj7yZIcOEQ+uDaXdu+MH3V664tRtfhHZi57d5hO5DwxXTnkuPKOXK4hh
	ZhmY+tXhrgtBpPWeeThtMeypjnLtC0R5ijADN46yjSxWMsD4j2QTygUqUpm7lsal4HDSdGfVAjV
	ummrrB6nsHdfRJOs2h0=
X-Received: by 2002:a05:622a:1802:b0:501:4eae:dbfc with SMTP id
 d75a77b69052e-5167b676239mr20862401cf.5.1779287337177; Wed, 20 May 2026
 07:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-11-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-11-91ab5a8b19a4@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 20 May 2026 15:28:19 +0100
X-Gm-Features: AVHnY4L9O3OTsfOAqqdov--6MJhNDxaLQ7PquyLIvNtXq2pe4PNa20rghwvuehE
Message-ID: <CA+EHjTyyah4B6RZRhp=awJ7psp-wSwSSFGyDQF0wt+J9J7aDdQ@mail.gmail.com>
Subject: Re: [PATCH v6 11/43] KVM: guest_memfd: Ensure pages are not in use
 before conversion
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
> When converting memory to private in guest_memfd, it is necessary to ensure
> that the pages are not currently being accessed by any other part of the
> kernel or userspace to avoid any current user writing to guest private
> memory.
>
> guest_memfd checks for unexpected refcounts to determine whether a page is
> still in use. The only expected refcounts after unmapping the range
> requested for conversion are those that are held by guest_memfd itself.
>
> Update the kvm_memory_attributes2 structure to include an error_offset
> field. This allows KVM to report the exact offset where a conversion
> failed to userspace. If the safety check fails, return -EAGAIN and copy
> the error_offset back to userspace so that it can potentially retry the
> operation or handle the failure gracefully.
>
> Suggested-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Vishal Annapurve <vannapurve@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad
> ---
>  include/uapi/linux/kvm.h |  3 ++-
>  virt/kvm/guest_memfd.c   | 65 ++++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 62 insertions(+), 6 deletions(-)
>
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index e6bbf68a83813..0b55258573d3d 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1658,7 +1658,8 @@ struct kvm_memory_attributes2 {
>         __u64 size;
>         __u64 attributes;
>         __u64 flags;
> -       __u64 reserved[12];
> +       __u64 error_offset;
> +       __u64 reserved[11];
>  };
>
>  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 91e89b188f583..9d82642a025e9 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -572,9 +572,42 @@ static int kvm_gmem_mas_preallocate(struct ma_state *mas, u64 attributes,
>         return mas_preallocate(mas, xa_mk_value(attributes), GFP_KERNEL);
>  }
>
> +static bool kvm_gmem_is_safe_for_conversion(struct inode *inode, pgoff_t start,
> +                                           size_t nr_pages, pgoff_t *err_index)
> +{
> +       struct address_space *mapping = inode->i_mapping;
> +       const int filemap_get_folios_refcount = 1;
> +       pgoff_t last = start + nr_pages - 1;
> +       struct folio_batch fbatch;
> +       bool safe = true;
> +       int i;
> +
> +       folio_batch_init(&fbatch);
> +       while (safe && filemap_get_folios(mapping, &start, last, &fbatch)) {
> +
> +               for (i = 0; i < folio_batch_count(&fbatch); ++i) {
> +                       struct folio *folio = fbatch.folios[i];
> +
> +                       if (folio_ref_count(folio) !=
> +                           folio_nr_pages(folio) + filemap_get_folios_refcount) {
> +                               safe = false;
> +                               *err_index = folio->index;
> +                               break;
> +                       }
> +               }
> +
> +               folio_batch_release(&fbatch);
> +               cond_resched();
> +       }
> +
> +       return safe;
> +}
> +
>  static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
> -                                    size_t nr_pages, uint64_t attrs)
> +                                    size_t nr_pages, uint64_t attrs,
> +                                    pgoff_t *err_index)
>  {
> +       bool to_private = attrs & KVM_MEMORY_ATTRIBUTE_PRIVATE;
>         struct address_space *mapping = inode->i_mapping;
>         struct gmem_inode *gi = GMEM_I(inode);
>         pgoff_t end = start + nr_pages;
> @@ -588,8 +621,21 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
>
>         mas_init(&mas, mt, start);
>         r = kvm_gmem_mas_preallocate(&mas, attrs, start, nr_pages);
> -       if (r)
> +       if (r) {
> +               *err_index = start;
>                 goto out;
> +       }
> +
> +       if (to_private) {
> +               unmap_mapping_pages(mapping, start, nr_pages, false);
> +
> +               if (!kvm_gmem_is_safe_for_conversion(inode, start, nr_pages,
> +                                                    err_index)) {
> +                       mas_destroy(&mas);
> +                       r = -EAGAIN;
> +                       goto out;
> +               }
> +       }
>
>         /*
>          * From this point on guest_memfd has performed necessary
> @@ -609,9 +655,10 @@ static long kvm_gmem_set_attributes(struct file *file, void __user *argp)
>         struct gmem_file *f = file->private_data;
>         struct inode *inode = file_inode(file);
>         struct kvm_memory_attributes2 attrs;
> +       pgoff_t err_index;
>         size_t nr_pages;
>         pgoff_t index;
> -       int i;
> +       int i, r;
>
>         if (copy_from_user(&attrs, argp, sizeof(attrs)))
>                 return -EFAULT;
> @@ -635,8 +682,16 @@ static long kvm_gmem_set_attributes(struct file *file, void __user *argp)
>
>         nr_pages = attrs.size >> PAGE_SHIFT;
>         index = attrs.offset >> PAGE_SHIFT;
> -       return __kvm_gmem_set_attributes(inode, index, nr_pages,
> -                                        attrs.attributes);
> +       r = __kvm_gmem_set_attributes(inode, index, nr_pages, attrs.attributes,
> +                                     &err_index);
> +       if (r) {
> +               attrs.error_offset = ((uint64_t)err_index) << PAGE_SHIFT;
> +
> +               if (copy_to_user(argp, &attrs, sizeof(attrs)))
> +                       return -EFAULT;
> +       }
> +
> +       return r;
>  }
>
>  static long kvm_gmem_ioctl(struct file *file, unsigned int ioctl,
>
> --
> 2.54.0.563.g4f69b47b94-goog
>
>
