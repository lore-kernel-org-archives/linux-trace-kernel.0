Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A972320B;
	Sun,  3 Nov 2024 04:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730609751; cv=none; b=o5QsGLPnjJJBTBvMsmTzAQ3QKII+3y/Qi4kJelkiPKu7gX9oROD4eszT6IVXKtBendGLMg08tYBl5dx6c73WzQUIid6IP6I/WWy3czJU1vphZcCF7LyfvSemsDlrGrcTX+KqF1KpRJTP2s2mymPmQ5yvvVa2mlL6ebE9NWs66SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730609751; c=relaxed/simple;
	bh=+09uscfLel9NWsLsYgmtDzXrHUoiLefG41k8w3meA4E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PlhKZvagbE+GY8WSfeJIplz5icDelTN7Z0DTGGIwmpcRItP4U4U91wBNisDgpz15DQa7k5nK0gnWaz/Y1n3hkllmJLJDIBmn+JZ/xIHq2zj8zBLhBf4G+1KaGWLZWTzaoeuHXY8nyEPr9QOxCUcq/jF/wYtRtzDxAzjffAVP3HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UITFML6Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UITFML6Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0442BC4CECD;
	Sun,  3 Nov 2024 04:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730609751;
	bh=+09uscfLel9NWsLsYgmtDzXrHUoiLefG41k8w3meA4E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UITFML6YWTmQKugoWzmkCCU54RTz9pfe2Z+gTtjRRW0lnlQTeP4PlRbDUS5Fv+6/L
	 OJaIyQWeQv4FKt00bD1leamDtC4uUMFSi23xVAJ7tByCqpwSbxZhAIAJBbD5468XnQ
	 afRGR0dlz8IlnM7bakuXfSWgb5EdaKcEpVe7CsIbsUY27TaD/sNUQ19YtSqUhQalRb
	 59nredZ/s8EaB0VU5Or2jsaWvT6pjyw3sfV5uvvc1E55Qhm269FnWFg0GODsrR5g50
	 WBx+4OHkO9AA6aKh10tzbWXf27tMFmNYsGVA65/oEDwmqacCmqzroaC8pMgHXXDM7y
	 TF094RHQrEl0Q==
Date: Sun, 3 Nov 2024 13:55:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: Re-order struct uprobe_task to save some space
Message-Id: <20241103135548.0c19e1a1451e598c18d8c42f@kernel.org>
In-Reply-To: <a9f541d0cedf421f765c77a1fb93d6a979778a88.1730495562.git.christophe.jaillet@wanadoo.fr>
References: <a9f541d0cedf421f765c77a1fb93d6a979778a88.1730495562.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Nov 2024 22:13:33 +0100
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> On x86_64, with allmodconfig, struct uprobe_task is 72 bytes long, with a
> hole and some padding.
> 
> 	/* size: 72, cachelines: 2, members: 7 */
> 	/* sum members: 64, holes: 1, sum holes: 4 */
> 	/* padding: 4 */
> 	/* forced alignments: 1, forced holes: 1, sum forced holes: 4 */
> 	/* last cacheline: 8 bytes */
> 
> Reorder the structure to fill the hole and avoid the padding.
> 
> This way, the whole structure fits in a single cacheline and some memory is
> saved when it is allocated.
> 
> 	/* size: 64, cachelines: 1, members: 7 */
> 	/* forced alignments: 1 */
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only
> ---
>  include/linux/uprobes.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index dbaf04189548..c684a470477f 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -73,6 +73,9 @@ enum uprobe_task_state {
>  struct uprobe_task {
>  	enum uprobe_task_state		state;
>  
> +	unsigned int			depth;
> +	struct return_instance		*return_instances;
> +
>  	union {
>  		struct {
>  			struct arch_uprobe_task	autask;
> @@ -89,9 +92,6 @@ struct uprobe_task {
>  	unsigned long			xol_vaddr;
>  
>  	struct arch_uprobe              *auprobe;
> -
> -	struct return_instance		*return_instances;
> -	unsigned int			depth;
>  };
>  
>  struct return_consumer {
> -- 
> 2.47.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
