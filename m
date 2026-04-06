Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5662D2EDD70
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Apr 2026 06:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775455400; cv=pass; b=u0LSaXGNBBdi9RFAs++r1ltHnUQLFIn/ojP+gA1WwFXb0WubbMd5k/rSudYavNj2GETsvDHf2t7T7mwhOcp/nL0SmRFlYNBIlb1TLGEcekblK5cmYatSXY2Qbgr9YcxbmoK3wDEoImjQIGMAjDFEhfV0d8xnSRs5ubIrZEOSMfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775455400; c=relaxed/simple;
	bh=pvB+e13ZiIq3Z8dQyvmTVzG0HdEXy2WDDpJpftKr3iI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTApYxc1HQQsetfcmPBcwB6b7NLn06deDOGRNJYk+gzIP2hbuQb3Jbs9yggY9mkePeolTYCsZdbvmh2p8vEhk6OUVJ1BPikuVF9HWcTwvpXiLsbRIvYrpbA94Rru3CQRAKREFW4p+ZGeeal+cPRzK1Rf4MkOVt/TsEmYwvp7sW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaL+91bb; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaL+91bb"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12c0b72daf7so1682500c88.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 05 Apr 2026 23:03:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775455398; cv=none;
        d=google.com; s=arc-20240605;
        b=WMuLMv8ud0HKC7hKGX06h3PXav+XEk53zPDgdW3jooivVqWE4ykkhZ18fzWQ+mZI4y
         iUuRjSPi+rAFGrQwaMx8TvK+94B9Bk6XIG1ZmfP3oqS+61E+2bKnQwfktd1CgO6JSD6a
         OEH8C2GQFHQBA0KceW/PE7N+2Vm4skAYJsT4MiQGfdSD+CzTIPjL2mnvJxaCXbAQiZig
         HR7CmWORHDfQmm2ycIfiS6xeN08QSfMJbP+TgSpBWPhRMJc2aZR/RrcH2xeIXojv0PaF
         1p26uyez0teOoL+0nxbPRCgVVZUhhem9OMJQxdHEhtzHV9Y6kSGo9btg1NoDHplzi+R/
         7XPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=slEgEOSlmdY+3GZDpMlwQoG5GoCXqYEutNbD8zKu3FU=;
        fh=NQ89ffy4z8CgLdzvSKljP4pDCWX5ebXyBQfrUzwx+F0=;
        b=EeO6GJOT0FGvcSqNxGE7fGTJZdFPyaRKWGoLPDPlNPp+QN1r2IkqlHY8Xw3Ow/asXe
         hqL3BGAIR0S3b+NiyFQJ7rArZd2fQQVUgcWQCU82pBm6ws7Pl4XMsADWj8SDP9a34xts
         Ry1Q+ZHyZuQyXdV51ju3D1yBJFAFqs8Rte26nTLXbff4YrVbvhoqv3XdvmW4naXY3+fu
         8EpUFI1a+MykM6w8WdTRMaCJfZv1kHOIIdvh8NH0u9Qiet+oxLZwp9ULJBudtzznFG7v
         +nWRIEfpSwZ3OpGXDwRnZfiXo5+mUVbngQdNRTjt1sQnXV9qKMpvczoiwy24Y0BdZCGL
         fhsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775455398; x=1776060198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slEgEOSlmdY+3GZDpMlwQoG5GoCXqYEutNbD8zKu3FU=;
        b=FaL+91bbM+C3PJAy6qgNEb7hPgLWHzajpsqu523jLU2qwj+LIDXSPGy8dukS3z003R
         86WUatOPEhHrmScqctz8uDdOCVR0eoSzUaeVFT+K0s4V89ElWWwiVqZsbsQe2JZAoSo8
         dWZ9d2IPQsSJqcrLzZpneS3I+V74q+odM6bvxWeqdE6lDWK2eBEh5HgTJxaJdo2dzsq0
         KEBqI9Q9xJR8dUBegKCvt0d4+0PPtlEKxmgdPMMOPhYDxkyNsz4bcEBeM63cxZOLRWPu
         bEeqR+OGa+ayt0sXaSGwpI9uqBdebdgS7LfLGtX1IyPp5E8FVv+GQNesatRkgLSZ7qE1
         3tTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775455398; x=1776060198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=slEgEOSlmdY+3GZDpMlwQoG5GoCXqYEutNbD8zKu3FU=;
        b=at/xWxsa7/L3Nb+OF1ZtpSTU7WI9IqWMldTO01fuTrvnuFL34W+9P1qMztCMyp5hG6
         mo2Rcql8aPvXgJnKQ0gU1na3JTqyhxtfDyJuD34IHpUwJuUL8poEVSY511IruIyKUfAG
         /ivfLAU9g4cwLb5ggpKL3fyD7E13EEG2p2KwQYq4BsPiYKc6j710XoI+132L8AL7lzHI
         CJtxon+bDsP/cp1105HfZy9sDZ5V57q0BMV/GG9ABJQnOJ3BhHNVjvWO3T1TGyo6f93W
         wyxU1PkIebWlncp5I/9gHxuhJyTZA47tjXEZnH6WsW2g3fjZ+Gdf82IB4PijS8H6apOX
         jYFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBnop7sahOGZDNxNmJNNrKy+iez/uS58nuaHT6NLbvwpo2be6L/S6dNBJsPgV5a+wEnpPkMoQX5M8yM/v9NEElWEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkakpiXpxj6Ixnh17i/Qu4XAES9ckiXmEcXsmk6kJnSw4AU1oy
	xvqelF2rUcNXCOj+yth79+XQwKfdQi0Ql7j+tnO6tDVIrL6n08BFzKNuSUunYRoRpLVo9551zTk
	hJZ5ZJX0OjnzQCQGR/kC5vcI+gmtJn0e3AYh8PMw=
