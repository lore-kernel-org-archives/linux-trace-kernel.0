Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ED0347503
	for <linux-trace-kernel@vger.kernel.org>; Sun, 17 May 2026 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779008519; cv=none; b=eQD4OX1I5qyEK3bLdDffZyvb2841/9ELLJ7tfVB4Uz061FCHxcgwGBV4PAm5OAzrSIlIxoxVf5wAFFJdJgwfl9nLt66FR+2Mh+y8AUjhpO7tEmg4E0//1ueGzTgnNB0PNjQMpEckxf8zZeMC8mPMY+ohQEL1noC18BHuJIvI2Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779008519; c=relaxed/simple;
	bh=urwAzaVqJKfgOTaz9GnRWF9UpklB4f9OH/+u350FeGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dC/IiR0op9Jjcwp95Pwwb/TdiOAsKgn8EA0wNQn2p9Qy3UkoR9rqAHlzqrahNqusE7z0po5Nmj1nL6plXJouKkju0tTWQxopoo++kIUsd3h0dJgZzjibBto8GjhK469HUL1v2+FopoVtRLi2GVu2zYY3+gzVrpHJbFvyPHluu6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lPZGp27P; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lPZGp27P"
Message-ID: <6053ea3c-b3b6-4e7a-a552-f6b8a8540e83@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779008505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNZWMHjOKrEtOEL6J4NmUPa43BCWI2IjllOETgJB2Pc=;
	b=lPZGp27PWueIplNjOuOqlhqWCT0nS8UdjCbUCe1TSymGEGTE3+sQkmLdCOB3+dqfJswOLu
	Bl8YFt2kGsCFjjVzug8STFM5xhB5YZhxewPNiN4Cx/TafQWCfUja58FZnP8xDv96QMaHhh
	Y2E+tSMSOrTdMGSBQahN8pAeCOpiwZQ=
Date: Sun, 17 May 2026 17:01:34 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 5/9] rv: Ensure all pending probes terminate on per-obj
 monitor destroy
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>,
 linux-trace-kernel@vger.kernel.org
References: <20260512140250.262190-1-gmonaco@redhat.com>
 <20260512140250.262190-6-gmonaco@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <20260512140250.262190-6-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


Correct for PER_OBJ: kfree() is called directly (not kfree_rcu()) after
hash_del_rcu(), so we must guarantee no concurrent reader holds a 
pointer to mon_storage.  tracepoint_synchronize_unregister() — which 
calls synchronize_rcu_tasks_trace() then synchronize_srcu  —
drains all in-flight probe handlers before the hash walk, making the
subsequent kfree() safe.


Reviewed-by: Wen Yang <wen.yang@linux.dev>



On 5/12/26 22:02, Gabriele Monaco wrote:
> The monitor disable/destroy sequence detaches all probes and resets the
> monitor's data, however it doesn't wait for pending probes. This is an
> issue with per-object monitors, which free the monitor storage.
> 
> Call tracepoint_synchronize_unregister() to make sure to wait for all
> pending probes before destroying the monitor storage.
> 
> Fixes: 4a24127bd6cb ("rv: Add support for per-object monitors in DA/HA")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   include/rv/da_monitor.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index a9fd284195ee..a4a13b62d1a4 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -515,9 +515,10 @@ static inline void da_monitor_destroy(void)
>   	struct hlist_node *tmp;
>   	int bkt;
>   
> +	tracepoint_synchronize_unregister();
>   	/*
> -	 * This function is called after all probes are disabled, we need only
> -	 * worry about concurrency against old events.
> +	 * This function is called after all probes are disabled and no longer
> +	 * pending, we can safely assume no concurrent user.
>   	 */
>   	synchronize_rcu();
>   	hash_for_each_safe(da_monitor_ht, bkt, tmp, mon_storage, node) {
