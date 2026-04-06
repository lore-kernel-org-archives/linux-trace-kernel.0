Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80593101D8;
	Mon,  6 Apr 2026 02:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775440858; cv=none; b=C3ZHZ3jz8xdpn9ewLnoGOTlK9iT3FFzAIKL6Y48ix7QLy6SmA9KaJJy+CN5O0HHeFil1bt5B0sB8thrAC+NnJ5R9CZXClZojBSuYNYQZy6q/5F22NrLpz9PqswGGf6bWrQIV5N7oYiJa4zHwNnatSsi05jaqKoGx0BlU3xxCFwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775440858; c=relaxed/simple;
	bh=CV6ih93qu+aZLv8CDLlocbGsiyLNyG61etvBK6OpYIY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DRYI9sJTRZlr5Friv1SU3XBDkJ4dy4tSZsRCjipQK03VLbs1jR1cYpcLGotAcfyN8Pj6KLZxAf+WjVRnvaeqRBhlYhxQF+s4sbQgns2K79lms7H+aiUZpBJde9IT3yupm5e6Qm5BKjurK/nGlMbnZZllHDhjv8svxNh8oX1sDhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEy2Kl25; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEy2Kl25"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13F4C116C6;
	Mon,  6 Apr 2026 02:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775440857;
	bh=CV6ih93qu+aZLv8CDLlocbGsiyLNyG61etvBK6OpYIY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GEy2Kl25YqgKiQOmHM2BifmcKXkx/O7rs9btjOAlIQqJwnTAcRVQQ1NvZohbLpqTV
	 ruMOddGiAwcYv4IqiLYEsLOW+c3h6hdQz7KHse69x8fb/OJD8GfWX2XpU84Cib1oqB
	 DJyxOK/6MLpfWLq7KRiYWwAb1D0HY4cm+YXxvOBLdQMgoM9f1R5YYCLuis2/raZ/5q
	 9RJthxsbUzwAP9trby4QGsQTDg0k87w3r099ZQbvn2TxNLIlhRWvKBO/6bg5QzNLTB
	 GXylEn8sNuWYB+E3e2/xDzKQK4/Qq0gNV/xl1WdqyF0/Z2SPzp5W819/Kh0XubU1IV
	 fKotBgnmfzD/w==
Date: Mon, 6 Apr 2026 11:00:53 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Abhijith Sriram <abhijithsriram95@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "open list:TRACING"
 <linux-kernel@vger.kernel.org>, "open list:TRACING"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel/trace: fixed static warnings
Message-Id: <20260406110053.b0582d349e42eefb1c4aeda6@kernel.org>
In-Reply-To: <CAMTgpFfAmzXxjtZXbtLyZL62dAWOmyhNkwJLkgQy7Lcv+VrjLA@mail.gmail.com>
References: <20260402195405.21316-1-abhijithsriram95@gmail.com>
	<20260404091806.4e1cf73d2775d128f1dc5277@kernel.org>
	<CAMTgpFfAmzXxjtZXbtLyZL62dAWOmyhNkwJLkgQy7Lcv+VrjLA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 4 Apr 2026 08:03:07 +0200
Abhijith Sriram <abhijithsriram95@gmail.com> wrote:

