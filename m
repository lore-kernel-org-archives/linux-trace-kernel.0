Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D3134B404
	for <linux-trace-kernel@vger.kernel.org>; Sun, 17 May 2026 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779007912; cv=none; b=PSNoyb+j6LuQCSuXupA7rSk1z2BZi7Gu5PvTrB7hboOwa7/4GfgRovhmT3maZjLPtP7kWq/tf4c3QuAS/7taTwM1Wgg0PWDp3hNZ/ZpbjgyV4EGqg2Gr4Iq0A+TU3hkNNm3jQyuFmd5/4ABH/7S4IspmBm0R08/c6+05v9JW+/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779007912; c=relaxed/simple;
	bh=tX/M/DJ2NZZ4tuPQLBZXibWnbi+uo0nEqTFui0air9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oCFMQWppIvRyGkw/xPhkcnzVpBYdYA9MNYcvmLrMkgrsv+zmGJzLoA4xB5FN6z2iVdaLRh1MYy383YQ1lJaqO7aW3Mneles6ozLDfrND0M0f0DLK4Kwfh0XcK3YMS0RQr6XfI+XRVmOXF6cmvzPjusbpdSAjgoGN/r4RBPWeN+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MYl3Umwv; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MYl3Umwv"
Message-ID: <123c3df7-806a-482b-be99-711b98db9938@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779007899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZpQZTSS4LwHof9qie2EFyqMFqFRIN+EVi5CAsxCpks=;
	b=MYl3Umwv9ugMFYZVX2IQcdTqL/QK2sY1Yl8AHxRAzE0+A/kz/okGL3VCq09oL67ee3qZA8
	BIhN6w4xX/IsiYYOtXB/mcChdRvk8Tk0FQAIwp4AZaG2i8iLR2oez/y8VfPPkb9MW1oCKg
	BXqwS8XPNLl12UxekFDZmsD0ZJ6YcRo=
Date: Sun, 17 May 2026 16:51:27 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/9] rv: Fix read_lock scope in per-task DA cleanup
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>,
 linux-trace-kernel@vger.kernel.org
References: <20260512140250.262190-1-gmonaco@redhat.com>
 <20260512140250.262190-3-gmonaco@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <20260512140250.262190-3-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


Correct.  tasklist_lock is only needed to guard 
for_each_process_thread(); idle tasks are bound to their CPU and are not 
subject to exit/reparent, so no lock is needed for for_each_present_cpu().


Reviewed-by: Wen Yang <wen.yang@linux.dev>


On 5/12/26 22:02, Gabriele Monaco wrote:
> The da_monitor_reset_all() function for per-task monitors takes
> tasklist_lock while iterating over tasks, then keeps it also while
> iterating over idle tasks (one per CPU). The latter is not necessary
> since the lock needs to guard only for_each_process_thread().
> 
> Use a scoped_guard for more compact syntax and adjust the scope only
> where the lock is necessary.
> 
> Fixes: 30984ccf31b7f ("rv: Refactor da_monitor to minimise macros")
> Fixes: 8259cb14a7068 ("rv: Reset per-task monitors also for idle tasks")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   include/rv/da_monitor.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index 39765ff6f098..250888812125 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -272,12 +272,12 @@ static void da_monitor_reset_all(void)
>   	struct task_struct *g, *p;
>   	int cpu;
>   
> -	read_lock(&tasklist_lock);
> -	for_each_process_thread(g, p)
> -		da_monitor_reset(da_get_monitor(p));
> +	scoped_guard(read_lock, &tasklist_lock) {
> +		for_each_process_thread(g, p)
> +			da_monitor_reset(da_get_monitor(p));
> +	}
>   	for_each_present_cpu(cpu)
>   		da_monitor_reset(da_get_monitor(idle_task(cpu)));
> -	read_unlock(&tasklist_lock);
>   }
>   
>   /*
