Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38FA5F470
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799433; cv=none; b=BtxrvAZaN/McARt8thx6hBdBEY/i+SG5xy0cNW2lNqAPqRjz7Mazves/wMbSk3MjLe0K2dQy7tvcRi4pRScRlvoKKmZ7vzTwyMRtCRk5BWfMTG+vFvID+Ql4oJkp8pM1bY9FodQbyECQR4AFxrzBqrVXUqAfZbyaWfbae8bw2kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799433; c=relaxed/simple;
	bh=18pHoWH50Iv2v4FSlrpCqG2ZsbcsI6iZ9hyVB81jlLo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jj49TM/jleO9IuLQWgPIqxFBvVpBhnYpz+G+rq/wDMv5ilgxtyz7VKq8n8/BbcvsrXqWhtHD4RQgk4CpZ+lpfwJ/ih9fh6gmD/xdL+zFuztaQAmoELt5iMe1TZS+mIiEW+MCfdPXUgbeKwxEx1mRMqaVa5yxt6+sZPshTYVtkMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB98C433C7;
	Thu,  1 Feb 2024 14:57:12 +0000 (UTC)
Date: Thu, 1 Feb 2024 09:57:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Andy Chiu <andy.chiu@sifive.com>
Cc: linux-trace-kernel@vger.kernel.org, bristot@kernel.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [v1] trace/hwlat: stop worker if !is_percpu_thread due to
 hotplug event
Message-ID: <20240201095729.4fe5e56b@gandalf.local.home>
In-Reply-To: <20240201062455.3154803-1-andy.chiu@sifive.com>
References: <20240201062455.3154803-1-andy.chiu@sifive.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu,  1 Feb 2024 14:24:55 +0800
Andy Chiu <andy.chiu@sifive.com> wrote:

> If the task happens to run after cpu hot-plug offline, then it would not
> be running in a percpu_thread. Instead, it would be re-queued into a
> UNBOUND workqueue. This would trigger a warning if we enable kernel
> preemption.
>=20
> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> ---
>  kernel/trace/trace_hwlat.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
> index b791524a6536..87258ddc2141 100644
> --- a/kernel/trace/trace_hwlat.c
> +++ b/kernel/trace/trace_hwlat.c
> @@ -511,7 +511,16 @@ static int start_cpu_kthread(unsigned int cpu)
>  static void hwlat_hotplug_workfn(struct work_struct *dummy)
>  {
>  	struct trace_array *tr =3D hwlat_trace;
> -	unsigned int cpu =3D smp_processor_id();
> +	unsigned int cpu;
> +
> +	/*
> +	 * If the work is scheduled after CPU hotplug offline being invoked,
> +	 * then it would be queued into UNBOUNDED workqueue

Is it due to a CPU going to online and then right back to offline? This
function is called by the online path.

=46rom the queue_work_on() comment:

/**
 * queue_work_on - queue work on specific cpu
 * @cpu: CPU number to execute work on
 * @wq: workqueue to use
 * @work: work to queue
 *
 * We queue the work to a specific CPU, the caller must ensure it
 * can't go away.  Callers that fail to ensure that the specified
 * CPU cannot go away will execute on a randomly chosen CPU.
 * But note well that callers specifying a CPU that never has been
 * online will get a splat.
 *
 * Return: %false if @work was already on a queue, %true otherwise.
 */

So the work gets queued on the CPU but then the CPU immediately goes
offline. I wonder what happens if it comes back online?

The above states that if the work is already queued on a CPU it won't queue
it again. Hmm, reading the comments, I'm not sure you can run the same
workqueue on muliple CPUs. It looks to do only one and all the others will
fail.

I think we need to change this to a global work queue and use CPU masks.
Where in the *cpu_init() function, it just sets the current CPU bit in a
bit mask and calls the workqueue, and that workqueue is responsible for all
CPUs.

Then the workqueue function will call cpu_read_lock() and just iterate the
CPU mask starting the threads for each of the bits that are set and clear
the bit (possibly with __test_and_clear_bit).

I don't think the schedule_on_cpu() is doing what we think it should be
doing.


-- Steve


> +	 */
> +	if (!is_percpu_thread())
> +		return;
> +
> +	cpu =3D smp_processor_id();
> =20
>  	mutex_lock(&trace_types_lock);
>  	mutex_lock(&hwlat_data.lock);

