Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E514327A36;
	Thu, 11 Sep 2025 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601651; cv=none; b=dZ/NrkaTpkARebIqlkXlXqJlAYgHUjbboQSrljS2zp+D9iE4V3e5qIiHx6lCVZrN3AnDTLAx8LZNWn4b3m7LHB3ltoLsWC/sVRhAH/0Ij4hj0PrnUox9mq3byxWNp9wc2dLZfkPj6nCtu8NvKd7tRrlwsYrADMNIZnyTExScHfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601651; c=relaxed/simple;
	bh=hOsnU96Duj7H4bPDhf52O/jlQhb37T2g9azDqZMBjWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K3KvboCF+MA6DEcEEVVryBNBEwtgl597o0PNj/zYqNOKEnIfemyMLx75Xsas40x5OJeiy9rvndMXC8GLU6LL11gr/+T9R374ksHYUFPCHiojZxfxZHPlBgD1N6D+UcuOAd7APDlB5LXSp4u4uUQALtJLPS2T0b5DI6vdtMKjghw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id B789214021E;
	Thu, 11 Sep 2025 14:40:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 03B0E80012;
	Thu, 11 Sep 2025 14:40:45 +0000 (UTC)
Date: Thu, 11 Sep 2025 10:41:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vladimir Riabchun <ferr.lambarginio@gmail.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Fix softlockup in ftrace_module_enable
Message-ID: <20250911104138.2830f60b@gandalf.local.home>
In-Reply-To: <aMLPm__QGrQCwz1t@vova-pc>
References: <aMLPm__QGrQCwz1t@vova-pc>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: hi6f91d6okink33npqhpi3e7caan7557
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 03B0E80012
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+OOMtyr7KDu/cgNi/2DzXP8bE2weFBwgw=
X-HE-Tag: 1757601645-820143
X-HE-Meta: U2FsdGVkX19ZShW5iPu+9iFzhpbRyHXteCdIPZGoi0/VqS5aVBfzITW1SLiALf/hghAVjavrpChJyB7VLo64KWK+Xd5L83Vrh0HP1UB/RFVc6A8DuITunnZ7FY2WmHz5SxouPd2OPHD+baJpikvArBJu3IlQden+hjeGnd7+m+0NuIHb60QtkfrmTmJAjLL5vsC77y2xBew9ZeGR/Vhg1bNx6Wc3+dPkjhjbE0jMvVpdmuIo+ZwNNW77h1ZtWMVwrt8uMxGFTvucOh2cMj+uYgBJ4Aw6ujRwf8bwFylYN3+3yhMAGTi6XveDn1ssGwDc6TdWNtH8bqhO8nTxlIl8pHrioMDok+CZ

On Thu, 11 Sep 2025 15:33:15 +0200
Vladimir Riabchun <ferr.lambarginio@gmail.com> wrote:

> A soft lockup was observed when loading amdgpu module,

I'd like to see more about that soft lockup.

> this is the same issue that was fixed in
> commit d0b24b4e91fc ("ftrace: Prevent RCU stall on PREEMPT_VOLUNTARY
> kernels") and commit 42ea22e754ba ("ftrace: Add cond_resched() to
> ftrace_graph_set_hash()").

The above cond_resched() is in the loop of all records that actually look
at all records! And that can be pretty big. On my server, it shows on boot:


[    1.934175] ftrace: allocating 45706 entries in 180 pages
[    1.934177] ftrace: allocated 180 pages with 4 groups

That means the loop will go through 45,706 entries. That's quite a lot and
a cond_resched() makes perfect sense.

> 
> Fix it the same way by adding cond_resched() in ftrace_module_enable.
> 
> Signed-off-by: Vladimir Riabchun <ferr.lambarginio@gmail.com>
> ---
>  kernel/trace/ftrace.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index a69067367c29..23c4d37c7bcd 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -7526,6 +7526,9 @@ void ftrace_module_enable(struct module *mod)
>  
>  	do_for_each_ftrace_rec(pg, rec) {
>  		int cnt;
> +
> +		cond_resched();
> +
>  		/*
>  		 * do_for_each_ftrace_rec() is a double loop.
>  		 * module text shares the pg. If a record is

This loop is different. Let me show a bit more context:

	do_for_each_ftrace_rec(pg, rec) {
		int cnt;
		/*
		 * do_for_each_ftrace_rec() is a double loop.
		 * module text shares the pg. If a record is
		 * not part of this module, then skip this pg,
		 * which the "break" will do.
		 */
		if (!within_module(rec->ip, mod))
			break;

See this "if (!within_module(rec->ip, mod))" break?

Look at the dmesg output again, and you'll see "groups" mentioned.

[    1.934177] ftrace: allocated 180 pages with 4 groups

That "4 groups" means there are 4 "page groups". That's the "pg" in the
do_for_each_ftrace_recr() function.

This means in my scenario, it loops 4 times. And then it will loop through
each module.

How big is the amdgpu driver? How many functions does it have?

 # grep amdgpu /sys/kernel/tracing/available_filter_functions | wc -l

And I'm guessing that this is only an issue when ftrace is enabled:

		if (ftrace_start_up && cnt) {
			int failed = __ftrace_replace_code(rec, 1);
			if (failed) {
				ftrace_bug(failed, rec);
				goto out_loop;
			}
		}

As that could slow things down.

If this is all the case, then the cond_resched() should be with the
ftrace_start_up code and not in the open like you have it.

		if (ftrace_start_up && cnt) {
			int failed = __ftrace_replace_code(rec, 1);
			if (failed) {
				ftrace_bug(failed, rec);
				goto out_loop;
			}
+			cond_resched();
		}


-- Steve
