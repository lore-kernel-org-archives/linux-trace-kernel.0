Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2136C2040A8
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Apr 2025 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744275224; cv=none; b=Vr7k/AQSMm666vKcZDWfx+ssjyuIKQzdxyjta+8lwxhr2cbe9s+PkL+KjnDJXD5QcXenBlUz8EzeUC/wvSuOrOqzjMBWFReG50R/q4FHOpxi6H3rXcLqHf3lXSudWpsXTufv6eDixO0uEA5GJc+cuy5dmIaqp4lYKUqyz1Tbubs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744275224; c=relaxed/simple;
	bh=fVLSQBRdXbHr2MS5+vi7RGVvfjmTrBOZyZlbctzX2cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eDNWMj+vcFxrlUSxsuNoF7NVgpuLfiAZM60CXQXlH0NcHMGJY2WJytUItJf3hOa7pL59eiXQKoPqTuAzoLTqMqVII7oXPLdJ+yw9+uK8FTKmsoaCu0633puUZWqEXfjCU4aG6+9Ncypt8AMMlwG79qSNw6Vj3xY7tLWhHco0m0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TCpTonVv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCpTonVv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744275220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1SmiyRMjzQQqXjsSoU5Im9okCaP3DYrJ1REzbecGMgA=;
	b=TCpTonVvuigIvCbx17poL+0fkQIE/fhaY6Fuyr3aIjeh2vc9gTPTQjmbjrM955xPFeJafS
	aGUUv7Bi7PfETgKHsMC7S8SQzm8X4cDwwhkD3Iiu+0oEGoPfmF9eAGnZ3eRcd7wmRy/M/Z
	fXxX31WdfEOactaNXgh3eTfRmxx8cSY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-E8_n8n9DMSGPhT_Lz9ltlg-1; Thu, 10 Apr 2025 04:53:38 -0400
X-MC-Unique: E8_n8n9DMSGPhT_Lz9ltlg-1
X-Mimecast-MFC-AGG-ID: E8_n8n9DMSGPhT_Lz9ltlg_1744275218
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d00017e9dso4305985e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Apr 2025 01:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744275217; x=1744880017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SmiyRMjzQQqXjsSoU5Im9okCaP3DYrJ1REzbecGMgA=;
        b=feyS3BZ4E4r2sszbCGHKfyzcXV1Uwkc4bWrsaH6hNqXEjoJcchUZQWHcBdBp55RPBY
         fMDhz9g3IjoAuSN1PYWTZHKys1WCJVuU2+hsSw3VOIheFp/OL4ysbNYN4Ipp5la39ckx
         8DnHHMzdScJTcNfzFQxMN4B5x0+yq6E/6OuJVPfIF6AYtK7bSsVMk3ZajF009f4vh3xJ
         Tx3DJ+Iw8gmZl8QMJAG6h93eDfiqTJLmQLWl2gf5IAu8zxDsNIF3JwN5xxtlZjpBd05t
         ov+gERVs60gQb36q+4AMG+EDjIEkACRxbKdZHs6hQT4PRdW0HsU14gN61RNNzvUEnB3F
         lQDw==
X-Forwarded-Encrypted: i=1; AJvYcCVKR61wTkEHTv4qUAWb7JPdN6gz3/XQBxK8maJlj79hWTJTE/SFClyN44CRtFfwVQV9u5Z0fGUSPMlQnM0uHXUiDr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFVZgeji7WxZiAFkrPX8R0F/OQuYDI6EPAw8zAmG9Ssh6h82ld
	1WKCEn9izhXiUULlvuY9qppRKMrSr5pJLUp+jP+YFQ2PqC+MuYtqzn4WlT/qOCoC6feLKGnp0qA
	KuQtK0FJfO7iqCS0wXQvCQj/muYh9NVuN3rPoI+StYJnIpUpmn2DgsERRY86LYsvYvp4B+Q==
X-Gm-Gg: ASbGnctfatFhzD4oXpsdymTNcfrXdi0xCZ9TTiYcPwySnw7/H6G5MfBQBuz4i3WlYVB
	mjNp0+QuwZJSnjZnbYnp40bjmOJROCbICQspcGq7jnBAxvMQuJyaRPzuG7hgwW4K4tE4C4pIxZ5
	RwCOK8/1Gq7m3+hZWcue80FsY4X3i+aw0ADz7DdK+iGTWVEXXWcko4/Ctq+7hRSSNL+yegJI0WL
	u0GFUiQno+f8pRJ2Kgt/VFz5aQLFwdLYJ/P1DvlV1LxhlLtj+f72fhiUtWVoL2rMFsAzagIGEWA
	dBERO43IJX3587/RvOWenTzYcN1YEBHpz/RQ3i65hTA=
