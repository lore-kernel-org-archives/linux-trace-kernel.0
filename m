Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF0C1B87CC;
	Wed, 19 Feb 2025 19:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739991880; cv=none; b=X/WFkorYdzZH9uqX1wP0i1oOmuNJrND3BWom/16H6/3vFOVlgtNlVqinkT3z15eeD7vQFBpXnrMyVcohSEU3p2AMCqM5zGBKASiAgtXcJiNFdCaByWZ/4jsuCObcyRBHw82dQ3HHtiRa3HyNS5COam64u+tU4gqF19znKDV13kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739991880; c=relaxed/simple;
	bh=4M979/zknqfwn9KA6giWEkTlaD7NNAUMousUqydFL5Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cLlbSb9pWjeAb7TIAsx+aBxWo+D0aoteLcPl7mckNEr/etixxtMjR0EcNDh6z1QnONXIULWNOiFtUU8AE0+IWWQYzHMqVIwGHNNveAmwp4jxPQgEdpbAcF+uMEfNBUpW/6wX/9aCs6z4ixIFGUdZKuXKWDhlDtiPkLOo7YJMTn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKV865bG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKV865bG"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-221206dbd7eso1015715ad.2;
        Wed, 19 Feb 2025 11:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739991878; x=1740596678; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrDlJ2AvMdUxp/age4FgO4Czj+vcMNDLiz2S2LoiMVU=;
        b=kKV865bGhc8vlkWkXtzKdJ66H7KOXXUjPBEjgE0cjEYZX/MedOCwsI9I9FI2Z1Uvpj
         JX81YyL9wgKWS9Cfv53vuCVwjyFqFD9xBY00TOAcnRPazoZodewcLTLgspOBCHmYcFQA
         UfhOZBeMqrOahENUnQqv6zMEAdDFnNvPFu3L6dVK5CqtRFsc+spK87yGRD0MkNNJ3OUR
         wGoo4jbVRVF5EwV7Uf3xKDTR6QYKBvame7cGGXPoSMTohGGRrmu+BBoUR87BKQpdiXBb
         0szTD3HGUw6/0hzdQ+cDHaurM1Ghay/3/6Y56DbiMB+Y166YP/XrNXVHtEFQFRMovkLw
         kz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739991878; x=1740596678;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrDlJ2AvMdUxp/age4FgO4Czj+vcMNDLiz2S2LoiMVU=;
        b=hEgkfLVFjyBtdNql01LJd79StfPuTK9MfQbQveFfFawfVH1lApRXTtCkCPKYak4JrK
         QPZkpqPKGw0We18Ib9AZURfvL2RHstxmqKTunoIp+OfbYHIgnADVxwbRV6QBkO/HDS3x
         PLBO/dQb4yJDlicCXCFNvJHuvxORujMolH5qLfdRJEpELBnlLbC6EuPJwXlA2dKY/VhM
         RB7o6Y3ZHAa9qwN5E7Ueq0aBj9i1iC674V+VfPIo6BV2fwHhLIKQIiwzw2utocsrTmKb
         iptUYOHbO5Q4JGDgrxpo+vtM0P2uT6FhJC1Ng3wt6Uy9OulpT2ZLPArabCKVdsEf45RT
         qw1w==
X-Forwarded-Encrypted: i=1; AJvYcCUGuW6Wc1Za/HakuK2xGYpwJ8D2Q7+EtXrJrr3COWDlMc1WpfBcNiuSg6M1yQ0IMBm1RceYnVNq4+w=@vger.kernel.org, AJvYcCV6rJFsHy1B1EAW0Gq/Tsyha1TSrIxwZE3CDpNcPi/2hi8Z3xK3YfRc19WldM0YBBzuTOR7q7Jak92YWMrboSb4ev8j@vger.kernel.org, AJvYcCWmaeTRkRiHbd9p3qefkDbBfA/ja9jF7sldNevfynZF5wHMVP9jaodHC9vO0k67oYhYBlvj4JJRddG9++lY@vger.kernel.org
X-Gm-Message-State: AOJu0YwSsvJ7gAuYtKVAVn+Mc6mcXmu0+ahQk3fZP6BEkXpNUYrkmOs8
	P7StOFyyov8NEfsmZzSkwNLjLoP6OjYtwZ5fRg70+uJC96PpURpH
