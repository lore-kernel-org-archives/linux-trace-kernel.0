Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991A513212B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Sep 2024 19:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726255063; cv=none; b=c8TvOb0/Q/o+1ctT+8MRQ7DxvlsOOfpEg44WpHyJsBktF2e8xrxRO5Fb+/w9//sPPjvWw0N1mDX0q0RiCmcLiNQN+DDgHOFsO0CfmS1GoiUr3PeDHsqiQbB2b5yUvYipgV427iXPhEMVZJxUhxX6zshZcS+oeXYvvPVOno7RrJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726255063; c=relaxed/simple;
	bh=exqxgPF0UdQfaGbZs7b/izy4FYKifj1m0sHOrBIOdKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lChgaEFXOBViYmQGoznVYtKF5B6L7/205pOK2F8k9JcvX/N+XbBmnG/r8IeErxLWmb/6ziUc6IztnX2FSqnrTlzLbubAoQARbR5rnUm/nWyYYD02AlzjeUL0tKAiFm6svDnyvDr2/QtITNoOhmGe8CprzajHome28yYiA9MDPkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tkZGX+pb; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tkZGX+pb"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so369784166b.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726255060; x=1726859860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEBBs3ZiKkkyF3FXeUJY6bD8zJrCWtH/rjqnceHaQ0Y=;
        b=tkZGX+pblNhUp7hX0wYoxhvsjZMhTceLEI0xdJKqcjvjnGD9/RUb2rEayaYURlm5Wi
         i/jppDwIA/4oSKMWyQgGxL9gilEXA6iMhP13K53c00UA4eQarvc99EeDt1b6W7joPa/v
         +3zRpO/0XMdVEGKzuTEQU9H2dfdvV1TsOMZVkikItinUj9mR5dMYAclq5AzZPVJ5aC4b
         yVaz8p2ue0sbsqoKQfUK5UCKzeY7kuP85dPJ/gnd3yNpIVc2UEQSMwfEAgPR2Hl5VQKm
         jJUAhw2s8dtCi/5sF8y+NaQPsmkgjK47H4KXdw2rUlJe7UT/P7ZSH+OyzH30AmI69K+Z
         b9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726255060; x=1726859860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEBBs3ZiKkkyF3FXeUJY6bD8zJrCWtH/rjqnceHaQ0Y=;
        b=lVTQOYwo7oK33y3jBFE/y1AxRpbK7F5l4g/kXC025F2u6O9a+xkFA9+vfDbaT8fJkp
         +8GMP1NqRkcGFmzYgpV4lzcZRPyIH/lrBiRXquW1V8u6KCHfWQEmTkA2hHtliRUOpdB7
         1icypFnn51v20Z2FF11393CrXkHc9vTsYR6cVDkUSu17XTILzxaXOyzAsejAOMjkoWGk
         gLIhEti2r9La69LHeDMiaem7GCAYKJlNdktrhPN1dkgm4jau7oZFtWF6MviNabMBjrjb
         qqqcu62nfDzIk2DvqjX9G8cdhGFr8cRQ+qpFsek97l9PXcdApCpBLeZkU1b5bKFjfxqz
         oPsg==
X-Forwarded-Encrypted: i=1; AJvYcCXG/RzQn10yuaXj0dzz0IbGi3ro6sMdgx6GfX/Us7GCv0tQYPMJlE/CKo4X3zqVhKeAxZPfZEqybtxOZUB7hdMsSOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvd4msBR/5NAQU+GSlDK9OihSY4UU+0M0P111DkxQABUuoYFER
	Gv60SCHsF9wsoTh45fnblFCGH1RzjUvDD0SRfrIBsCywIivTmWaW9Po+uN8jJcpCmzRhQNWWJ9x
	F0q4wlsQlRLIWJUkYRJAE0kh6Ncuph1DNH2M=
X-Google-Smtp-Source: AGHT+IHWtZ8oBZ/r75IG/ZCzOt2Io2yL14++IpNnUCKri/jsmh7LErkKNbEwqZih9dC/IIe59HK21E10WSAVnPAmuFA=
X-Received: by 2002:a17:907:1b20:b0:a86:9c41:cfc1 with SMTP id
 a640c23a62f3a-a90293dab74mr710886366b.8.1726255059557; Fri, 13 Sep 2024
 12:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913-mgtime-v7-0-92d4020e3b00@kernel.org> <20240913-mgtime-v7-1-92d4020e3b00@kernel.org>
 <CANDhNCof7+q+-XzQoP=w0pcrS_-ifH9pmAmtq8H++tbognBv1A@mail.gmail.com> <8756a43fe0b7c3f418b351adb05e7a146d33bdfe.camel@kernel.org>
In-Reply-To: <8756a43fe0b7c3f418b351adb05e7a146d33bdfe.camel@kernel.org>
From: John Stultz <jstultz@google.com>
Date: Fri, 13 Sep 2024 12:17:26 -0700
Message-ID: <CANDhNCpPr-MvQhV7P6at9fQ-UpM_Q9R+S9oVqjHyguOgzrrZZQ@mail.gmail.com>
Subject: Re: [PATCH v7 01/11] timekeeping: move multigrain timestamp floor
 handling into timekeeper
To: Jeff Layton <jlayton@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, 
	Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 12:06=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
> On Fri, 2024-09-13 at 11:59 -0700, John Stultz wrote:
> > > +/**
> > > + * ktime_get_real_ts64_mg - attempt to update floor value and return=
 result
> > > + * @ts:                pointer to the timespec to be set
> > > + * @cookie:    opaque cookie from earlier call to ktime_get_coarse_r=
eal_ts64_mg()
> > > + *
> > > + * Get a current monotonic fine-grained time value and attempt to sw=
ap
> > > + * it into the floor using @cookie as the "old" value. @ts will be
> > > + * filled with the resulting floor value, regardless of the outcome =
of
> > > + * the swap.
> >
> > I'd add more detail here to clarify that this can return a coarse
> > floor value if the cookie is stale.
> >
>
> Sure, or I can just drop the cookie, if that's better.

That seems like the simpler approach, but I don't have a sense of the
actual performance impact, so I'll leave that decision to you.

thanks
-john
