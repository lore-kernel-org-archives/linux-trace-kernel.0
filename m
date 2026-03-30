Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B99227A92E;
	Mon, 30 Mar 2026 17:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774893236; cv=none; b=S4oR1+F0ZEn2z96d5gpg/NCrRb/WboHOOFh8Ua2ewksI+Vm+BR2Jky4YeBkgcH4lJ+aBezXOY+SG0ILBFUyGTKwt3BRT8RH5l3WxeIsvaF1q2FoLngLKqVHHGOYJzR/oGFK/2Bkm8uH8QT8V80PGTivGwRV3Q7E5Kj3z0kIO11c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774893236; c=relaxed/simple;
	bh=joooSgh20rkFoxwTA7S1U47jM/W7cL4ml5gVF6pCx0A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hw2E9yzzcBD+Y610ecYaZW0nAwNWsv6xUfj4NcaVAdIzsDJKrTJfiSfaYhOOl7S8wYnbG87YAJyxOr05Ln0zelz2rT+bGVDxYzPB6+x5sT0VOQekXljvRqemwDvzdj40qodqQ7qMG0PNkMaG/qSsMHLtj20AW1pyvLpYVVq0ngA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id F1F1B8C521;
	Mon, 30 Mar 2026 17:53:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 2DBAA34;
	Mon, 30 Mar 2026 17:53:51 +0000 (UTC)
Date: Mon, 30 Mar 2026 13:54:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>
Subject: Re: [PATCH v14 1/5] ring-buffer: Flush and stop persistent ring
 buffer on panic
Message-ID: <20260330135447.423bc070@gandalf.local.home>
In-Reply-To: <177487499643.3463592.15413057950716995168.stgit@mhiramat.tok.corp.google.com>
References: <177487498530.3463592.12715592581212799257.stgit@mhiramat.tok.corp.google.com>
	<177487499643.3463592.15413057950716995168.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 2DBAA34
X-Stat-Signature: 6a1x1g19ttuj9meknrmi9cn3z5p7hc35
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+SpgGvLyrFp6rjn7dzVYcwrLZVQGFis7U=
X-HE-Tag: 1774893231-84487
X-HE-Meta: U2FsdGVkX1/39dMoG9fo7BkVKJkcGlaAadelIqa2BHpg16h7wsEg95KboNSNc7xo05Ujf0i6pAdW2vnxFuqH6uTuHuUBVQC2/kZhbdf184HYqdgr4hAGoxSPd3UivBBEkLO0pLp5igOHdAROkKToOyCkHGFP0MlWikFdEdmqn3qJZYfuvEP5VJEKEDhgRdXsWvSskeCqECPB7joNw/3Fd79gzKdYIALRQwOvxHv6w5uVGtvyAPfTtA4iONub+0y8zabVSHY+LrspGDw5fnN7dIjOcKMXozSaxuFFas0WhMyUxcgTzR+JEjnXtnVoZqfxDgiyvUtKGO2F5hgq72+N5SAyHxJWePRi

On Mon, 30 Mar 2026 21:49:56 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> diff --git a/arch/arm64/include/asm/ring_buffer.h b/arch/arm64/include/asm/ring_buffer.h
> new file mode 100644
> index 000000000000..62316c406888
> --- /dev/null
> +++ b/arch/arm64/include/asm/ring_buffer.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _ASM_ARM64_RING_BUFFER_H
> +#define _ASM_ARM64_RING_BUFFER_H
> +
> +#include <asm/cacheflush.h>
> +
> +/* Flush D-cache on persistent ring buffer */
> +#define arch_ring_buffer_flush_range(start, end)	dcache_clean_pop(start, end)
> +
> +#endif /* _ASM_ARM64_RING_BUFFER_H */

You probably need to get an ack from the arm64 folks.

-- Steve