> On Sat, Apr 4, 2026 at 2:18 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Thu,  2 Apr 2026 21:54:04 +0200
> > abhijithsriram95@gmail.com wrote:
> >
> > > From: Abhijith Sriram <abhijithsriram95@gmail.com>
> > >
> > > The change in the function argument description
> > > was due to the static code checker script reading
> > > the word filter back to back
> > >
> > > Signed-off-by: Abhijith Sriram <abhijithsriram95@gmail.com>
> > > ---
> > >  kernel/trace/trace_events_trigger.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> > > index 655db2e82513..477d8dee3362 100644
> > > --- a/kernel/trace/trace_events_trigger.c
> > > +++ b/kernel/trace/trace_events_trigger.c
> > > @@ -246,7 +246,7 @@ event_triggers_post_call(struct trace_event_file *file,
> > >  }
> > >  EXPORT_SYMBOL_GPL(event_triggers_post_call);
> > >
> > > -#define SHOW_AVAILABLE_TRIGGERS      (void *)(1UL)
> > > +#define SHOW_AVAILABLE_TRIGGERS      ((void *)(1UL))
> >
> > This is OK.
> >
> > >
> > >  static void *trigger_next(struct seq_file *m, void *t, loff_t *pos)
> > >  {
> > > @@ -325,6 +325,7 @@ static const struct seq_operations event_triggers_seq_ops = {
> > >  static int event_trigger_regex_open(struct inode *inode, struct file *file)
> > >  {
> > >       int ret;
> > > +     struct seq_file *m = NULL;
> > >
> > >       ret = security_locked_down(LOCKDOWN_TRACEFS);
> > >       if (ret)
> > > @@ -351,7 +352,7 @@ static int event_trigger_regex_open(struct inode *inode, struct file *file)
> > >       if (file->f_mode & FMODE_READ) {
> > >               ret = seq_open(file, &event_triggers_seq_ops);
> > >               if (!ret) {
> > > -                     struct seq_file *m = file->private_data;
> > > +                     *m = file->private_data;
> >
> > Why is this change required?
> The original warning says "missing blank line after declaration". I
> thought it was cleaner to have the
> declaration in the beginning of the function. I made a mistake here
> which I fixed in the version 2 of
> the patch, please have a look here:
> https://lore.kernel.org/linux-trace-kernel/20260403071108.23422-2-abhijithsriram95@gmail.com/T/#u

In that case, you just need to add an empty line, no need to move the
definition becuase it changes the scope of `m` variable.

> >
> > >                       m->private = file;
> > >               }
> > >       }
> > > @@ -388,9 +389,9 @@ static ssize_t event_trigger_regex_write(struct file *file,
> > >                                        const char __user *ubuf,
> > >                                        size_t cnt, loff_t *ppos)
> > >  {
> > > +     char *buf __free(kfree) = NULL;
> > >       struct trace_event_file *event_file;
> > >       ssize_t ret;
> > > -     char *buf __free(kfree) = NULL;
> >
> > What is this change?
> The same missing blank lines after declaration was triggered here,
> even though there is a blank line after the char *buf.
> If I do give an empty line then there is another error "Trailing white
> space". So I  reordered it and the warning disappeared.
> This change I am not super sure since it is usually recommended that
> variables of larger size are declared first
> for padding purposes. What do you think?

Ah, that is a known checkpatch's bug. It does not understand __free()
macro. So please ignore that error (or/and fix checkpatch.pl).

Thanks,

> >
> > Thanks,
> >
> > >
> > >       if (!cnt)
> > >               return 0;
> > > @@ -633,6 +634,7 @@ clear_event_triggers(struct trace_array *tr)
> > >
> > >       list_for_each_entry(file, &tr->events, list) {
> > >               struct event_trigger_data *data, *n;
> > > +
> > >               list_for_each_entry_safe(data, n, &file->triggers, list) {
> > >                       trace_event_trigger_enable_disable(file, 0);
> > >                       list_del_rcu(&data->list);
> > > @@ -785,7 +787,7 @@ static void unregister_trigger(char *glob,
> > >   *   cmd               - the trigger command name
> > >   *   glob              - the trigger command name optionally prefaced with '!'
> > >   *   param_and_filter  - text following cmd and ':'
> > > - *   param             - text following cmd and ':' and stripped of filter
> > > + *   param             - text following cmd and ':' and filter removed
> > >   *   filter            - the optional filter text following (and including) 'if'
> > >   *
> > >   * To illustrate the use of these components, here are some concrete
> > > --
> > > 2.43.0
> > >
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> -- 
> Regards
> Abhijith Sriram


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
