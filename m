Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601401;
	b=Dse/+CXWBub8vyW0lmq69PsWVQsjiajQhiR93OEBHnb+DSQMHCSlQwtnqptUXi+SqylJ
	 qWemTACWOsW9XM6t5/lETBFGRINERf0szeYRTTzCGBJfNjq3sJ96/4LLTRqV5sL9ywzrZ
	 XNgM9D1tLdxrNijkUpV3gS3lV30Wgg/KYxGhMMHy5Yb8MOoZdMtnplblowSuu64RNt7sV
	 Kng4n/AxWYnlCWXBOrCgq58OnoH5m/AAYl0+8h49QYZoqG/mwq8vBVIzfnuz3sHaL04Uy
	 1VoHIjtqBfF85PHWm0bPodaPPBctcuLjpka+G3egdNY+BvNkNM8TBGfYIHS6cprevIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601401;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:User-Agent:
	 MIME-Version:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Transfer-Encoding;
	bh=OmgP7lpAhGw+ltLrjN+pc1MVDZJ3Kku9R5PxK3eTW1c=;
	b=qVbL0DQ66yCcMxo9vDUkaIXt+nsEz8tqaQJ1rc5XmaqU3OihgF9MRCOZOvAfvg52HdpP
	 11g8bjSyHwCxszgzkpcpkI39GSEOUUx8aIEeA9rFBIigiPBYGn2rtJVt8BeGax0B+QenQ
	 whSfUqF295xJ7gI0OKLPTjxL8K2rdB5Iv8qpqErpSd7WF9W6kA4fgdv/kIkdHmscxoAK0
	 aczaIbvARDfpLl1HJABp70n3EGDoJX3X5KkASWR5c16WQim7f+xHUa0FX+V+8HkX2MafV
	 VtnTJ9GxCD4reJ+5sPeEiDk54f/mzo42RAHrpcAOZIhyUBfpewNl+3nRQ2NtrhIBAUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g6fFGq2j;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC42B606A336
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 20:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC42B606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g6fFGq2j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794601399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OmgP7lpAhGw+ltLrjN+pc1MVDZJ3Kku9R5PxK3eTW1c=;
	b=g6fFGq2jz9SCICkNVp8Ec6JZh5qqXa6iqPCN/AAVdPEs4lcMyHnpVKU/7HlOyrXfU0tmnr
	D3asAoGyUO1xWzT6AhscZcEBm1hWaRfB53n77kWxxPmK8a4qmw9U7Okm3XoPX5eYwdYaCs
	AEn8SWKudYAcn+xG+sxfMqp2mrD7/7A=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-A-V6rNQWNW6DZ5giK7zjSg-1; Fri, 13 Nov 2026 15:23:18 -0500
X-MC-Unique: A-V6rNQWNW6DZ5giK7zjSg-1
X-Mimecast-MFC-AGG-ID: A-V6rNQWNW6DZ5giK7zjSg_1794601397
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-45952ce9ee0so1905219fac.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 12:23:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794601397; x=1795206197;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OmgP7lpAhGw+ltLrjN+pc1MVDZJ3Kku9R5PxK3eTW1c=;
        b=IeRvpO/5SIRnQdQu5uuz/5/7c77aEeOwW+y3BYRRiBl59w7sB/K6cMx+HrRcKz2lTK
         kCrIGuRhJpVxq4tTI92WuL7VhOds0ERMD7SdjxCzPGkuucobamZMFykeVoSsay/XIS6S
         1RwrnJPNTEFm2ga1p6+vSzvG/rFHMVIR06Bf1Vuyn1wuB76yMKlG5mSbf+EJwYoADpq3
         NoUaim3dcypTj948priokHjqCAcTLQeyBljuVoPI0yU0TIDI95Y3TxCWezWB6zhn0+Un
         S8CgZt5J8SvWWP+l/3yWpG9Bf7PmiuBf4zjv/Mix60Yck6J0A8QuZDvQ91QqfuiySGXw
         oYKA==
X-Gm-Message-State: APuU4Z9bM0Sew6ZmZ2jWRkWCMwhZUaMUZUdrCLEL7Z8Z9LxYLz+nYn15
	sOj/CLArf2asWLs4KtnD+4IlGgnnQF8yjA/YZ/AAQG9EJNmqUuSU0J6CLa6AoxFE83b9jdPaB2m
	WaEkDSVPKfObWOIouQl7gwnQ39/DLYNo0nMNs0TpidPbZVFznZRLk7vw/LpecjMesAiV4cc1YpP
	/f/j/UhQ==
