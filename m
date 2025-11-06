Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B042923B632;
	Thu,  6 Nov 2025 22:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468115; cv=none; b=oCEMKNQiBrK6YgEHc8vucWLk3wKdxSCjcg0PUTUVs9AU36opPwsoUAOVsO3ImrDOUt5MYygqJZLTzo3owMDgfd6hQrpze2CRnGbi+/V1u3Vyf4ml9r9poIbCmaQ5UCQRigQFlWzyAytSp2L9HCDql7oXjboBGRSQ4BsXzjNldTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468115; c=relaxed/simple;
	bh=vOasg1vu4TSAI/iaAWfwlVZOlX3SdhTIegJguJYs6sQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VADWNGZlPb65/1D6CnYAP6JN6XfcxX1Y2v7BakEwVEYNbGlwtlMK9Gj5o1xtrrcy2t+3neTYcJl5wXQLwgmUGQIMhg//rEppLxUdRcMkocVGiKWO+Gb8j0mWOiWvzga8i3mqqq962xlFu163xW4a0zH56eFLd1eGx2STl76VTws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYEuS70f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYEuS70f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C786DC4CEF7;
	Thu,  6 Nov 2025 22:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468115;
	bh=vOasg1vu4TSAI/iaAWfwlVZOlX3SdhTIegJguJYs6sQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RYEuS70fCfC04DY3wS8GsIv1D2SGndcdn0qdQT7XC8JXy18RAOwrCMI5nwNNV0IbI
	 5eYfWbUU6F0Ntf0cAwBhZ8Zfk9ckvhOJMrGmqqshhqeegepRL0XsZcc1DnOJQrRtje
	 DJ8ic3n4b3YShSntFBdI/EcDgcy96XOEOiIrhJHtJaxnpU15geXGrkWBZGO1g0uMzn
	 43uON7qw0dMwsHneCGdUOsAk9N2npNs5eiTmvP7JwRiUz1BPyiE5Z6gWacLTVRQxRB
	 foTwoxqFuh668pT8sd/jbVIrsXyC+6KDRuYDV8/ZaliiBe//yD8EhkKP4ZuLr70Wk9
	 ADELuiM6r3s0w==
Date: Fri, 7 Nov 2025 07:28:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] tracing: tprobe-events: Fixes for tprobe events
Message-Id: <20251107072831.0bab75f9f2f95dd6d5a025ba@kernel.org>
In-Reply-To: <20251106175513.GA174-beaub@linux.microsoft.com>
References: <176244792552.155515.3285089581362758469.stgit@devnote2>
	<20251106175513.GA174-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Nov 2025 17:55:13 +0000
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> On Fri, Nov 07, 2025 at 01:52:05AM +0900, Masami Hiramatsu (Google) wrote:
> > Hi,
> > 
> > Beau reported tprobe example in the document does not work on 6.17
> > kernel.
> > 
> 
> Thanks! I've applied this series locally and tested this. Everything
> works well in our environment.

Great!

> 
> > 
> > And found it forgot to set tuser->tpoint before calling
> > tracepoint_user_register() which calls
> > tracepoint_probe_register_prio_may_exist(tuser->tpoint).
> > To fix that, I just moved the tuser->tpoint setting line
> > right before tracepoint_user_register() call [1/2].
> > 
> > I also found another issue when I switched enable and disable[2/2].
> > 
> 
> Thanks! I've validated no bad dmesg, etc. and can delete the tprobe
> without issues after we disable it.
> 
> > I hope this report will help someone to do similar debug by tracing.
> > 
> 
> I will reference this, it's very useful.
> 
> For the series:
> Tested-by: Beau Belgrave <beaub@linux.microsoft.com>
> Reviewed-by: Beau Belgrave <beaub@linux.microsoft.com>

Thanks!


> 
> Thanks,
> -Beau
> > Thank you,
> > 
> > ---
> > 
> > Masami Hiramatsu (Google) (2):
> >       tracing: tprobe-events: Fix to register tracepoint correctly
> >       tracing: tprobe-events: Fix to put tracepoint_user when disable the tprobe
> > 
> > 
> >  kernel/trace/trace_fprobe.c |    7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
