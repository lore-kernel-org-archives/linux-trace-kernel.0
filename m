Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEB6374192
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jun 2026 20:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210959; cv=none; b=Rnt61YuPcITFXgBW2n+7SooRSeCa6AsArmCh8wV3pTvuEVGDCgwQBJ2EcACpnrKM/bNGAWSQE3BjYSIGR5pfWlFMUDu9TMSxi4/oY31Evz0xucaPQ0OF0SaXEJLeaukYBLxryBsirHw8G65ozBSZjW3Ni7N0X9vyogTrfM8J8Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210959; c=relaxed/simple;
	bh=5hOHi9t8eWvhak32t4WLHOEeSPNgnnXI2tqmdR/ET2I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byDQrjNSIbay8z/bxor24D1/SYitFb2dv77g4b/JzK69rvz3641oWEpJDMbG0XZQZ1TvOUicFGfcMe2OAmPstMNQSBZMwIufSSeppZfHIj/j3QgC/QE6lvA58eTWSw8hY65glHXw9NfNdlwUk+CYTQIaZxmj2ZTYuvBmEElg7WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JbjeYhqc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbjeYhqc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781210957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wgktEKfzuJsITNJ+8XhsgZmhYbupv7GRDCn0xvz14pw=;
	b=JbjeYhqcT2JlEwoUUi+KAUhkJNxBaSMkBJ6mLiVghg6eK2XZsXplWmwiiUxkCmzGl+1aYe
	uwxhmpCOABBtT4DQNQLMnlL3ASlH1PwPA/HRnqD/5OdOwk/sUsyulJ0RkVozJWNp4XzRZS
	jwtGIP9tUtLkI9gA5+60l0jG+5HanpI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-C7Vmqp9PPwKHIJeGg5VDyQ-1; Thu, 11 Jun 2026 16:49:16 -0400
X-MC-Unique: C7Vmqp9PPwKHIJeGg5VDyQ-1
X-Mimecast-MFC-AGG-ID: C7Vmqp9PPwKHIJeGg5VDyQ_1781210956
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9159c4b210aso43567585a.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jun 2026 13:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781210956; x=1781815756;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wgktEKfzuJsITNJ+8XhsgZmhYbupv7GRDCn0xvz14pw=;
        b=QvuhmxiorQjTmVUCp5ykFjWImcqY1G4qeMpjlmOv5d+AHssGd7JEe5r/ww+fD6xEzO
         C4JrY84+zn0AA0E/9BC5EXO9cPJoA2ubphjSoj1SoXlJOBK+m0BWOTMiv+rDvluRbags
         jlNIBLFHs9mj7G295Zvcwqw8ECNeu1S7XAaCs27FXilHJyyc0NgLeKKtu/BJ7PkD82p9
         mBBaGJQ1hm6iw1TaN7IBYImpLezkZs8aj3t2cWJB7x/bmim9wB0z8PpztR/MOWsMpAqE
         89tFv1+DodZ29f3+H/rm8IkItjWWMLspZCd8v2YsvB7iVB5qDWAuwz47ZXccE6i87/Bo
         fbPA==
X-Forwarded-Encrypted: i=1; AFNElJ92+qJnQWygfjqu3VxSCDljCcvcINE5BViarpFS3gmQV4MWYvYNgVuEZYWaSMYznn+rt0+cdgOMillSeQ/M86UL7ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaoiUTjOKXvBiMovihWGXNrxBAc17IsVK5cm6M6tn9/3Y1Vo9Z
	1/sk/dkOUw/EDkJRfgat3nfbAmyQ8rYSIrYFa60hj/Q5VsmXRXOFDrfwAnAGsdiJyxV1MQgWr5S
	iFDOTSUWMkFAF7AYABJv4K/n5WyhlEMtKIRAGumxjqak5QfxSqOuww7qdjvdhx0iTiF2DiZHnFg
	==
X-Gm-Gg: Acq92OH8BdKOniPJI18OTHXF+h8RF0wnXetEJ4dNM5DgEfZpyqM02t/1/u9SX8Ca/gR
	XTLZbej2vrolBQA6amNW6qWyZPriyWv8BtLUDX9i6W8gZXlxKBH2Cb0RahUjqkamUwQdzqO+C1+
	cYKTbeZUhk1qcKjTQ3a7ImUFFsmPy1RBKj8r9V0l0aK5tV/VDR5+ykD33XzC4ghmBJSsVMqdosW
	a2s4gIdgvZ0sReeSZOdfGS6l2DKV8tLidG14RHKoMjoB5MVnJvf7vqCgHUasjMxvWsN5a+0jfyf
	6M8GewD1mZPildl0Doa5mftbWh2lUoBzfemuwSuNx/3P/YAygCwcKoiUzvyysd8AbZHsZ6hvQLC
	5fL6JCJ6wVTD0X9RAEuMiwNZ9m9hcnTTLVdJ5F7+ZFxgidknhKB1GYw==
