Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20791480DF0
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281350; cv=none; b=jJ+x55B7yhQmQCM0u2DVXYJe9bJqyMQ1H8d8W2xzwqurP/Jw+TOur5zwluQtTePfUrY+bz2iDNywEmWSOhewnQwpfbFDJGOqWhWwqaAcRii8W6LlLxUfReRbhXflFTPrZ0uqRDj1N4qSS3lG3FLqg1lTcvmCfqFqYJsXLmQHh8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281350; c=relaxed/simple;
	bh=P+ghaIFdvhiv1gc5rr1LafGAKnlltIHpWDu3K7S4lz8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RGLngfZz0b5FIqi8dhQW/2Isj8J5iBLuxGOnKbpiMxgeShsf1Lzbs+82DtqONouKHLhGs/LBLZh6LGsteXY9ui+qWbIDSFz9/ft27qoikBBT11k1ZrYn4F1A6HPZeuVk/GpGqAZYty2Z16wYFlLNk+o8ikz9A82mNxNNnT9Cj/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RutvT3Sp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RutvT3Sp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788281347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HQdU6nS9X5s/Sk+3p7QLJBTOkdIV0pLZBILT9fDuDE4=;
	b=RutvT3SpEQh+MxWdCDwCMPkn2F7dpHrvwL2mJEE5+xdHn1+YS6ZKgXQLSfs12QXvU6bOA3
	RKdegNAOzIBL3Q/yXzW3urbPhkbVo0R5MYjToqW47rcXcUNsJ/fmw1ybTfyycekJFU16B/
	wUYz2EXuKVyRSDiYBaCew4aLsCkX+rk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-1N2ooOimOl69bJ72Y4XlcA-1; Tue, 01 Sept 2026 12:49:06 -0400
X-MC-Unique: 1N2ooOimOl69bJ72Y4XlcA-1
X-Mimecast-MFC-AGG-ID: 1N2ooOimOl69bJ72Y4XlcA_1788281346
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-936e393061dso16578485a.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 09:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788281346; x=1788886146;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HQdU6nS9X5s/Sk+3p7QLJBTOkdIV0pLZBILT9fDuDE4=;
        b=mc083W8Dvihh//RilU94CCsOR8v2DohqpuMXNH5DUMLQ8jUEWI89W6l5rDj5X/ELGF
         1msjrre/GF3bQkbKDDOQhNfumurtjh4CFewO2x/39ZhI9cOCWpAcdCM6aGr8ohwlxr8n
         twNiBW8tRib77Dn+m1jPLv14Okh/8YVJ0TcC6mNTOobmO2RX56qu9P3Q1XXEvliSRnPQ
         6mQH5BQCYdf0/26UNavSSblelRJvk/qBONrReGnmMEU8ZTty8P6lzVcOKPPwHblS50y3
         yxS+50jHj9sN7Ao9QahT9cUhc4AzfGuE+nL6HZ5j4e8Dr+1uEbDyIB/5K9cjqV6LacyG
         WQvw==
X-Forwarded-Encrypted: i=1; AHgh+RrQ3UfkbPhiohPvteMt5kzJNskyeGlf8pOMeJvv3bau3W9GFYVFyFaKJPjugYdVBTn+O0zcRzN4MtmxA+Z9qzOdco0=@vger.kernel.org
X-Gm-Message-State: AFuF++m3DSfKXwDOnzaWGHDQElLvpKJMW+XfcKhdd+/9ioYT8po1yKiv
	MHL6z0cHSQNCdwHYfMQLIAoo+NxdAJXRfrsvMjpZXPKwuGEG8/orXaVAPDLBS+IL7dr11oaIW9D
	q80HMBQBZwrE4rRiZB9V3Ps5BQoqdRTmgtgOUggk6FEjBhKUWGXSuW4gbmc9a6sSrffK1HFNZUA
	==
