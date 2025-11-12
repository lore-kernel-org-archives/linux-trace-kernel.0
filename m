Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C873931B11E;
	Wed, 12 Nov 2025 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762972183; cv=none; b=Ok0cl04HjqfWFQWEeSz4SrA8GMl1L6T9RvyxBEpKrVMUDGxgVtcgcv/3fQHIolnk9rYOSrdLpW0Q5rK6uIGN32ipq1KJwC3239kbHijEtryI5XNg7bPvsOSDAO9Jq5u8EVoiN7Wwc/kY8QlHpDnciNhVH/YSBS9Unl17uoKprBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762972183; c=relaxed/simple;
	bh=3utautM/I1JvEJAAbf+4rjrS0aJiSSOCpsXk7us/aJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eAonEimcnhtn+Dm9cX+kb7DfzRqC7iTEWoeUbkVyAKCwGW9/Fb+vg3wIOQp1VMqEj+YUWGA8s6BJpL7zEmi76SZXJNhw0yBAgM4WnoPMHGLRogNaUl46L3g9GXlTD6XG0e39vNbpB4inG/szgk2pv8Vn+A4rF70SwNf/Shp8LbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 00AC659DC6;
	Wed, 12 Nov 2025 18:29:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id D6F222000E;
	Wed, 12 Nov 2025 18:29:36 +0000 (UTC)
Date: Wed, 12 Nov 2025 13:29:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yongliang Gao <leonylgao@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, frankjpliu@tencent.com, Yongliang Gao
 <leonylgao@tencent.com>, Huang Cun <cunhuang@tencent.com>
Subject: Re: [PATCH v2] trace/pid_list: optimize pid_list->lock contention
Message-ID: <20251112132950.60a165f9@gandalf.local.home>
In-Reply-To: <20251112181456.473864-1-leonylgao@gmail.com>
References: <20251112181456.473864-1-leonylgao@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 84pj5zx7gpkheb4jsc96i8gxanm7sb6f
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: D6F222000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19pMuM56FwXwSkiKEKvUXe3kiOkGV1dz6U=
X-HE-Tag: 1762972176-932112
X-HE-Meta: U2FsdGVkX1+l0Pvk6Yn4iRM92dGnSiTjk7RpdIewBn6pmUd/xn2zETqRUBtnfIodVkk7Jcf+IpOb37V8mzLF2Pnr2TiO9A726yTiNg9/lKxUaMesEdrlQvw2xdJVRDtCNmV7TLo0SyJgJrbUuSsmHWogVKaIEn5rFW++WXdJHHyP516WbbcYp05+qVJOVuvguv3MmjniEjDw/hjSGqvgtPyCj0Ir7S9hhfueUf9bantCdNELM/W/5bevF4uIGJdb/liESJHZR0uZhA8waEbZNaU87IgL+dPEYUZcznD2EHK9IgnbYYe3Iauc6lF8aEw8z2OpN3TiqcV+Rb/aQRsR82vtdE8bpTvWHdGB9FktByFIYTSdHwzsFFEqSX1UACOX

On Thu, 13 Nov 2025 02:14:56 +0800
Yongliang Gao <leonylgao@gmail.com> wrote:

> @@ -271,7 +277,6 @@ int trace_pid_list_next(struct trace_pid_list *pid_list, unsigned int pid,
>  {
>  	union upper_chunk *upper_chunk;
>  	union lower_chunk *lower_chunk;
> -	unsigned long flags;
>  	unsigned int upper1;
>  	unsigned int upper2;
>  	unsigned int lower;
> @@ -282,27 +287,44 @@ int trace_pid_list_next(struct trace_pid_list *pid_list, unsigned int pid,
>  	if (pid_split(pid, &upper1, &upper2, &lower) < 0)
>  		return -EINVAL;
>  
> -	raw_spin_lock_irqsave(&pid_list->lock, flags);
> -	for (; upper1 <= UPPER_MASK; upper1++, upper2 = 0) {
> -		upper_chunk = pid_list->upper[upper1];
> +	do {
> +		unsigned int start_upper1 = upper1;
> +		unsigned int start_upper2 = upper2;
> +		unsigned int start_lower = lower;
> +		unsigned int seq;
>  
> -		if (!upper_chunk)
> -			continue;
> +		seq = read_seqcount_begin(&pid_list->seqcount);
>  
> -		for (; upper2 <= UPPER_MASK; upper2++, lower = 0) {
> -			lower_chunk = upper_chunk->data[upper2];
> -			if (!lower_chunk)
> +		for (; upper1 <= UPPER_MASK; upper1++, upper2 = 0) {
> +			upper_chunk = pid_list->upper[upper1];
> +
> +			if (!upper_chunk)
>  				continue;
>  
> -			lower = find_next_bit(lower_chunk->data, LOWER_MAX,
> -					    lower);
> -			if (lower < LOWER_MAX)
> -				goto found;
> +			for (; upper2 <= UPPER_MASK; upper2++, lower = 0) {
> +				lower_chunk = upper_chunk->data[upper2];
> +				if (!lower_chunk)
> +					continue;
> +
> +				lower = find_next_bit(lower_chunk->data, LOWER_MAX,
> +						    lower);
> +				if (lower < LOWER_MAX)
> +					goto found;
> +			}
>  		}
> -	}
>  
> +		upper1 = UPPER_MASK + 1; /* Mark as not found */
>   found:
> -	raw_spin_unlock_irqrestore(&pid_list->lock, flags);
> +		if (read_seqcount_retry(&pid_list->seqcount, seq)) {
> +			/* Retry if write happened during read */
> +			upper1 = start_upper1;
> +			upper2 = start_upper2;
> +			lower = start_lower;
> +			continue;
> +		}
> +		break;
> +	} while (1);
> +
>  	if (upper1 > UPPER_MASK)
>  		return -1;

Honestly, I wouldn't modify trace_pid_list_next(). It is simply used for
printing of the pids in /sys/kernel/tracing/set_*_pid files. It's not a
critical section, and it shouldn't affect scheduling like
trace_pid_list_is_set() does.

Just keep it taking the raw spin lock, as that will keep it from being
modified by the writers. It also keeps the code from becoming more complex.

-- Steve

