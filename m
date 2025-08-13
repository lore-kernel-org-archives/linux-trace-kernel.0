Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC8D268C40
	for <linux-trace-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099213; cv=none; b=Ey+Bs7ZTdmUGy7sd6R0mO1YVHYgDJFuDAPN6htWY2i7DYksAMSFVBfCKliUU3amldeGmBYXjM9EENy+2QYskq/P6/p4/liLfiymFjBsXGj9/nifrea2P9p6TY7WNyi1DWfF4DZ1O7jAbM5vJU2MmxCBBh+RphtijMkxF5S80w/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099213; c=relaxed/simple;
	bh=Oo1nxd6Ov/1CUg5rzqw6f7a6E4Pmt2QOZ5fku7GDj0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FCibEeo0gIVRTovhXIFc3es45cOIx6pCpPOIsDVaUFcXX1t/E6BGXRfglJK8TMNKFFXCtcmwHsazdZ5eDU3ptBC4xb4d+/Zy8AOjgT9RtYsA+RuIFNbvBiWN/ZxAnLZDe+QM29aQtBNHz/KLfpp2f56eJEWWejedt1RgUOJPO4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id B3CF658A2F;
	Wed, 13 Aug 2025 15:33:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 22CAD20014;
	Wed, 13 Aug 2025 15:33:22 +0000 (UTC)
Date: Wed, 13 Aug 2025 11:34:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Steven Rostedt <srostedt@redhat.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [bug report] tracing/events: add startup tests for events
Message-ID: <20250813113409.22afa127@gandalf.local.home>
In-Reply-To: <aJTL2Av9ph7vhQ_U@stanley.mountain>
References: <aJTL2Av9ph7vhQ_U@stanley.mountain>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 22CAD20014
X-Stat-Signature: inusotcggsrpcj1jfz6uq8jhiqtxos84
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+YvENs2r4Dd9To1AdKff4LEyRIqugp9WM=
X-HE-Tag: 1755099202-589885
X-HE-Meta: U2FsdGVkX1/3P9hPC4mWdR7xA2sa+NcS+5xCkFRHEkrLfbPf0Vfkh6vBhlgaql7FTC2pzcNqZ7oYro0/EQ6H5a99GuCDoFKotoB08LSDiNo54Mmv3Ar6bt/gXaGTItNcEMV67OP2Ix4V51M0uikvlXZv0TJhEWQNH7X0BT3nMhZdonRwplwFb8Srs8pTlRN7mVDEFiTzXm3K/WfRUf2EJ1riunaouLPPk5A2LBxwsvc7rU+8OqNiB62njukLRviLEnl+/TLa8BqEV8zknPfgHDVzuP8S+FbdjyRPKzH/tpzOSmHGQLB0zZvjsenJmUFwYuU+QmIY3xS7Y1TtsrvX8YneLYLPC9FcVPzhRc+ZYBSxV6STnaj3m1r5GzQ92CZL

On Thu, 7 Aug 2025 18:52:56 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> Hello Steven Rostedt,
> 
> Commit e6187007d6c3 ("tracing/events: add startup tests for events")
> from Apr 15, 2009 (linux-next), leads to the following Smatch static
> checker warning:

So this "bug" is in a selftest that has been running fine since 2009.

Yes, if things go really bad then kthread_run() could return an error, and
if it does, it means the system is having major issues at boot up.

> 
> 	kernel/trace/trace_events.c:4704 event_test_stuff()
> 	error: 'test_thread' dereferencing possible ERR_PTR()
> 
> kernel/trace/trace_events.c
>     4698 static __init void event_test_stuff(void)
>     4699 {
>     4700         struct task_struct *test_thread;
>     4701 
>     4702         test_thread = kthread_run(event_test_thread, NULL, "test-events");
>     4703         msleep(1);
> --> 4704         kthread_stop(test_thread);  
> 
> Check for if (!IS_ERR(test_thread)) ?

I'm not against taking a patch that adds a check, but I don't plan on
updating it myself.

static __init void event_test_stuff(void)
{
	struct task_struct *test_thread;

	test_thread = kthread_run(event_test_thread, NULL, "test-events");
	if (WARN_ON_ONCE(IS_ERR(test_thread)))
		return;
	msleep(1);
	kthread_stop(test_thread);
}

Would work for me.

-- Steve


> 
>     4705 }
> 
> regards,
> dan carpenter

