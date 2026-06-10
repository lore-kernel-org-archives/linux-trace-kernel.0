Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C56B248F57
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 19:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121068; cv=none; b=D1pP5GMfw6mYU1z11hWfszDTuq2imetL2r6Z9dFIFoAVlakwAcNo0csmJpCoiT67taZbK9ONYPgaWDrijpBQ+sZn6aOKaiXsOuMG7awPWp8OzyObjBcM+J0MC5ixUqyQg0URjhIZfAZqrW2wO2kFrA+vL7cum5CZDBcofH3eloQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121068; c=relaxed/simple;
	bh=CKbRKDO7eWYh+7hEyJVpBppZx+7Hd8mr/w4pLbPDno4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jal0vtJBIyhc0Yk3GOgNX51MsQrHtBiDllTRmEQdpGQx9u4jwYMRA+6r+FiDv21ttJgHfFLFEgROz61LxywriNgh8LVvbzYMqnL9VItrwuzKB8J17ODg0ljurQxsqL/nPz8sEDXCfvm/NxwEpu/uHyuMiOoYTw0uvYmGmC9lX+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fcnj9QqP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fcnj9QqP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781121066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjKWxDzCHSmUCgExH7Ye+6nL/fXmFRzO7uCaop1VMvA=;
	b=Fcnj9QqPheYcrgJFsiDqWOD5L6QD36mEAqhBnnTEusFuibhjB9w0l7I/K27ZTtXHEv/W7h
	HfPWLaS5U2D/fpmNddU7WJlNNM8kiLuWhVrNN1Mx7Qqf7+2CfQicROzw5ZATIo1jzVF97J
	eXtGHOcUt4m1Qqu1eXpzUnwuOh+dZRo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-3BL6q_rNM42o2CXhGayA8Q-1; Wed, 10 Jun 2026 15:51:05 -0400
X-MC-Unique: 3BL6q_rNM42o2CXhGayA8Q-1
X-Mimecast-MFC-AGG-ID: 3BL6q_rNM42o2CXhGayA8Q_1781121065
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5178aed25baso145278261cf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 12:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781121064; x=1781725864;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRFqrK+FD8/ttWzWSAic+qFGoF10SyTo3eAZoCNE+ag=;
        b=WcFvuFQdsvEIe2jS6xN3oOqM9z96PU4OiZ2v3PJiv6l6dptjXgQOQOYjik6UfAR5sm
         6TpBsx11TGTfDbpf0krzG/9Er1Uwxa6bEW7WBjj/8V6S+Rk2MHxHobSp3Jn0KXPfXBXR
         8XTey7zEzByYl5d7urh9HXj/XQqTAtH7s5KRD76R+8hW8fxHD0+R9OyJtRZ9sC4Ob/Ov
         uG+aYPhaPgq1e8yAx/7W/HlL0UfIJoaTBIUqSJ7KIb3u7kinACnjCOuPzpBwfPhQxGfo
         IMwBqj3Thr9/s7ZfBL+gq6JFfoKSJGloaBjOs/fZfvqB7bQ/FASKNMXhrbpD1HTMpxmC
         o7Rg==
X-Forwarded-Encrypted: i=1; AFNElJ+eFDW9tZpvCsNe18qf8nvOiLFA2JpU+su+j9mVNkHvhKYu+mVOuZh6fSemSLie7FoiXebTyGpheKmPCZZrw1bQo3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF3o+Nfx713YTZHj3NGTeUcBjFeNUgP0Kbi+/JmI5ub0195DPP
	f9y8VuYLZsb9bfhdzKcX/HJ5ynxsaa+BrFSIa3swTmlhbT4WkDkmnQVN7eLsJ8DuPwz0w6C8RvP
	iaQQfEVGQj/drUWsZym1yRYC9Y3uQ00g5QxTJkdLQJce24FLqja+FL5YMLADg5fJ2wbh/oZDoGQ
	==
X-Gm-Gg: Acq92OHvQAcuocMlUKL5mw849nLN1hq/3hsotJUMhYs/sb6Aj/b0qnO9CC8M9V0LabI
	zfnovKx1TQHO3gny9FhQ9v1yXN0aTHWd1pbu8gH3Jem+AOlaejBQ3GGVEBps/kSi+YbroGhU/e0
	48Zy95Y9JnDeWejjGmnRgGj+bvrYj1gDjNcyuuz0wicuaIih26ZsIiX9B2E0GTeVUIlP3YQD7vG
	UJVUs3rnB2VdLBn0xs+ds4zVRPGjAd1Y8cTx3HRY6EaA3jp3naw2FYgP6WE/Cv3zzxHc5nicqOi
	l+Ys+lVYFEzpaBrtI4PZi1oRKobUJV5Y4W0wn5FLN7MkiqcrMI8uahpGBsl4WjYghoQRq8osiNg
	vwp0N/7bHZbZM33C5YGWq8OdF/wNNblATWxq3ros6Rn+QPk6OPm8gpiV+IDiMzY1d
