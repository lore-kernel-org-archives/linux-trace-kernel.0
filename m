Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560813C0C;
	Wed, 30 Jul 2025 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753834807; cv=none; b=s1sMuWIp4A3MXuDd23KwIG1rSJX8Nf74zUMXKXSnuMx+I22Hu41cOAtY9BghAMOIi2lkj4j4M+JZ7mX7FeYBFU+vxjv6OzD7hZ6XON/BSNMQIcTXU+V+DJQgS/EGOGX9RnUqKja1F5yrsxbV/CTu6yt0LehtqmYwRtjuYGcdoGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753834807; c=relaxed/simple;
	bh=g0JC2xHN7N0cJc0XrGjRCh6w8tJJXklpdHokno9uyro=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZUr3ZiXnURv7HX0JU94dyHoijg93arvwLIqgHPfYQNzmW7lTywKnXv8xRvlivZQUaIkjshmWx1cmBaniyij6gwJo4r3V3ArrKVZ3bA4nDOY8JmfmOD7/xLBpHtyeNSDsBjHpdfNVSBVR2q0w6G4LbqXmALmv01l7Vy7ES+PuJ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2MxhTaX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2MxhTaX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8162C4CEEF;
	Wed, 30 Jul 2025 00:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753834806;
	bh=g0JC2xHN7N0cJc0XrGjRCh6w8tJJXklpdHokno9uyro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F2MxhTaXJ6M0sCsBvqFEM9FOXFskcgtNOLocGfEJ2/Y++MJGL2MeGHdetwvhiy82s
	 6EbaeGMDS/USmFBpw6w66yQa2JJXTHUk5QSI2SMId0QGLivwlqSZI19L+BUFizWemI
	 MxJCtN5aqIQOiIeEd9IpclU1+jKrA+UIKhIuPPVHNvZVe2Cr6VLWXbnSyQjFuWZvKN
	 sa5fxwl08U2wCqpLWMvV8GvQiV06GvghCHmnlZq0ImWTxw0cLWXm+KnvRnTrbWW8vj
	 95nLfSYVDXpoRMdi6TYEqt5CxcmYQh4J43mt2ObSaHZ77TrCu447Du95lpB6rWu7u5
	 m8L2EfmdYxiqw==
Date: Wed, 30 Jul 2025 09:20:03 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] tracing: Remove "__attribute__()" from the type
 field of event format
Message-Id: <20250730092003.72fdfa30ea25a451e062f08d@kernel.org>
In-Reply-To: <20250729123349.61dbcc92@batman.local.home>
References: <175376582586.1688759.2122686728240441891.stgit@mhiramat.tok.corp.google.com>
	<175376583493.1688759.12333973498014733551.stgit@mhiramat.tok.corp.google.com>
	<20250729123349.61dbcc92@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Jul 2025 12:33:49 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 29 Jul 2025 14:10:35 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> >  static void update_event_fields(struct trace_event_call *call,
> >  				struct trace_eval_map *map)
> >  {
> >  	struct ftrace_event_field *field;
> > +	const char *eval_string = NULL;
> >  	struct list_head *head;
> > +	int len = 0;
> >  	char *ptr;
> >  	char *str;
> > -	int len = strlen(map->eval_string);
> >  
> >  	/* Dynamic events should never have field maps */
> > -	if (WARN_ON_ONCE(call->flags & TRACE_EVENT_FL_DYNAMIC))
> > +	if (call->flags & TRACE_EVENT_FL_DYNAMIC)
> >  		return;
> 
> Is there a reason you removed the WARN_ON_ONCE()?

Yeah, I removed that, but maybe I misunderstood.

> 
> Even for the attribute, this shouldn't be called by dynamic events. Or
> do you know of a case?

Yeah, with this change, trace_event_update_all() is changed to call
update_event_fields() on all events even if there is no eval map.
And this trace_event_update_all() is called from the below call chain;

trace_module_notify() -> trace_module_add_evals() -> trace_event_update_with_eval_map().

So, IIUC, if there is any dynamic events on the list, and a module is
loaded, trace_event_update_all() is called.

Hmm, if so, this is really inefficient. We need to introduce build-time
sanitize routine.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
