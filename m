Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B188032E129;
	Mon,  9 Feb 2026 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770628126; cv=none; b=hIplU1DVIJCy8BTQwcii/JRT7r4eqGCWul+8PuSPPZ91rWkdSt14oDIkD6I9unDN0OJVUQlk5oJ1dGAz/RVj43hlFjoq2LYat80GRtkViKtV2SYNUSWH/ZXm6k7uCVI+P06FrD46KuR0cvdzc/1medbfqswD9HJh9HfPQbrvbUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770628126; c=relaxed/simple;
	bh=EJqKxnI4VQyAJC8TfeIKKJxQy3Erybu1Z+Y0JPcXQpE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=T3pGa17GYV+xtsfokBrwuJLMLR6k+h0BX4ZLD6SRt9W53uKmcmJiJwBuKSbzfOZ6Eq8C8gW4aXKZ+GGv568nrrHizefa4qIKdiAHSKlJK1CZNrNalZrFhNsO7cQ1ZQhAUEOw6rjUAYard4+5MoVdY2rAQ+w4aJC8IeP+sHmjvuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoqYAYEZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoqYAYEZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DD1C116C6;
	Mon,  9 Feb 2026 09:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770628126;
	bh=EJqKxnI4VQyAJC8TfeIKKJxQy3Erybu1Z+Y0JPcXQpE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZoqYAYEZZuLs0QaYrvhMlsUniaZzuZZ3ojDxRT16Z2+oo6eLgwSgW4YkKr47zBhcg
	 1KnpXziwSiufYUZXom02BwY1Lt3LvCfKc+MU6YF1A/8mcV02gxqFhNvpWFM+dpDDFv
	 15KgtmJDbZL/Da3Cj/I7U7HBmBtc3OalqihvH3x2Y/aG9pXLknUJLYggXnmJ2QXrzZ
	 ppIalHB3fcxzBOyvHZHGIdwFo/3LU5CfmM8zxTl/zRn/Zibgyify8k9Pn51S9OMAIA
	 srW/7HsZfOogu92kQcXW3hmvn2Ck44nQM+Wcilxn5PvfpdWNUqjZB3UjFf97Tsyd9M
	 LEhbKBIZL7FFA==
Date: Mon, 9 Feb 2026 18:08:44 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] tracing: Make the backup instance non-reusable
Message-Id: <20260209180844.c582bdbb6a4a5b737db7a0a7@kernel.org>
In-Reply-To: <20260204211721.74e501f0@robin>
References: <176991653525.4025429.12655335935351822711.stgit@mhiramat.tok.corp.google.com>
	<176991655479.4025429.105619035638065215.stgit@mhiramat.tok.corp.google.com>
	<20260204211721.74e501f0@robin>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Feb 2026 21:17:21 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun,  1 Feb 2026 12:29:15 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since there is no reason to reuse the backup instance, make it
> > readonly (but erasable).
> > Note that only backup instances are readonly, because
> > other trace instances will be empty unless it is writable.
> > Only backup instances have copy entries from the original.
> > 
> > With this change, most of the trace control files are removed
> > from the backup instance, including eventfs enable/filter etc.
> > 
> >  # find /sys/kernel/tracing/instances/backup/events/ | wc -l
> >  4093
> >  # find /sys/kernel/tracing/instances/boot_map/events/ | wc -l
> >  9573
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v6:
> >    - Remove tracing_on file from readonly instances.
> >    - Remove unused writable_mode from tracing_init_tracefs_percpu().
> >    - Cleanup init_tracer_tracefs() and create_event_toplevel_files().
> >    - Remove TRACE_MODE_WRITE_MASK.
> >    - Add TRACE_ARRAY_FL_RDONLY.
> >  Changes in v5:
> >    - Rebased on the latest for-next (and hide show_event_filters/triggers
> >      if the instance is readonly.
> >  Changes in v4:
> >   - Make trace data erasable. (not reusable)
> >  Changes in v3:
> >   - Resuse the beginning part of event_entries for readonly files.
> >   - Remove readonly file_operations and checking readonly flag in
> >     each write operation.
> >  Changes in v2:
> >   - Use readonly file_operations to prohibit writing instead of
> >     checking flags in write() callbacks.
> >   - Remove writable files from eventfs.
> > ---
> >  kernel/trace/trace.c        |   94 +++++++++++++++++++++++++++++--------------
> >  kernel/trace/trace.h        |    7 +++
> >  kernel/trace/trace_boot.c   |    5 +-
> >  kernel/trace/trace_events.c |   76 ++++++++++++++++++++---------------
> >  4 files changed, 117 insertions(+), 65 deletions(-)
> > 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 5c3e4a554143..b0efcf1e0809 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -5052,6 +5052,11 @@ static ssize_t
> >  tracing_write_stub(struct file *filp, const char __user *ubuf,
> >  		   size_t count, loff_t *ppos)
> >  {
> > +	struct trace_array *tr = file_inode(filp)->i_private;
> > +
> > +	if (trace_array_is_readonly(tr))
> > +		return -EPERM;
> > +
> >  	return count;
> >  }
> >  
> > @@ -5152,6 +5157,9 @@ tracing_cpumask_write(struct file *filp, const char __user *ubuf,
> >  	cpumask_var_t tracing_cpumask_new;
> >  	int err;
> >  
> > +	if (trace_array_is_readonly(tr))
> > +		return -EPERM;
> > +
> 
> Shouldn't these checks be done in the open function? Doing it now is
> too late, as -EPERM on a write is confusing when the open for write
> succeeds.

I've made a small program and straced. Surprisingly, for the super user,
open(2) does not return error on opening a readonly file with O_RDWR.

With normal user, it returns -EACCES
-----
$ strace ./write-test hoge
execve("./write-test", ["./write-test", "hoge"], 0x7ffc30b99928 /* 73 vars */) = 0
...
openat(AT_FDCWD, "hoge", O_RDWR)        = -1 EACCES (Permission denied)
exit_group(-1)                          = ?
+++ exited with 255 +++
-----

But for the superuser case:
-----
$ sudo strace ./write-test hoge
execve("./write-test", ["./write-test", "hoge"], 0x7ffcffa80488 /* 32 vars */) = 0
...
openat(AT_FDCWD, "hoge", O_RDWR)        = 3
write(3, "test\0", 5)                   = 5
fstat(1, {st_mode=S_IFCHR|0600, st_rdev=makedev(0x88, 0x2), ...}) = 0
write(1, "write return 5\n", 15write return 5
)        = 15
exit_group(0)                           = ?
+++ exited with 0 +++

So I think we can postpone it until actual action for the superuser case.
(Anyway, I will make it return -EACCES)

Thank you,

> 
> -- Steve
> 
> >  	if (count == 0 || count > KMALLOC_MAX_SIZE)
> >  		return -EINVAL;
> >  


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
