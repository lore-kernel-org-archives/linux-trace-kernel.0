Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684CA2727FD;
	Tue, 28 Apr 2026 20:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777407887; cv=none; b=OzOykboRI6NmC0iF14FVAp3z2+Ae2ZLUBC2WVfd3Mt+mc0Wl36UUAnqIcFCPxxR/9T4LhT1FNGWhzTJGvQQhZ3/wEAvp7ZyqLZYxGuuzuS1ZCoTEm3hBn1Rd/wJJyvUjT+KbzWKdMIvnnK37/pDbycAMN1F3EW9zqn8lcm+WZ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777407887; c=relaxed/simple;
	bh=BDVL5/ciNfMwj7HcrlKnIuhW/c+Lp5JBMUF802ulZbk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9FKWQyqthoXYFDjzlb9oC1LTCOqXcbcwga12Jnh345xlwCdLDjgMPXnrsmc3bmFc88VCJw2DH0Z/DtgLWtrOXUhyzOAeky1spg9a74IoXzqFWgZ0YKUHHAkfSQLggOgptO4s8ynkQz6NHIdD9mKORHT20jgEdp8jlqQSZbc9wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id AD8D88B78A;
	Tue, 28 Apr 2026 20:24:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 99FF720019;
	Tue, 28 Apr 2026 20:24:42 +0000 (UTC)
Date: Tue, 28 Apr 2026 16:24:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v18 7/8] ring-buffer: Cleanup persistent ring buffer
 validation
Message-ID: <20260428162457.1ca8c4b6@gandalf.local.home>
In-Reply-To: <177701357903.2223789.1327164275262010250.stgit@mhiramat.tok.corp.google.com>
References: <177701351903.2223789.17087009302463188638.stgit@mhiramat.tok.corp.google.com>
	<177701357903.2223789.1327164275262010250.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: p71hyz9fekbjacrm1rsynhwxw4oh7391
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 99FF720019
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19qottaY6YWkTiSZoZRzTvuj+Q3AbUx4Rc=
X-HE-Tag: 1777407882-289024
X-HE-Meta: U2FsdGVkX1+93qCyUXSei14/xjvmWhmSi2zjKopXHQge2cNxtuzOS9yAEjE1qfVnWxubjc9zdF+l9P8J+cQh3bYspGXBSo5hiCzjBWUWrNUgoTdbqspXjp9VJOyPcw7VDHFagx3KAyps8QNKd0iFU7GLx4VzIAT+94X0n9bO/nK3+FFvd1ZsZnm7JyeHPtio1zjRT2TUnj6I82gtQSqpnxuHTycPiSR9yBi0fwpXplzsmDKhVtdGuWRaP9+tCYXhzT1UEwC0jywfvLutaSubmYJ31jUdJ7841H8j3vU6dHZUkRACPUeww9Qd8ofLgdzKglgU9fu56tJvDKpVrnbeT/kKVB/h0S3/

On Fri, 24 Apr 2026 15:52:59 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Cleanup rb_meta_validate_events() function to make it easier to read.
> This includes the following cleanups:
>  - Introduce rb_validatation_state to hold working variables in
>    validation.
>  - Move repleated validation state updates into rb_validate_buffer().
>  - Move reader_page injection code outside of rb_meta_validate_events().
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/ring_buffer.c |  186 ++++++++++++++++++++++----------------------
>  1 file changed, 95 insertions(+), 91 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index de653a8e3cec..9850a0d8d24b 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1883,8 +1883,16 @@ static int rb_read_data_buffer(struct buffer_data_page *dpage, int tail, int cpu
>  	return events;
>  }
>  
> -static int rb_validate_buffer(struct buffer_page *bpage, int cpu,
> -			      struct ring_buffer_cpu_meta *meta, u64 prev_ts, u64 next_ts)
> +struct rb_validation_state {
> +	unsigned long entries;
> +	unsigned long entry_bytes;
> +	int discarded;
> +	u64 ts;
> +};
> +
> +static int __rb_validate_buffer(struct buffer_page *bpage, int cpu,
> +				struct ring_buffer_cpu_meta *meta,
> +				u64 prev_ts, u64 next_ts)
>  {

This can still use those comments (from patch 4).

Also, could you rebase on top of v7.1-rc1?

Thanks Masami!

-- Steve

>  	struct buffer_data_page *dpage = bpage->page;
>  	unsigned long long ts;
> @@ -1914,16 +1922,82 @@ static int rb_validate_buffer(struct buffer_page *bpage, int cpu,
>  	return ret;
>  }
