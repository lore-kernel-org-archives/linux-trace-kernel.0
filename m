Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93FC23BE
	for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Aug 2024 00:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724977886; cv=none; b=ciK6o+mL7ACHwXE+3JIwj7YFWglQLa71Sxi9x5b+DtZv0DZYNTUpWnV+ClFONKhvOtbyPAbSi8dOYFnY77aOMLZvj14mtxa+M87e+JrxxU2/6trd6g0pn301fRxzI1iJbvN94H+xcbiXcoOtj3qxnXYyPf2j1OiJUWmjEoJIt50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724977886; c=relaxed/simple;
	bh=bY6qbzWkNppR59O7ZGg2GIS3EEAeYuG3h/SvakQOwQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpbTbZ5VOvTuXhULdHVaW/yQEFFXSpCafqfzRiPINZpE5tintMHlckQkik1kjkZViMHZXmfLYseS28YbXFwAmvLyxYY52sOq6FEptKUsYOwPkaDdDHgm/G3sce/waj8LciRi3LGrUbuesBeX1i+SUjBGbd8bxlj8QRd9JIQCZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AUsrc5lY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUsrc5lY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724977883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bq43fjOrp+mgHH7br+yotsunWX52YYYoWiMEdtFI2lk=;
	b=AUsrc5lY+rm9LKBNCAR797wzubJX3R2LhYY/zc6CgamFe55UarQpten+yM63IvRTW9UMv8
	LZi+FSXg1akMGb5LEfWDuYud/bxR2QuMUafXbj0TDvGVy30sOj8IPdUIUVJNFQ8wj57cnA
	3bNLj8zN7PeKBOu0PHiCHDDsZnveXvM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-EFTzMam4Nbi0r5JvGnbjsg-1; Thu,
 29 Aug 2024 20:31:19 -0400
X-MC-Unique: EFTzMam4Nbi0r5JvGnbjsg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 745D61955D48;
	Fri, 30 Aug 2024 00:31:18 +0000 (UTC)
Received: from localhost (unknown [10.22.32.86])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B1CB51956048;
	Fri, 30 Aug 2024 00:31:17 +0000 (UTC)
Date: Thu, 29 Aug 2024 21:31:16 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	jkacur@redhat.com
Subject: Re: [PATCH] tracing/timerlat: Check tlat_var for NULL in
 timerlat_fd_release
Message-ID: <ZtES1Iw6K1GY85bS@uudg.org>
References: <20240820130001.124768-1-tglozar@redhat.com>
 <20240823125426.404f2705@gandalf.local.home>
 <20240823145211.34ccda61@gandalf.local.home>
 <CAP4=nvQnW5vS5CQBZtKp-BdjYxNFbq26P36uRy3RhCenHEG_YA@mail.gmail.com>
 <20240826132620.1618d201@gandalf.local.home>
 <CAP4=nvTR9EuA5WhGweSaoeptEw0n0w5exr8gq6zfqGhGNt3zpg@mail.gmail.com>
 <ZtEG5gOxv8UlTbzS@uudg.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZtEG5gOxv8UlTbzS@uudg.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Aug 29, 2024 at 08:40:25PM -0300, Luis Claudio R. Goncalves wrote:
