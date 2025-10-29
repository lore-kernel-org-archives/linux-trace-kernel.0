Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4612E7645
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761732599; cv=none; b=h+qz1I8/YOKyRRGwwyuo6IHYf4pqWzmZyn+K1n2PyW4jdAsqqRA81FfNOSbCz69nIP69hrP8VCnOdejH2xXLv+zxAplamCZsKBF2ujoPLZKKIQhc5Z/pcDuTJbcazxXYq0P2jLrZzItErRJjwnINYMZGj1clCWP1oUDvlrcLwLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761732599; c=relaxed/simple;
	bh=fDud/gli0gs0bKQHR8KRS+b9VJUz0ACksoD21DnIixM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u6xKUKVHC/rLc3+611OlnQtm7V7xREWjQvKITIqe4i/PHI0b+g6qCKSs0NE8XScPmZh6W5S+L93+uGaxxhpQmRqpueonQdCxQwpSAXfcpxH+FuAijnH2IeAUBdIEWN147S3xYhY5opFXQczmQ/K8eP9b+QdRSpwb26qtKLCmDxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TWszmJri; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWszmJri"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761732596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8VL8F1BbEiYOKI5l4LcZTZfjaaIUn5rioPCVGdYu3M=;
	b=TWszmJriLh3sb/XOvxs0g1/N8dMFiRWbwwGww+WGTJ9MstDMNd3VopUIYJj2LP4PkVkE5m
	+0Ib7Vl3wpueWFiQqZiU5VOGxYquOS33ywvwy7K5NlHmxLoOFN1xOx6crlaIk2gqaGLWeY
	62HVL2zpQyLwAMPalb3S7K2jm3FvilU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-21eAvcttMtiF69PxWBwsFQ-1; Wed, 29 Oct 2025 06:09:55 -0400
X-MC-Unique: 21eAvcttMtiF69PxWBwsFQ-1
X-Mimecast-MFC-AGG-ID: 21eAvcttMtiF69PxWBwsFQ_1761732594
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-429af6b48a8so577592f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761732594; x=1762337394;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7va99Zg9nu4+XxtsT3y+i0Qg89ua4ByIHfysL3F+F4=;
        b=EjPqePTATdIJaZK+CNkEyddUDQLlATBPnkQf/3O7bPkmwF1dEdk5B5fnu6JIOHE9X9
         CJPf7II+cqkdw7mTLFSliYTWKle/NCLHIcnoZnfBa3/wXEIYPdUXU3t4x1TJ+s6aP7an
         VZxxefLT4mEyT9um5RJZMlT61ga3EzMzqX18yjF10Sry25fKcRakdM7uaQuWlLpTXif/
         M9ea09A/aStghijT7hGcvEhALeT3ovSbsCtBJLM1p1hSXmCBgdY0mvr9XNmA7rTFD9cI
         n4M0NrzcYU9iCApV4SFGw2+hxr7NJWV90cdu9PjKL/ab99WsRTXvssncp8RA5Rt9Mlr9
         1Jng==
X-Forwarded-Encrypted: i=1; AJvYcCUe/uVLDPNNI7N57iApBgPGTd3OFektK/efXq8xWF3u8CVbX9JHcPmi96+syMEhyhdJZBnHGw5/uks+fZbbVyQoyqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhjiGePAg8h5jmDWbKl2yHsrAK9b0FMmQV2kLDOxtGSp84XdE+
	rd6e0afdTwVXeHmksprix0AwpGMZGzR0imhHU7kytp29wYfL9E/zksPkVnejdwz0VFYqlGyWWut
	UMNZr/FY1XYZo1VEbcTzTtrjpEzo/MX2/Fll3mvwKwOKFxmScT3fGnH6IDjeoS/6KmGb4aVpnNA
	==
X-Gm-Gg: ASbGncvUaTBWaUKKEG33X5XoeXqL/OEURLn5fdv3tU/iL4oBmpFG0YMWLs2pXE065rd
	R0J2sS89aFqc/66yHq7MQyaHElP7ANXxZDJCCJE6lYePfCwV1fyAbFjX6rjrXHvyVP+liNWjM+G
	mfHyNwbflxBUl+CnUIKzHL56st0paPWXvKv8Rhu2wzpAM51TTM6WrM8tLL8Sdbe3+f9PjKo/rlb
	Au5VrQ2KL3dKBmjEzWqlJZMaVcLOs7tScDZlnrqNgOMv6ti8ggE9CxtoFe3R1FabBIVEy0bEIJa
	cwSiaNaw+LcfPkvF/YUu3vKCzeMkf8fG/5uAhlrxy1PNSbyMEaklll+NA5Vl224ZYGWcMuGB569
	z6KTyr3VmZYEhNB65S3SPrC/lZEzhsRF4vHFCCLdZGWZmtw8vzkutp2CJOXH4
