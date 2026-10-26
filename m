Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018841;
	b=NBt9ZLeXPUkF0Vj5iq5oWXx9KrHLgPokh/RWsw5HGpz6MRvCMCYqz0Rzw7WjzABl3pcy
	 taRwmrUxaGR3GKvnkl+Z4MR6YHrgJtuOxsPxSm3Vl6WWC/K1wjwt5fa0bKduLecXI0HJC
	 qzp0JJv7zEPQ112GD43k8chYhSL2CQccOhQl9t2kCs0rwUxA1EIg4UR7mFf8waJrcfjLQ
	 xWjUIG5reR1JtD/LaC7n+sak89GC8HN4baRkdGlrM0CR5xm1m9n13gPg/OzpgaVqibJAW
	 dwAAydqbIWpsjdrE7fOVsxcwxQdTKRtk/r+lItorE54dBZjKmixSq1vQJZ0gHMnRoag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018841;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=yYos0YalaElAervCmJhi1r/Xaz01TUSWztMqDf9OqM4=;
	b=xizeFopoPINdd88CPJIciSZyhspJkxhngyejIgnP0twn5uQBXdyfGHcmNTgBlNFTGouK
	 KF2xMiBBtT87ZRhbSpz3XN4zajMLiKymDRRGJm2jqHI+aM59VrEZuRpL4tmeHfY4QsC8f
	 aoBZpDjv8rRmrqsQ7hoWXfF//gT2YkLHkyLwOByEc8Ofx2MYWhNdfHTXlXvOdvlelaEVm
	 V93ueH0l9HsQWRf3a/a7hF+SmGbu30vWn2iaUlpn4gSOvrNIUUF1aUQ7Qnx7JTCWUKmX9
	 3ZbKLBZ1a8/EzpCo/SbDcoNEDMbtkZiWYFclCMZeerilF5EEYzQDCdh0EKGVt7h4GqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=yED8X1C8;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB59C606A322;
	Mon, 26 Oct 2026 12:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB59C606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=yED8X1C8
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 7A07F1C3D9F;
	Mon, 26 Oct 2026 12:47:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 6E15220024;
	Mon, 26 Oct 2026 12:47:10 +0000 (UTC)
Date: Mon, 26 Oct 2026 08:47:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Chaosheng Qu <quchaosheng000406@163.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: don't reference jiffies from writeback
 TP_printk()
Message-ID: <20261026084709.26f7737f@fedora>
In-Reply-To: <179299543891.294518.18224691820856958686@163.com>
References: <179299543891.294518.18224691820856958686@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 6E15220024
X-Stat-Signature: 5xy1sm6ayu4gcorstddm4yqkhrp1dfx1
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18U6B+tW+QsDwV4v8O9nKX/R9uKoOIiw+A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=yYos0YalaElAervCmJhi1r/Xaz01TUSWztMqDf9OqM4=; b=yED8X1C8Gd2U0+cQvs0Dij8iWwtlGoveC7hID45ZcS/3YrsSwuJiqSUazSNg6bRC8PsSdS98m3qj6o4/T4nz1BBI+ljNjixst4pqeEVloRUD2ozUOc4s31B6MRb7RL0d1oPDAomd04RcrIdMg3lVWghHaLz9p4t5PqaiuvcDtbA=
X-HE-Tag: 1793018830-124609
X-HE-Meta: U2FsdGVkX1/NdW0cv1l+jNawNKQzyW7SgL2iFEhgrkNJRpXcQsYRrF+o6UiS/BDGb8xUylosZ8TmIZH8T5bIcuiW+eAivbCeWEUzVH9YZa7PBj34yM8JRqUsuCAVT15aquNVRouwG00Fm1ggGV8wSqgR/9Mi0/aiaKekOZJm7SJi2M6Ipbivx7FMLCKn6SmaYMIGxh5QkM14/zVetO+2T4XJPUOePJxgh5qsgGHu4ee4KuWRQfre1Ownoc/naH4MhPImpt6VED80vuh1aFJbw4G//99ryqDnH5BLHMgI7eDtrDnf+L4/ZCQWSBN/I9LHJXU1jsTSlPV8YoWoCw8g8sTiW8r9GaGtwwRLVRUqZixrK8Wa3DGmU7kL3jLRh/y8ghg0NVEm8K8oD+SoDyTNspRId+3APtg/b21Oq6pJfbjOrBZQ/udXBnMmn0W1v5ekAoqaPVkyB+7nTYEevq+f8Ash/WB9Hk2o9GGPccyRYUERkKxZZy6tLV5xOLST2E73g+74Tdnypnq+NAAjt03dGJqGRgDlYBpswIRrMQpHRtk=

