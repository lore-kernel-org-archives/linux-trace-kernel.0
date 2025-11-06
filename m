Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D19346A1C;
	Thu,  6 Nov 2025 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451719; cv=none; b=RT5ZRGgyU34/TViRTKB1kWURBj59U7/9Yfdr6biGPsQ9ZTuHaeP3Tk2dZE8bufRpnzm/36wcaZMA4Wo5Xuffbg+FOYctXSslmIm14PYu1AdYJ7WW4oIDGzfR57cUveekrhvKzVkfnNi+LA2OWa7veB0P9zcbqWCRtSKAUa8XjrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451719; c=relaxed/simple;
	bh=7KUkVQB8fSg5lNPwuWJRy+7zUz4Nw0l+R3XZZVzbeuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptQKgbrQhm9F9eFY18s+l6+zfDjsRW1HcmVF+jKr38q4D+yAGNodWeDXtHYW63zhFnfVaQhfMzxt7KN/2CWSjXhpEnYDi2kTnUegwx5VgFvgmTys0FLAcvwN9hrDzkrEFnlzxIpXwIq21QQBD7qiBPqKmiGn+3wAIhGtgq03lRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=A9MKVjv0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="A9MKVjv0"
Received: from CPC-beaub-VBQ1L.localdomain (unknown [70.37.26.58])
	by linux.microsoft.com (Postfix) with ESMTPSA id 578BB201CEF1;
	Thu,  6 Nov 2025 09:55:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 578BB201CEF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762451717;
	bh=s8I0sLI/LF0Ojfue7NuHNcANa3hTqbnC59ycXy4XnX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A9MKVjv0/re99Op2lGwQBwlHYykXKVWUm44eV5x6f3Th6l3WTOIIS4tieMiH6xd/d
	 rMFAi1VZUh9MNO7uqWUeubsCjYYOWi+o338h9Bdirfrgcen8S6r0OvdbHXcD9mocuE
	 cLmA35fShoQHUg90uE5VQ4b6wFYPf39uch2s2/PA=
Date: Thu, 6 Nov 2025 17:55:13 +0000
From: Beau Belgrave <beaub@linux.microsoft.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] tracing: tprobe-events: Fixes for tprobe events
Message-ID: <20251106175513.GA174-beaub@linux.microsoft.com>
References: <176244792552.155515.3285089581362758469.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176244792552.155515.3285089581362758469.stgit@devnote2>

On Fri, Nov 07, 2025 at 01:52:05AM +0900, Masami Hiramatsu (Google) wrote:
> Hi,
> 
> Beau reported tprobe example in the document does not work on 6.17
> kernel.
> 

Thanks! I've applied this series locally and tested this. Everything
works well in our environment.

> 
> And found it forgot to set tuser->tpoint before calling
> tracepoint_user_register() which calls
> tracepoint_probe_register_prio_may_exist(tuser->tpoint).
> To fix that, I just moved the tuser->tpoint setting line
> right before tracepoint_user_register() call [1/2].
> 
> I also found another issue when I switched enable and disable[2/2].
> 

Thanks! I've validated no bad dmesg, etc. and can delete the tprobe
without issues after we disable it.

> I hope this report will help someone to do similar debug by tracing.
> 

I will reference this, it's very useful.

For the series:
Tested-by: Beau Belgrave <beaub@linux.microsoft.com>
Reviewed-by: Beau Belgrave <beaub@linux.microsoft.com>

Thanks,
-Beau
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (Google) (2):
>       tracing: tprobe-events: Fix to register tracepoint correctly
>       tracing: tprobe-events: Fix to put tracepoint_user when disable the tprobe
> 
> 
>  kernel/trace/trace_fprobe.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
