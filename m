Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A40212542;
	Wed,  1 Apr 2026 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054351; cv=none; b=CUobIeZTJJzAhsdgVFuKmAoMlUdN50kEYCpls4N5eMCer/W4XLWs5cpp74S2odbhasKaZ+0r5EgDidPgIAFV8SW15Y1m4/b+wt4jNI+zFNbgi36k2Xao1kvEI+8iI3EzaJ0YYRWAqKPgNxMUIw9N8xuneMncY/s8Rwd7Co4wCFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054351; c=relaxed/simple;
	bh=jcIo50MQvGZLquDxrrybnymmuv35Qkplzo1TACjlkoY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dqly9reNaLVOMRC7X29BHybGiUx4SpK9ABVe/CP8KOosPzfzquR0INb4BzPCRLCOCTcAS5TKmXyhKDM3Y5WkrcUtzwmVAxRNboS3QrQK0ptVZP+xJArUv4hhJ9nm76GZTg9ujjvg/P4Oi8kQqQ2FDrWAq3lQ9REE2ewWt/Sbv+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id F15B7BB678;
	Wed,  1 Apr 2026 14:39:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 3E93F1A;
	Wed,  1 Apr 2026 14:39:01 +0000 (UTC)
Date: Wed, 1 Apr 2026 10:40:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/3] tracing: Remove the backup instance
 automatically after read
Message-ID: <20260401104001.5461c5f0@gandalf.local.home>
In-Reply-To: <20260401121957.2665d454390aff97593bb996@kernel.org>
References: <177497473558.569199.6527680985537865638.stgit@mhiramat.tok.corp.google.com>
	<177497475349.569199.11513916633426967730.stgit@mhiramat.tok.corp.google.com>
	<20260331171936.6f84e357@gandalf.local.home>
	<20260401121957.2665d454390aff97593bb996@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: zgiqkrgtmpqfadz5f7esw4wpap45itsu
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 3E93F1A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX195wfUxamN0/v3zFUuttCix/440qDWNP4s=
X-HE-Tag: 1775054341-839768
X-HE-Meta: U2FsdGVkX1/jxoplB1lOCMBL4SkToRwZABfCD6Qj+JXDgEKMaSC17zbnQFic3F257CiHbeMMxNKr+mLJRVH3GVIRObtqo/4hw8WVbbaDd087kuszEQ5M/paWAdKh+O7caCWldBltD4ysj8nLZH5CcKyMqsV27IdGv4HwbOpfXyOGCn7dkqj8jW8d9pbdVx8j68O6Y5vPedgN9feifZOseYxtpjac0hB8Zeqx66E8jSC8HHXSq4PJ+H0gWN/ZjSCHiHqaOafTW1xhXg5m6h5z5ju+4s+KAm8NGp7ogwQQzke2KAUjwrKcD/CvMp/bOGg/te3/QjaxBF4h0udrZTSC8xUUtO5g/rTV

On Wed, 1 Apr 2026 12:19:57 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > 
> >   CPU 0							CPU 1
> >   -----							-----
> >   open(trace_pipe);
> >   read(..);
> >   close(trace_pipe);
> >      kick the work queue to delete it....
> > 						rmdir();
> > 							[instance deleted]  
> 
> I thought this requires trace_types_lock, and after kicked the queue,
> can rmdir() gets the tr? (__trace_array_get() return error if
> tr->free_on_close is set)

rmdir() doesn't use __trace_array_get(), it uses trace_array_find() which
we shouldn't need to modify.

static int instance_rmdir(const char *name)
{
	struct trace_array *tr;

	guard(mutex)(&event_mutex);
	guard(mutex)(&trace_types_lock);

	tr = trace_array_find(name);
	if (!tr)
		return -ENODEV;

	return __remove_instance(tr);
}

> 
> > 
> >   __remove_instance();
> > 
> >    [ now the tr is freed, and the remove will crash!]
> > 
> > 
> > What would prevent this is this is to use trace_array_destroy() that checks
> > this and also adds the proper locking:
> > 
> > static void trace_array_autoremove(struct work_struct *work)
> > {
> > 	struct trace_array *tr = container_of(work, struct trace_array, autoremove_work);
> > 
> > 	trace_array_destroy(tr);
> > }  
> 
> OK, let's use it.

Yes, by using trace_array_destroy(), it will fix this.

Thanks,

-- Steve
