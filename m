Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2568A14A82;
	Thu, 25 Jul 2024 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721927774; cv=none; b=JsTCy+JmZ5M/nap/LNLutCza0EQdz2h632i1Yj1f/T73P3xuLFXdzDwI20ZLPc/diTg7CEFb+yLKaLNFjqyySHfKyMVJ8fCv8ayuiqAGTHaqkROwOj5RSXgz41OObgK4kK2nKU+bxk77gkUXlKMI3F3AP/PVM3gN0Z6VJo44E6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721927774; c=relaxed/simple;
	bh=WbAzZRlEYkN2KDT4LrhkDUIkqp+bsK1buji5VXHRhVY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRvcOHFnxs8fdwl3BwmBywEHeEbfE7rxXl3W/1f1D6b/CIzRCMfYtnrQE3RzFR6+fp1jaYwmN2zPBlMMYNamnbCwA48TAWzxeBXoezgm4fBsgmJN258WMYqGnxb4QCLPCXbDAXlfiaBe0SLXr48j8LjSrqmZI5sEhYNH1cWdbis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD13C116B1;
	Thu, 25 Jul 2024 17:16:12 +0000 (UTC)
Date: Thu, 25 Jul 2024 13:16:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: Mathias Krause <minipli@grsecurity.net>, Masami Hiramatsu
 <mhiramat@kernel.org>, Ilkka =?UTF-8?B?TmF1bGFww6TDpA==?=
 <digirigawa@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al
 Viro <viro@zeniv.linux.org.uk>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@leemhuis.info, Dan Carpenter
 <dan.carpenter@linaro.org>, Vasavi Sirnapalli
 <vasavi.sirnapalli@broadcom.com>, Alexey Makhalov
 <alexey.makhalov@broadcom.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>
Subject: Re: tracing: user events UAF crash report
Message-ID: <20240725131632.64cab267@gandalf.local.home>
In-Reply-To: <20240725131021.788374d0@gandalf.local.home>
References: <20240719204701.1605950-1-minipli@grsecurity.net>
	<CAD2QZ9bDcQ46jOAc_Hxy6sG5-N5RPxw4zPuLK6R+M_GhxZR+=g@mail.gmail.com>
	<5083301c-6dc9-45c9-8106-da683ac6bfbb@grsecurity.net>
	<CAD2QZ9ZxZ+mjfju2JMw3fPATNNWkqT1p97QxXgeGo54AFzQ-Cw@mail.gmail.com>
	<CAD2QZ9bTrQ1p3zTZOXe6Gk4Xq8kjYSziAYAdbTrvRSZzAGPY9A@mail.gmail.com>
	<CAD2QZ9YAzq3jq8CyAcoG9YuMD9XWHbk3jKxAmszuSkJ3mtGoGw@mail.gmail.com>
	<20240725131021.788374d0@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 13:10:21 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 3a2b46847c8b..e9ed2826ff46 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -321,6 +321,8 @@ static void user_event_put(struct user_event *user, bool locked)
>  	 */
>  	refcount_set(&user->refcnt, 1);
>  
> +	user->call.data = NULL;

Hmm, it may be possible to just have:

	user->call.get_fields = NULL;

and then it will just use the call->class->fields instead and that should
be initialized to empty.

-- Steve


> +
>  	if (WARN_ON_ONCE(!schedule_work(&user->put_work))) {
>  		/*
>  		 * If we fail we must wait for an admin to attempt delete or
> @@ -973,6 +975,11 @@ size_t copy_nofault(void *addr, size_t bytes, struct iov_iter *i)
>  static struct list_head *user_event_get_fields(struct trace_event_call *call)
>  {
>  	struct user_event *user = (struct user_event *)call->data;
> +	static LIST_HEAD(head);
> +
> +	/* If the user event is about to be deleted, return no fields */
> +	if (!user)
> +		return &head;
>  
>  	return &user->fields;
>  }

