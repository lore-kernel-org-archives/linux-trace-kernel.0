Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8400F3AAF42
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 05:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785388412; cv=none; b=Eoc52yCQO0fOg0uoucxb3cfsGup0Myc1lmjg0Z4ktR3Zw+9W+urdwOrdcWargyaWu0j1yihZN4g3qI2aPxuFRpj00cVwraLkxtlzig/f/GUtXbZrgHZnaE7yHysOY7Tn4DIbB9XgnPEKplNKW3pKCP76y6DmcikIibcJGOc4sRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785388412; c=relaxed/simple;
	bh=jYBoD3WTLODitr3/jlTdhXE1qs7H4BHU2FVIazNirpY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=X9TEj76A23AWS7tjOpljd/cZMWe8AD00vSVkq4j2ur2x8D/VFJ+7pQO09Hm6y2ayjk6JPqmLP3iCarNVmU8OkrS6VgfpD/Cs4lcD3L7aIYVFphhif6WUVOrElxD1ru98lZFHGW7OjmaMnN7mc51Q/dIkqo6GChmJ2bCyTRPQDuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KUun0EAH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUun0EAH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785388409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HjmqrivcJJpxkBpfchxzvsyG/l3p96EKoQD2VOBo+zs=;
	b=KUun0EAH0/Zi/ByBWYYSFbhvMGGGa2vXyUqwCl2/6kRS8yi43HQk+TIZGF4Fq6hdxE1Jq9
	/GzXquwW3uuXGxauQCFF0piHY63zNCBYBgBbxp9m51qrAHwwGoxdtoEuJMGQ50FikOoWbE
	0KpjKScNMIiVPiKc7+tJF2vNYXjpYiQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-1qvJAE0RMqGQR3oHOQEwmA-1; Thu, 30 Jul 2026 01:13:26 -0400
X-MC-Unique: 1qvJAE0RMqGQR3oHOQEwmA-1
X-Mimecast-MFC-AGG-ID: 1qvJAE0RMqGQR3oHOQEwmA_1785388405
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4955843c6cdso18014305e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 22:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785388405; x=1785993205;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BOEicW8D/gztHqaGk9GvfiS29jnoogsbqOZZnCb/DS0=;
        b=DOwf2rAUon33b30SRKpadA7By+0JJxDlOK7ZLU8Hp43GaaWQBtsIOwOiGajvi1gLvd
         PcfM5xNmcW4Xom4Wd6KI3qOeQE+5RDWdOs0l1NQTr3NN/hQHvqrxs4+FH2eWkIC+JTto
         Ln2lUeiT4EPQPscFUBxIvyXCSoRhsjUQsK9aUoHcbRf1jEgdJfME+Y6t4GDOvfVmXipG
         U3Gj+JFZcxWv45vKezc0W9pVhW357r4z11W1e63PmgK89FEUZwvXaKD0EEPvRBZw3s22
         qHZ1SC2uPvs8KQ9pIMrHFCCw/Z0su9YT+lent5Mm3Epn3sprY1j5eb4oXFtb24SQrf4k
         gKew==
X-Forwarded-Encrypted: i=1; AHgh+RpUpT1eoiUQneL9z67LilFb1p305d0ro3pTjl5qqyawIM4mO2uUN9Vv0aPCMUwSe7Q7nB4GNcj2A9itkVl6oS6QDSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO9FwahjDEpu5rrqO7xOFwFoZB5VYXjOln4ciW1TU0qguc7aSy
	fIcsj5ncpWmTnp5iE+3GJt4jo6I0eI721rvQKZV8oHNBWRSUAlkDrvNJTtFolI1E4q9QTS2KFHn
	JvumWWODIKvzdoZ/7nckIXdSV0RvGAlHfTdXb36rLUFDR7mMdkY0U9nyT6xYAkjKOVOa4yt8fpw
	==
X-Gm-Gg: AR+sD11MTgKaIgIwzv2hg9fST7cEh7DfjFiInmjmTcBbT+6CSDeYE5ge6xFdQ1sP9PE
	Fb4k0WFn571yINt73NVg7cZpIjqSH5ge/vAGMkd0r0O1xeulnuiWli5OTsVJAfyEUTG03+sM97f
	OO2pFHviRj9cA3+c25ZoUDBaKBC9EOXRD/QJL9rSJRFTPzNeueo7hIY0+0zvYeFCp+aZsOGXU6d
	AKr+eNgE3nyk+SrEfsZRWmVlgmf6DkijImV61eCiV/6234HOflEC8Lq5mEbH44I3YH8u81JriwE
	WgPxBkDBWjtgSC9HSNDmfCH+lV7HDsMubKBC9mJdZK3pbfxqFbh57FXs5QSrdfDkpqeYqkkxxm0
	sFIvzimCC
