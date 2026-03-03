Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AFC43D4FF
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Mar 2026 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548722; cv=none; b=bJkvrLjbmPyJKOvvxduh4uL003Z0V/LxCXLt3zufuISsZusdL9ws/cnE6OJuakhSwQOkVdX4kqTJsW+z2EaPwh4+YuURUXzo++l9/02P+Yox1EPkzN1uaVB34AZwnux6RjEUFchgVdHrLXkyXcJAEUID5rIzIBoKpCyORPYYPK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548722; c=relaxed/simple;
	bh=eePFz1p6AQfK52Dfp6nhDG5PiFLOvEXjAnIw4amVPCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvPlrP81NFpLd9j+lEaERcqHUIj/lDzga+zeMDKstsDDAqNDK0rhgDVxrHJynD5F24DZRYNOtxEGFrD+3auikcCX1MfzW4DYFZOwLpW5GvGN9JXjodzI9UgrPiHZ4AhDTwUQnK4EU2ihiVc78vIZEVftWgm0zNLojKYkm8mD88U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f4P03egJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4P03egJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772548716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uByqIUprBRkKO950etTatx08ahw/9qF0/t4J/O2bhx0=;
	b=f4P03egJWsHCst/2UaMTJXF8I3kM0Xj3rTbTA+varKlydu3WkZB72aCkzJIUFb0rYmgfm9
	8czbiUXegJ60zlUjlDg9BTVBsqSTgpgfWBp27uv5KLCXn5sbawnSN2eNfZCMArau71Mm6B
	uLLr+tuaJrnt9SSx+shP30X2dfcyUNE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-zbe4PLghOJyPGfvMxTRBCA-1; Tue, 03 Mar 2026 09:38:35 -0500
X-MC-Unique: zbe4PLghOJyPGfvMxTRBCA-1
X-Mimecast-MFC-AGG-ID: zbe4PLghOJyPGfvMxTRBCA_1772548714
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b8704795d25so374747666b.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Mar 2026 06:38:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772548714; x=1773153514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uByqIUprBRkKO950etTatx08ahw/9qF0/t4J/O2bhx0=;
        b=SW9QLGRXeYdOfajNWvgTysvme1+dQdONQPeFH96DTlAdfgvK6/EIaIwFtZF36/Q1Uo
         7BlDeoQr3Waof2Wm+WOk5bHV/gR15c5S7M2huGbYSFX2FImh20ifSDHZBvbefc3+zD8r
         dSc5QMaw0aTHUfhPWN30IazWnVlfTHj9VCBE2VY/Lc/fz6lm+rOPxUIOBEmk2C3lAXy5
         aIrQjg0ZHXInwJ+vXDgqY3P9rRc98joAHqrkyEra7n4COq+S448A7mPqTwOwsOjnZIrz
         iKLJ46qWSpVh4zcZgVKntgWw34kyRYX2BJdDD6r7tjmowDZ8i/VnKoqlNWxNxct9n4te
         WK7w==
X-Forwarded-Encrypted: i=1; AJvYcCWAZRwexHkwjxCWptmXNEMfzQXILZX/DLTKrgCgEQMIJxfJdShq/PB3znHUI7wU+/w3iD3/Q2zn+CIsrLchQb49GOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4jCRaU8A9RW2Z1wXZArA+3BaeFo7ZsixR/+Lg3eArDAlxhFgz
	03aTUQ+AS0A3sjPO4s2fgCjGQFh8nvJpRQqMtzf1socgB6qpzDVqV52atY6nPzi4TpK3AU+FwrW
	ru9HEkDOUhNJfG2zAL5c7DqO8d3IYMPBC4vKL0EqtoegUsQbJyNt2tPsgbgBPS87MeF9wyoHHub
	0mOUiUX5tTmBAxDzIoOVc0iqqS8oMdOACuAFZiJKklfJwAhwSt
X-Gm-Gg: ATEYQzx5snWBdS/bOINhxDQI8UOt2mv/2gMCc8E/tKowPzutlJa1+4bhGvQNy0u/gfA
	PLQqzQKl8kMQEw5hmFl9PTSOhAzdkntd/w3lrGzslr13eZDuMHxTQ+Opv3YbKTCM0ZxtFMVmLRX
	1syHJl+kHbYNsQrJ8GmovnNN9Bg7ejpdiBLmbtpW5MeWRPQVSrwqe2AGSJ80gik1FP88c4CVQMN
	58GtA==
X-Received: by 2002:a17:907:a49:b0:b87:2780:1b29 with SMTP id a640c23a62f3a-b93764c7e7emr902976166b.37.1772548714049;
        Tue, 03 Mar 2026 06:38:34 -0800 (PST)
X-Received: by 2002:a17:907:a49:b0:b87:2780:1b29 with SMTP id
 a640c23a62f3a-b93764c7e7emr902974266b.37.1772548713579; Tue, 03 Mar 2026
 06:38:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115163650.118910-1-wander@redhat.com> <20260115163650.118910-15-wander@redhat.com>
In-Reply-To: <20260115163650.118910-15-wander@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 3 Mar 2026 15:38:21 +0100
X-Gm-Features: AaiRm53Eu2RQAmILp0LANpphIwNNYI7ejb-zkRgheOkvXJcE58fh1F24u7Tb4FM
Message-ID: <CAP4=nvSyD+hYdPkXQ9P0KPLw0rESh3A9Nr0su1fvkTAJfAOxzw@mail.gmail.com>
Subject: Re: [PATCH v3 14/18] rtla/timerlat: Simplify RTLA_NO_BPF environment
 variable check
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Daniel Wagner <dwagner@suse.de>, Daniel Bristot de Oliveira <bristot@kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Xk3HU4-shPEJYukvjNJUXSaFn2b8-8-uUuS1s_ukZjc_1772548714
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 15. 1. 2026 v 18:29 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
> -       if (getenv("RTLA_NO_BPF") && strncmp(getenv("RTLA_NO_BPF"), "1", =
2) =3D=3D 0) {
> +       if (rtla_no_bpf && strcmp(rtla_no_bpf, "1") =3D=3D 0) {

Another use case for strncmp_static()?

>                 debug_msg("RTLA_NO_BPF set, disabling BPF\n");
>                 params->mode =3D TRACING_MODE_TRACEFS;
>         } else if (!tep_find_event_by_name(tool->trace.tep, "osnoise", "t=
imerlat_sample")) {
> --
> 2.52.0
>

Tomas

