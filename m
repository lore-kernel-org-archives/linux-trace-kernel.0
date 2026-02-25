Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290962E0B5C;
	Wed, 25 Feb 2026 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772050374; cv=none; b=ItRbQy4jprItwh0JYotKmYGJhugeP38O02bSHXkuoDGAtn/ebeI0fmTpItg3HnmN5IZpNV8MmU3hhyotxgLrDrBuj/VkakibjY9LQLTBmLuNZkloTkPa2ybzA79EvnNdVavJeP5hwogd7/ZpbTsE/FQUDFoUPfoMqlEumFFJsn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772050374; c=relaxed/simple;
	bh=hvDyKIkKV0xKNXKf+f4mVxzCGIFYEMzA/sqURO92W30=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YOb0pkUPSEzo+BaP4mcEa/rK/DFN8C35DVulPrzY0SuoooY98N1lIz3KeNMQdXMmkwNqolhpaXXgy2hW0J1dNrVApomx2eG6CqBH41BITpP+9guBPETFPz9/zQPlvr2+ctwWQBjDlUSvmOlSWpjce85+12rQrk10XKNSN4tTKME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vZXOPZ1F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vZXOPZ1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BCEC116D0;
	Wed, 25 Feb 2026 20:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1772050373;
	bh=hvDyKIkKV0xKNXKf+f4mVxzCGIFYEMzA/sqURO92W30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vZXOPZ1F0hslCdpR1V7LhWv/gVAq66hcZRmtOh8L0xMZCTpYuZhP96kGtG+PXIthU
	 ZM6TOaD8CYQ8v8jrmSN2C10ygQ+Vc29+ZUVwzbn3eeprcJHSdh0uzI/RtkPKH6erMZ
	 xv09WEpiHYPEtpqqi/5rOnyYmVcb7IHVcxQrnKTc=
Date: Wed, 25 Feb 2026 12:12:52 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Brendan Jackman
 <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan
 <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>, Qi Zheng
 <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>, Axel
 Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei
 Xu <weixugc@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 kernel-team@meta.com, Benjamin Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v2 3/4] mm: convert compaction to zone lock wrappers
Message-Id: <20260225121252.7c6519a857c1a8c56ba5206f@linux-foundation.org>
In-Reply-To: <9710c3448c6c984164c93d7c6c0283e06ff987bf.1772030186.git.d@ilvokhin.com>
References: <cover.1772030186.git.d@ilvokhin.com>
	<9710c3448c6c984164c93d7c6c0283e06ff987bf.1772030186.git.d@ilvokhin.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Feb 2026 14:43:05 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:

> Compaction uses compact_lock_irqsave(), which currently operates
> on a raw spinlock_t pointer so that it can be used for both
> zone->lock and lru_lock. Since zone lock operations are now wrapped,
> compact_lock_irqsave() can no longer operate directly on a spinlock_t
> when the lock belongs to a zone.
> 
> Introduce struct compact_lock to abstract the underlying lock type. The
> structure carries a lock type enum and a union holding either a zone
> pointer or a raw spinlock_t pointer, and dispatches to the appropriate
> lock/unlock helper.

It's regrettable that adds overhead - increased .text, increased
instructions.

Thing is, compact_lock_irqsave() has only two callsites.  One knows
that it's dealing with the zone lock, the other knows that it's dealing
with the lruvec lock.

Would it not be simpler and more efficient to copy/paste/edit two
versions of compact_lock_irqsave()?  A compact_zone_lock_irqsave() and a
compact_lruvec_lock_irqsave()?

