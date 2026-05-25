Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F8D35F176;
	Mon, 25 May 2026 07:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779694935; cv=none; b=fFTnBbDf5Esk+0J+4HsP+FL6BBLE2YoLKg7sRM8sq4RLGoF4yrC051sHSHDzJjywqJwMMNzUeDrgnXmCHwTJir+aQiRiPCkc+f7SZYAoTdaVT75c9m75duBQmoq59y2ssbTfEHd96J+JdeXJ4z1l6DSHMaDjP+FMmPrXJyv48F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779694935; c=relaxed/simple;
	bh=+TsowpuRsJjZdi7I22rXF2At1FHq7x7ywmoFLnxf8Bw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EX8fv3d3zxQ+zFLgo7k/tsscNJxq5OJMAetKpXDVMgy3CbEQWshVp65FrQjLiMXodn9UccwYzU2nmjnh8YRhI7bblHWU6U3oLgFWx7UXDlo+jCBMP760DGJRApsSSebBzg0sl5sYgDHAOOPyrMyl6cLCE+DjW0KFQHAjJSXTLYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFft0hiu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFft0hiu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51601F000E9;
	Mon, 25 May 2026 07:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779694934;
	bh=L558L5fMhloLKzPhL5jojU5DJVC8L4SgH80TH9Qemx4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KFft0hiuyWrJHe1lplGUqooVRG1QvxC6ke4nPOp4+tXijzj4w4lQzJ8axVEaos45e
	 9nhboBgrbSR4dBGU/EIqbn6sMCQLP9DlzUY+AHKpSF7YgpdRbydkpBmkqZ95SS9d1j
	 VoG9s0vLBlTkEmZD3qymrB4x949bPSlv2pKK4xaVter5/9ctzVyHMLU2wKn3FSZmk4
	 Y65zBo5/6qnqlL5rIg+bn5ThAggJR9KOWAjGhdoHZ7F9o7oISuaIbUNrZe/cUg9eXh
	 6mLweh6/0TFAM4XmSkLcuGTJ2E6R90R66fTxEos0+ugXf96Ds+5fEVpKp5t8WKN3Un
	 ijhgGsTpV25Aw==
Date: Mon, 25 May 2026 16:42:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yash Suthar <yashsuthar983@gmail.com>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] tracing: Replace BUG_ON with lockdep_assert_held in
 uprobe_buffer functions
Message-Id: <20260525164210.9885d1eef078547290ead1df@kernel.org>
In-Reply-To: <20260521181601.77ce38e6@gandalf.local.home>
References: <20260521192846.8306-1-yashsuthar983@gmail.com>
	<20260521181601.77ce38e6@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 18:16:01 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 22 May 2026 00:58:46 +0530
> Yash Suthar <yashsuthar983@gmail.com> wrote:
> 
> > Replace BUG_ON(!mutex_is_locked(&event_mutex)) with
> > lockdep_assert_held(&event_mutex) in uprobe_buffer_enable() and
> > uprobe_buffer_disable().
> > 
> > BUG_ON() will crash the kernel. mutex_is_locked() only checks
> > if any task holds lock,but not the caller task. lockdep_assert_held()
> > also check current task for lock and no crash on true condition.
> > 
> > Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
> 
> This looks good to me.
> 
> Acked-by: Steven Rostedt <rostedt@goodmis.org>
> 
> Masami, do you want to take this?

Yeah, let me pick this.

Thanks!

> 
> -- Steve
> 
> > ---
> >  kernel/trace/trace_uprobe.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > index 2cabf8a23ec5..aee0960d0cf7 100644
> > --- a/kernel/trace/trace_uprobe.c
> > +++ b/kernel/trace/trace_uprobe.c
> > @@ -912,7 +912,7 @@ static int uprobe_buffer_enable(void)
> >  {
> >  	int ret = 0;
> >  
> > -	BUG_ON(!mutex_is_locked(&event_mutex));
> > +	lockdep_assert_held(&event_mutex);
> >  
> >  	if (uprobe_buffer_refcnt++ == 0) {
> >  		ret = uprobe_buffer_init();
> > @@ -927,7 +927,7 @@ static void uprobe_buffer_disable(void)
> >  {
> >  	int cpu;
> >  
> > -	BUG_ON(!mutex_is_locked(&event_mutex));
> > +	lockdep_assert_held(&event_mutex);
> >  
> >  	if (--uprobe_buffer_refcnt == 0) {
> >  		for_each_possible_cpu(cpu)
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
