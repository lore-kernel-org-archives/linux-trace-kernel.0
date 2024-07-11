Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814C71514ED
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720704068; cv=none; b=nXQB3MhXvZx+lrClKmW1c4WG8jfUS4CC2WvXvyeCuiBP22ZnBFZBzA1+yYg1V0BMPf5auvFPHF7DttwAzMKJTkGuiot4ah2IfGjRFO22qdpqwMOi3bESBfL1+/N6/YgI4IJ3OKfF38Q54wnaIS3NhBNnEa7j4RnHTrdUATuasug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720704068; c=relaxed/simple;
	bh=Uy9I9T/tN9JJUlWQ/p6H0LUGVt6skO0x/JqhCMzMy7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwB8ZHKNqzAGl/eqxHcKHcOiOoIF9MZZJyy2gqI1vZcCScBlJMoTFfvtzhtMFeYHTxM/uzx+nfkrk0huF5q7YXky0WlQkfwsRpowWnRzYUzDpoAhgsVdo0Q1rUE8WhhCIlosdlhR6qtAjoEHLHFgsp6S1Syc+xUIbyJL+1XESew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dg2VxaQx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dg2VxaQx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720704066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zCgO4S5Trmscfbn2cBjRYOQFsKPBWlxEUZ+TlU9yQ9Q=;
	b=Dg2VxaQxAcigrsp0aIjUVv8TUkhDWkK+q0zzTlZi7Id22+WZGu9F0pk+N2wWL2Q6iSC/Av
	l+xuPGsFGlJfnYAEvak3uJp7pUa7A1hI77GO1HIWHbEIvRiTyBdT6CHbKx5qPWitj1TMjH
	asBeH6LEnuqdCeZMlfNFsATnAKGxK+M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-IDrcX-ZUOW-EIF2bPrWOaA-1; Thu,
 11 Jul 2024 09:21:03 -0400
X-MC-Unique: IDrcX-ZUOW-EIF2bPrWOaA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 306381955BC7;
	Thu, 11 Jul 2024 13:21:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.32])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 39A7019560AA;
	Thu, 11 Jul 2024 13:20:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 11 Jul 2024 15:19:24 +0200 (CEST)
Date: Thu, 11 Jul 2024 15:19:19 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, jolsa@kernel.org, clm@meta.com,
	paulmck@kernel.org
Subject: Re: [PATCH v2 11/11] perf/uprobe: Add uretprobe timer
Message-ID: <20240711131918.GC16902@redhat.com>
References: <20240711110235.098009979@infradead.org>
 <20240711110401.412779774@infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711110401.412779774@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Not sure I read this patch correctly, but at first glance it looks
suspicious..

On 07/11, Peter Zijlstra wrote:
>
> +static void return_instance_timer(struct timer_list *timer)
> +{
> +	struct uprobe_task *utask = container_of(timer, struct uprobe_task, ri_timer);
> +	task_work_add(utask->task, &utask->ri_task_work, TWA_SIGNAL);
> +}

What if utask->task sleeps in TASK_STOPPED/TASK_TRACED state before
return from the ret-probed function?

In this case it won't react to TWA_SIGNAL until debugger or SIGCONT
wakes it up.

---------------------------------------------------------------------------
And it seems that even task_work_add() itself is not safe...

Suppose we have 2 ret-probed functions

	void f2() { ... }
	void f1() { ...; f2(); }

A task T calls f1(), hits the bp, and calls prepare_uretprobe() which does

	mod_timer(&utask->ri_timer, jiffies + HZ);

Then later it calls f2() and the pending timer expires after it enters the
kernel, but before the next prepare_uretprobe() -> mod_timer().

In this case ri_task_work is already queued and the timer is pending again.

Now. Even if T goes to the exit_to_user_mode_loop() path immediately, in
theory nothing can guarantee that it will call get_signal/task_work_run
in less than 1 second, it can be preempted.

But T can sleep in xol_take_insn_slot() before return from handle_swbp(),
and this is not so theoretical.

Oleg.

