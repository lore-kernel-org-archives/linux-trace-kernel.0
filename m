Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB432263A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725004; cv=none; b=WFr37uIHLvIxQ+9iPF6R9V41L/5onmzZtddvt/pv5QeGXITTza77NdI2Q9RbwqD2bPJke6xX20oYSCDMhqoRJZoLsnR2TM2BDwgX9Dcpa+8LHXFgWfhzIlPoCSLzcej0iVvqT8YmTqPrx77G2NRxhLMbaoGi+s97QIjQtf/iSmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725004; c=relaxed/simple;
	bh=MEWdl0tqnkjxn0t/wprGhWa8mDGC5ARyeWTuu4/vhE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TmwfGxa4ZAYpaTkgImRi2omVCxF60i9D+BT1LRUXCRiJ7C+S/l/bIpUQsXlp2bcGTDegW0sqSAdaON7UjUFCtCsjBQ29znpqbBHVI722yHxsnKJ67vwscY5NT5B2sSS4B//JLhLtSFyB5wOgsx2mk1+S17Cux8AuHcHvf7eCCmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DN/06F1Z; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DN/06F1Z"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b4ffc2a7abso2676706d6.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718725002; x=1719329802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEWdl0tqnkjxn0t/wprGhWa8mDGC5ARyeWTuu4/vhE4=;
        b=DN/06F1ZRQ1bHhrwwIStI+m2IKnS/Vzz4wwIfvP5vEwZYcFfG6tCQ3HPk5DitK1BA3
         8CuFHMJoVg/0etfum5FpZB1ayOCHbVFsyxO5nYd/gSxejmLESAoozZdRoSMIcTUXvFfs
         PY3QgWSS/20cISybItLx7qBlHfkmOk+kLCjPX4RuFzw4lTy/+rVN2JQgtNEdsp1gt+/T
         gnrrgLQ8TZ/xyJdgLkcoTp74tZ+6snIaZrBLh+hkGR87tOjQpfICtrJ96g+4vp4Q2Ijq
         WczIhBw2Isi2kbwk/RL7HeF3l8MF5QOQRU2v2gJT3CtVkVVsPnsVJHhBgDWrOE299OV/
         YKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718725002; x=1719329802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEWdl0tqnkjxn0t/wprGhWa8mDGC5ARyeWTuu4/vhE4=;
        b=GxBWMZ3+Hwgi1dCLaudV+qAau/l0qb3oBozErX/yrkKHBuQN1Hd32PXtR0qcpnIstT
         bCN921fP0LALy6B/NHPKnMe5974CSuzCxlJpzr4uh1czIOf/1hCVwEX8r3MMq6Z+gsRP
         oHkiflGR9IHRGZQMVYE0ytbcxabruWcdQ8FeTxw4Dyf4sr4jzLzy07cdmNfqwhRbMdDI
         x+7MwoyBE4EyXUo882FXzYzUbApHxjukCkGn64zhjuG35eVAQYYpq3iGi1v0bPCbznSi
         3S0exPbYFxP7EvQwoGny61MweRGDJs9jnCRS9LUbDAMTLiTnCjXSJ9kQCulVDGLrHWbl
         ML4w==
X-Forwarded-Encrypted: i=1; AJvYcCWc53DQQ8BB24K1Mn5UtJuo2XJLZrqU1B1tdVmD1rjXbcmFzwDN7cQm8L7e5QfWV72qEEsuMBrBMwmPv0S59e1lKiDv4LBwR/dhxe9rLoKIgw11
X-Gm-Message-State: AOJu0Yw/FlVMoAy4cEcibUC00O9dIonD+JfJ/YVZy+xui/5ismJBd+xx
	avCjV/GTHlIxdTSiBb2MxiRVgPmkOPQuREk6I0TZQKNZW1+WNngBUp08qALak9zGO10neIwg1b7
	Jd6TGwz8d/og424tn+E4EgwYZWzEp9QV97QWU
X-Google-Smtp-Source: AGHT+IGgUZAgVNuWZRwjPfHOMbbpIpqWWli3o1vJH/R23c/Tl3JFwmx2EG7BwUQGM8yvFqzdXJsnNlvcCKVIpai5js0=
X-Received: by 2002:a05:6214:e66:b0:6b0:7d88:c307 with SMTP id
 6a1803df08f44-6b2e249503cmr44454876d6.29.1718725001515; Tue, 18 Jun 2024
 08:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613153924.961511-1-iii@linux.ibm.com> <20240613153924.961511-36-iii@linux.ibm.com>
In-Reply-To: <20240613153924.961511-36-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 18 Jun 2024 17:36:05 +0200
Message-ID: <CAG_fn=XczonMkhozFo9YT0pJhPPzfjiAMKmHvVBb9QJ6_mcspg@mail.gmail.com>
Subject: Re: [PATCH v4 35/35] kmsan: Enable on s390
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 5:40=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> Now that everything else is in place, enable KMSAN in Kconfig.
>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
