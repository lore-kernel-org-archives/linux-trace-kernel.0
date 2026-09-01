Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8A54314AC
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 13:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269577; cv=none; b=mWicJVAoTPhH2NHxA62uNlP+qIt9HgpVVFheNw/YTFOazzjhAmQYjeY8ChDmbC695kZVjnIY6w+vCY6JEqljmHx2j5NHwu2OjLF6mKmESpdWzrcds/bcZVyrUqNwG5+W90Q1bJKQiV/C8cWEvJ+27BKqojiBWDyX4C8yQAK7sDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269577; c=relaxed/simple;
	bh=ly3q25r3+vuOvHlPFlKMbatqNBbcpeWd+JAJ9yLp61A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L9c8IfjJ714SvkZ5u20fWSR4UAP6JfmuUWqIKN2LGqc/bE7+eY0T7zyU4+5onhyiE2iKnc3WA5n8R+ZnCQmK90aA7v7OgGng1s1EmffrF1VMuvGzRh+NGgSC+B/rtHnxRp1DJJodxcMVghOsYRpk0hHJhLzX+jx/XMDz7nNXuZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ExerRsuC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ExerRsuC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788269575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OO6nbsjJP15HB/PMZfo3LzLmtqH1tOSFn2qFQJtQehA=;
	b=ExerRsuCcCl+HEPukmCsuvulHUGfbnCaLa57H1XhXgB+I+u3CVG/VCaIhBvhd9j85SltG5
	SOAehm/zEcSVt4lS127AKmFdimahZGMkpb+ZWYzlpIbL1BnJrxAT7tTeGmvk73USUooErk
	D7XCCbUDnMkPrZ9PsztzeOSTXvaHi/4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-KC6E1Mu7P_eDEdTFZ9rV6g-1; Tue, 01 Sept 2026 09:32:48 -0400
X-MC-Unique: KC6E1Mu7P_eDEdTFZ9rV6g-1
X-Mimecast-MFC-AGG-ID: KC6E1Mu7P_eDEdTFZ9rV6g_1788269567
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c25501f4aa2so130366066b.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 06:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788269567; x=1788874367;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OO6nbsjJP15HB/PMZfo3LzLmtqH1tOSFn2qFQJtQehA=;
        b=VfUylYRlMttZDEDpmih4b2BNi6o0sU6bXNWqpmqt/8jfMNN7tV0MRm7Pm//FDIBU51
         BjfnKUtiFzQzjPh3Au71Ux35gVTYQVAvU/VidglAb/zjuuwh2C34WJlNEYnhzOcyVE/G
         UIQEBPeomoprIF5FJYfR1Z2+v4/WR19v2LOl60VW8h48n0DPBppwQR9CbdN3ypTQ2C74
         LJmR5CSgYUIb/VTlmX5wt6iglGe59p00KCl0dVOHAVTWVPaImIctLCaghspkkrFItMrm
         wIH/fF40OmWIdiMmrn17gCL60f3krqONo6i98drmT2eJ17x7JI0mqpZFL76lcKaFfMzK
         FX0Q==
X-Forwarded-Encrypted: i=1; AHgh+RqCNKzdrosk/wp7WUwJ16e6G7kkKGxV2b+UvxG4RATYUNjPkqLMW2Qt4h8EOEqVX92LQCqZGZFw0aahSzyq6NzCaX4=@vger.kernel.org
X-Gm-Message-State: AFuF++k8unaqtCD3KJGjwChkzf8dlEoJQq+qCMLJektfRAwfjSwu6OKT
	gM6zMAJUBAVqJazqoPPAGEnUmpgiGJHwP+7HVZ2FNsfWfvnrqT8wQAE2baKkgqpeOIihQn03hjB
	3LuH7cUlsj/l/rFRG4COWstwhijHZ0KHWuhQfn+2YnmxcOvyJo+W2w+RpzH/4tCHGoaRX7swnu+
	uiBz2/L0Ls0+zxUhxBq4AWpa0DvNqbZMWzrdIWkH6tai8jPH9EFkUVNVSM
X-Gm-Gg: AYBFou27DW1LiZrI0f6cZxbnYLC8CCZnl/ulX9hz6R2gJ++8tH99bj0t1xFLzi3ugUO
	jGPqYOGvgOrH7sUe0XAvUx651fvWiJlShzVvxSlVmc2oKnO2wcoKbFlfoyzUqTwINk9vpKXv+/O
	QCJgSxk/cDUt4WcFyeWAA2YgxqacoR+4ZyaFuDPqua8tsFND10hN7oWoiY
X-Received: by 2002:a17:906:2081:b0:c25:c678:ff80 with SMTP id a640c23a62f3a-c25c679627cmr100011766b.2.1788269566734;
        Tue, 01 Sep 2026 06:32:46 -0700 (PDT)
X-Received: by 2002:a17:906:2081:b0:c25:c678:ff80 with SMTP id
 a640c23a62f3a-c25c679627cmr100007966b.2.1788269566258; Tue, 01 Sep 2026
 06:32:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824211544.3984835-1-crwood@redhat.com> <20260824211544.3984835-2-crwood@redhat.com>
In-Reply-To: <20260824211544.3984835-2-crwood@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 1 Sep 2026 15:32:35 +0200
X-Gm-Features: AcwNN1UADGsVUoF7vM6JEtFwVsLsprF8Y8qfVpTu_opKmQwDSHGmfBv_884cNv0
Message-ID: <CAP4=nvTE0YsxMUTJuC2uT=T-5TX29JDZ1axR6nZBP7XjMNV0WQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] tracing/osnoise: Per-cpu mutex and fd detachment
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	linux-trace-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CarYx49KrzqoyAgwDzUmJ9-hw3L5QxH4hf64nDHeXAw_1788269567
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 11:16=E2=80=AFPM Crystal Wood <crwood@redhat.com> w=
rote:
>
> Clean up a variety of synchronization issues and related bandaids
> by having a per-cpu mutex that guards changes to kthread, and
> fd open/close/revoke.
>
> Replace the SIGKILL hack for userspace timerlat threads (that doesn't
> even work, because we don't wait for the process to actually die) with
> a mutex-protected detachment mechanism.  The mutex should be uncontended
> during normal timerlat_fd_read() usage.
>

I agree with detaching the file descriptor, that seems to be the right
pattern. An alternative would be to make the user process to block the
tracer until it detaches, but that would make it less consistent with
kernel thread mode - which owns (creates/stops) the threads - as well
to make it more prone to locking issues during user process exit.

Can we perhaps clean up the synchronization issues without using a
mutex? If one thread is switching timerlat between no thread, user
thread, and kernel thread, it could mark the osn percpu structure
"busy" and reject all other switching operations until it is finished.
As you say, the resource should be uncontended during normal usage, so
the user shouldn't care about being returned an error instead of
waiting. Or am I missing something?

> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
>  kernel/trace/trace_osnoise.c | 239 +++++++++++++++++++++--------------
>  1 file changed, 144 insertions(+), 95 deletions(-)
>
> [truncated]

Tomas

