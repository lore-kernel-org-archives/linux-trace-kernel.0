Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE537313552;
	Wed, 11 Feb 2026 18:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770834534; cv=none; b=QAUzl27ywT+hafDxwn68L+n1HqyWN0W+4HeGq9VIQMYJG3nQ0X1Xu9WUmuWhShA1sVzjQdmi3dmBvswWgZ4qN7kEH6CCCCKLrEZxKq1XNJQMKzovKHKostTtxhLzaQ9OCIn7bA6k2GdUXnmLkzE+KwgNpVljhoI8htcG+kk4thQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770834534; c=relaxed/simple;
	bh=6H4CuDX1kBeM/vEF2rxbflTE6WmGWWfMeRc6Yxcp88s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KA0oBHPz75IDPKmNHmBde9a6TBIA4Jcv1lZO4/iDlHWC3lRyzBAzw0FaVDa2o08mpKeT6xgkEyKneZynmRtYjO8MnrW31tVWB0kEicRLSY5NCjLJQuwTfSZXtSPmeJYn7fRKz5bV+o855J389e8JQtb4+vn06kMOxF0MgekkM9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id CCB9C1A04CE;
	Wed, 11 Feb 2026 18:28:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 2CB8C20029;
	Wed, 11 Feb 2026 18:28:50 +0000 (UTC)
Date: Wed, 11 Feb 2026 13:28:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/4] tracing: Reset last_boot_info if ring buffer is
 reset
Message-ID: <20260211132848.2bda172a@fedora>
In-Reply-To: <20260206225051.f22b670b54e8906a4bc1bec9@kernel.org>
References: <176991653525.4025429.12655335935351822711.stgit@mhiramat.tok.corp.google.com>
	<176991654703.4025429.9641092475053587709.stgit@mhiramat.tok.corp.google.com>
	<20260204204049.0f7dc697@robin>
	<20260206225051.f22b670b54e8906a4bc1bec9@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: zfcudbxnxhe5p497kr3hmptoi7ydhxt6
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 2CB8C20029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1989X7lX4moQyhkhRUZhP+hIz0osoc1aYs=
X-HE-Tag: 1770834530-789532
X-HE-Meta: U2FsdGVkX1/n2GyhT6S/nxxcxwVjD9L7ja9mDoiA7k2TLNvzovzAxKLWlnLUb6pm1qKL1CQepcE71IoWVltiHAE4+vCESgm9fLQfvPv1/cAiJHTbOs2mTV1N53RlrLn3kWXykAIWSOcOT1SWPS7ELbuqLvn0j0geeCAmbOSfMnEwAQBT+XnjfDbiuWUrk4M6wgvmPxQuIfoU74DQrAvWcYCfUQortvTaQy9yZGkSuUO3z/5DO33uToShBBGLE4KFPxCV9rDD79rlfAShc5XftuZRMdcQPehJLgHS4sGSAIw4rj/GIYeV/Wr692reehrY+yhocwYuEw9f+Iu5u3J6yxsyhQx6PVho1s+LsE/rBHUPGZdQNk1g0WI59CPglZMMg0r6wCsor8Kb3WKOYo/dLA==

On Fri, 6 Feb 2026 22:50:51 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Wed, 4 Feb 2026 20:40:49 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Sun,  1 Feb 2026 12:29:07 +0900
> > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> >   
> > > @@ -8036,6 +8042,7 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
> > >  				tracing_reset_online_cpus(&tr->max_buffer);
> > >  			else
> > >  				tracing_reset_cpu(&tr->max_buffer, iter->cpu_file);
> > > +			update_last_data_if_empty(tr);  
> > 
> > Is this needed? Memory mapped buffers (which the persistent ring buffer
> > is) do not have snapshot buffers.  
> 
> Yeah, I did this just for consistency. But it is better to just leave
> the comment here.
> 

I have code to move all the snapshot buffers into its own file. I'm
going to drop this one as I think leaving it makes it more confusing.

-- Steve