X-Gm-Gg: ASbGncvFx+G0HQfYvZ5WkkH6k4RDv+YnYPHdM5c5QO0UXKi1ocpHtZf2Nqlq/uAjvqS
	ezb1d0zod/yisZTbPjO77Nsk6FuMslbh9wHMgIInU7z7d5cj2R5L33LeOt05G+nvGXhQZqVEsYU
	jllYDCeLkzFWJQWe3lzfQyYjl0RZdHXfLyFYKTSTcZtIRDuYlO4CSYq5HWpfp5Et2skP/7ISlkl
	rKYNhtV7AiGGPuUXmFqw/hZG9oH9nnJPuFbbAEirjVd4/9A/gL8MvrJacBUm4aGQhCTbqi4ngeP
	+ZRFSXV6QjPEMGGI/co44kFiwlA=
X-Google-Smtp-Source: AGHT+IH8qML5oejH5DvReZgBKnWZtCAwJ9nqynkZ6m/Qk1rU3U+KF0Wr6raCqPID2y/zlaJq2VJ9Pg==
X-Received: by 2002:a05:6a21:6016:b0:1ee:7ddf:f40c with SMTP id adf61e73a8af0-1eed4e9cd1bmr8380457637.11.1739991878383;
        Wed, 19 Feb 2025 11:04:38 -0800 (PST)
Received: from smtpclient.apple ([103.152.220.38])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-add3958ee01sm8939188a12.43.2025.02.19.11.04.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2025 11:04:38 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH 1/2] sched: Refine scheduler naming for clarity and
 specificity
From: Jemmy Wong <jemmywong512@gmail.com>
In-Reply-To: <20250219134210.51bdf447@gandalf.local.home>
Date: Thu, 20 Feb 2025 03:04:02 +0800
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0245BA04-B0CD-482E-820A-FF5D608FB57E@gmail.com>
References: <20250219182020.393006-1-jemmywong512@gmail.com>
 <20250219182020.393006-2-jemmywong512@gmail.com>
 <20250219134210.51bdf447@gandalf.local.home>
To: Steven Rostedt <rostedt@goodmis.org>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

Hi Steve, =20

I=E2=80=99ve identified the cause: these changes stem from trailing =
whitespace,=20
which my IDE automatically trims by default.=20
I=E2=80=99ll disable this setting to avoid generating large diffs going =
forward. =20

Do I need to revert these changes? I don=E2=80=99t think it matters,=20
but I=E2=80=99d appreciate your guidance. =20

BR,
Jemmy

