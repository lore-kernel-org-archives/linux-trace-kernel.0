Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F39286425;
	Fri, 27 Feb 2026 00:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772153629; cv=none; b=IZ3wMeJlWDFlaVo4zW+fPH9jeue9SRU5W+b7EkxU/AvMPHVduwZHNq5Jo9hrt+4CCehesdv4oLa9dNZF2hdDskoI0K6itpnMe2M//HrPqmNHw6gJWat0f0AHafpzMA7DA8a6d0z7icCG4Sh9po1lpXcuj0nlJcspQc24g3bpZyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772153629; c=relaxed/simple;
	bh=CmjyhHBzOamf/TIiZ2ARCfteNT7y9VF5jQJbX1dDiAM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h39PdfdRtIgvGW+DqihpFVnArwhvQcZnKpNnAqnaEykYU+1WuWvqsAgHiBzfKnWDetk11MV6juwvifh7Hkiiyl/L+v7NkHh4/ptLYV/12SFA+ofW1Q0Is8E7/C7IajbgmqHGcCtwf/W+kox+X9xh5G9Se+wGC/k70RKoK7KK99Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 20A57C1AE8;
	Fri, 27 Feb 2026 00:53:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 8D64A20029;
	Fri, 27 Feb 2026 00:53:32 +0000 (UTC)
Date: Thu, 26 Feb 2026 19:53:55 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: SeongJae Park <sj@kernel.org>
Cc: Dmitry Ilvokhin <d@ilvokhin.com>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie
 <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Oscar Salvador
 <osalvador@suse.de>, Qi Zheng <zhengqi.arch@bytedance.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 kernel-team@meta.com, Benjamin Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v3 1/5] mm: introduce zone lock wrappers
Message-ID: <20260226195355.611ec7f3@gandalf.local.home>
In-Reply-To: <20260227003856.83271-1-sj@kernel.org>
References: <5bcc39cd3a227944d0fbe75ff86cdac92b38d4ca.1772129168.git.d@ilvokhin.com>
	<20260227003856.83271-1-sj@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 66drfiy9dmwciebf5j7fsqroxmzzedms
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 8D64A20029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/LiC0YloSSM44sJymQ/qyPpNpQ64AKLbM=
X-HE-Tag: 1772153612-227748
X-HE-Meta: U2FsdGVkX185+mqfSVIc5V+IJg7SmsD8GX4C+AsrLlqGF+GiNx5rp1FR/ah3UYg0ySZaaCC0lC3y4ZOj3GwZRvNDd+jiQ+voXh7q637prwfNUghpmjrfcHBWXH6pj6Zt7HFY086MjXDaLq1BJi+TnWMBNHvNvRTA9iVOHt8dQv0WkMKuXibT3ArN/tDWSD2XbgpIFNTuvbTxOSkHHvRTcd1M1eAaFfIZkTnOnpay0V5xotmMG540AfPniTrLHh5j267JzPYt69h1lEqRPTCS1/ZVFW+450aGnIu92ayUHLLi6Ptre+idC7HVL6gk/4lcHKe1coJSNmTZb815erS9aFI+OZAhIfA9

On Thu, 26 Feb 2026 16:38:55 -0800
SeongJae Park <sj@kernel.org> wrote:

> checkpatch.pl complains as below.  Should be ok to ignore, but, may better to
> kindly make it silence?
> 
>     WARNING: Single statement macros should not use a do {} while (0) loop

Hmm, why is this an issue?

>     #116: FILE: include/linux/zone_lock.h:13:
>     +#define zone_lock_irqsave(zone, flags)                         \
>     +do {                                                           \
>     +       spin_lock_irqsave(&(zone)->lock, flags);                \
>     +} while (0)
> 

I know this is checkpatch and not you complaining about it, but I really
think it's a useless complaint. I can see it better as a do { } while (0)
because it is creating a "function" like feature but can't be inline due to
flags.

This is one of the reasons I still never use checkpatch.pl :-(

-- Steve
