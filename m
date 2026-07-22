Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8085B3E2AD3
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Jul 2026 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784712980; cv=none; b=U14xcK9+COBSmDQYTnu8kD7JKkAoCxpWZT2YeC9DQRF5BEEI6cjo/xvsg9PnVJa7IB9HXVCXYE18uOjDeT/vHBZ7B6LeWndTrtkjRTRTV9OgfNbBfHnVd9zR7YPZoF5byBxuQEEAuZXGfjpq9+H+8WFVCsYuU5xHCo8byCvfqhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784712980; c=relaxed/simple;
	bh=4JXHTbQj9vbjgLrakjSFGraU6K3+W2n+uavTJuYhxoY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jMWrj9/krcxneovhtGbCnVVCYEbZStxNH64o9RVjqApzsU+k+ii4HdK3x9r6kU+kNgz65cUhpsn/9bGKhKEF68aQLKSuqpNSowTuyuyk71UYJU+QgGZgxh53XXLx3ipEak1yXnlDJtHEaGjamg9Vm2B5V62po3LIOQLJmnoslTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FXr22I8I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FXr22I8I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784712975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4JXHTbQj9vbjgLrakjSFGraU6K3+W2n+uavTJuYhxoY=;
	b=FXr22I8IERrMoNCz2iPqDosIrN0cj+R4deFxhhEZFAHRlskwobY+LrxuA36P/MQm3g1qUg
	ufOkmNrAotE9i3/iY/k5uqI6fyYpn8EzNQhiOz001vRgM49NmCJnx+Eqt2aTdxy3bRqdJK
	nHoW/pn9LKZvksblONAZ07IYn0w0bkE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-tXBPU2pRNEmXMUW_nC2z4w-1; Wed, 22 Jul 2026 05:36:14 -0400
X-MC-Unique: tXBPU2pRNEmXMUW_nC2z4w-1
X-Mimecast-MFC-AGG-ID: tXBPU2pRNEmXMUW_nC2z4w_1784712973
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493a7fa8481so34103155e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Jul 2026 02:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784712973; x=1785317773;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=887G4FpM8v6xJwAY2TuX6vrvJZdHf0fmrax/gsZiZnE=;
        b=A+WyOKZ4b6T+yJCoz2m2KjOrosRuke/uhy+5tdBHc/I3OtXTdJCR+P8qqhtq3ORr5i
         W6D/ntjHAozh6IWr32drx1kPvBY1O5y4we00OFaueJXpkFcAiaNhM1gsNRwyJW5se0Wa
         /xP0JymUbfBDVEaP1Pv6TjYptAXb+QSdMO/roisGuXSAi/QFqc+/qlzEN8KYeGBKK8mm
         gGaKe5tFTq8q84/FOHmOpctQj/tdFNWT0+BRLg9dP6ds/rWtTpMvQ7hrDP180LR97Ya8
         Ev1duV9ybXQMGtWx9jHI06dimQFS1Wkq/r6wn4GAQHJ/Yk3j58bmAs4jo+NHA6amMUZ6
         NEBg==
X-Forwarded-Encrypted: i=1; AHgh+RoOxkt33LPGetnb7D1oJThcYrtr16DagFQi4pfgXoutoFfY7JKgAXgAq8BbHAL0FQ9z5TfGk+yxREZgpCIfXsR2MD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxXl1Zwq8Syx7/s4xqBoKRPSmwIuCJ9xJriDVIotI0vdwy2dXw
	Vnef2YOOc8a5nzgjDGQs9mk0VNhk2f2TnV2EB4KggVZkYO54dIWA2f9VnwpWhNrNa9KLTtjHVM5
	Copnq9snZZrZA+Yex/WH9OOUPTGHLymWwQOyugGgbmIrplHfXyzGY82Q0kAncux4c+iSgH0WkpQ
	==
X-Gm-Gg: AR+sD12CeKBiwJOX6CKos0Ynb2whVWaYwjPSMQ8/81q6i3YZkOWWCcRHw8CGPvB4Xwc
	ZifHdLyxX7dYTqXq+a0/A4reE1Zn+bx2hQlqm2eJk+q4pLhR5x9XrS6/tPaCzSJ4eMsb/zmQ1Id
	kDigC/oahgFOuFZD9sxyBZ0njEsF/hjYqsmg6/LrjOdvvSG3j0peczBT9dxUCOcZG9VBRckxpZP
	PK9Vkb3tXSsBE+ni+hWw56DACqnEFVUl9M0zpTXdx62RnL5OuEAherTx06BrsJT2SFUwlAAFpaC
	Gtty6tnvmsU6CpbGEYNiiArnzNCL0f9eg9UuGJ8Zs4sNSjvD2Z+HSVHdKJgRVI4WBnAqmsrVAA9
	i74iyH/eUNu20QyT/GR3Ci7JRfyoo
X-Received: by 2002:a05:6000:26c6:b0:47a:b6a0:b024 with SMTP id ffacd0b85a97d-47f840a020dmr4085315f8f.4.1784712973081;
        Wed, 22 Jul 2026 02:36:13 -0700 (PDT)
X-Received: by 2002:a05:6000:26c6:b0:47a:b6a0:b024 with SMTP id ffacd0b85a97d-47f840a020dmr4085256f8f.4.1784712972611;
        Wed, 22 Jul 2026 02:36:12 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.132.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c67339sm4537989f8f.31.2026.07.22.02.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 02:36:12 -0700 (PDT)
Message-ID: <1fe191ba66ae668b4635e2dd18b3e6c3b3c0090d.camel@redhat.com>
Subject: Re: [PATCH v2 4/4] rv/rtapp: Add wakeup monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Chao Liu <chao.liu@processmission.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, 	linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 22 Jul 2026 11:36:10 +0200
In-Reply-To: <87y0f3wjuk.fsf@yellow.woof>
References: <cover.1781852967.git.namcao@linutronix.de>
	 <ba5658fa13e49ada466b84a2c211f233037180b5.1781852967.git.namcao@linutronix.de>
	 <amBHR4JTr2InJDk8@ChaodeMacBook-Pro.local> <87y0f3wjuk.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hNo89Mvn7kcD3m2WaBf8gEvYokWuv4kdBvSas_MfIME_1784712973
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-22 at 09:42 +0200, Nam Cao wrote:
> Chao Liu <chao.liu@processmission.com> writes:
> > > +static void handle_sched_waking(void *data, struct task_struct *task=
)
> > > +{
> > > +=09if (in_task()) {
> > > +=09=09if (current->prio > task->prio)
> > > +=09=09=09ltl_atom_pulse(task, LTL_WOKEN_BY_LOWER_PRIO,
> > > true);
> >=20
> > The implementation also reports wakeups from softirq context through
> > WOKEN_BY_SOFTIRQ:
> >=20
> > > +=09} else if (in_serving_softirq()) {
> > > +=09=09ltl_atom_pulse(task, LTL_WOKEN_BY_SOFTIRQ, true);
> > > +=09}
> >=20
> > Should this description mention softirq wakeups as well?
>=20
> Technically, on RT kernel, softirq is a SCHED_OTHER task. On !RT kernel,
> softirq can also be executed as a SCHED_OTHER task, which is the cause
> for concern.
>=20
> But explicitly mentioning softirq does not hurt, I wouldn't oppose that.

Sounds good to me. So as far as I understand, this change is going to go th=
rough
a separate patch right?
I'm considering this series final.

Thanks,
Gabriele

