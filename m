Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7552B34A77A;
	Fri,  5 Dec 2025 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947247; cv=none; b=TGz6kjia42EpPy4uu3y8kwL8dsFv2T24FqkYRVfzd/G3Bow/I6MqYE5h/QoFUNXWteq7JH0TQAcLQVuQ/sPOpDHnsC0pIkw1M3VUJEXlA0jd4iKpuNImN1mZlGQcCV1SpGPygKNCaxZcB+WhkPZfKm8uLBCZGs0ZL4lG+wSL78M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947247; c=relaxed/simple;
	bh=arbV+mzok06QGTLqt3FOzbPCjxEVUCX5BqniY6uhBKI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbJl+ayl5vz0ixRt6FlWXPtK7YyyGTN7M+me9BjfwhkYBMYW8L0kPg4bqe9U42NI98vknlxI7J+kDUSJIALDqGcCv1eAMF+BTGBQ305Hh0cxayblL+7X6c0Mbn1xFGk37q7SUsQEafNKEnLRC6nDJ9IeFcd6aCFog+UdniwzNH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 0358DB6D26;
	Fri,  5 Dec 2025 15:07:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id C713620026;
	Fri,  5 Dec 2025 15:07:16 +0000 (UTC)
Date: Fri, 5 Dec 2025 10:08:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "qingwei.hu" <qingwei.hu@bytedance.com>
Cc: naveen@kernel.org, davem@davemloft.net, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: Call check_ftrace_location() on
 CONFIG_KPROBES_ON_FTRACE
Message-ID: <20251205100823.28aa8ffd@gandalf.local.home>
In-Reply-To: <20251205092933.3889547-1-qingwei.hu@bytedance.com>
References: <20251205092933.3889547-1-qingwei.hu@bytedance.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: C713620026
X-Stat-Signature: ok4dzduhba57eqthpzpb5paszrhn6dpt
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18y0d4pQ3VDQgOWOlSoVP/GSk5Wai9PxZY=
X-HE-Tag: 1764947236-773391
X-HE-Meta: U2FsdGVkX1/79ntXtNAOAbX5gbd7lwpmYA4S8WCenPpBquQHWEaSoSryZuu6My93wsCFRsVMGO8njWj7vSQjLuVzP7HZpE33ZWAo/KBSCOgGd9Q9Riuvqq9J+Ss3xV3tR5vR/bFuaYqgwAMSyflniHcB1n6D40+oAni7Vp/8cjUuXd3mf9dVbntC4llcJhe7O1qe20YVje1ZnO7maSTizkxFgyxZKoSwLTY6g8fWKtbB62pLALt7tRPf3tjMRz8AiWqSB/kwy9Miim62n8emPXsi1WGZptvb6Ys9CyPN3+1uOoH832/mnnVhSOCnNteWLfJMWC0JSqQtKU2L0suiCRIuY8jufO30

On Fri,  5 Dec 2025 17:29:33 +0800
"qingwei.hu" <qingwei.hu@bytedance.com> wrote:

> From: Qingwei Hu <qingwei.hu@bytedance.com>
> 
> There is a possible configuration dependency:
> 
>   KPROBES_ON_FTRACE [=n]
>        ^----- KPROBES [=y]
>          |--- HAVE_KPROBES_ON_FTRACE [=n]
>          |--- DYNAMIC_FTRACE_WITH_REGS [=n]
>                 ^----- FTRACE [=y]
>                   |--- DYNAMIC_FTRACE [=y]
>                   |--- HAVE_DYNAMIC_FTRACE_WITH_REGS [=n]
> 
> With DYNAMIC_FTRACE=y, ftrace_location() is meaningful and may
> return the same address as the probe target.
> 
> However, when KPROBES_ON_FTRACE=n, the current implementation
> returns -EINVAL after calling check_ftrace_location(), causing
> the validation to fail.

This is a feature not a bug.

The reason is if you put a kprobe on a ftrace location, it can cause ftrace
to trigger a bug, as kprobes will modify the location and ftrace will see
something it doesn't expect and think the system is corrupted. We don't want
that either.

If you say "KPROBES_ON_FTRACE=n" and place a kprobe on a location that is
controlled by ftrace, it had better fail!

NAK

-- Steve