X-Received: by 2002:a05:622a:114c:b0:517:d869:4293 with SMTP id d75a77b69052e-517eaa95694mr12023581cf.43.1781121064493;
        Wed, 10 Jun 2026 12:51:04 -0700 (PDT)
X-Received: by 2002:a05:622a:114c:b0:517:d869:4293 with SMTP id d75a77b69052e-517eaa95694mr12023101cf.43.1781121064032;
        Wed, 10 Jun 2026 12:51:04 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccd9fa53sm243219196d6.8.2026.06.10.12.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 12:51:03 -0700 (PDT)
Message-ID: <f40903f8198f8e2f42f1efdf950f995f24cf6e93.camel@redhat.com>
Subject: Re: [RFC PATCH 1/2] tracing/osnoise: Sample IPI counts
From: Crystal Wood <crwood@redhat.com>
To: Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tomas Glozar <tglozar@redhat.com>, Costa Shulyupin	
 <costa.shul@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>
Date: Wed, 10 Jun 2026 14:51:02 -0500
In-Reply-To: <20260610130457.1304245-2-vschneid@redhat.com>
References: <20260610130457.1304245-1-vschneid@redhat.com>
	 <20260610130457.1304245-2-vschneid@redhat.com>
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: A8gE0cqXqrz283My9erqZbws2MvdD_i0n1y5fDuSt_A_1781121065
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-06-10 at 15:04 +0200, Valentin Schneider wrote:
> Osnoise already implictly accounts IPIs via its IRQ tracking,

Does it?  It seems that IPIs bypass the kernel/irq subsystem on some
arches (including x86, but not ARM).

It would be nice to solve this properly by adding generic ipi
entry/exit tracing (similar to what ARM already has).

> however it
> can be interesting to distiguish between the two: undesired IPIs usually
> imply a software configuration issue (e.g. wrong/incomplete CPU isolation=
)
> whereas undesired (non-IPI) IRQs usually imply a hardware configuration
> issue.
>=20
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
> Note that this is modifying the osnoise:osnoise_entry Ftrace entry; I kno=
w
> trace events are sort of supposed to be stable, but I'm not sure about
> ftrace entries.

I think old rtla will be OK with this since it looks up fields by name
rather than assuming a fixed layout.

> Alternatively I can have this be purely supported in userspace osnoise by
> hooking into the IPI events and counting IPIs separately from the osnoise
> events.

One benefit I could see of doing this in kernel osnoise would be if you
could atomically correlate the count with the particular noise
interval, but this patch doesn't do that.

> +static void ipi_emission(struct osnoise_variables *osn_var, unsigned int=
 dst_cpu)
> +{
> +=09if (!osn_var->sampling)
> +=09=09return;
> +
> +=09osn_var->ipi.count++;
> +}
> +
> +static void trace_ipi_send_cpu_callback(void *data, unsigned int cpu,
> +=09=09=09=09=09unsigned long callsite, void *callback)
> +{
> +=09struct osnoise_variables *osn_var;
> +
> +=09osn_var =3D per_cpu_ptr(&per_cpu_osnoise_var, cpu);
> +=09ipi_emission(osn_var, cpu);
> +}
> +
> +static void trace_ipi_send_cpumask_callback(void *data, const struct cpu=
mask *cpumask,
> +=09=09=09=09=09    unsigned long callsite, void *callback)
> +{
> +=09struct osnoise_variables *osn_var;
> +=09int cpu;
> +
> +=09for_each_cpu_and(cpu, cpumask, &osnoise_cpumask) {
> +=09=09osn_var =3D per_cpu_ptr(&per_cpu_osnoise_var, cpu);
> +=09=09ipi_emission(osn_var, cpu);
> +=09}
> +}

Isn't this racy to do from a different CPU?  Both in terms of the
counter, and the timing of the increment relative to when the IPI is
actually received.  Not necessarily a huge deal if you only care about
zero versus bignum, but still.  At least worth a comment, if we go with
this approach.

-Crystal

