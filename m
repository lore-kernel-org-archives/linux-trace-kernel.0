Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D154F23BCF3
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758301667; cv=none; b=Z7L7XQwjbQhJXyleauiP/SqYx9ylySatjjJ/W1ngkFRWQO2HteG5BRElwwt5YIAzhAzAHrnCg0c2hfDd2F2KDceJrKi9SXkITgZYKdhoFgybB+o3vplzkSzAHlojvX5FXrsOWVHLeNorCvPRuGUPqeP9jwY8Ou524ugVgJT+tJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758301667; c=relaxed/simple;
	bh=3qp6q9LRUoe6q3bo7J359SoUE/ClQLHaiAfa3bIxl3w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Ktq6RfD0lxfSFGOHduHGuB4sK3NmBUTUAkzP14T5tGp9bjNi7aB0l1L6NmYst8tb3od6eEu/emse7FBZdHciw6UcQ7dB/YK4eliuNWGZBO9dmcd5VtME8XpmSNObmr9/HBxhxX9vuMcjEjk0y77cRqP9MDUnAeyXHo/QA5bIpPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e30Mbx90; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e30Mbx90"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758301664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3qp6q9LRUoe6q3bo7J359SoUE/ClQLHaiAfa3bIxl3w=;
	b=e30Mbx90iu+dk6hEnF3mVaZ2+MFePXenkVm8J55FA7jq0Oy0S2vuOuG15H9VMF/JT/Y3hl
	VP2HK4n/RXG/kbiW6shD1H/iFZVRLfX8t0PYNPS6WBM1HEm+q4Ig3u7hMSWBEB7SJHFN98
	zVPlhFKDK/A13/EdRUa3i/YDLjOyrEY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-xDmgwqvCPyGR7VMoEwynLQ-1; Fri, 19 Sep 2025 13:07:43 -0400
X-MC-Unique: xDmgwqvCPyGR7VMoEwynLQ-1
X-Mimecast-MFC-AGG-ID: xDmgwqvCPyGR7VMoEwynLQ_1758301662
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ee1365964cso1667868f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758301662; x=1758906462;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3qp6q9LRUoe6q3bo7J359SoUE/ClQLHaiAfa3bIxl3w=;
        b=wmk7AAyzdoEFPKo1Nz7jDiN32P56cfQPaTStO/Ncy1WsUmJhkoW6DojWB4BX9jWTeA
         FExFfAlHajP3vi84oN0bksjgD/rvWapzITasIBCLtGN9zHe6SdMe1ETG0btz2sD3ArV2
         HZ/wOexKzPkesYYBqd9ExDnLx7lcN1ukl254a6y1+NlUrWX6Q1wbPwdIrgCCV7JFNCiu
         1q8qid0wmRMVqrkuNM2R/4AUnAwLRWlovgl7XLIjWoDGbHUTCadQ5iMohY+I1Gy/uaUr
         tP7gLEGkzhtqIT28WnZLVB1YnMASvje7wvgEyU6mCCrmyU2wMzGMlgZuAzT0l83W7Xae
         hRkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTjNVTyFvh47w9Sg/rgBvxcwFIyE5XnZMlsYwuQZ06Zssa2H9HguO3yg1kXfOMogmxwnCl9IVQrHzW3Ty11KI0GYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3MJnChgePSfmM6H/jTuQfd53ebKcgY7fg1zIcJ4XbcOCEgz2Y
	3LZtVmjFYIIY0xCzJvaJSAwb8lB5goOFhV5C4GqmHqM1IMTkW5sUHXpLOgSVpNn0+A02aR9gW5T
	LnZqlEUya/LxmEG5WX8rkNHk6u1J3Mlns3DxPx5YdZ+NvhK4Wg6FNcXcgShSJvwx7+iITQHaHcQ
	==
