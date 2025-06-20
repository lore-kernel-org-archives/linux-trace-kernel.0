Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ECD30E830;
	Fri, 20 Jun 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750412106; cv=none; b=DmjSh549vnL6PzN9OPz2QfFfl2v+cs0nKkiHGquRhrt9xWJW/3H113jQ5lPW8x0ZJRW378z31zGCj22AmZa2uhajTeJ9HXblMsELfI5y1D+9gfYJhqKE8KWUpmjxMEOwELpH4P/6IKVWXE77iaUwAjXzE9neVEPl7wzHG/XnNHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750412106; c=relaxed/simple;
	bh=mcglT0uza/+CKIa/rtTfM2tRXfO+gkQTMPbHccFk6FU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JVHyI3weZ3jMAi/a3KgP/UbcAFxDoti2jaGfGEvrIek6zUR4cEWRG82/IH53BjKMK6xijPkYw7NTDR7p5JhpvLyIDmPCWGVtBu0AMXS1LD9tqkuPf1wtjGA1Ixd4EJC/kTEbuLrS6m6RhBn9HrIv4FHsXhOi0lHiscqoKMoYCu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0k2W5Tq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0k2W5Tq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB72C4CEE3;
	Fri, 20 Jun 2025 09:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750412105;
	bh=mcglT0uza/+CKIa/rtTfM2tRXfO+gkQTMPbHccFk6FU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e0k2W5TqfmzR48uS+dhgxhdXOoS7SwdXkAd1Z6VjABY4bArc6Pz7UjhjBR10sHmTt
	 7gIP3xumflw0RjauwJnnY3m4TrMvgUyNUBbOzH6qNMJwQ+JgyR/mA1rtYcIRLE2BoL
	 r0vAmYmUhMXWfddNjRHxKxTOsYAQuCfd+eifEpuYd4PlEC2ONOqvzyI9o3cWNWjIHp
	 QdDhGyvvsY9Ak8UgUjIOvuj5t8uurG362LwEOzITiLbJBJPWNcvuiEmBHm5kuNOYmL
	 /zVURUnuBixNVckBiAoRtiNTG01MVMJiNHKMAJWPl4fhnOxCNiI0+kp7dxZTqFJksf
	 HR3VmUaZCJRNg==
Date: Fri, 20 Jun 2025 18:35:03 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 acarmina@redhat.com, chuck.wolber@boeing.com
Subject: Re: [RFC PATCH 1/2] tracing: fixes of ftrace_enable_fops
Message-Id: <20250620183503.6c84eb22cca206cd10418c04@kernel.org>
In-Reply-To: <CA+wEVJa0jL-JH_4=5sR+Mvb26n4mPPudmOL0LRBDV54nMZcw8g@mail.gmail.com>
References: <20250612104349.5047-1-gpaoloni@redhat.com>
	<20250612104349.5047-2-gpaoloni@redhat.com>
	<20250613114527.7e27a9a0ecc2b59d98677b0c@kernel.org>
	<CA+wEVJa0jL-JH_4=5sR+Mvb26n4mPPudmOL0LRBDV54nMZcw8g@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 19 Jun 2025 19:07:33 +0200
Gabriele Paoloni <gpaoloni@redhat.com> wrote:

> Hi Masami
> 
> On Fri, Jun 13, 2025 at 4:45 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Thu, 12 Jun 2025 12:43:48 +0200
> > Gabriele Paoloni <gpaoloni@redhat.com> wrote:
> >
> > > Currently there are different issues associated with ftrace_enable_fops
> > > - event_enable_write: *ppos is increased while not used at all in the
> > >   write operation itself (following a write, this could lead a read to
> > >   fail or report a corrupted event status);
> >
> > Here, we expected the "enable" file is a pseudo text file. So if
> > there is a write, the ppos should be incremented.
> >
> > > - event_enable_read: cnt < strlen(buf) is allowed and this can lead to
> > >   reading an incomplete event status (i.e. not all status characters
> > >   are retrieved) and/or reading the status in a non-atomic way (i.e.
> > >   the status could change between two consecutive reads);
> >
> > As I said, the "enable" file is a kind of text file. So reader must read
> > it until EOF. If you need to get the consistent result, user should
> > use the enough size of buffer.
> 
> What I am concerned about are scenarios like the one below:
> ---
> # strace -Tfe trace=openat,open,read,write scat 1
> /sys/kernel/tracing/events/kprobes/ev1/enable
> open("/sys/kernel/tracing/events/kprobes/ev1/enable",
> O_RDONLY|O_LARGEFILE) = 3 <0.000237>
> Open /sys/kernel/tracing/events/kprobes/ev1/enable ->fd=3
> read fd=3, 1
> read(3, "0", 1)                         = 1 <0.000099>
> 1 bytes Read
> 30,
> read(3, "\n", 1)                        = 1 <0.000095>
> 1 bytes Read
> 0a,
> read(3, "", 1)                          = 0 <0.000102>
> close fd=3
> +++ exited with 0 +++
> ---
> So in this case there are 2 consecutive reads byte by byte that
> could lead to inconsistent results if in the meantime the event
> status has changed.

