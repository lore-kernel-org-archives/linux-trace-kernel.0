Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7ED225D9;
	Thu, 25 Jul 2024 21:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721942080; cv=none; b=MNdE90aZsexfUjE67wcI1XEY59gk9DxexQh/sNH/GBCUc7aGzJysLbDFaWHQ56cAeKo3IkvjfR+QBF0BRYyPfcTaN4pL/qbSKp6yfPNWU8qpJQmmqR+MbQvZetucUc1b7yqAJoqbZqlj8S+fpFl/W/KF7PwuB1+Ljo/MH8WyDFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721942080; c=relaxed/simple;
	bh=NuLRowIVm+Fl0x9TYugEgL9W/RUQUOnDqgYa0XpoF0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SO8+WJfQPyD8ZD19EJqfTtEK+Hl3ozM9N0qPRcf0+fy7wDsBleNd6vzds9/bjJ7o8Sz9lH8L7zssq5Ymq00cZ31qvT8I16LCGt5pkMFBlFCskRtjFPeDWJje4WhcEJyHnkLMy3kmXxv8uwaDkzFJGT9SMuZFUDGOMiBjf6lTkQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE92C116B1;
	Thu, 25 Jul 2024 21:14:38 +0000 (UTC)
Date: Thu, 25 Jul 2024 17:14:59 -0400
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
Message-ID: <20240725171459.598d9500@gandalf.local.home>
In-Reply-To: <1b1b09fa-0064-429c-9f78-385119c5e691@grsecurity.net>
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
	<20240725161519.35fd3bd6@gandalf.local.home>
	<1b1b09fa-0064-429c-9f78-385119c5e691@grsecurity.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 22:41:23 +0200
Mathias Krause <minipli@grsecurity.net> wrote:

> > diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> > index 6ef29eba90ce..5fbfa1c885de 100644
> > --- a/kernel/trace/trace_events.c
> > +++ b/kernel/trace/trace_events.c
> > @@ -1627,12 +1627,14 @@ static int f_show(struct seq_file *m, void *v)
> >  
> >  static void *f_start(struct seq_file *m, loff_t *pos)
> >  {
> > +	struct trace_event_file *file;
> >  	void *p = (void *)FORMAT_HEADER;
> >  	loff_t l = 0;
> >  
> >  	/* ->stop() is called even if ->start() fails */
> >  	mutex_lock(&event_mutex);
> > -	if (!event_file_data(m->private))
> > +	file = event_file_data(m->private);
> > +	if (!file || (file->flags & EVENT_FILE_FL_FREED))
> >  		return ERR_PTR(-ENODEV);
> >  
> >  	while (l < *pos && p)
> > 
> >   
> 
> Nope, still the same splats.

Can you reshow the splats. Because I'm now confused.

destroy_user_event() which is under event_mutex calls
user_event_set_call_visible() with false, that will then call:

trace_remove_event_call() -> probe_remove_event_call() ->
 __trace_remove_event_call() -> event_remove() ->
 remove_event_from_tracers()

Where remove_event_from_tracers() loops over all the instances and will set
each of the file pointers flags associated to the event: EVENT_FILE_FL_FREED

Then it returns back to destroy_user_event() that would free the event.

The f_start() that was in your crash, with the new patch, should take the
event_mutex before referencing the event that was freed. And with that flag
being set, it should exit out.

Did you remove all the other patches before applying this one?

-- Steve


