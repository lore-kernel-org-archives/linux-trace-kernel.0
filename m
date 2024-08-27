Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F871624
	for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769299; cv=none; b=ruPe3faucmGC3ii313eaHVaPlvgxU9vC1FbLpWl0YgwQo5RidxPSyUdfXs+/DLW9CPeQAeUUIiR/I/WdDtKTuY5bdugIQlenLrL7SFFG13WVhJwVW8zpXUT9cj1Sbr++exlxChkYYpcfKaQxEa57Ro38PxQ1MJYeAyIQPuys5dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769299; c=relaxed/simple;
	bh=hbYne1pfgTFWnnTMvpQLFh+ZyDiGc50wGAfOyXWLm5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCbYXrHfCZk0AkTl+ibfYh5DLraEGMMs5F3RwG/co6FnvXkgoPIPvim0lVBI79ZgLxt+Twz0l06sVDbov1uh5P4CH7Iq9A+wn/5T3zTOvw+OkSN3GnF6rZDhLnYtEZJxCL5pHN5lTy4TE4iSn9sHwWpED5KGPxVe/09fA6zHTCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V05WqAcf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V05WqAcf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724769296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iwu4Za2Wm1Yaizvy4lS8Xc7WL1qKP7PD7M1ARL9g61k=;
	b=V05WqAcf8u/uwG8ImxRIREEoWsp1oMSbjTe+qlS0SaRDnkOEeC3e/kfVsu8nde+wZgjwGe
	6/9miww/r9lGrpc/i032uUyHCfSRy8ZLuGKpVSnWHQTef6bNXzMyPo+wCKHplPwAg0bkpE
	p0qiuZGVCwZsVsDqWzUd9agZLDigZ78=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-ZV2qIwFJNpCbVC7-pT3u4g-1; Tue, 27 Aug 2024 10:34:52 -0400
X-MC-Unique: ZV2qIwFJNpCbVC7-pT3u4g-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a7d6a72ad99so507065266b.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724769291; x=1725374091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iwu4Za2Wm1Yaizvy4lS8Xc7WL1qKP7PD7M1ARL9g61k=;
        b=TRzZXVd1J18WudWvmDOAxJFGWcFNgY88KHuglznbz10u46czJhxtkSEywcj1Lm2D1q
         ZLyea9oZdVYMPNJGp63RjESzjKroeJpz2wR0oTHloO+1qlEeLJKW63Yn5AeiDkfORLc4
         cW3gXQJxpH4TdAmAl5YIdqg3yTevZp/FvORIOxPyrPdNvmG2VpZdQb26o6zF5YBfLAqC
         qNSILlpoJOA42VtnCbmH4Q+kLj2Qo/QAAe+V9/flsvSwB2iYbRKajepeJMHDldWU2SAW
         cK+fzmcOg8LM1U6vMQ2rKY2vHznnNMBm1CwtP7SPdvQvxBkwkP3jQornhthvwx7PwLaK
         BlCQ==
X-Gm-Message-State: AOJu0Yya44/ozlSDp9ILie4PuQjopvj613JbJnciS1sOJkhb9NUSf+ZD
	8pLXXLKSbDuQ3jomeATugRmkkFJkHz9FUdb/yhVgXjZWgtrO7kBIWJInmk8Yb7/hVbyV8L27yYo
	4YYf9Jj+KDOeDnKhyzlfwHva5ewh0DD1BtU3gSSkv3KO1trOOvRgQ/9Xb3N8ikve+dujkJdpZOX
	wpumYQHtRD59LJBpzTsOTsxUfTaX1IL4zNeNuVzybG996Z
X-Received: by 2002:a17:907:2da7:b0:a86:96f5:fa81 with SMTP id a640c23a62f3a-a86e3a36fbbmr231848166b.32.1724769291440;
        Tue, 27 Aug 2024 07:34:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZX+6v8RfoUIBAptFlsQmYtDjq55qaW8kWJXtouIu1hlDX1t+LZCcF+kX2NfJ9T4Wrn/Lyhgs1FvmrE3sswOA=
X-Received: by 2002:a17:907:2da7:b0:a86:96f5:fa81 with SMTP id
 a640c23a62f3a-a86e3a36fbbmr231843966b.32.1724769290430; Tue, 27 Aug 2024
 07:34:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820130001.124768-1-tglozar@redhat.com> <20240823125426.404f2705@gandalf.local.home>
 <20240823145211.34ccda61@gandalf.local.home> <CAP4=nvQnW5vS5CQBZtKp-BdjYxNFbq26P36uRy3RhCenHEG_YA@mail.gmail.com>
 <20240826132620.1618d201@gandalf.local.home>