X-Received: by 2002:a05:600c:4693:b0:496:ca1f:a428 with SMTP id 5b1f17b1804b1-49800ea1ab2mr12602615e9.19.1785388404815;
        Wed, 29 Jul 2026 22:13:24 -0700 (PDT)
X-Received: by 2002:a05:600c:4693:b0:496:ca1f:a428 with SMTP id 5b1f17b1804b1-49800ea1ab2mr12602305e9.19.1785388404297;
        Wed, 29 Jul 2026 22:13:24 -0700 (PDT)
Received: from ehlo.thunderbird.net ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498011fec37sm27120065e9.9.2026.07.29.22.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 22:13:23 -0700 (PDT)
Date: Thu, 30 Jul 2026 05:13:22 +0000
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wen Yang <wen.yang@linux.dev>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
CC: Nam Cao <namcao@linutronix.de>,
 Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
 Tomas Glozar <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v5 13/17] rv: Add KUnit mock for current
In-Reply-To: <38a2480b-b420-4b14-9793-5ab3d7cfb2b9@linux.dev>
References: <20260723074534.43521-1-gmonaco@redhat.com> <20260723074534.43521-14-gmonaco@redhat.com> <38a2480b-b420-4b14-9793-5ab3d7cfb2b9@linux.dev>
Message-ID: <0CC2C4B0-6E6A-4199-A7FA-EEDEB28866B6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b4p2YcL0eKopQhBwvWXS4n7jjdYrSYHIdtZGoCxowH8_1785388405
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Il 29 luglio 2026 18:17:31 UTC, Wen Yang <wen.yang@linux.dev> ha scritto:

>> +#define rv_get_current() (unlikely(kunit_get_current_test()) ? rv_get_m=
ock_current() : current)
=20
...

>> +/*
>> + * rv_get_mock_current() is called only if we are running from a KUnit =
test.
>> + * This can occur from a legitimate RV test or any unrelated test runni=
ng when
>> + * a real RV monitor is active and triggering events.
>> + * We assume the former case is the only one where mock_current is not =
NULL and
>> + * can occur only sequentially (KUnit doesn't run tests in parallel).
>> + * We cannot rely on the test's context because there is no way to safe=
ly
>> + * understand from which test we are running and KUnit utilities requir=
e
>> + * locking, which is unsafe from NMI or scheduling context.
>> + * Note that it is not possible for a real RV monitor to run when the R=
V KUnit
>> + * tests are running (see rv_set_testing()).
>> + */
>> +static struct task_struct *mock_current;
>> +
>> +void rv_mock_current(struct task_struct *tsk)
>> +{
>> +=09mock_current =3D tsk;
>> +}
>> +EXPORT_SYMBOL_IF_KUNIT(rv_mock_current);
>> +
>> +struct task_struct *rv_get_mock_current(void)
>> +{
>> +=09return mock_current ?: current;
>> +}
>> +EXPORT_SYMBOL_GPL(rv_get_mock_current);
>>   #endif
>
>rv_mock_current() uses EXPORT_SYMBOL_IF_KUNIT, but rv_get_mock_current() u=
ses EXPORT_SYMBOL_GPL. Both are defined inside the same CONFIG_RV_MONITORS_=
KUNIT_TEST block, so rv_get_mock_current should use EXPORT_SYMBOL_IF_KUNIT =
as well, otherwise it leaks a test-only symbol into production builds.
>
>With that fixed:
>Reviewed-by: Wen Yang <wen.yang@linux.dev>

Thanks for the review.
This was intentional however: rv_get_current() can be called by any monitor=
, those don't have to be KUnit.
Since rv_get_current() is a macro also calling rv_get_mock_current() we nee=
d to be able to link that too.

The idea is that a "real" (non-kunit) monitor handler could be run when int=
errupting a KUnit test (not an RV one, we make sure of that). In that case =
we do call rv_get_mock_current() and return current after the function call=
.

rv_mock_current() CANNOT be called outside of the RV KUnit test cases, it u=
ses a global variable (for problems I tried to explain in the comment), so =
should be exported only to KUnit and called directly from the test case.

Does it make sense to you?

Thanks,
Gabriele