X-Gm-Gg: AYBFou2vXPCTaA97izsaXYkgcJp3jAtj2KR2z1HSvzEjOmywA57gsAr5WQsMq0lCH7k
	J0l4YnGI/HafwtUzgOL4+TmYv1xtJs5o0RjqlTOneZ0pQGVKmZV3GzKP+sXkNQ7aXItnQ+L+3DM
	7OJElcKNEjYnVP87fu1UAtCUipbBhnq8/NNuixfZEaDMPtIp68SKGluhKXpWvP6G7teaCRmwBP6
	btcBiArOwAd0kq60pCvAhMMRTZCP+E8LjCrUVEN4iTzzPpJs6MlxvQa+1bbqeK62P4UhoXt3gtu
	Sv94SJcjEm48Kc6zQN2+E5YB/3RUfw4h75nsK90Il3JJ9RiI+0pbguQIa8sYDPNjRgMdYJPT2Dx
	OdU7speAMfZO0QF+DK+Lg7ebgNFLo/f/GzQG9TscD7G3nHbxXt1hrBxKU953AlzACQ63pOV7D5/
	w4kSpEpzrAaPEutWx2NTz53p8XTHAs
X-Received: by 2002:a05:6870:568a:b0:46a:e87f:a7f3 with SMTP id 586e51a60fabf-4afdf031ac6mr3908828fac.2.1794601397396;
        Fri, 13 Nov 2026 12:23:17 -0800 (PST)
X-Received: by 2002:a05:6870:568a:b0:46a:e87f:a7f3 with SMTP id 586e51a60fabf-4afdf031ac6mr3908812fac.2.1794601396986;
        Fri, 13 Nov 2026 12:23:16 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4afe2200c91sm1914434fac.4.2026.11.13.12.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:23:16 -0800 (PST)
Message-ID: <dc20c6087569c0bba7469216f29832dbb23abd23.camel@redhat.com>
Subject: Re: [PATCH v7 05/10] tracing/osnoise: Per-cpu mutexes and fd
 detachment
From: Crystal Wood <crwood@redhat.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Date: Fri, 13 Nov 2026 14:23:15 -0600
In-Reply-To: <sashiko-outbox-212329@kernel.org>
References: <20261113064103.3041704-1-crwood@redhat.com>
	 <20261113064103.3041704-6-crwood@redhat.com>
	 <sashiko-outbox-212329@kernel.org>
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4g3p__FiCSC88VMS5feDYEtl3mqpQ6fi29m6sUIrqr0_1794601397
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-11-13 at 07:14 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] tracing/osnoise: missing migration detection in
>   timerlat_fd_read()
> --
>=20
> commit d34bc9208d90b4be9c903307f53e72248c2ac3b7
> Author: Crystal Wood <crwood@redhat.com>
>=20
> tracing/osnoise: Per-cpu mutexes and fd detachment
>=20
> This commit introduces per-cpu mutexes to protect kthread and timerlat fi=
le
> descriptor state, replacing the SIGKILL mechanism for user-space timerlat
> threads with a mutex-protected detachment mechanism.
>=20
> [Severity: Medium]
> In kernel/trace/trace_osnoise.c, timerlat_fd_read() removes the
> cpu !=3D smp_processor_id() migration handling (which set
> cpu_tmr_var(cpu)->uthread_migrate =3D 1, tainted osnoise, and stopped
> tracing) and instead locks this_cpu_tmr_var()->detach_lock before checkin=
g
> fdd !=3D osn_var->fdd or tlat->uthread_migrate.
>=20
> Can this miss user-space thread migrations when NO_OSNOISE_WORKLOAD is
> enabled after the timerlat tracer has already been started?
>=20
> By default, OSN_WORKLOAD is set in osnoise_options. If the user enables
> timerlat first and then writes NO_OSNOISE_WORKLOAD to osnoise/options (as
> shown in Documentation/trace/timerlat-tracer.rst), osnoise_options_write(=
)
> does not call register_migration_monitor(), which only runs during initia=
l
> tracer startup in osnoise_workload_start() -> osnoise_hook_events() ->
> hook_thread_events() -> register_migration_monitor() and skips registerin=
g
> trace_sched_migrate_callback() when OSN_WORKLOAD is set.

That's a minor pre-existing bug that shouldn't block this patchset.

-Crystal

