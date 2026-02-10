Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5486B30C620
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Feb 2026 21:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770757627; cv=none; b=k0acitrEen+yhL+zc7j5n6Y6q2+VoDmv1/2lBBoqyb+hFC/4Orwqj5oWU9OLex/AQL3Yq12y2aRI/qUG1uEsOBJMeZYO3zFpkt2N1yl6FTFqVcYYkrHTkPxr3Y9mceIjUS3soui1NLhwsdVs8m+9WUoKcJXzbUwktxtCu1OAf5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770757627; c=relaxed/simple;
	bh=RNJYResRebNRH7Z9j40IrwW3u2UGUbnA7oSLIcqDk8w=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dnXG7WfgRtjm+yIZATan67wTujVy6kRrLRC3CNJVbzs9BUUI1ugVBXL39Ur+fAFHHqVyfa14rUqNG+ylqWBVfCuz/XLZxpuQ9FgnsqoutscFbQopZyRGXzvMkzO2lBHM6ZqvRSPeY2hHEaqK/EGpAGE4D5klbfSD2zQwarDQAQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AbF8Q68l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbF8Q68l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770757625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SH75Lcn0Bk0i3INWSVd804url4O7Trp8bwYcgcysUxE=;
	b=AbF8Q68lD8rYTI1wgYOhEGE1tSWuqFXSvZcCbZlA8HyfVBF77hxGlKM0+PluvlnOACACu6
	zisOtWMdTiCNaM2m+6QKUskHeppvxWg3EnGFHDqEOeO5vfcqrDHJ7aXw2yMF9qvEY4KpoP
	67TNuOVYq/IqxhO9IeykSltC5rn4XXA=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-NZL7_n1uMlCQyvVrqigaVg-1; Tue, 10 Feb 2026 16:07:04 -0500
X-MC-Unique: NZL7_n1uMlCQyvVrqigaVg-1
X-Mimecast-MFC-AGG-ID: NZL7_n1uMlCQyvVrqigaVg_1770757623
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-45f39e21e1bso4829400b6e.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Feb 2026 13:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770757623; x=1771362423;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SH75Lcn0Bk0i3INWSVd804url4O7Trp8bwYcgcysUxE=;
        b=WBFMIGBvDyQ4bGyB+cUMgAciupFyaB2YtcsB0eBXSdQ+zoDBhanpepQx1x2O2iZlpG
         msX66i3e37u7zwPiks1Yhue1rB+GYELLJ2nLKuRdz5zm+NlsZWCfEkTIH3y+iy8hEn1q
         Ww8XQ+WFRfJlIKdEe8PVNzPunF9XResMGwFXQK/SmZJYAfCzOgrvH0VQIy8NHZthu6DN
         TSfOrteDVh5Ye1Q4ng14greeVQ8QGhILryIDcDSm8NCZuF43oPKTCOEuUXGyJV37f9TC
         eT/rxcy3MiXFGHpiLTN60oDlEH5TWJV32+pX9NWpCed2/KcnwHITSPYPQr9gWpa1Huw9
         8W8w==
X-Forwarded-Encrypted: i=1; AJvYcCXcGB38Zojjn020D00KENYPX7avIVhcZT7qp7pKm1gVobgxclo+9uuPExH/reBpuFw/gWHGAL3A6nGjpIio8JaNbGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhvnQAeofT8VIf86W1/APhD+VurBoEDz6uWyOk5NtSvIWAfH3b
	i//fcX8DPOkQKhViEru6aG+zMe6l+ne+wHIcsI88vC2/YxEkie9la7MgK9slOzOjCyNiXZQZHjN
	MER44oC7U8KRxapqSDrfqOp07kgufXawv8oJ/7wVQtG213Zjhj/yF17+9AsWiU7WX9w5w+B4ofQ
	==
