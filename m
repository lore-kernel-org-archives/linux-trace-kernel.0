Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9E112D1EA
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729592239; cv=none; b=iSHFtAyfCKoVeS59u78VeBBvk+KFzM1tRX53xvShQc25Wp2oaQJ57OKtV8bgYg1W3taxax0ss8sK1KbsYmnrz3KFzRDUioDG7JR/+bHpVkraQqSbIhj5xSkaGOmehSVY+bZx7erZ4FLYkhEiJt5qxVtVkcY5M/BqywgpvOYclGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729592239; c=relaxed/simple;
	bh=bLIudfZmAxXAigq2j2X8zHzH7CagXjYYlj/FnEzfAvw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNKnqUAwDJ73YXpf+PpCOXzwU4oA2hMtS30WJFFQNhX7XofpQSbqhwgauS52ih5bYn2lmdILSbnU3H6nTm0/dZ7A1JurP9cKM+wfcVgME9B3XfgqZw856BjYMC/6Frj24xptN8QdyVgEzMowL+rJB43Jnq8PWHm7fdZb+b1Cgpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E91C4CEC3;
	Tue, 22 Oct 2024 10:17:17 +0000 (UTC)
Date: Tue, 22 Oct 2024 06:17:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [bug report] ring-buffer: Limit time with disabled interrupts
 in rb_check_pages()
Message-ID: <20241022061714.4f293898@rorschach.local.home>
In-Reply-To: <d51fd42f-9fc7-4b0b-aae3-ee8bfd909d69@stanley.mountain>
References: <d51fd42f-9fc7-4b0b-aae3-ee8bfd909d69@stanley.mountain>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Oct 2024 12:09:47 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> Hello Petr Pavlu,

It's not Petr's fault, but mine.

> 
> Commit 1f1c2bc9d075 ("ring-buffer: Limit time with disabled
> interrupts in rb_check_pages()") from Jul 15, 2024 (linux-next),
> leads to the following Smatch static checker warning:
> 

>     1531         raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
>     1532         head = rb_list_head(cpu_buffer->pages);
>     1533         if (!rb_check_links(cpu_buffer, head))
>     1534                 goto out_locked;
>     1535         buffer_cnt = cpu_buffer->cnt;
>     1536         tmp = head;
>     1537         raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>     1538                 return;
>                          ^^^^^^
> You probably intended to delete this return?

He sent two patches where the second patch was a fix to mainline. I
asked him to reverse the order so I could send the fix to Linus, in
which he did. In the mean time I switched the order myself for testing
and broke it with this mistake. When he sent the update I took his
patches but accidentally tested and pushed the broken branch to
linux-next.

When Linus took the fix, Stephen Rothwell reported a bad merge between
next and Linus's tree. That's when I realized I had pushed the wrong
branch.

This is the broken branch. I already updated my for-next branch with
the correct commits and when Stephen syncs the linux-next tree, it
should be fixed.

-- Steve


> 
>     1539 
> --> 1540         while (true) {  
>     1541                 raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
>     1542 
>     1543                 if (buffer_cnt != cpu_buffer->cnt) {
>     1544                         /* The list was updated, try again. */
>     1545                         raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>     1546                         goto again;
>     1547                 }
>     1548 
>     1549                 tmp = rb_list_head(tmp->next);
>     1550                 if (tmp == head)
>     1551                         /* The iteration circled back, all is done. */
>     1552                         goto out_locked;
>     1553 
>     1554                 if (!rb_check_links(cpu_buffer, tmp))
>     1555                         goto out_locked;
>     1556 
>     1557                 raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>     1558         }
>     1559 
>     1560 out_locked:
>     1561         raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>     1562 }
> 
> regards,
> dan carpenter

