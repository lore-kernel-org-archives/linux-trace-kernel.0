Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2DD37C92E
	for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Apr 2026 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776000663; cv=pass; b=JlsXiHqY5fIRVEohlxGXmFutBI8SsjgY66U2ZCCDrq5CiTtp5nc0lc9YSV1V+0gPDabv8SCct8nTbAlOdrMZPz9iC5nKRYMoIP4boP6+aC+fNvCSbegZ8qqfI4gCuGiFB9Ul0lL0GkoochTonPJHME1ZbjeZB76SHCpxa/wdVi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776000663; c=relaxed/simple;
	bh=C6RY+r5Ylx4J7Ow2wiGd1LhoQuZdYHn356nitvzkRbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S05XZNZGFkBnANHAIOuC0/hDuhRle1CtmGdinYU1XDoB0cYOqNK6CQI1maw4IHa/U5WgdWPw2AR2gKEP2m29xlUMJr5c+orRJWnq/2tqBnZ1eegtnumhwBYTyevEv+37xP1Fd6pROnsk9N4JQRtkJkaeQ2Pjurvjmshw6XTmmGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cczCth2K; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cczCth2K"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-797ab169454so40715137b3.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Apr 2026 06:31:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776000661; cv=none;
        d=google.com; s=arc-20240605;
        b=YN/uhY56ylF/21MHbqJfkSpb9Tqtv3pwCLWQLesPtbrDYFlUH44IYExmTSZRpc5MYi
         OCeCb8DXPYU7lJSTIBej/0Ebgn9SwfyVof8YzlElnAfL9YsBc62prM6bvTerCwnBYQEe
         vAxPdebSBo2rrhCN0cEZSyOykMS2DyKShlhQKVkIuLkAQ3Om08XV3BqeMYLQdTRyh0Kv
         ZhCnoQCWVyCVRduqcKjDiuR6pgBF41d5AtIrz67s3xRTi2k+k7vuyGDZ7+JaWHFVktEi
         0ySVvGQ/m7Bb8MMUs8Movy54/UmnGLo7Oe+U+r0EaT4urzRLPINq2IosTjwK5Yd3Z5S1
         axAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DXgBrho6CsK2+t2aCD8rZwM6Rey4DYcpPa87+rv2X+o=;
        fh=O2wvZMAjkTs+o9OTcdBk4szBTRShJGefPspcKjddpjE=;
        b=OufM24X118tdrLcDzChATjPStlDcI0kejABvuJSj44UmohrlCp7PLdipqR9VOj+1rs
         89vdBFyZj8SdF0Ug1/l6HMj1g1/XmLo40cwzHCSD0YdvKAFehMhY3ElE+zCE5RiUm39M
         AUAAfUa3LMSoHO6sflPKvEZbjBHLoDt8eSQnmFnUg6f6yPlroDbQOLTgf6eyn61AoKFx
         oKeyrmBMPpQZWrAIWvnk6CcclKiYP/ieFJ/VMGe12mtFUVvHKkECkyXn6PNsiZlZNrwx
         j311S8H/2Hpwik9Pm473R48cJYjMe39ljrPdmOY60yyMDT9OSg6T9h0ldx3mBiAyvwCH
         ra4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776000661; x=1776605461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXgBrho6CsK2+t2aCD8rZwM6Rey4DYcpPa87+rv2X+o=;
        b=cczCth2K2sLrPD/N/YtRFYIWH/K5oQpNo2MbO63jR7NHToIIVLtbjhFkN+DrOXvExl
         Tg4QrGPYfiJ/PPNLeI1zmXFG9nQS404LC+bh0X56h+tIGRtYylTrzausH9VjXutVzP09
         Bvu5y+iKG8/S+T8XjWZu5PPy0i4bmG9PVW2ZlD8JS5cLn6w8RSKjxefOsS1TXw+qmT63
         g2HFvm7ff7qGhNG7hVfE7Li9jaYFumJHU2EJ0gq2g8uhg9XRusNlHP0QiPY/YKy7s23t
         8zJwJNPlShAA8cEQFLSVgraqOcsypIf/qt4TwZWv3Q6J8BIGZ483BshRrN4EsaG0QLFj
         PiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776000661; x=1776605461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DXgBrho6CsK2+t2aCD8rZwM6Rey4DYcpPa87+rv2X+o=;
        b=O4U+sRpXnDoduKZRMuCEi6zIHeWyU/uUogYn3Xm7sSC572ENx56u/tff7TrfmhAg3z
         L1GFck8P3KRsMr2hPzPBBDPPA4FhvoZm8poUaK8L9LcqGG2Tv1y38H7HWteNTWUpXI6G
         +0jS+owtBVlvSlcRBYagXBAGenm7ykVe3Qlv9xzcOU0KUG++9AYSNm8K1cieggvfcnUI
         iCJAERBhUvOoDg+3cZdV3cmoi/fqYbu73cQIW5S1KK4Q/0iEDyhay26NxJcDYIDwI8zh
         yLhoE/XZK0IQZg8P2SC82k9pEuj9vNqEL1keHUnClqltS+apVyNV4lp5e+lTdxW+jT3k
         CcNA==
