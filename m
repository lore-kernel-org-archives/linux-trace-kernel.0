Received: from mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263B5351C11
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 08:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251991; cv=none; b=m9MdMmUK6RmSoQyKMgnZUE8vaNkHaX3+iDhEl8bIblNNBzLiCcbhv8reXZT2IM/CYDVgkAwyULirwES99znuq1Tl1PBWXjVgA4zB6sKpZDKdVBGmvIkPrgxoi9XCB0/TyZwXIT29Y6j5UbYTSAebtoM8ddiE9hE5ZsL6RePpcn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251991; c=relaxed/simple;
	bh=MFd6QQcIiVNo4d+5OnfkjHu0LYEIxCoAHDswhin9sq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVlPGsvo8YIL23pZuvaFE3xQCDoc1PmtYMb8R/kzUkW98GysjORSGgPTUXz/ZOYusr/yYU56NXAsyU4aMEhg+CzJkB5KBkccNQA4Kxramtb1lU8YJvufMtu4gy+DwhvB0jyx5bLV6BikVFAEB6YxxMI9YQGSY0QxB0iL/K8slUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mINlTCzk; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mINlTCzk"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MFd6QQcIiVNo4d+5OnfkjHu0LYEIxCoAHDswhin9sq8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788251987; v=1; x=1788856787;
 b=mINlTCzkzRJE09TeorJ64wWbNWvqxkLNNDvyUWUPBtC+x/LkmeHqHdExRzLIRphopLpjnDlo
 QhffBAche/rfJ9yyBqCsIeysSVAgsa/Pixwdg7p+wBY2ee7ouEhwV3ch+t8KKkcOoi2cTck71D3
 3tpg0pQFgHmx6InF1T5SIfv0=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a22d40f24c5f44fb;
	Tue, 01 Sep 2026 08:39:47 +0000
X-Mizu-Trace-ID: a22d40f24c5f44fb
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b5e5aaf7deso5939e87.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 01:39:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwJdsJsx9HQQQqpHB3lqJfeAb92ps0d/GCA2hoYNysmzPOto9iarzDojjKFlLxiwUiCn3gswuFdC7ugAlxEJDHnG10=@vger.kernel.org
X-Gm-Message-State: AFuF++kJlD32emJ9kU25wM0kxGTj/4zRXw7wm3cVrHaGSR4msvLQMz/g
	bdKCTgvVSoxouRqpvZnsd+Kjb3f2EqWjyZye3JHY0PGZzwwcjua26UfvFx8Ad8MTCzWBSTy+USb
	DZ4KufIVSC5EES6yXRotVclSLUyDXlcVABad16wuO
X-Received: by 2002:ac2:5689:0:b0:5b4:4c8a:abef with SMTP id
 2adb3069b0e04-5b5ff29d7ccmr116639e87.10.1788251981891; Tue, 01 Sep 2026
 01:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830-gmem-inplace-conversion-v12-0-85e5fd25252a@google.com> <20260830-gmem-inplace-conversion-v12-1-85e5fd25252a@google.com>
In-Reply-To: <20260830-gmem-inplace-conversion-v12-1-85e5fd25252a@google.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 1 Sep 2026 09:39:05 +0100
X-Gmail-Original-Message-ID: <CA+EHjTytLWsa9-boURuumSFC8yNWDwvz_+WNN-aEz_cA9OkcdA@mail.gmail.com>
X-Gm-Features: AcwNN1XCAyPPlQdujvTs-aL1UBkQHfHgNLA1ozg5F-aaAoV8bE_sbTlT0O7ALBU
Message-ID: <CA+EHjTytLWsa9-boURuumSFC8yNWDwvz_+WNN-aEz_cA9OkcdA@mail.gmail.com>
Subject: Re: [PATCH v12 01/45] KVM: guest_memfd: Optimize away conversion
 overheads via dead-code elimination
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Randy Dunlap <rdunlap@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Aug 2026 at 01:25, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Sean Christopherson <seanjc@google.com>
>
> Add and use kvm_arch_has_gmem_convert() to guard guest_memfd's invocation
> of arch hooks related to converting memory between private and shared, as
> only one half of the x86 CoCo duo needs the runtime hooks (any pre-work is
> pure overhead for TDX).  At this exact moment, the overhead is negligible,
> but that will change when in-place conversion comes along, at which point
> to-shared conversions will "need" to find all affected folios prior to
> calling into arch code.  In quotes because very technically that work could
> be pushed to arch code, but that would bleed guest_memfd details into arch
> code and would be far worse than adding yet another kvm_arch_has... hook.
>
> Opportunistically provide the kvm_arch_gmem_make_private() declaration, and
> rely on dead-code elimination to eliminate the call to non-existent code
> when CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT=n.
>
> Reported-by: Binbin Wu <binbin.wu@linux.intel.com>
> Closes: https://lore.kernel.org/all/1ec08cd8-3072-4753-ad5e-cd34956647f8@linux.intel.com
> Suggested-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad

> ---
>  arch/x86/include/asm/kvm_host.h | 3 +++
>  include/linux/kvm_host.h        | 3 ++-
>  virt/kvm/guest_memfd.c          | 5 ++---
>  3 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 683bb8bf43a94..6beddd8a0c749 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1854,6 +1854,9 @@ enum kvm_intr_type {
>  #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
>  #define kvm_arch_has_private_mem(kvm) ((kvm)->arch.has_private_mem)
>  #endif
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> +#define kvm_arch_has_gmem_convert() (!!kvm_x86_ops.gmem_make_private)
> +#endif
>
>  #define kvm_arch_has_readonly_mem(kvm) (!(kvm)->arch.has_protected_state)
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 502465119ca0c..b7516e19ef419 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2597,9 +2597,10 @@ static inline int kvm_gmem_get_pfn(struct kvm *kvm,
>  }
>  #endif /* CONFIG_KVM_GUEST_MEMFD */
>
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
>  int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
>                                kvm_pfn_t nr_pages);
> +#ifndef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> +#define kvm_arch_has_gmem_convert() false
>  #endif
>
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 798d91df69537..2190e4d6b6bea 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -772,11 +772,10 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>                 folio_mark_uptodate(folio);
>         }
>
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> -       if (kvm_gmem_is_private_mem(file_inode(file), index))
> +       if (kvm_arch_has_gmem_convert() &&
> +           kvm_gmem_is_private_mem(file_inode(file), index))
>                 r = kvm_arch_gmem_make_private(kvm, gfn, *pfn,
>                                                (kvm_pfn_t)1 << *max_order);
> -#endif
>
>         folio_unlock(folio);
>         folio_put(folio);
>
> --
> 2.55.0.897.gb25b4bd76c-goog
>
>
