Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEB01A08DB;
	Fri, 27 Feb 2026 00:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772152738; cv=none; b=EaGzuXUuKuJ8GmPhG4KOzZ/I5tEgz0AJWJa8PD7k5dhUW2sjdeo954zTxlCsAxfboew5qW/JrihrA5JfP6/ekt68DPVobv8j0IDNzMkDR+9ZMR2sXlDA07lxrwb9hntyXbAz1nb5lwT3XqK0eWN1cNqfJux48+msVzRttKpF5Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772152738; c=relaxed/simple;
	bh=+zLLB70CAty+NdETlp4hLlKF20g9qfS3WT0A330lBlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqN9qNRTRbN9VXde1Faa4YgeSl3PAJfXgaOFXa/a58BYC+tMnRg/ZfGmKyZkVBhgoRPsmEM4tU/K7EKNG8qfeVEMq4gm90l+gaoaVSqCzBuy645zrDi7WlxxOyy+CKDwtXKpdLxl5lKmvpJnXx2nq5JJaewmUYE9tk1ZgIauGIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldWMfqkG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldWMfqkG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610C6C116C6;
	Fri, 27 Feb 2026 00:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772152738;
	bh=+zLLB70CAty+NdETlp4hLlKF20g9qfS3WT0A330lBlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ldWMfqkG9pksWV2DpVwALltLFNKX6kPDCKJYXDlvhpFSpcb/KGrwW2ZGbCqdU/KC6
	 1UHlKZ8lac4iujmDTjndN0zlJ3cQSA98jQZoUtrMbNQOzkpiNRMtmJA+8YZY5LINn2
	 PAN1K+BA4CkZH8vnH01jHbuH/9pkXekDuek9QKdDNocl5yT9iTunq6bGtgzy8uGHPY
	 4ene5f81tWwTdyqJnboEV9c9TdFff8XZ5ToEXlAJg0EjeUX2Wc9+Txm9qtO8zQIb7X
	 P6LkIPvANC/fgLSUMD//akSJDsWHCo/uk5hRwTlUHQZbRSsNr1l1QSHz1LNafpDpiP
	 fXCdY0nuQv4nw==
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
Subject: Re: [PATCH v3 1/5] mm: introduce zone lock wrappers
Date: Thu, 26 Feb 2026 16:38:55 -0800
Message-ID: <20260227003856.83271-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <5bcc39cd3a227944d0fbe75ff86cdac92b38d4ca.1772129168.git.d@ilvokhin.com>
References: 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I should sent this together with the previous reply, but I forgot as usual,
sorry.

On Thu, 26 Feb 2026 18:26:18 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:

> Add thin wrappers around zone lock acquire/release operations. This
> prepares the code for future tracepoint instrumentation without
> modifying individual call sites.
> 
> Centralizing zone lock operations behind wrappers allows future
> instrumentation or debugging hooks to be added without touching
> all users.
> 
> No functional change intended. The wrappers are introduced in
> preparation for subsequent patches and are not yet used.
> 
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
[...]
> --- /dev/null
> +++ b/include/linux/zone_lock.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_ZONE_LOCK_H
> +#define _LINUX_ZONE_LOCK_H
> +
> +#include <linux/mmzone.h>
> +#include <linux/spinlock.h>
> +
> +static inline void zone_lock_init(struct zone *zone)
> +{
> +	spin_lock_init(&zone->lock);
> +}
> +
> +#define zone_lock_irqsave(zone, flags)				\
> +do {								\
> +	spin_lock_irqsave(&(zone)->lock, flags);		\
> +} while (0)

checkpatch.pl complains as below.  Should be ok to ignore, but, may better to
kindly make it silence?

    WARNING: Single statement macros should not use a do {} while (0) loop
    #116: FILE: include/linux/zone_lock.h:13:
    +#define zone_lock_irqsave(zone, flags)                         \
    +do {                                                           \
    +       spin_lock_irqsave(&(zone)->lock, flags);                \
    +} while (0)


Thanks,
SJ

[...]