X-Received: by 2002:a05:600c:3b0d:b0:43c:ea40:ae4a with SMTP id 5b1f17b1804b1-43f2d98b709mr23626995e9.31.1744275217430;
        Thu, 10 Apr 2025 01:53:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkgjS6DJy42J7oCRD/T/lyrUvWYjKsmRJi3sXXVt5rMwqXTVWXcayHO7ebX6QAYtA3nxJyWA==
X-Received: by 2002:a05:600c:3b0d:b0:43c:ea40:ae4a with SMTP id 5b1f17b1804b1-43f2d98b709mr23626755e9.31.1744275217030;
        Thu, 10 Apr 2025 01:53:37 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.22.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893f0a75sm4175687f8f.62.2025.04.10.01.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 01:53:36 -0700 (PDT)
Date: Thu, 10 Apr 2025 10:53:34 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>
Subject: Re: [RFC PATCH 9/9] rv: Add srs per-task monitor
Message-ID: <Z_eHDlLIG2SZwyfY@jlelli-thinkpadt14gen4.remote.csb>
References: <20250404084512.98552-11-gmonaco@redhat.com>
 <20250404084512.98552-20-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250404084512.98552-20-gmonaco@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NVA1bqBeMOwBk3YRE5C7GiOfR4xDDQaP60agmPwZrDg_1744275218
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Gabriele,

On 04/04/25 10:45, Gabriele Monaco wrote:
> Add a per-task monitor for task switches as part of the sched model:
> 
> * srs:
>     Monitor to describe conditions for different types of task switch.
>     This monitor enforces rules such as preempt after setting need
>     for reschedule and suspend after setting a task to sleepable.
> 
> This new monitor implies the previously introduced snroc (set non
> runnable on its own context), so replace that monitor with srs.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---

...

> +Monitor srs
> +-----------
> +
> +The switch after resched or sleep (srs) monitor describes conditions for
> +different types of task switch. This is a complex model, below we are going to

Quite the ASCII art indeed. :-)

> +explain it step by step. Unfortunately splitting this into smaller monitor is
> +not trivial due to some shared events such as ``switch_in``::

Not splitting, but maybe providing several separate diagrams for the key
cases and transitions might help grasping the complete picture? Not
sure, just a thought.

In the below, set_{sleepable,runnable} corresponds to set_state_
{sleepable,runnable} in the code, does it? Not a big deal, but I was
confused at first.

Thanks,
Juri

