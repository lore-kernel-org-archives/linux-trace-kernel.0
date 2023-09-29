Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8E8C2CF
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Sep 2023 15:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552A5C433C8;
	Fri, 29 Sep 2023 15:07:01 +0000 (UTC)
Date: Fri, 29 Sep 2023 11:06:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH] tracing: relax trace_event_eval_update() execution with
 schedule()
Message-ID: <20230929110657.7a4b38ef@rorschach.local.home>
In-Reply-To: <20230929141348.248761-1-cleger@rivosinc.com>
References: <20230929141348.248761-1-cleger@rivosinc.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 29 Sep 2023 16:13:48 +0200
Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com> wrote:

> When kernel is compiled without preemption, the eval_map_work_func()
> (which calls trace_event_eval_update()) will not be preempted up to its
> complete execution. This can actually cause a problem since if another
> CPU call stop_machine(), the call will have to wait for the
> eval_map_work_func() function to finish executing in the workqueue
> before being able to be scheduled. This problem was observe on a SMP
> system at boot time, when the CPU calling the initcalls executed
> clocksource_done_booting() which in the end calls stop_machine(). We
> observed a 1 second delay because one CPU was executing
> eval_map_work_func() and was not preempted by the stop_machine() task.
>=20
> Adding a call to schedule() in trace_event_eval_update() allows to let
> other tasks to be executed and thus continue working asynchronously like
> before without blocking any pending task at boot time.
>=20
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> ---
>  kernel/trace/trace_events.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 91951d038ba4..dbdf57a081c0 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -2770,6 +2770,7 @@ void trace_event_eval_update(struct trace_eval_map =
**map, int len)
>  				update_event_fields(call, map[i]);
>  			}
>  		}
> +		schedule();

The proper answer to this is "cond_resched()" but still, there's going
to be work to get rid of all that soon [1]. But I'll take a cond_resched()
now until that is implemented.

-- Steve

>  	}
>  	up_write(&trace_event_sem);
>  }

[1] https://lore.kernel.org/all/87cyyfxd4k.ffs@tglx/
