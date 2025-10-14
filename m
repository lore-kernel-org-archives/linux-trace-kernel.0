Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915702AD2C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760401351; cv=none; b=SnAIq3a4DulW344BftmlDXOa/Ob16P2rcahI5w9IwJGhZfhS8Lei6K1qo45mtgQGKTzTfl4AIbaX283QfI/F/fgBaXMXwtwP6qjZT4AUoGmaN5UMWLQVtLP1K2AXUhmC4j1IoGBl952anBsdG8lCV8WSqUQqAo9zaZyABtwGTW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760401351; c=relaxed/simple;
	bh=/sckt03WCwLfSnAYlLkgFAXULnFY3Wevrmpp7eOMfNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WrNRqqXmWR1kd0k4fM14ccWZOxyJoS3oYTFsWNcAX6QuN6l94NTCoA0jY1L+n7suwFyFh0q+9fgI0fE0cDykMqLUf7gLh2LaYVk/s7I3OqOyo02fT5UyKWKcp0KFlzJu7q90PmxMUSqLqyo56O/qMtpLqehRA1Of3tikoRyWYHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MB4hdrHG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MB4hdrHG"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46fc5e54cceso10427515e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Oct 2025 17:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760401348; x=1761006148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sckt03WCwLfSnAYlLkgFAXULnFY3Wevrmpp7eOMfNc=;
        b=MB4hdrHGdodXYFiOzVnsbASiCK1SV8gqNtWGCqoGWl2WxV+uQq8kJTKJLMlfnG48pu
         Mt8rOPjT01+++fwuF23VaF/zchYWHP3zo3xDt643cLtbjphiklRPVqJN9b6bn9EmgNdh
         7NZZf+6SWpxHovo4Dy0KPjEiU8qmns7ebOMsLRpLzANjMFpFr3I17gYLOtqVEspGe6De
         YISRwq3XOM5roEuhRlQy7gDYUPry5ITqtHOKRMa5zY+UYnr17+Bbk2FmpHCsbdufE3X3
         YArjyntYoXUkoyEx8g+FyK+XlvVLSmHP5smtDZs21NeNZe+KdTU/EUHNgUj3iKJi+M8v
         YBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760401348; x=1761006148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/sckt03WCwLfSnAYlLkgFAXULnFY3Wevrmpp7eOMfNc=;
        b=uRbbYKiHn3THiF02pVvN+PMLMJEQ9EXaXOmtmgOXNuOF/ABxsm2m1e9n97lSyPZ96A
         G6mFGvClwOE84VQ/ynaUqBM9VGWBnsvKH6rBhfnCt28WpTE9cokPO2QRHOq065QmGgXt
         CO/YAbssvGkTPYd4+2pFOjm1tcSblynrNVwVQojA1EGLKeUzhubqRyRXiyp8KE+Vn1FI
         ugFozREz5I1R+8LkMznVEHQEGfSVPU0veDIQiz0vU9tIEDX8otDnzTMveQ7+8RkuLKEe
         vgLs7jazHt4hpvYzt68FKU4s4EnP2ushTS+tFyzoc8X38b77BZR681ez5siaE4jGOZWH
         h7Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUMShtuDWQau8KJ5Jj8ATVAG6V2WdxiCf1J8ZlSDQ2U7yON/jCYxdEtwuQKOWViNHCMKgh1WW2G5eGygJUrS6O2GXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqSTmqphq8nBHp7cbzJIGTmN/38aPAe//165/thReiRk9WLKvP
	fPzheMLCwW0wzZJdPd3WBkjna+V81PV3zm28ipewJH74FFJD1gW+A5mTdRCTjX9EcejrTbd/pUw
	Ld0/yGQFLtAlxkVJqdGO7pvuiCbKH4tY=
X-Gm-Gg: ASbGncuaXPVgTgr38QAuJlORtIn3zJIEyhtNjh9UePftulO3AJ4eXltKIkOzziNusWu
	nD4vyW3vsTKNiN3j46QSmEPc4fSZqLgugrMNtlnxgkZraPuv+uwuIzlWdsLuQuEA9pcra2xRoVP
	p1sB+PsIXZnL84RHTQReprDc4ABZWiwZNRBRoFWFDS1iJTqILetjbDr2Ar9FHcrq20rsAZbZtXW
	WyM/bPKzL4tsu+eaF4tS9Rk03GMGQQ0u/AUFcIs0mTm5CQS56RUKhEdXn6NHnYUDdrM+w==
X-Google-Smtp-Source: AGHT+IGJ5qltTUgA9/cXw31x1uygg5Ge3oJflLyKYoL308YSooCGQK7bShKg5RHbFvJc2PS3RR0ZKQ4FvgbV7QSJsvE=
X-Received: by 2002:a05:600c:621b:b0:45d:d609:1199 with SMTP id
 5b1f17b1804b1-46fa9b08c13mr164583095e9.30.1760401347853; Mon, 13 Oct 2025
 17:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013131537.1927035-1-dolinux.peng@gmail.com>
 <CAEf4BzbABZPNJL6_rtpEhMmHFdO5pNbFTGzL7sXudqb5qkmjpg@mail.gmail.com>
 <CAADnVQJN7TA-HNSOV3LLEtHTHTNeqWyBWb+-Gwnj0+MLeF73TQ@mail.gmail.com> <CAEf4BzaZ=UC9Hx_8gUPmJm-TuYOouK7M9i=5nTxA_3+=H5nEiQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaZ=UC9Hx_8gUPmJm-TuYOouK7M9i=5nTxA_3+=H5nEiQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 13 Oct 2025 17:22:16 -0700
X-Gm-Features: AS18NWDsJZRVcAOOD78yeTLl2fGNB2L3UPZhGSAHkSeeDFBcX4ozvTqOGJGcH4E
Message-ID: <CAADnVQLC22-RQmjH3F+m3bQKcbEH_i_ukRULnu_dWvtN+2=E-Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1] btf: Sort BTF types by name and kind to optimize
 btf_find_by_name_kind lookup
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: pengdonglin <dolinux.peng@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 5:15=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Oct 13, 2025 at 4:53=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Oct 13, 2025 at 4:40=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > Just a few observations (if we decide to do the sorting of BTF by nam=
e
> > > in the kernel):
> >
> > iirc we discussed it in the past and decided to do sorting in pahole
> > and let the kernel verify whether it's sorted or not.
> > Then no extra memory is needed.
> > Or was that idea discarded for some reason?
>
> Don't really remember at this point, tbh. Pre-sorting should work
> (though I'd argue that then we should only sort by name to make this
> sorting universally useful, doing linear search over kinds is fast,
> IMO). Pre-sorting won't work for program BTFs, don't know how
> important that is. This indexing on demand approach would be
> universal. =C2=AF\_(=E3=83=84)_/=C2=AF
>
> Overall, paying 300KB for sorted index for vmlinux BTF for cases where
> we repeatedly need this seems ok to me, tbh.

If pahole sorting works I don't see why consuming even 300k is ok.
kallsyms are sorted during the build too.

In the other thread we discuss adding LOCSEC for ~6M. That thing should
be pahole-sorted too.
