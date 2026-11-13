Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606578;
	b=Kb/IZg/NcanJb31/Q1n+AvWq7CHo0UiTOOUOKjrxSqBAMPu9RlWS23gXh1V9b54MSckA
	 ZcC5XcEV2HGUAkVrQpsTv0qolqgnYTG0tSQoWTcoxXdeO+mUuTCp3lLdQxnnpWNYND/yR
	 Su8QURkVMlLh6zo9GWAZ/8FTsAba9hFPKsF2I6SWiPybuLapBQwvf/MADaIid5pxLJcdZ
	 Dn4CWVt1v64I6o3Pt340Apx17e2iBUbo2NiK7kxJRtb3HvHBmMGWvvfElWq3XN5gOo/r+
	 fIQBCXVfWNUOX45nuAy+dSXwAtqOxBNuGY2HP0Fpthehl8DQV5T00ctDC3DLuxtXjcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606578;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=h+GokFWrRb6RyiJcNV+tP7Ka8PzXDY9louULdGqCsWQ=;
	b=pcbxMriDPhkykYUrUM3oex0aCmPSLT/4pP5M+TjPqURWJ6MeO3LnP4HdfMJdz8esxcRI
	 Fj7a80kaG4JQqI1Hoqeiz1xOPEAAr5+hOvYAGayyWxDdt2zIEZ7LVKL4k1vrveTaOrEqU
	 6zBoH1FZjlxTrJMq0jWOpOhcO9NABP3RIzRt7CmeTH0ReMR4QvDZURSIZE6FpuYzABJlU
	 68Y/V4tmqri7mXX1JCmras378KkQEv3QcHrMUbmLW0n6GG74/T25lY50JIOuWDdHE8t1R
	 WeYqzN7oNeDMN0RV5rmSTyoGhDN+nTIogcnPx8wjfhL2o79iM28Qy7onaUn/islGYxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dGgis3lj;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B99260A2635
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 21:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B99260A2635
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dGgis3lj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794606576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h+GokFWrRb6RyiJcNV+tP7Ka8PzXDY9louULdGqCsWQ=;
	b=dGgis3ljEiPVTxal8Nvj/0N9FoPjsknp+9kA9PFaCsRAGjo7J9DF4bgTXLPmeSOBMdWe/y
	bsEcOWgK+AGbOVgouHeIb9BC8LlvjXZlyYcsQbUmo27rdFoFcNaRoByseU4rg1Wl7kq1cc
	nDEptKZii12GL4K2PFrPhZlTKnKZM5M=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-QtOyPknLOFerCko90DtOFg-1; Fri, 13 Nov 2026 16:49:35 -0500
X-MC-Unique: QtOyPknLOFerCko90DtOFg-1
X-Mimecast-MFC-AGG-ID: QtOyPknLOFerCko90DtOFg_1794606574
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-85d630e451aso1890924a34.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 13:49:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606574; x=1795211374;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dlag7MRnimQp/VdUsSYNeNxTfLzNTam8qkTAMMPdLYU=;
        b=wLKo8zXPLbU+FOT+vo3y3StXQoTajZDjoeybtyBuuXYbbcxvyxUWf07FAMlHjH8c1Y
         9P/8rTpH7G5U+hmd+xuIFrbeTjjSNsM3VmLVcZOq4UXlIiHp7H7kn6bh+zRhqlV6EfWF
         K6ZGHO7BnyTi0OigK0jFhgepndjm+mFnWrtedZLtCIgkW78/eg/+QSVDQEw69HhWdr2m
         ppDd3hnXTqLNTl84l6hW0r4KJ7I0yOLNDFITnhv9l7u2tgMlkn1kZvnoK6BfrkzjAxen
         nVMSeICIiw2HTdIwbGwcmGzV8sjgxYdrRJIGOUbcj348OgElNy6rLdBtEoLq+AD8UERt
         YzKg==
X-Forwarded-Encrypted: i=1; AL+hErFY1J9y80BFZEYZNUZFm7KuORtMsk+TPOVRtd+WOD9cGUtezBzIvcevyUjIh7+CRFqjzLgrZR6FCiNJ4fHDVqJlcag=@vger.kernel.org
X-Gm-Message-State: APuU4Z/f2b2fgQjLWZbr8+Pusd8FAjmXvlwh+ZklwL/3WDcNP6yn3lr/
	COaNYtcSSxL/0jZpRwe7uVQQ2+ca1Vlh2U+jwPsf60q1azjeYvLuzmBIyYJY7167K+vxWV1HPdP
	SZGm1xaJ1x6hBDz762MjGQ4HpThqEUkF36FL1XSzcAWPqpAafX+dR/AH/jtrTQZKntRONJk+u0Q
	==
