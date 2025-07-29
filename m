Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751A21B424D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753797988; cv=none; b=P1tO5f2khzJZlOQiWb+lxZY14ueqpB/FUPcgZAumFfcMLuYaj0aipG1JD2X6lXHox2FvrIZObFi8nIuUu//rp4N0jUDpmT3BfBT5QmIYVapAs261sBjVevKpufv6ixZ4GtLUEzyYMZJk/NA+nu3oWMIKw7ZKFy4If+f/4avnYFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753797988; c=relaxed/simple;
	bh=j7G/xoDmIxavPytwYZD9c7zZP2sUlikxAcn6/9NNafs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=maNk1ZzzBtBOPu1MyaGqoL/PyqqCwSV1d5EBGx/VCahI/V4k2PaIyz4N7i6gg4Fzptf7LqBr8sLJ7Cw2uAInRkX2s2Zu6tV/in2x5fJt/ZTfnkPFlfLU7WmdO837x+2YW76FuSfGNIjY0xluLgwZvkJ74/JLSJDPaVtxcgcBTtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ax5+EnMK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ax5+EnMK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753797985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2oeKZsmFlPjcLuqzIJmSdyhukaz9SNPsEctCnZaG7Z0=;
	b=ax5+EnMKfDTQmDpHnKErSxf0CWprNwGdIVnglVFY60fSyvh5FArasiyRD7QQVKOktkIwJi
	Ngf1Kv3TwbgJ9IBxKiAqvBsVYAwJlyHg+3PY/EXznNL6HiHuMtx6kyungJrgasBlEWRa9y
	xjx1m6E63ANmK2Uc+OdQ7LCFGBlaq3s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294--X_MvuL1M8WnwpRu4Ea98A-1; Tue, 29 Jul 2025 10:06:22 -0400
X-MC-Unique: -X_MvuL1M8WnwpRu4Ea98A-1
X-Mimecast-MFC-AGG-ID: -X_MvuL1M8WnwpRu4Ea98A_1753797981
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4588cfda8b6so7909545e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753797981; x=1754402781;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QIgYf2vsWqDkDVYt9P3cGO1QNBX3mGMfTpUEie2O+uk=;
        b=pVw3H43Eciq4XOP6ME9lj3rIyuDNTyoV3ghMiPwe0kV5MQspTTTrI1WneErfVHtX3f
         8ihHR605l44WbyUrRq0lDrD0asqqNVItqkup016niErr3b9ft1K6UW0/lAOpqkCeqVXT
         5eqWC0llBhrRcRh2RkqoRgbJt8tFP/ctfQRUvFlC0Mpyw6FBubHuhAVmU4E6BV+p9tfr
         Y0VzuxayWTg1cjCXyEfhPzcgo2BjyHwumKP4yu2BBP4rhQ4+A89niwYniseSdqi4+lkh
         QaJQLml8vwDveDjshZCZ8fwTVw3Kny50ovIOeABtgYkNZhN1s3JibaArbc8gNupnHn3L
         rjBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0ag0W1jAo/UtPjRgHAiVrlHEjqT4imH700/Llr0VzhdrzWKdC1nIt5A1ZDP3FQqm8/DFxgVKP8OxjCqSmhr7l1LQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6oBnl0Sbh5Frv0jr+CCEbc4NVrmIR7tlBSLrxAzTZ+91hk418
	2lrFUGmuqH2zezt8dOiQ0C+hs5DXkXhBr3Ejl0+vawY3YMpEA4SjS7lL9l45WfkjFAKywwyTYBD
	BTU29Km6ixpiyW8pZEj99zEraG95Nhpoqy7MfuWMoqhMfXLJzQv7hkrqy/jvrm8T68c+FGXKBjA
	==
X-Gm-Gg: ASbGnctdJaWvTGm5WEMF4bTiNmU0AXi+GyM9IXY0XERl0vpl1H+qJfvnZ2LgouXMxRR
	IokftgcMTLFbVkQAHcTI5Og3esgiV8UIjrE2Bp5RyRhXotd1Os+yXVeawFTMeCkf9SXFDP1kQ75
	FDTs/U8hqYoln6Uz9CTQ+MiM/UJXFXlyqXB9YyUXn9zB72oUqKII7L0EpttXjj8nYS+DGqI6huL
	39A8rrAjBVMFzGEe/FJ3PgO14WzJrDBnnkoFYtCUAxtu+2RriFdedNr65ceSwpqHGCNEkzf/yQZ
	lW7Qdvb0atQ3AAH93bCU2pGdkxBHqVAMHPoTUuyEsUyvQO6/1UfZm3HjycTNhZdEnmDS
X-Received: by 2002:a05:600c:6487:b0:456:2a9:f815 with SMTP id 5b1f17b1804b1-4587d857d16mr109316955e9.4.1753797980671;
        Tue, 29 Jul 2025 07:06:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxjXdEX/Zvad6HpbTya9ftqyz9bUQ8OagmI57aY0kUZL/2O6fcgIidQtrxq/dI7VwXkCwFhQ==