X-Gm-Gg: AZuq6aL7XpE/XIKEiCnlz85QCUXbUW4PjLLFv4HP9w8rETu+GYxpGM/iKhx6K6K/Rmy
	fRE3BZj3liwL1OqflAHUP755Z2Ef+mzf8UPQZlMUiZfevUv8TFeckZJgmiFJL10nEk1BbS/YIg6
	q2LOjYI7LBtCMLiCsHWXiVV6T4ivHSG7tPULGdAJpgRCgC+ljQ0X5YyTOuuXEd5vEeXA4Kb/VGZ
	zF+ZKg2b/cr0ZbruBsahsvQJts7QQ7x9F5gr98I9rEeXr8La8RKHmxb76QTsyz60eeETfGej3hg
	AwRVd61EgmhvLghLrCgl61QDpwkIhKq+jW+8rK73DfCwsPvBRX55PYoP34qVPmQdtZnOH+umG8x
	juc89/f2at6oY2kXB+3tADcR0mAzxPs7iLQkxtEK83ukEmsaGDUDiKQ==
X-Received: by 2002:a05:6808:138f:b0:45c:a3bb:ad8f with SMTP id 5614622812f47-462fcc8d431mr8555913b6e.56.1770757623520;
        Tue, 10 Feb 2026 13:07:03 -0800 (PST)
X-Received: by 2002:a05:6808:138f:b0:45c:a3bb:ad8f with SMTP id 5614622812f47-462fcc8d431mr8555902b6e.56.1770757623252;
        Tue, 10 Feb 2026 13:07:03 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462fe9a12f5sm8999355b6e.5.2026.02.10.13.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 13:07:02 -0800 (PST)
Message-ID: <95b45cb5db8d3f3b8202eff5c754e4c0c95769de.camel@redhat.com>
Subject: Re: [PATCH v2 0/4] tools/rtla: Consolidate nr_cpus usage
From: Crystal Wood <crwood@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>, Steven Rostedt	
 <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, Wander Lairson
 Costa	 <wander@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>,
 John Kacur	 <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Date: Tue, 10 Feb 2026 15:07:00 -0600
In-Reply-To: <20260209092436.2899888-1-costa.shul@redhat.com>
References: <20260209092436.2899888-1-costa.shul@redhat.com>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N4unKeWk3pXELrvShEsiO4xWXKMCrdCWfBPoPdPx9z4_1770757623
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-02-09 at 11:24 +0200, Costa Shulyupin wrote:
> sysconf(_SC_NPROCESSORS_CONF) (via get_nprocs_conf) reflects
> cpu_possible_mask, which is fixed at boot time, so querying it
> repeatedly is unnecessary.
>=20
> Replace multiple calls to sysconf(_SC_NPROCESSORS_CONF) with a single
> global nr_cpus variable initialized once at startup.
>=20
> v2:
> - Add `#pragma once` in timerlat_u.h to avoid redefinition errors with
>   pre-C23 compilers.
>=20
> Costa Shulyupin (4):
>   tools/rtla: Consolidate nr_cpus usage across all tools
>   tools/rtla: Remove unneeded nr_cpus arguments
>   tools/rtla: Remove unneeded nr_cpus members
>   tools/rtla: Remove unneeded nr_cpus from for_each_monitored_cpu
>=20
>  tools/tracing/rtla/src/common.c        |  7 ++-
>  tools/tracing/rtla/src/common.h        |  4 +-
>  tools/tracing/rtla/src/osnoise_hist.c  | 26 +++++------
>  tools/tracing/rtla/src/osnoise_top.c   | 16 ++-----
>  tools/tracing/rtla/src/timerlat.c      |  9 ++--
>  tools/tracing/rtla/src/timerlat_aa.c   | 11 ++---
>  tools/tracing/rtla/src/timerlat_bpf.c  |  5 +--
>  tools/tracing/rtla/src/timerlat_bpf.h  |  6 +--
>  tools/tracing/rtla/src/timerlat_hist.c | 62 +++++++++++---------------
>  tools/tracing/rtla/src/timerlat_top.c  | 47 +++++++------------
>  tools/tracing/rtla/src/timerlat_u.c    |  9 ++--
>  tools/tracing/rtla/src/timerlat_u.h    |  1 +
>  tools/tracing/rtla/src/utils.c         | 10 +----
>  13 files changed, 80 insertions(+), 133 deletions(-)

Reviewed-by: Crystal Wood <crwood@redhat.com>

-Crystal

