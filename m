Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA2830DD2F;
	Tue, 31 Mar 2026 01:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774921398; cv=none; b=cgnrllCO4G7WFwlXcZ+lx6dal+k8TAEv7oAaucn8zj07FYB+RSvM3i7m0/Yu44HSbDbDcMVe5dpiHvOz0wZ5W40VAEYbGeocgGcV63X2cceDDN7mcGcJpd49fqoEDHq8WdO4qid4ScpLbDIY6ygTJ1kTcCBiVwx8pBrtJl9IRE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774921398; c=relaxed/simple;
	bh=DkKghEXTvkuoAUKnz/L6+CM+9iswGKKMeh3dCg+qPMw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jKPxuqJo8y3Tb4KRGsrMOoDyvDWTHaJzi+8+W5P7gVPS0wgb6fesVhQ0/8KsdJAnc3BA7Q0FkH8UKzkRyB4iIRdIHFry1YtZAzGds+tlcl9oiyRnIcEVPHfx+QmrOb+IExCFhjq3UQCw72f9dzi6/Xd+azF2quK32gUmARwrkLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfQndXYb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfQndXYb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F028CC4CEF7;
	Tue, 31 Mar 2026 01:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774921397;
	bh=DkKghEXTvkuoAUKnz/L6+CM+9iswGKKMeh3dCg+qPMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rfQndXYbNrtaV6Ec+MhpRqFN/I/okFI2Yr2wLoNwUCd2XQiza/hnSo/sRXqJjQwc5
	 AUuAUPqZA0LHpJNCAU7jD1lj1SazwgAhGVyXvqr1wb3vmoWYN9YziuNaZuM/eJLXjR
	 bmmhk82+Dr03uBnTI9xCJF2Ug+Mm1dox3HFiyFS2/xuuTOnSQqipl5xKcyWXvzKcZY
	 IIvp1DSrsyec3puGpbKsKApIstYDOiGNR8G/ToZq6VRBfhpcRrud9lJn1k8TTO/Oik
	 X2tV8SvO68C+UqRDlsRm7a3f5dwM8GJL+EWJkLQ6UVXMdzNk6eSDa25xaPZwAdefxl
	 Mpdc8ztC64D9w==
Date: Tue, 31 Mar 2026 10:43:15 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>
Subject: Re: [PATCH v14 4/5] ring-buffer: Reset RB_MISSED_* flags on
 persistent ring buffer
Message-Id: <20260331104315.708238643b1aa257e642a07b@kernel.org>
In-Reply-To: <20260330143613.42fe5640@gandalf.local.home>
References: <177487498530.3463592.12715592581212799257.stgit@mhiramat.tok.corp.google.com>
	<177487501981.3463592.2886576368556755178.stgit@mhiramat.tok.corp.google.com>
	<20260330143613.42fe5640@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 14:36:13 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 30 Mar 2026 21:50:20 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Reset RB_MISSED_* flags when the persistent ring buffer is
> > validated at boot. Since these flags are used only in reading
> > process, such process should be stopped when reboot and never
> > be restarted. Thus, these flags are meaningless in the next
> > boot. Moreover, it can confuse the read process after reboot.
> 
> Is it meaningless on a second boot?
> 
> Let's say you have a crash, and there's an invalid buffer. On the next boot
> it is flagged as invalid with the RB_MISSED flag. But then you reboot again
> before looking at the buffer. The next boot will clear this flag. Now
> looking at the persistent ring buffer will not show any missed events.
> 
> Ideally, it shouldn't matter how many reboots are made. If the persistent
> ring buffer hasn't started again, it should always show the same output.

Hmm, OK. I'll drop this.

Thanks!

> 
> -- Steve
> 
> 
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v14:
> >    - Newly added.
> > ---
> >  kernel/trace/ring_buffer.c |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index e5178239f2f9..5049cf13021e 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -1903,6 +1903,7 @@ static int rb_validate_buffer(struct buffer_page *bpage, int cpu,
> >  		local_set(&bpage->page->commit, 0);
> >  	} else {
> >  		local_set(&bpage->entries, ret);
> > +		local_set(&bpage->page->commit, tail);
> >  	}
> >  
> >  	return ret;
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