On Mon, 26 Oct 2026 14:17:18 +0800
Chaosheng Qu <quchaosheng000406@163.com> wrote:

> From: Chaosheng Qu <quchaosheng000406@163.com>
> Subject: [PATCH] tracing: don't reference jiffies from writeback TP_printk()
> To: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>,
>     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
>     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
>     Jan Kara <jack@suse.cz>,
>     linux-trace-kernel@vger.kernel.org,
>     linux-kernel@vger.kernel.org
> 
> writeback_sb_inodes_requeue and writeback_single_inode_start/() compute
> the inode age with:
> 
> 	(jiffies - __entry->dirtied_when) / HZ
> 
> inside TP_printk().  TP_printk() is not part of the recorded event: it
> runs when the trace is read back, so the expression is evaluated at
> formatter time, not at the time the event was recorded.  The formatted
> output therefore reports the interval between recording and reading,
> not the age of the inode when it was traced.
> 
> It is also evaluated outside of the kernel: tracefs renders the format
> string once and userspace re-evaluates it.  A tool that has to resolve
> every symbol in the expression (trace-cmd and the parser in LISA both
> do) resolves the bare "jiffies" to its address, so the printed age
> becomes ((unsigned long)&jiffies - dirtied_when) / HZ, which is
> nonsense.  This was reported as a wrong "age" value in trace-cmd
> output:
> 
>   https://bugzilla.kernel.org/show_bug.cgi?id=219839
> 
> Nothing in TP_printk() may depend on the state of the machine at read
> time, which is the same rule that keeps ktime_get() and friends out of
> it.  writeback_queue_io already does the right thing and stores the age
> in TP_fast_assign(); make these two events do that as well.
> 
> The new __entry->age field is appended after the existing fields, so
> no existing field changes offset and trace consumers that index the
> event by offset keep working.  The "age=%lu" placeholder keeps its
> position in the output text.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219839
> Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
> ---
>  include/trace/events/writeback.h | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> index 13ee076..23d107c 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -745,6 +745,7 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
>  		__field(u64, cgroup_ino)
>  		__field(unsigned long, state)
>  		__field(unsigned long, dirtied_when)
> +		__field(unsigned long, age)

Actually can we just record jiffies here?

>  	),
>  
>  	TP_fast_assign(
> @@ -753,6 +754,7 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
>  		__entry->ino		= inode->i_ino;
>  		__entry->state		= inode_state_read_once(inode);
>  		__entry->dirtied_when	= inode->dirtied_when;
> +		__entry->age		= (jiffies - __entry->dirtied_when) / HZ;

Divisions are expensive and this is executed during the trace where we
try to keep the trace side effects as small as possible.


>  		__entry->cgroup_ino	= __trace_wb_assign_cgroup(inode_to_wb(inode));
>  	),
>  
> @@ -761,7 +763,7 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
>  		  __entry->ino,
>  		  show_inode_state(__entry->state),
>  		  __entry->dirtied_when,
> -		  (jiffies - __entry->dirtied_when) / HZ,
> +		  __entry->age,

By saving jiffies, this would be:

		  (__entry->jiffies - __entry->dirtied_when) / HZ

Where it would be processed at the time of read (aka "slow path").

As jiffies would be saved in the event, user space would also be able
to calculate this.

-- Steve


>  		  __entry->cgroup_ino
