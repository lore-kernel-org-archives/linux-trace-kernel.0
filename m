Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08C0238C08;
	Sat, 31 Jan 2026 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769864177; cv=none; b=KSjut94YkEhQeEGx4MxV37mF6B1fki5r1R4w6touOyCwDzoJOx1tJcwW2eRu3sdIAZhw0x7OYp1PUUwcsJY2u3R6PRLmLeM5q1IMl0neyRHV1bn06/azUY5fiSCTMQuKV/SsrpubrqlwVEHiu04cjuALHMQ+T0FjOH8485EQFGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769864177; c=relaxed/simple;
	bh=C5lDUZktmav9yCLu+iZJPXkTDtUEiRWQkzJ6TmCmJTc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LOpDs52uEIMSzZKpLD9HxjKE+EKs0LZuJfhlkfKqPpPm06iZfNo5IN6TNLYl4BskPp1ZWnbhIzPHlG7aBhFCqH2n/xuGfwGjdKa+6u/ckkK2k1Cze3putpEufBhSyScv+1SqIbc06HDyfYWncS5eNLt9msrovkfdX/DLLzajEl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 04B7213BB00;
	Sat, 31 Jan 2026 12:56:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 2AA842000D;
	Sat, 31 Jan 2026 12:56:07 +0000 (UTC)
Date: Sat, 31 Jan 2026 07:56:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "jempty.liang" <imntjempty@163.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix duration calculation bug (rettime -
 calltime) on ARM architecture
Message-ID: <20260131075606.2e4b7042@robin>
In-Reply-To: <586de639.2489.19c13895e08.Coremail.imntjempty@163.com>
References: <20260130015740.212343-1-imntjempty@163.com>
	<20260130155548.0673f1f3@gandalf.local.home>
	<586de639.2489.19c13895e08.Coremail.imntjempty@163.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 2AA842000D
X-Stat-Signature: xxpyhyy7nuhy16dees5c8bd4mh833xyh
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/4WJDTH/KqU47jlShZisqBETKDttA5VoY=
X-HE-Tag: 1769864167-569738
X-HE-Meta: U2FsdGVkX186KEASG5PVG9jP4iH2pydidKGI4hcY5MHuUXUMk9SQS5CWTDa3GKFb8OwoP7gWvolAWl5dkVpIntLbPJwGyu/OQnlOHBrrY8ooU2w1IPvvUnIMXGw9txzzvj3NOrXyrXIHR+IKEwKt72QghuyVlj/JnvaKAcKwUJP20BHNzK9VqDd/1gEHp3T2lMKHI7mtxEIh+g43/TdS0WMno+z5JcRWoIEidcHUmAjexHCKiGbU2WVScuY3mYVxTgr12tqRLg0GndQe5FrkHNCCriJq/UPdN806t6HQ/YQDBJTTvIHU8zYfSToqtNwFlMIo5IAkQsE5GxLgPkW14XsrRT9a0Bqa

On Sat, 31 Jan 2026 18:08:41 +0800 (CST)
"jempty.liang" <imntjempty@163.com> wrote:

> >
> >How is this unique to arm? I'm not able to duplicate this on x86, but the
> >code here is all generic code. What's different?
> >    
> 
> You're right, this bug is only reproducible on ARM.  

You didn't answer my question. I understand that you said this only
impacts ARM. I'm asking you why does it only impact ARM? There's
nothing in this patch that is ARM specific? What is different about ARM
that makes this code have an issue where it doesn't have an issue with
x86?

>   

> >You show what the wrong output is and the correct output, but you
> >don't mention what was the bug and how this fixes it. From the
> >change log, it looks like you just tried something and it worked,
> >but do not know why it worked.
> >
> >I'd like to know what the bug was and how this fixes it. It's not
> >obvious.
> >    
> 
> Before the patch, do_open_execat had an abnormal execution duration
> of 2757369004 us (over 1 second); the patch resolves this and
> restores the function to a normal duration range.  

You still haven't answered my question. You are just telling me that
the patch fixes it but you do not tell me what in the code was wrong
and why the patch fixes it!

-- Steve
