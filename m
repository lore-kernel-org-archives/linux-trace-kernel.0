Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B492BEC5E
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Oct 2025 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759943572; cv=none; b=fv4Sbyulv/O0rRHS/XP4V7QMNxPXlhiG0PXm1NAwKz50LdjeRbfxS4X5ZA35IdHThL+HRODcUEZsC0TnxrlpI+i2FRijGHwmaVbjUjxEE4n7DCdP75FqyHQ1gapfd4jonRB2GH6eqOcD09s84PHHf2wC66l2K1MP2OewzTc9pFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759943572; c=relaxed/simple;
	bh=QXRXen/paY2I8AfimuUYl6aegwK5TnJBROTQaPpMH7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWAyBnyaOa1ZVIJGOM4YN6f5PToOZiE7MDBg9vL4Y4AbjSBAeMg2yWE90Y8wo32EbSr4sOaxiUhv5F5Ve02QkGbEeUGzm44tWCeEdryhbyts9UXrYJx2G59vzWlCww6CUbnvuUIH2s+7Fy7YdIy0iIa5dSeqPwZipaRU9v0Iv6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bo71i0b+; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bo71i0b+"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-638d01a8719so127196d50.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Oct 2025 10:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759943569; x=1760548369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXRXen/paY2I8AfimuUYl6aegwK5TnJBROTQaPpMH7o=;
        b=Bo71i0b+i59XE8ndqAGX+HyUNnuN9NvwMpvW4aTtrQSQlPpIMjH4u9QdyYNw9yP/5h
         V4TAabAjATR5PWsYQiK7gl6V46/K15pWImSTeOpEEkD4veVu0Q9Tmyomue5Vz1MCrO78
         EZ90Bns8SS34hTs3lz01GcMAAHy7wY3kruPjdcp+bkMVokj6l5JTB8BlpYBA86PneIEP
         xo9nAzwQeJUS4nXZx8Pp9CsSIF3My4bkw/IHYnE1dsrY/gDcXpT5blHYBHKcNoSO4b4z
         9GlfF5GwGCoZeCYPME5ILU+qvAjLW/LdfkcFan6nzbjQXi/58UgD8Y3DIMIgafPR7B7K
         uJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759943569; x=1760548369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXRXen/paY2I8AfimuUYl6aegwK5TnJBROTQaPpMH7o=;
        b=oMTgRrLvl1RlcE32Y/jqWGEu9/5fPlK008t1FgXH+qlEFgUXipzXyH3DIOhPDLw5yS
         tUfn67OIVosB9ldY5yYpAGYGP7gYaWUkO6NQz7AIgHY3A9xE8z2rUaopdz5qTZOxzWkz
         Etm0Rm5Of7VlGKX+2ubQSFzDwSHAfPBjYotpzei+widCZFjS/yf8DXZ0n96Q0BHQlKAy
         F7vVK4OXXrNv1y/5Rpk0Ckazswp/8f3EUoIKGpxRBuiHp8/J8UvvklnO7N0yMYYoNJiN
         fHnVgs44LwBIG+t8O8ktJtsaKkkRRGITYeMZ++9siLOjRQZvJJdbbfH+4dtgIIHUGaj6
         uwaA==
X-Forwarded-Encrypted: i=1; AJvYcCWHPC56HL6VgLRjIKmB7ktpBc6TOFeMXi2AemufyCYMziwxcqHPiWux5lZ1OuoU8SglYTWibZxi0j3cFoNvk0bXvdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7uoqUB9jHHVOMac+9+L/udyYLfvgaTmPDYNkMECeqN2xpvm9K
	bTRuzuiuzcInI0h6wk7IVZzT717Tkgi+nAWqfBzVYTAs+0VO6G95ZDIywtbXajSJw1+H66327rK
	iFkHgehzUHuQUqgqdaYuC8HXk+d/y8whitydYtMXm
X-Gm-Gg: ASbGncvRoLBMmIiTvb6XehjKo2pbcJmWMCq7pxDE7eY0dVCL9ZBy4CKpZYgw5u9l4Rq
	UQRXjrsIO5E1XfTIVL6tz8aDpIbQuLQxJKCUfnTd+Dw6+Ykkhb8R9/ovPdijnf8iKpVgdjisA81
	OGNJ0k0zRdhan/EaWNYM62zvIJuqYMBYIpH7omElbFbF3N9RG5C12i6gJqtOUcbnYMwjn1ZShq8
	ff3ZEODd0sXfS7I7lMYNwW96HX+HcJj6MLfCbTfY+DaRLepnnV8QnwVzBlciLgdZEM=
X-Google-Smtp-Source: AGHT+IHC6J7ndh3GhjpBhSyUbtmgShHSwrKImun5tVKXinNrao1jet7Nrip5xHU4l1aWy75vzkCWg2jOpuWyhQsCFpY=
X-Received: by 2002:a05:690e:4289:20b0:633:4a1d:f9d6 with SMTP id
 956f58d0204a3-63ccb90536emr3975966d50.25.1759943568487; Wed, 08 Oct 2025
 10:12:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007003417.3470979-2-runpinglai@google.com>
 <20251006221043.07cdb0fd@gandalf.local.home> <CABgk4RQwGsn4CdP0K+_7A0j7RVOiHNfoF1ESk17wEuzCea16pA@mail.gmail.com>
 <20251007154308.5b158d04@gandalf.local.home> <20251007163141.1034b120@gandalf.local.home>
 <20251007174208.11fd02da@gandalf.local.home> <CABgk4RSxm8mNJcRn0HdNH3+Y=VDL5gNVvyhhR26wjBme+i5X-g@mail.gmail.com>
 <20251008123259.1dfc621c@gandalf.local.home>
In-Reply-To: <20251008123259.1dfc621c@gandalf.local.home>
From: Runping Lai <runpinglai@google.com>
Date: Wed, 8 Oct 2025 10:12:36 -0700
X-Gm-Features: AS18NWBZ_2jIHsOqsd1oLxaaH4vYuG-AVzpDFpi_S9SaadhDzofyG-wP9wS95Gg
Message-ID: <CABgk4RSb91kHHGG4hqyiSb7w1cOLQTXE1+TxCCu1WwSimQE5og@mail.gmail.com>
Subject: Re: [PATCH v1] Revert "tracing: Fix tracing_marker may trigger page
 fault during preempt_disable"
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Wattson CI <wattson-external@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Luo Gengkun <luogengkun@huaweicloud.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 9:31=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Tue, 7 Oct 2025 16:25:41 -0700
> Runping Lai <runpinglai@google.com> wrote:
>
> > Hey Steve,
> >
> > Thanks for providing the buffer-based solution. I tried it and it
> > fixes the problem!
>
> BTW, I'm about to post a real patch, and I'm adding:
>
> Tested-by: Runping Lai <runpinglai@google.com>
>
> -- Steve

Thanks, Steve. I'll be looking at the new patch as well. I can also
help test if
there would be follow-up patches.

Best,
Runping
