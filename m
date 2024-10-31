Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C765D33F7;
	Thu, 31 Oct 2024 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389663; cv=none; b=h4yijU4sPRZZx42LmoJrL0RvDT2yCllB5felwk8YUVXMKfW/2XuiTDG320qJp+1Y05YMD6Gcquex0+ndq7mlmw8B8wBP6b0Qgga40chFLAFj3l2n3586f2d2OLLYuQsh3N6eIx2xy28XngzWJEYKEtLrVrffbzVh9vKAQ5nXXDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389663; c=relaxed/simple;
	bh=mciHGwhu2F/fUJvnuXHEK+qEdmcK5ZiWdPJZlVtxkag=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EF9ytjCTvBcMsl8Xkd1pL92F8PwVgueu0y8Ret9X11PLFlKr7aIAb9T3q1kWSBtDlIdzfH/2ipNvZ/Gzt4ZTZANQCVRpqFMZ356bAdXp5Sf1fpfXJY8cEW4qwQ/KOJULfEdUO4ndbN/1xUKWMtsYxs084Ee7I4MRIJdpso6pVdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0921C4CED3;
	Thu, 31 Oct 2024 15:47:42 +0000 (UTC)
Date: Thu, 31 Oct 2024 11:48:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Replace strncpy() with strscpy() when
 copying comm
Message-ID: <20241031114838.02b404ba@gandalf.local.home>
In-Reply-To: <af478335-d0ad-40d8-a827-eeb06c1f4e70@efficios.com>
References: <20241031120139.1343025-1-ruanjinjie@huawei.com>
	<af478335-d0ad-40d8-a827-eeb06c1f4e70@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 11:12:06 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -1934,7 +1934,7 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
> >   	max_data->critical_start = data->critical_start;
> >   	max_data->critical_end = data->critical_end;
> >   
> > -	strncpy(max_data->comm, tsk->comm, TASK_COMM_LEN);
> > +	strscpy(max_data->comm, tsk->comm);  
> 
> make allyesconfig + make please ?

Or at a minimum, make sure all the code you change is compiled.

-- Steve
