Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE65391849;
	Mon, 29 Jun 2026 20:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782766164; cv=none; b=giGJjFN/6ppQxUCQx9vEVJQre4kjQsqhirh8kvbhJ047DqCkkdTNFJZISYhDCqBfk5guP8ZoIFa5sgNSLiMb5bWbDSvnIjiM+aiDpib9htX3rZOBEX0caBX+fXEx9wYTI2v16CuTYArqTW82raAc+ol0UL00Aq7RbzL6G3ot82w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782766164; c=relaxed/simple;
	bh=3buh7oZFwiZVQDIywocE9CPhFpDoj+HNeE4CEXi/K+E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcnYvkZLRNXgPCByD6DUDTwc4D51ahiCOZ4hgsczFirVlxJrf9xi5Fbi+z229eM05UK3Tj6sg1xxL7fa3aZAJgrm2gEm1kknb+NUn3oJhahMR2RN4MMBCRCAQ6Wde/ho70ca+4oeyqFtaCAJw7tetlX/XW5F068pfQ0UP2Svicc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id D1E03120266;
	Mon, 29 Jun 2026 20:49:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 014A42002B;
	Mon, 29 Jun 2026 20:49:13 +0000 (UTC)
Date: Mon, 29 Jun 2026 16:49:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Michal =?UTF-8?B?S291dG7DvQ==?=
 <mkoutny@suse.com>
Subject: Re: [PATCH 2/2] tracing: Keep pid and comm[] in the same structure
Message-ID: <20260629164912.4c1c2855@robin>
In-Reply-To: <20260626212356.64150-3-david.laight.linux@gmail.com>
References: <20260626212356.64150-1-david.laight.linux@gmail.com>
	<20260626212356.64150-3-david.laight.linux@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 014A42002B
X-Stat-Signature: b8zxd6rxr3cqksg8nbd17otof5kzqswg
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18T7JwCVgpGy1U1bg1+3gT1zO/0s7dyR5k=
X-HE-Tag: 1782766153-343907
X-HE-Meta: U2FsdGVkX1/uQfIeK1XUCTmlWn+VEG+A6XHiye6TFRJ0F4d9JXfqUSER0CU/HgF7D7MOuEL04OaD60AeMkRWJejRkgZ6/VnvIIGXKQw+I4IjyjWjwOyY2JvNA14SnmhCpAvvE5IFmYqWZbArXS0plsbErA8C5EZDdA0Jm/aSi48BW58MuKk3XIpNfqztcUAfrMmCK9wNAEOhQC5DR7gq8YzzAtVXdYjDDLXdTT107s546EI75tzgFEotnpux/gQFSOE3Ue7TEI5zJnnCBQKaTnuCOIJheSkbP+/rbAzYKZv/1d782AISYMkchptaoW06xYXe+0tg+HO6Qo2QCvLqf72JFQyvZBaO

On Fri, 26 Jun 2026 22:23:56 +0100
David Laight <david.laight.linux@gmail.com> wrote:

> Rather than have two separate dynamic arrays on the end of struct
> saved_commandlines_buffer have a single dynamic array where each
> entry contains the pid and associated task->comm[].
> This simplifies the initialisation and lookup.
> 
> Don't bother trying to initialise the pid field no a non-zero value,
> it only matters in the tracing_saved_cmdlines_seq_ops code.
> Allocate entry [0] first so that the tracing_saved_cmdlines_seq_ops
> code can just index the array with the file offset.
> 
> The code now uses the correct size when determining the page 'order'
> to free the structure. The smaller size will always give the same
> 'order'.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
> 
> Is there any reason why this code uses alloc_pages() rather
> than vmalloc()?

It's been a long time since I worked on this, but IIRC, it was to keep
the pressure down on the TLB when tracing. It updates at every
sched_switch that has a trace event occurring so, I likely used normal
pages which are part of the huge pages the kernel sets up and doesn't
affect the TLB as much. vmalloc does have impact on the TLB pressure,
and tracing should always try to avoid that.

> map_pid_to_cmdline[] is 64k*sizeof(int) so the whole structure
> expands to 512k with about 64k/20 (about 3200) pid entries even
> though the default is 128.

That's because it is not dynamic. That array needs to be able to hold
most PIDs. The default is 128 but it will expand to how much it can
hold to allocate the full map_pid_to_cmdline. The real default for 4098
page sized architectures is 6552 entries.


> AFAICT there is only one copy of the data - so it could be static.
> Perhaps with pointers to map_pid_cmdline[] and (after this patch)
> pid_comm[], both of which could be separately resized.

map_pid_t_cmdline[] is to hold the PID_MAX_DEFAULT amount of PIDs to
avoid collisions. I wouldn't resize it.

> 
> I also noticed that map_pid_to_cmdline[] contains indexes into
> pid_comm[], restricting these to 16bits would half the data area.

Hmm, yeah, this could be useful, as it doesn't appear one could make
saved_cmdline_size greater than 65536 (or even close to that).

-- Steve
