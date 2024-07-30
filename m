Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B7328EB;
	Tue, 30 Jul 2024 00:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722297745; cv=none; b=SYtVH92b7BRUcvUNZZxaMYsCIJDmKMOT0pwFyX6Y1q2xA5dQmXfvlTqUy0BwipUTIXV1oNZrjaCncXVPOnAOQi94MVRp431TKT9paqkDvmGmGP6ZXpAHmNn85KL2B5NvdKCxh5khPAuW445T4TF6uq0Ju/xm4ZK6IUUsQILiJJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722297745; c=relaxed/simple;
	bh=66w/099e5tHE8mUELUbU71wiwXB947RM/RzP19wVSpM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RcxQQlZJ7PV8PIAz3Z+N1/bQbTReBKcV0CrKi+K6vVVCc5l2BL3iKTljqVJI3mEeNXX+9oiQ3aSrSbs2mMGMlbtYgvnUvBWW/Nn2tqI1dhWYhds6HMRLJevBGH6EmvVfyhzKfsihvGsxSdP3GI8515skXs7Rnf4xDffjr8tKCxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8g5j7lX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8g5j7lX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E3AC4AF07;
	Tue, 30 Jul 2024 00:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722297744;
	bh=66w/099e5tHE8mUELUbU71wiwXB947RM/RzP19wVSpM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I8g5j7lXjnbkRHn1prjviT2kFlagmdY5ItmVVolyVnh6nC91/QMROD5yfC2lf5bzb
	 fnfz3HqW6L6E4P0rGCAtHMJL5D440a0IXYLIhLdRNy5ir16+UcTpgRFb8SoYcHLp1P
	 I5xGTJij5fO0kv4AWhDxOUuV8ZAUCxapNuMt2ZPOUQGAN8DbLV9z3FOaBtgPhavKG9
	 995iKq45fM4dGdLAr0lVv7WShJDKCEvtrpQRfwjH57CoKV7Ak2YvwLQ0a3d9ek3QA6
	 RcNMT9rGMXnJVoog/zVejEdu/uMM78+heafl3o/1vi5pEEACyKA0tRJOsi57t8wKCX
	 yZJbMuDAx51cw==
Date: Tue, 30 Jul 2024 09:02:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Use refcount for trace_event_file reference
 counter
Message-Id: <20240730090221.7fea5eaedddce5de4e43914a@kernel.org>
In-Reply-To: <20240729190241.47e52c05@rorschach.local.home>
References: <20240726144208.687cce24@rorschach.local.home>
	<20240729234924.6accc2e6216e3b7be1a97e61@kernel.org>
	<20240729190241.47e52c05@rorschach.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jul 2024 19:02:41 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 29 Jul 2024 23:49:24 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Fri, 26 Jul 2024 14:42:08 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > From: Steven Rostedt <rostedt@goodmis.org>
> > > 
> > > Instead of using an atomic counter for the trace_event_file reference
> > > counter, use the refcount interface. It has various checks to make sure
> > > the reference counting is correct, and will warn if it detects an error
> > > (like refcount_inc() on '0').
> > > 
> > > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> > 
> > Looks good to me.
> > 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Is that an ack or a review? ;-)

It was Ack,

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sorry about that. I might be too sleep.

> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
