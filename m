Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793233548;
	b=QJ89y1qnTzNKUKGFs5V8fWf6ppp2F5vgjhviUg/UiMdkbV+yEfa65lL3JoydZWhQVdBT
	 En+GuGvqf4JG4rvmMGxY9v0MxcoZ62qEDOJeGw4sivk70e+hoHB6mFfo7JhpU6Y1mZeSz
	 1Go8xlbXLskKwcAggSfS4VgsB0rQoAZY9sExxA/y6m9LPAbhsuBG+uGVBVTmE8WbAtujg
	 6S9w6y5VhJXuLV7JG88D2QHx3aILLlHuDFIXTxxdCqxLc+ue2D1QQHfhJMzxeI/RNff8C
	 bX37xmJIAL0IptVq0p/Z2ePGuj7nonEkkjkG3qkcBqGbzdHYshpOtMVKBFLT2EYReZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793233548;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=P+4VVR2gpLvsEHdIjCTthnXLZ9TQdByWRp+bxozVmD4=;
	b=TzYuUsQVmN23M/WpJsYGOr2N6+UZ2OlgAV7wXqUbrNhW8413rFiFgwp2I5WB2Cm3Gk5o
	 4qNijpn0Y2305ABl6d1q45awg2t1fC42/PNrfxYzQzKypE68QTyoGEtSXB1RyTVVQN3SG
	 3IPjDA5BwARFIUtAUSTN+JTXKHsTUMigtmHwXowkTVt4T5m2IeVqYUw/VJUcW72rPFwsh
	 VSSLio7jAAwv0tHpzOsJ0x+8F0/VxO/OvxAuErs7pSsBinC1OEfpLjLu1G709oZo0+xr5
	 ugn0uIn2muYYEvZO5sh5KnSxQEPdzBUbWvWviBZdtqUwy6j77lalvxvgajZdTR4NISA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NPa4LHT6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7B9606A31F;
	Thu, 29 Oct 2026 00:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NPa4LHT6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F6A1F031E0;
	Thu, 29 Oct 2026 00:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793233547;
	bh=P+4VVR2gpLvsEHdIjCTthnXLZ9TQdByWRp+bxozVmD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NPa4LHT6YOrb/FsVdX424AthRCwyyvXJXSEu7Y6JAvC4JEolnjSwVb6woAoTKJb2B
	 KpW8ojull0bAX+v82Wdrzd7uD/v8VQozsokRmf5QvYQe/k7t3+nzGMleltlgqiiMPb
	 1MPVjBhqMuFvDRwAZSnOYFwzhXZ/p9BYJXA0r84jKr90XM+YPXS7mCZDRGYkijgi/M
	 yf2DZYWLYHNasS6k0k0jQgF2wFTnapg0EMTJfowHNZshh9gFPW1CGqRkeYug/xPU3G
	 uF02Y2lMMJ1ZruTHK9aa90cWWr8m6CFJ4PowXt/OXwQ3FqX9g6IJSvy0nE+EQPdfMZ
	 YmjoLkkVKJ4eg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 03/16] tracing/filters: Fix false success return in process_system_preds()
Date: Thu, 29 Oct 2026 09:25:44 +0900
Message-ID: <undine-1793233544695295393-1ccb0da0c6955df7@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261028092846.3782e698@gandalf.local.home>
References: <179314820431.684037.4147763044424284198.stgit@devnote2> <179314823296.684037.17602272705996028005.stgit@devnote2> <20261028092846.3782e698@gandalf.local.home>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Wed, 28 Oct 2026 09:28:46 -0400, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 28 Oct 2026 09:43:53 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > In process_system_preds(), "fail" is initialized to true to indicate
> > whether any event in the subsystem successfully applied the filter.
> > However, "fail = false;" was placed at the end of the event loop outside
> > the error check, unconditionally clearing "fail" on every iteration even
> > when process_preds() returned an error.
> > 
> > As a result, if every event in the subsystem fails to match the filter
> > (e.g., an invalid field), process_system_preds() returns 0 (success)
> > instead of -EINVAL. Consequently, create_system_filter() considers the
> > operation successful and silently resets the subsystem filter display to
> > the default global filter message instead of reporting the parse error.
> > 
> > Move "fail = false;" into the else branch of the error check so that
> > "fail" is only cleared when at least one event filter succeeds. Because
> > file->filter is still replaced even when process_preds() fails, check
> > !list_empty(&filter_list->list) on the fail and fail_mem paths so any
> > replaced old filters are freed after an RCU grace period via
> > delay_free_filter().
> > 
> > Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace_events_filter.c |   15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> > index f7c067a58ba4..617bc3c0bb0c 100644
> > --- a/kernel/trace/trace_events_filter.c
> > +++ b/kernel/trace/trace_events_filter.c
> > @@ -2354,8 +2354,10 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
> >  			filter_disable(file);
> >  			parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
> >  			append_filter_err(tr, pe, filter);
> > -		} else
> > +		} else {
> >  			event_set_filtered_flag(file);
> > +			fail = false;
> > +		}
> >  
> >  
> >  		filter_item = kzalloc_obj(*filter_item);
> > @@ -2370,8 +2372,6 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
> >  		filter_item->filter = event_filter(file);
> >  		event_set_filter(file, filter);
> >  		filter = NULL;
> > -
> > -		fail = false;
> >  	}
> >  
> >  	if (fail)
> > @@ -2386,14 +2386,17 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
> >  	return 0;
> >   fail:
> >  	/* No call succeeded */
> > -	free_filter_list(filter_list);
> > +	if (!list_empty(&filter_list->list))
> > +		delay_free_filter(filter_list);
> > +	else
> > +		free_filter_list(filter_list);
> >  	parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
> >  	return -EINVAL;
> >   fail_mem:
> >  	__free_filter(filter);
> >  
> > -	/* If any call succeeded, we still need to sync */
> > -	if (!fail)
> > +	/* If any filter was replaced, we still need to sync */
> > +	if (!list_empty(&filter_list->list))
> >  		delay_free_filter(filter_list);
> >  	else
> >  		free_filter_list(filter_list);
> 
> I still prefer my suggestion which cleans up the code and gets rid of the
> duplicate if statement for freeing.
> 
>   https://lore.kernel.org/all/20261026153258.5259323d@gandalf.local.home/

Ah, indeed. Sorry I missed it. Let me update it.

Thanks!

> 
> -- Steve
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
