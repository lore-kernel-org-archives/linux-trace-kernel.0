Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FiO38LCV"
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625EC1A7
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 00:56:41 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5be6d6c04bfso5642747b3.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 00:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700125000; x=1700729800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0H8tt9dZT0qWTNb8kikU8kJP6qFA036d+J9DtuTzo40=;
        b=FiO38LCVb8fBklw64T6AH26gpSqb8qlx1wXHPxu1ZPWy58Vaex9azvV0r2+6BlQ/Jz
         9cMjn7vSYITmtGGHPodX6G5UKWFfvYTGATD6k+2VbSwdoe/1/CChhWJHz4pP82GCFA+A
         qCXOM+aqZuenMQs1YkrIVIsjMrMAdhmeWciQn9RDiSqqlL8zYo1gvdrj5NU7zcAbr6Io
         bYzZEmYEfaNSVbxAjVB76i1apSZIo+VgwJrERNiQHlgBnJmYbkbPUBFwHWyuRyHPA2i9
         mRwcNm296SVwhp2SAcCIb3BWEkCdPzeM4OyivjvYvRKN+Y5wmaE/6Gmrt27FTXafmjRK
         Xong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700125000; x=1700729800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0H8tt9dZT0qWTNb8kikU8kJP6qFA036d+J9DtuTzo40=;
        b=tqzLAtGIzy/+igJ4l9HHHfolneiJAtEb+ZmKxNX2kzyupNk837lBG674I3iw5hPZPv
         GZwlSqlPJqxuShudJQebcMaNE9f4PSIihTN6gnTgzqu/ocpsfxaA7K+OEbGGgxIEScOY
         nnrbJYEwd1r7C+zg8JkBGb3QTaFp/2b03D9wEwsfzm1Go5EVnkE3u931cjjzLq0kaMXZ
         xFoRIqNMgPhvlt5aJj3fhXKCURBVyEbf5WRMYG7QBCGydQRoxMaT/RIYzRnUZgMrSt8I
         gon56vQ85Qbo0dPo2TEGta+U8Biji2Ddcj85soAJqnyaFuaTPZw4ydFnONnOJBworosF
         QnQQ==
X-Gm-Message-State: AOJu0YwfCsiE3xlUkcMwkPdClxojhWcsoK9IFuoe+hyYENgwe2jfBUMR
	Rkj3wKit/HW7YAlPgs496CRM+SZN18wBd/h9Ss+PhA==
X-Google-Smtp-Source: AGHT+IHzzP8uN5KL7oySFlmUovw/aF4rbyrEjZrNGe1wJC40tLjll2AY1uSp3JjEkwmZJ6aR8KyKW2fBLOpcuaHXMsg=
X-Received: by 2002:a25:b18e:0:b0:d9c:a3b8:f39d with SMTP id
 h14-20020a25b18e000000b00d9ca3b8f39dmr13846249ybj.65.1700125000447; Thu, 16
 Nov 2023 00:56:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-13-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-13-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 16 Nov 2023 09:56:04 +0100
Message-ID: <CAG_fn=XVJNZLtHj2n3DP5ETBzgoUZL0jQFX7uw4z9Pj2vGbUPw@mail.gmail.com>
Subject: Re: [PATCH 12/32] kmsan: Allow disabling KMSAN checks for the current task
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
> Like for KASAN, it's useful to temporarily disable KMSAN checks around,
> e.g., redzone accesses.

This example is incorrect, because KMSAN does not have redzones.
You are calling these functions from "mm: slub: Let KMSAN access
metadata", which mentiones redzones in kfree(), but the description is
still somewhat unclear.
Can you provide more insight about what is going on? Maybe we can fix
those accesses instead of disabling KMSAN?