X-Gm-Gg: AYBFou1oM0i7TXKpHkjsoK5dwTQ8KohZHlGfQTv+D/Lj+uXPP3no8XAVV6h+KYmyFVz
	TFeY4GAapFlDiewwtL+3jq+mi2ce3ziKe44dOaZa96kbw6vdHDFJcAKPGpWCB2nEJNshh78Hh8o
	oPSS4kA3/DkPHE//2o/efVSJrGWK6ejdJ+q/ZCYBNrz1isc4c2LbxBgjLYVhTtTzrJueoncO3C2
	yY7rbA7y1QXLo8KTssYKKSNAqGKZCurYdfSM72vV3ezGACgneGB5f+qlV8kIdkKWRKoyi6NLI1i
	wDpuRIim4LQ29OyJzmBMBR4Vub46OJS9Oiap+JNQZUZMTjRoMnrog55j9EP2aAAE51BCSziwBxL
	bKoJoW7VMMIgzdntrqZ7hyIE9rAwD1z91UDlaGtwBoN1MmOtrHzPfhYB1xzaZn/l3dPWEONDUGP
	mB/Wi9Gn3yfhOCoum0by+ZQDzOhtHr
X-Received: by 2002:a05:6830:230c:b0:81f:da91:c984 with SMTP id 46e09a7af769-8628984ffd3mr5321303a34.11.1794606574275;
        Fri, 13 Nov 2026 13:49:34 -0800 (PST)
X-Received: by 2002:a05:6830:230c:b0:81f:da91:c984 with SMTP id 46e09a7af769-8628984ffd3mr5321261a34.11.1794606573813;
        Fri, 13 Nov 2026 13:49:33 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862881a965esm3363739a34.25.2026.11.13.13.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 13:49:33 -0800 (PST)
Message-ID: <c03ddcb736c86c7fa16d8beeb8af9ecb6343d9f5.camel@redhat.com>
Subject: Re: [PATCH v6 02/10] tracing/osnoise: start_kthread: Always check
 OSN_WORKLOAD
From: Crystal Wood <crwood@redhat.com>
To: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, 	linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 13 Nov 2026 15:49:32 -0600
In-Reply-To: <179447882048.254241.2527227025791137084@gmail.com>
References: <20261028220120.4005187-3-crwood@redhat.com>
	 <179447882048.254241.2527227025791137084@gmail.com>
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
X-Mimecast-MFC-PROC-ID: 9LNDFun7d3Us-HJE0tqpMNS4ORn6tYxQmkle4qvgcuc_1794606574
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-11-12 at 18:20 +0800, Chaosheng Qu wrote:
> On Wed, 28 Oct 2026 17:01:20 -0500
> Crystal Wood <crwood@redhat.com> wrote:
>=20
> > We can get here on timerlat with OSN_WORKLOAD cleared via
> > osnoise_hotplug_workfn().
>=20
> Confirming this from the other side, because it is worse than a stray
> thread.  On 7.3-rc7, with `rtla timerlat top -q -c 0,1` and cpu1 cycled
> offline and back online mid-run, the CPU coming up installs a
> "timerlat/1" kthread even though OSN_WORKLOAD is clear.  stop_kthread()
> picks the teardown path from the *current* OSN_WORKLOAD, so when the
> trace stops it takes the user-thread branch for that kthread:
>=20
>     WARNING: at stop_kthread+0xc6/0xd0, CPU#1: rtla/57
>     WARNING: at __put_task_struct+0xdf/0x100, CPU#1: timerlat/1/72
>     WARNING: at free_task+0x7d/0x90, CPU#1: kthreadd/2
>     BUG: kernel NULL pointer dereference, address: 0000000000000018  (rep=
eated)
>=20
> kill_pid() plus put_task_struct() is only right for the user thread,
> which owns the reference taken in timerlat_fd_open().  A kthread is owned
> by kthread_stop(), so the extra put frees it while it is still running.
> A plain offline (never bringing the CPU back) does not reproduce it,
> because nothing calls start_kthread() then.  So 02/10 fixes a null-deref
> here, not just a redundant thread.

If you stop at patch 2 I'm sure you'll find other ways to make it go
boom too :-)

> One thing about the series itself:
>=20
> 02/10 sets osn->sampling, but `struct osnoise_variables *osn` is not
> declared in start_kthread() until 04/10:
>=20
>     @@ -2053,15 +2081,18 @@ static int start_kthread(unsigned int cpu)
>     +=09struct osnoise_variables *osn =3D cpu_osn_var(cpu);
>=20
> so 02/10 alone does not compile with CONFIG_OSNOISE_TRACER=3Dy.  Sashiko
> flagged this on v6 and it looks like it is still there in the posted
> version.  I applied 02/10 on its own on 7.3-rc7 to be sure:

This should be fixed in v7.  Not sure what you meant by "the posted
version" other than v6 itself.

>=20
>     kernel/trace/trace_osnoise.c: In function 'start_kthread':
>     kernel/trace/trace_osnoise.c:2043:25: error: 'osn' undeclared (first =
use in this function)
>      2043 |                         osn->sampling =3D true;
>=20
>     +=09if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
>     +=09=09if (!timerlat_enabled())
>     +=09=09=09osn->sampling =3D true;
>=20
> Either move the "osn" declaration into 02/10, or keep
> `cpu_osn_var(cpu)->sampling` in this patch and let 04/10 switch it.  The
> second keeps each patch buildable on its own, which helps anyone
> bisecting the series.

I moved the declaration into patch 1, which seemed more appropriate
given that patch is all about cleaning up the per-cpu references.

-Crystal

