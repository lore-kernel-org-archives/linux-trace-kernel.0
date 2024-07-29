Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B0E149C7B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722258005; cv=none; b=JLUKSUdNLNmrm4ISz3f+Of9gAf05T2v7IhpbpnYtotSQyp18iJ8X0CAEMRXYXos3e9Xos8XQIRGur9xeCc2oKYMrpuLI1S+NY1O83thSbbHXmMTGxDNRayofew+0wGU885QIHMj+bQAA1jTmSUz5Ig6X2Qz6CFJs12CJAzCTdlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722258005; c=relaxed/simple;
	bh=iyhMtCj+2ug3HhoQzLL3MI2M8A3X8GrsNcqfvZ9UIiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YR7Pex2Uj5LwKImbT7F8j83cJjfiDJx6JW7tv9WhQUE4xxqL5FtVGGBayc1NDHJJD2MHbZTLyFRO8+u8O/d2bCdHOv9eWBtvZ8oNGRYwFkDnB+VJ8FaurGbE1AQz7Eq/vZR5Z8aSsY6rVgt0JwMX2fycrS0z4juPJhKbqFV71Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aiBfOjPZ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aiBfOjPZ"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52fc4388a64so5737378e87.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jul 2024 06:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722258002; x=1722862802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyhMtCj+2ug3HhoQzLL3MI2M8A3X8GrsNcqfvZ9UIiU=;
        b=aiBfOjPZZZoN1/w5Ki2V4y92xSRQk0g7P0kaTqP1/H1gsmaUOILHtxVJVF+TjB+Kyc
         crWkRASabvimGzeXhjVUbrNCdec93ls+swwatfXbCUZYhVqHpwZPOgt0GqHlNl5/FOl9
         F0TkwwRoqVqkhB7dZTDEm0HJtGW95P77KQcY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722258002; x=1722862802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iyhMtCj+2ug3HhoQzLL3MI2M8A3X8GrsNcqfvZ9UIiU=;
        b=E4H6mk/vH4jlOALFBVgG8qluz5hpsfX+s2OtcExHPcEwE0IJffZQTFV5oyIHeStM9e
         8mVDaST+NY02UcI1CnZxwq04j0DLxpzaS/ob4Aqs1UueQC7nWa4IeC8+Lt3B7b8BVRiH
         G06bKZyZmZrtZMGNJWZZ1cVpU0ntU0n9DCsLJ96BmO/pslWPP25dS50fNr6PU+uYpPP0
         t1TGl80ZVQ9OcUZNQtEsRcvR1F4dqi9O4yRsu/ZQKokhq8UD7Jsw6a9P/e5zFt67i5+D
         MDN9Gk1xu/kMw7bsqdgMwGNXwhvUgvzdEQ5KFWJfTURS8RfiVtcw6frbrhnLkjzbPNWl
         IuOw==
X-Forwarded-Encrypted: i=1; AJvYcCVtGzGrWww4fn4Cz3Mg9hNZypPAie3STepTG9dLPvVcIwJNvMD+InsWTuENBjhwcynmFPpDBY++2LNhnxkAAfZCDLY09Opsp5UW72l7KoFHzgHs
X-Gm-Message-State: AOJu0YxOzldVLQ44HNEWZU9yR4+WAqrjGK9kK/vcjR4TM+LJNhcOKMiM
	NNjNFDtr/ljLNbLhrilornBOedBavkJA7YixCMKcOh/f6iSh+FHIAFNM+ll+6QDYsbJfVxWO8ic
	vUX1jN4FGV6+W96ip51UfoVipVStqKlVBV9QR
X-Google-Smtp-Source: AGHT+IErnIW9gMUrEfSZ991mf9g4mdjcR9dgoWOZFwNbvCiRLPFhTkxLVHvFqQj4f+dAKocJUgn+Hxy2jFfqs0TTSH0=
X-Received: by 2002:a05:6512:487:b0:52c:deba:7e6e with SMTP id
 2adb3069b0e04-5309b2804f1mr5059532e87.29.1722258001356; Mon, 29 Jul 2024
 06:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725201517.3c52e4b0@gandalf.local.home> <CAD2QZ9b7=Y_x6o6R2UGwDRCky522A0fbiX_BxrY9w2LPyd=0sw@mail.gmail.com>
 <20240726120337.40e77833@rorschach.local.home>
In-Reply-To: <20240726120337.40e77833@rorschach.local.home>
From: Ajay Kaher <ajay.kaher@broadcom.com>
Date: Mon, 29 Jul 2024 18:29:49 +0530
Message-ID: <CAD2QZ9aFHOTLSryw88PKdvXBQaug9di=CDQ9KjPBhuOTNhjxTQ@mail.gmail.com>
Subject: Re: [PATCH] tracing: Have format file honor EVENT_FILE_FL_FREED
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mathias Krause <minipli@grsecurity.net>, 
	=?UTF-8?B?SWxra2EgTmF1bGFww6TDpA==?= <digirigawa@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	regressions@leemhuis.info, Dan Carpenter <dan.carpenter@linaro.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Vasavi Sirnapalli <vasavi.sirnapalli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 9:33=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Fri, 26 Jul 2024 18:00:18 +0530
> Ajay Kaher <ajay.kaher@broadcom.com> wrote:
>
> > Some doubt:
> > Because of the same race condition, it may happen that kmem_cache_free(=
file)
> > was executed while f_start() is waiting to get event_mutex. Once
> > f_start() acquires
> > event_mutex, it will access the *file which points to the freed cache.
> > I am assuming in this case KASAN will not show anything as *file
> > belongs to cache.
>
> No, the file is freed by the callback from eventfs when the last referenc=
e
> to the file is released. That is, there's no more references to the files
> (nothing has it opened). As this code is only called when the file is
> opened, it will not race with the freeing of the descriptor.
>
> See event_create_dir(), it registers the dynamically created directory
> and files. It will also do call event_file_get() that adds a reference
> on this file/directory descriptor. It also registers the
> "event_release" function to be called when the last reference of all
> open files are closed in that directory.
>
> That event_release() will call event_file_put() that does the final
> release and frees the file. This prevents file from being freed while
> anything has it opened.
>
> While looking at this code I did realize that the "format" doesn't
> register an "event_release" and there's no bug with its data pointing
> to the call with respect to freeing something it shouldn't be. But it
> still needs the file pointer anyway so that it can have access to its
> flags.

Got it, VFS calls the callback tracefs_d_release() -> ... ->
kmem_cache_free(file). And this will happen on close of the last
reference.

Following is not related to this bug:
event_release callback executed once 'dir' closed (no more ref), any
specific reason to register with 'dir'/'enable' file. If not, could we
register with the 'dir' instead of 'enable'.

-Ajay
