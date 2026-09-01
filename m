Received: from mta0.migadu.com (out-162.mta0.migadu.com [91.218.175.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770CA34E74B
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788258899; cv=none; b=symEdmhjG4hfomg9f/r2/ZgH/uvB8gsaecS731yMX41F2wKVq4YNo3oLTku0a1uqGgRBWdlhdT9wMBB+3qLOww9/whMW2xeOedO+2ylnE9sqt0D1vS6IZQdZQ2rZhxxFNxKz1I1wJbTF75497QbmAq03mX+R/ol2qfwoxro3vSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788258899; c=relaxed/simple;
	bh=hGwrqJibjsI979lLLZMh7q1FzrzRBk6jSe5g0u5F2Qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVLPDzn+B3vxMHzpSmsnJAr3uGFqoPji+rDI7voMDueMFf1aW4DhLvknYMJVhYsJ+Rexs29tRCaxQ96bMehcoK9lgiJdsPB1CcY05BM9bTl42mscJQZfzncETMoD5mUKRAkQA5/jMmU0hrhQQ5qNYcIiMQTWcoRuyq60j0cgesI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mq1f/7Vu; arc=none smtp.client-ip=91.218.175.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mq1f/7Vu"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hGwrqJibjsI979lLLZMh7q1FzrzRBk6jSe5g0u5F2Qc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788258895; v=1; x=1788863695;
 b=mq1f/7VuoYejo8kDH2nDeuJWEf7Id2zVtyoyl8edNXahhl/ikdcdIpHhhmivFQq3VauUspxs
 8cbDqtUigM/XVxHfnGXirlhX0Q3IyVbX2zqr1qbX6QTiALAXcwUqpnSAPvHda1I8U93b6Uca7tn
 CpDVe6WLb/IQ7xMlxSL7/pBU=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b8b3d08cd4f89bea;
	Tue, 01 Sep 2026 10:34:55 +0000
X-Mizu-Trace-ID: b8b3d08cd4f89bea
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b5e5aaf7deso7042e87.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 03:34:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByJYyHpSUR12c3Jg6v7VkdGRRZapQ3gh3GNxaZYIaHGsajHaE/bEEJtrtDeE5HJNQSgh4Hi8xoi00nGxtNLW3hvX4Q=@vger.kernel.org
X-Gm-Message-State: AFuF++l/1WzNaG7JpEq8zvpo026O25QZ9DdAIMoapvHPBgLD75VrkfOG
	EbSOykW2Qb/zEeZQsoBseSL2j80wUZ+qU4vx6pWJeY1wc39mC9byAji34p7I6BKykVNzDHdazt+
	qUm7jBls/SdPSV/dC0lseE/4PUL+FzazOgq+9H7cI
X-Received: by 2002:a05:6512:ac4:b0:5a8:6646:d7b4 with SMTP id
 2adb3069b0e04-5b600a0b6f4mr114181e87.1.1788258889928; Tue, 01 Sep 2026
 03:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830-gmem-inplace-conversion-v12-0-85e5fd25252a@google.com> <20260830-gmem-inplace-conversion-v12-13-85e5fd25252a@google.com>
In-Reply-To: <20260830-gmem-inplace-conversion-v12-13-85e5fd25252a@google.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 1 Sep 2026 11:33:00 +0100
X-Gmail-Original-Message-ID: <CA+EHjTxdJmjBu8vJqbZks3ANP7QFZzGvp4J7kqxvTNR-fKMmJA@mail.gmail.com>
X-Gm-Features: AcwNN1W_H4CnVusKniYHLtrTvE9k4_Zq5YT-PzaJWqqbnOmAYps19c1F8GBPWTQ
Message-ID: <CA+EHjTxdJmjBu8vJqbZks3ANP7QFZzGvp4J7kqxvTNR-fKMmJA@mail.gmail.com>
Subject: Re: [PATCH v12 13/45] KVM: guest_memfd: Pass mapping type filter to
 invalidation helper
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
> From: Ackerley Tng <ackerleytng@google.com>
>
> Accept the mapping type filter as a parameter in the invalidation start
> helper instead of querying it internally. This allows callers to specify
> which mappings (shared, private, or both) should be invalidated.
>
> In the next patch, the conversion process will use this new parameter to
> invalidate mappings only when they're different from the target state of
> the conversion, i.e. invalidate only shared mappings on a shared to private
> conversion and not both.
>
> No functional change intended.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad


> ---
>  virt/kvm/guest_memfd.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index e41802944756b..e19de803149c2 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -192,13 +192,13 @@ static void __kvm_gmem_invalidate_start(struct gmem_file *f, pgoff_t start,
>  }
>
>  static void kvm_gmem_invalidate_start(struct inode *inode, pgoff_t start,
> -                                     pgoff_t end)
> +                                     pgoff_t end,
> +                                     enum kvm_gfn_range_filter filter)
>  {
> -       enum kvm_gfn_range_filter attr_filter = kvm_gmem_get_all_gfns_filter(inode);
>         struct gmem_file *f;
>
>         kvm_gmem_for_each_file(f, inode)
> -               __kvm_gmem_invalidate_start(f, start, end, attr_filter);
> +               __kvm_gmem_invalidate_start(f, start, end, filter);
>  }
>
>  static void __kvm_gmem_invalidate_end(struct gmem_file *f, pgoff_t start,
> @@ -224,6 +224,7 @@ static void kvm_gmem_invalidate_end(struct inode *inode, pgoff_t start,
>
>  static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>  {
> +       enum kvm_gfn_range_filter filter = kvm_gmem_get_all_gfns_filter(inode);
>         pgoff_t start = offset >> PAGE_SHIFT;
>         pgoff_t end = (offset + len) >> PAGE_SHIFT;
>
> @@ -233,7 +234,7 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>          */
>         filemap_invalidate_lock(inode->i_mapping);
>
> -       kvm_gmem_invalidate_start(inode, start, end);
> +       kvm_gmem_invalidate_start(inode, start, end, filter);
>
>         truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
>
> @@ -522,6 +523,8 @@ static int kvm_gmem_migrate_folio(struct address_space *mapping,
>
>  static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *folio)
>  {
> +       struct inode *inode = mapping->host;
> +       enum kvm_gfn_range_filter filter;
>         pgoff_t start, end;
>
>         filemap_invalidate_lock_shared(mapping);
> @@ -529,7 +532,8 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
>         start = folio->index;
>         end = start + folio_nr_pages(folio);
>
> -       kvm_gmem_invalidate_start(mapping->host, start, end);
> +       filter = kvm_gmem_get_all_gfns_filter(inode);
> +       kvm_gmem_invalidate_start(inode, start, end, filter);
>
>         /*
>          * Do not truncate the range, what action is taken in response to the
>
> --
> 2.55.0.897.gb25b4bd76c-goog
>
>
