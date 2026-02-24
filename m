Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F3C3A9622
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Feb 2026 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771953216; cv=pass; b=J1W2DkBk5+rOsB9T433NbcuLGm0RXJ+vjZVVC6oOaJ48ODCmJyEst9cOQ1oE4h6S72pncugFx1awMsbvO96iFj0CSAAYq2KNPPIntn0N8lqVNnnGgjSpswZg+hCJWPyUVavUkL73IUu0O++1tz12snA1IQWnf3nJKI418Iqkjio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771953216; c=relaxed/simple;
	bh=wcOJjAPE0JT0qLCFfyvYa/742HjZQ/jXz0Ob5iB0R+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0pkdBw5jcqjCAwlgeqsqp1WXuS2LPE6krcgnrRMjw04hGu+KFJjJA9fveOd70598fxRbv5lmuX+3Yv2qaO8Yd7lzQRRXcDckPGfFXWV5+9mPllqaRYzNA0ugNC6CfH1OdsGmpS0GEyR0n5VuPhaC7h6RRqGDhTiJ7zHjtTbwaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6KVlN4q; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6KVlN4q"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-483a233819aso56368255e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Feb 2026 09:13:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771953213; cv=none;
        d=google.com; s=arc-20240605;
        b=BhlMbmdiw3Acq4Mte6qm1zXgb5hPkeHOsjp70Xbu1mxEXd+kWd0egrooK5hXpNfAhs
         4XPCiCd8AZ5LE0Z6pSQhZNUzq1t1UlqG0CwiR2GCt71lH0ZIIqs7LIfKjJvqhnc80IkF
         eQEb2oT9leQ3HDD1KU4WX6HH4GhWTKi04hUvfQ+xq5qJsL9/ihaUbsz2K8fmqIPkxBP7
         0JgwMPpB8BQ2Va/vlSNSTZtts7K+mf0dYeA6jDumZ/TGWLYgZifOEovAboyQPC8fuvMv
         LGVgABvhWJF1rmJqcnfaKKOx45MwwTLo45d44vm0R3ipbtMnuz07WaDc+BGaxO2RtrUX
         KJiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tcnX9HllqX0Hw9TVrxhKywHJCcgvH6KhhpQUtvizeKc=;
        fh=clrYaGEuT8Hy/hbry4S9tAAgPb0THMRNHmO/c+n706k=;
        b=jLly8iPz0Q0XVrIzyqoLDn5gnJKXwPuw3H1rZem8KmLbUscxGrMEIPaf9YkgdrI/40
         lHMyGa2YQs0etH1cdQefQpo844c3hR66LSpks4FTSVoMfGpDAOxKt9rRnh4V4Ae4vb4p
         iBkC4mpripFH1dwKaE36Pa4QR4hT4sHCbBy9ivNhG0SP+xoibqMiLNicTrqf4JT9XMQY
         N7WYhQL+deoWcPcaobhIZ+H5AdQW3jyyJfc2AEj9YUTElJpvDjfyp0SE3lC5qayDOT+S
         qVWcWpsl65KDUbniKj7giBDM1/DaMQJ1X7zdvvpg5MPL4T2IRCR/kNTQdJmR/pLbM3sd
         b3dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771953213; x=1772558013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcnX9HllqX0Hw9TVrxhKywHJCcgvH6KhhpQUtvizeKc=;
        b=Q6KVlN4qgO22hojXrNegDDbOFfytnULs+EOGeknx1/Yq6QAj6UgeN4J6ICKoKMjQsG
         qKWJNsL0Bkp8xL7ykgLqEMdL/DygZXJGKox+u14fe5asNhPJetlz2TloXcpI5rJXP1m8
         ZTwh8QrOtcD6AosldwG03e/CJbgKFsE9cOycS0W9As8UWELv30ZnqAAV9uyOZu6E+BuR
         /yNmnHb0nBCX+JNLs1jdJ6n0a2HN6ZTHRyPsyP+zsoV+Llq4F5ZLeK8rcuUhIcURe3qe
         P27yZDBqmuSVzcQESe3mzdtx1I4fguSHhArnWCG6kjWpYs+AVFFoa90yj+gqO/k1mbg7
         pccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771953213; x=1772558013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tcnX9HllqX0Hw9TVrxhKywHJCcgvH6KhhpQUtvizeKc=;
        b=P6VO1gl6ydbiqOG6uGAMB48M5KEp4REzlmqpJcbbB4tYOl9r7ZfjevpOfR54Pv6EUa
         FYA0rTpio30bg6/q3Dhk2jy+G/gycBoM0Dx6IYS+BCLS5mAk29oLsHi+APTD7dFtB7Bd
         6luPMLsvLZW+OICI1KD+n/ZDwqNoJggfUYINfwUe8t46BnqqCC8yjT7Vi3dJdZ1eGGR+
         X5oW8ePQDAiJ5YwVMUtgHjJ6XT5sH37aBCNgJA6SW0ZJp9KrQZfiDgg6RLA9X/H4j846
         Hy9EsXMZdbD3tLsbNwkmZBhOViOQcx4lkA8Q30rdveFGy7unonkjZWH0HySFASVYkNxi
         sa5A==