> On Tue, Aug 27, 2024 at 04:34:39PM +0200, Tomas Glozar wrote:
> > po 26. 8. 2024 v 19:27 odesílatel Steven Rostedt <rostedt@goodmis.org> napsal:
> > >
> > > Yeah, I think I finally found the real issue. I don't think we need the ref
> > > counting. The problem is the creating and killing of the threads via the
> > > start and stop callbacks. That's not their purpose. The purpose of stop
> > > and start callbacks is when tracing_on is set to off and back on again. I
> > > think this is what is racing with the close.
> > >
> > 
> > I believe I discovered the exact mechanism of the bug. Since rtla is
> > killed with SIGTERM, it leaves the timerlat tracer active and its
> > timerlatu processes running. The rtla from the next iteration of the
> > while loop in the reproducer deactivates the timerlat tracer,
> > triggering the killing of the timerlatu processes. However, this
> > killing is asynchronous, and while the processes are gradually dying
> > one by one and closing their fds, the rtla from the next iteration is
> > already activating the timerlat tracer again. One of the timerlatu
> > processes does not die fast enough to release the fd before the
> > tlat_var is cleared in osnoise_workload_start, triggering the panic.
> 
> With this in mind I tried a simpler approach. I used a kernel without any
> extra patches from Steven or ourselves, just used the code below. Not
> saying it is a definitive solution, but as a proof of concept I have two
> boxes running the loop used to reproduce the problem and so far not a
> single problem. The patch:

