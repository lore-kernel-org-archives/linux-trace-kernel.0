Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F731288C3D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779115497; cv=none; b=XqqLUSN1HIA1ezPp5JZqVKLWk5MkSGUep4Ta47hT5gCdTkKfkDctUb2BfdzY03Run+lesBR6uTLHdBOkjRmc4h/8/ITuC5wP4+YE+jSpADONu7R8p1ihWK0gHxXt7t5b7PPq2UcQQXpuyKAH+m3F5Z7oAJg1OO8X9y0bgjG3sm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779115497; c=relaxed/simple;
	bh=VHcdtkhO42wYch+Vyz5+JlQO9CdKTp6tz6bag7T+suM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gCEQgxiNHGPQ1CoJrE+zrWi1sRHbVIQ/+XIpyxoG+wLeJjyOWMjJaCoVw560AwwYMfssIwlE5LfnQvZKf4iRuNtu1Q7cAL71WMeTaSGr5NIXta5J9VRICc/1hmW6dZDaWTBmc9o3nS4UQmjcy7pSU98dLhV1kpihwP/L469aV0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qme5s5KO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qme5s5KO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779115495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kq5SmUAVt7Cx2lZl8SA1Z+LMYibvqRnAdFpBFPJBKtg=;
	b=Qme5s5KO9vrMCBE9moEG3TuC2NpBeZJYNEigUuu4Y9a71t8kv2pdnYMcUU3x74jtT+pxl6
	rmlAXOKoHzGhtW5xLVlvBWQS355EMqPV8r3YL7SrXczAaiQHEl9Z9O3/JrRIi+xalPcq/+
	3c0qsT/YDEKgKx+bJTQTgyAbFu9tNpw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-mygFl5-KP1a8_Mss34r0qA-1; Mon, 18 May 2026 10:44:53 -0400
X-MC-Unique: mygFl5-KP1a8_Mss34r0qA-1
X-Mimecast-MFC-AGG-ID: mygFl5-KP1a8_Mss34r0qA_1779115492
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5a86f4deccdso2043801e87.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 07:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779115492; x=1779720292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kq5SmUAVt7Cx2lZl8SA1Z+LMYibvqRnAdFpBFPJBKtg=;
        b=JINR5JnFaEtjGYiCw0GrbAASIg9fu9c07ma1wCnpt71Jo0UTslj0qS3jCD9fgy0tHl
         eSivjWK170jIhdytLLP9srSPu74qUkK/7LF2Dw9uiKtTqw9PIz+NAkm4AeAVTnMiBJ81
         DfodRQ34NyOXG6dUjaV+NOUEh6sdvJwRItxgyXW3FEJEAVlKFmt/UOe8JLTXb0Z0ldET
         cigBDKbK/ljaiAE9HatevAbfLZH0/zDfmIvIJ4aRYjsruejt35Zz6+t7MZgTEehGLkBU
         QNWQ6Sj0G0+OzcjcasRduHZAgvNLicose4wwmifcCd/QNWIhYJ3YKCnmypb6DGin5Z3G
         PPGw==
X-Forwarded-Encrypted: i=1; AFNElJ+smY1XHos0ALNXt18pJ9iNY5ZTzR8HfEEWpx4VYMD/Yb49V9KlxTrDUjcbYd6Cf0mD84ydhz/MAtnC9Gx7iW3mJMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJQacnH/uw5wi2NV5pjE21lKBLz5ISFChIna1E9MzLASjmf2d3
	8byZaWWTvKJ1gQCnVjXOz+bLe9GRK1UsKk5EJthbtbevsadvx8DstixHkzrI09gavOu4/n6KUpg
	EhoM0WaWD/WABnJG82OBjgOs4B7c1aV9xAdvb4tt703xgnTFQwVymGfgn7gBJmoPwUi8osr4yUj
	2Qa5EZH6VO+YEVFMEv1bJ6P/ZfqiKtZWwZpI4w34v9cEpWBbza
X-Gm-Gg: Acq92OEN5UBhbk43F2IKDsAnr1mv4sKSJ/mu1VOKNFIxDdX74eEiWb0afKwxTwnVrni
	IUF8t/RJz4VpMYrqeNpGJ7n6xbVFHzZJGgmFmnwfNmTaAUvz8MhTkeRH4ARpuO2ZOq50AcqCkIU
	0s5Qgm7hAzHaSaZtpTdK63ioIfn34HvsNZY3+TASEy2joMY0qRpo37ViRX++qXsYqa/RcQd2ODr
	+1t+Z9dEi/c+NacgJ/lUSm7bPu6ZeWEbZGPHhci3V8KDbMnQMqX2oBAs5KkXR/HvE+TLut0Po9w
	2Si0esML06KbixsAgwQgrOhNRE18ZMeA
X-Received: by 2002:a05:6512:1595:b0:5a8:6b96:9d10 with SMTP id 2adb3069b0e04-5aa0e77522fmr4479622e87.40.1779115492263;
        Mon, 18 May 2026 07:44:52 -0700 (PDT)
X-Received: by 2002:a05:6512:1595:b0:5a8:6b96:9d10 with SMTP id
 2adb3069b0e04-5aa0e77522fmr4479610e87.40.1779115491693; Mon, 18 May 2026
 07:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777962130.git.namcao@linutronix.de> <e8a636c8ea6da554fd51b1241b9181f65af420c8.1777962130.git.namcao@linutronix.de>
 <agd1Tb8RDUqfjaGn@wcosta-defaultstring.rmtbr.csb> <87jyt189oe.fsf@yellow.woof>
In-Reply-To: <87jyt189oe.fsf@yellow.woof>
From: Wander Lairson Costa <wander@redhat.com>
Date: Mon, 18 May 2026 11:44:40 -0300
X-Gm-Features: AVHnY4L_15-qCgxo1YfKUTd7PHvn28XVv4DG57YloXyytz62ITSi64Ow3YJiFjs
Message-ID: <CAAq0SUm0qMWCgXxTPW+sXjPCv7uJc3GoxHeqG3vCaa1FM6S91w@mail.gmail.com>
Subject: Re: [PATCH 06/13] verification/rvgen: Convert __fill_verify_guards_func()
 to Lark
To: Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 63AuHYPUCwPRwV3wMAZy--8tE_MBdyIUsK8PE9O60s0_1779115492
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 4:21=E2=80=AFAM Nam Cao <namcao@linutronix.de> wrot=
e:
>
> Wander Lairson Costa <wander@redhat.com> writes:
> >> +        if not self.has_guard:
> >> +            return
> >
> > The signature of function says this function return a list, instead of
> > None.
>
> Can you share the tools you are using to catch these? Or did you notice
> that yourself?
>

I use pyright [1] with vim integration.

[1] https://github.com/microsoft/pyright

> Nam
>

