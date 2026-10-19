Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04C34CA298
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 10:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792404130; cv=none; b=ZaJY4+Zf0n9RRp3wxR/cWh8/wH8cwGwjH4mSw5krDnTPmHaQzhNfN7ODt1ejogy5/aUsIjJoE79uPdHCk4EQnESp5Al6RwgtoH93VvxbV7UsS7BaGjDXhXuMLfAa5vjNjLAnONemkAj5kHQ3iQQtfixckmL01ePGQE/6rviBJ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792404130; c=relaxed/simple;
	bh=vpWpmb3YDa75S+dGCCi7peYWMhttJoCHOLpxALx7pic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GxKdiDWg0RCU/mXvayYfR0zdcSoCUO2bMMWZuPqz3xeTJgAiqkjanJfRsrncSKc4A3zz681g2GBODM20Q+NLfbrsRz8ruVdYyhZGcodt0XFUEPjDnAL56ymg5F3jjfmkYeqAogyjUxe/KCVBADBsKXhcTAWZlNMIthd1BvhrPf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PE8h4Syn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PE8h4Syn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792404128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vpWpmb3YDa75S+dGCCi7peYWMhttJoCHOLpxALx7pic=;
	b=PE8h4Syn7fcVff4360KKeGmn9N3z463/JATIHJjViNxj6YmKhKje8QXX/zwu5p72FWCwPl
	19XNdLYoIZj+BhJS4xNJTu1k+0wSqVs3pdOu+q94VbjoJO7S66MiEp3irwd97DZo7Ty/t6
	mJH7FeWbAepp6GiRn7AQnlZej/hhkJI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-ttlKM6V_N4ezjORaf--MtQ-1; Mon, 19 Oct 2026 10:02:06 +0000
X-MC-Unique: ttlKM6V_N4ezjORaf--MtQ-1
X-Mimecast-MFC-AGG-ID: ttlKM6V_N4ezjORaf--MtQ_1792404125
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c44903d6927so72290666b.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 03:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792404125; x=1793008925;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vpWpmb3YDa75S+dGCCi7peYWMhttJoCHOLpxALx7pic=;
        b=Gc7tE/DdxkGofzvFhWQnZKvyqKlR71RpGYbjvNgGD1yswBeZBA0WBaseBqzM6/h5EL
         PnHUOm7AlLUezxgnHlo4adKmRkq4S+alS7v13NSoIN5gyAn1hCzjPhNMxTd6HrwHooL1
         raKWf4hWWFQISuhmDOCXvt39qALYvEwAk4vPH6I5ytuOOwskqo0c6CEgtGK78iYP5IeK
         pzwIJnAUXvA1JB5Pd4Weyj0X5LwnK8CE3pmf/6lHaU/hnDt+rkfyC9xHPE1hkTuRg8kM
         N++i5eWZjs3PXihOpgTE/aZYPI+dkVmskPwVzCalTRED0e2/LNR/YcFQ8V9gi6eClyNO
         9C1g==
X-Forwarded-Encrypted: i=1; AKwUvBztknP4hNcsbf8A1KNbl2jCWof8rdvN55qTwm6rCs2cCK6SjEhxI0kyBl0JmRhrWf/RytddG3odhxrO9dL6hrVula8=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2AkNsw0LMeSb7ntC+AKheDIJ2BJg4Huur7QpS9gUZggcd1a55
	Imd19x5iGDIcpiaDkRBcajZuZcIQddasAp87U80+6akhsjdiuFXL5oJcOyO2a0hvMYwVVsR06sn
	Y0UZFCMe1wyD7YLxsbs5oiSxIxZPUCOgVUQ+j8AEFz94SaTrhyyT5HKXP4Dw2MhBl/KgvTHIEc1
	iUC2gzG6B/tSrWSCGt8onb8hdNczYLUxJ9L+zEyatJ95felJTi
X-Gm-Gg: AYBFou3Z8kc0axXrMm4MKdRu0MmytlG8J67Rc9NJxKCkXtgDoWCwk7DmNF8scPLXdVM
	FrCZC61pbpHrIR+98q+ujccu44TDeTKZh871KgACB5Y/QiUX9JO5VVYoQarJSGapq7j7y2SjGFm
	x3bgRzzIf8Qfvd/qH75lLC2LgffIeod1gxJeAB6zGXcJpxcVrZ441hWdtTlJXDgyxUKx1f0QJYJ
	6Q8kxBmbgLhNUg=
X-Received: by 2002:a17:907:a2cd:b0:c2e:7e0a:572f with SMTP id a640c23a62f3a-c419de3d0f6mr427563666b.21.1792404125328;
        Mon, 19 Oct 2026 03:02:05 -0700 (PDT)
X-Received: by 2002:a17:907:a2cd:b0:c2e:7e0a:572f with SMTP id
 a640c23a62f3a-c419de3d0f6mr427557966b.21.1792404124608; Mon, 19 Oct 2026
 03:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001152042.124445-1-gmonaco@redhat.com> <20261001152042.124445-11-gmonaco@redhat.com>
 <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com> <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
 <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com> <878q3xtptq.fsf@jogness.linutronix.de>
 <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com> <87bj8s8ih9.fsf@jogness.linutronix.de>
 <DM78SVMBI2XW.2XHVC67VON48A@gmail.com> <87v770uuyr.fsf@jogness.linutronix.de>
 <DM7I2PYHNKXE.3AYY3N1HATXLW@gmail.com> <87ik2zryzo.fsf@jogness.linutronix.de> <0055967d4571e7c8549dfa476fa6b15b93013701.camel@redhat.com>
In-Reply-To: <0055967d4571e7c8549dfa476fa6b15b93013701.camel@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 19 Oct 2026 12:01:52 +0200
X-Gm-Features: AclHuK-g9NcQuSX2oEVaSkoEXxNQmoV5Ee9U7uVHOzoGFLemx-m8yG7uigcHu_s
Message-ID: <CAP4=nvR2i092924zszA8Qh0UUYnwXfAsa+7KjPe-NpwC+bbLXw@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: John Ogness <john.ogness@linutronix.de>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
	Wen Yang <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>, 
	Viktor Malik <vmalik@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ju2IDyYZDN3Wj-IcEvM8uLN4oDzXDv3dCpbJKIKGiyM_1792404125
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 11:05=E2=80=AFAM Gabriele Monaco <gmonaco@redhat.co=
m> wrote:
>
> Alright, I'll focus on trace_printk for now. As I said, it's rather trivi=
al to
> add another reactor later.
>

One disadvantage of using bpf_trace_printk() for RV violation
reporting is that the event will be caught by every instance that
enables bpf_trace_printk() and does not explicitly filter rv out.

I can imagine an RV-specific trace event for that, however, it would
require a separate kfunc to generate it, and ideally also distinct
labeling of a BPF program eligible to call that kfunc. The "rv"
userspace tool could then iterate over these labels so the user knows
which violation events can be expected to occur on the system.

Tomas

