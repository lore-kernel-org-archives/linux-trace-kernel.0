Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39FF213E6F;
	Fri, 10 Jan 2025 17:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736529933; cv=none; b=TPzaM4wg9+cia78NHiBZihgjB8OfnLT7kurEJHdcPs1J5jgHcyU72U7OCVY+1+RglU3cVJ9BZH8zcCPIBZWTDQB5mDaBSqvulVvU6PRdDHqwpoOzWHW1XElWepQxS9GTrIg6v3kv9zIbSzxjkyXYvblsMdGAjUWtiaUDtj6FeuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736529933; c=relaxed/simple;
	bh=g9XJdaMNTbG7yWk8MTUa1vhNm5DPDzlxoFFVasn9ikQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9/ApDoneB9xr7duMWNwWYP28VbbU/2Do9nzSo3bigCKIwE1zqrdCsIyCu5bQSDuby99s3IE9Up2syCkAESKMfJh++yIB8EwHn07hPE6XgGunlaO3Enz59oTY6H5sNEdUjSIhJa63KiuJwrxhndq+FTOoamhemJ1lC1Rcw+3bAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EAFC4CEE2;
	Fri, 10 Jan 2025 17:25:31 +0000 (UTC)
Date: Fri, 10 Jan 2025 12:27:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, david@redhat.com,
 vdonnefort@google.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: fix incorrect boundary check order
Message-ID: <20250110122707.119c6f41@gandalf.local.home>
In-Reply-To: <20250110162612.13983-1-aha310510@gmail.com>
References: <20250110162612.13983-1-aha310510@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jan 2025 01:26:12 +0900
Jeongjun Park <aha310510@gmail.com> wrote:

> If there is a case where the variable s is greater than or equal to nr_subbufs
> before entering the loop, oob read or use-after-free will occur. This problem
> occurs because the variable s is used as an index to dereference the
> struct page before the variable value range check. This logic prevents the
> wrong address value from being copied to the pages array through the subsequent
> range check, but oob read still occurs, so the code needs to be modified.

This is *not* a fix!

As this should never happen. The logic before it prevents it from happening.
The s is calculated from the same logic that calculates nr_pages. If s were
to be greater than nr_subbufs it is a bug!

> 
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  kernel/trace/ring_buffer.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 60210fb5b211..6804ab126802 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -7059,7 +7059,7 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
>  	}
>  
>  	while (p < nr_pages) {
> -		struct page *page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
> +		struct page *page;
>  		int off = 0;
>  
>  		if (WARN_ON_ONCE(s >= nr_subbufs)) {

Notice that there's a WARN_ON_ONCE() here. That means if this is true, the
code is buggy. User space should never be able to trigger this either.

That said, I'm not against the patch and will add it for the next merge
window. But I will modify the subject and change log to state that this
should never happen and if it does the code is buggy and needs to be fixed.
That this is just a clean up in case the code is buggy we can trigger the
WARN_ON() and not worry about an out of bounds hit. Something like:

 ring-buffer: Make reading page consistent with the code logic

 In the loop of __rb_map_vma(), the 's' variable is calculated from the
 same logic that nr_pages is and they both come from nr_subbufs. But the
 relationship is not obvious and there's a WARN_ON_ONCE() around the 's'
 variable to make sure it never becomes equal to nr_subbufs within the
 loop. If that happens, then the code is buggy and needs to be fixed.

 The 'page' variable is calculated from cpu_buffer->subbuf_ids[s] which is
 an array of 'nr_subbufs' entries. If the code becomes buggy and 's'
 becomes equal to or greater than 'nr_subbufs' then this will be an out of
 bounds hit before the WARN_ON() is triggered and the code exiting safely.

 Make the 'page' initialization consistent with the code logic and assign
 it after the out of bounds check.

-- Steve


> @@ -7067,6 +7067,8 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
>  			goto out;
>  		}
>  
> +		page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
> +
>  		for (; off < (1 << (subbuf_order)); off++, page++) {
>  			if (p >= nr_pages)
>  				break;
> --

