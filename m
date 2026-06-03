Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0000B4C0436
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Jun 2026 23:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780530733; cv=pass; b=Dr6CQWsbBnlBx7vIqsc8v1Lck7HIGktwCmTgSNheoat6iqrL2ENyEBKdmHAatZzJL391y4xdKIbjbIZJnzhZbtsh7E5TnPDpxrvmU9qUW1A1ZPzn3aCTnNjHgeaXlV9AgoOdC6EBLwCUfjJOil6cQUOPNQ0RcukVF73rjRAxuuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780530733; c=relaxed/simple;
	bh=FfS/kIbVyXQ8oYH5XuhRQq9azxEmzRp4crNgtSWViUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEmGwfussUIhsFzYYFKnOZcfKYDk0oXyRgrfAtDIGD+FFmtI0lkgNTTqDP/3AXP6ZVfDNy2j3JgeRi1auEroQvApRT6Qlx7HqFSgm4LR7pcxhnQFpJowTCsOlGqTlvmgSSvgWpbaSYgiZK8oC0XwFZ0iWgFunvUNRV+4IlQFfSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QX9nc0Tz; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QX9nc0Tz"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68d232e119dso121876a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Jun 2026 16:52:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780530730; cv=none;
        d=google.com; s=arc-20240605;
        b=bRM12isvtkN4zyYiksgGCjHY4MAg6kBZHp9kmrcA6zSI7F/alBvy6QHrL1+qbEa2Z6
         pan4actK4uPdonX9dh80KSTUmvBfXPF7PaMSRJqc3x2Jsi9rg6dacmsEqBY7SYE8nJoj
         D9bQ94CUMhVP/WZlLvBj0teQS4h6CYTdAwy/ti1wwGyMzptl9CMzC4dXCrg/GO0T9Ysg
         l6UoEVKZncRRctpBBAPBdW1CxbgYd6pCz4zoz0YnbMPBTt+TyhENi4+//8viqO3nETWB
         gXjEh62aYzp2aHXjTuEZSiKUTtNZ+Nwryjsq9D7jXdQIItE+X/C2FVcOzVKWpqh0nORb
         YOKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FfS/kIbVyXQ8oYH5XuhRQq9azxEmzRp4crNgtSWViUI=;
        fh=/GFWBRAjO5XCsutgq0QLkBXNkIus2qvMW7gulCR31Zg=;
        b=eitFn0HujaEBqCgz0hU63iYBHDHuDICuC+5FR9VirIo4tmkNhF8OmaQ0tD6EjtH3Vq
         REH0sUYVrxTErbQ1eiAWWfAi/lf4yIKqdWq59Bre1iFfO/pazdiyIRQhMrKJk9u+qLAy
         7pHP//7IKkYfI+bs+xDTUYdOtLWdiL4TPh7P6l+Z3K2dhUzghW74Ure98ASXIj7co6Ar
         WkDEsfbzIsOZTVEUDy6DkNOr9jWca3vOKvdTw+jEJ/eai9YGOMkvFGWldpb5/gpf3s9S
         tJf7Tmqe8+DpQOsWmAGqgaCZ9e/66K0bBOHiQ5W/Iv9djdL0pLfNowZcpM/4pwR5MfzQ
         4aPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780530730; x=1781135530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfS/kIbVyXQ8oYH5XuhRQq9azxEmzRp4crNgtSWViUI=;
        b=QX9nc0TzLhgQ2/GbHvsfMf1kEykLjokLa9+pdEzqbCO/ZUWpkclTZQMMOXen7vgZeW
         1jZ1M0Sn9LeMSExVTA1RSvPLWSZk67XA6iouD7BBduMY5Vp5rWquCKORi3KdB4DwlUST
         t1KisgywuGA8tcUO3auJV3PAJJt5BuDZPVAKvszMLEoj36+Lil72me+Swx4B3dmkyKBo
         +T2amXt2yf8bQQb6Y6wTRFInErhE/XvUFfZJHSpSO7rryjenDI4ioJRY7v+6gs+Katta
         lBXl1x5nPvzNKExaMWZCnuHLjkuo1L96P5tPF54FeHEipiPbmx7yAdYDd/d49C/PSjMi
         9KVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780530730; x=1781135530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FfS/kIbVyXQ8oYH5XuhRQq9azxEmzRp4crNgtSWViUI=;
        b=Hth1hpi7K81nlm9Eze2/SAxidZfMFe8rFwr93IJ76BtBTWzgCAGlnKUe1jNZJp0uh3
         pczfRdFK2hVpZMyKO+4+FIYsNgOp9hgKmCamO7oeNMIlkETRFE+2+1y2OeLQ0YkMqw5C
         a8UObCFQ3M4UTKO4TLvMYrPgAh/hBQmFxbuADp0t8utvM9xyRlcvCK5tvXxPR/9vaups
         XT+B53Hjc9Va7EmPtDizQVwTtazLCaeC3lp7iIpi8RdPJxaGanm5n34u1bcNd8DDzXxY
         xyoogTzbTR0xv/KqUezI+PDzfy5RFkzEYRBLxedK4xMf6QjlqAxByae0ry3NDxqHW6RC
         4pcA==
