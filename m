Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10793264614;
	Mon, 10 Aug 2026 21:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786397959; cv=none; b=mVS2B0Df32Xw5NT/uzkSO0OytLeYjXQI89DF5RMrML8IdUVBUeG180BFI/nWz8K528GF8pcnsG0N3czhfRyx7jw0TeMSiS3CznADMzlR3ZqPCxaCs9KYyrRHigIE1JSVuNZNvBVySC+dWYalY3VemoSsyTVzhdi2SoX1lMISVVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786397959; c=relaxed/simple;
	bh=yNbKGCC+ucFp04okUhCItWlQDIYsthwzFfbBr8g1jOo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a72w29CqX43CriprBGd4OVyF6s+rgTYR1Dob/LCgUdjNmC34aatuz8qOjZOx0jZb3+XXySnoo/zenfVewfuEOe4hqkb+w4gQT2PKIB083Fw+Dv9LhLrP9O076A4QYxuddn0bS7UtfbDIOzOkWA0pHSKjlOaI9AdIymF2D4KlkpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id F002D1C0202;
	Mon, 10 Aug 2026 21:39:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 9DB8320030;
	Mon, 10 Aug 2026 21:39:13 +0000 (UTC)
Date: Mon, 10 Aug 2026 17:39:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Anubhav Shelat <ashelat@redhat.com>, Masami Hiramatsu 
 <mhiramat@kernel.org>, Shivank Garg <shivankg@amd.com>, Ackerley Tng 
 <ackerleytng@google.com>, Fuad Tabba <tabba@google.com>, Christian Brauner
  <brauner@kernel.org>, Sean Christopherson <seanjc@google.com>,
 "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>,
 "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
Subject: Re: [PATCH v3] tracefs: Add read-only eventfs filesystem at
 /sys/kernel/events
Message-ID: <20260810173923.32a42907@gandalf.local.home>
In-Reply-To: <20260810160708.3460a2fd@gandalf.local.home>
References: <20260810160708.3460a2fd@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9DB8320030
X-Stat-Signature: bz5t9osdzsds7g9jton7uennewsco1zt
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18agrxIcwZ3dt2+xFJMEeRexx0GVhnT78M=
X-HE-Tag: 1786397953-516905
X-HE-Meta: U2FsdGVkX18Z5S/d3j37m3d+vLbWFZiVmOfaAsIADd/kT77dTemCZuURQWQUBmNC70XmIhTlTF4xZldFUEcOT0e6VMkJhD8vOMoJ8ZVZvN/I1frW4GMYOuHisMCTT/jGagSDbhsyBpYIqekZHrz01oQ+B0uqHkieR5X9vc+R6ceC6IEXTi/N+0RvaN96t3ZAhyFMXEuN4N3c8uYxh1+8xG3KmN8cE8T01tX7lKPJ681SNJeF7IjGOtgSzNRYKGhwauwx14RO/kgei8mnInSNkli2iI0MbYAxv/v5dBdaDsXawxS//LtcLNhGM2YogIyyTl1awJeocRdx7UVTYIVslpqIJi8dFwYPOODeQjfRvP2pn4Py98Vqg6QxzCIG6C2tETizvh5PBPgXmceKB7bZFA==


Replying to Sashiko: https://sashiko.dev/#/patchset/20260810160708.3460a2fd%40gandalf.local.home