X-Gm-Gg: ASbGncuq9ic3ZNRJ50PBKhw/1JSDcjDM59bijQScTK7f8fPWH7NyB4bJcUoNbfUsSIQ
	Ca/mcQAIyMSCksvFvr6e4WePy4W8knCD8oMSgJ0AXxfmXPHANahUx3lbO41KNr8N01dbbiZmYPd
	vFiOO0sXE3s9Oe5l5j3J4kLIZZukx1E4md8+hJ3AQMflZGPTmL3O+YYvw8siTEPr1mVHw/Fcqcv
	PclCkjI5ZuXy2foCxOYx9ulTlQ7An+6fU4HbbcPHI0cmxlqIjt3OhCX22DSTeXZv0F8C+y+jXRJ
	2tJfksWGuuy4nIBVeCqqPGPBk+uG44LhIWHC
X-Received: by 2002:a5d:64e5:0:b0:3ea:ac25:b6b9 with SMTP id ffacd0b85a97d-3ee7da56ff7mr2979540f8f.11.1758301662188;
        Fri, 19 Sep 2025 10:07:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgsMyuWn2Qvd0H7mVqIwWFUhFqllortDrLxiWpPoSxTPoDr2zxCfkYtR+1fTUa0yG7RVSidw==
X-Received: by 2002:a5d:64e5:0:b0:3ea:ac25:b6b9 with SMTP id ffacd0b85a97d-3ee7da56ff7mr2979510f8f.11.1758301661712;
        Fri, 19 Sep 2025 10:07:41 -0700 (PDT)
Received: from [127.0.0.1] ([195.174.132.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f4669sm8270429f8f.4.2025.09.19.10.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 10:07:41 -0700 (PDT)
Date: Fri, 19 Sep 2025 17:07:14 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Nam Cao <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-trace-kernel@vger.kernel.org
Message-ID: <7a446e09-4333-409f-bba1-246a27d91db8@redhat.com>
In-Reply-To: <20250919113749.7ee1f249@gandalf.local.home>
References: <20250919140954.104920-1-gmonaco@redhat.com> <20250919140954.104920-17-gmonaco@redhat.com> <20250919113749.7ee1f249@gandalf.local.home>
Subject: Re: [PATCH v2 16/20] sched: Export hidden tracepoints to modules
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Correlation-ID: <7a446e09-4333-409f-bba1-246a27d91db8@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FdvaUQ3AF2tgUVvWw62-XcLH4PHlqC4IWUJhJcdpFP4_1758301662
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2025-09-19T15:36:50Z Steven Rostedt <rostedt@goodmis.org>:

> On Fri, 19 Sep 2025 16:09:50 +0200
> Gabriele Monaco <gmonaco@redhat.com> wrote:
>
>> The tracepoints sched_entry, sched_exit and sched_set_need_resched
>> are not exported to tracefs as trace events, this allows only kernel
>> code to access them. Helper modules like [1] can be used to still have
>> the tracepoints available to ftrace for debugging purposes, but they do
>> rely on the tracepoints being exported.
>>
>> Export the 3 not exported tracepoints.
>> Note that sched_set_state is already exported as the macro is called
>> from modules.
>>
>> [1] - https://github.com/qais-yousef/sched_tp.git
>>
>> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>
> Note, for all the scheduler changes, we need an acked-by from the schedul=
er
> maintainers.
>

Alright got it.

> After you have acks and are satisfied with the code (hopefully someone el=
se
> can review them), you can send me a pull request to be added into linux-n=
ext.

Usually Nam does a very good job reviewing them.

> I'll still run them through my own tests.
>
> Which BTW, there should be a bunch of tests in:
>
> =C2=A0 tools/testing/selftests/verification/
>
> (which doesn't yet exist).

Yeah that's the next thing in my imaginary list, or perhaps something inspi=
red on what's done in rtla.

Thanks,
Gabriele

>
> -- Steve
>
>
>> ---
>> kernel/sched/core.c | 3 +++
>> 1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index ccba6fc3c3fe..334ff5b214d7 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -117,6 +117,9 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
>> EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
>> EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
>> EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
>> +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_entry_tp);
>> +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_exit_tp);
>> +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_set_need_resched_tp);
>>
>> DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
>>