X-Forwarded-Encrypted: i=1; AFNElJ/BW7s5cHfGS3WX+Ntqn+ySs6oISlk4JMrnHuotBHoNWOSxe0GjtZ/BwoPvRKi2iqixk2TjHAEESNgC7kgV8AaNk8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO+zz7MouGDcqdGSqROelBlMQqVglKWgGartmvLGiaLBBBz4vg
	NUn9dOwzVO1zZ4puCD2UtpiEObPXWIqVSZ/P5G7H5gMc9QYVDkXleyS9ytw756KqJJ0NdRWkjYm
	idMHW53FDskdpdX+iNWPegEM5FostukZ6oQ==
X-Gm-Gg: Acq92OH84af37Ol661FcMWDuYpkWRt52JS43RT6AFCNJVSSCzvQF2qaAkPoP8UYcDyb
	FiemfdEzGAxlk2d/8UolhIdrdateTxhfy8mA2sAYUwx3scW2afeU4zr1RTCzQxDsDZ9+o9bLAaI
	MWeLFmt7dN5274nS+HGSm+8Zzm2/mTRa1jHFLXZzI6n3LCaPz2cnFeRnzDFQ7H2WLgjvlxtnx6N
	WJtiK81S9NUUrD2jpEpcdJ3Ms5jCjLIFpQ26noVKDmHtsb2TqMA51b7A3oPWsvwHWhiw4CE0KJC
	5ASfJSNGS5OAp5QNMgTWXytzTdAWa7hZce2rkEWBATXUzGqP5gWvigjRKWsg2tbHKyFGsSxTZUE
	=
X-Received: by 2002:a17:907:c085:b0:bea:2fbc:4ef5 with SMTP id
 a640c23a62f3a-bf0ab710b5cmr316516966b.44.1780530730399; Wed, 03 Jun 2026
 16:52:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-generic_tracepoint-v2-0-b755a5cf67bb@meta.com>
 <20260518-generic_tracepoint-v2-2-b755a5cf67bb@meta.com> <eed59d12-969f-4135-a84b-4965743692cd@gmail.com>
 <20260526215741.1e5b3e42@fedora> <CAEf4BzY5MTGJyys369qDS3b63-tKq3okCpFMqUdfzy0dXk7vLg@mail.gmail.com>
 <20260603185057.4a85d5df@fedora>
In-Reply-To: <20260603185057.4a85d5df@fedora>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jun 2026 16:51:54 -0700
X-Gm-Features: AVHnY4IUVNJqtXV9AScDfxOf1g8eA90hmIpGHvsbaa7lCYBS-3jVxavexcFRfWI
Message-ID: <CAEf4BzZFjsEv3aLktwdCZF6EXoCL+eefX+6xa3XGrhBmfO1SqA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] tracing: Expose tracepoint BTF ids via tracefs
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	Mykyta Yatsenko <yatsenko@meta.com>, linux-trace-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 3:51=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Wed, 3 Jun 2026 15:41:50 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > That's just to say that it would be great to have this in some form of
> > shape, so please help getting this into acceptable form, thanks!
>
> As I said, I'm not against it. I was hoping to find something to help
> alleviate the memory usage.
>
> I'll likely take these as is, but I'm currently on vacation and it will
> have to wait until next week.
>

Yeah, no worries, I was just going through my backlog and trying to
think if we can avoid extending the tracepoint class struct. Besides
the somewhat dirty kallsyms symbol lookup logic, I don't see any other
way.

Enjoy your vacation!

> -- Steve
>
