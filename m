Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D3A308F2E
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Jan 2026 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767787430; cv=none; b=r2dMOKD/3vB1J7849/Ho0MPOhroG1re6qsYWR+h7rxB9Xtk3H9iyuTn0Mo909C0OsoE+fmiSUUr0DG9SY3PaVxAIZ4lxmMlXVdc4/ALDc+5TupLwTh1jS2RBQllswO5Mv8XzLo6iCkho74NEY88IatN5ci673Ww7wOCOR5h4xAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767787430; c=relaxed/simple;
	bh=BV3qLeOvMcaNZVUP69c1YtN/wbMYGTCv2M+gokMVuCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZZgcl/VWUaSLcdYJ0oFjx1RxPDs8ZQcGhOjEGZ2zPhyyt3xXUOy/JOYVTfbCCx5nvinwV/jbMBqoG0yrOB1EPpYyOg/JLCKtNcjd2XKmw1heTz/aNk7VZ0X+COZEntxXD/CeVDzVhxHrqUHlnc2dViPUW9Qze8/x1+uyTto5rro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYnZvUEX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYnZvUEX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767787427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Al4OPVFE0mOhMlBb5QMwhatYcqi1Bruqbnv2tfRXugQ=;
	b=JYnZvUEXVk6pNep+DZwPixVL3bVstefCdmO5duvhTzef5+WMZjQ+iEQ6Si8Ph1m29P9Jfj
	+vKGCzVgqnxJPzBnM5I8Tjj3OMjwtMu22E7zaqtiNsFr5J6TZt7JeaG40BrcOf6sUuFtjz
	lYFiVgU8LSKDt/14UDK8y29Fr06kAZc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-Y4fQthFOOO6hCLjiheEatw-1; Wed, 07 Jan 2026 07:03:46 -0500
X-MC-Unique: Y4fQthFOOO6hCLjiheEatw-1
X-Mimecast-MFC-AGG-ID: Y4fQthFOOO6hCLjiheEatw_1767787425
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b7cea4b3f15so313506566b.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Jan 2026 04:03:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767787425; x=1768392225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Al4OPVFE0mOhMlBb5QMwhatYcqi1Bruqbnv2tfRXugQ=;
        b=byItMtSnNHa+Btg/g0VbcnNbWCm+uNk0E9ds9gl56mHoHDwFy8qDQOYCg0cI2+PGM1
         YJPHjPRaO3F9pVEfHeOnGgDBhRT1ttcl2BxrQNMYa4wIFOmatyh4asxM3wqb0s2t7PCj
         yZIjRTIOyYU9AYNDIq1oyWXQNBroGCCYlbac11fAhT9f/VT6R/qlegc+izc1sgYPjMkj
         GGe2dfLepbr2FenjDYvRU/yJlRwUNz31w7L4twY7nfKOPQX6p1MF1mb8qzWdyimFbfiO
         nu8pAPRlLSVJWDijRAixc9GyMhPiYp1VGgU0W0r8pfCQ1j/r8ZyeSyXO78aWPs+WF01N
         uRyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUASHZo/9RuYgoz7mAmHYqk85AWMSHr1UJwjscnc6JXPOcwThUC5eVHZfZkTCdASyuIUT5kMvCGaHkHx6Bormv0P4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL7JLKXSXDdJJq6GsOvGrUuQUi9zDtFXBSpsegMMylVcKfjiRD
	QSlq2i+FwAYxCuE7PYTWXTjgowBBS57CwJzT+tGYARpOtKA799hL8Y229o9f+e7X3uumjhzVUel
	gNGovzKfAJJaWlMVIaPA6bWT4OpIr83BJ0Lxl/ZQFbo1K36Mg88YAUoBdQbJD0GX1VkhTXGK3Z3
	YdcYuoPHTuS9ugLmTrq8L6UMXxwMS8lrOw+2yuqiLDjoBJDiTb
X-Gm-Gg: AY/fxX6vmbEAu9jpaOCWhdu1IhrhEMR+d14S9lZVpC6+c6CFWM2KpRbyZRg8czKZ/Gg
	GdfhHhm7QNnwloGlX61K71JkD0Ez/IhFuvseXgi8PLXXqWeTNbqlk/Sc9iaoid6sAXJQP7bbCpw
	0xPBiOEX19n4q80lnkQmhkdlsujAGHioRpu+AZcLtsFmsXRgoaMU16ZTE0qvPeDdkRoVpCsKrVN
	Yfam2inQb8tQgBbXpn51QHA
X-Received: by 2002:a17:907:2d2b:b0:b77:18a0:3c8b with SMTP id a640c23a62f3a-b8444c4d2bamr194806866b.1.1767787425336;
        Wed, 07 Jan 2026 04:03:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEc3hhh6pev/A+PbACCMi4+m1wjCgaQ133+hHqE1gnCXiQmaW7gjia4wxOa3u0Bbnghah13U2BNLs8CltmHlkg=
X-Received: by 2002:a17:907:2d2b:b0:b77:18a0:3c8b with SMTP id
 a640c23a62f3a-b8444c4d2bamr194804166b.1.1767787424908; Wed, 07 Jan 2026
 04:03:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106133655.249887-1-wander@redhat.com> <20260106133655.249887-8-wander@redhat.com>
In-Reply-To: <20260106133655.249887-8-wander@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 7 Jan 2026 13:03:32 +0100
X-Gm-Features: AQt7F2o7jlt0YO3V4XYuBaar_aNRy0h6LrccZdVcN1LsGdXmgJoS71bsNR4IS3c
Message-ID: <CAP4=nvT2oPtM73nfPkSJZ4612mcAPw1LWbHNrszFBVAmSJOVbw@mail.gmail.com>
Subject: Re: [PATCH v2 07/18] rtla: Introduce common_restart() helper
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T6feyGSWTZ9Ey1m-ndR4vfGEEoJKHrwJSHmEInZjhlU_1767787425
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 6. 1. 2026 v 14:42 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
>
> A few functions duplicate the logic for handling threshold actions.
> When a threshold is reached, these functions stop the trace, perform
> actions, and restart the trace if configured to continue.
>
> Create a new helper function, common_restart(), to centralize this
> shared logic and avoid code duplication. This function now handles the
> threshold actions and restarts the necessary trace instances.
>
> Refactor the affected functions main loops to call the new helper.
> This makes the code cleaner and more maintainable.
>

The deduplication idea is good, but I find the name of the helper
quite confusing. The main function of the helper is not to restart
tracing, it is to handle a latency threshold overflow - restarting
tracing is only one of possible effects, and one that is only applied
when using --on-threshold continue which is not the most common use
case. Could something like common_handle_stop_tracing() perhaps be
better?

> +enum restart_result {
> +       RESTART_OK,
> +       RESTART_STOP,
> +       RESTART_ERROR =3D -1,
> +};

Do we really need a separate return value enum just for this one helper?

Tomas