> On Feb 20, 2025, at 2:42=E2=80=AFAM, Steven Rostedt =
<rostedt@goodmis.org> wrote:
>=20
> On Thu, 20 Feb 2025 02:20:19 +0800
> Jemmy Wong <jemmywong512@gmail.com> wrote:
>=20
>> +++ b/Documentation/trace/ftrace.rst
>> @@ -986,14 +986,14 @@ why a latency happened. Here is a typical =
trace::
>>   #  =3D> ended at:   _raw_spin_unlock_irqrestore
>>   #
>>   #
>> -  #                  _------=3D> CPU#
>> -  #                 / _-----=3D> irqs-off
>> -  #                | / _----=3D> need-resched
>> -  #                || / _---=3D> hardirq/softirq
>> -  #                ||| / _--=3D> preempt-depth
>> -  #                |||| /     delay
>> -  #  cmd     pid   ||||| time  |   caller
>> -  #     \   /      |||||  \    |   /
>> +  #                  _------=3D> CPU#
>> +  #                 / _-----=3D> irqs-off
>> +  #                | / _----=3D> need-resched
>> +  #                || / _---=3D> hardirq/softirq
>> +  #                ||| / _--=3D> preempt-depth
>> +  #                |||| /     delay
>> +  #  cmd     pid   ||||| time  |   caller
>> +  #     \   /      |||||  \    |   /
>=20
> What exactly did you change for all these header updates?
>=20
> -- Steve
>=20
>>         ps-6143    2d...    0us!: trace_hardirqs_off =
<-__lock_task_sighand
>>         ps-6143    2d..1  259us+: trace_hardirqs_on =
<-_raw_spin_unlock_irqrestore
>>         ps-6143    2d..1  263us+: time_hardirqs_on =
<-_raw_spin_unlock_irqrestore
>> @@ -1490,14 +1490,14 @@ an example::
>>   #  =3D> ended at:   run_timer_softirq
>>   #
>>   #
>> -  #                  _------=3D> CPU#
>> -  #                 / _-----=3D> irqs-off
>> -  #                | / _----=3D> need-resched
>> -  #                || / _---=3D> hardirq/softirq
>> -  #                ||| / _--=3D> preempt-depth
>> -  #                |||| /     delay
>> -  #  cmd     pid   ||||| time  |   caller
>> -  #     \   /      |||||  \    |   /
>> +  #                  _------=3D> CPU#
>> +  #                 / _-----=3D> irqs-off
>> +  #                | / _----=3D> need-resched
>> +  #                || / _---=3D> hardirq/softirq
>> +  #                ||| / _--=3D> preempt-depth
>> +  #                |||| /     delay
>> +  #  cmd     pid   ||||| time  |   caller
>> +  #     \   /      |||||  \    |   /
>>     <idle>-0       0d.s2    0us+: _raw_spin_lock_irq =
<-run_timer_softirq
>>     <idle>-0       0dNs3   17us : _raw_spin_unlock_irq =
<-run_timer_softirq
>>     <idle>-0       0dNs3   17us+: trace_hardirqs_on =
<-run_timer_softirq
>> @@ -1541,14 +1541,14 @@ function-trace, we get a much larger output::
>>   #  =3D> ended at:   ata_scsi_queuecmd
>>   #
>>   #
>> -  #                  _------=3D> CPU#
>> -  #                 / _-----=3D> irqs-off
>> -  #                | / _----=3D> need-resched
>> -  #                || / _---=3D> hardirq/softirq
>> -  #                ||| / _--=3D> preempt-depth
>> -  #                |||| /     delay
>> -  #  cmd     pid   ||||| time  |   caller
>> -  #     \   /      |||||  \    |   /
>> +  #                  _------=3D> CPU#
>> +  #                 / _-----=3D> irqs-off
>> +  #                | / _----=3D> need-resched
>> +  #                || / _---=3D> hardirq/softirq
>> +  #                ||| / _--=3D> preempt-depth
>> +  #                |||| /     delay
>> +  #  cmd     pid   ||||| time  |   caller
>> +  #     \   /      |||||  \    |   /
>>       bash-2042    3d...    0us : _raw_spin_lock_irqsave =
<-ata_scsi_queuecmd
>>       bash-2042    3d...    0us : add_preempt_count =
<-_raw_spin_lock_irqsave
>>       bash-2042    3d..1    1us : ata_scsi_find_dev =
<-ata_scsi_queuecmd
>> @@ -1689,14 +1689,14 @@ is much like the irqsoff tracer.
>>   #  =3D> ended at:   do_IRQ
>>   #
>>   #
>> -  #                  _------=3D> CPU#
>> -  #                 / _-----=3D> irqs-off
>> -  #                | / _----=3D> need-resched
>> -  #                || / _---=3D> hardirq/softirq
>> -  #                ||| / _--=3D> preempt-depth
>> -  #                |||| /     delay
>> -  #  cmd     pid   ||||| time  |   caller
>> -  #     \   /      |||||  \    |   /
>> +  #                  _------=3D> CPU#
>> +  #                 / _-----=3D> irqs-off
>> +  #                | / _----=3D> need-resched
>> +  #                || / _---=3D> hardirq/softirq
>> +  #                ||| / _--=3D> preempt-depth
>> +  #                |||| /     delay
>> +  #  cmd     pid   ||||| time  |   caller
>> +  #     \   /      |||||  \    |   /
>>       sshd-1991    1d.h.    0us+: irq_enter <-do_IRQ
>>       sshd-1991    1d..1   46us : irq_exit <-do_IRQ
>>       sshd-1991    1d..1   47us+: trace_preempt_on <-do_IRQ
>> @@ -1727,14 +1727,14 @@ was over.
>>   #  =3D> ended at:   task_rq_unlock
>>   #
>>   #
>> -  #                  _------=3D> CPU#
>> -  #                 / _-----=3D> irqs-off
>> -  #                | / _----=3D> need-resched
>> -  #                || / _---=3D> hardirq/softirq
>> -  #                ||| / _--=3D> preempt-depth
>> -  #                |||| /     delay
>> -  #  cmd     pid   ||||| time  |   caller
>> -  #     \   /      |||||  \    |   /
>> +  #                  _------=3D> CPU#
>> +  #                 / _-----=3D> irqs-off
>> +  #                | / _----=3D> need-resched
>> +  #                || / _---=3D> hardirq/softirq
>> +  #                ||| / _--=3D> preempt-depth
>> +  #                |||| /     delay
>> +  #  cmd     pid   ||||| time  |   caller
>> +  #     \   /      |||||  \    |   /
>>       bash-1994    1d..1    0us : _raw_spin_lock_irqsave =
<-wake_up_new_task
>>       bash-1994    1d..1    0us : select_task_rq_fair =
<-select_task_rq
>>       bash-1994    1d..1    1us : __rcu_read_lock =
<-select_task_rq_fair
>> @@ -1841,14 +1841,14 @@ tracers.
>>   #  =3D> ended at:   ata_scsi_queuecmd
>>   #
>>   #
>> -  #                  _------=3D> CPU#
>> -  #                 / _-----=3D> irqs-off
>> -  #                | / _----=3D> need-resched
>> -  #                || / _---=3D> hardirq/softirq
>> -  #                ||| / _--=3D> preempt-depth
>> -  #                |||| /     delay
>> -  #  cmd     pid   ||||| time  |   caller
>> -  #     \   /      |||||  \    |   /
>> +  #                  _------=3D> CPU#
>> +  #                 / _-----=3D> irqs-off
>> +  #                | / _----=3D> need-resched
>> +  #                || / _---=3D> hardirq/softirq
>> +  #                ||| / _--=3D> preempt-depth
>> +  #                |||| /     delay
>> +  #  cmd     pid   ||||| time  |   caller
>> +  #     \   /      |||||  \    |   /
>>         ls-2230    3d...    0us+: _raw_spin_lock_irqsave =
<-ata_scsi_queuecmd
>>         ls-2230    3...1  100us : _raw_spin_unlock_irqrestore =
<-ata_scsi_queuecmd
>>         ls-2230    3...1  101us+: trace_preempt_on =
<-ata_scsi_queuecmd
>> @@ -1894,14 +1894,14 @@ Here is a trace with function-trace set::
>>   #  =3D> ended at:   mutex_unlock
>>   #
>>   #
>> -  #                  _------=3D> CPU#
>> -  #                 / _-----=3D> irqs-off
>> -  #                | / _----=3D> need-resched
>> -  #                || / _---=3D> hardirq/softirq
>> -  #                ||| / _--=3D> preempt-depth
>> -  #                |||| /     delay
>> -  #  cmd     pid   ||||| time  |   caller
>> -  #     \   /      |||||  \    |   /
>> +  #                  _------=3D> CPU#
>> +  #                 / _-----=3D> irqs-off
>> +  #                | / _----=3D> need-resched
>> +  #                || / _---=3D> hardirq/softirq
>> +  #                ||| / _--=3D> preempt-depth
>> +  #                |||| /     delay
>> +  #  cmd     pid   ||||| time  |   caller
>> +  #     \   /      |||||  \    |   /
>>   kworker/-59      3...1    0us : __schedule <-schedule
>>   kworker/-59      3d..1    0us : rcu_preempt_qs =
<-rcu_note_context_switch
>>   kworker/-59      3d..1    1us : add_preempt_count =
<-_raw_spin_lock_irq
>> @@ -1987,7 +1987,7 @@ wakeup
>> One common case that people are interested in tracing is the
>> time it takes for a task that is woken to actually wake up.
>> Now for non Real-Time tasks, this can be arbitrary. But tracing
>> -it nonetheless can be interesting.
>> +it nonetheless can be interesting.
>>=20
>> Without function tracing::
>>=20
>> @@ -2007,14 +2007,14 @@ Without function tracing::
>>   #    | task: kworker/3:1H-312 (uid:0 nice:-20 policy:0 rt_prio:0)
>>   #    -----------------
>>   #
>> -  #                  _------=3D> CPU#
>> -  #                 / _-----=3D> irqs-off
>> -  #                | / _----=3D> need-resched
>> -  #                || / _---=3D> hardirq/softirq
>> -  #                ||| / _--=3D> preempt-depth
>> -  #                |||| /     delay
>> -  #  cmd     pid   ||||| time  |   caller
>> -  #     \   /      |||||  \    |   /
>> +  #                  _------=3D> CPU#
>> +  #                 / _-----=3D> irqs-off
>> +  #                | / _----=3D> need-resched
>> +  #                || / _---=3D> hardirq/softirq
>> +  #                ||| / _--=3D> preempt-depth
>> +  #                |||| /     delay
>> +  #  cmd     pid   ||||| time  |   caller
>> +  #     \   /      |||||  \    |   /
>>     <idle>-0       3dNs7    0us :      0:120:R   + [003]   312:100:R =
kworker/3:1H
>>     <idle>-0       3dNs7    1us+: ttwu_do_activate.constprop.87 =
<-try_to_wake_up
>>     <idle>-0       3d..3   15us : __schedule <-schedule
>> @@ -2076,14 +2076,14 @@ Instead of performing an 'ls', we will run =
'sleep 1' under
>>   #    | task: sleep-2389 (uid:0 nice:0 policy:1 rt_prio:5)
>>   #    -----------------
>>   #
>> -  #                  _------=3D> CPU#
>> -  #                 / _-----=3D> irqs-off
>> -  #                | / _----=3D> need-resched
>> -  #                || / _---=3D> hardirq/softirq
>> -  #                ||| / _--=3D> preempt-depth
>> -  #                |||| /     delay
>> -  #  cmd     pid   ||||| time  |   caller
>> -  #     \   /      |||||  \    |   /
>> +  #                  _------=3D> CPU#
>> +  #                 / _-----=3D> irqs-off
>> +  #                | / _----=3D> need-resched
>> +  #                || / _---=3D> hardirq/softirq
>> +  #                ||| / _--=3D> preempt-depth
>> +  #                |||| /     delay
>> +  #  cmd     pid   ||||| time  |   caller
>> +  #     \   /      |||||  \    |   /
>>     <idle>-0       3d.h4    0us :      0:120:R   + [003]  2389: 94:R =
sleep
>>     <idle>-0       3d.h4    1us+: ttwu_do_activate.constprop.87 =
<-try_to_wake_up
>>     <idle>-0       3d..3    5us : __schedule <-schedule
>> @@ -2125,19 +2125,19 @@ Doing the same with chrt -r 5 and =
function-trace set.
>>   #    | task: sleep-2448 (uid:0 nice:0 policy:1 rt_prio:5)
>>   #    -----------------
>>   #
>> -  #                  _------=3D> CPU#
>> -  #                 / _-----=3D> irqs-off
>> -  #                | / _----=3D> need-resched
>> -  #                || / _---=3D> hardirq/softirq
>> -  #                ||| / _--=3D> preempt-depth
>> -  #                |||| /     delay
>> -  #  cmd     pid   ||||| time  |   caller
>> -  #     \   /      |||||  \    |   /
>> +  #                  _------=3D> CPU#
>> +  #                 / _-----=3D> irqs-off
>> +  #                | / _----=3D> need-resched
>> +  #                || / _---=3D> hardirq/softirq
>> +  #                ||| / _--=3D> preempt-depth
>> +  #                |||| /     delay
>> +  #  cmd     pid   ||||| time  |   caller
>> +  #     \   /      |||||  \    |   /