Premature commemoration. One of the boxes rebooted a minute ago. Sounds
like I just diminished a bit the window for triggering the problem.
Tomorrow I will run tests with all the suggested patches and work of a
better idea, more comprehensive, to address what Tomas described above.
 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 66a871553d4a1..331c69bc7b0d4 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -2239,8 +2239,11 @@ static ssize_t osnoise_options_write(struct file *filp, const char __user *ubuf,
>  	 */
>  	mutex_lock(&trace_types_lock);
>  	running = osnoise_has_registered_instances();
> -	if (running)
> +	if (running) {
>  		stop_per_cpu_kthreads();
> +		mutex_unlock(&trace_types_lock);
> +		return -EBUSY;
> +	}
>  
>  	mutex_lock(&interface_lock);
>  	/*
> @@ -2579,7 +2582,8 @@ static int timerlat_fd_release(struct inode *inode, struct file *file)
>  	osn_var = per_cpu_ptr(&per_cpu_osnoise_var, cpu);
>  	tlat_var = per_cpu_ptr(&per_cpu_timerlat_var, cpu);
>  
> -	hrtimer_cancel(&tlat_var->timer);
> +	if (tlat_var->kthread)
> +		hrtimer_cancel(&tlat_var->timer);
>  	memset(tlat_var, 0, sizeof(*tlat_var));
>  
>  	osn_var->sampling = 0;
> ---
> 
> In short, do not start new instances if the old one still registered. And
> only cancel the timer if the timerlat per cpu var has not been zeroed-out.
> 
> Again, not a final patch but a simpler approach to protect start/stop
> races.
> 
> Luis
> 
> > 
> > You can see the bug in action in this detailed trace I got today, with
> > the use of in-kernel trace_printk together with bpftrace and
> > bpf_trace_printk and captured using ftrace_dump_on_oops (running the
> > same reproducer on a 8 CPU KVM system):
> > [  103.227679]     rtla-2325      2..... 98242607us :
> > osnoise_workload_start: tlat_var_reset: cpu=0,
> > tlat_var=0000000034996efa
> > [  103.227844]     rtla-2325      2..... 98242607us :
> > osnoise_workload_start: tlat_var_reset: cpu=1,
> > tlat_var=0000000062d1f520
> > [  103.228009]     rtla-2325      2..... 98242607us :
> > osnoise_workload_start: tlat_var_reset: cpu=2,
> > tlat_var=0000000002e262d8
> > [  103.228173]     rtla-2325      2..... 98242607us :
> > osnoise_workload_start: tlat_var_reset: cpu=3,
> > tlat_var=00000000b9d3a280
> > [  103.228349]     rtla-2325      2..... 98242607us :
> > osnoise_workload_start: tlat_var_reset: cpu=4,
> > tlat_var=000000000fba7a6e
> > [  103.228510]     rtla-2325      2..... 98242608us :
> > osnoise_workload_start: tlat_var_reset: cpu=5,
> > tlat_var=000000008ed0b87f
> > [  103.228670]     rtla-2325      2..... 98242608us :
> > osnoise_workload_start: tlat_var_reset: cpu=6,
> > tlat_var=00000000a02fe267
> > [  103.228831]     rtla-2325      2..... 98242608us :
> > osnoise_workload_start: tlat_var_reset: cpu=7,
> > tlat_var=000000008e1d5095
> > [  103.228992]     rtla-2327      3...11 98256551us :
> > bpf_trace_printk: rtla pid 2325 forks into 2328
> > [  103.229156]     rtla-2327      3...11 98256873us :
> > bpf_trace_printk: rtla pid 2325 forks into 2329
> > [  103.229325]     rtla-2327      3...11 98257124us :
> > bpf_trace_printk: rtla pid 2325 forks into 2330
> > [  103.229489]     rtla-2327      3...11 98257353us :
> > bpf_trace_printk: rtla pid 2325 forks into 2331
> > [  103.229651]     rtla-2327      3...11 98257574us :
> > bpf_trace_printk: rtla pid 2325 forks into 2332
> > [  103.229810]     rtla-2327      3...11 98257801us :
> > bpf_trace_printk: rtla pid 2325 forks into 2333
> > [  103.229968]     rtla-2327      3...11 98258008us :
> > bpf_trace_printk: rtla pid 2325 forks into 2334
> > [  103.230124]     rtla-2327      3...11 98258216us :
> > bpf_trace_printk: rtla pid 2325 forks into 2335
> > [  103.230293]     bash-2094      0d..31 102987914us :
> > bpf_trace_printk: rtla pid 2325 received signal 2
> > [  103.230452]     bash-2094      0d..31 102987915us :
> > bpf_trace_printk: ...from bash pid 2094
> > [  103.230609]     bash-2094      0d..31 102990000us :
> > bpf_trace_printk: rtla pid 2325 received signal 15
> > [  103.230766]     bash-2094      0d..31 102990001us :
> > bpf_trace_printk: ...from bash pid 2094
> > [  103.230922]     rtla-2325      2...21 102990010us :
> > bpf_trace_printk: rtla pid 2325 exiting
> > [  103.231079]     rtla-2327      3...21 102990503us :
> > bpf_trace_printk: rtla pid 2327 exiting
> > [  103.231242]     rtla-2337      3d..31 103232021us :
> > bpf_trace_printk: timerlatu/0 pid 2328 received signal 9
> > [  103.231399]     rtla-2337      3d..31 103232022us :
> > bpf_trace_printk: ...from rtla pid 2337
> > [  103.231554]     rtla-2337      3d..31 103232024us :
> > bpf_trace_printk: timerlatu/1 pid 2329 received signal 9
> > [  103.231711]     rtla-2337      3d..31 103232025us :
> > bpf_trace_printk: ...from rtla pid 2337
> > [  103.231866]     rtla-2337      3d..31 103232029us :
> > bpf_trace_printk: timerlatu/2 pid 2330 received signal 9
> > [  103.232022]     rtla-2337      3d..31 103232030us :
> > bpf_trace_printk: ...from rtla pid 2337
> > [  103.232178]     rtla-2337      3dN.31 103232031us :
> > bpf_trace_printk: timerlatu/3 pid 2331 received signal 9
> > [  103.232347]     rtla-2337      3dN.31 103232031us :
> > bpf_trace_printk: ...from rtla pid 2337
> > [  103.232506]     rtla-2337      3dN.31 103232034us :
> > bpf_trace_printk: timerlatu/4 pid 2332 received signal 9
> > [  103.232685]     rtla-2337      3dN.31 103232034us :
> > bpf_trace_printk: ...from rtla pid 2337
> > [  103.232846]     rtla-2337      3dN.31 103232039us :
> > bpf_trace_printk: timerlatu/5 pid 2333 received signal 9
> > [  103.233010]     rtla-2337      3dN.31 103232039us :
> > bpf_trace_printk: ...from rtla pid 2337
> > [  103.233171]     rtla-2337      3dN.31 103232042us :
> > bpf_trace_printk: timerlatu/6 pid 2334 received signal 9
> > [  103.233357]     rtla-2337      3dN.31 103232042us :
> > bpf_trace_printk: ...from rtla pid 2337
> > [  103.233517]     rtla-2337      3dN.31 103232046us :
> > bpf_trace_printk: timerlatu/7 pid 2335 received signal 9
> > [  103.233678]     rtla-2337      3dN.31 103232046us :
> > bpf_trace_printk: ...from rtla pid 2337
> > [  103.233835] timerlat-2331      3...21 103232701us :
> > bpf_trace_printk: timerlatu/3 pid 2331 exiting
> > [  103.233995] timerlat-2329      1...21 103232704us :
> > bpf_trace_printk: timerlatu/1 pid 2329 exiting
> > [  103.234155] timerlat-2331      3....1 103232705us :
> > timerlat_fd_release: timerlat_fd_release: cpu=3,
> > tlat_var=000000000fba7a6e, osn_var->pid=2331
> > [  103.234357] timerlat-2329      1....1 103232706us :
> > timerlat_fd_release: timerlat_fd_release: cpu=1,
> > tlat_var=0000000002e262d8, osn_var->pid=2329
> > [  103.234508] timerlat-2334      6...21 103232821us :
> > bpf_trace_printk: timerlatu/6 pid 2334 exiting
> > [  103.234657] timerlat-2334      6....1 103232826us :
> > timerlat_fd_release: timerlat_fd_release: cpu=6,
> > tlat_var=000000008e1d5095, osn_var->pid=2334
> > [  103.234813] timerlat-2330      2...21 103232850us :
> > bpf_trace_printk: timerlatu/2 pid 2330 exiting
> > [  103.234966] timerlat-2330      2....1 103232853us :
> > timerlat_fd_release: timerlat_fd_release: cpu=2,
> > tlat_var=00000000b9d3a280, osn_var->pid=2330
> > [  103.235122] timerlat-2333      5...21 103232856us :
> > bpf_trace_printk: timerlatu/5 pid 2333 exiting
> > [  103.235291] timerlat-2333      5....1 103232858us :
> > timerlat_fd_release: timerlat_fd_release: cpu=5,
> > tlat_var=00000000a02fe267, osn_var->pid=2333
> > [  103.235452] timerlat-2332      4...21 103232861us :
> > bpf_trace_printk: timerlatu/4 pid 2332 exiting
> > [  103.235610] timerlat-2332      4....1 103232864us :
> > timerlat_fd_release: timerlat_fd_release: cpu=4,
> > tlat_var=000000008ed0b87f, osn_var->pid=2332
> > [  103.235769] timerlat-2335      7...21 103232867us :
> > bpf_trace_printk: timerlatu/7 pid 2335 exiting
> > [  103.235932] timerlat-2335      7....1 103232869us :
> > timerlat_fd_release: timerlat_fd_release: cpu=7,
> > tlat_var=000000003113e297, osn_var->pid=2335
> > [  103.236103]     rtla-2337      3..... 103234109us :
> > osnoise_workload_start: tlat_var_reset: cpu=0,
> > tlat_var=0000000034996efa
> > [  103.236316]     rtla-2337      3..... 103234109us :
> > osnoise_workload_start: tlat_var_reset: cpu=1,
> > tlat_var=0000000062d1f520
> > [  103.236473]     rtla-2337      3..... 103234109us :
> > osnoise_workload_start: tlat_var_reset: cpu=2,
> > tlat_var=0000000002e262d8
> > [  103.236630]     rtla-2337      3..... 103234110us :
> > osnoise_workload_start: tlat_var_reset: cpu=3,
> > tlat_var=00000000b9d3a280
> > [  103.236797]     rtla-2337      3..... 103234110us :
> > osnoise_workload_start: tlat_var_reset: cpu=4,
> > tlat_var=000000000fba7a6e
> > [  103.236972]     rtla-2337      3..... 103234110us :
> > osnoise_workload_start: tlat_var_reset: cpu=5,
> > tlat_var=000000008ed0b87f
> > [  103.237144]     rtla-2337      3..... 103234110us :
> > osnoise_workload_start: tlat_var_reset: cpu=6,
> > tlat_var=00000000a02fe267
> > [  103.237345]     rtla-2337      3..... 103234110us :
> > osnoise_workload_start: tlat_var_reset: cpu=7,
> > tlat_var=000000008e1d5095
> > [  103.237516] timerlat-2328      0...21 103234149us :
> > bpf_trace_printk: timerlatu/0 pid 2328 exiting
> > [  103.237690] timerlat-2328      0....1 103234152us :
> > timerlat_fd_release: timerlat_fd_release: cpu=0,
> > tlat_var=0000000062d1f520, osn_var->pid=0
> > [  103.237871] ---------------------------------
> > [  103.238053] CR2: 0000000000000010
> > 
> > On the kernel side, I'm using similar trace_printk debug prints as you
> > did; the bpftrace program used is this:
> > uretprobe:libc:fork
> > /strncmp(comm, "rtla", 5) == 0 && retval != 0/
> > {
> >         debugf("rtla pid %d forks into %d", pid, retval)
> > }
> > tracepoint:signal:signal_generate
> > /strncmp(args->comm, "rtla", 5) == 0 || strncmp(args->comm,
> > "timerlatu", 9) == 0/ {
> >         debugf("%s pid %d received signal %d", args->comm, args->pid,
> > args->sig);
> >         debugf("...from %s pid %d", comm, pid);
> > }
> > tracepoint:sched:sched_process_exit
> > /strncmp(args->comm, "rtla", 5) == 0 || strncmp(args->comm,
> > "timerlatu", 9) == 0/ {
> >         debugf("%s pid %d exiting", args->comm, args->pid)
> > }
> > 
> > > Anyway, the start and stop should probably just pause the threads and not
> > > kill them an start them again. That is, the osnoise_workload_start() should
> > > be called by the init callbacks and the osnoise_workload_stop should be
> > > called by reset callback.
> > >
> > > The start and stop callbacks should just pause and restart the the threads.
> > >
> > 
> > I'm not sure if that fits into the design of timerlat. At least for
> > timerlat with user workload, each activation of the timerlat tracer
> > implies the creation of a new user workload, not the re-activation of
> > a lingering one (that might be an entirely different program). A
> > timerlat tracer is tightly associated with its threads: if the threads
> > exit, the timer itself ceases to have meaning. Of course also rtla
> > should make sure there are no lingering timerlatu processes.
> > 
> > I think waiting on the threads to actually exit in stop_kthread() is
> > the proper solution:
> > 
> > /*
> >  * stop_kthread - stop a workload thread
> >  */
> > static void stop_kthread(unsigned int cpu){
> >     struct task_struct *kthread;
> > 
> >     kthread = per_cpu(per_cpu_osnoise_var, cpu).kthread;
> >     if (kthread) {
> >         if (test_bit(OSN_WORKLOAD, &osnoise_options)) {
> >             kthread_stop(kthread);
> >         } else {
> >             /*
> >              * This is a user thread waiting on the timerlat_fd. We need
> >              * to close all users, and the best way to guarantee this is
> >              * by killing the thread. NOTE: this is a purpose specific file.
> >              */
> >             kill_pid(kthread->thread_pid, SIGKILL, 1);
> >             /* ^^ here wait until kthread (actually the user workload) exits */
> >             put_task_struct(kthread);
> >         }
> >         per_cpu(per_cpu_osnoise_var, cpu).kthread = NULL;
> >     }
> > 
> > There might even be another bug, not sure if calling put_task_struct
> > on a task that is still exiting is sane.
> > 
> > Tomas
> > 
> ---end quoted text---
---end quoted text---

