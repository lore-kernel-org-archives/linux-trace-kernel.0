Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4AB1482F5;
	Mon,  6 Jan 2025 22:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736201425; cv=none; b=VeiHyDZrdLKYzD1NFNfsDbWqniddVWld9mGITIrGD12SnYFwhWlDm0zzqOlKX46Iako76mFdIEjBXsljHgJ3CzgwWos3e6AIP7YIAW6IJJh0Ba1jdqxd7Xi9VylMst6O95E59Qpns/8RTinJWPKyJXtMQVtdQCUiwrDNZ8IW3B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736201425; c=relaxed/simple;
	bh=c92pLxmlZb48uVKCnMmJYJL3Yho+BDP+VdGwzw2kZCo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fpQuwu7AZMyp3lOeKzkCdskqgCBUReWHXjPL9BwRBzcPy5uI+z3FoQpsZ1jcZIFUgeUDtzXUP68YtgggBT2L1Cfhih9lilVrEvnuKLdmsflSp1jd9emk8i86NidgSVBJIDGQUj7H3MgKW/a7I3haoTylQUJpsQT1iuUeWyjwU+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC507C4CED2;
	Mon,  6 Jan 2025 22:10:23 +0000 (UTC)
Date: Mon, 6 Jan 2025 17:11:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: "mhiramat@kernel.org" <mhiramat@kernel.org>,
 "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linuxarm
 <linuxarm@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)"
 <prime.zeng@hisilicon.com>
Subject: Re: [PATCH 1/1] tracing: Support reading trace event format file
 larger than PAGE_SIZE
Message-ID: <20250106171150.4d3da6e5@gandalf.local.home>
In-Reply-To: <edd0ebb243684fc0a14e8974c8dabf8a@huawei.com>
References: <20250102174317.1594-1-shiju.jose@huawei.com>
	<20250106122204.0f16cb58@gandalf.local.home>
	<edd0ebb243684fc0a14e8974c8dabf8a@huawei.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Jan 2025 18:15:36 +0000
Shiju Jose <shiju.jose@huawei.com> wrote:

> >You see, it requires multiple reads to pull in an entire kernel pseudo file. None of
> >those reads are greater than PAGE_SIZE. Why should trace format files be any
> >different?  
> Thanks for the reply.
> Yes. I had a fix/workaround in the userspace rasdaemon with multiple reads like above
> as reported previously in the  following thread.  
> https://lore.kernel.org/lkml/3c9808a694d242cab35bab67602edebf@huawei.com/
> However thought a solution in the common kernel code for the format file
> may be better.  I will go ahead with the user space solution.

That would make it different than every other pseudo file in the kernel. I
rather not do that.

>  
> Also shared an information in the above thread about libtraceevent  __parse_event() does not
> return error when parse_format() fail with incomplete formt data, which resulted initialization for the
> trace event does not fail in the user space tool.

Hmm, can you send me the the format file that failed?

Just the output of "cat /sys/kernel/tracing/events/<system>/<event>/format"
will do.

-- Steve
