Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433C5194A5B
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Sep 2024 10:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725532734; cv=none; b=aoW8jTDd8yOBQZ5Q5rkMvPKicSeIf6NfowgeqcpiYncoOSSbvl53uJcD0gE2Az1T8bfU6TGmdhgJGoqiQeOsn+xASCeS0hTOwUYiFzFPg09FgAs38oM0yooYo5Grp01F+HuQmggjHiQxxR+qfckukmMJcNdzoAKsircvIyE5ZNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725532734; c=relaxed/simple;
	bh=5eaa+rSxz7RV4LJNTlQaXt482DTfawXdnh2HOEs2v/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrDN37A5DQFQxsI1Ac4KaLQwzkyiQONP+pau4QsZVZeNleP/f0d1AB1OgyUe9fxOCgmHwEVG3tfA/FpQUSM/wLWvCcFfrl9BXdgry7HfdRPP4RaxtcmW4G269ttRiTnS0ec+pBp50FidzN+7dE2kNaFKjSJ4jLIBXOqj2B8SgjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fjCBEM7Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjCBEM7Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725532732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wV7mzlpoDJEIgZcv8pSkUgGLoTQH8N21DlR4ywl2M0M=;
	b=fjCBEM7Qo4D3M0BjFvdOLO8ovU2KmsEZY/JHVpqqsAr4zzkvjCp+Qfco/zcbl0HBCYrOSm
	LJJagnT+k1RbqAM0RhVBTqxtzxmA/7rADRzQVlSf5d1glMHecSs1FgVMxjt5Pr7NpJhBHV
	41o2bh6bMIDZW2yEN/KtpfGYv1z5X5U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-yMXxJFO-OZSWK7DIghQ7ZQ-1; Thu, 05 Sep 2024 06:38:51 -0400
X-MC-Unique: yMXxJFO-OZSWK7DIghQ7ZQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a86975f70a2so60645466b.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Sep 2024 03:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725532730; x=1726137530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wV7mzlpoDJEIgZcv8pSkUgGLoTQH8N21DlR4ywl2M0M=;
        b=wfdXP+T6nOU98jPliuGyqoXj3b8H5TTTP+5C+U9XKwVgzANljsUmfTji6GGvLpHeBX
         AC9WR++wtXtScCWdslywLdj7sDKjYPZ693nB0x33CF8CQOPotFe8NHg4DNnWOM5RcstM
         tHaxK1LrCxeauPGmnFeSONl634mVYg+Niavfl/VJ1DL37dTr3NdWSzG/QIxagyxQkHFe
         Q4EuLbE1knv/IO56BfgD+WnLRC6ovxsJEXVMO9nyGfsfUO6NyZZO4YVE/t/OaAnHIVEF
         tVMxQDNU/dmb2k6L3U4a787NUsz56OYnpbjnEVv6hNisnLmMq2tY4k0Nrz0ICGSZDTwo
         w6Ww==
X-Gm-Message-State: AOJu0YzwVSzHS2ua/K0fTdGReaxmm1qxLCzyhVH1yxNCaqn6o75lRbIv
	Ytyn8QfHyDZwpw7N4P2fz04Qm2tUMgyctPNfSlFSvPkruCosfkeXVL+lm4Nm+LzjkX/D71jUbfF
	+FsQg319u8KwYTvOjJk7Nsv1y2BWmpeaDmRZmSF1D/IBmBzX4VK0Xd1Gain7Cx36dvY8R7/jVLz
	b/UMZv3dUjWO/3Oh9qOLO4bhkQ2PuL5AmBKUXcmQUgC+pK
X-Received: by 2002:a17:907:7e90:b0:a7a:a138:dbc1 with SMTP id a640c23a62f3a-a8a32e72ebcmr610763266b.20.1725532729772;
        Thu, 05 Sep 2024 03:38:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE98kyXo3s0NnZGdnqKCaiXTRoquo7eiLgNbREY5yttSLKxxqdUm8L/2aoPfmxvVVbNnuPcjPl1DZFVAQgZavU=
X-Received: by 2002:a17:907:7e90:b0:a7a:a138:dbc1 with SMTP id
 a640c23a62f3a-a8a32e72ebcmr610759266b.20.1725532728703; Thu, 05 Sep 2024
 03:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820130001.124768-1-tglozar@redhat.com> <20240823125426.404f2705@gandalf.local.home>
 <20240823145211.34ccda61@gandalf.local.home> <CAP4=nvQnW5vS5CQBZtKp-BdjYxNFbq26P36uRy3RhCenHEG_YA@mail.gmail.com>
 <20240826132620.1618d201@gandalf.local.home> <CAP4=nvTR9EuA5WhGweSaoeptEw0n0w5exr8gq6zfqGhGNt3zpg@mail.gmail.com>
 <CAP4=nvRfkZ2CEbFv+MFBXikZ_p2K-1uucgkdgp27JeTxe58qhw@mail.gmail.com> <20240904102104.6f2a35af@gandalf.local.home>
In-Reply-To: <20240904102104.6f2a35af@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 5 Sep 2024 12:38:37 +0200
Message-ID: <CAP4=nvQPPd5nb3ao4tc9dCyd+fy30wX6=dziFEJ_AyaJOpnCmQ@mail.gmail.com>
Subject: Re: [PATCH] tracing/timerlat: Check tlat_var for NULL in timerlat_fd_release
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jkacur@redhat.com, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 4. 9. 2024 v 16:23 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis.org> =
napsal:
>
> When running my tests, the second one would end up deadlocking and
> triggering lockdep. I found a way to do basically the same thing with a
> cpumask and no added locking. I'm currently testing it and will be sendin=
g
> out a patch later today (if it passes the tests).
>
> -- Steve
>

Oh that's unfortunate. Your cpumask patch does protect from timerlat
trying to stop a user workload thread via kthread_stop, but I don't
think it prevents this race in the code from the other patch:

static int timerlat_fd_release(struct inode *inode, struct file *file)
{
    ...
    mutex_lock(&interface_lock);
    <-- this can now run at the same time as tlat_var_reset(), since
the latter is not done under interface_lock in the latest version
    ...
if (tlat_var->kthread)
        <-- if tlat_var is zeroed here, we still panic on NULL dereference
hrtimer_cancel(&tlat_var->timer);
    ...
}

Either way, the results are much better: before, the kernel panicked
in <10 iterations of the while loop of the reproducer; with the
cpumask patch and the tlat_var->kthread check patch, it has been
running on my test VM for a few hours already with no panic.

Tomas

