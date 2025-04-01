Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88BB3594F;
	Tue,  1 Apr 2025 20:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743539891; cv=none; b=kA7Ihy59HYTUoM2HcAxvNeocO5QrgkyQlFFVlUi/X32iegHeMBfoYSdDnSwCP/3hEyp/Ehwe8d5mqQnJ01mg6QNVuz2cUAOAVP3uwcRC/BOn05NeGdF9F358bXjeKDSNdFtH0njxaA8PMbpNRQYqOgYjVcLMTx3olWvBMZAHdFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743539891; c=relaxed/simple;
	bh=vZTp+Qd528/dWyR7wM1PbVmz2cjypLMhlVHAlfveqoA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CkSvF0VUShQjhTtDBSWe0ir4LCqjNPhbd/OzM6vaFiX0LIXSdNn0p7AjRGD/ZZiDVPRTEU7j9yD7PX7/6ks36kzl1rcAgsPJ45KUjQGZ0rrKB451/PKFjPJOqn9gbiJBcTmeyOMDuHE1Q0pIwqk0o1n0j3uQ0l0HH7b6OUZdLVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216D1C4CEE4;
	Tue,  1 Apr 2025 20:38:09 +0000 (UTC)
Date: Tue, 1 Apr 2025 16:39:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Jann
 Horn <jannh@google.com>
Subject: Re: [PATCH v3 4/5] ring-buffer: Use flush_kernel_vmap_range() over
 flush_dcache_folio()
Message-ID: <20250401163910.256c3177@gandalf.local.home>
In-Reply-To: <20250401203332.072456470@goodmis.org>
References: <20250401202549.409271454@goodmis.org>
	<20250401203332.072456470@goodmis.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 01 Apr 2025 16:25:53 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

>  
>  static void
> @@ -7319,7 +7319,8 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
>  
>  out:
>  	/* Some archs do not have data cache coherency between kernel and user-space */
> -	flush_dcache_folio(virt_to_folio(cpu_buffer->reader_page->page));
> +	flush_kernel_vmap_range(cpu_buffer->reader_page->page,
> +				buffer->subbuf_size + BUF_PAGE_HDR_SIZE);
>  
>  	rb_update_meta_page(cpu_buffer);
>  

This patch actually fixes a bug (I need to update the change log).

The previous code only flushed a page. But if the sub-buffer size was 2 or
more pages, it would not flush the rest of the sub-buffer.

-- Steve
