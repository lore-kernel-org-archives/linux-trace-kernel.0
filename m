Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0B81A6838;
	Mon, 29 Jun 2026 10:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782730016; cv=none; b=jksthAn1qpu6K07BRd/NctWQ/T251I9USxq+yS08apxOr2r9RC0znPVl28AoTrPAfwYnU0AqRnYjUafSBnLNiTKCDTs80Efv7x0wlJSo3UFMEyRe/Phl2N5NFbyHi6yvxMPjBlLD6gKvJqivLKIz03DunYVuJyOL8MOzxXYYFdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782730016; c=relaxed/simple;
	bh=/C0Q0DNvvO7li3qpeQ5jg51Bq60J4N/yY8q5r2HaP2s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rpMNSUo5bQe9GkTuZ4Jxst5GvmUTid9Sp7b9HZcNCrEP1XSwZuy8FOaWJFp8lGS9JwZtFKYlg/EDUhLqajuHhsFJyTix0NYsxxIqvrQ9dDY9oBkTqrtR8omPYRlUK9lN63qcxxHL0jY7xppypesiQvhulYk9DAwO9QWvAS6QdjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 3C8B3C3217;
	Mon, 29 Jun 2026 10:46:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 7551E20028;
	Mon, 29 Jun 2026 10:46:45 +0000 (UTC)
Date: Mon, 29 Jun 2026 06:47:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Martin Weiss <martin.githubacc@gmail.com>
Cc: linux-kernel@vger.kernel.org, Martin Weiss <Martin.weiss2410@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] trace_branch: use per-cpu counters for
 correct/incorrect stats
Message-ID: <20260629064721.1ffd75fb@gandalf.local.home>
In-Reply-To: <20260629095838.601926-1-Martin.weiss2410@gmail.com>
References: <20260629095838.601926-1-Martin.weiss2410@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: wqsdokyfife11itnzjtgqonbz5e3m9ed
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 7551E20028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+ZdPdIl2Oi15830NMDc9gVNDFIe3S3OQk=
X-HE-Tag: 1782730005-880365
X-HE-Meta: U2FsdGVkX18i7nTH06hQ1lDgg3eDDBXMtir1jmPdtanWg0WK9dA9T5W6lZZs74YqMeioKKbQCDyUrfN7VI+aishisoGMdxFEU4fMBQuoTtqmRSMenoXok0B1DQuAVGsTThZPaomymVa32PHrNX4k0iGWkdsGsoKYSh/pM/AEb418V9BNBJzD/bQhw9Z/c8ay6d4oUz12JEreZdWI37hb9fMDpdQNUxjeH32fzC8Tvd7wHmB2H47k6TzzPU4qL0tbQAebDNlavnQAJX9CtKuxLbeTiPWWzUeQZlWpOj3eRaGzt0lgbr7c2ynwojreThTKctdZWy4z/TqoS+Nr8nxjGuCh8jZeldWA

On Mon, 29 Jun 2026 16:58:38 +0700
Martin Weiss <martin.githubacc@gmail.com> wrote:

> Replace per-task counters with per-cpu increments to avoid race
> conditions in the branch profiler fast path.
> 
> Fixes FIXME about atomicity.
> 
> Signed-off-by: Martin Weiss <Martin.weiss2410@gmail.com>
> ---
>  kernel/trace/trace_branch.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_branch.c b/kernel/trace/trace_branch.c
> index d8e97ad798f0..960bcb3d7dbf 100644
> --- a/kernel/trace/trace_branch.c
> +++ b/kernel/trace/trace_branch.c
> @@ -213,11 +213,11 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  	 */
>  	trace_likely_condition(f, val, expect);
>  
> -	/* FIXME: Make this atomic! */
> +	/* use per-cpu counters to avoid contention */
>  	if (val == expect)
> -		f->data.correct++;
> +		this_cpu_inc(f->data.correct);
>  	else
> -		f->data.incorrect++;
> +		this_cpu_inc(f->data.incorrect);

I don't think this does what you think it does.

Did you even test this? I'm guessing it would blow up in some fantastic
ways.

NAK.

-- Steve


>  
>  	user_access_restore(flags);
>  }

