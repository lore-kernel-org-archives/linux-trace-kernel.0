Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2CB238D27
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779115563; cv=none; b=UYpoA0XjGWlaOs9drMpUOZ8YToNhFVc0KbDLIvFB8G4NYPyPvkLNI+Q4/DwOWQiIX1hzfZRQKWgds49f7/CDKzvppe+P7UKCugkHON1IA3uIjK3otTRsKWynaSQ1dXwUVj5Asq06qGYF1dWncVB23AQ2i7Ohsztg0SYAbOkgI18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779115563; c=relaxed/simple;
	bh=nR5UDrrm/Nrph88djxiatQ1UAc4/x3C+WYyR/ep/2Gk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ig1BL/T9orM6k4vaGi//Gq/BMLHMkqA+Bf4f8ZP/yh9u5NFhJnzGgZ8CuNB2WSFrPBi/rFrlnZZTTWrfeRjIItBEKIKP3BTF9PJ7bLQrUoeZ5PBOr0zhGzq3dQlJloptx2SxiiR/vNOg2ykPh6yBjYV4JQrYsSvnQPZb7e/LKzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aJw38Fki; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJw38Fki"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779115560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqrDxNmVMqx3LSQYT4MO2L61kYecL3Ss6HCoXQptOcU=;
	b=aJw38FkifO4pVBYQ3B29eLXOeDWwB8XSPYcKq4H/oBJfySWrX77ZvJyBYEVuViSxNm1ZKy
	q477O2T7Xo8d4BQZeglgHO2wyC0y1kE32lrUbia3XN+wfYSFK/i82+RP4e7HE7DlecTANW
	wbOX3iqNNPY4i5r0vjCgLQn1rclBQMQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-xRVgXlyRPpq10cziKgxVrA-1; Mon, 18 May 2026 10:45:59 -0400
X-MC-Unique: xRVgXlyRPpq10cziKgxVrA-1
X-Mimecast-MFC-AGG-ID: xRVgXlyRPpq10cziKgxVrA_1779115558
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5a526442aedso1324000e87.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 07:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779115558; x=1779720358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mqrDxNmVMqx3LSQYT4MO2L61kYecL3Ss6HCoXQptOcU=;
        b=qcFn30LS8Qjv+TVblPgFRqn3zmK1RQLYzv1AabjB5qlHNwjm4ak1l3b4RjH9fhmkoY
         4KPLeD3/ptsDP7GvQIO3nmJ2abKUCUK2e4oxq6/gM5Cmkvq1g9VGldJPGVoXrBZwytcj
         yUBrjbyM61ItsaVb1yIlLBxF3C4pocZ/oeP4e+y3ZPEKGhMjpfl3SG22PObiD334MiwK
         8ZpfaQBzR+pzOWpqwsZ4SVE2WJhqwugoT0yG488S+IYzZipaIau10PXzi5cjwqVh//V1
         4WpMb86jeppv/Phzu25J76KEtOPoPCvlcQHDjxtMrF2ygOveNwGQZK9feYylfphABQu6
         jeSw==
X-Forwarded-Encrypted: i=1; AFNElJ/Ef+XLRATPzFHVdYPQq13RNjbgeAfk6YKjL7od1yePK94YoM1zxatji2XI5yHHl9qTHNsEVxRj73/G0NncLg4c5mc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ia3GiYOpifdkmxknq7kM9KrkGLWRKNCNbAwmmKGCdqL0wWpc
	Gmem5MFEjSg5qEY2Yx3c8dLRv6d+YULzF7iulX6VsO0gFV9Wq4G+v5HxyIRh0i8+YawuykbBjNj
	BM+v5ZWoQcb6ba+z6W9H8Qq6Yst+6NLw4IEXJ6Ah2/l8iXJuZTZS1zAgY9NKHTDi+WZ8jZLZWJf
	T5r/1JRJXTr4WWHFRA5z4cCpVZixlIJCJOqnVOjIxFPyyWI1kr
X-Gm-Gg: Acq92OEiOP8KhBtcs3JrXoM9B/r3AYBkuZFiFRLykxWM+xehgpUz7HwvSRX51RPgnW4
	W0hmG5+9hPBx9Eu7f4uCWnHpOrLqgmchxVc2hfiEk/lN4TdlOt8Axk4iE3cIxHY1eAyprw2d8er
	4kRu/55ZT4i1CCty/vy+zDr9Q0WFC34suc94FZDcls5B+UccnoAsJ6qV8r8vfiZP5LNGUrhHrZn
	3iFvkjCd8gx6aglCPnKyQd2iy8LDvG3H9YACE8U6YP4GrkD0uwZj8XtW/5vnzdLKwBavNsxQZo9
	/kyWv6s7OpmM59PJlL1PPw==
X-Received: by 2002:a05:6512:1590:b0:5a8:7425:565b with SMTP id 2adb3069b0e04-5aa0e601220mr4677960e87.7.1779115557994;
        Mon, 18 May 2026 07:45:57 -0700 (PDT)
X-Received: by 2002:a05:6512:1590:b0:5a8:7425:565b with SMTP id
 2adb3069b0e04-5aa0e601220mr4677948e87.7.1779115557450; Mon, 18 May 2026
 07:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777962130.git.namcao@linutronix.de> <050ac3d7aeb1ece12a4deb91fc173de24ad147de.1777962130.git.namcao@linutronix.de>
 <agdnvQPLLiLBIxw7@wcosta-defaultstring.rmtbr.csb> <87pl2t89ue.fsf@yellow.woof>
In-Reply-To: <87pl2t89ue.fsf@yellow.woof>
From: Wander Lairson Costa <wander@redhat.com>
Date: Mon, 18 May 2026 11:45:46 -0300
X-Gm-Features: AVHnY4Ke5EVLsIji1A2GnbwhrlXj9m0UlLcNXtV6zHJ0XQwUiQbVuEJsf0_3wlo
Message-ID: <CAAq0SU=7a-aWoFxFkrgk0RbmYodK_DXrybzFkOMCtmp99=oUnA@mail.gmail.com>
Subject: Re: [PATCH 02/13] verification/rvgen: Introduce a parse tree for
 automata using Lark
To: Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GgVolrgLb5boBVudpTjIfN-U360Jj8X7lHYoFkLP_fo_1779115558
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 4:18=E2=80=AFAM Nam Cao <namcao@linutronix.de> wrot=
e:
>
> Wander Lairson Costa <wander@redhat.com> writes:
> > On Tue, May 05, 2026 at 08:59:23AM +0200, Nam Cao wrote:
> >> +    ID: /[_a-zA-Z][_a-zA-Z0-9]+/
> >
> > This regex rejects symbol character symbol. Is that intentional?
>
> It wasn't intentional. This is blindly copied from the existing regex.
>
> Let me switch to Lark's CNAME.
>

Note: there is a type. s/symbol/single/.

> Nam
>