X-Gm-Gg: AeBDieuRSKIDEsnP3Osi7sexAeqylPyBgjOkusDM6Fd47X+ovSNM7d8q0hnK9oioNb4
	GMxuTHeGXs2SrCFFGTdmIlZvAKAxbrWkK919f64Ru6QC2sAylf41kPI33NLsJb9jO5QADyi+cv4
	gNyXZhTP4blAzbrzmUdFkG1a0Fg3JZcd66Iwwe5EAy4UjCUWEn6sDktpBHowuua21Z5SidUTR/1
	QtYHfcw+w4BOm7b2LVbCWILu2oPmDD0W/JTGpZyR9gDD8PSpfPym8Q8nlmMbFpheeJMxzRaKkb5
	zC/74SYrwjyi9nBJJ0/cus7Gx9VyFsjpnrXYpLw=
X-Received: by 2002:a05:7300:6d07:b0:2c4:ec89:be7 with SMTP id
 5a478bee46e88-2cbfc07386emr6478600eec.23.1775455398218; Sun, 05 Apr 2026
 23:03:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402195405.21316-1-abhijithsriram95@gmail.com>
 <20260404091806.4e1cf73d2775d128f1dc5277@kernel.org> <CAMTgpFfAmzXxjtZXbtLyZL62dAWOmyhNkwJLkgQy7Lcv+VrjLA@mail.gmail.com>
 <20260406110053.b0582d349e42eefb1c4aeda6@kernel.org>
