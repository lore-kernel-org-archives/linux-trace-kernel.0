Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FB81EF0B0;
	Fri, 27 Feb 2026 00:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772153157; cv=none; b=jonv0Ohjx+5bU72uCBTSRozMKWXn6xgDAfGEGyotQdR6S7yFiT78HCO/vJ5NGWnaDe7+MjLftYX3udeWF5peUFMdN84XGmLEfxT2YQGE34NXqOu3uCxHAnUgh+3t6BZ7aePJiJI2OkChGFXsj0oLFONIvIxJ2j2CdXkegdTt7IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772153157; c=relaxed/simple;
	bh=7stlFYCl1LQeMv3JNhnoSvzt9QhLvt8aUlCsIpsOmHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkfst8mddoAQRIdYv9seSYn3keDwugENetmLpcyAN0N75hID/vWkr3he6SxU3F/4L1LERE1YAJXsjMZ/NyueSsqIOWBY7+grWdva6PqTK7KyqohVVR+wn9AbZgDaYXPomx/H3LxFiVdvEB7idM6UqKWRIAdPpFJUdVeVZ6ULyRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5/u1IOs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5/u1IOs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE24EC116C6;
	Fri, 27 Feb 2026 00:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772153156;
	bh=7stlFYCl1LQeMv3JNhnoSvzt9QhLvt8aUlCsIpsOmHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N5/u1IOs51h8aCGcDabK8JxMaRFCCz3yl/81Kyfp2I9SmL8WNud2TGw1i6xPTNx2+
	 YkBlcdmAlq03sHWV9EXKAPQF1dpu9RdaR/SmBF18k1H5a78VPeTzgZMyQr1463r7tt
	 U8FPbQENYrGx1CPlO+DNYhbWgqVlCA8C186mEv6qpHCuntkOSqmQ/2LJJySaJ9STRB
	 ipFC3tGfwLOEvSxvB/Xhgv0M7v0BhgXnlLVOKYZQjI30fOPWH5/HZt0+9InTZFnXJL
	 1tDMAQMyXo0idZuX80df97Secsv4Lpq45x7LyGctpT7z9CBeMovuOgDwhIU4D1NJIt
	 634MDT7vDZDUQ==
From: SeongJae Park <sj@kernel.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
	Benjamin Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v3 3/5] mm: convert compaction to zone lock wrappers
Date: Thu, 26 Feb 2026 16:45:54 -0800
Message-ID: <20260227004554.83555-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <01729baf359e4c6612aead53f1fcb644f782d1de.1772129168.git.d@ilvokhin.com>
References: 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 26 Feb 2026 18:26:20 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:

> Compaction uses compact_lock_irqsave(), which currently operates
> on a raw spinlock_t pointer so it can be used for both zone->lock
> and lruvec->lru_lock. Since zone lock operations are now wrapped,
> compact_lock_irqsave() can no longer directly operate on a
> spinlock_t when the lock belongs to a zone.
> 
> Split the helper into compact_zone_lock_irqsave() and
> compact_lruvec_lock_irqsave(), duplicating the small amount of
> shared logic. As there are only two call sites and both statically
> know the lock type, this avoids introducing additional abstraction
> or runtime dispatch in the compaction path.
> 
> No functional change intended.
> 
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> ---
>  mm/compaction.c | 33 ++++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 47b26187a5df..9f7997e827bd 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -503,19 +503,36 @@ static bool test_and_set_skip(struct compact_control *cc, struct page *page)
>   *
>   * Always returns true which makes it easier to track lock state in callers.
>   */
> -static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
> -						struct compact_control *cc)
> -	__acquires(lock)
> +static bool compact_zone_lock_irqsave(struct zone *zone,
> +				      unsigned long *flags,
> +				      struct compact_control *cc)
> +__acquires(&zone->lock)

Nit.  Why don't you keep the indentation?

My impression based on below output is that mm code prefer indenting
__acquires().

    $ git grep __acquires mm
    mm/compaction.c:__acquires(&zone->_lock)
    mm/compaction.c:__acquires(&lruvec->lru_lock)
    mm/khugepaged.c:        __acquires(&khugepaged_mm_lock)
    mm/userfaultfd.c:       __acquires(ptl1)
    mm/userfaultfd.c:       __acquires(ptl2)


Thanks,
SJ

[...]