X-Forwarded-Encrypted: i=1; AJvYcCWyeob08fZrxx9nllX07EtA/Uj34ZkfWxuPrkuew9M6hWRyf0++mXpJYlQmId+Y4gj3fsVXii8HtZYF+zALRmVekw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXiF2am6Cok0fufB9FZPrgxls5a9hb90ILorPEG/K0FG2q0gT4
	M6bT/uXzJoKUAEuamrzdUUNvFAJ4buWA16CRPSunyKLYj3VZk7jC0EZgTgty/Ff+O+rIqfD/JgK
	ljZpYWIBFTcRKYCm2FD1DkU7Eqjaq8NY=
X-Gm-Gg: AZuq6aLlgDbu41+SKTSi4yKqWgm09VE0krsbA/cqKPwX0/lauwArkOcgP/dfyOkakOa
	H7d67xYXbYR31p69gv0T+Q7SUrUMieKxzzMlbk+fImMutGE8NtLSe5Y5inyQEaMa3p/bPr+DF0Y
	IkWMA0NNCwsI0aX/SmLR5ixdObRg1ZZXLnOyI06jF1sqcDeEwXZrUQE3VcKxhAadCRLnw0glprw
	/SBLpJWNF3OhJuJdFhUVBf5caSD5i/+9decss+xvgykm6UJ6EzrY/qjvuy1mkACWh5DIezo630L
	WTeeakrjEDD2cxSO+8Sui//zL0KLfb49R8/hfQXSW6muxhc9Xkx+ObVgsChrcFQKqwxWbCPp7qp
	uzZg0Q42n
X-Received: by 2002:a05:600c:450c:b0:47d:73a4:45a7 with SMTP id
 5b1f17b1804b1-483a96377b1mr210446775e9.24.1771953213405; Tue, 24 Feb 2026
 09:13:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220100649.628307-1-jolsa@kernel.org> <20260220100649.628307-3-jolsa@kernel.org>
 <CAADnVQ+2-DtgWqeKmrbsP0O7Rz2ZkDjkh1kfHDSxF0K8Xs+1ww@mail.gmail.com>
 <aZsT6_3tkli3SPsI@krava> <CAADnVQL_Jpe_7a55HTn5CyYoxWcHahiK3+CDeOeURqZAuf+teA@mail.gmail.com>
 <aZ2ZQnBHPz3UO1wr@krava>
In-Reply-To: <aZ2ZQnBHPz3UO1wr@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Feb 2026 09:13:22 -0800
X-Gm-Features: AaiRm53ORMryKT0X5sm_eSd4JXNBTgpQLyAE7ayxMqNU5N8GexDlTXWt0hUxTz0
Message-ID: <CAADnVQLxOhcULuV-T3KHo29rmGSdmoShA2UqyVwreKacJMtQFQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 02/17] bpf: Use mutex lock pool for bpf trampolines
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 4:27=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> nope, the rfc had workaround for lockdep ;-)
>
> +#ifdef CONFIG_LOCKDEP
> +       mutex_init_with_key(&tr->mutex, &__lockdep_no_track__);
> +#else

The only user of lockdep_set_notrack_class() was removed from the tree.
We shouldn't introduce new special cases.

> but I overlooked lockdep config for this version
>
> > MAX_LOCK_DEPTH is indeed 48.
> >
> > See fs/configfs/inode.c and default_group_class.
> > It does:
> >                         lockdep_set_class(&inode->i_rwsem,
> >                                           &default_group_class[depth - =
1]);
> >
> > the idea here is that the number of lockdep keys doesn't have
> > to be equal to the actual number of mutexes.
>
> I see, thanks for the pointer
>
> >
> > I guess we can keep a total of 32 mutexes to avoid making it too fancy.
> > Please add a comment explaining 32 and why it needs lockdep_key.
>
> ok
>
> >
> > I thought declaring all mutexes as static will avoid the need for the k=
ey,
> > but DEFINE_MUTEX doesn't support an array.
> > So since we need a loop anyway to init mutex and the key,
> > let's keep kmalloc_array() above. Which is now renamed to kmalloc_objs(=
)
> > after 7.0-rc1.
>
> I don't mind either way, meanwhile I used this version:
>
> static struct {
>        struct mutex mutex;
>        struct lock_class_key key;
> } trampoline_locks[TRAMPOLINE_LOCKS_TABLE_SIZE];
>
>        for (i =3D 0; i < TRAMPOLINE_LOCKS_TABLE_SIZE; i++)
>                __mutex_init(&trampoline_locks[i].mutex, "trampoline_lock"=
, &trampoline_locks[i].key);

works for me.
