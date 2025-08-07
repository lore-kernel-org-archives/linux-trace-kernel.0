Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E75242D89
	for <linux-trace-kernel@vger.kernel.org>; Thu,  7 Aug 2025 13:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754572007; cv=none; b=OAIRgCHAU617IokGWp1EhcK2OiQDkpDtcU0AJpZlWyJXN4EbS3tBY++VLx6hP+Sqg1jcP2STm6LpqRzKb0J0CAoHUL3xgBtj9BEnClXeVgYQ71N1G0NFDML79uD91elV0KAzYWtKudKidC04RiOjVaHRvgzqEYQPbZWZgYerxGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754572007; c=relaxed/simple;
	bh=ziD0nNgetzn0HxGpclDfbLUOG5bHV4f/L7luKsVvGIM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ayvC5eT9GczzqwBI+BCTnlo5wlyw3uif71B1u1+8bpBKEhgr5O+2rsL0lBOugKcltLSAiiWJzJyMrryZJZMNzGN/pRCryANWMnts7bx7v6vBhEptLcVYFQe1gTVW5k+H+LcvdjhFpI3eccF8/rLIdcx1e9ABOO0ziBSC06oBY18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mzm5PTYT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mzm5PTYT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754572004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ziD0nNgetzn0HxGpclDfbLUOG5bHV4f/L7luKsVvGIM=;
	b=Mzm5PTYTzO6AH22kvh562ZHAHTjDo6bJzrcDAiQN+P1U1L+KYGLpbRpfvBpp4PYAdlFzdk
	s8GaZBefm+CxfkGPs9vRKokUfGzAs/dPr6ZBXXKWPWHlDonR+c1L/Bv5lSuNdlqIZcGemV
	2Y82N7CgVXd5wZ4ONGPBu91I0uq2iPw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-wEOer1CMNkS0Hlv1ZiJXiQ-1; Thu, 07 Aug 2025 09:06:41 -0400
X-MC-Unique: wEOer1CMNkS0Hlv1ZiJXiQ-1
X-Mimecast-MFC-AGG-ID: wEOer1CMNkS0Hlv1ZiJXiQ_1754572001
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4595cfed9f4so4012755e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 07 Aug 2025 06:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754572000; x=1755176800;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DSIPIMT9naRgReubOEbbzM4FjlFFTRK0DZ9wbkIeIeM=;
        b=ovU+1t6QZytVoUCvz5my8NA/KHhxKJIbj8/GUq/Yd/dkC9p2mmPXPgZWwUJml6JHnj
         tt+T8XIb1jXhPAkxGuA4QhADGe5wD5qBrM4HeqKWc8cUWsCeRiQIvHv5ZdMZLCvJy0lL
         3d39Ilz5yg8EIV0lMv8gZNBLdJIUWWF78u8ZH5YmlA6G+c5kYMK1DcDeszjp/ji36NdP
         aPTSWUPbwzGqV7ZhK7iOdkvmzHWVIfW+dXlb2ralyafdIyeKzJrr7r+S93bGk81d3IY/
         w9VB357c97hV7mJcK4RvO2ik4/yGDjebgjLV1HFlomVFehCPL+bQogHKuuCou6SUanki
         WDKg==
X-Forwarded-Encrypted: i=1; AJvYcCXbbNLuDIgbT4yya4uSuVS3D0FY2UKKC6l5cw0n8QFpGihCpEs110xsJbSEEPnimQwgAHaJqk81QSneVw1j5C+cvC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl8h9X53FTTvbkAnBvkLa+suEErIQ2e+JRbK0HPpoNpRvNvOIe
	3raAcKLNdYDRsXTxx+H4a+DARCf6F1jSnYmfafZ6OaHRvMKaIK7hR5ZsJDVPWemQJsAcndih+Kt
	DLM0bCiroFxq4HQOskCPjiPE6j5D/778yUZ6zA6+mBhfmfGufyDqeFj4HICTJieEVVZAYLfS35Q
	==
X-Gm-Gg: ASbGncuxFXKV1a+nzXQS1duJW59UVKngtbU7MW3wIp04lZtzL635Nql55qJV9A+2/x1
	/947fgWEqPw1EIoyDjr7cZb8jcysilGn2yHURTpMxgv/a+4Ycbw1ZsKSWtWJ8r9GIl6DmG/ztbp
	AB7ubGvAKb3QnidUqzxtFF/zGiUcrbljzDJefOGYm9gz7OOm3TKjSqBhkRKXtuC3yLLJGZGu84n
	KXhgwYu+iI9pCau7PibLYQn5ZHlP5lgRJqaZ9nrJXXRZFgOniP36kq5Y0hRz7CLUEInWDc+fvUv
	DZ/354Ux6Gctp8eucJaJ0zZkmbkBGgeWJ/kOw/FewpezkuUpyuXhyQJ2Bwi7sjjldQ==