In-Reply-To: <20240826132620.1618d201@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 27 Aug 2024 16:34:39 +0200
Message-ID: <CAP4=nvTR9EuA5WhGweSaoeptEw0n0w5exr8gq6zfqGhGNt3zpg@mail.gmail.com>
Subject: Re: [PATCH] tracing/timerlat: Check tlat_var for NULL in timerlat_fd_release
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jkacur@redhat.com, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 26. 8. 2024 v 19:27 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis.org>=
 napsal:
>
> Yeah, I think I finally found the real issue. I don't think we need the r=
ef
> counting. The problem is the creating and killing of the threads via the
> start and stop callbacks. That's not their purpose. The purpose of stop
> and start callbacks is when tracing_on is set to off and back on again. I
> think this is what is racing with the close.
>

I believe I discovered the exact mechanism of the bug. Since rtla is
killed with SIGTERM, it leaves the timerlat tracer active and its
timerlatu processes running. The rtla from the next iteration of the
while loop in the reproducer deactivates the timerlat tracer,
triggering the killing of the timerlatu processes. However, this
killing is asynchronous, and while the processes are gradually dying
one by one and closing their fds, the rtla from the next iteration is
already activating the timerlat tracer again. One of the timerlatu
processes does not die fast enough to release the fd before the
tlat_var is cleared in osnoise_workload_start, triggering the panic.

