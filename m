Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A083A0E85
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 May 2026 06:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780034899; cv=none; b=bOQor5VZ76Y9xt1Hf4kYW9NbFkQIrFClf6HMUxgaKLelsaA5zMIlTewsQWzPdxyHi9NyqX8yikpZq8+a4zRsiJ+CDcCOsPvYyaZ0rBZ+zS/MHEz+MsG2D3tqvmehwl2fdXGiJc3K4ajNsIxV2QcoTvNXkQeOnf/XV1z8mWRTc1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780034899; c=relaxed/simple;
	bh=QE90Vm1v241VW5L7o0c7RK2smtkqVjG7hxXcnZPfIS0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0YKlbNREt1t8WAj2oXRBGRwb0eWCphUw3OmLDXzCMjfw3ZWxVp+QEAGfCePky9WrMP82I87Z7ZhoaLl15atvNJbi2RPc9rI5LNBjWXSqH2D75EGpU07yXRGKq/DRF+0ba972OyR/u3YGYJl7gLuwLHUOqa/1Yo4w+y3ybnGJfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PKbegBn6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PKbegBn6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780034896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QE90Vm1v241VW5L7o0c7RK2smtkqVjG7hxXcnZPfIS0=;
	b=PKbegBn6rBNU8VqsQSacFg7dUt9HpFsOYdnL1lXd/zDvkyHX6RdA3QBTZDTBavERkyyZ6b
	/8T5XBzjggyEIFL1r8ECFD/yLqQrwh5w41uTRQH64DaV1PSnP3dF/8A6XXeitr91IN+1mp
	NhQ5yUiFRgusshXD5rdggwRrZfpUC3w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-zDSt6BTkO62nHy5HQxrfAw-1; Fri, 29 May 2026 02:08:15 -0400
X-MC-Unique: zDSt6BTkO62nHy5HQxrfAw-1
X-Mimecast-MFC-AGG-ID: zDSt6BTkO62nHy5HQxrfAw_1780034894
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4909c0f0ba2so2474165e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 28 May 2026 23:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780034894; x=1780639694;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QE90Vm1v241VW5L7o0c7RK2smtkqVjG7hxXcnZPfIS0=;
        b=b++aALe0alsaMe5d+7/jvJglY+C9/q4Sb0reEU73msq5EQS9X1mo5iPJF4daQQfWKc
         4kebCBpUvuoNAkigGWd7XGnGKFR632M41vLP3oA5OcJgoC55BUyvWKpLqkGvmu35iAZf
         kLVvA0Z1SBvaj0jAbq+4Ynfx9DF0V7oeHP/LHFWz26tPFEQ5xTz2hUHa+spou1KlBCHe
         UdslIV5sF3D8s1eGXp47ePnNC9w38nCnYzsZbbix2zftBZWUAxl0kWZncmDgqtXzN4TS
         +9M6YJULkISGFxnx4as2dEgW5XNwDjSc8ql0NuzKOjhf3nDZCjU3lccq4Mzu38eQZkVc
         6+7A==
X-Forwarded-Encrypted: i=1; AFNElJ+6yaGHLC080wnfim+TFKdsl7OH2XxqqX+rZb0SnmRmspDUL6NjyIIxW0RAJ+JdzxFWaL0/4/K48n9RUKiRlpx0JyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkDZIsTJ2hTJQzmQqRgq2OFX0D+03nS1UTXz8E4tWbjwhzvL5m
	PMG9054ELqeTjaoee0RMH0+hak4HCh+GaL5JJhs2M0MEO30RhJECfJIbZlBXl/GkL36kweX9yKI
	WwP/xxLhec5vub9JqWWWjgNLqk43m5a0N96RahVx+vg5etxmyCYexZF3mE+jRq1/Y/ovLdwxweA
	==
X-Gm-Gg: Acq92OH8Jv4ySGtp6JDppwAaYMSyG+HWvXsretJ/seorY99peg/AH4SL9MJ3Xpql7L3
	PtpjZcfjRKuxXcK5irQxebx3MJE24BlxIUq/0LjVoE+Ruc2ROqjtLn9YaL8jnNQ2T/Im+K5BHXv
	2qAZJ4cewqoysSO2HZXtpZ/7oRUBnC6T+wuGR4AGeoZ5SXG0KUdQntuMga9nFbgCXOkDE3LVgyx
	f4pY4+HEqUtUjoa9mHmXn5f8gXiFWG2iznTKhOHPiydnnYUQCae7XIrySAd9chCHVXelZOg81ZE
	+l3yg68V0NKQkkiYV2qfcDb9EXbR+MuW1fhtKiFQkmNFPzl/xs146MipwVGFC50Nkj17QjQkNkM
	q6A3BIWhCBdc/1WpS5N2IxDwrw4/AoA6MiaUo
X-Received: by 2002:a05:600c:3104:b0:490:9d1b:f068 with SMTP id 5b1f17b1804b1-4909d1bf102mr17916445e9.29.1780034894088;
        Thu, 28 May 2026 23:08:14 -0700 (PDT)
X-Received: by 2002:a05:600c:3104:b0:490:9d1b:f068 with SMTP id 5b1f17b1804b1-4909d1bf102mr17915865e9.29.1780034893617;
        Thu, 28 May 2026 23:08:13 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d68980csm21833625e9.1.2026.05.28.23.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 23:08:13 -0700 (PDT)
Message-ID: <90bedf1a51a12b2f2fab4a34b3f2402c33fa4f34.camel@redhat.com>
Subject: Re: [PATCH v2 02/12] rv: Fix read_lock scope in per-task DA cleanup
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Wen Yang <wen.yang@linux.dev>, linux-kernel@vger.kernel.org, Steven
 Rostedt	 <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Date: Fri, 29 May 2026 08:08:12 +0200
In-Reply-To: <87ldd3orft.fsf@yellow.woof>
References: <20260527062313.39908-1-gmonaco@redhat.com>
	 <20260527062313.39908-3-gmonaco@redhat.com> <87ldd3orft.fsf@yellow.woof>
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YFOEGfjx9lE37k3cgLuaM4KfqVi2EchUCMdp3REozio_1780034894
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-05-28 at 10:43 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > The da_monitor_reset_all() function for per-task monitors takes
> > tasklist_lock while iterating over tasks, then keeps it also while
> > iterating over idle tasks (one per CPU). The latter is not
> > necessary
> > since the lock needs to guard only for_each_process_thread().
> >=20
> > Use a scoped_guard for more compact syntax and adjust the scope
> > only
> > where the lock is necessary.
> >=20
> > Fixes: 30984ccf31b7f ("rv: Refactor da_monitor to minimise macros")
> > Fixes: 8259cb14a7068 ("rv: Reset per-task monitors also for idle
> > tasks")
>=20
> Fixes: tag "indicates that the patch fixes a bug in a previous
> commit". There is no bug here, so I don't think Fixes tags are
> applicable.

Yeah good point, that isn't a real bug.. We're just holding a lock for
a bit too long but there's no harm in that. Will remove the tags.

Thanks,
Gabriele

>=20
> > Reviewed-by: Wen Yang <wen.yang@linux.dev>
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>=20
> Reviewed-by: Nam Cao <namcao@linutronix.de>