X-Received: by 2002:a05:620a:2954:b0:915:351b:3ad5 with SMTP id af79cd13be357-9161a3cbedbmr33292385a.29.1781210955595;
        Thu, 11 Jun 2026 13:49:15 -0700 (PDT)
X-Received: by 2002:a05:620a:2954:b0:915:351b:3ad5 with SMTP id af79cd13be357-9161a3cbedbmr33287985a.29.1781210955151;
        Thu, 11 Jun 2026 13:49:15 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f210b7sm21254885a.18.2026.06.11.13.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:49:14 -0700 (PDT)
Message-ID: <dcab30ebd537f34cbab2446be8ff9b8cca61e0f3.camel@redhat.com>
Subject: Re: [RFC PATCH 1/2] tracing/osnoise: Sample IPI counts
From: Crystal Wood <crwood@redhat.com>
To: Valentin Schneider <vschneid@redhat.com>, Tomas Glozar
 <tglozar@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers	 <mathieu.desnoyers@efficios.com>, Costa Shulyupin
 <costa.shul@redhat.com>,  Ivan Pravdin <ipravdin.official@gmail.com>
Date: Thu, 11 Jun 2026 15:49:13 -0500
In-Reply-To: <xhsmh33yt2wtc.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
References: <20260610130457.1304245-1-vschneid@redhat.com>
	 <20260610130457.1304245-2-vschneid@redhat.com>
	 <f40903f8198f8e2f42f1efdf950f995f24cf6e93.camel@redhat.com>
	 <CAP4=nvT6GEdwZAm-2h+Z-mj9DOmJ-swyApujFun6m1Qaxxr7hQ@mail.gmail.com>
	 <xhsmh33yt2wtc.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4JMnkCgquB9Nr46WDBN4XnhvakZ0otAECxhXSVXbCAY_1781210956
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-06-11 at 12:30 +0200, Valentin Schneider wrote:
> On 11/06/26 10:59, Tomas Glozar wrote:
> > [just replying to comments, will do a full review later]
> >=20
> > st 10. 6. 2026 v 21:51 odes=C3=ADlatel Crystal Wood <crwood@redhat.com>=
 napsal:
> > >=20
> > > On Wed, 2026-06-10 at 15:04 +0200, Valentin Schneider wrote:
> > > > Osnoise already implictly accounts IPIs via its IRQ tracking,
> > >=20
> > > Does it?  It seems that IPIs bypass the kernel/irq subsystem on some
> > > arches (including x86, but not ARM).
> > >=20
> > > It would be nice to solve this properly by adding generic ipi
> > > entry/exit tracing (similar to what ARM already has).
> > >=20
> >=20
> > Isn't that precisely what the ipi tracepoints used by this
> > implementation (ipi:ipi_send_cpu) are for?
> >=20
>=20
> Well, these catch the emission of the IPI, which is great for investigati=
on
> - slap a stacktrace trigger and you (most of the time) get the source of
> your interference.
>=20
> However Crystal's point is that on x86 (and I assume other archs) receivi=
ng
> & handling these IPIs is "special" and doesn't go through the generic irq
> subsystem and thus has to be tracked separately, which is why osnoise has
> this fairly lengthy osnoise_arch_register() thing.

Oh, I missed the arch hook.  I feel better now :-)

(I'd feel better if it didn't rely on osnoise-specific arch code being
updated to match if some new interrupt path pops up, but oh well.)


> >=20
> > > > Alternatively I can have this be purely supported in userspace osno=
ise by
> > > > hooking into the IPI events and counting IPIs separately from the o=
snoise
> > > > events.
> > >=20
> > > One benefit I could see of doing this in kernel osnoise would be if y=
ou
> > > could atomically correlate the count with the particular noise
> > > interval, but this patch doesn't do that.
> > >=20
> >=20
> > The count is already reported by cycle on the kernel side in the
> > patchset, right? It's only missing in the current RTLA (userspace)
> > part, as there is no statistic using the information. But it can still
> > be collected through custom histogram triggers.

Not sure I follow... this patchset reports a count of IPIs, not cycle
info, but the count is based on when the IPIs were sent, not received.=20
The IPI send events capture cycle info, but that's not what this
patchset adds.

I'm not sure that it really matters though.  I had been thinking of this
more like the interference count, which is atomic with respect to a
single noise (and thus the sender of the noise would be outside that
window).  But this count is reported over the entire osnoise sample
period, so a little slop is probably OK.

-Crystal

>=20

