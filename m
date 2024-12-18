Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8CB156225;
	Wed, 18 Dec 2024 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527844; cv=none; b=P06IZUPUiSuTongqt4GQWhkevVV7Gdza5xwz0/VaKe0pv27RxXd3bjUwy+15X4Jh5XHtdMwyDj6crZqrpZsQsQkseGoBW7Pf2IlGDXiXeZ9v5f6IsDBkVHhQMiFYxqqMuOipfhGR3GGL88LC+osIKuTZ5sUdQFMJkbUJdjEKlas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527844; c=relaxed/simple;
	bh=nDtxIcUdvyI/ltjZ2KqovuX6yrx2/7dNovXbDvQWnCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aefd5o7dAlEZLfPWAnOdz46P0B6KzvpuV6N0ijfe504witwqEv+oKRfZohwZomX69lidFsD0lDlJ+XS+dQZ5I8kFuWpM+CQef4SXmmd7jOs3rIDrPOXKrVZeHX0H7x1/VeJYhgWYDuDr9H/u/rer4nukQNt7bVUVoPaP9fxeWhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EE5C4CEDD;
	Wed, 18 Dec 2024 13:17:22 +0000 (UTC)
Date: Wed, 18 Dec 2024 08:18:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: vdonnefort@google.com, aha310510@gmail.com, david@redhat.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
 syzbot+345e4443a21200874b18@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] ring-buffer: fix overflow in __rb_map_vma
Message-ID: <20241218081800.05d81fe4@gandalf.local.home>
In-Reply-To: <tencent_11A0A5D80DEC925EDDA2DDB8990F4FC88D07@qq.com>
References: <Z2KSR5QrAWYDEBVh@google.com>
	<tencent_11A0A5D80DEC925EDDA2DDB8990F4FC88D07@qq.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 19:42:22 +0800
Edward Adam Davis <eadavis@qq.com> wrote:

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 7e257e855dd1..20f0e01b7a50 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -7019,7 +7019,11 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
>  	lockdep_assert_held(&cpu_buffer->mapping_lock);
>  
>  	nr_subbufs = cpu_buffer->nr_pages + 1; /* + reader-subbuf */
> -	nr_pages = ((nr_subbufs + 1) << subbuf_order) - pgoff; /* + meta-page */
> +	nr_pages = ((nr_subbufs + 1) << subbuf_order); /* + meta-page */
> +	if (nr_pages < pgoff)

That probably should be <= as if it was equal...

> +		return -EINVAL;
> +
> +	nr_pages -= pgoff;

nr_pages would be zero and

>  
>  	nr_vma_pages = vma_pages(vma);
>  	if (!nr_vma_pages || nr_vma_pages > nr_pages)

this would return true, which the next line is:

		return -EINVAL;

Why not catch it before going through all that?

-- Steve


> -- 