> +
> +                                                      set_runnable
> +                                  |                        wakeup +---+
> +                                  |                   switch_vain |   |
> +                                  v                               |   v      wakeup
> +                         #================================================#  set_runnable
> +      switch_in          H                                                H <----------+
> +    +------------------> H                    running                     H            |
> +    |                    H                                                H -----+     |
> +    |                    #================================================#      |     |
> +    |                         |        |                |         ^    ^         |     |
> +    |                         |  switch_yield      need_resched   |    |         |     |
> +    |                         |        |      need_resched_lazy   |    |         |     |
> +    |                set_sleepable     v                |         |    |         |     |
> +    |                         |      +-------------+    |         |    |         |     |
> +    |                +--------+----> |  preempted  | ---+- switch_in   |         |     |
> +    |                |        |      +-------------+    |              |         |     |
> +    |        switch_preempt   |        |                |              |         |     |
> +    |        switch_yield     |   need_resched          |   +- switch_vain       |     |
> +    |                |        |        v                |   |                    |     |
> +    |                |        |      +-------------+    |   |                    |     |
> +    |  need_resched -+--------+----> | resched_out |    |   |                    |     |
> +    |  |             |        |      +-------------+    |   |                    |     |
> +    |  |             |        |        |                |   |     need_resched   |     |
> +    |  |             |        |    switch_in            |   |     wakeup         |     |
> +    |  |             |        |        v                v   |     set_runnable   |     |
> +    |  |             |        |      +--------------------------+ -------+       |     |
> +    |  |             |        |      |                          |        |       |     |
> +    |  |             +--------+----- |       rescheduling       | <------+       |     |
> +    |  |                      |      |                          |                |     |
> +    |  |                      |      +--------------------------+ -----------+   |     |
> +    |  |                      |        |           ^ wakeup                  |   |     |
> +    |  |                      |  set_sleepable   set_runnable                |   |     |
> +    |  |                      |        v           |                         |   |     |
> +    |  |   +------------------+----- +---------------------------+           |   |     |
> +    |  |   |                  |      |                           |           |   |     |
> + +--+--+---+------------------+----> |     resched_sleepable     | ---+      |   |     |
> + |  |  |   |                  |      |                           |    |      |   |     |
> + |  |  |   |    +-------------+----> +---------------------------+    |      |   |     |
> + |  |  |   |    |             |        |           ^      |           |      |   |     |
> + |  |  |   |    |             |  switch_preempt    | need_resched     |      |   |     |
> + |  |  |   |    |             |        |           | set_sleepable    |      |   |     |
> + |  |  |   |    |             |        v           +------+           |      |   |     |
> + |  |  |   |    |             |       +---------------------------+ --+------+---+-----+--+
> + |  |  |   |    |             |       |    preempted_sleepable    |   |      |   |     |  |
> + |  |  |   |    |             |       +---------------------------+ --+------+---+--+  |  |
> + |  |  |   |    |             |         |             ^               |      |   |  |  |  |
> + |  |  |   |    |             |     switch_in   switch_preempt        |      |   |  |  |  |
> + |  |  |   |    |             |         v             |          switch_vain |   |  |  |  |
> + |  |  |   |    |             |        +-------------------------+    |      |   |  |  |  |
> + |  |  |   |    |             +------> |                         | <--+      |   |  |  |  |
> + |  |  |   |    |                      |        sleepable        |           |   |  |  |  |
> + |  |  |   |    +- need_resched------- |                         | ----------+---+--+--+  |
> + |  |  |   |       need_resched_lazy   +-------------------------+           |   |  |     |
> + |  |  |   |                              |      ^      |          switch_block  |  |     |
> + |  |  |   |                              |      | set_sleepable             |   |  |     |
> + |  |  |   |                      switch_block   | switch_vain    +----------+   |  |     |
> + |  |  |   |                    switch_suspend   +------+         |              |  |     |
> + |  |  |   |                              v                       v              |  |     |
> + |  |  |   |   switch_block          +-----------------------------+  switch_block  |     |
> + |  |  |   +-switch_suspend--------> |          sleeping           | <-----------+  |     |
> + |  |  |                             +-----------------------------+                |     |
> + |  |  |                               | wakeup                                     |     |
> + |  |  |                               v                                            |     |
> + |  |  +- need_resched ------------- +-------------+  wakeup                        |     |
> + |  |                                |   waking    | <------------------------------+     |
> + |  +------------------------------- +-------------+                                      |
> + |                                                                                        |
> + |                         +-----------------------+                                      |
> + +----- switch_in -------- | resched_out_sleepable | <-- sched_need_resched --------------+
> +                           +-----------------------+
> +
> +Types of switches:
> +
> +* ``switch_in``:
> +  a non running task is scheduled in, this leads to ``running`` if the task is
> +  runnable and ``sleepable`` if the task was preempted before sleeping.
> +* ``switch_suspend``:
> +  a task puts itself to sleep, this can happen only after explicitly setting
> +  the task to ``sleepable``. After a task is suspended, it needs to be woken up
> +  (``waking`` state) before being switched in again. The task can be set to
> +  ``resched_sleepable`` via a ``need_resched`` but not preempted, in which case it
> +  is equivalent to ``sleepable``.
> +  Setting the task's state to ``sleepable`` can be reverted before switching if it
> +  is woken up or set to runnable.
> +* ``switch_blocked``:
> +  a special case of a ``switch_suspend`` where the task is waiting on a
> +  sleeping RT lock (``PREEMPT_RT`` only), it is common to see wakeup and set
> +  state events racing with each other and this leads the model to perceive this
> +  type of switch when the task is not set to sleepable. This is a limitation of
> +  the model in SMP system and workarounds may require to slow down the
> +  scheduler.
> +* ``switch_yield``:
> +  a task explicitly calls the scheduler, this looks like a preemption as the
> +  task is still runnable but the ``need_resched`` flag is not set. It can
> +  happen after a ``yield`` system call or from the idle task.
> +* ``switch_preempt``:
> +  a task is ``preempted``, this can happen after the need for ``rescheduling``
> +  has been set, also in its ``lazy`` flavour. ``need_resched`` can be set as a
> +  flag to the task or in the per-core preemption count, either of them can
> +  trigger a preemption.
> +  The task was previously running and can be switched in directly, but it is
> +  possible that a task is preempted after it sets itself as ``sleepable``
> +  (``preempted_sleepable``), in this condition, once the task is switched back
> +  in, it will not be ``running`` but continue its sleeping process in
> +  ``sleepable``.
> +* ``switch_vain``:
> +  a task goes through the scheduler but it is picked as the next task to run,
> +  hence no real task switch occurs. Since we run the scheduler, this clears the
> +  need to reschedule.
> +

...

> +enum events_srs {
> +	sched_need_resched_srs = 0,
> +	sched_need_resched_lazy_srs,
> +	sched_set_state_runnable_srs,
> +	sched_set_state_sleepable_srs,
> +	sched_switch_blocking_srs,
> +	sched_switch_in_srs,
> +	sched_switch_preempt_srs,
> +	sched_switch_suspend_srs,
> +	sched_switch_vain_srs,
> +	sched_switch_yield_srs,
> +	sched_wakeup_srs,
> +	event_max_srs
> +};
> +

