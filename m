Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B8336657D
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Mar 2026 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729851; cv=none; b=MZbjLktX3XNiT69YZYOOtX6EmVRzmcbGoPu1mtDWBjKwiwya7DDHt5KrxbJlVugV4SxwFQOvUrSJ7UNMF9gWPBLiEF5yU/psgJbffZM0UQcHWB3j8ZMYTG+r5DdfIdFQJ6N2xmqI5OBey47YKNHpLDrKJd6/ytbQYABuuNWtKBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729851; c=relaxed/simple;
	bh=L50tzPA+SUigvQnZGhzfTUDWPZA9ogMtdWbdTLfaxuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlmL4S6bvGsPv3pv9HqHSisOI09JhMZ7z8A9v+fVcWv+AfhMw7IuYPjvw4spuEDolfU2vLRDVjblX5vzvctxudbclsOqSoGJlT8/rRy2i4++R896xW2jI/YdQC1VjHMG5Z/ZdBDBQrXNOf2e5Yav2MPnE3JmQdaoUsCFN9nP26Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDG36W82; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDG36W82"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso7721341eec.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Mar 2026 08:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772729849; x=1773334649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSYeYpQWoo0g63AakogojnOJ+SUDTQC7bT0GuINwN34=;
        b=nDG36W824trpQfahQkDHN9anxTFqaGTd/NTIRQHMqPMTdWSpn4PmF9KJVhgLuZnvpR
         6aNZ7urRIMxh6IIILp/HzuHOtzjG4+PolEvsPEUsqfy0kayCFqAjVLuLFjVb58U2H2Xm
         PEMRuxYnFgChLqjRNBDmOY0LycQlQBFKhwILLnz5f70jSovTUHIPKKut6SGGrHeK5v2S
         naVIQKACzSYMgn0z/UpYkIx/6SsqUt+kxJpEW6CvIdoofxdcFz3uU0yG+llBC41AFTH3
         DIcW3kZr7Pg7AnckVs7/QkHSDJ1+PbWIJP/SJXPRw+S2mri4FXlEi2AA+COZRvp5qJ0m
         we0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772729849; x=1773334649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WSYeYpQWoo0g63AakogojnOJ+SUDTQC7bT0GuINwN34=;
        b=R6hadoQ7g3nn40WezNcUJCfyCjnBhzSAg/0OAJxMJee8oikgdarT93zdkGmBFO+YGG
         C4HFax/LfSBLR6RmTodgeVMIj0McXBXxcn837IzZ9yIsu2a3k05c8ZAuVh7fReNvex1o
         69h/KkAJQAkYIK55Nf52TEjnzwVoYLNAwfI+VIzwqLLRYNxze2MKTpqCU5iFknpirL7B
         HHWjgnThkc2ilIpkP5yC7v8ECD43QkuUbaNNSik+NH00PTAe4B8PWxcrkHf8BCptLA48
         TNUj+PzGd+9omj2qaqooI2cNxbyykhSYfSO8oR8RkgvkIbo2B8HmxT2PTjt+GGbu4bfw
         D2ag==
X-Forwarded-Encrypted: i=1; AJvYcCV/ItYGiQQ+jEMy+GPs0Tl7OKZg4MxRQ5iI0h5b2Byc5tLgZLUbP2TbOP5mkRYmE3VdYsQKfLbusw75VTzmlHfyVeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzMhOlho8RRc1KxkFuH6Ra9Aw0ubirLJ94aUywPJxxVtWEfmpj
	ciOtGWLge5t1hfK7VsImOcbfFNi367Ik0OtKZt+nQO35e1OaOHm/lc51
X-Gm-Gg: ATEYQzwgs3hCKvJgMJu8sthBJo2nARvzSG140ikl7OC6M9JZXn8vmrc/Xnc3iBLBRsx
	jm334l7EONZnocJoaEb/sHIfA9bI0cItnJlhGIdVw6Eilep9lS+pB+Eg9wjva80TwjuWTZOMrVw
	jAyZuSVSMY8m5qvRjJS/F+eX1PGZE8IF/JkVoYKESO4s2wrz97IDzVG8XBRVVIRPee+YumFEHca
	e/28q4leMPIL8z8Gk0N63Cp2bkg5wO4PU6qwwRKuRnpQyJqhO42ZE0RGfrxsXf5tMLZfZ2Uaxt1
	c8FG3UcE/XTWoGU2kwRzUaxut9UTYAmDVg9nioqf7YBGyMwITdLZK30eTPtOqWwmU2DNuXC6CPy
	mLbzfluITVNqjM+ztTYhjb6iYmy2qyDP/q467UlrM2R0z4x5jdIA3WDkyZuBkQ28VaIre4U8fc+
	+/GlL0fr4v2mIuI4JApI+4wVaR0BN1pM4jXJ1kZKdSLJpTeW0=
X-Received: by 2002:a05:7300:bc0c:b0:2be:171c:5048 with SMTP id 5a478bee46e88-2be30fd2fd8mr2215320eec.5.1772729849363;
        Thu, 05 Mar 2026 08:57:29 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be0d7e0d40sm10266051eec.12.2026.03.05.08.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 08:57:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 5 Mar 2026 08:57:27 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [PATCH] tracing: Do not call trigger_data_free with NULL data
 pointer
Message-ID: <c568c324-cccf-4636-9697-1e2cc3f0ba9d@roeck-us.net>
References: <20260305163633.2782210-1-linux@roeck-us.net>
 <20260305114336.0f2710eb@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305114336.0f2710eb@gandalf.local.home>

On Thu, Mar 05, 2026 at 11:43:36AM -0500, Steven Rostedt wrote:
> On Thu,  5 Mar 2026 08:36:33 -0800
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > If trigger_data_alloc() fails and returns NULL, event_hist_trigger_parse()
> > jumps to the out_free error path. While kfree() safely handles a NULL
> > pointer, trigger_data_free() does not. This causes a NULL pointer
> > dereference in trigger_data_free() when evaluating
> > data->cmd_ops->set_filter.
> > 
> > Fix the problem by adding a new goto label and jumping to it if
> > trigger_data_alloc() returns NULL.
> > 
> > The problem was found by an experimental code review agent based on
> > gemini-3.1-pro while reviewing backports into v6.18.y.
> > 
> > Assisted-by: Gemini:gemini-3.1-pro
> > Cc: Miaoqian Lin <linmq006@gmail.com>
> > Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Fixes: 0550069cc25f ("tracing: Properly process error handling in event_hist_trigger_parse()")
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  kernel/trace/trace_events_hist.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> > index 73ea180cad55..a2abdfe19281 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -6874,7 +6874,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
> >  	trigger_data = trigger_data_alloc(cmd_ops, cmd, param, hist_data);
> >  	if (!trigger_data) {
> >  		ret = -ENOMEM;
> > -		goto out_free;
> > +		goto out_destroy;
> >  	}
> >  
> >  	ret = event_trigger_set_filter(cmd_ops, file, filter, trigger_data);
> > @@ -6942,7 +6942,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
> >  	remove_hist_vars(hist_data);
> >  
> >  	trigger_data_free(trigger_data);
> 
> I rather make trigger_data_free() more robust by starting it with:
> 
> 	if (!data)
> 		return;

Sure. No preference on my side. I'll send v2.

Thanks,
Guenter