X-Received: by 2002:a05:600c:190d:b0:458:be62:dcd3 with SMTP id 5b1f17b1804b1-459ee85db15mr30439135e9.17.1754572000611;
        Thu, 07 Aug 2025 06:06:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvuQErMrs7pQQjbgiBrZj5Oe6HhNXNVcrP7y6W8RfdTgSKkAlKOOHrHkibb93XutcY29YK/Q==
X-Received: by 2002:a05:600c:190d:b0:458:be62:dcd3 with SMTP id 5b1f17b1804b1-459ee85db15mr30438635e9.17.1754572000105;
        Thu, 07 Aug 2025 06:06:40 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459c58ed07fsm189342675e9.22.2025.08.07.06.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 06:06:39 -0700 (PDT)
Message-ID: <6754c61d60fc161963d0625a4b647a241b363fc5.camel@redhat.com>
Subject: Re: [PATCH v2 3/5] verification/rvgen/ltl: Support per-cpu monitor
 generation
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, 	linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 07 Aug 2025 15:06:38 +0200
In-Reply-To: <ccfa5ee80e6114b046f04dc1bf1de0c4e7a11c09.1754466623.git.namcao@linutronix.de>
References: <cover.1754466623.git.namcao@linutronix.de>
	 <ccfa5ee80e6114b046f04dc1bf1de0c4e7a11c09.1754466623.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jeVd0Ix1htVtpvzgb7BBSeq8IF03rmc43BEaxMexd_4_1754572001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-08-06 at 10:01 +0200, Nam Cao wrote:
> Add support to generate per-cpu LTL monitors. Similar to generating
> per-cpu monitors from .dot files, the "-t per_cpu" parameter can be
> used to generate per-cpu monitors from .ltl files.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> v2: Rename "implicit" to "cpu"
> ---
> =C2=A0
> -static void ltl_atoms_init(struct task_struct *task, struct
> ltl_monitor *mon, bool task_creation)
> +static void ltl_atoms_init(%%TARGET_ARG%%, struct ltl_monitor *mon,
> bool target_creation)
> =C2=A0{
> =C2=A0=09/*
> =C2=A0=09 * This should initialize as many atomic propositions as
> possible.
> =C2=A0=09 *
> -=09 * @task_creation indicates whether the task is being
> created. This is
> -=09 * false if the task is already running before the monitor
> is enabled.
> +=09 * @target_creation indicates whether the monitored target
> is being
> +=09 * created. This is false if the monitor target is already
> online before
> +=09 * the monitor is enabled.

I get you're trying to be more type-agnostic, but I believe this
/online/ is a bit imprecise, unless you register a hotplug handler and
just initialise the online CPUs (much of an overkill I'd say).
What about something like "this is false if the monitor exists already
before the monitor is enabled"

Other than that it looks good to me.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

> =C2=A0=09 */
> =C2=A0%%ATOMS_INIT%%
> =C2=A0}
> diff --git a/tools/verification/rvgen/rvgen/templates/ltl2k/trace.h
> b/tools/verification/rvgen/rvgen/templates/ltl2k/trace.h
> index 49394c4b0f1c..87d3a1308926 100644
> --- a/tools/verification/rvgen/rvgen/templates/ltl2k/trace.h
> +++ b/tools/verification/rvgen/rvgen/templates/ltl2k/trace.h
> @@ -6,9 +6,8 @@
> =C2=A0
> =C2=A0#ifdef CONFIG_RV_MON_%%MODEL_NAME_UP%%
> =C2=A0DEFINE_EVENT(event_%%MONITOR_CLASS%%, event_%%MODEL_NAME%%,
> -=09=C2=A0=C2=A0=C2=A0=C2=A0 TP_PROTO(struct task_struct *task, char *sta=
tes, char
> *atoms, char *next),
> -=09=C2=A0=C2=A0=C2=A0=C2=A0 TP_ARGS(task, states, atoms, next));
> +%%TRACEPOINT_ARGS_SKEL_EVENT%%);
> +
> =C2=A0DEFINE_EVENT(error_%%MONITOR_CLASS%%, error_%%MODEL_NAME%%,
> -=09=C2=A0=C2=A0=C2=A0=C2=A0 TP_PROTO(struct task_struct *task),
> -=09=C2=A0=C2=A0=C2=A0=C2=A0 TP_ARGS(task));
> +%%TRACEPOINT_ARGS_SKEL_ERROR%%);
> =C2=A0#endif /* CONFIG_RV_MON_%%MODEL_NAME_UP%% */