You can see the bug in action in this detailed trace I got today, with
the use of in-kernel trace_printk together with bpftrace and
bpf_trace_printk and captured using ftrace_dump_on_oops (running the
same reproducer on a 8 CPU KVM system):
[  103.227679]     rtla-2325      2..... 98242607us :
osnoise_workload_start: tlat_var_reset: cpu=3D0,
tlat_var=3D0000000034996efa
[  103.227844]     rtla-2325      2..... 98242607us :
osnoise_workload_start: tlat_var_reset: cpu=3D1,
tlat_var=3D0000000062d1f520
[  103.228009]     rtla-2325      2..... 98242607us :
osnoise_workload_start: tlat_var_reset: cpu=3D2,
tlat_var=3D0000000002e262d8
[  103.228173]     rtla-2325      2..... 98242607us :
osnoise_workload_start: tlat_var_reset: cpu=3D3,
tlat_var=3D00000000b9d3a280
[  103.228349]     rtla-2325      2..... 98242607us :
osnoise_workload_start: tlat_var_reset: cpu=3D4,
tlat_var=3D000000000fba7a6e
[  103.228510]     rtla-2325      2..... 98242608us :
osnoise_workload_start: tlat_var_reset: cpu=3D5,
tlat_var=3D000000008ed0b87f
[  103.228670]     rtla-2325      2..... 98242608us :
osnoise_workload_start: tlat_var_reset: cpu=3D6,
tlat_var=3D00000000a02fe267
[  103.228831]     rtla-2325      2..... 98242608us :
osnoise_workload_start: tlat_var_reset: cpu=3D7,
tlat_var=3D000000008e1d5095
[  103.228992]     rtla-2327      3...11 98256551us :
bpf_trace_printk: rtla pid 2325 forks into 2328
[  103.229156]     rtla-2327      3...11 98256873us :
bpf_trace_printk: rtla pid 2325 forks into 2329
[  103.229325]     rtla-2327      3...11 98257124us :
bpf_trace_printk: rtla pid 2325 forks into 2330
[  103.229489]     rtla-2327      3...11 98257353us :
bpf_trace_printk: rtla pid 2325 forks into 2331
[  103.229651]     rtla-2327      3...11 98257574us :
bpf_trace_printk: rtla pid 2325 forks into 2332
[  103.229810]     rtla-2327      3...11 98257801us :
bpf_trace_printk: rtla pid 2325 forks into 2333
[  103.229968]     rtla-2327      3...11 98258008us :
bpf_trace_printk: rtla pid 2325 forks into 2334
[  103.230124]     rtla-2327      3...11 98258216us :
bpf_trace_printk: rtla pid 2325 forks into 2335
[  103.230293]     bash-2094      0d..31 102987914us :
bpf_trace_printk: rtla pid 2325 received signal 2
[  103.230452]     bash-2094      0d..31 102987915us :
bpf_trace_printk: ...from bash pid 2094
[  103.230609]     bash-2094      0d..31 102990000us :
bpf_trace_printk: rtla pid 2325 received signal 15
[  103.230766]     bash-2094      0d..31 102990001us :
bpf_trace_printk: ...from bash pid 2094
[  103.230922]     rtla-2325      2...21 102990010us :
bpf_trace_printk: rtla pid 2325 exiting
[  103.231079]     rtla-2327      3...21 102990503us :
bpf_trace_printk: rtla pid 2327 exiting
[  103.231242]     rtla-2337      3d..31 103232021us :
bpf_trace_printk: timerlatu/0 pid 2328 received signal 9
[  103.231399]     rtla-2337      3d..31 103232022us :
bpf_trace_printk: ...from rtla pid 2337
[  103.231554]     rtla-2337      3d..31 103232024us :
bpf_trace_printk: timerlatu/1 pid 2329 received signal 9
[  103.231711]     rtla-2337      3d..31 103232025us :
bpf_trace_printk: ...from rtla pid 2337
[  103.231866]     rtla-2337      3d..31 103232029us :
bpf_trace_printk: timerlatu/2 pid 2330 received signal 9
[  103.232022]     rtla-2337      3d..31 103232030us :
bpf_trace_printk: ...from rtla pid 2337
[  103.232178]     rtla-2337      3dN.31 103232031us :
bpf_trace_printk: timerlatu/3 pid 2331 received signal 9
[  103.232347]     rtla-2337      3dN.31 103232031us :
bpf_trace_printk: ...from rtla pid 2337
[  103.232506]     rtla-2337      3dN.31 103232034us :
bpf_trace_printk: timerlatu/4 pid 2332 received signal 9
[  103.232685]     rtla-2337      3dN.31 103232034us :
bpf_trace_printk: ...from rtla pid 2337
[  103.232846]     rtla-2337      3dN.31 103232039us :
bpf_trace_printk: timerlatu/5 pid 2333 received signal 9
[  103.233010]     rtla-2337      3dN.31 103232039us :
bpf_trace_printk: ...from rtla pid 2337
[  103.233171]     rtla-2337      3dN.31 103232042us :
bpf_trace_printk: timerlatu/6 pid 2334 received signal 9
[  103.233357]     rtla-2337      3dN.31 103232042us :
bpf_trace_printk: ...from rtla pid 2337
[  103.233517]     rtla-2337      3dN.31 103232046us :
bpf_trace_printk: timerlatu/7 pid 2335 received signal 9
[  103.233678]     rtla-2337      3dN.31 103232046us :
bpf_trace_printk: ...from rtla pid 2337
[  103.233835] timerlat-2331      3...21 103232701us :
bpf_trace_printk: timerlatu/3 pid 2331 exiting
[  103.233995] timerlat-2329      1...21 103232704us :
bpf_trace_printk: timerlatu/1 pid 2329 exiting
[  103.234155] timerlat-2331      3....1 103232705us :
timerlat_fd_release: timerlat_fd_release: cpu=3D3,
tlat_var=3D000000000fba7a6e, osn_var->pid=3D2331
[  103.234357] timerlat-2329      1....1 103232706us :
timerlat_fd_release: timerlat_fd_release: cpu=3D1,
tlat_var=3D0000000002e262d8, osn_var->pid=3D2329
[  103.234508] timerlat-2334      6...21 103232821us :
bpf_trace_printk: timerlatu/6 pid 2334 exiting
[  103.234657] timerlat-2334      6....1 103232826us :
timerlat_fd_release: timerlat_fd_release: cpu=3D6,
tlat_var=3D000000008e1d5095, osn_var->pid=3D2334
[  103.234813] timerlat-2330      2...21 103232850us :
bpf_trace_printk: timerlatu/2 pid 2330 exiting
[  103.234966] timerlat-2330      2....1 103232853us :
timerlat_fd_release: timerlat_fd_release: cpu=3D2,
tlat_var=3D00000000b9d3a280, osn_var->pid=3D2330
[  103.235122] timerlat-2333      5...21 103232856us :
bpf_trace_printk: timerlatu/5 pid 2333 exiting
[  103.235291] timerlat-2333      5....1 103232858us :
timerlat_fd_release: timerlat_fd_release: cpu=3D5,
tlat_var=3D00000000a02fe267, osn_var->pid=3D2333
[  103.235452] timerlat-2332      4...21 103232861us :
bpf_trace_printk: timerlatu/4 pid 2332 exiting
[  103.235610] timerlat-2332      4....1 103232864us :
timerlat_fd_release: timerlat_fd_release: cpu=3D4,
tlat_var=3D000000008ed0b87f, osn_var->pid=3D2332
[  103.235769] timerlat-2335      7...21 103232867us :
bpf_trace_printk: timerlatu/7 pid 2335 exiting
[  103.235932] timerlat-2335      7....1 103232869us :
timerlat_fd_release: timerlat_fd_release: cpu=3D7,
tlat_var=3D000000003113e297, osn_var->pid=3D2335
[  103.236103]     rtla-2337      3..... 103234109us :
osnoise_workload_start: tlat_var_reset: cpu=3D0,
tlat_var=3D0000000034996efa
[  103.236316]     rtla-2337      3..... 103234109us :
osnoise_workload_start: tlat_var_reset: cpu=3D1,
tlat_var=3D0000000062d1f520
[  103.236473]     rtla-2337      3..... 103234109us :
osnoise_workload_start: tlat_var_reset: cpu=3D2,
tlat_var=3D0000000002e262d8
[  103.236630]     rtla-2337      3..... 103234110us :
osnoise_workload_start: tlat_var_reset: cpu=3D3,
tlat_var=3D00000000b9d3a280
[  103.236797]     rtla-2337      3..... 103234110us :
osnoise_workload_start: tlat_var_reset: cpu=3D4,
tlat_var=3D000000000fba7a6e
[  103.236972]     rtla-2337      3..... 103234110us :
osnoise_workload_start: tlat_var_reset: cpu=3D5,
tlat_var=3D000000008ed0b87f
[  103.237144]     rtla-2337      3..... 103234110us :
osnoise_workload_start: tlat_var_reset: cpu=3D6,
tlat_var=3D00000000a02fe267
[  103.237345]     rtla-2337      3..... 103234110us :
osnoise_workload_start: tlat_var_reset: cpu=3D7,
tlat_var=3D000000008e1d5095
[  103.237516] timerlat-2328      0...21 103234149us :
bpf_trace_printk: timerlatu/0 pid 2328 exiting
[  103.237690] timerlat-2328      0....1 103234152us :
timerlat_fd_release: timerlat_fd_release: cpu=3D0,
tlat_var=3D0000000062d1f520, osn_var->pid=3D0
[  103.237871] ---------------------------------
[  103.238053] CR2: 0000000000000010

