Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31EA42A92;
	Tue, 28 Jan 2025 05:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738043097; cv=none; b=JwBbuTrnHR02R0GcbnGhVy6O+xn0bcWoTnC30j2BjNDvvMJGFPNiIIkgLocD44N8S/+LhjmCFeh/zAUDzDaQsx1WxDylR/FhU66pE0hzA5e+9igjOyIH7K/rcZvyYwvPloNWfp+357Up88hnb+p+bqKrGAKYhePnC7FIr+JmIQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738043097; c=relaxed/simple;
	bh=RQ5Vm02lAX8S3oz05O/5pdpSi3XMSRWelAXlLTjanxQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PZzsXM5qkv0QnWIWpoS8J6YmFYUPdBGMdXHJE6dDirvRjpuHnkYvwrJQxbsJTswYXT70nLIHOiewokYgAKhDtxvil7rbimJwsaxwsh6nFsRstKHoy9VKplOi9st+8GbZHssfgRpiACjOmvd6k6lZ/Qkhjw2itGtFBHBFhroZ/68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuCWUiPV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuCWUiPV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B83C4CED3;
	Tue, 28 Jan 2025 05:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738043096;
	bh=RQ5Vm02lAX8S3oz05O/5pdpSi3XMSRWelAXlLTjanxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PuCWUiPV5YW0WuZS2+3GnWvMujL3mIMCLO8/cUoYCW69EQCWMTL1zrLevzsyEf1hN
	 My+usQcVbA9ctcxcpGKkmSZ2PEBSqZ/Uy2NNqPt3WuKu8kU1PmWMnpYuFCNQwJ5XTT
	 zoB+y3InDoE3hzLrxLHZLQWPB16hXE8qnXAMPjJGyXuidSoqwujBsFNmdJoVdyGqfk
	 HiCndxuSwzDJMH+T83fJLBQIM4y1iKGbfX8j+AIBdwhBkBJU0YR+BfI1arqHZy6BBY
	 KPRwlaOw9y4KIOOtD5eLBKo+IKzUu8vRz7mFXGX6NITI4Mn5tXzi3taAsknqz98M+s
	 a1H//LfS8Jtyw==
Date: Tue, 28 Jan 2025 14:44:52 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel
 Gomez <da.gomez@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>,
 "Paul E . McKenney" <paulmck@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Naveen N Rao <naveen@kernel.org>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 26/28] kprobes: Use RCU in all users of
 __module_text_address().
Message-Id: <20250128144452.fb5f9741e58f059c7cdf4ce9@kernel.org>
In-Reply-To: <20250108090457.512198-27-bigeasy@linutronix.de>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
	<20250108090457.512198-27-bigeasy@linutronix.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 Jan 2025 10:04:55 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> __module_text_address() can be invoked within a RCU section, there is no
> requirement to have preemption disabled.
> 
> Replace the preempt_disable() section around __module_text_address()
> with RCU.

Hi,

Since the below cleanup has been merged, this patch needs to be updated.

https://lore.kernel.org/all/20241121-kprobes-preempt-v1-1-fd581ee7fcbb@linutronix.de/

(may need to change the guard(preempt)() -> guard(rcu)() in the new version.)

Thank you,

> 
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Naveen N Rao <naveen@kernel.org>
> Cc: linux-trace-kernel@vger.kernel.org
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/kprobes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index b027a4030976a..22e47a27df4aa 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1566,7 +1566,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
>  	if (ret)
>  		return ret;
>  	jump_label_lock();
> -	preempt_disable();
> +	rcu_read_lock();
>  
>  	/* Ensure the address is in a text area, and find a module if exists. */
>  	*probed_mod = NULL;
> @@ -1612,7 +1612,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
>  	}
>  
>  out:
> -	preempt_enable();
> +	rcu_read_unlock();
>  	jump_label_unlock();
>  
>  	return ret;
> -- 
> 2.47.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
