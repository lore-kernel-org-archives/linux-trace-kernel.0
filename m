Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE937242D78;
	Mon, 10 Nov 2025 23:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762817932; cv=none; b=jicLPxeaOjzJYSOhMfMyPxpf/Aq26fHVnRPnkhilbvEyd2V6BR2s7n/oQTdYZ+FnGlgi4fqKjlL4aKG+4yVTcD7X2YXGjHH3GuQld7IiSoXZ8oo0KkV0ncJyqLyySneAF5+QoaRiZD94WCuu0mYHdWHdikhLi/qxEMMO5Gdyefg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762817932; c=relaxed/simple;
	bh=TSiKRn8KXstGb+AC1BS5OZza7As7Vr2R+Z54KsY7zj4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jVAO6KadsE7gG/Xwn2DT9QLfNHbyXD3rAmupCbzjwZcemdqVNk3v2r4Ksa2irXhSqI/rspU/Iz6gobR2kE0boRCCWGKD7D7THnFlr/wAQ5E9PQy7poP1yl4YFD1y3VFPSkBy8rhsf3C6Cg7PfbtMB2php3tSctn0GweDIGZm+jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 49B441DFFD0;
	Mon, 10 Nov 2025 23:38:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 1D41A6000A;
	Mon, 10 Nov 2025 23:38:46 +0000 (UTC)
Date: Mon, 10 Nov 2025 18:38:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yongliang Gao <leonylgao@gmail.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Yongliang
 Gao <leonylgao@tencent.com>, Huang Cun <cunhuang@tencent.com>
Subject: Re: [PATCH] trace/pid_list: optimize pid_list->lock contention
Message-ID: <20251110183854.48b33b50@gandalf.local.home>
In-Reply-To: <20251015114952.4014352-1-leonylgao@gmail.com>
References: <20251015114952.4014352-1-leonylgao@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: jaoz51kcyaca59m77edasd36mqwscmrj
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 1D41A6000A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+xXfvQ1MzHszbnHM1kX5j0D6qEpKU6Vsk=
X-HE-Tag: 1762817926-346271
X-HE-Meta: U2FsdGVkX1+cz/SfyESL2m0HHcS8jBCFNg4dfoe62FGdyQKUUTk1w/Z8tAlarMUuFDOO2427OxKoAjd2RMirNZpXpoJCzNH0P2g7lLyhIxZB5I4E6l22nBAVCWRAB1Ok8C/FljCPHdzqUafoPRiIH5pppa4cmPTzhypaVCanvQhssBrTt4tHq2Wsrwn0Hk7yJvYlJO43w1UPAlEzPHRp7uoZu3Z42J+9hIgae4KCAn/TI57jLWWhD05WZWBf0/HLtudSqIYxPP2atPJYRVU3hNqqXwx3RCbO8wFmhWd6mWSPAWU04arQQY4Z2+OixD7SdF9rRg99Ply9vdFltE98usw7+KC/lkz2

On Wed, 15 Oct 2025 19:49:52 +0800
Yongliang Gao <leonylgao@gmail.com> wrote:

> diff --git a/kernel/trace/pid_list.c b/kernel/trace/pid_list.c
> index 090bb5ea4a19..62082a4f60db 100644
> --- a/kernel/trace/pid_list.c
> +++ b/kernel/trace/pid_list.c
> @@ -138,14 +138,14 @@ bool trace_pid_list_is_set(struct trace_pid_list *pid_list, unsigned int pid)
>  	if (pid_split(pid, &upper1, &upper2, &lower) < 0)
>  		return false;
>  
> -	raw_spin_lock_irqsave(&pid_list->lock, flags);
> +	read_lock_irqsave(&pid_list->lock, flags);
>  	upper_chunk = pid_list->upper[upper1];
>  	if (upper_chunk) {
>  		lower_chunk = upper_chunk->data[upper2];
>  		if (lower_chunk)
>  			ret = test_bit(lower, lower_chunk->data);
>  	}
> -	raw_spin_unlock_irqrestore(&pid_list->lock, flags);
> +	read_unlock_irqrestore(&pid_list->lock, flags);
>  
>  	return ret;
>  }

Unfortunately you cannot do this because this is called while holding the
task pi_lock and rq locks. In PREEMPT_RT() the read/write_lock_* turn into
mutexes.

Sebastian, is there any equivalent of raw_read/write_locks() that can be
used?

-- Steve
