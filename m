Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416AD2DEA95
	for <linux-trace-kernel@vger.kernel.org>; Sun, 17 May 2026 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779007751; cv=none; b=FAR8GAoPJPSxYNOKdKZnrnbmKTrijTQH1lYMs6NRe6JpAqq/cY8aSs9czPKcnNyEjAwJWN5a0tMLMB9eNikIU86JTD4D6T3rAvyb8bx4m0Jld/u/sazPTMXxW1rcxNIE1rW0ojCLGDgi+K++gLwAIUgUv50g/YEK+3yEE8D4yKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779007751; c=relaxed/simple;
	bh=xunHsTAdc5BMkSFoIywIxYA8MNTXjZyFHvSZp4BTFR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H//cQ/yRRyAPhk6gy2TiMYxkmzPFK/zc9Wt9fg2gjHIYe7H5E85hNueFkqXUDLcWCYoHvZS1oukDNB832I69LoqAKws5aISeB+Qeu3XlxN5BGTMd/OyTHzn5CtJ6SS1GDftnvVPdW2EnhsPJvfkhmWt4tJvUke/utIaFCuujgTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v07O2nIN; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v07O2nIN"
Message-ID: <1b983ed5-cb2d-4a86-9c23-320d4223ce4a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779007747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Me0/m97wgihx/YS8nKSTzQKcWUXgso3kkR8Du8e2q5I=;
	b=v07O2nINRoEtniFtupjPgHL8awdDYHtlau4iBuFLxxnh2Ea8sd5RVj6Rh+wjqVxgQgyUX9
	MROZm081N1H3G9E07ztmgmYEdV5t2exkDBvKZK5A3Jo6mn7s4QRExU7PPKkt2KxzuJxkul
	b0snlQyBJT88MxfAV74aKexRjH2sFPw=
Date: Sun, 17 May 2026 16:48:51 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/9] rv: Fix __user specifier usage in extract_params()
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Nam Cao <namcao@linutronix.de>,
 linux-trace-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>
References: <20260512140250.262190-1-gmonaco@redhat.com>
 <20260512140250.262190-2-gmonaco@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <20260512140250.262190-2-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


Correct.  __user annotates the pointer type, not the stack copy.

Reviewed-by: Wen Yang <wen.yang@linux.dev>


On 5/12/26 22:02, Gabriele Monaco wrote:
> The attributes variables extracted from syscalls in the helper are both
> defined with the __user specifier although only the actual pointer to
> user data should be marked.
> 
> Remove the __user specifier from attr.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202604150820.Ny143u6X-lkp@intel.com
> Fixes: b133207deb72 ("rv: Add nomiss deadline monitor")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   kernel/trace/rv/monitors/deadline/deadline.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/rv/monitors/deadline/deadline.h b/kernel/trace/rv/monitors/deadline/deadline.h
> index 0bbfd2543329..78fca873d61e 100644
> --- a/kernel/trace/rv/monitors/deadline/deadline.h
> +++ b/kernel/trace/rv/monitors/deadline/deadline.h
> @@ -95,7 +95,8 @@ static inline u8 get_server_type(struct task_struct *tsk)
>   static inline int extract_params(struct pt_regs *regs, long id, pid_t *pid_out)
>   {
>   	size_t size = offsetofend(struct sched_attr, sched_flags);
> -	struct sched_attr __user *uattr, attr;
> +	struct sched_attr __user *uattr;
> +	struct sched_attr attr;
>   	int new_policy = -1, ret;
>   	unsigned long args[6];
>   