In-Reply-To: <20260406110053.b0582d349e42eefb1c4aeda6@kernel.org>
From: Abhijith Sriram <abhijithsriram95@gmail.com>
Date: Mon, 6 Apr 2026 08:03:07 +0200
X-Gm-Features: AQROBzDJITpusmQlLWB6JtKyBZKdRTZidy0yw4GnK6lkL1qpsxNzDsxJjUcjLSE
Message-ID: <CAMTgpFcqFtZ52iKCzWekdLrwmpKGSSqOD-DLfHuwMV6YN9Opog@mail.gmail.com>
Subject: Re: [PATCH] kernel/trace: fixed static warnings
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	"open list:TRACING" <linux-kernel@vger.kernel.org>, 
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 4:00=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Sat, 4 Apr 2026 08:03:07 +0200
> Abhijith Sriram <abhijithsriram95@gmail.com> wrote:
>
> > On Sat, Apr 4, 2026 at 2:18=E2=80=AFAM Masami Hiramatsu <mhiramat@kerne=
l.org> wrote:
> > >
> > > On Thu,  2 Apr 2026 21:54:04 +0200
> > > abhijithsriram95@gmail.com wrote:
> > >
> > > > From: Abhijith Sriram <abhijithsriram95@gmail.com>
> > > >
> > > > The change in the function argument description
> > > > was due to the static code checker script reading
> > > > the word filter back to back
> > > >
> > > > Signed-off-by: Abhijith Sriram <abhijithsriram95@gmail.com>
> > > > ---
> > > >  kernel/trace/trace_events_trigger.c | 10 ++++++----
> > > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/tra=
ce_events_trigger.c
> > > > index 655db2e82513..477d8dee3362 100644
> > > > --- a/kernel/trace/trace_events_trigger.c
> > > > +++ b/kernel/trace/trace_events_trigger.c
> > > > @@ -246,7 +246,7 @@ event_triggers_post_call(struct trace_event_fil=
e *file,
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(event_triggers_post_call);
> > > >
> > > > -#define SHOW_AVAILABLE_TRIGGERS      (void *)(1UL)
> > > > +#define SHOW_AVAILABLE_TRIGGERS      ((void *)(1UL))
> > >
> > > This is OK.
> > >
> > > >
> > > >  static void *trigger_next(struct seq_file *m, void *t, loff_t *pos=
)
> > > >  {
> > > > @@ -325,6 +325,7 @@ static const struct seq_operations event_trigge=
rs_seq_ops =3D {
> > > >  static int event_trigger_regex_open(struct inode *inode, struct fi=
le *file)
> > > >  {
> > > >       int ret;
> > > > +     struct seq_file *m =3D NULL;
> > > >
> > > >       ret =3D security_locked_down(LOCKDOWN_TRACEFS);
> > > >       if (ret)
> > > > @@ -351,7 +352,7 @@ static int event_trigger_regex_open(struct inod=
e *inode, struct file *file)
> > > >       if (file->f_mode & FMODE_READ) {
> > > >               ret =3D seq_open(file, &event_triggers_seq_ops);
> > > >               if (!ret) {
> > > > -                     struct seq_file *m =3D file->private_data;
> > > > +                     *m =3D file->private_data;
> > >
> > > Why is this change required?
> > The original warning says "missing blank line after declaration". I
> > thought it was cleaner to have the
> > declaration in the beginning of the function. I made a mistake here
> > which I fixed in the version 2 of
> > the patch, please have a look here:
> > https://lore.kernel.org/linux-trace-kernel/20260403071108.23422-2-abhij=
ithsriram95@gmail.com/T/#u
>
> In that case, you just need to add an empty line, no need to move the
> definition becuase it changes the scope of `m` variable.
I reverted the changes in version 3 of the patch.
Please find it here:
https://lore.kernel.org/linux-trace-kernel/20260406060046.223496-2-abhijith=
sriram95@gmail.com/T/#u
>
> > >
> > > >                       m->private =3D file;
> > > >               }
> > > >       }
> > > > @@ -388,9 +389,9 @@ static ssize_t event_trigger_regex_write(struct=
 file *file,
> > > >                                        const char __user *ubuf,
> > > >                                        size_t cnt, loff_t *ppos)
> > > >  {
> > > > +     char *buf __free(kfree) =3D NULL;
> > > >       struct trace_event_file *event_file;
> > > >       ssize_t ret;
> > > > -     char *buf __free(kfree) =3D NULL;
> > >
> > > What is this change?
> > The same missing blank lines after declaration was triggered here,
> > even though there is a blank line after the char *buf.
> > If I do give an empty line then there is another error "Trailing white
> > space". So I  reordered it and the warning disappeared.
> > This change I am not super sure since it is usually recommended that
> > variables of larger size are declared first
> > for padding purposes. What do you think?
>
> Ah, that is a known checkpatch's bug. It does not understand __free()
> macro. So please ignore that error (or/and fix checkpatch.pl).
>
> Thanks,
>
> > >
> > > Thanks,
> > >
> > > >
> > > >       if (!cnt)
> > > >               return 0;
> > > > @@ -633,6 +634,7 @@ clear_event_triggers(struct trace_array *tr)
> > > >
> > > >       list_for_each_entry(file, &tr->events, list) {
> > > >               struct event_trigger_data *data, *n;
> > > > +
> > > >               list_for_each_entry_safe(data, n, &file->triggers, li=
st) {
> > > >                       trace_event_trigger_enable_disable(file, 0);
> > > >                       list_del_rcu(&data->list);
> > > > @@ -785,7 +787,7 @@ static void unregister_trigger(char *glob,
> > > >   *   cmd               - the trigger command name
> > > >   *   glob              - the trigger command name optionally prefa=
ced with '!'
> > > >   *   param_and_filter  - text following cmd and ':'
> > > > - *   param             - text following cmd and ':' and stripped o=
f filter
> > > > + *   param             - text following cmd and ':' and filter rem=
oved
> > > >   *   filter            - the optional filter text following (and i=
ncluding) 'if'
> > > >   *
> > > >   * To illustrate the use of these components, here are some concre=
te
> > > > --
> > > > 2.43.0
> > > >
> > >
> > >
> > > --
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > --
> > Regards
> > Abhijith Sriram
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

Regards
Abhijith Sriram
