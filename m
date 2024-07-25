Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0564C7B;
	Thu, 25 Jul 2024 19:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721934299; cv=none; b=tPKTA+C4zIjbX/fsI5D8/8O0UgTFa4ZAusApdUdXRrsdPKYPIsJJmig77iTWcwf7awIRNBWG/UAYArwdajwV3vX/t7I1Z/8CFyi71Nn/gVn4FxxKcNm+5WwGmxv5fUfU9xdPLEYXksS29zekMk0RnB+gvC33z7BLf6g9gmzNFN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721934299; c=relaxed/simple;
	bh=WwVKnek0llCOtmCYpz2ahA/Ex6X9WFQ6XqJ4xkXrFOg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QeFUAAwQEbw0nK5txT5j4IXCaSkeSgAGYEKghFISfpq6+ncgMaFxkX+eAxIM7miBHVIY8z74mv7i5smPsgr96/aDeJHrIhc7cKNdbtv3Vt1XBpCcaWyRg+B0vMRnWlmtHzCYInU5Q3HH7/KeU8MX1figF0suxZfw1aJjM0Habfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7558FC116B1;
	Thu, 25 Jul 2024 19:04:57 +0000 (UTC)
Date: Thu, 25 Jul 2024 15:05:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathias Krause <minipli@grsecurity.net>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Ilkka =?UTF-8?B?TmF1bGFww6TDpA==?=
 <digirigawa@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al
 Viro <viro@zeniv.linux.org.uk>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@leemhuis.info, Dan Carpenter
 <dan.carpenter@linaro.org>, Vasavi Sirnapalli
 <vasavi.sirnapalli@broadcom.com>, Alexey Makhalov
 <alexey.makhalov@broadcom.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Beau Belgrave <beaub@linux.microsoft.com>
Subject: Re: tracing: user events UAF crash report
Message-ID: <20240725150517.3184e078@gandalf.local.home>
In-Reply-To: <cff51d4b-80eb-4587-b4ad-bfe7d7361b19@grsecurity.net>
References: <20240719204701.1605950-1-minipli@grsecurity.net>
	<CAD2QZ9bDcQ46jOAc_Hxy6sG5-N5RPxw4zPuLK6R+M_GhxZR+=g@mail.gmail.com>
	<5083301c-6dc9-45c9-8106-da683ac6bfbb@grsecurity.net>
	<CAD2QZ9ZxZ+mjfju2JMw3fPATNNWkqT1p97QxXgeGo54AFzQ-Cw@mail.gmail.com>
	<CAD2QZ9bTrQ1p3zTZOXe6Gk4Xq8kjYSziAYAdbTrvRSZzAGPY9A@mail.gmail.com>
	<CAD2QZ9YAzq3jq8CyAcoG9YuMD9XWHbk3jKxAmszuSkJ3mtGoGw@mail.gmail.com>
	<20240725131021.788374d0@gandalf.local.home>
	<20240725131632.64cab267@gandalf.local.home>
	<cff51d4b-80eb-4587-b4ad-bfe7d7361b19@grsecurity.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 20:12:33 +0200
Mathias Krause <minipli@grsecurity.net> wrote:

> 
> >   
> >> +
> >>  	if (WARN_ON_ONCE(!schedule_work(&user->put_work))) {
> >>  		/*
> >>  		 * If we fail we must wait for an admin to attempt delete or
> >> @@ -973,6 +975,11 @@ size_t copy_nofault(void *addr, size_t bytes, struct iov_iter *i)
> >>  static struct list_head *user_event_get_fields(struct trace_event_call *call)
> >>  {
> >>  	struct user_event *user = (struct user_event *)call->data;  
> 
> Dereferencing a potentially free'd object, so 'user' is now "random" data.

This is the callback function of user->call.get_fields.

That is, we have:

	user->call.get_fields = user_event_get_fields;

And the f_start() code eventually calls trace_get_fields() that has (from a
previous email in this thread).

    trace_get_fields(struct trace_event_call *event_call)
    {
	if (!event_call->class->get_fields)
        	return &event_call->class->fields;
        return event_call->class->get_fields(event_call);
    }

Where it calls the ->class->get_fields(event_call);

that calls this function. By setting:

	user->call.get_fields = NULL;

this will never get called and no random data will be accessed.

That said, I was talking with Beau, we concluded that this shouldn't be the
responsibility of the user of event call, and should be cleaned up by the
event system.

> 
> >> +	static LIST_HEAD(head);
> >> +
> >> +	/* If the user event is about to be deleted, return no fields */
> >> +	if (!user)
> >> +		return &head;
> >>  
> >>  	return &user->fields;
> >>  }  

Here's the proper fix:

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 6ef29eba90ce..3a2d2ff1625b 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3140,8 +3140,10 @@ EXPORT_SYMBOL_GPL(trace_add_event_call);
  */
 static void __trace_remove_event_call(struct trace_event_call *call)
 {
+	lockdep_assert_held(&event_mutex);
 	event_remove(call);
 	trace_destroy_fields(call);
+	call->get_fields = NULL;
 	free_event_filter(call->filter);
 	call->filter = NULL;
 }

Can you try it out?

-- Steve
