Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9431D31AF;
	Mon, 14 Oct 2024 22:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728944101; cv=none; b=u08qVQzLczRjysAiJPsgtxR6EbmtS6+lj+r1rJG+042rikl4PptWMMf5RGXoIukphU211h/tvWhZxdiqmOo/vI5RDlmd2E0fDIy6RAlDrxg1uH/xF5C4F8+BOI8psJG5Sjs7uWZBnCOKF8y6F19je83QDMbE8SlhpHVi+oEPMfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728944101; c=relaxed/simple;
	bh=THquEAFMdkA/EK7Fx8gsrWMTO8C47KvDDC1a5eqDEd8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIllJLNQzzIvDR7w8gsxBDNH6TKvEoSM7Dnxdj9V60YhlM4HcuO7/jv5RPBrlciaLCJ6H6YuQ1gCgc2YOQTfbPz4s88zC+5wIwb62r+y3v8u1rjfIdCT4dm6Dn3xknQPOqadTBvU+KfbraMjBKBSJMX3ojJbgqkd/waag1iYe6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4C3C4CECF;
	Mon, 14 Oct 2024 22:15:00 +0000 (UTC)
Date: Mon, 14 Oct 2024 18:15:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: Fix reader locking when changing the sub
 buffer order
Message-ID: <20241014181517.4cf0ad69@gandalf.local.home>
In-Reply-To: <20241014141554.10484-1-petr.pavlu@suse.com>
References: <20241014141554.10484-1-petr.pavlu@suse.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 16:14:16 +0200
Petr Pavlu <petr.pavlu@suse.com> wrote:

> The function ring_buffer_subbuf_order_set() updates each
> ring_buffer_per_cpu and installs new sub buffers that match the requested
> page order. This operation may be invoked concurrently with readers that
> rely on some of the modified data, such as the head bit (RB_PAGE_HEAD), or
> the ring_buffer_per_cpu.pages and reader_page pointers. However, no
> exclusive access is acquired by ring_buffer_subbuf_order_set(). Modifying
> the mentioned data while a reader also operates on them can then result in
> incorrect memory access and various crashes.
> 
> Fix the problem by taking the reader_lock when updating a specific
> ring_buffer_per_cpu in ring_buffer_subbuf_order_set().
> 
> Fixes: 8e7b58c27b3c ("ring-buffer: Just update the subbuffers when
> changing their allocation order") Signed-off-by: Petr Pavlu
> <petr.pavlu@suse.com>

I see you applied this on top of your cnt patch. Can you reverse the order
and add this patch first and then the cnt patch please.

This is a fix that needs to go up to mainline during the rc release. The
cnt patch is going into the next merge window.

> ---
> References:
> https://lore.kernel.org/linux-trace-kernel/20240715145141.5528-1-petr.pavlu@suse.com/
> https://lore.kernel.org/linux-trace-kernel/20241010195849.2f77cc3f@gandalf.local.home/
> https://lore.kernel.org/linux-trace-kernel/20241011112850.17212b25@gandalf.local.home/

BTW, it's also OK to add these as Link: tags in the commit message.

-- Steve


> 
> base-commit: 6485cf5ea253d40d507cd71253c9568c5470cd27
> prerequisite-patch-id: 0aa81c18abaac4990d14c431e12b9e91696aa053

