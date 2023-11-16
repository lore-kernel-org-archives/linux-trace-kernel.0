Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gjQ20O/o"
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ABBD57
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:14:12 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a7afd45199so7016797b3.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700129651; x=1700734451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5z27wFZQcKESSrI85AK8SZJIpmMB6uhj5fEtkmaII8=;
        b=gjQ20O/oXiMttAWwKuYqRM8jsItpyrbgUftQOi5nWSPBZNynU2otEfAQ8TbFpi4nYv
         L2+mS6P5WPvxvBfcqlZXflak3skFOepr6piLa+3rwyHsi3Ndddhv/X+RasJn1W8E9YTn
         CcaQARRW3sYpKEJ8NwjYfrexPmk+IxEhSyt2Uj6v6k8oSC0xpt9FtPO4uhQfXnacz3Pw
         TtQevSy1Zitg1U2DBbPBp6TCzpgAnw2fSOk4OVZlBI0YbH9svNI3TddNsMuUF4zrzWrH
         lNvL1tVYYO4RoTabtVk3DbSNmT+xfAMzRWD5HqmCFqkYWjmWaJ2maieVCvzRMmsjjZKr
         grcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700129651; x=1700734451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5z27wFZQcKESSrI85AK8SZJIpmMB6uhj5fEtkmaII8=;
        b=JLq8fMkLVAg8zCP43ZElkQMwGDhyv4lzhIPXOm9XOXvgcuYY3qP4yc16ufnUhm2g16
         KTQH0EItgFsJXvCYsEQtTOVGFFgufmzEw8P6WQImtdl5mrtluNx3vrszyefxgNSpZ9AL
         wXj/Ml9zaaoUwW3osV/+zzzvllmwTPBm8vnF6FCwfIuyWG6rjxvLCGAxfxzbnhl92kD7
         Fy4mbCj5xP+LbuY/AGd1ycm4pDPBN1Cdo6O2M0x528siPJva2+4gYhPW5CtJKJBcy/qi
         DlMwQTS7LF9oGTlVeIqiX1dXrWhUaNphfrREBWSrU7Y/zsF6txO6rWiwoxxO5kS0QYk+
         BgGA==
X-Gm-Message-State: AOJu0Yy3jgYu7x6yofvlpRQR4yZnN7RByb54kD/lT/WzvEs4+eTJlg4i
	HqlKnFMPLvf/28wUZoo5Ly19oIpXsUSHhPllHnAK7A==
X-Google-Smtp-Source: AGHT+IF+jaGcS9pPp5H4LI7L0H2rgwwBBSMYs58tIpjDOVz6YSDhqCfvQL1gqRcOfGQbFFqR56bfm3c0DchFbitnYxg=
X-Received: by 2002:a81:47c3:0:b0:594:f864:8507 with SMTP id
 u186-20020a8147c3000000b00594f8648507mr15893002ywa.51.1700129651150; Thu, 16
 Nov 2023 02:14:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-7-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-7-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 16 Nov 2023 11:13:30 +0100
Message-ID: <CAG_fn=Viz99-GHX0rnKWo7Wdhw+BLHqNXY_AV0-pT6d1OiGw3A@mail.gmail.com>
Subject: Re: [PATCH 06/32] kmsan: Fix kmsan_copy_to_user() on arches with
 overlapping address spaces
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
> Comparing pointers with TASK_SIZE does not make sense when kernel and
> userspace overlap. Assume that we are handling user memory access in
> this case.
>
> Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
