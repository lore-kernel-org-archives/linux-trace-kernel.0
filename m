Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65102580DE;
	Wed, 24 Dec 2025 20:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766608998; cv=none; b=C2Y/FMXugG1t619Xe7FlvFY5lCENg8pbHVo7f9VnzstHAwUyETSDQbymOaedoOK3drlkxR1j3hbf16bsD3iym4srGW9OX8L3ouAP3AsVmJCv1Y1865MCscXsLlOKYqfzEHjz0kYkGHExo9lwAHiXyzzb3+4/Pn40Y/3dknoNHAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766608998; c=relaxed/simple;
	bh=GQnpe2+5ZSMIYY9pMfawdM/bNw3xhk4JfCTB3kAQ3kw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aGwxumWdbIfG7YlktTrKGTUt8t7sAsANekTdd93TcuBdEEZodyYJvRsEMkM5jsUNsmu8NX5cerrC+7Aw1tdeAwKL+TELZRKC3XQB78oc3Qhmic9MzvNEzFV0+kehf9TOgf+ED79ddnKCnFrFkXoLV0HZi1qJx1zwhxVeXtZ8TfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 31A7C58EA0;
	Wed, 24 Dec 2025 20:43:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id E601380009;
	Wed, 24 Dec 2025 20:43:06 +0000 (UTC)
Date: Wed, 24 Dec 2025 15:44:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Tejun
 Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Frederic
 Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Replace use of system_wq with system_percpu_wq
Message-ID: <20251224133210.7b62ba5e@gandalf.local.home>
In-Reply-To: <20251224162000.141731-1-marco.crivellari@suse.com>
References: <20251224162000.141731-1-marco.crivellari@suse.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ifqoenecgmgq3ro6kywxuabn1dndx58k
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: E601380009
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+djofSNu05EBYfcS//jkNluPc36x5SlHI=
X-HE-Tag: 1766608986-794064
X-HE-Meta: U2FsdGVkX19ORhYbayY4cErkMT03zXV0te4ZAX4G+OpAF2xKqmSx2g2ekFAjo2PBOeO4XWGUVNvncTKoG5PhumaCA1VHpXGuE6w8QON/ycEiynuyi8QCBZAvToJnhpDsxTWoAB7EuZ83FXhBQetGJnM4K0vfc2IDXhibcjsvRdZ8CD9qOY2lzNRqNULr1EeBpZqUf7v0Tk2wKAWjbUMbY2jDIoO2qmjJBFXyeVywCPa8bvOc6GYtpcQZRtLnpTkxjkbgJ/K4hwLctKiWbMciWHy8iR8y+SDzH0xUBzD7xrUnMRkMrXQlSlIuKkMln/Mo+Xc2cIuf0K83FCq5lpBwfIKuy4TusFeKHQzS4d9z+Gp5sDlPoIDG3EfnkUsPYz+OPWe8Xl+giJWh1aMxFGdvMw==

On Wed, 24 Dec 2025 17:20:00 +0100
Marco Crivellari <marco.crivellari@suse.com> wrote:

> Before that to happen after a careful review and conversion of each individual
> case, workqueue users must be converted to the better named new workqueues with
> no intended behaviour changes:
> 
>    system_wq -> system_percpu_wq
>    system_unbound_wq -> system_dfl_wq
> 
> This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
> removed in the future.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  kernel/trace/trace_events_filter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index 385af8405392..bb6de1d38f78 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -1375,7 +1375,7 @@ static void free_filter_list_tasks(struct rcu_head *rhp)
>  	struct filter_head *filter_list = container_of(rhp, struct filter_head, rcu);
>  
>  	INIT_RCU_WORK(&filter_list->rwork, free_filter_list_work);
> -	queue_rcu_work(system_wq, &filter_list->rwork);
> +	queue_rcu_work(system_percpu_wq, &filter_list->rwork);

This is just garbage collection and has no need to be done on the CPU it
was queued on. I guess this can use system_dfl_wq?

-- Steve


>  }
>  