On the kernel side, I'm using similar trace_printk debug prints as you
did; the bpftrace program used is this:
uretprobe:libc:fork
/strncmp(comm, "rtla", 5) =3D=3D 0 && retval !=3D 0/
{
        debugf("rtla pid %d forks into %d", pid, retval)
}
tracepoint:signal:signal_generate
/strncmp(args->comm, "rtla", 5) =3D=3D 0 || strncmp(args->comm,
"timerlatu", 9) =3D=3D 0/ {
        debugf("%s pid %d received signal %d", args->comm, args->pid,
args->sig);
        debugf("...from %s pid %d", comm, pid);
}
tracepoint:sched:sched_process_exit
/strncmp(args->comm, "rtla", 5) =3D=3D 0 || strncmp(args->comm,
"timerlatu", 9) =3D=3D 0/ {
        debugf("%s pid %d exiting", args->comm, args->pid)
}

> Anyway, the start and stop should probably just pause the threads and not
> kill them an start them again. That is, the osnoise_workload_start() shou=
ld
> be called by the init callbacks and the osnoise_workload_stop should be
> called by reset callback.
>
> The start and stop callbacks should just pause and restart the the thread=
s.
>

I'm not sure if that fits into the design of timerlat. At least for
timerlat with user workload, each activation of the timerlat tracer
implies the creation of a new user workload, not the re-activation of
a lingering one (that might be an entirely different program). A
timerlat tracer is tightly associated with its threads: if the threads
exit, the timer itself ceases to have meaning. Of course also rtla
should make sure there are no lingering timerlatu processes.

I think waiting on the threads to actually exit in stop_kthread() is
the proper solution:

/*
 * stop_kthread - stop a workload thread
 */
static void stop_kthread(unsigned int cpu){
    struct task_struct *kthread;

    kthread =3D per_cpu(per_cpu_osnoise_var, cpu).kthread;
    if (kthread) {
        if (test_bit(OSN_WORKLOAD, &osnoise_options)) {
            kthread_stop(kthread);
        } else {
            /*
             * This is a user thread waiting on the timerlat_fd. We need
             * to close all users, and the best way to guarantee this is
             * by killing the thread. NOTE: this is a purpose specific file=
.
             */
            kill_pid(kthread->thread_pid, SIGKILL, 1);
            /* ^^ here wait until kthread (actually the user workload) exit=
s */
            put_task_struct(kthread);
        }
        per_cpu(per_cpu_osnoise_var, cpu).kthread =3D NULL;
    }

There might even be another bug, not sure if calling put_task_struct
on a task that is still exiting is sane.

Tomas

