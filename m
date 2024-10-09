Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE27681AC8;
	Wed,  9 Oct 2024 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728486239; cv=none; b=anL740U7weGtgN4FsRUdGVF/nan1Cxb4a04ONT2fhXnlk08qO8GFlPcbx2mjiB2RzJT7zXvxG34c7EPRON3w2QLGIN6+OAvvdklxqu6x9vq4A4jY7kc0lCktfQkeeXtkitz7gJQvWQOEsTyQsyAoEhOmnVAwG6ioKBbpK1oFBFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728486239; c=relaxed/simple;
	bh=faco1nLJgewCs4LoQGBTqoDES80pvIUKX3coBEZH6/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grdgQeHi4f8EeQqYJPmBBKJOtroXx9khVX54JB7iJogEA/FYDyZiDV2+LmwcHTMf5A/rCyBBVbz98lxoER6jGkdcXsJcizuEKXXtwSkc/efGhCYNUnBiFPQQaIRG3TgPyQjDZya05cZxs25K77mYUAIJNNL+n1LVg6NMfVmVab0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i23gUw4d; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i23gUw4d"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a99388e3009so582541666b.3;
        Wed, 09 Oct 2024 08:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728486236; x=1729091036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+Gl/m+FJO6FhGFh7EFmgpJVIIXmrUNagrx2cXMjBAE=;
        b=i23gUw4dX0ZrB0NQNilzgmf60apKGy96vx+x/TJJABhwKD9QiEHcXViUKhgQo9JuOo
         n8t9Z1Jef+qW0A7jMugNPLU0f44NZZuaBJxCaaE8eSNfxo6cdnjSaHavj5f4GZAftMvx
         qcTA0M0wXNBil4SZW/hN0DeoKgtBN20vT58yxhLVK/5uxTpeJutFKOTCHwMOJpshPWj9
         3voW+m2Ok/zrD9kOgUTgrvd81xaQf7+/mKXfbEByfXDqag/USTYwUSCzxEgZQ+nA8259
         lvgHP6qxNOMF7jD47nPLJaVUXnL6QHMVgI8h26N0XKCgEusrj1Z5UnowsJypAgN/lUS8
         c8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728486236; x=1729091036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+Gl/m+FJO6FhGFh7EFmgpJVIIXmrUNagrx2cXMjBAE=;
        b=fdVKxzGkbGy4/+7a6T5aVpxKtSDY2Ew4SdqHmQ6XXLfc2uwgtXSl1lYiso1wK4g8JC
         TapGM6gMs9axNEEeckMxN7Qxvp/jYBcFK3/4KvWvZmfRaRwP9MqngmOXsWQRmHQleN5O
         iKOZrs9w+CGtn7Gajkkk27acd+EXiDueoDlTqjiPzcWrRxNdBUz7jGLD18gp8RQnNDr/
         c5hwSdLGao+3rnm5pW/LcVm+dFIndTZt1ct62XARpBXYi7DAdTlF8fYbfls9MxYqtEAN
         5Zxzj6U+qG8dD9YsUZ7sMf9mOl7sfC9EmWmq6Ke2liIMS+aSPVGKwRALSg8Mx4MiYtip
         IesA==
X-Forwarded-Encrypted: i=1; AJvYcCUHYAaxUhAx8gUNxicraXyx1bAULC+BEu23p9tWTgXhSgrGjimFEGWiFq/xaN0V4f9yhULRDFz1Y+KNQS97lDrpV7T2@vger.kernel.org, AJvYcCXFtkTT+6JVpiySY5bXPvk9+gSYho+Y8NpC1ArHKGFqQjh94+gMkpYyG+/vvGcNXogU65kK6cq5MOfO77M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGa6je0R3KWnzWTT0jM1ia0Vi9tnKjDUhO6PdqLkf7ZNMekPS1
	lCQnR2Yebn2MluklpHwFLdChkSLwU5IzEG7uH26rFfzFzEfO+Fd08bWFFdEqet+grIQLAJR831G
	qgjaZl1ZghB2l0+hzuSL7vWG4qhc=
X-Google-Smtp-Source: AGHT+IFSNXnDoEBt/LzuRbAPFBZw1Awvp1SI/kYiOaX45DzlreMR+aHMrG2g2hoB2DsPt2cNYTQ7S712YZsOJmYURGs=
X-Received: by 2002:a17:907:3e0a:b0:a8d:4d76:a760 with SMTP id
 a640c23a62f3a-a998d207656mr278521166b.35.1728486235824; Wed, 09 Oct 2024
 08:03:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009030340.16400-1-dolinux.peng@gmail.com>
 <20241009093727.4e99c1e2@gandalf.local.home> <CAErzpms1mGeBw364qsX1YV_4=4sPhMhTRsWsjHZmH8Ro5xWoyQ@mail.gmail.com>
 <20241009104556.333bca30@gandalf.local.home>
In-Reply-To: <20241009104556.333bca30@gandalf.local.home>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 9 Oct 2024 23:03:43 +0800
Message-ID: <CAErzpmveL_vVFBWfdJgKUbtnqvJxWd8m3qckvb2MYJxWBF9=VQ@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] function_graph: Support recording and printing
 the function return address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 10:45=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 9 Oct 2024 22:01:51 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > > Is there a reason for the resend? I already have it in my for-next br=
anch.
> >
> > I'm sorry and I did not notice it.
>
> You were Cc'd:
>
>   https://lore.kernel.org/all/20241005191308.384922133@goodmis.org/
>
> That's why I send these out.

Thanks, this issue is due to a misconfiguration in my email settings.

>
> -- Steve
