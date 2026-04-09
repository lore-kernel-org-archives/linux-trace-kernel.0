Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961BA3A6B68
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Apr 2026 12:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775736471; cv=pass; b=Dbcsi8F2Y8ZIH2ly2Uv/nHRRtN/rAMKeNE9lH44V3yQOgwg3LK1oSDW9SsAEI6fFFTvaokaEpZKQv1B/7qsAJPu1tNV2OoAQ9A/8LweSRAcdEI5to4HJh/gWECvqbAhaLlphqpy6RHnqU+mIROvvVs2jCA7gGn7c79JJjgPiTTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775736471; c=relaxed/simple;
	bh=X1lrPbSfhwBphUNrl7QHa4edg7PTaaemDhLjC1KzkjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dfjA6IjZSJK+iTYnbE72K88JjtoddriXahX3Gy4e1muiVHOS0spUjTN8E7Ih41IkWLDJmJFDHybACvBQTWhCRSXdi0lUGtUt6MTqBQuf7EHJ79m3AGitZ47NT49MAe9xXU8p/h+D8HdwiN1OGkucrpijWAWrKLuUSMSCt5nBLSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmKPHrAq; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmKPHrAq"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b4520f6b32so624395eec.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Apr 2026 05:07:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775736469; cv=none;
        d=google.com; s=arc-20240605;
        b=IjX1vzenPGI3C0cY2Sm08mAx7FzpxiUS30unc5hgcc0nIDA+quYDSeE5atPlecQ0aS
         yJisW0z4mWM52YAzA+dsteKUkq7AdA4azqSaoZky/8Af7LaNDx3iKra0q4fBqFO7o6f/
         e3sZ8dQRMXb8PetEUA92IjHQhIr/4Pe8NoHOHlBhZcvVcuJJMgcPTZ5ILodVRVJKsqg+
         NXNVqVX/bJkGAbnVW3rnnRsnav5OzQwrZ+2IZVCKe6KiMk4kvE1Ej7hmfYqBk7xpHyoc
         aiYm4E3+PO6wwtIHRjYGfMJfZJF/7JVEgiigZP2IzRgYBVn5SJ4TIA8xyDV0eytuWos6
         RqPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uDQF4/A02+r6NSMCX1kA6MHS3pMk2RySt5Y0g8eT3Hc=;
        fh=wJ4qn6WIURH7cbpI4FQYFdGtG+VBzntbXTjyU2N5OEw=;
        b=Bn1mTPA3kyibbWBX9JyetmwXhMnRsxmA4atExT564fDp53mseywaMc6G+3Mm1CjRvZ
         J21Yo0/94PdVCHEMlFqZayrlM+HJY89JY3yQGs+vxwAWtwrlawaQNx3mnbTNsIEfjUFt
         iHEP+ouWFHdj4GccWO8ciiIHQL0L3hIBnm8rgFAp8/cUG967DO5kALaejV333Ngum/j8
         PSSh9x5dOrWZPVAxDWnRIiZLx9DLQpSQdUACoIiddtTUianxTd3/KlxmXpZqvq8phw5s
         zJPiUI6l96bIVJt9R/x7CvmIt8wJZTaVwyDdoZjPRYfxwC2H3RRQbp9bWwqmIjj2SZlo
         KCYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775736469; x=1776341269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDQF4/A02+r6NSMCX1kA6MHS3pMk2RySt5Y0g8eT3Hc=;
        b=PmKPHrAqdWjRkeO0hlVr0JOImG0k1GwtF25zTsYDE46dxTA3TqMu2UjbvPIOAZ6nbj
         DeAlrsRPgcJavj6TkiKOF7iHGeUxPZaUfUfUfWdg1T2kf9k80cw2E5MhCvFf3cmeoCgV
         nlr8D3ENttF82Ybim06QEKYN7qWCa8eHq5Gu3Yw298YjDwA/5ZdSsmYXDK8wZOd9fxof
         MTHm3VouPR/a3VYw7K9lMiuiw2OVIvKuQhEIO5qbsGuWbKJ3ZB6+fS/p77ZKDtQLnLjV
         Gmui/DGENXT7aUqrMHRdswRtrcBLUZvJHA/h21nVunnDjbnqTl3Sg2CNvqBqit09B/sm
         XsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775736469; x=1776341269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uDQF4/A02+r6NSMCX1kA6MHS3pMk2RySt5Y0g8eT3Hc=;
        b=Pr+RemqfLwlezMMsAXgY4ZDzFwEAYhztcwCmE7OjRicXorRKZVLrVCjJk+JXZOIz7A
         OCt6IlQCGl0OFXvlapXG2T4h0DFPIfwl373EOb40em6a7Dhtj9W4VTKgMr6LtuDI6hOP
         ISV2+Esglbib7uVDKV/y42U56OOA3LpOEIKNDXZ44/o5nY0MHSzYwqprJb13QR/v4stE
         ViWGqtJv2gSQqTVI2fod98uhKx3KetGxZXFihKTvF/ias+Wev4IeJBlrHw0Rjz7ZSOJk
         dLpolW7D2IBDUrQrfYQ4fMNem1EHdUjrRLHGRyRh9j00FEef6v6Xji+A6j06JyhSI+/P
         00BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyFAMSQormhzKXQF6jsmuOXxbA7x6KoqKSeh4LweQvT8W7tmPY1RZBZy0joznmoTGOKk1UpIwc8Yi6hDOyyXhGFPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbHxHE0SSQMo0iiCvOV9p3jD9pbUDYW3aUhz0UDUADwB5JgUlQ
	+w4s2hIHTxoHVBM/xcxhf0g7YkMKTsj2qaCAt9kCEbapG1PvXIHtksCLcAWOLtjV0/5Kp3UCKzn
	qbEWkpKIZe/nlZTEpkFEsPaWUZ4NKlvo=
