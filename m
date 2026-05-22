Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA6144CF4F;
	Fri, 22 May 2026 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779467998; cv=none; b=Awb5pTC9v9IFFYmd1NFsnpfRAIpm0iD2m4EOBtZYMUdVlJZeZLuMpJOWXvLpXxXGl3NVh1rtUFHAkQi68ynVgPtrUJB5nI/hXlw5uv3WAoka6MD1LCJT4ZcIKtWOf35IhnOWzmCa5MRGQj5e3A2ELvQegnYb13PeXRnEvEYdykg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779467998; c=relaxed/simple;
	bh=BNc7MECR7hSSWzknqLlC6v4IWrnc/cJnCWwknuAZwIM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bMokNGX8FHQ0axrcMkZzityfvIyILQF/gitVZZKcpryVIiPZ4TMbygw7VOJK0NYmYLpwN8z03QpDRXmVMsuJl8o3e/uorCsa9r9zfl/I9EjFRA1ZFEhr9zRro+Q68VUWzbtPhKSQZTPu0rBM1JNC75dBGecQPu8vQk3Bv8pGG/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 2B2C5C29B6;
	Fri, 22 May 2026 16:39:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id F260832;
	Fri, 22 May 2026 16:39:49 +0000 (UTC)
Date: Fri, 22 May 2026 12:40:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ian Rogers
 <irogers@google.com>, "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>,
 "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
Subject: Re: [PATCH v20 02/10] ring-buffer: Skip invalid sub-buffers when
 rewinding persistent ring buffer
Message-ID: <20260522124012.77eb9e47@gandalf.local.home>
In-Reply-To: <20260521101742.2dd92bad@gandalf.local.home>
References: <20260520184938.749337513@kernel.org>
	<20260520185017.219342323@kernel.org>
	<20260521101742.2dd92bad@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F260832
X-Rspamd-Server: rspamout06
X-Stat-Signature: ery3683gemotwpxdmmuyjz994138djn4
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18W6KtFEroPy+JDclG1x1kTN1XuL/2bMI0=
X-HE-Tag: 1779467989-509399
X-HE-Meta: U2FsdGVkX1/mRxCUh51FxZ1PHRbkpxB/NtcCR6YTbWmhSHIJynM8x0cKNzM1uGkonLK7LPrAlTgq+U166K7Jd+4o5/R5YYqirnQjij/R7d5Q8fF9+fiJQsm9pfbX5jLaRjvHWbptPAY0SXxyjbgnxILTCpjArEWg1h4ZVvFGqQLzBH27/Wlhr2lMt806Fm5B/G1aLK04IZyQNDFdhWjxVI7wwwfhGqWA7ouy4P6beWJ0q3cuTrX7YMqnJOoX33ZyvtpSn/4o5dgcBMSjA36LbX2ws2K4lZRphJG+xcF4DxAHmtV4jWBt5Si5w6FD3DsXtU4PA6dAtGXrC4gLzrGQFfX62j8uc2eLrVqvp5JNPpkZO9sNbUMaFfd0LthilytkgUOZooOlV2tLMlirXnKN6hTmvxuk6i0U

On Thu, 21 May 2026 10:17:42 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > > +		local_set(&bpage->entries, 0);  
> > [ ... ]  
> > > @@ -1915,25 +1936,29 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
> > >  	orig_head = head_page = cpu_buffer->head_page;
> > >  	orig_reader = cpu_buffer->reader_page;
> > >  
> > > -	/* Do the reader page first */
> > > -	ret = rb_validate_buffer(orig_reader->page, cpu_buffer->cpu, meta);
> > > +	/* Do the head page first */
> > > +	ret = rb_validate_buffer(head_page, cpu_buffer->cpu, meta, 0, 0);
> > > +	if (ret < 0) {
> > > +		pr_info("Ring buffer meta [%d] invalid head page detected\n",
> > > +			cpu_buffer->cpu);
> > > +		goto skip_rewind;
> > > +	}
> > > +	ts = head_page->page->time_stamp;
> > > +
> > > +	/* Do the reader page - reader must be previous to head. */
> > > +	ret = rb_validate_buffer(orig_reader, cpu_buffer->cpu, meta, 0, ts);  
> 
> > If rb_validate_buffer() for the head page fails, we take the goto skip_rewind
> > path. Since skip_rewind jumps past this orig_reader validation, and the
> > iteration loop explicitly skips orig_reader:
> >     /* Iterate until finding the commit page */
> >     for (i = 0; i < meta->nr_subbufs + 1; i++, rb_inc_page(&head_page)) {
> >         /* The original reader page has already been checked/counted. */
> >         if (head_page == orig_reader)
> >             continue;
> > does this mean the reader page escapes validation entirely, introducing a
> > regression?  
> 
> This is a bug and needs to be fixed. If the head page is invalid it
> shouldn't skip the rewind but instead jump to the "invalid:" label.

Hmm, no it shouldn't jump to invalid, it just needs to be discarded, and
then we should skip rewind. I've changed this patch with the following:

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7291744d0216..c10cf4ba91d6 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1926,6 +1926,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	unsigned long entry_bytes = 0;
 	unsigned long entries = 0;
 	int discarded = 0;
+	bool skip = false;
 	int ret;
 	u64 ts;
 	int i;
@@ -1941,9 +1942,12 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	if (ret < 0) {
 		pr_info("Ring buffer meta [%d] invalid head page detected\n",
 			cpu_buffer->cpu);
-		goto skip_rewind;
+		/* Don't bother rewinding */
+		skip = true;
+		ts = 0;
+	} else {
+		ts = head_page->page->time_stamp;
 	}
-	ts = head_page->page->time_stamp;
 
 	/* Do the reader page - reader must be previous to head. */
 	ret = rb_validate_buffer(orig_reader, cpu_buffer->cpu, meta, 0, ts);
@@ -1957,6 +1961,9 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 		ts = orig_reader->page->time_stamp;
 	}
 
+	if (skip)
+		goto skip_rewind;
+
 	/*
 	 * Try to rewind the head so that we can read the pages which are already
 	 * read in the previous boot.

-- Steve

