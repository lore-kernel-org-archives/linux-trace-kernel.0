Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCAE1C2AD
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Nov 2023 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7866AC433C7;
	Wed, 22 Nov 2023 21:20:35 +0000 (UTC)
Date: Wed, 22 Nov 2023 16:20:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Nick Lowell <nicholas.lowell@gmail.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Nicholas Lowell <nlowell@lexmark.com>
Subject: Re: [PATCH v2] trace: tracing_event_filter: fast path when no
 subsystem filters
Message-ID: <20231122162051.661981fe@gandalf.local.home>
In-Reply-To: <CAFEqNJ3PE6_u-q41Jw=-p7PrNBLT0Lr_n87WiY_2UctOJrDmZA@mail.gmail.com>
References: <20231002144149.1325-1-Nicholas.Lowell@gmail.com>
	<20231003223003.675bd888@gandalf.local.home>
	<CAFEqNJ2=rt5KaDaAah1t8gGbLViW7VZEDq+81drvuWUz4CKR2w@mail.gmail.com>
	<20231004105339.5f948a96@gandalf.local.home>
	<CAFEqNJ3PE6_u-q41Jw=-p7PrNBLT0Lr_n87WiY_2UctOJrDmZA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Oct 2023 16:37:35 -0400
Nick Lowell <nicholas.lowell@gmail.com> wrote:

Sorry, I was traveling when this was sent, and I missed it.


> I really appreciate the continued feedback.  I was able to reproduce.
> I think I'm understanding better but still need some help.
> I am actually wondering if remove_filter_string(system->filter) should

You mean to return true if filter->filter_string was not NULL?

> also return bool as an OR'd input for sync.
> Should it be something like this?
> 
>         if (!strcmp(strstrip(filter_string), "0")) {
> -               filter_free_subsystem_preds(dir, tr);
> -               remove_filter_string(system->filter);
> +              bool sync;

I would just make this an int;

> +
> +              sync = filter_free_subsystem_preds(dir, tr);
> +              sync = sync || remove_filter_string(system->filter);

And then just have:

		sync |= remove_filter_string(system->filter);

>                 filter = system->filter;
>                 system->filter = NULL;
> -               /* Ensure all filters are no longer used */
> -               tracepoint_synchronize_unregister();
> +              /* If nothing was freed, we do not need to sync */
> +              if(sync) {
> +                      /* Ensure all filters are no longer used */
> +                      tracepoint_synchronize_unregister();
> +              }
>                 filter_free_subsystem_filters(dir, tr);
>                 __free_filter(filter);
>                 goto out_unlock;
> 
> > Maybe even pass in "sync" to the filter_free_subsystem_filters() to make
> > sure there were nothing to be freed, and do the WARN_ON_ONCE() then.
> >
> >                 __free_filter(filter);
> >                 goto out_unlock;
> >         }
> >
> > -- Steve  
> 
> I'm not sure if I see the reasoning for the WARN_ON_ONCE() in
> filter_free_subsystem_filters()
> because it ends up checking the same if(!filter) just like
> filter_free_subsystem_preds() did earlier. It doesn't
> seem to do anything with system->filter.  I actually wonder if !sync,
> could filter_free_subsystem_filters()
> be skipped altogether.  Help me if I'm missing something.

The point is, code always changes. It's a bug if one of the filters had
content in filter_free_subsystem_filters() and sync is 0, hence the
WARN_ON_ONCE() if it does.

WARN_ON*()s are added to make sure the code is acting the way it is expected
to act. Yes, it should never trigger, but if it does, we know there's a bug
somewhere.

-- Steve