X-Forwarded-Encrypted: i=1; AFNElJ9/anufKFsNqGp+3nNWnmA89KtvCGWKOJFhAcX+zkrzuL2BF+UIYOa1IeEj1m44PVSnjPSmM2p5IdQmhLg3oyMpjyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP5gEEvDK+jyQG5AAxIKaSiPpQc98k/pIuTuh4VCHt11y/oekx
	v1zJfe8vx0o8nZGKEZP+aJVsyjy78eyVXoOKvkW6W7YbYoaGbvXMisgctN3xntWPq5JJJVdXdkA
	RAzY+bb/KCogSKogk/uYhArcYDDwZSg4=
X-Gm-Gg: AeBDievvA0C5upmnebwEXf4IzG7EctzrYcI01edh+UDQwlATpMKkgylHEHbcTbqGp5H
	YRBjMjCX7/1LifVRy5kCGTv80WvtGS4AKMWG9ZiFJkFdAOmXzHJqZ5QQARcOfcys2rxdQ3MXBhT
	GdCJ8op5zKR1ddsMr1c5NEfCfswGdJ0bZg2zQyd+AN+AeAN02dJKy9WhS6vxl7HjC67OkRjt8FC
	4vZT9zhz4+b3qI602iQZh7X13iDzBHzF6G4gb8yeuJk7CKWQxN0rdno7AFFuQJUSuHi8alVh+O9
	Ld4SgxthvLVZYh3QsNF9YSAggFpnTP/R/YZGjjFo
X-Received: by 2002:a05:690c:8e1a:b0:7ae:dc4a:ff6e with SMTP id
 00721157ae682-7af702dbb9dmr92247417b3.24.1776000660995; Sun, 12 Apr 2026
 06:31:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <CAPhsuW7Y5KksWM49TrGH_Hohaq02XO8qs7G99Y6D8=0usLFSrQ@mail.gmail.com>
 <CALOAHbDG8=eUV53kF+xn=izs2rpydCk=a9RznU-EEOzmkB8mQg@mail.gmail.com>
 <CAPhsuW73qFybHgOnZ=oFC1PvdWkYWDk7gsAoiBXe4xWYagPrmA@mail.gmail.com>
 <CALOAHbC0hqk+yrUZay01EBRNOHgyj1MAavzNK-06XJKK9ARMqQ@mail.gmail.com>
 <CAPhsuW5MN6ikKmxgqby5RJ3_gvjJ4B77X74OvfbTQoFO8iUgzA@mail.gmail.com>
 <CALOAHbAmTAfamStF9sZtO6efWYJ1sbXJp3PbsVapZf7dba91ig@mail.gmail.com> <alpine.LSU.2.21.2604091205250.31526@pobox.suse.cz>
In-Reply-To: <alpine.LSU.2.21.2604091205250.31526@pobox.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 12 Apr 2026 21:30:25 +0800
X-Gm-Features: AQROBzAhZ7uy9uCOnehpJbZd9tdZu27AddmcCPfaAwa94iQun-8NAS1qnJVKEUo
Message-ID: <CALOAHbC3-_zW2CbHccy8kCzuBj0x4LeraeEt5DdUV=CdrxCnNw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] trace, livepatch: Allow kprobe return overriding
 for livepatched functions
To: Miroslav Benes <mbenes@suse.cz>
Cc: Song Liu <song@kernel.org>, jpoimboe@kernel.org, jikos@kernel.org, 
	pmladek@suse.com, joe.lawrence@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, kpsingh@kernel.org, 
	mattbobrowski@google.com, jolsa@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, yonghong.song@linux.dev, 
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 6:08=E2=80=AFPM Miroslav Benes <mbenes@suse.cz> wrot=
e:
>
> > Can we add something like ALLOW_LIVEPATCH_ERROR_INJECTION() to allow
> > error injection on functions defined inside a livepatch?
>
> No.
>
> I am sorry but you always seem to find band aids to your set up and how
> you deal with live patches internally. While I can see that something lik=
e
> a hybrid mode might be useful to people if done right (and we are not
> there yet), the combination of it with bpf overrides or anything like tha=
t
> is not something I would like to see in upstream.

The upstream kernel already allows for combining BPF and livepatch to
override functions. Song=E2=80=99s patch offers a great reference for
implementing this without changing the kernel:

  https://lore.kernel.org/bpf/20260408175217.1011024-1-song@kernel.org/

--=20
Regards
Yafang
