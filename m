Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F731A725A
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Sep 2024 12:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367679; cv=none; b=cSUsYJrhqSc/Rpu/0f2fKaACHOkTue8n+fB9h/pImojtV0QUndmTN58VUbdQn4cp8emTblTHCyXrHV1tjuqURdXhxo7VzUtiKv2E5qqkhhLPcVfzOk7aWzRa0CUNP1zE/wyEujj3M0knARchlnRtKMtEH/WPvEgpUlVAvk69Xrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367679; c=relaxed/simple;
	bh=38nBdhN362xzFrHx9c/SvDQTiddRNmNAVsbB48MBuY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmnaBfvPWKeKEi229bUpXH6HMWIRbVe/qsKmARjBMthrjdS5SR9+y/xwMsF4MaCUdcOZh5JN62Ju0J6HJR9olNjvRdibqXycTg0sXvfOkgNgCMPdfGrxbKgbysClhHm7cI202tkEHbMttpJSfZLo+7F0J2G80iW7GsRpDZ6zvKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ToigPrgc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ToigPrgc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725367677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A4iuXyfKhiI8SVaO+kKMaEMJwXrp+yyDs1DdjgoBNm8=;
	b=ToigPrgc/vkrY5nJTrH+YHTMC7x20lQB46cpFmi61x3cj1+vNboX2hDXw7ygwwbC5mmsh8
	4a+pWUhB390e334LRmbKA0O7q4c+TdR37/yc/60sDTRCX6bTocQGLb70qOQxgxzkKQ6+FC
	3VtdUNcbeS/xXKsiSu+KjyO7EqlVglo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-cvB4EK01OT-4cQszhN0sXQ-1; Tue, 03 Sep 2024 08:47:56 -0400
X-MC-Unique: cvB4EK01OT-4cQszhN0sXQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a7a83fad218so457684966b.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Sep 2024 05:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725367675; x=1725972475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4iuXyfKhiI8SVaO+kKMaEMJwXrp+yyDs1DdjgoBNm8=;
        b=Oq0ahXnET0fCrhAqSdROu/iuXnikFtSVLG7zU/4lILE6neGeolCmpIXQDki2XHcqDo
         VmqGGyXn2e501MU8/omz9W/3Rk6QWSKzMATT/uWBMyvIkmwsa0lpetpjd0idJj/1VzQ+
         vngTCIf4+yZkJlsxhnNaEYLyn3xW+YMI9q5NWZbnA3gqpeP+ZRqKwwEGe5PBMqbAYtmL
         gdpKHFE8VSdo9W1rVaKS9MdGL2OppKIJlacRf+Mh0mVVstaAh1ciT/8X1BJcU5Cg7+Yi
         kt/+0NO/CmYDKf8MDP+KVVgIK6sbTutbiaVVe/Lxc5rGRiSEplk2ZKVTLml9Kj0sV0EE
         5bMA==
X-Gm-Message-State: AOJu0YzrhoTuXtFbEsHUVQf25fKQU3Q8n9xt4O8nta2E608qNF2GfMf0
	lPiytjFtG5hFJvHGXjuIaXSecp8KJlJDmi5RQXLIer/wP/2iM86UkyaC1azUxvd989YVV49tuzg
	zh4AHqtCsPXmoj5P/8FH+oLMgc4zYFJDdBx/rp5GDT9MFfSvUqw1WDUPOR6YY/EBaWXlYlgjfJz
	/cd9BddDsb5NeN8mh9MaQQlccBGoLGy9o92PZhAuNO5soc
X-Received: by 2002:a17:907:94d4:b0:a86:9258:aeed with SMTP id a640c23a62f3a-a89b9729521mr686424366b.61.1725367675002;
        Tue, 03 Sep 2024 05:47:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEub8oka8LPUWP6yKVSkigULGv+zrIVCG2rIIRYWLoPTZzPEC/tfBPWRqRO2UuQ4cI0EJ02w3kgBfcBOEs8gxs=
X-Received: by 2002:a17:907:94d4:b0:a86:9258:aeed with SMTP id
 a640c23a62f3a-a89b9729521mr686420566b.61.1725367674086; Tue, 03 Sep 2024
 05:47:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820130001.124768-1-tglozar@redhat.com> <20240823125426.404f2705@gandalf.local.home>
 <20240823145211.34ccda61@gandalf.local.home> <CAP4=nvQnW5vS5CQBZtKp-BdjYxNFbq26P36uRy3RhCenHEG_YA@mail.gmail.com>
 <20240826132620.1618d201@gandalf.local.home> <CAP4=nvTR9EuA5WhGweSaoeptEw0n0w5exr8gq6zfqGhGNt3zpg@mail.gmail.com>
In-Reply-To: <CAP4=nvTR9EuA5WhGweSaoeptEw0n0w5exr8gq6zfqGhGNt3zpg@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 3 Sep 2024 14:47:42 +0200
Message-ID: <CAP4=nvRfkZ2CEbFv+MFBXikZ_p2K-1uucgkdgp27JeTxe58qhw@mail.gmail.com>
Subject: Re: [PATCH] tracing/timerlat: Check tlat_var for NULL in timerlat_fd_release
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jkacur@redhat.com, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 27. 8. 2024 v 16:34 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.co=
m> napsal:
>
> I think waiting on the threads to actually exit in stop_kthread() is
> the proper solution:
>
> /*
>  * stop_kthread - stop a workload thread
>  */
> static void stop_kthread(unsigned int cpu){
>     struct task_struct *kthread;
>
>     kthread =3D per_cpu(per_cpu_osnoise_var, cpu).kthread;
>     if (kthread) {
>         if (test_bit(OSN_WORKLOAD, &osnoise_options)) {
>             kthread_stop(kthread);
>         } else {
>             /*
>              * This is a user thread waiting on the timerlat_fd. We need
>              * to close all users, and the best way to guarantee this is
>              * by killing the thread. NOTE: this is a purpose specific fi=
le.
>              */
>             kill_pid(kthread->thread_pid, SIGKILL, 1);
>             /* ^^ here wait until kthread (actually the user workload) ex=
its */
>             put_task_struct(kthread);
>         }
>         per_cpu(per_cpu_osnoise_var, cpu).kthread =3D NULL;
>     }
>

I tried a patch that waits on the user workload to exit when doing
osnoise_workload_stop, similarly to what we already do for the kernel
workload. I added a wait_on_completion in osnoise_workload_stop that
is completed in timerlat_fd_release, mimicking what kthread_stop()
does. But that deadlocks if the user workload process attempts to free
a file descriptor taking trace_types_lock before the timerlat one,
since the caller of osnoise_workload_stop() is also holding
trace_types_lock. There seems to be no way to prevent this deadlock,
since the user workload, unlike the kthread which has a fixed program,
is free to open anything it wants.

I suggest using the workaround suggested in
https://lore.kernel.org/linux-trace-kernel/20240823125426.404f2705@gandalf.=
local.home
for the time being. Together with the patch that adds locks around
stopping the threads
(https://patchwork.kernel.org/project/linux-trace-kernel/patch/202408231028=
16.5e55753b@gandalf.local.home/),
this should prevent the kernel panic at least until we have a solution
for the race itself.

Tomas




Tomas