> --- Patch [1]: [PATCH v3] tracefs: Add read-only eventfs filesystem at /sys/kernel/events ---
> commit 5fedbb447b6c46a029edb4492a02145a903d2475
> Author: Anubhav Shelat <ashelat@redhat.com>
> 
> tracefs: Add read-only eventfs filesystem at /sys/kernel/events
> 
> This commit introduces a read-only pseudo-filesystem "eventfs" mounted at
> /sys/kernel/events, exposing trace event format and id files to unprivileged
> users. It reuses the eventfs_inode lazy-lookup infrastructure with new
> super_operations to share the tracefs inode allocator.
> 
> > diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> > index a524584353279..3af1cf5abe4ab 100644
> > --- a/fs/tracefs/event_inode.c
> > +++ b/fs/tracefs/event_inode.c
> [ ... ]
> > @@ -561,20 +653,40 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
> [ ... ]
> >  /*
> >   * Walk the children of a eventfs_inode to fill in getdents().
> >   */
> > -static int eventfs_iterate(struct file *file, struct dir_context *ctx)
> > +static int __eventfs_iterate(struct file *file, struct dir_context *ctx, bool ro)
> >  {
> >  	const struct file_operations *fops;
> >  	struct inode *f_inode = file_inode(file);
> 
> This is a pre-existing issue, but does exposing this directory iteration
> code to unprivileged users create a severe security vulnerability?
> 
> Looking at __eventfs_iterate(), there is an existing integer truncation
> when setting up the loop:
> 
> fs/tracefs/event_inode.c:__eventfs_iterate() {
>         ...
>         c = ctx->pos - 2;
>         ...
>         for (i = c; i < ei->nr_entries; i++, ctx->pos++) {
>                 ...
>                 entry = &ei->entries[i];
>                 ...
>                 r = entry->callback(name, &mode, &cdata, &fops);
> 
> If an attacker uses lseek() to set ctx->pos to 0x100000000, ctx->pos - 2
> truncates into the 32-bit signed integer 'c', resulting in c = -2.

Once again, this is not possible. That's because both eventfs and tracefs
have their super_block maxbytes set to the default which is 0x7fffffff.
Anything more than that will return an error. You can't use lseek() bigger
than that.

> 
> Since the 30-bit unsigned bitfield ei->nr_entries is promoted to a signed
> int in C, the loop condition (i < ei->nr_entries) evaluates as (-2 < 5),
> which is true.
> 
> This allows a negative index to be used in &ei->entries[i], reading
> out-of-bounds memory to find the function pointer entry->callback, which is
> then immediately executed.
> 
> Because this patch makes eventfs available to unprivileged users via the
> new 0555 mount, can this be used by any local user to trigger the
> out-of-bounds read and control-flow hijack?

With the following code:

readdir.c:
-------------------------------8<-------------------------------
#define _LARGEFILE64_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <dirent.h>

#include <sys/types.h>
#include <sys/stat.h>

int main(int argc, char **argv)
{
	unsigned long long addr;
	struct dirent *dirent;
	DIR *dir;
	char *file;
	int fd;

	if (argc != 3) {
		fprintf(stderr,"usage: %s dir addr\n",argv[0]);
		exit(-1);
	}

	file = argv[1];
	addr = strtoull(argv[2], NULL, 0);

	fd = open(file, O_RDONLY);
	if (fd < 0) {
		perror("open");
		exit(0);
	}
	printf("lseek to %llx\n", addr);
	if (lseek64(fd, addr, SEEK_SET) == (off_t)-1) {
		perror("lseek");
		exit(-1);
	}

	dir = fdopendir(fd);
	dirent = readdir(dir);
	if (!dirent) {
		printf("Nothing to read\n");
		exit(0);
	}

	printf("entry: %s\n", dirent->d_name);
	return 0;
}
------------------------------->8-------------------------------

I run:

~# ./readdir /sys/kernel/events 0x7fffffff
lseek to 7fffffff
Nothing to read

~# ./readdir /sys/kernel/events/sched 0x7fffffff
lseek to 7fffffff
Nothing to read

~# ./readdir /sys/kernel/events/sched/sched_switch 0x7fffffff
lseek to 7fffffff
Nothing to read

~# ./readdir /sys/kernel/events/ 0x100000000
lseek to 100000000
lseek: Invalid argument

~# ./readdir /sys/kernel/events/sched 0x100000000
lseek to 100000000
lseek: Invalid argument

~# ./readdir /sys/kernel/events/sched/sched_switch 0x100000000
lseek to 100000000
lseek: Invalid argument

~# ./readdir /sys/kernel/events/ 2
lseek to 2
entry: header_page

~# ./readdir /sys/kernel/events/sched 2
lseek to 2
entry: sched_wake_idle_without_ipi

~# ./readdir /sys/kernel/events/sched/sched_switch/ 2
lseek to 2
entry: format

How can we hit the condition that Sashiko is reporting?

-- Steve
