Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A6F18FC83;
	Tue, 25 Feb 2025 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500995; cv=none; b=Iw1dBuGcmNbnzL35qEwcwiZsZTo5mgeRndMswer3Up1oBUMq8sVwUa1OO/31NIAAuhXytQoUNgebM5oDNvbdWGapM+pzjNTULI2QV3qYj16QdobM/fVY5JGL4WUIiXco0SjnH5KvU/yBHS72b4J1DbuA/VlSiQmARpwdQM3bn3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500995; c=relaxed/simple;
	bh=M6eCWP5N7NLqafofIMj1/gwTZwbYOxkJr165KE/TatM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEbnA4arFsOnH1c6WGKD1fEZyzDNntvDRKPmtXfAtra2HcIUDXxubT25PF/xwfXGlf9WgyNZsd2RTPwdf5jZ4AnsZTGXxQDo1oWhj/fJ9iRajE8n1jaHZewlT0fZSOZtBGPDMNgqVZDqBzoywk1GQ79f6Lm9Jbbgrc7TAsdNW4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B62C4CEDD;
	Tue, 25 Feb 2025 16:29:54 +0000 (UTC)
Date: Tue, 25 Feb 2025 11:30:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ran Xiaokai <ranxiaokai627@163.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 ran.xiaokai@zte.com.cn, yang.guang5@zte.com.cn, Wang Yong
 <wang.yong12@zte.com.cn>
Subject: Re: [PATCH] tracing/osnoise: Fix possible recursive locking for
 cpus_read_lock()
Message-ID: <20250225113032.5e01922d@gandalf.local.home>
In-Reply-To: <20250225123132.2583820-1-ranxiaokai627@163.com>
References: <20250225123132.2583820-1-ranxiaokai627@163.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Feb 2025 12:31:32 +0000
Ran Xiaokai <ranxiaokai627@163.com> wrote:

> @@ -2097,7 +2096,7 @@ static void osnoise_hotplug_workfn(struct
> work_struct *dummy)
>  		return;
>  
>  	guard(mutex)(&interface_lock);
> -	guard(cpus_read_lock)();
> +	cpus_read_lock();
>  
>  	if (!cpu_online(cpu))
>  		return;

This is buggy. You removed the guard, and right below we have an error exit
that will leave this function without unlocking the cpus_read_lock().

> @@ -2105,7 +2104,12 @@ static void osnoise_hotplug_workfn(struct
> work_struct *dummy)
>  	if (!cpumask_test_cpu(cpu, &osnoise_cpumask))
>  		return;
>  
> -	start_kthread(cpu);
> +	if (start_kthread(cpu)) {
> +		cpus_read_unlock();
> +		stop_per_cpu_kthreads();
> +		return;

If all you want to do is to unlock before calling stop_per_cpu_kthreads(),
then this should simply be:

	if (start_kthread(cpu)) {
		cpus_read_unlock();
		stop_per_cpu_kthreads();
		cpus_read_lock(); // The guard() above will unlock this
		return;
	}


But I still have to verify that this is indeed the issue here.

-- Steve


> +	}
> +	cpus_read_unlock();
>  }
>  
>  static DECLARE_WORK(osnoise_hotplug_work, osnoise_hotplug_workfn);
