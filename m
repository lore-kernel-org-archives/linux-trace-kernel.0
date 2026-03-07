Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16743909BB;
	Sat,  7 Mar 2026 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772897247; cv=none; b=pFy9AX/ZhQOxZJPsG7IxpNyUuDTCEBuue/VkIRoDJC4ro3LW49FS0gpXhoYaGG5jynKk5IaEf85z131fxn4hnUsxkrXIGyN05aOAHmFF7L2C/6DcHLZi0aAat15I5tSfqfUmLIRfxZuMZ+i1Cg5uwU8izDlYzFceEGRbWfCgBqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772897247; c=relaxed/simple;
	bh=pbA4k9VXF6kYhNCSerEvrSGPLdH9ZfJsgprrePHhrhU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7oDTAxeghjiu4GGUGy+hc+MKDnI+PIma7uvMtKD/hD1EtblAP/1aq4zZypjYudJ35tMqur+ZTdZ05o1eK/2bCUEnJGqFQhWLXvCnxaFZYSUSyJtAt9JqqNyJDYahCu31CxJuBTpO5vO7RseJJCgt2oLo49IXz3rQCEIarO5xYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id BEF491A013C;
	Sat,  7 Mar 2026 15:27:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 1A56F33;
	Sat,  7 Mar 2026 15:27:17 +0000 (UTC)
Date: Sat, 7 Mar 2026 10:27:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] ring-buffer: Skip invalid sub-buffers when
 validating persistent ring buffer
Message-ID: <20260307102711.50932648@robin>
In-Reply-To: <177289359843.248514.164858607457269337.stgit@devnote2>
References: <177289358078.248514.14947007976699929481.stgit@devnote2>
	<177289359843.248514.164858607457269337.stgit@devnote2>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 1A56F33
X-Stat-Signature: pgmx1w55oodpph1fkj7f74rb8hb1ouak
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/nD/G1MJnMamnweFBj3bSjM5hBC/F/nkA=
X-HE-Tag: 1772897237-106659
X-HE-Meta: U2FsdGVkX18k/AvG8GAnYjjRLfcpkAXN1/yZ9+zGMEVTkE+WsWB1Pr6cU2XfpXFTjzZBgWBA0+deoxKVpWiVTlFk0fOEc6Ifpf4e4XpIeIRmumdfIqD9dcvaAVL5Hzc7wsBtxEuqfVjRNpT588wApG8VfVjcDkxj4aEfRHNU8PapOawsyPNHkj1N9zFAVLP5ZLCKg6xR+cJU9IGJ9ZIK22glY6YonNtwea/N501OGYSB+u9tqDrG8orUTOjbyTEykC3o5QisdoVqoBWzq3tFWVnf7/ayNn4Izor/IxC3xw2k4yDQ1TWg1X74NdZGi8c2lLXAv62iEBM8ZX2zCuNFkqSdeHzsOPYR

On Sat,  7 Mar 2026 23:26:38 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

>  kernel/trace/ring_buffer.c |   63 +++++++++++++++++++++++---------------------
>  1 file changed, 33 insertions(+), 30 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index b6f3ac99834f..8599de5cf59b 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -396,6 +396,12 @@ static __always_inline unsigned int rb_page_commit(struct buffer_page *bpage)
>  	return local_read(&bpage->page->commit);
>  }
>  
> +/* Size is determined by what has been committed */
> +static __always_inline unsigned int rb_page_size(struct buffer_page *bpage)
> +{
> +	return rb_page_commit(bpage) & ~RB_MISSED_MASK;
> +}
> +
>  static void free_buffer_page(struct buffer_page *bpage)
>  {
>  	/* Range pages are not to be freed */
> @@ -1819,7 +1825,7 @@ static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
>  
>  	bitmap_clear(subbuf_mask, 0, meta->nr_subbufs);
>  
> -	/* Is the meta buffers and the subbufs themselves have correct data? */
> +	/* Is the meta buffers themselves have correct data? */

I just realized that the origin didn't have correct grammar. But we
still check the subbufs, why remove that comment?

The original should have said:

	/* Do the meta buffers and subbufs have correct data? */

>  	for (i = 0; i < meta->nr_subbufs; i++) {
>  		if (meta->buffers[i] < 0 ||
>  		    meta->buffers[i] >= meta->nr_subbufs) {
> @@ -1827,11 +1833,6 @@ static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
>  			return false;
>  		}
>  
> -		if ((unsigned)local_read(&subbuf->commit) > subbuf_size) {
> -			pr_info("Ring buffer boot meta [%d] buffer invalid commit\n", cpu);
> -			return false;
> -		}

This should still be checked, although it doesn't need to fail the loop
but instead continue to the next buffer.

Also, I mentioned that if the commit == RB_MISSED_EVENTS, then we know
the sub buffer was corrupted and should be skipped.

And honestly, the commit should never be greater than the subbuf_size,
even if corrupted. As we are only worried about corruption due to cache
not writing out. That should not corrupt the commit size (now we can
ignore the flags and use page size instead).

So, perhaps we should invalidate the entire buffer if the commit part
is corrupted, as that is a major corruption.

-- Steve