X-Received: by 2002:a05:600c:6487:b0:456:2a9:f815 with SMTP id 5b1f17b1804b1-4587d857d16mr109316195e9.4.1753797980068;
        Tue, 29 Jul 2025 07:06:20 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.134.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588e5df43fsm27300635e9.28.2025.07.29.07.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 07:06:19 -0700 (PDT)
Message-ID: <5803d2623278c7516406534b035a641abfdecee6.camel@redhat.com>
Subject: Re: [PATCH v5 7/9] rv: Replace tss and sncid monitors with more
 complete sts
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Ingo Molnar
	 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tomas Glozar
	 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark Williams
	 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Tue, 29 Jul 2025 16:06:17 +0200
In-Reply-To: <20250729093717.3AqIu_f0@linutronix.de>
References: <20250728135022.255578-1-gmonaco@redhat.com>
	 <20250728135022.255578-8-gmonaco@redhat.com>
	 <20250728155332.sbkepHj7@linutronix.de>
	 <76d7e572aae2ccd1699a461aded7a6146f6d8215.camel@redhat.com>
	 <20250729092510._Hq3RWF_@linutronix.de>
	 <20250729093717.3AqIu_f0@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r1u3dtT-e1ip-xeE3yI22kIHiDtwD24_npnBFk-iLK4_1753797981
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-07-29 at 11:37 +0200, Nam Cao wrote:
> On Tue, Jul 29, 2025 at 11:25:12AM +0200, Nam Cao wrote:
> > Kernel:
> > =C2=A0 - base: ftrace/for-next

I assume you mean rv/for-next ? The one that includes all changes as of
yesterday.

> > =C2=A0 - config: defconfig + mod2noconfig + PREEMPT_RT + monitors
> >=20
> > Hardware:
> > =09qemu-system-riscv64 -machine virt \
> > =09-kernel ../linux/arch/riscv/boot/Image \
> > =09-append "console=3DttyS0 root=3D/dev/vda rw" \
> > =09-nographic \
> > =09-drive if=3Dvirtio,format=3Draw,file=3Driscv64.img \
> > =09-smp 4 -m 4G
> >=20
> > =09riscv64.img is a Debian trixie image from debootstrap
> >=20
> > Test:
> > =09echo 0 > /proc/sys/debug/exception-trace
> > =09./testall # see attached
>=20
> I should note that this takes a few tries before something shows up.
>=20

Thanks for all the details, but I still can't reproduce nor understand
what can be triggering the issue.

I tried enabling sts and setting panic as the reactor (to avoid missing
it with all the rubbish that gets printed on the dmesg) and run
testall. Still cannot see the error.

What might help would be to see the trace with irq_enable and
irq_disable around the error, something like (not tested):

  trace-cmd stream -e irq_enable -e irq_disable -e error_sts -e
irq_handler_entry -- sh testall | grep -B 10 error

The problem here is not when the error occurs, but a couple of events
earlier (where I possibly miss something that looks like an interrupt).

Thanks,
Gabriele

> Below is the backtrace, in case it helps:
>=20
> illegal=C2=A0=C2=A0=C2=A0 3246 [000]=C2=A0 1020.132675: rv:error_sts: eve=
nt sched_switch
> not expected in the state enable_to_exit
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff8013231c __traceiter_e=
rror_sts+0x28
> ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff8013231c __traceiter_e=
rror_sts+0x28
> ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff80138aa4 da_event_sts+=
0x198 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff80138cf0 handle_sched_=
switch+0x46 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff80aaf222 __schedule+0x=
4ba ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff80aafb80 preempt_sched=
ule_irq+0x32
> ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff80aac714 irqentry_exit=
+0x76 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff80aac1dc do_irq+0x38 (=
[kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff80ab7da6 __lock_text_e=
nd+0x12e ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff80a93e50 mas_find+0x0 =
([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff8021ea60 vms_clear_pte=
s+0xe8 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff8021f81a vms_complete_=
munmap_vmas+0x58
> ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff80220706 do_vmi_align_=
munmap+0x15c
> ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff802207d0 do_vmi_munmap=
+0xa6 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff80221f3c __vm_munmap+0=
xa2 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff8020be7c vm_munmap+0xe=
 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff802bbdbe elf_load+0x14=
c ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff802bc1f4 load_elf_bina=
ry+0x36e ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff80264426 bprm_execve+0=
x254 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff8026570c do_execveat_c=
ommon.isra.0+0x11e
> ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff802664de __riscv_sys_e=
xecve+0x32 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff80aabf84 do_trap_ecall=
_u+0x1bc ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ffffffff80ab7dc8 __lock_text_e=
nd+0x150 ([kernel.kallsyms])