X-Gm-Gg: AeBDievCC5caqh1QKwnvWlgnQrGvzmXzFPDZ9aH3SSVwHjTYHIrbSquHGp8qPtHv6+6
	j9Kf46Kln+30zZViS5PRPvZdg4KXRHHQJHkt6aWLWTfbpe+tSfig6v2UHJkp4TNBWSUesLe4ldC
	VYmUq+KchNP+KbftdtSzLjhDtGcaIJRtGBtCix9vWw60LeUdS2lqNJkL6Q/Q4r3xhVlNnpTRo2o
	Dlmh1LoxbwGLDWwlxSv81/6VTTu02HFTnXASqmB3St7Ol3TaLe4cZ2SGCnydaPggxTyq8xrSBGq
	gq67FBy4YHTrEwq77xhg2Uq0fNG29o3x7IEKBlA=
X-Received: by 2002:a05:7301:5793:b0:2c5:d833:a4f3 with SMTP id
 5a478bee46e88-2cbfb995d30mr13213703eec.18.1775736468682; Thu, 09 Apr 2026
 05:07:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406072834.243491-2-abhijithsriram95@gmail.com> <20260408162459.6b8f4b01@gandalf.local.home>
In-Reply-To: <20260408162459.6b8f4b01@gandalf.local.home>
From: Abhijith Sriram <abhijithsriram95@gmail.com>
Date: Thu, 9 Apr 2026 14:07:36 +0200
X-Gm-Features: AQROBzDNTUx5myf1ZCtCM7E2Cin4CZd-mP8okUgPqJZ74QtNuVuyoXXkhOoWbVY
Message-ID: <CAMTgpFcDFqpmOx197sRZzOP8PSYsX+w8vmaTDUMSXanv2S0Ywg@mail.gmail.com>
Subject: Re: [PATCH v4] kernel/trace: fixed static warnings
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	"open list:TRACING" <linux-kernel@vger.kernel.org>, 
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 10:23=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
>
> Subject should be:
>
>  tracing: Fixed static checker warnings
>
> On Mon,  6 Apr 2026 09:28:34 +0200
> abhijithsriram95@gmail.com wrote:
>
> > From: Abhijith Sriram <abhijithsriram95@gmail.com>
> >
> > The change in the function argument description
> > was due to the static code checker script reading
> > the word filter back to back
> >
>
> The below changes should be beneath the '---'
>
> > Changes in v2:
>
> The last change should be first. In fact, I only care about the last chan=
ge
> as the previous versions should have the description of what changed.
>
> > - corrected *m =3D file->private_data to m =3D file->private_data
> >
> > Changes in v3:
> > - reverted the changes for struct seq_file *m and
> >   added a new empty line instead
> >
> > Changes in v4:
>
> That said, this should really be:
>
>  Changes since v3: https://lore.kernel.org/all/20260406060046.223496-2-ab=
hijithsriram95@gmail.com/
>
>
> > - added a new empty line before char *buf ...
> >   previously this line was relocated to avoid the
> >   static check warning.
> >
> > Signed-off-by: Abhijith Sriram <abhijithsriram95@gmail.com>
> > ---
> >  kernel/trace/trace_events_trigger.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_e=
vents_trigger.c
> > index 655db2e82513..664283bcd9ea 100644
> > --- a/kernel/trace/trace_events_trigger.c
> > +++ b/kernel/trace/trace_events_trigger.c
> > @@ -246,7 +246,7 @@ event_triggers_post_call(struct trace_event_file *f=
ile,
> >  }
> >  EXPORT_SYMBOL_GPL(event_triggers_post_call);
> >
> > -#define SHOW_AVAILABLE_TRIGGERS      (void *)(1UL)
> > +#define SHOW_AVAILABLE_TRIGGERS      ((void *)(1UL))
> >
> >  static void *trigger_next(struct seq_file *m, void *t, loff_t *pos)
> >  {
> > @@ -352,6 +352,7 @@ static int event_trigger_regex_open(struct inode *i=
node, struct file *file)
> >               ret =3D seq_open(file, &event_triggers_seq_ops);
> >               if (!ret) {
> >                       struct seq_file *m =3D file->private_data;
> > +
>
> This blank line makes the code look worse. Yes, we usually want a blank
> line between the variable declarations and the code, but when it comes to
> code blocks (not functions) that rule is not as strict.
>
> Get rid of this newline.
>
>
> >                       m->private =3D file;
> >               }
> >       }
> > @@ -390,6 +391,7 @@ static ssize_t event_trigger_regex_write(struct fil=
e *file,
> >  {
> >       struct trace_event_file *event_file;
> >       ssize_t ret;
> > +
> >       char *buf __free(kfree) =3D NULL;
>
> The char *buf is a declaration. It no new line is expected before it.
>
> >
> >       if (!cnt)
> > @@ -633,6 +635,7 @@ clear_event_triggers(struct trace_array *tr)
> >
> >       list_for_each_entry(file, &tr->events, list) {
> >               struct event_trigger_data *data, *n;
> > +
>
> Again, if it's in a code block, don't change it.
>
> -- Steve
>
> >               list_for_each_entry_safe(data, n, &file->triggers, list) =
{
> >                       trace_event_trigger_enable_disable(file, 0);
> >                       list_del_rcu(&data->list);
> > @@ -785,7 +788,7 @@ static void unregister_trigger(char *glob,
> >   *   cmd               - the trigger command name
> >   *   glob              - the trigger command name optionally prefaced =
with '!'
> >   *   param_and_filter  - text following cmd and ':'
> > - *   param             - text following cmd and ':' and stripped of fi=
lter
> > + *   param             - text following cmd and ':' and filter removed
> >   *   filter            - the optional filter text following (and inclu=
ding) 'if'
> >   *
> >   * To illustrate the use of these components, here are some concrete
>

Shall we totally scrap these changes? Apart from introducing new lines
the only other
changes are to add some brackets and reframe the comments. We are not addin=
g
a lot of value from this change. I will take this as a positive first
time experience
into linux kernel dev and focus on other meaningful changes.

--=20
Regards
Abhijith Sriram
