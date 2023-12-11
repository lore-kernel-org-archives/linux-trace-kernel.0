Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LswbF9ZK"
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C9A12E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:46:03 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-67ab41956f8so17452396d6.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702291563; x=1702896363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oGkQuUWo91ye44C9IpsxZC6+sJmmo7+c+5R/ZoMYnk=;
        b=LswbF9ZKpTmZcrwlg+PykPudsQPWHEl9tXtc0PW4cE+POJn4SWIJI0n7WgNsQqiPj/
         TE2JI0zG91KQdpHgFRW+uNe50j1jMrWDf1vGKfwuQGoTgqUwYpzO2V7nmJZI0d9AT840
         aDBR1E9WFF/bk8ZWF5LEeNmJejGTI2WViwllDFXo93mo5inV+WrpgVE2pmQOYJ0CTBq2
         17dgA6Nx9egJa0xiihyG6YnvxOiaE/ne56XuOK4PhN3P8Go/hBNQ0/WRlxrC0hZSikOL
         iTKUzUtOinVi/MpF9rQKkGvkRxYUkTP8L78zeslrYPPRsYfh7PRuE/uInqTgI8Dt6nAF
         n7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291563; x=1702896363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oGkQuUWo91ye44C9IpsxZC6+sJmmo7+c+5R/ZoMYnk=;
        b=go8LgfOK84h9QAqtXzuEDOAVeEJPAxXiRWPGJ7iI8NA7d4uOLRZgrQsumOa/fhjsQL
         Dshxc4TkZKpjff7kpLjacV698x2joUi8Sin+RuyvEUJz3wGSacLLuBxK23fnYRY5YZHL
         O6IWBPPGc+yAMeqocsjT0cLfWzu/X2dtt5Q9bRbXe6gHU//e+YjYLdYq0b7SoaWf/La7
         5KVv8IEnEiOGOMh1XXb6aMztVlguoKJnimBUsOplCHAm+BjbntpK6T/S6SrgakDpJlp/
         VlgZ6FlpNiX4s4LmeWuVl1yCG52WWQKjyJBd3oSLW+SHZU1N2B6TuceJTgvQf4nZ7mwZ
         NYDg==
X-Gm-Message-State: AOJu0YywmzEjctvsgH3E5NRCTmIJB7pB1UTkjmRJ57pbVzd6Ostb7/iY
	JJkXoYMiO8K/SPU1eZDJrCV5jafl9Sa0AQTc/yummQ==
X-Google-Smtp-Source: AGHT+IH22X94i2ts8pfDTl+UHUOVSQbvWaHqW1ewv6yn/pgryYwSlV5ZdHdef/3tWsAKN8+sgj14JcXabg2oblYSeP4=
X-Received: by 2002:a0c:fc48:0:b0:67a:a721:ec3f with SMTP id
 w8-20020a0cfc48000000b0067aa721ec3fmr2421212qvp.131.1702291562839; Mon, 11
 Dec 2023 02:46:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-33-iii@linux.ibm.com>
 <CAG_fn=V5zMxGUQ=KmJh-ghTUHa-AZYn1CPTQNbf3x7Lu0w=HvA@mail.gmail.com> <13e3e073f6ed6aa48b39ec16add85baa677d17b4.camel@linux.ibm.com>
In-Reply-To: <13e3e073f6ed6aa48b39ec16add85baa677d17b4.camel@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 11 Dec 2023 11:45:22 +0100
Message-ID: <CAG_fn=UX=8HrFzCSxmPgMn=H4cVmZ4GHE0Z+qZbpysOZwuH=aw@mail.gmail.com>
Subject: Re: [PATCH v2 32/33] s390: Implement the architecture-specific kmsan functions
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

> > Is there a possibility for infinite recursion here? E.g. can
> > `lowcore_ptr[raw_smp_processor_id()]` point somewhere in between
> > `(void *)&S390_lowcore` and `(void *)(&S390_lowcore + 1))`?
>
> No, it's allocated with __get_free_pages() or memblock_alloc_low().
> But since this question came up, I should probably add a check and
> a WARN_ON_ONCE() here.

Yes, please.


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