Unless you take a lock explicitly, ftrace (and other pseudo
files) does not guarantee the consistency between 2 read()
syscalls, because it is something like a file which is shared
with kernel side.

Please imagine that this is something like a file shared
between two processes, one updating it and one reading it.
The kernel guarantees the one read() will consistent, but
two read()s may not be consistent because it can be updated
by another.

> With the proposed patchset the same test would result in a failure
> as per log below:
> ---
> # strace -Tfe trace=openat,open,read,write scat 1
> /sys/kernel/tracing/events/kprobes/ev1/enable
> open("/sys/kernel/tracing/events/kprobes/ev1/enable",
> O_RDONLY|O_LARGEFILE) = 3 <0.000227>
> Open /sys/kernel/tracing/events/kprobes/ev1/enable ->fd=3
> read fd=3, 1
> read(3, 0x7ffd960234e0, 1)              = -1 EINVAL (Invalid argument)
> <0.000228>
> close fd=3
> +++ exited with 0 +++
> ---
> On the other side the proposed patchset would be still compatible with
> “cat” or “scat 2” commands that continue to work as they do today.
> 
> >
> > > - .llseek is set to default_llseek: this is wrong since for this
> > >   type of files it does not make sense to reposition the ppos offset.
> > >   Hence this should be set instead to noop_llseek.
> >
> > As I said, it is a kind of text file, default_llseek is better.
> >
> > But, if we change (re-design) what is this "enable" file is,
> > we can accept these changes. So this is not a "Fix" but re-design
> > of the "enable" file as an interface (as a char device), not a text
> > file (or a block device).
> >
> > I want to keep this as is, same as other tracefs files.
> 
> IMO it is a redesign that is enforcing the user to avoid erroneous
> usages of enable files (because the reads are either reporting the
> whole and correct status of the event or failing to read; also the user
> cannot llseek into a position that would lead to not reading or reading
> a corrupted status).

Can you make it for files which can be bigger than PAGE_SIZE?

For example, "hist" file also can be inconsistent if user reads
it several times. Can you also update it to return -EINVAL
if read buffer size is smaller?

> 
> On the other hand the proposed re-design is fully compatible with
> the current user space commands reading and writing to the enable
> files.
> 
> If the concern is having inconsistent implementations between tracefs
> files, I am happy to extend this patchset to all traces files, however,
> before doing so, I would like to have your approval.


Hmm, I'm still not convinced. If you redesign it, that should also
be applied to other pseudo files. "why tracefs can not read partially,
but procfs can?" I guess that can cause more confusion and will
lead unneeded debug.

> Otherwise I will just document the current functions and associated
> assumptions of use that the user must comply with in order to avoid
> the erroneous behaviour.

Yeah, I like to update the document so that user must read with enough
size of buffer. And TIPs how to read consistent data from each file.

Thank you,

> 
> Thanks a lot for your inputs and clarifications.
> Gab
> >
> > Thank you,
> >
> > >
> > > This patch fixes all the issues listed above.
> > >
> > > Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
> > > Tested-by: Alessandro Carminati <acarmina@redhat.com>
> > > ---
> > >  kernel/trace/trace_events.c | 11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> > > index 120531268abf..5e84ef01d0c8 100644
> > > --- a/kernel/trace/trace_events.c
> > > +++ b/kernel/trace/trace_events.c
> > > @@ -1798,6 +1798,13 @@ event_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
> > >
> > >       strcat(buf, "\n");
> > >
> > > +     /*
> > > +      * A requested cnt less than strlen(buf) could lead to a wrong
> > > +      * event status being reported.
> > > +      */
> > > +     if (cnt < strlen(buf))
> > > +             return -EINVAL;
> > > +
> > >       return simple_read_from_buffer(ubuf, cnt, ppos, buf, strlen(buf));
> > >  }
> > >
> > > @@ -1833,8 +1840,6 @@ event_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
> > >               return -EINVAL;
> > >       }
> > >
> > > -     *ppos += cnt;
> > > -
> > >       return cnt;
> > >  }
> > >
> > > @@ -2557,7 +2562,7 @@ static const struct file_operations ftrace_enable_fops = {
> > >       .read = event_enable_read,
> > >       .write = event_enable_write,
> > >       .release = tracing_release_file_tr,
> > > -     .llseek = default_llseek,
> > > +     .llseek = noop_llseek,
> > >  };
> > >
> > >  static const struct file_operations ftrace_event_format_fops = {
> > > --
> > > 2.48.1
> > >
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
