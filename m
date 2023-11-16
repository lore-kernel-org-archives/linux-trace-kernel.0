Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L2w/VYcS"
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7905C1B8
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:15:07 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5bf58204b7aso5818677b3.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700126106; x=1700730906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsOxPTssCXfEjaJKL1FvlaQBMDAuXe1RlMdSNjLvudI=;
        b=L2w/VYcSN5vXT9bGmTpDrhhO9vGrfZFGNJojaIFwWz8De9Hg0ORb7LEWZJ5Lf7k/35
         J5kXuSfRX5Ydo0pBPDF1N8FFt1P/XOZdCXKJROrF35us7bDm/TsOfWM8PRfoXSy9IFHp
         UZqVMWIA03Ntl3+X6UodmYgxmTrhlSBmCGaZBiJU5uVYdk4b5jrydAU6GStptcbtwCUu
         WJXkKy7ynDx9IeQ7ruX41BbcwOQH/nUf7+25qWdjpZux2R2IayLj4QSnWZtPCu1cqOza
         kPJGs3lxEcMNv8t3IDM5xCyeHRn+XSWhfOY2iEA4V8OTKp9QCHAsQRz98bAeArBJmWtu
         R10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700126106; x=1700730906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QsOxPTssCXfEjaJKL1FvlaQBMDAuXe1RlMdSNjLvudI=;
        b=bgQw0zmLKPLuEuafBpPPZCcC6Oz+Xz6RZK1yVn8abzjgzDqJZN7VHzU2hE+CFcGWPj
         8m75LdzPX2z/eWF41pKWmXCNDbrYc10qKtfGzF3KXO2/u6Fyn/IKdGo8+lHbLrxYmGKy
         Gj8yt4ZjlC4fcjJngfcqYc7rpR/oH7lg+gt/8Oi/UdlVErefGi7F53D4U14IF88F+D7B
         ZXUS/gVeqlZBKi8OQuBFYFlgC1pRugczFe6wGCHtOZ+i4ZH9nsLUHdW4CR490nY/dHo+
         dWhnTDFWSgqpAKmIy/IXkK0V0/DDEr+aLgA74Dc2EFJ2N21EWxUNZamfdHsGtFy2P/ZS
         6PcA==
X-Gm-Message-State: AOJu0YzwXpXeN+y2RGbStaqGbV4ITJ2Tk+8eTb1Fqfn7Iz1KabkBJSGE
	l3OTiv9DKxNcGCuoJJkJIiCbnZY9GZihnX/DgGxN0A==
X-Google-Smtp-Source: AGHT+IEvSuQ2VeLe8nxzm+KAwC3Xu4zj8WHKnveqJO0J+JPLWHM+U1ETIwvgpmkEprYTf00eQ+4e7i073zU5qxwyHM4=
X-Received: by 2002:a0d:d70d:0:b0:5be:b764:a15f with SMTP id
 z13-20020a0dd70d000000b005beb764a15fmr15877402ywd.24.1700126106526; Thu, 16
 Nov 2023 01:15:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-12-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-12-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 16 Nov 2023 10:14:30 +0100
Message-ID: <CAG_fn=X6+fgYb8THhb4GyZYz_1mVxAifbBeA+bOqDCmmT6Dovg@mail.gmail.com>
Subject: Re: [PATCH 11/32] kmsan: Export panic_on_kmsan
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Marco Elver <elver@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Pekka Enberg <penberg@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 9:34=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> When building the kmsan test as a module, modpost fails with the
> following error message:
>
>     ERROR: modpost: "panic_on_kmsan" [mm/kmsan/kmsan_test.ko] undefined!
>
> Export panic_on_kmsan in order to improve the KMSAN usability for
> modules.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
