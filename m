Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD20327210;
	Fri, 30 Jan 2026 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769763699; cv=none; b=TNGC61qRQMO1eFADrvdEiljO68WEC+G8ml9KukXCdY0VGUInk+KeFsaY4XZy2VHFjE/h+jrQXLJYaDT7JBF5bnbfAHjxzZ+AoplWiUz50ICkHzY2Ofypo77TFkUyxUnn0kjLnDaZVA3ot8igtJWRg/HgVdk4rfS506Sdq9hPFjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769763699; c=relaxed/simple;
	bh=95H/wIESXikiwhcfcLOr67klTQ/qhrjEzacoy+OO0yc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Xziw9d0gw+CWIowlVwz8P4NoxGifXvEo6jpI2Q+sBiXMWaYxlE71y7T/v5V3RO1ys8PH9gqygq4Fbl6nXkCPoKQ5pCt0blm9W1sPgBabfF6eoyyL3c5Ev1vR05v53aqBJzDJPHr5YUQcw8MZSUTQ4Fo08FZ5dus01zeYBtr/JqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCWDMECu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCWDMECu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4058AC116D0;
	Fri, 30 Jan 2026 09:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769763698;
	bh=95H/wIESXikiwhcfcLOr67klTQ/qhrjEzacoy+OO0yc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UCWDMECuUWqixoMk3hOfTbD7m9P9i5e/EIoQ9Tb8pvDcneGT4tTfP2soi4KTl2eLY
	 E5a/kdggZeTkMiDrWTnFpbLH/bxPQgJHph8Xwt+1eXR6rWzunnK6PHAN5Rc8iKrP9B
	 /7OnE+W/TZsbIoxh1Mlewzd67Wj5wV5DMfhlXYx71XvZV2azM1xI4uwfp/61uXNvsP
	 6s3MT19R0qpUoJMoFoTDhBjUNxXrQ747IIfF86I3kXIKdISsRY77cP2BIPISEpk0JJ
	 /B28Vzf/U8+Dlnc5AXgB0PMb+kXIyCHhGJFl3PKai8g15Is6kcxseWeKctLDwGnt45
	 p0gNiea/owCwg==
Date: Fri, 30 Jan 2026 18:01:35 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] tracing: Make the backup instance non-reusable
Message-Id: <20260130180135.7dd5b3731bf242d8d5e907c7@kernel.org>
In-Reply-To: <20260129145333.002815e1@gandalf.local.home>
References: <176955897718.2786091.11948759407196200082.stgit@mhiramat.tok.corp.google.com>
	<176955899639.2786091.8716448298561300937.stgit@mhiramat.tok.corp.google.com>
	<20260129145333.002815e1@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jan 2026 14:53:33 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 28 Jan 2026 09:09:56 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > @@ -9388,12 +9405,16 @@ static void
> >  tracing_init_tracefs_percpu(struct trace_array *tr, long cpu)
> >  {
> >  	struct dentry *d_percpu = tracing_dentry_percpu(tr, cpu);
> > +	umode_t writable_mode = TRACE_MODE_WRITE;
> >  	struct dentry *d_cpu;
> >  	char cpu_dir[30]; /* 30 characters should be more than enough */
> >  
> >  	if (!d_percpu)
> >  		return;
> >  
> > +	if (trace_array_is_readonly(tr))
> > +		writable_mode = TRACE_MODE_READ;
> 
> Hmm, writable_mode is set but not used?

Oops, good catch! I missed to update it.

Thanks!

> 
> Looks like you missed an update.
> 
> -- Steve
> 
> > +
> >  	snprintf(cpu_dir, 30, "cpu%ld", cpu);
> >  	d_cpu = tracefs_create_dir(cpu_dir, d_percpu);
> >  	if (!d_cpu) {
> > @@ -9616,7 +9637,6 @@ struct dentry *trace_create_file(const char *name,
> >  	return ret;
> >  }


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
