Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3337B166318;
	Fri,  5 Jul 2024 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720188676; cv=none; b=VByP6BXe6mizqEhadUPz0NY61NJabINVCrUH89GsM9xmsKukulEBOrkhpgQfW9E0VOU6jCgtfxfDklRF5r/I5+Cqc8zDAvHa0Tcaq8aLCcLsvAECkJEEY2Lhxih5D3XTcFt48GoY5PsPE18eFtUm35oEA9tbHpkQGabDnz9wnaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720188676; c=relaxed/simple;
	bh=cmxg5ruCVGuPgfqmaXJ7qSDhUCFW4nmmmBPwt4SCJCk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jgwZmRGIzt+96vTNCKb/dPwwY0ivfoSvl/N4ZkkdnpoWgQGD2dIdPJlmyjpOi/ETqJhYiBhlfT+RquSBrGIg4BEYg6QwgcoYn+UD9K0WjNnLx+10SIhLVf4Ghm4+P5lrLDWElqLpcGVWTwsnpQhcisDzG80KeJT8ROjVRKeAJeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJAlcLv9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJAlcLv9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A18CC116B1;
	Fri,  5 Jul 2024 14:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720188675;
	bh=cmxg5ruCVGuPgfqmaXJ7qSDhUCFW4nmmmBPwt4SCJCk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kJAlcLv9pTjPD704dyyX1GYUJ4z91JAlbS5d0dJBGIBAh4VVf0JsRQXqA7IHRHUTc
	 smb+GaPz/lCs+XaP4o06qlU3EnB4IEqlXciykZyMfckiavOrsM2TW6CUkDuq2PHbHJ
	 qwyufiKgKAOtQfSg03ZC/eoeQ3+U5Otm5tO/GqXu1P35xvBrwRYH1SUJxe8cRoKfop
	 OdPofT7rQUQhUuuvofO3P871q9JDnElGcTlOs9Ly4WehQdtuT+21111v65Q1eCudqu
	 dTzKd8SYSjlEFnI6Ht1r9KwNuJUGuQWx/9BCAD9iymrnkRQOgHpVwbvPXlOhy/J8Rs
	 1CiqtQ3N2zhgg==
Date: Fri, 5 Jul 2024 23:11:12 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Levi Yun <yeoreum.yun@arm.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] trace/pid_list: Change gfp flags in
 pid_list_fill_irq()
Message-Id: <20240705231112.4097fd46656778115acf7da1@kernel.org>
In-Reply-To: <20240704150226.1359936-1-yeoreum.yun@arm.com>
References: <20240704150226.1359936-1-yeoreum.yun@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jul 2024 16:02:26 +0100
Levi Yun <yeoreum.yun@arm.com> wrote:

> From: "levi.yun" <yeoreum.yun@arm.com>
> 
> pid_list_fill_irq() runs via irq_work.
> When CONFIG_PREEMPT_RT is disabled, it would run in irq_context.
> so it shouldn't sleep while memory allocation.
> 
> Change gfp flags from GFP_KERNEL to GFP_NOWAIT to prevent sleep in
> irq_work.
> 
> This change wouldn't impact functionality in practice because the worst-size
> is 2K.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

and 

Fixes: 8d6e90983ade ("tracing: Create a sparse bitmask for pid filtering")

Thank you,

> Signed-off-by: levi.yun <yeoreum.yun@arm.com>
> ---
>  kernel/trace/pid_list.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/pid_list.c b/kernel/trace/pid_list.c
> index 95106d02b32d..85de221c0b6f 100644
> --- a/kernel/trace/pid_list.c
> +++ b/kernel/trace/pid_list.c
> @@ -354,7 +354,7 @@ static void pid_list_refill_irq(struct irq_work *iwork)
>  	while (upper_count-- > 0) {
>  		union upper_chunk *chunk;
> 
> -		chunk = kzalloc(sizeof(*chunk), GFP_KERNEL);
> +		chunk = kzalloc(sizeof(*chunk), GFP_NOWAIT);
>  		if (!chunk)
>  			break;
>  		*upper_next = chunk;
> @@ -365,7 +365,7 @@ static void pid_list_refill_irq(struct irq_work *iwork)
>  	while (lower_count-- > 0) {
>  		union lower_chunk *chunk;
> 
> -		chunk = kzalloc(sizeof(*chunk), GFP_KERNEL);
> +		chunk = kzalloc(sizeof(*chunk), GFP_NOWAIT);
>  		if (!chunk)
>  			break;
>  		*lower_next = chunk;
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
