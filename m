Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hGy5kX1t"
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3046D1706
	for <linux-trace-kernel@vger.kernel.org>; Fri,  8 Dec 2023 05:39:13 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6d9dadc3dc0so1186771a34.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 08 Dec 2023 05:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702042752; x=1702647552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rN8Rat4FZlrJAhphwUeTKAqkkJCDvqW2t49f375msAs=;
        b=hGy5kX1toSBypw4ZLPXDuL9hcokhSZB2g+qGSsSOf0cso9ZsPKp9DCbbuaU7XDMaiE
         j31rp1vUW1TiO8kY2Xh716R+RcsHZ+OSUkysX7VF/n7vMx6Q4cgE76oh/ELomjdCVmSF
         E4NDDaPAddfLOioRDkzq3nwqtl8odhWAjBQhTP+NAI70bgxmEJT+P6UbleA5W3Cgwqu8
         aDR1oKJlEMw2CdN0OQTOdoLW9UHcR0Gll/nrl1JvDrh3Ta17n7tV0JJMq7E7BQvUGuyN
         VJl2Q7bCfAIKY1xUmCrmJzvsA/jEyeZUfW2k1QI45d8nvIrdN45LFSfPNddfHdZaDADD
         3zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702042752; x=1702647552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rN8Rat4FZlrJAhphwUeTKAqkkJCDvqW2t49f375msAs=;
        b=vxtZR1tQqLu4kINF/BFbl8YpV9fJ1d7G3wT+9md1xIuZBk8WNiSo5Jt4LJBKa6t1d1
         imejEuyxxF8fSxh2TVGwLV9+Jdua6Iup8oqQ8kUl0Va6h+nXgekKxQWQYou4HXN3xLKr
         dmVlbXOhISld7YpbNPuDfjZsv+2Yo7CzK+sz3MMsMltUMuxGLPEmEsN1ovwcurT453ko
         1BrfUBdZdF3SSxZFdKJvSIwzmTnVjtKAbiP3UIyXak5qCwUb6TabtF15WM4gRCzg5++t
         DcnXx4oI9lSKnXEaOXKH6IoRuB3/cGWYJLS/wll2vEVPpGVSg2Guy/MN91HS7920a0fj
         23SA==
X-Gm-Message-State: AOJu0YzhHXy9sEE5afVxjpSesY4MStEYMGhIZoozKH7LjPy2eXkL5nd5
	QpgJYhA8Hoct4L/rMPpq4LW+Z2OAjfVAYLe86bcdSA==
X-Google-Smtp-Source: AGHT+IEJXKzONP7C4cAEoOMzT6ZeTkshs4DU290kKfRkkOzICnszoAWUTV1A4DlsnRvXpiN/Sz4G5aKQQ3r+jLf2v2c=
X-Received: by 2002:a05:6830:1a:b0:6d7:f363:eb0 with SMTP id
 c26-20020a056830001a00b006d7f3630eb0mr39559otp.35.1702042752413; Fri, 08 Dec
 2023 05:39:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-25-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-25-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 8 Dec 2023 14:38:36 +0100
Message-ID: <CAG_fn=U8kGUCHQb7580bfVgh9=E1zjch3vB0tV5ooFxWsGNQkg@mail.gmail.com>
Subject: Re: [PATCH v2 24/33] s390/checksum: Add a KMSAN check
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

On Tue, Nov 21, 2023 at 11:02=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> Add a KMSAN check to the CKSM inline assembly, similar to how it was
> done for ASAN in commit e42ac7789df6 ("s390/checksum: always use cksm
> instruction").
>
> Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
