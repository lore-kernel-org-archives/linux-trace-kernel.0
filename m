Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C773A3264C7;
	Sat,  8 Aug 2026 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786199394; cv=none; b=fcPEirRxZIjTc5ebW/EocdHOc+Fkdwc8rGvGmJt4qT3b4bFEsdrXCuWWdloMLGj2WjxEa78jf+OcTDfbYW25sXY98ZHxsEEzTgWu0GStUtCZD1n/OjHYP3F3TVRuzM6UFllRki48YJ5tnjGRAgqjDFldvLioRF6CM/kRULunkPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786199394; c=relaxed/simple;
	bh=Pi1LKybHmB8QeWC92Hc1242PpEBDtEMKCec9KK3SiX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WpeAnkUTLqmhqyfc7eSFJif+HuA68JXWI5Wr6lC2K6Tz6CFoMGnC4f5HeR47SMGHRjRCkCxdDzhQbGtyfqNQ7QL/Ixpa4oBak4CjfrgIKPZF7+WUwXgFJdjnpVMGuAwP2uTrQ7UC9iDfJYEFMNJGWmmAyNiFm/rq0kumj6coqO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 3EF56803B5;
	Sat,  8 Aug 2026 14:29:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 6AD0C1C;
	Sat,  8 Aug 2026 14:29:47 +0000 (UTC)
Date: Sat, 8 Aug 2026 10:29:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH v2] eventfs: Use children field for rcu head and add
 memory barriers
Message-ID: <20260808102946.284ec524@robin>
In-Reply-To: <20260808093755.342fb36b@robin>
References: <20260807204441.75a7db89@gandalf.local.home>
	<20260808093755.342fb36b@robin>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: xya8pgq1o9gya5wtfew5hnrzt1q1ai8i
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 6AD0C1C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18aZnRUllGsGj2ial9rA0PXO4zMdlAS+n0=
X-HE-Tag: 1786199387-654268
X-HE-Meta: U2FsdGVkX1/YJUNOfFEjURC0XUnhgxy2MztRgBSkiC4fQXidYV1dar+pToAa9ZGD09Vbrpbf462Q83WPinLMd1jpsXcyHhm42fDVMXd9DrlhQCa6eYgrwE5LVHNdDuXWKNnm9T0ntLkV5yIFyIwZQD/JPD9qINArnHXsKHycJX+JUzxwDqZEZ4vuO6YjHp4cEgs7SPHbFtgLrKY89AGuRyd2MMLHB/x6SP8hEKIgiIb9eULSjC8SfBRCzfNfyNw3FUIjfwrcsNvROdeLi99ELdGdaK39/8eKuNr/pYDZ23Px7XFUWHOlTbbj/DCOUUd/gmhhFq7silku/oyre3WGsAMVFJKRICl4VAMgL7PCA+ldI9uRWX2MguJ7r6XPT/AdvjqjgxbvdBPW/SPTncIGCWYTQ3SpEvHVFGOHulKMIo5YnVbqPnoBTMIF7c3wBIYNHpxbzn67+gJXuMDnVJfuTA==


[ Replying to Sashiko ]

> --- Patch [1]: [PATCH v2] eventfs: Use children field for rcu head and add memory barriers ---
> commit 4a672c87272cb1dcd1b1464842254420c8ac2bec
> Author: Steven Rostedt <rostedt@goodmis.org>
> 
> eventfs: Use children field for rcu head and add memory barriers
> 
> When an eventfs inode is freed, it sets ei->is_freed and adds it to the
> srcu link list. This patch changes the union of the rcu list head with
> the children list and adds memory barriers to prevent SRCU iteration
> from reading a corrupt target.
> 
> Closes: https://sashiko.dev/#/patchset/20260806022719.375354-1-shuangpeng.kernel%40gmail.com
> 
> This is a pre-existing issue, but does eventfs_iterate() in
> fs/tracefs/event_inode.c truncate ctx->pos in a way that bypasses loop
> bounds checks?
> 
> If a user uses lseek(fd, offset, SEEK_SET) to set the 64-bit loff_t
> ctx->pos to 0x100000000 (4 GiB):

This shouldn't be a problem as tracefs/eventfs uses the default
maxbytes which is defined as:

  fs/super.c:     s->s_maxbytes = MAX_NON_LFS;
  include/linux/fs.h:#define      MAX_NON_LFS     ((1UL<<31) - 1)

Which ends up being 2147483647 (0x7fffffff). I tested this using code:

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

The program was called "readdir" and I ran it like this:

~# ./readdir /sys/kernel/tracing/events/sched/sched_switch 2147483647
lseek to 7fffffff
Nothing to read

~# ./readdir /sys/kernel/tracing/events/sched/sched_switch 2147483648
lseek to 80000000
lseek: Invalid argument

~# ./readdir /sys/kernel/tracing/events/sched/sched_switch 5
lseek to 5
entry: filter

Which proves that pos will never be 0x100000000

~# ./readdir /sys/kernel/tracing/events/sched/sched_switch 0x100000000
lseek to 100000000
lseek: Invalid argument

-- Steve




> 
> fs/tracefs/event_inode.c:eventfs_iterate() {
>     ...
>     c = ctx->pos - 2;
> 
> Here, c = ctx->pos - 2 computes 0xFFFFFFFE, which is truncated into the
> 32-bit signed integer c as -2. The loop variable i then starts at -2:
> 
>     for (i = c; i < ei->nr_entries; i++, ctx->pos++) {
>         void *cdata = ei->data;
> 
>         entry = &ei->entries[i];
> 
> Per C integer promotion rules, the 30-bit unsigned bitfield ei->nr_entries
> is promoted to a signed int. The check evaluates as -2 < (int)ei->nr_entries,
> bypassing the bounds check. This allows an out-of-bounds array read on
> &ei->entries[-2], and subsequently calls entry->callback.
> 

