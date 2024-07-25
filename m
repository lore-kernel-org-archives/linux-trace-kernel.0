Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216D711711;
	Thu, 25 Jul 2024 20:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721938501; cv=none; b=OwyevQRZO1tR4j6926ZrhImH6N9JAqZsTHRpF9zTObzcCn0Xzz07/4rqm1X5+lzZ0bzMgBTxO129Zv7CH0W373g+MI2mpUKSw4kYyR6AQQbiFe0pFYmUlt5YVe9cIsdDptwRGCB+94og4RBd+4dtF+WIsKGdeBPhw3yzsu3iXC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721938501; c=relaxed/simple;
	bh=NF2RIxo1fJp8yqecDhIOyEG8HypVCg/sr20j0WVp5hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dG3PSdeQg033Yc9AvBGHBeWqcRaXbxUq06QHuPAdTAXwlCixWq1R1Eme5hhh51Cv/jC6RMiKpNHKx3wbHMqoSTnLE54fxvb3+q6OCEnQsR9PTYINWAX+ZJJwhVURmBMXTHqWrn17mcNXfCHfsUyx+RBRG8FAKHe8zAFXMe3DrdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E24DC116B1;
	Thu, 25 Jul 2024 20:14:58 +0000 (UTC)
Date: Thu, 25 Jul 2024 16:15:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathias Krause <minipli@grsecurity.net>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Ilkka =?UTF-8?B?TmF1bGFww6TDpA==?=
 <digirigawa@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al
 Viro <viro@zeniv.linux.org.uk>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@leemhuis.info, Dan Carpenter
 <dan.carpenter@linaro.org>, Vasavi Sirnapalli
 <vasavi.sirnapalli@broadcom.com>, Alexey Makhalov
 <alexey.makhalov@broadcom.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Beau Belgrave <beaub@linux.microsoft.com>
Subject: Re: tracing: user events UAF crash report
Message-ID: <20240725161519.35fd3bd6@gandalf.local.home>
In-Reply-To: <0d1a8c46-43a7-42d6-bcbf-647a5a68c3c5@grsecurity.net>
References: <20240719204701.1605950-1-minipli@grsecurity.net>
	<CAD2QZ9bDcQ46jOAc_Hxy6sG5-N5RPxw4zPuLK6R+M_GhxZR+=g@mail.gmail.com>
	<5083301c-6dc9-45c9-8106-da683ac6bfbb@grsecurity.net>
	<CAD2QZ9ZxZ+mjfju2JMw3fPATNNWkqT1p97QxXgeGo54AFzQ-Cw@mail.gmail.com>
	<CAD2QZ9bTrQ1p3zTZOXe6Gk4Xq8kjYSziAYAdbTrvRSZzAGPY9A@mail.gmail.com>
	<CAD2QZ9YAzq3jq8CyAcoG9YuMD9XWHbk3jKxAmszuSkJ3mtGoGw@mail.gmail.com>
	<20240725131021.788374d0@gandalf.local.home>
	<20240725131632.64cab267@gandalf.local.home>
	<cff51d4b-80eb-4587-b4ad-bfe7d7361b19@grsecurity.net>
	<20240725150517.3184e078@gandalf.local.home>
	<0d1a8c46-43a7-42d6-bcbf-647a5a68c3c5@grsecurity.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 21:42:41 +0200
Mathias Krause <minipli@grsecurity.net> wrote:

> Right. But the point is, that 'event_call' is really some '&user->call'.
> With 'user' being free'd memory, what gives? Dereferencing 'event_call'
> is UB, so this function is doomed to fail because it cannot know if its
> only argument points to still valid memory or not. And that's the core
> issue -- calling that function for an object that's long gone -- the
> missing refcounting I hinted at in my first Email.

Ah, I missed that the call was part of the user structure. But I think I
found the real fix.

> 
> > 
> > Where it calls the ->class->get_fields(event_call);
> > 
> > that calls this function. By setting:
> > 
> > 	user->call.get_fields = NULL;
> > 
> > this will never get called and no random data will be accessed.  
> 
> As 'user' is free'd or soon-to-be-free'd memory, that's a non-starter.
> 
> > 
> > That said, I was talking with Beau, we concluded that this shouldn't be the
> > responsibility of the user of event call, and should be cleaned up by the
> > event system.
> > 
> > Here's the proper fix:
> > 
> > diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> > index 6ef29eba90ce..3a2d2ff1625b 100644
> > --- a/kernel/trace/trace_events.c
> > +++ b/kernel/trace/trace_events.c
> > @@ -3140,8 +3140,10 @@ EXPORT_SYMBOL_GPL(trace_add_event_call);
> >   */
> >  static void __trace_remove_event_call(struct trace_event_call *call)
> >  {
> > +	lockdep_assert_held(&event_mutex);
> >  	event_remove(call);
> >  	trace_destroy_fields(call);
> > +	call->get_fields = NULL;

Actually, this is wrong as it would be: call->class->get_fields, and this
is not the right place to clear it, as class can be used by multiple calls.

> >  	free_event_filter(call->filter);
> >  	call->filter = NULL;
> >  }
> > 
> > Can you try it out?  
> 
> I can try but I don't think that's the proper fix for above reasons, I'm
> sorry.

I believe the issue is that f_start() needs to check if the event file has
been freed.

New patch:

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 6ef29eba90ce..5fbfa1c885de 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1627,12 +1627,14 @@ static int f_show(struct seq_file *m, void *v)
 
 static void *f_start(struct seq_file *m, loff_t *pos)
 {
+	struct trace_event_file *file;
 	void *p = (void *)FORMAT_HEADER;
 	loff_t l = 0;
 
 	/* ->stop() is called even if ->start() fails */
 	mutex_lock(&event_mutex);
-	if (!event_file_data(m->private))
+	file = event_file_data(m->private);
+	if (!file || (file->flags & EVENT_FILE_FL_FREED))
 		return ERR_PTR(-ENODEV);
 
 	while (l < *pos && p)


-- Steve
