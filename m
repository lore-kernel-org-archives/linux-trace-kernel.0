Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBABC3A8743
	for <linux-trace-kernel@vger.kernel.org>; Sun, 20 Sep 2026 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789915098; cv=none; b=DBp81eU0ogHkUGzvc1OZuTzBBsoPpWGhs81IgGhVmtnCRwgYXfHGq03mlLjYcS1xGyqsQJQTZ23KSKVuke7ebSJhQJiilt93y38TTmquqtm795EKvQkhy/HB0B3pgdDPndCQOMbDEpdjhw9tdQzjqsuOM5cY3yJUppXwiebYkwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789915098; c=relaxed/simple;
	bh=k1/vPVWmelbquYNhQm4hxjmelpN8EQ1ipSIQo45GnjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jEQmEoQRIPQNZcKtERFoEeayghiJ4vi9DY0gDn4BpT/U34m6pCmKCkK/qP3wZFhup50qusqFHe5xySp6/5j0jbWfKWbZFtcQ2XXcjrc1ynBFW6VdEYObbOOnpM/roezrdMhFCg2Ya3cMnG6AwA7ryeQI2JtIw7MhdhTs7Isffb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gVaLXeD3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVaLXeD3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789915093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZRsIrsnLE8Ff1LkbGdy9r/zXAFT8DSmXUcXQS9CgO18=;
	b=gVaLXeD3nUKUzXV3h5NT4jF0+7+UgFmhqOL2dHE8hwUEXlRS4F1uwkfdtNhw15WAKIdvmS
	hShy1Mx5gTh78htoN6hrp8YVssx3DruWlz9oGv2+FqTrSd4g9LUx9l364yaox8CgWDnXgC
	BdGGz102q1ckCCXAi6S1yUZIVnp0RDA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-DThqWn-2N_KoQGPNCu824A-1; Sun,
 20 Sep 2026 10:38:07 -0400
X-MC-Unique: DThqWn-2N_KoQGPNCu824A-1
X-Mimecast-MFC-AGG-ID: DThqWn-2N_KoQGPNCu824A_1789915085
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1DAD1180A9E5;
	Sun, 20 Sep 2026 14:38:05 +0000 (UTC)
Received: from fedora (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 33B851956095;
	Sun, 20 Sep 2026 14:38:00 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 20 Sep 2026 16:38:04 +0200 (CEST)
Date: Sun, 20 Sep 2026 16:38:00 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Adriano Cordova <adrianox@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH 2/2] uprobes: Hide unprepared uprobes from the breakpoint
 paths
Message-ID: <aq_vyA_eIfvpCuj1@redhat.com>
References: <20260918143209.709291-1-adrianox@gmail.com>
 <20260918143209.709291-2-adrianox@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260918143209.709291-2-adrianox@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: Od7pCedvf2SUowspnDDlc-FVX1Yc7v82UDuOTAVadQA_1789915085
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 09/18, Adriano Cordova wrote:
>
> find_uprobe_rcu() backs handle_swbp() and handle_syscall_uprobe(). Make
> it skip a uprobe whose instruction has not been analyzed yet, so neither
> path can use an uninitialized ->arch. An unprepared uprobe has no
> breakpoint installed (install_breakpoint() prepares before set_swbp()),
> so the trap path treats it as not registered yet. This also gives
> handle_syscall_uprobe() the check it was missing.

Sorry, I am confused.

Can you explain in more details what problem(s) this series tries to fix?

handle_swbp() checks UPROBE_COPY_INSN.

handle_syscall_uprobe() is only called by sys_uprobe() which checks
in_uprobe_trampoline(). So it can only be called after the probed insn
has been analyzed and optimized.

Oleg.

> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>  kernel/events/uprobes.c | 35 +++++++++++++++--------------------
>  1 file changed, 15 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 686585539ebf..bdc05fdce0a0 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -924,8 +924,20 @@ static struct uprobe *find_uprobe_rcu(struct inode *inode, loff_t offset)
>  		 * try again as we might have missed the element (false
>  		 * negative). If seqcount is unchanged, search truly failed.
>  		 */
> -		if (node)
> -			return __node_2_uprobe(node);
> +		if (node) {
> +			struct uprobe *uprobe = __node_2_uprobe(node);
> +
> +			/*
> +			 * A uprobe is inserted before it is prepared; do
> +			 * not hand it out until ->arch is usable.
> +			 */
> +			if (!test_bit(UPROBE_COPY_INSN, &uprobe->flags))
> +				return NULL;
> +
> +			/* Pairs with the smp_wmb() in prepare_uprobe(). */
> +			smp_rmb();
> +			return uprobe;
> +		}
>  	} while (read_seqcount_retry(&uprobes_seqcount, seq));
>  
>  	return NULL;
> @@ -1123,7 +1135,7 @@ static int prepare_uprobe(struct uprobe *uprobe, struct file *file,
>  	if (ret)
>  		goto out;
>  
> -	smp_wmb(); /* pairs with the smp_rmb() in handle_swbp() */
> +	smp_wmb(); /* pairs with the smp_rmb() in find_uprobe_rcu() */
>  	set_bit(UPROBE_COPY_INSN, &uprobe->flags);
>  
>   out:
> @@ -2743,23 +2755,6 @@ static void handle_swbp(struct pt_regs *regs)
>  	/* change it in advance for ->handler() and restart */
>  	instruction_pointer_set(regs, bp_vaddr);
>  
> -	/*
> -	 * TODO: move copy_insn/etc into _register and remove this hack.
> -	 * After we hit the bp, _unregister + _register can install the
> -	 * new and not-yet-analyzed uprobe at the same address, restart.
> -	 */
> -	if (unlikely(!test_bit(UPROBE_COPY_INSN, &uprobe->flags)))
> -		goto out;
> -
> -	/*
> -	 * Pairs with the smp_wmb() in prepare_uprobe().
> -	 *
> -	 * Guarantees that if we see the UPROBE_COPY_INSN bit set, then
> -	 * we must also see the stores to &uprobe->arch performed by the
> -	 * prepare_uprobe() call.
> -	 */
> -	smp_rmb();
> -
>  	/* Tracing handlers use ->utask to communicate with fetch methods */
>  	if (!get_utask())
>  		goto out;
> -- 
> 2.51.0
> 

