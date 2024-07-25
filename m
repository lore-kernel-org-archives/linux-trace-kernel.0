Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AF9131E38;
	Thu, 25 Jul 2024 23:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721948773; cv=none; b=FvbJd+b9Wq/ZgERYAwNNJwBibggn/Km/CAe0ULB3tSKa0aReWx5rDInD7i6rxZN2TqIuSCGEjov3WhZtn6LBwP/i7Mq2/hra8jbWb7AYlNESpc1P3sJScC6vbtwslq7AxOlEq5R+uegfQExJabAT/yQogxPWP91wgJkD5/V3cfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721948773; c=relaxed/simple;
	bh=GQ44ueZPDL1u8vh1JS5SlJF8AZnKpW0TAjJWT8PZGhc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=etPIgjam3BtAHKk+ahq5knD1Abh1g1NnzD3fpBkYg03pMs+cziW5oZ93OUQHyCZaqQKqFOMcKEhPSinY0n9WLdJNH4ioONebdLw3CZUaJG5U45f2euFzg3Iznk9vaZJqZlESPix6fsnXHs9dj5gOFQwsWYOhf/aGp5L0PhSekRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF851C116B1;
	Thu, 25 Jul 2024 23:06:11 +0000 (UTC)
Date: Thu, 25 Jul 2024 19:06:32 -0400
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
Message-ID: <20240725190632.2755cb70@gandalf.local.home>
In-Reply-To: <a7d66736-80d3-4f3d-9cca-ec46e019b4cb@grsecurity.net>
References: <20240719204701.1605950-1-minipli@grsecurity.net>
	<CAD2QZ9bDcQ46jOAc_Hxy6sG5-N5RPxw4zPuLK6R+M_GhxZR+=g@mail.gmail.com>
	<5083301c-6dc9-45c9-8106-da683ac6bfbb@grsecurity.net>
	<CAD2QZ9ZxZ+mjfju2JMw3fPATNNWkqT1p97QxXgeGo54AFzQ-Cw@mail.gmail.com>
	<CAD2QZ9bTrQ1p3zTZOXe6Gk4Xq8kjYSziAYAdbTrvRSZzAGPY9A@mail.gmail.com>
	<CAD2QZ9YAzq3jq8CyAcoG9YuMD9XWHbk3jKxAmszuSkJ3mtGoGw@mail.gmail.com>
	<20240725131021.788374d0@gandalf.local.home>
	<20240725131632.64cab267@gandalf.local.home>
	<cff51d4b-80eb-4587-b4ad-bfe7d7361b19@grsecurity.net>
	<20240725150517.3184e078@gandalf.local.home>
	<0d1a8c46-43a7-42d6-bcbf-647a5a68c3c5@grsecurity.net>
	<20240725161519.35fd3bd6@gandalf.local.home>
	<1b1b09fa-0064-429c-9f78-385119c5e691@grsecurity.net>
	<20240725171459.598d9500@gandalf.local.home>
	<a7d66736-80d3-4f3d-9cca-ec46e019b4cb@grsecurity.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 23:32:30 +0200
Mathias Krause <minipli@grsecurity.net> wrote:

> That was for a single run of
> tools/testing/selftests/user_events/ftrace_test with the read loop of
> /sys/kernel/tracing/events/user_events/__test_event/format in a
> different shell.
> 
> > 
> > destroy_user_event() which is under event_mutex calls
> > user_event_set_call_visible() with false, that will then call:
> > 
> > trace_remove_event_call() -> probe_remove_event_call() ->
> >  __trace_remove_event_call() -> event_remove() ->
> >  remove_event_from_tracers()
> > 
> > Where remove_event_from_tracers() loops over all the instances and will set
> > each of the file pointers flags associated to the event: EVENT_FILE_FL_FREED
> > 
> > Then it returns back to destroy_user_event() that would free the event.
> > 
> > The f_start() that was in your crash, with the new patch, should take the
> > event_mutex before referencing the event that was freed. And with that flag
> > being set, it should exit out.  
> 
> Looking at the very first report:
> 
> [   76.306946] BUG: KASAN: slab-use-after-free in f_start+0x36e/0x3d0
> 
> That's what faddr2line gives me:
> 
> f_start+0x36e/0x3d0:
> f_start at kernel/trace/trace_events.c:1637 (discriminator 1)
> 
> Which is:
> 1635     mutex_lock(&event_mutex);
> 1636     file = event_file_data(m->private);
> 1637     if (!file || (file->flags & EVENT_FILE_FL_FREED))
> 1638         return ERR_PTR(-ENODEV);

BAH! I finally figured it out.

I was able to reproduce it and this does stop the UAF from happening.

The issue was, as a short cut, I had the "format" file's i_private point to
the "call" entry directly, and not go via the "file". This is because the
all format files are the same for the same "call", so no reason to
differentiate them.  The other files maintain state (like the "enable",
"trigger", etc). But this means if the file were to disappear, the "format"
file would be unaware of it.

This should fix it for you. It fixed it for me.

-- Steve


diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 6ef29eba90ce..852643d957de 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1540,7 +1540,8 @@ enum {
 
 static void *f_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct trace_event_call *call = event_file_data(m->private);
+	struct trace_event_file *file = event_file_data(m->private);
+	struct trace_event_call *call = file->event_call;
 	struct list_head *common_head = &ftrace_common_fields;
 	struct list_head *head = trace_get_fields(call);
 	struct list_head *node = v;
@@ -1572,7 +1573,8 @@ static void *f_next(struct seq_file *m, void *v, loff_t *pos)
 
 static int f_show(struct seq_file *m, void *v)
 {
-	struct trace_event_call *call = event_file_data(m->private);
+	struct trace_event_file *file = event_file_data(m->private);
+	struct trace_event_call *call = file->event_call;
 	struct ftrace_event_field *field;
 	const char *array_descriptor;
 
@@ -1627,12 +1629,14 @@ static int f_show(struct seq_file *m, void *v)
 
 static void *f_start(struct seq_file *m, loff_t *pos)
 {
+	struct trace_event_file *file;
 	void *p = (void *)FORMAT_HEADER;
 	loff_t l = 0;
 
 	/* ->stop() is called even if ->start() fails */
 	mutex_lock(&event_mutex);
-	if (!event_file_data(m->private))
+	file = event_file_data(m->private);
+	if (!file || (file->flags & EVENT_FILE_FL_FREED))
 		return ERR_PTR(-ENODEV);
 
 	while (l < *pos && p)
@@ -2485,7 +2489,6 @@ static int event_callback(const char *name, umode_t *mode, void **data,
 	if (strcmp(name, "format") == 0) {
 		*mode = TRACE_MODE_READ;
 		*fops = &ftrace_event_format_fops;
-		*data = call;
 		return 1;
 	}
 
-- 
2.43.0

