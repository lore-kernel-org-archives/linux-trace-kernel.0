Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719233FC2;
	Wed, 19 Feb 2025 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739923828; cv=none; b=LOcSsc2JDaDhGT3y/IUwCCbjLYCL8apDv1jDQfcjZVazjmfltGrjpBL7yPxW2+KTSLjrJvoPCzTlHeTHrKZ4HGM/oqlxHuYLmGzWxhml92/Zkh1BeJzLtR9IHCsV8vtMk0/5hlSP+3SEMaeEV8d8UzrquxMow5O+A0f1HbRQPAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739923828; c=relaxed/simple;
	bh=9Vw4L/7bu0F9hyQfG+u+P+URLIF4Z1kuQHWvCRHBaWw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dO45d3S4DvrRVk+ja8dTn+gDtKFOG6B2gkqeKlz7QvjvrAfG+BQ+KN+cJ/ru7FHlO5GMZu4x/k+ZmO2WZlh7LINxO4wvtzOfDqtIsRCsHlz8tEBZXwVMI5lbcwVBwIHKlGAPSNOwxT9C5BtztUSmCp0jjwb/dMJkMSbsWe/ea5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGnuTuoU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGnuTuoU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5100BC4CEE2;
	Wed, 19 Feb 2025 00:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739923827;
	bh=9Vw4L/7bu0F9hyQfG+u+P+URLIF4Z1kuQHWvCRHBaWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cGnuTuoUcJcQ0hACXnT6oJePo3mAJfaDHmusTo/Z1YLcJRcVB1164Y18S7KBH0un4
	 a6qkC1zLra8fMBCvTclwukHf7SGpPv0DscD943iLriHcHDaWZi9YZAbkMQlorSoTyR
	 urS8iRXUxdF/UQ82p63ypN51SkKG/sk5PTAz+W+BPWURd0kJFwgGTcFVMZowlGy8Ho
	 5oKEH2XQGkS6bKHLk0Zq0egcogpJbzSGhE6/U5oPAJGs0hTwDd+hV2nk4renE+Aum7
	 WAtIG2rQi1VkGRRg+JkHO83ZaKIh0ykF09jC2ZLLHtYCpRWad95N4PlrVeCCq1fRS2
	 2/uT3axVAh8Lg==
Date: Wed, 19 Feb 2025 09:10:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/user_events: Don't use %pK through printk
Message-Id: <20250219091023.f17833aea92a3d90e1bbc7da@kernel.org>
In-Reply-To: <20250217-restricted-pointers-trace-v1-1-bbe9ea279848@linutronix.de>
References: <20250217-restricted-pointers-trace-v1-1-bbe9ea279848@linutronix.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 17 Feb 2025 14:16:12 +0100
Thomas Weißschuh <thomas.weissschuh@linutronix.de> wrote:

> Restricted pointers ("%pK") are not meant to be used through printk().
> It can unintentionally expose security sensitive, raw pointer values.
> 
> Use regular pointer formatting instead.
> 
> Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/

This is only for the kernel pointer, but the "uaddr" below means it
has a user space address. So I think this does not need to be applied.

Thank you,

> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>  kernel/trace/trace_events_user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 97325fbd62836f4fb477c4a2b2936eff544291ec..3effc6fce20e65a8077de5221eb69db04fb1a775 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -455,7 +455,7 @@ static void user_event_enabler_fault_fixup(struct work_struct *work)
>  	if (ret && ret != -ENOENT) {
>  		struct user_event *user = enabler->event;
>  
> -		pr_warn("user_events: Fault for mm: 0x%pK @ 0x%llx event: %s\n",
> +		pr_warn("user_events: Fault for mm: 0x%p @ 0x%llx event: %s\n",
>  			mm->mm, (unsigned long long)uaddr, EVENT_NAME(user));
>  	}
>  
> 
> ---
> base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
> change-id: 20250217-restricted-pointers-trace-a0fb12707ac6
> 
> Best regards,
> -- 
> Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
