Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F362C45979
	for <linux-trace-kernel@vger.kernel.org>; Sat, 30 Nov 2024 02:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732935487; cv=none; b=T1PRInerNLCLvmvM99wbSXdSYpOlq4JOlSbOzXIaLJLzk1gP6jKpx3jFViGPTyy5jM7ubDmSPIE594MFfkaU6gTChtmONzE7H7O6hsigfIZGnGizaI8hO12eLJZKVtBijcG30ISyH8+ghGuEoNIPJPBgnRYd04BecztoiXOXwRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732935487; c=relaxed/simple;
	bh=Nu3QewCXsIbhquPm2uAwA5tbAqEpjcUOCuz+Z230TmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OmwTyFtf5MoO4mb6xFoCrsydhPdhxZuDJpqxroj7WIGU+R64bzmlPW7yxCSe9U7FGx4kPc7EgdR+UcYon/PLuSbuCjmjk/b1qVskx8C+5HhsHohBR9HNmwU7J8xbaTYy5m79yNnUdo+to5w9DB4arqOROtlIHprTdm2w9dKVDTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YMGNJzZd; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YMGNJzZd"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6ef6ffcc2dcso1217757b3.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Nov 2024 18:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1732935485; x=1733540285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6gul2c7IY4cdIw9dvigC/KghZFAEVBI0kHJe5Zx+Ao=;
        b=YMGNJzZdFcru8eDIMDu2Gvf2k8jRb3I5ChfE9QghqzRzRLRoJIjwniWNyC6cpgPpom
         ct1UQnybsf36qhaA/CPL9a46Mdt0V7HvNWl8P+2dBZ2gCC2Vj8luebBW4cvH9o6kSd0X
         yXxCpRobkMlapbbt2v9WEVR2sgTZNDfu8gxnWpVWHwBkbYOIqZKXi+mO+CS8BTSRd2Lu
         190OE2tmLb6j9tTb/hJ51rjZLLi9WOErmennscsurP2VQXSeMoyOsrWbcZxODnbVscvC
         +yIn70xbKcaOPjhvICqHC423dDslJWPBG8S7WW3HSfk/k1/hSdoASD1aYuDlLSNHR4C4
         cIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732935485; x=1733540285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6gul2c7IY4cdIw9dvigC/KghZFAEVBI0kHJe5Zx+Ao=;
        b=b/HiEmga03Ew8PEgxfkqeCiw6QXSD6RZqRtrmwv9ADGfbz9ZaXiyI7L2F0mtXnhLbS
         JE+wabTfLb6qvzVx/u7CUj2Nnki1Jwm9J+heWSiQTTPM4FzRggCPhn+WVRBN/WDEiv51
         C+YRFLJ6ZIuysBU4Z9fwcLm23BzZaJmGXCt++1q1Os0SvE5oebqspd0kNYemUh+4HrnT
         /5pEtaDf/uDzQxIjPFnfKtFRk0HRjwk8a/mLODO8CVR2Y8BuuErZMg1ZszdQ6xi32atN
         fgv/HXR/7UdS37C6LTWij1NrYrS5gu/M7S9si1qAyum1XR7g/sbfWQR9U7q4t423jXYs
         Xauw==
X-Forwarded-Encrypted: i=1; AJvYcCWE+aAbKx40yX7msS79Z0efUWhDmYrxQ1M9oo0mx3fnVE2zePe2sEuIMZgUsiN7YzzDiHtgJjnikSFYmdThOeK/T8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YysdMimsXZhsbAE92FhMriSICjBAjLHQtxsfVVRaIwdiJRg4ywV
	HY348K47IDw/RA0WVuUcKKgd8gcfdZFo2XvFC7eh9R/E22XugbsDjwm/Ag8vkdsc3ACV8qrQvb0
	X+GtVF+a+cxemYd4oxcv+tgzNr740Bmg5HYFO6K7gG01jicI=
X-Gm-Gg: ASbGncuj/a8vsJJzFawQ/BVss0r4+78l9zv94PUgxKwLZ92i09MK5Kb5wl+g5e6FjQH
	7aW6ddhHcH3Ql4kZTffP46xh1UlebSg==
X-Google-Smtp-Source: AGHT+IHSdo4niy+RHraptwbjH++BGNhpJMyrtVeOAo+Nl9H/zbgcBZxWSyAeMnfFipAvLfo1M4hag4YesJOE8bOYJ6s=
X-Received: by 2002:a05:690c:4883:b0:6e2:fcb5:52fa with SMTP id
 00721157ae682-6ef4a0fe282mr95799337b3.9.1732935484978; Fri, 29 Nov 2024
 18:58:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128224849.3774367-1-linux@jordanrome.com>
In-Reply-To: <20241128224849.3774367-1-linux@jordanrome.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 Nov 2024 21:57:54 -0500
Message-ID: <CAHC9VhSds8SKprWxN4NQiCJ090eYk7bzTZ=yy0KOAYLHMqOUJw@mail.gmail.com>
Subject: Re: [v8] security: add trace event for cap_capable
To: Jordan Rome <linux@jordanrome.com>, Serge Hallyn <sergeh@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 5:49=E2=80=AFPM Jordan Rome <linux@jordanrome.com> =
wrote:
>
> In cases where we want a stable way to observe/trace
> cap_capable (e.g. protection from inlining and API updates)
> add a tracepoint that passes:
> - The credentials used
> - The user namespace of the resource being accessed
> - The user namespace in which the credential provides the
> capability to access the targeted resource
> - The capability to check for
> - The return value of the check
>
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>  MAINTAINERS                       |  1 +
>  include/trace/events/capability.h | 57 +++++++++++++++++++++++++++++++
>  security/commoncap.c              | 57 +++++++++++++++++++++----------
>  3 files changed, 97 insertions(+), 18 deletions(-)
>  create mode 100644 include/trace/events/capability.h

I'm personally not a fan of the helper based approach here, it adds
unnecessary complexity in my opinion, but I understand that was an
edict handed to you.  Otherwise, and within the other constraints, I
think this looks okay.

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