X-Gm-Gg: AR+sD13GcjN5auIDxvUKEKnSl+Bet+TSS1hYN2oFkuyBh2nPvxqlHR9mvjKf/rgqUs7
	FpC5i5uxNr5nbkJBNzdafWYVLvGnMWDT+ya8FJL1WurdzW/hNXDMS16rjTss4SEnnzBu+2U2jPz
	gGVE0sXixcLsxOcTsMWISdIpdKBlzXPGpnW0iMSXwsAqxeVcFQC3asJzIVYD5t83YlFG1rSqsRt
	oOdO7dSSP76J07WNeNIUIURaAU2MIL5q5fR4O/pAJL5HMJbwDM9i6Gp/e/wHQfBuKEELnekhtry
	86HvJjyqnRgHsDCjO0nGrsRlklcsJJCqRKYvdLBiXau87RqAAwgJHC9oAZqfNfFejaZ4PPbBV6+
	uaqph0DKngtYsCLEZjON3TKv76k/3PXSK
X-Received: by 2002:a05:620a:2b43:b0:936:bc78:791b with SMTP id af79cd13be357-9391379810fmr4573152285a.15.1788281346119;
        Tue, 01 Sep 2026 09:49:06 -0700 (PDT)
X-Received: by 2002:a05:620a:2b43:b0:936:bc78:791b with SMTP id af79cd13be357-9391379810fmr4573141485a.15.1788281345545;
        Tue, 01 Sep 2026 09:49:05 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc01:6890:c623:cd89:345e:99f3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939170138eesm1085336385a.3.2026.09.01.09.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 09:49:05 -0700 (PDT)
Message-ID: <1aeef720f40a21514c42ed7a76779086e867ebaf.camel@redhat.com>
Subject: Re: [PATCH 1/4] tracing/osnoise: Per-cpu mutex and fd detachment
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	linux-trace-kernel@vger.kernel.org
Date: Tue, 01 Sep 2026 11:49:04 -0500
In-Reply-To: <CAP4=nvTE0YsxMUTJuC2uT=T-5TX29JDZ1axR6nZBP7XjMNV0WQ@mail.gmail.com>
References: <20260824211544.3984835-1-crwood@redhat.com>
	 <20260824211544.3984835-2-crwood@redhat.com>
	 <CAP4=nvTE0YsxMUTJuC2uT=T-5TX29JDZ1axR6nZBP7XjMNV0WQ@mail.gmail.com>
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nSi6MbyTprya9bC_2-k6k3yA21meduGcg8Z1heho3Ys_1788281346
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-09-01 at 15:32 +0200, Tomas Glozar wrote:
> On Mon, Aug 24, 2026 at 11:16=E2=80=AFPM Crystal Wood <crwood@redhat.com>=
 wrote:
> >=20
> > Clean up a variety of synchronization issues and related bandaids
> > by having a per-cpu mutex that guards changes to kthread, and
> > fd open/close/revoke.
> >=20
> > Replace the SIGKILL hack for userspace timerlat threads (that doesn't
> > even work, because we don't wait for the process to actually die) with
> > a mutex-protected detachment mechanism.  The mutex should be uncontende=
d
> > during normal timerlat_fd_read() usage.
> >=20
>=20
> I agree with detaching the file descriptor, that seems to be the right
> pattern. An alternative would be to make the user process to block the
> tracer until it detaches, but that would make it less consistent with
> kernel thread mode - which owns (creates/stops) the threads - as well
> to make it more prone to locking issues during user process exit.
>=20
> Can we perhaps clean up the synchronization issues without using a0
> mutex? If one thread is switching timerlat between no thread, user
> thread, and kernel thread, it could mark the osn percpu structure
> "busy" and reject all other switching operations until it is finished.
> As you say, the resource should be uncontended during normal usage, so
> the user shouldn't care about being returned an error instead of
> waiting. Or am I missing something?

The issue is waiting for the completion of an fd operation that has
already passed the "busy" check.  Maybe something custom could be done,
but a mutex seemed simplest at the time.

That said, there is another issue with this patch in its current state,
in that you need to wait for the timer to wake the timerlat thread in
order to get the mutex to detach (and maybe longer depending on mutex
fairness issues).  So it could take a long time if the user sets a long
period.

I've also recently seen some additional issues that I'm in the process
of debugging.

-Crystal

