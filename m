Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793262848;
	b=HfaI4h8wyQywGf1IQARQWnSfJBSx+9Fqp1o6EOTXppW6v1Tq7vXyX4H/YdWz/R8JfcG5
	 1VhTLilcj+w3y5u94G/BzGwWRKEI4hPDDDxrYZYUeCu2ZA2jwU3jis/LBQtcAWYHKD1Je
	 ZWk69wO9gsmI9ksYDQBDtEUXmeyg8Ag/D4KFLu07rIXuWnBPMyaaUGi0P/p10ruddPaML
	 hzoSLTk3K3VZV3OJbNRpL3nMnx+iuHP3E0AVlaUbApx9zqmkJGwGzbFO/4fnq/SIzpgEu
	 9i3UILsqjDEzNArC/ATKw61kXN0OHSSL6ngUqYJNQx31UOM4gfQlhbzowrX8yyRbFdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793262848;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=EhgAgTm52pgiixrPe9CqfL75nlW6cKpRZ11fJQCD/PE=;
	b=5n5AEO2pjjPdbgNQzmfW1qLL3eVy9AxXhBCVvxKwIK9bBGEybLZXsO8DNp7NUiwJwX9i
	 r4ohNkqz8V5/dD7Y9uZwrOoVFZXHgUvyumOR52n8wVM6WUu6Kxa9skDibKvjduwoAXReD
	 +NPKntkL0Hj41MfWR7kkDpLd7gypZPeK3eR1ccxU0Oi/Y66pD/hJN6sAxtcjhVCxIDqZR
	 W//p4ZVSOF9DtBAurXbdJ51nWdVqDwW/xFrYm/tXpxK1afObWDTs0u83PfECXB1CGjFOn
	 +dZj8ooyqeJ19RnEmQ4aZt1/D9w3aJLXar6vI7RBZYINd1TMV/yb8dPzCiaHoDGZySA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=YFQyddmq;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63AF606A31D;
	Thu, 29 Oct 2026 08:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D63AF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=YFQyddmq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EhgAgTm52pgiixrPe9CqfL75nlW6cKpRZ11fJQCD/PE=; b=YFQyddmqhJ4oKe1IKsEIhTkVy/
	UhCKP91ig4WJ82vsubrBqyold4fB6frrMTJACCH7bTzT93xjNwfF6Bl88ESAjC1v2Un/IjG3xTz4u
	ijvYmJkU6SvHIdwCMzPwU2fjFH6DzAKkHLeV1w5jdcJfgwBDWwKMDCLL9T0isDBYTi35Oaf/W3W3T
	/uHg9kcQyP/GMO/baXZcn3ZuygxRkuPoysVl2jJx65bLx4fOTaEToUw3Qw42ZBOMHWuLmHqFD9wdL
	Dx0mTBsy7IKwMDl7xXIwYbtH28rNjjKbJKb1g9xtO0jwQdgReHS4SqRZ42YOSAaZuh2FYO+O6dqAW
	ItMqSITQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMLaE-0000000Dq9G-49rd;
	Thu, 29 Oct 2026 08:34:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EF5E2300329; Thu, 29 Oct 2026 09:34:01 +0100 (CET)
Date: Thu, 29 Oct 2026 09:34:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH] lockdep: Add #include <linux/instruction_pointer.h> to
 lockdep.h
Message-ID: <20261029083401.GD1779021@noisy.programming.kicks-ass.net>
References: <20261028110558.623a92d1@gandalf.local.home>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028110558.623a92d1@gandalf.local.home>

On Wed, Oct 28, 2026 at 11:05:58AM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> On 32bit x86, _THIS_IP_ is not defined in asm/linkage.h. It happens to get
> included into lockdep.h via kernel.h pulling in trace_printk.h which
> includes instruction_pointer.h that has _THIS_IP_ defined when linkage.h
> does not.
> 
> In order to remove trace_printk.h from kernel.h, have lockdep.h include
> instruction_pointer.h directly.
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  include/linux/lockdep.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index a6451ecbbe9a..c6b0168f5fc9 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -22,6 +22,7 @@ struct task_struct;
>  #include <linux/list.h>
>  #include <linux/debug_locks.h>
>  #include <linux/stacktrace.h>
> +#include <linux/instruction_pointer.h> /* In case _THIS_IP_ isn't defined */
>  
>  static inline void lockdep_copy_map(struct lockdep_map *to,
>  				    struct lockdep_map *from)
> -- 
> 2.53.0
> 
