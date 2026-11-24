Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536525;
	b=pKFzCiGtGbw/jdLDc0T5z24FvNBY4MtMxmvgCUCDQzzYYDjF4zK/CqIJQ6NwBENIXUN0
	 A23WzkcA3T/zONizAI0nwWy07qTapnLHnUCcBXSZ/j+6dRo+GVfzD7IkS3gQRB11V2Og0
	 FprpOAZIEAZOAcvJ6JpTlCskTbc5jBy1ExQSdGKSoD32ogKD6sm6iPlsgvm9J5rS0yPoo
	 MOOmb4gcC0RkaAJNYXaD9qPuP6RAkyD9oUOqZlGfFAuX9YfJwMTPWKD12nbyLTPh4NIEF
	 HCwQ5neawbslBv6yShLI2al2UBAW4z0uT8FZ5pdAIPKorphY+HGERMWD8IDK8m7jcAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536525;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Stat-Signature:
	 X-Spam-Status:X-Rspamd-Server:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=lHe6t0W6wJIz0Tl4HeE64/VhSLD31cFoO27KI4Qiuhw=;
	b=JCBwI7+4aexuG0L22oMmPY6L1vRVtmpTxmKBSm0MtEiASjF45aRvxIyqDmQbOx4rPP+w
	 27vpTn+OM+sVwAJ+0tSZg7uTHMRYE4hQ+BkmHF/BpumnyDLHTyd/E7fgJJS+QJ8KmSoNm
	 ym2fvKOSyaflCK3Oi10tMiJdoLGviLCy/zgbgt8NMdk/vYvdsOS5DHcx2Gbxl099YKORu
	 otsvxXuJjaYZwPbXhrEHF754h9kwJkQdEeckHO0h0z/HfBKf79Px2v+AebSbRJkviPpML
	 LW7lCkrT9JHsoIYmKiifZuenvRIEIlxodLFb9uzLhvR/Kr56xBSpsBagVveB0+Oo+jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=iN5i07JY;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F79A606A321;
	Tue, 24 Nov 2026 16:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F79A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=iN5i07JY
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 3150A80C03;
	Tue, 24 Nov 2026 16:08:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id DBB8D2002D;
	Tue, 24 Nov 2026 16:08:38 +0000 (UTC)
Date: Tue, 24 Nov 2026 11:08:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Hongyan Xia
 <hongyan.xia@transsion.com>, Song Liu <song@kernel.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider
 <vschneid@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sched/preempt: Check preempt counts in notrace
 helpers
Message-ID: <20261124110837.731d1d2e@gandalf.local.home>
In-Reply-To: <446e2bd042ce071da52ea80f577fe43c1b3dc031.1794814699.git.kmehltretter@gmail.com>
References: <cover.1794814699.git.kmehltretter@gmail.com>
	<446e2bd042ce071da52ea80f577fe43c1b3dc031.1794814699.git.kmehltretter@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DBB8D2002D
X-Stat-Signature: y99wuu3wcuparip11f8ts89pfbjmjbeq
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18DwXvKUKEkZAWHfXqOR0iuglFy7nRSMf0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=lHe6t0W6wJIz0Tl4HeE64/VhSLD31cFoO27KI4Qiuhw=; b=iN5i07JYlQRQ34fWR1AvoJAloSckSso7iEYRm9WjSFR3aLVMbXWgunSGg28ES0C5FDExitzGh9y49MzgHWF9QII2XRAodQ9+fdAH+0xqYGdEZcoa6I+qKWZROzXUy8sUXt6VD6xZuPfTG4ihukVU+xwbCp5f41/d091E0F7Xc5g=
X-HE-Tag: 1795536518-760363
X-HE-Meta: U2FsdGVkX18bnq3lqHEYYRQn2HbnrQkmCuTUkZ8yFM3JKQH/amoJ0fMN2eiSYNF1wZTyTk9ZMcRD0XZw1w2poxlye60YOayZcvOD+Zglk/0yLuYh/x6opXsqualSJdS8TeyIL3St6DBX+yi4braHVjh0wkhAgQoGXzX/Yth1jxC5Pc6LWOixWJ6ZYEjHBoBnePHWECl/K4iirlKgRJSmQMDvBOm7Irjy4rd0j1WHddRVlTpyEsJfsbT9A0ioGHd9b2MYoJNw/Q0zDOj8HHP5VEJrC0Dk4cqJtSpjJCHCByyLxvV3Z7GSbf/Et9mpRzrZX/7dZRF9xSgXtCgSvIfQ0E6CEtS05TYk0JohdFj7TAfA6ZUrtpmT8w==

On Mon, 16 Nov 2026 08:54:24 +0100
Karl Mehltretter <kmehltretter@gmail.com> wrote:

> --- a/kernel/sched/Makefile
> +++ b/kernel/sched/Makefile
> @@ -27,6 +27,9 @@ endif
>  
>  # Branch profiling isn't noinstr-safe
>  ifdef CONFIG_TRACE_BRANCH_PROFILING
> +ifdef CONFIG_DEBUG_PREEMPT
> +CFLAGS_core.o += -DDISABLE_BRANCH_PROFILING
> +endif
>  CFLAGS_build_policy.o += -DDISABLE_BRANCH_PROFILING
>  CFLAGS_build_utility.o += -DDISABLE_BRANCH_PROFILING

Branch profiling is really for checking production code and not debug code.
I don't see a use case to see what branches are taken when the kernel is in
debug mode.

I think it would be better to just have BRANCH_PROFILING depend on
!DEBUG_PREEMPT. Then the above wouldn't even be possible.

Thanks,

-- Steve


>  endif
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1a088d4576f59..98ca93bc60887 100644
