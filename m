Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E1427442;
	Fri, 27 Feb 2026 00:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772152302; cv=none; b=qr46hAvJrMozUMFMIEHSe99l28P3PxFmHUsliOvOf/anMD5EIEAMUACTYWGJEP/Ay/50QQUfMF+guxp6FlEUlgwBLQMlyZGOzGZ860U0Qu08wzICptBMagSxjXfW1fNPYLa3NRNGybyQizqfe5b0sp0L9ZlfsnwZh+nbUzY5wIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772152302; c=relaxed/simple;
	bh=wLUycsWy3gvgVrAlquArUpLMruKe7fYZQVQj/k79Xis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJ7W2lwZDLLuEO/UPyfdnhM1Z/EE26vTczPdv7GcvfKK2TM8wSUnvCOagbfXh5A2dFvwxaTYA7LKdnf90GsXFutk34pgVxUDqbMsRSpzPgXrqcRwcFSJ09whq8CvT9zWEZZRPPX1pRpEK0E9zv3mOAP9q95geJXsKAqZCvOQ4F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6wDT8Oz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6wDT8Oz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BA8C116C6;
	Fri, 27 Feb 2026 00:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772152302;
	bh=wLUycsWy3gvgVrAlquArUpLMruKe7fYZQVQj/k79Xis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C6wDT8Oz/lWsnUbLFCuR+IuSXz5zQ2VJkvYKpUXXoPZ/z8OhpxaWeRaa5c4TLRAhK
	 O7HwYD8uJA3dEJRoQwpbdlwcpzKNFy6c6Y2rlnAx1i3MUOhZ/z/wkWiGmwlyEDFNXC
	 vaDUebAFwFQlcm0XAcavOJXyB7KVONW6Amv1x/VM/BEqfAsScqIXsUOZWvgdkQsNfh
	 RP9Vd2dE1ZBsotkGgdnOGvBNXFnxclpXgsKE2CpzjdRlrl1S7BjAGJs/sEPG20lVUt
	 tynzhNe8Wu+Luo8aZjvsWO+8Ja3a+mPaM4kWOeJEWsw64nvk2eyHOUYV+et7xVXzvM
	 4oAdfOn8IoOBw==
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
Date: Thu, 26 Feb 2026 16:31:39 -0800
Message-ID: <20260227003140.82789-1-sj@kernel.org>
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
>  MAINTAINERS               |  1 +
>  include/linux/zone_lock.h | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>  create mode 100644 include/linux/zone_lock.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 55af015174a5..61e3d1f5bf43 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16680,6 +16680,7 @@ F:	include/linux/pgtable.h
>  F:	include/linux/ptdump.h
>  F:	include/linux/vmpressure.h
>  F:	include/linux/vmstat.h
> +F:	include/linux/zone_lock.h
>  F:	kernel/fork.c
>  F:	mm/Kconfig
>  F:	mm/debug.c
> diff --git a/include/linux/zone_lock.h b/include/linux/zone_lock.h
> new file mode 100644
> index 000000000000..c531e26280e6
> --- /dev/null
> +++ b/include/linux/zone_lock.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_ZONE_LOCK_H
> +#define _LINUX_ZONE_LOCK_H
> +
> +#include <linux/mmzone.h>
> +#include <linux/spinlock.h>

I'm bit worried if I will think this as a file for another general locking, not
the mm specific one.  I hence think renaming it to more clearly saying the
fact, say, mmzone_lock.h, might be less confusing.  Or, putting things in
mmzone.h might also be an option?  What do you think?


Thanks,
SJ

[...]