X-Received: by 2002:a05:6000:2089:b0:428:4354:aa43 with SMTP id ffacd0b85a97d-429aef83083mr1733923f8f.18.1761732594339;
        Wed, 29 Oct 2025 03:09:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMwZOd1Sm4LKIO70Dn8iCGAQm9z32hncQVtTx+dFITCY/jcrLahS/V2gOWr58H4oqqEmvh5w==
X-Received: by 2002:a05:6000:2089:b0:428:4354:aa43 with SMTP id ffacd0b85a97d-429aef83083mr1733872f8f.18.1761732593822;
        Wed, 29 Oct 2025 03:09:53 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952e3201sm25467518f8f.47.2025.10.29.03.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 03:09:52 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Nicolas
 Saenz Julienne <nsaenzju@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Arnd
 Bergmann <arnd@arndb.de>, "Paul E. McKenney" <paulmck@kernel.org>, Jason
 Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard
 Biesheuvel <ardb@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 "David S. Miller" <davem@davemloft.net>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>, Andrew
 Morton <akpm@linux-foundation.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Han Shen <shenhan@google.com>, Rik van Riel
 <riel@surriel.com>, Jann Horn <jannh@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [PATCH v6 23/29] context-tracking: Introduce work deferral
 infrastructure
In-Reply-To: <aQDMfu0tzecFzoGr@localhost.localdomain>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-24-vschneid@redhat.com>
 <aQDMfu0tzecFzoGr@localhost.localdomain>
Date: Wed, 29 Oct 2025 11:09:50 +0100
Message-ID: <xhsmh5xbyqas1.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fLc0lNX_5-_rcshRkW-vorQ-NN8DbR3ObB-JV3W3gJg_1761732594
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28/10/25 15:00, Frederic Weisbecker wrote:
> Le Fri, Oct 10, 2025 at 05:38:33PM +0200, Valentin Schneider a =C3=A9crit=
 :
>> +=09old =3D atomic_read(&ct->state);
>> +
>> +=09/*
>> +=09 * The work bit must only be set if the target CPU is not executing
>> +=09 * in kernelspace.
>> +=09 * CT_RCU_WATCHING is used as a proxy for that - if the bit is set, =
we
>> +=09 * know for sure the CPU is executing in the kernel whether that be =
in
>> +=09 * NMI, IRQ or process context.
>> +=09 * Set CT_RCU_WATCHING here and let the cmpxchg do the check for us;
>> +=09 * the state could change between the atomic_read() and the cmpxchg(=
).
>> +=09 */
>> +=09old |=3D CT_RCU_WATCHING;
>
> Most of the time, the task should be either idle or in userspace. I'm sti=
ll not
> sure why you start with a bet that the CPU is in the kernel with RCU watc=
hing.
>

Right I think I got that the wrong way around when I switched to using
CT_RCU_WATCHING vs CT_STATE_KERNEL. That wants to be

  old &=3D ~CT_RCU_WATCHING;

i.e. bet the CPU is NOHZ-idle, if it's not the cmpxchg fails and we don't
store the work bit.

>> +=09/*
>> +=09 * Try setting the work until either
>> +=09 * - the target CPU has entered kernelspace
>> +=09 * - the work has been set
>> +=09 */
>> +=09do {
>> +=09=09ret =3D atomic_try_cmpxchg(&ct->state, &old, old | (work << CT_WO=
RK_START));
>> +=09} while (!ret && !(old & CT_RCU_WATCHING));
>
> So this applies blindly to idle as well, right? It should work but note t=
hat
> idle entry code before RCU watches is also fragile.
>

Yeah I remember losing some hair trying to grok the idle entry situation;
we could keep this purely NOHZ_FULL and have the deferral condition be:

  (ct->state & CT_STATE_USER) && !(ct->state & CT_RCU_WATCHING)

