Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ECF343D8A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 17:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786730041; cv=none; b=PD6RNC1BzA0TSHt75LqD0CqJB0T6ETyklzvPCeB6aGJ6cSrVrKvJjuY6IQ21AemY9vdIULSuI9M2biDKWgWxLQL9C0+bY178BiBw1MRSSrELA2oyOppl5A43hitn8c2z9rmlxGdZhx0MXnTepxN80Fg2+c2/Pryg8MW6NkdJOrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786730041; c=relaxed/simple;
	bh=vVIxzxqKpJB42eAB7QQkiNdfnN7e8QwPwOzhr6DFoRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTEIHnlK5n0sN62nZGob8F5IqvVa+kNZqkW1Gxiu/hb/J0ka658S7hslN5j1B5vbNI5OJKrAfR2aNXq1m1cVCHHWdMN9pobenDqsD/sZnN5vkt3+5ioIUlpnkGR6GnK7xmfEJdgYNfprOyXbP6nWi1HXeHyZgco1T1bbo2LjQuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MqWRSmj9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MqWRSmj9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786730039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vVIxzxqKpJB42eAB7QQkiNdfnN7e8QwPwOzhr6DFoRw=;
	b=MqWRSmj9oUulXjf3jl/rsOCcTx1RcXx0gq4X9MEDXpNqHHckV2PULj45e+/fsq8258/N8o
	poMgccuVslFpsG4OIerDQfSoQvrC9/CtACxqnumFtEizMILzEHuHfZYmWpITBG36Mp+QIu
	ZtiTJqBQOhgEB/yCeeocWREPJSoXfoY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-TPdJBQnSN_m7ZUOZOjB8Nw-1; Fri, 14 Aug 2026 13:53:57 -0400
X-MC-Unique: TPdJBQnSN_m7ZUOZOjB8Nw-1
X-Mimecast-MFC-AGG-ID: TPdJBQnSN_m7ZUOZOjB8Nw_1786730037
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c20262b5e10so136304966b.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 10:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786730036; x=1787334836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vVIxzxqKpJB42eAB7QQkiNdfnN7e8QwPwOzhr6DFoRw=;
        b=miVvFQKBQytOEnRDYMW3KS+F7a4N6hXbyrHr6ypm5gwtZYS1PK9oG1Sfm5+nVfL8Lr
         /Bi3aMSBIXPlJAWJHu8eKG1pfZmNcN9HfwWKKPCz/T2hokhdC3wcieaX4kYliS9glxr9
         udUeKV0pk90JJtIT87r3aLC/KK+hJdiTbh8rIve0srgg5YBlfzsjpP3D3BbLdgVpLugD
         OzaKiJlOUCsz+IWM9w2X22khvcNjk/1RgTI9nAwppD00ic0TbFiG60OlfZFQlAR1hg1c
         It9+0/W3QIXbVrAw2w9bTcxfU/C0mwyJz5kQNk5hVkbh+SYHtuQRZTVhVi75wYAW70hD
         FVHg==
X-Forwarded-Encrypted: i=1; AHgh+RotrvOrxhM74f+XCh0VS8UQLnYsMgOZi6eOsunqvakyr107qoRsBiL0vj28gPujiPIFbEYrhDfDyFod+4jaqv3s8To=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNq23uSuTp4oE6K/btPSN9ijTqbKwgnQ13lT5002S6wZ3qnCZq
	UyA8Yfc7iIYWRMUNWcSUfarYlbxSFIfIFkkpCnP/T7j7JZ0vvvOq+ohC3EkeyuU/1Pmajy+DHJz
	/Kt1VWYMHjgajo+81V2iRkgTw4erdeZS8KgDtqjONAQALbhJ35llXYC24W0p3IHMHUyd9IbYD80
	WFR797xWUHyn28yrBOrCRRkC7LIwffE0x0h+iE9nxV2lomCeQ3
X-Gm-Gg: AR+sD11QD6rHpI0H/j1bz3lrJuOAu1d331kpXwdV/lvnJuomEFZpZ3Jb/gD6rTWEtcV
	KNNd+rgR6mWbYi+aI2fiJ3wDgKHbAXoMtCDKHHhhQAHKBAqgIhEM6lObklnxFshW9U3TgAP7NrE
	t1lIlHE9pyrkqwl582IdPKcCHDu3LngN6Pj2WMQHtJo8f9xnFS62xQyStWM6DI7/jMBeANOkUEJ
	XlFhy3Zrk1Yypk=
X-Received: by 2002:a17:907:980a:b0:c19:49ee:19b9 with SMTP id a640c23a62f3a-c212a11e24fmr353174466b.15.1786730036632;
        Fri, 14 Aug 2026 10:53:56 -0700 (PDT)
X-Received: by 2002:a17:907:980a:b0:c19:49ee:19b9 with SMTP id
 a640c23a62f3a-c212a11e24fmr353171366b.15.1786730036127; Fri, 14 Aug 2026
 10:53:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805151055.870722-1-tglozar@redhat.com> <20260810210425.61435b0b@robin>
 <CAP4=nvRWKYdkfr-9_1OMupZfF0nUYVVtMd7Vwsd3o4pO__SCew@mail.gmail.com> <20260814101906.26679d49@gandalf.local.home>
In-Reply-To: <20260814101906.26679d49@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 14 Aug 2026 19:53:44 +0200
X-Gm-Features: AUfX_mwNiMIamNkV_EIHHO-hgPZc_pfHO4ZxKKowKmJenw0yn14d2_T_Af3S1zg
Message-ID: <CAP4=nvToTgOw6iyx4vNp63UzYJGjzXbSVXmfAbycvHYpBaa7Dw@mail.gmail.com>
Subject: Re: [GIT PULL] RTLA changes for 7.3
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Gi2J6nylLVheZoGDOz6lnfSg-tFXQJ6HAwZW5GS_OuE_1786730037
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 14. 8. 2026 v 16:19 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis=
.org> napsal:
>
> On Tue, 11 Aug 2026 09:22:54 +0200
> Tomas Glozar <tglozar@redhat.com> wrote:
>
> > tools/tracing/rtla/tests/scripts/lib/get_workload_pids.sh is for some
> > reason not finding the user threads (as the tests for -H and -k
> > succeeded) on your system. The threads themselves had to be running,
> > as timerlat is reporting samples from them. The script and the related
> > tests cases were added in 7.2 already, this pull request does not
> > touch them so it's most likely a pre-existing issue.
> >
> > Either way, I will look into that, thank you for testing. It might be
> > environment-dependent, as the test relies on the test script (executed
> > as an --on-threshold action) being a direct child of the main rtla
> > process - which only holds when the system() shell executes the script
> > directly, not as a subprocess.
>
> I just pushed this to the for-next branch. I'll let you figure out if the=
re
> needs to be any more updates.
>
> -- Steve
>

Thanks. As this is now a known bug in the test (and is already in 7.2
rather than a 7.3 regression in the pull request), I was not rushing
to fix that and rather continued to focus on my patchset.

Of course, I'm trying to keep tests passing, now that the majority of
high-frequency intermittent failures are fixed, so that people running
tests are not desensitized to failures.

Tomas

