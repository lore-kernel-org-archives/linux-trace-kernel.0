Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1334366836
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 07:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779347067; cv=none; b=TZULxbleMv+QATXx+cHRF7u0gIOHfHPNFZr6sVCwQb82pLSq7nmIzDYHZFTKyY46H/2Cg3QdppjzqrO39H6dRk6IrmNDBM8pNzshAn4aVOmVU1OsClh9w7zwTtSLk4XCmMGAGk/Qys4141gnsw8M9WbBY9MYV73Z3bp2QtypQpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779347067; c=relaxed/simple;
	bh=Z2A5zHXLDkxoJKcTINH6UFYsqc4B1Y7vCpXz+7YBudc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tl0BajwZze6cz0T/ilE3QX21cRV3xios+TAtURigEd0M0M7RTSHWQ45RyiM8ZS+ZOcKRtE05fliH0ZC1pb+dTh9FKp858E6yHo7gUDrSXSU5GJmuXBIkJL/E/Zj2EISwOuGjWzcA0H2fPEN+A2E86VQ+p4XU8RhHp5CAkAMUmQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXkMf63n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXkMf63n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779347064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Z2A5zHXLDkxoJKcTINH6UFYsqc4B1Y7vCpXz+7YBudc=;
	b=cXkMf63nuHj1fDo/vHh6MUbTqyTD3LOJra1EEkA2KNqeCOFNU7k3lN4pSipw5gaWNraS0P
	WTEWHRXpYlZIg8P+j4gLE1lnlECVbnqDMfmrzXNrf0/0Tl4KCoUkdRP7hhTpz6cPK7/wMc
	QZmPY5aFwM3wwBqLAnwNSjVzX5qAQPQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-VI1y7s5FNeCZCkBW1jKd3w-1; Thu, 21 May 2026 03:04:22 -0400
X-MC-Unique: VI1y7s5FNeCZCkBW1jKd3w-1
X-Mimecast-MFC-AGG-ID: VI1y7s5FNeCZCkBW1jKd3w_1779347061
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44696b11265so7604367f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 00:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779347061; x=1779951861;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OFsuzF9LUMXdCSw0qWu/j9Z+GAO8mscxEvKXnPMhIa4=;
        b=SsJrNQDP2HFOPw7ADzFEFdP4237rnY+iC9OXDfw3FBFow1dQQQaOoFNaDsnDBeZkOq
         pN+b/noGo2P+evuWfjr6c5Gv4DB1iujTBMM1m+lYhdKNOzFY7KSoBhOwF6RRr9lFceUM
         0mOHxJfVVr/MntPvBNMwS5so17LUZ2oq6qi6Y74KNY+NK4FE1wdbBJOQ2gHbBY9giDDK
         pZei36aUOhc+6SbXhkHnsz3qY16/J+V2d6uqmQMpKIHTQHVtALUbRMxtLYLGDoWtaf2T
         UX1eynWL5wyw4jmRR+5RKw16Fyb0Xnjt4SOOf/AubcNaEMqBmxzcs9S9zhY7cNynoACX
         wU7A==
X-Forwarded-Encrypted: i=1; AFNElJ9fIxu7rLrONpPeCw5QYwoFozSf5Pl6cL8SzGTo8D6ZQBUGDRVSXDO+12geaEVJFS3lEPLn6d7VrDCbQx80Z8NYnDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0JPFi4LXZhczFAQZ91fjZl3zyJ+FU9VwCZ/jyw6L3SNyl5B/4
	ZJ8RzbmZDzCdd7Qo4GXn121b0+Uqbm70PEtgTyO/ebwc+P4n1R1r0W0KQn6i6pTCa+OV4VlP/Wt
	4Sw89+SCxtW5fJavbZCj8gTp0FFfnwX1H3yOLSZ739SYNmIk7r5lEeO5b0cHnYIa8hEVi7Jqe6Q
	==
