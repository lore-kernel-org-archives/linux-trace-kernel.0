Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F741231C91;
	Tue, 25 Nov 2025 19:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764100618; cv=none; b=CWPXgftSeckHV1yP6pXeiUhK0xVBb1uncgKtjqKfxiiVqNcBp8HlGAZUuy0TLA9eTvAyennf4cP94zVDE/ceIPUZe1v0DhjsFTuq84YXgT8nEWs6R9I20eUHrxle+rc6ydJybwJLdZy0tN7ZiaAJFJBfDW8Bcp0kXleP31rNd14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764100618; c=relaxed/simple;
	bh=0uOb+5xRXxDvFlrdddVfKia4CixTf65VgQM2KcclXu8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XxSNBZcLQM34FNGk/2JEidk4broRgZzfLJIbc1VXtHDoXl3ozTGfqFEpjv2XCF0FDqroRyIACXk6ske/iQ9KcwVE2K7WilVivQxuQt+p/I50q1fwEQDILVh0GnZfCuo8fLYz+RlMXfDRtz4nStj4Zw5jPVDhWyMBbTjylACfL5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id B9CF41604AA;
	Tue, 25 Nov 2025 19:56:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id E358A6000F;
	Tue, 25 Nov 2025 19:56:52 +0000 (UTC)
Date: Tue, 25 Nov 2025 14:57:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rv: Convert to use lock guard
Message-ID: <20251125145736.48c3ed9d@gandalf.local.home>
In-Reply-To: <dbefeb868093c40d4b29fd6b57294a6aa011b719.1763370183.git.namcao@linutronix.de>
References: <cover.1763370183.git.namcao@linutronix.de>
	<dbefeb868093c40d4b29fd6b57294a6aa011b719.1763370183.git.namcao@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 6rw9th4qkion9mj17s9zci5r6q4rteix
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: E358A6000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19M6gmPRhawM5X4IsJw5r9eWxJT7MYiUwI=
X-HE-Tag: 1764100612-972284
X-HE-Meta: U2FsdGVkX18i1MjAsb1259aTYoyx1xYe0/rY3qx0iGcN1dVeDRRdTlZoJmGtG0aaxAtXl1oZPN97IQ/d/C11pHj9wbyLd8pb7imogzJJrSZD1R9tgByMU87i1m9CrKk/D1n0U/3IXvLaBozSMoG3sQGOKBkKPG8Q59qnWLPStnhDvo92e1l1xDq9xZfVuXuMSPvtAyCwKc+szOqXy3XNDNvlR9I90j9rudBEQlYhjHP+1/CQT8qCJUhyR1+HnZErm2QyleWSoMcIDRKH02FQtSYICz73NgvSDCsNGz535VCHQ+3FDUOjGms+C5/tNh7C

On Mon, 17 Nov 2025 09:06:02 +0000
Nam Cao <namcao@linutronix.de> wrote:

> @@ -644,13 +640,11 @@ static ssize_t enabled_monitors_write(struct file *filp, const char __user *user
>  		else
>  			retval = rv_disable_monitor(mon);
>  
> -		if (!retval)
> -			retval = count;
> -
> -		break;
> +		if (retval)
> +			return retval;
> +		return count;

No biggy, but I wonder if this would look better as:

		return retval ? : count;

-- Steve

>  	}
>  
> -	mutex_unlock(&rv_interface_lock);
>  	return retval;
>  }
>  