X-Gm-Gg: Acq92OEvgPb8ZI2NZWqHGys/bjRbJCmyHh5oA+oU0dBmnhW5q+C6qgQwQp/DFAIH/65
	Ef16uuyGrdBQKFZPzjT1wRWB1oy9HPEljvDssUsJEynogIjHOwdLIEl/hkhvxEVDWtB+d4eMErf
	c+J3xmIikUxP8cFq20DxZA7IkibytOgIB++eDD5ma9uobBAlLoTugKiSjlfqox5Dx9ABAo/hVBd
	e1MBU7DabGLbzny/DVzVKnS8SQvQe97L5G7QKcsAx1XR1BU5CjFAP0w7BtnP+cEiXCeiIEpz85l
	tcdpGg7vXPR12oCPGpr2UZZPVUnHq5v28VCPbQVTizsggKTVyOFeKUt71ysJCfXFsugV/BI/BJr
	1r1OU81o0NO0Oqe+SpSk5har8Cx5n8Wc4B6QyOzZfsoIPSUbZP79yiZMg0E7aQLZnYNLaWkY2X4
	y6xcp3RfLOcN/1YiQ=
X-Received: by 2002:a05:6000:40d9:b0:446:ef9a:8f41 with SMTP id ffacd0b85a97d-45ea3cea561mr2199945f8f.40.1779347061365;
        Thu, 21 May 2026 00:04:21 -0700 (PDT)
X-Received: by 2002:a05:6000:40d9:b0:446:ef9a:8f41 with SMTP id ffacd0b85a97d-45ea3cea561mr2199879f8f.40.1779347060900;
        Thu, 21 May 2026 00:04:20 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa92dea5sm394994f8f.23.2026.05.21.00.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 00:04:18 -0700 (PDT)
Message-ID: <376235e7f56f4d7fe21c68b39e12bacb9d3e3d19.camel@redhat.com>
Subject: Re: [PATCH 2/3] rv/rtapp/sleep: Update nanosleep rule
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Date: Thu, 21 May 2026 09:04:15 +0200
In-Reply-To: <a2175a6647bb88797ad8275eddb4b20b749474ec.1779176466.git.namcao@linutronix.de>
References: <cover.1779176466.git.namcao@linutronix.de>
	 <a2175a6647bb88797ad8275eddb4b20b749474ec.1779176466.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VdHlC1xxBbXpzRP_bsOAXLbe7JQCpFNONuegv2D-9Os_1779347061
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-05-19 at 09:49 +0200, Nam Cao wrote:
> diff --git a/kernel/trace/rv/monitors/sleep/sleep.c
> b/kernel/trace/rv/monitors/sleep/sleep.c
> index 0a36f5519e6b..e01ac56b3f4a 100644
> --- a/kernel/trace/rv/monitors/sleep/sleep.c
> +++ b/kernel/trace/rv/monitors/sleep/sleep.c
> @@ -43,9 +43,7 @@ static void ltl_atoms_init(struct task_struct *task, st=
ruct
> ltl_monitor *mon, bo
> =C2=A0=09ltl_atom_set(mon, LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO, false);
> =C2=A0
> =C2=A0=09if (task_creation) {
> -=09=09ltl_atom_set(mon, LTL_KTHREAD_SHOULD_STOP, false);

Was it intentional to remove this too? It seems to me now it's cleared
only for existing user threads.

Aren't we sure new kthreads aren't stopping?

> -=09=09ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_MONOTONIC, false);
> -=09=09ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_TAI, false);
> +=09=09ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_REALTIME, false);
> =C2=A0=09=09ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, false);
> =C2=A0=09=09ltl_atom_set(mon, LTL_CLOCK_NANOSLEEP, false);
> =C2=A0=09=09ltl_atom_set(mon, LTL_FUTEX_WAIT, false);

You missed removing a couple of these in the next branch, the monitor
doesn't build.

Thanks,
Gabriele

