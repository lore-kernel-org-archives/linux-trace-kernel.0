Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ECD79E1;
	Fri, 28 Mar 2025 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743174393; cv=none; b=lv7F0hHMJIS9mckreG8w1yP7SmHEB2rklaak6zzsg5jP+IJVnhWWgzDZ3Kuc34/cSp6rjZApnZyDoJgvjG5O97MxLQMezLagvbEAjy4WhZ68XgvSPGd7y6UtS+Bv2AUoWg2Qwf3I9EqfcCvOEzqi7X5Rx87gEdQzsZBzlbck2rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743174393; c=relaxed/simple;
	bh=Msd4djB5R4l+uchgtEHVjrVjZkqKDfz854vGB8wNEkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Exuu49fn4bFGcBxCnl88c9YBBnlcmCcxO2yMO0jJ70bx2wOd4JlHhwSYB198oEcsBT0nuplZkF736LokHC38G9Qf+casw26ZaIVgUQY7gTGtKJs6KpEAbT+yXFPKLYwlKEKmAWreEGVAaqZUR1cm0JKe3mpp3UdjbhqVPu2tXDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgYLGahh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgYLGahh"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2a9a74d9cso424360166b.1;
        Fri, 28 Mar 2025 08:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743174390; x=1743779190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Msd4djB5R4l+uchgtEHVjrVjZkqKDfz854vGB8wNEkM=;
        b=UgYLGahhw/yF4pHZqHqZmGHu26jEgGdaE8st8l4Gpj+VfpgD+o0A3BTmrhQ1lcQwPk
         xT5BZXyOvMWUxZ7RtzPrvwxtVBLWq1SC3kY33tyS0USyZvfyEG+w/kRt7tSVjRXQyTV7
         UTf/+j+JN6kJtXMH+CRIg9cn8HX5T7f4G8ZN5JXbRS4zzU55UMEh8MS+57lC5b02Viaa
         CeKblFl8ZuEaAlX2+NIK8VpwNjSDhy+92JxaIoG89UQaNMbwbxIPgrF/v8aGQNAGeBYT
         gzbgqS//V6tp3HHTyb24J5izYe/6Yi84tKykeH0cB6rMdVOzdmKcG+CPBZkl5VZupVmO
         txqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743174390; x=1743779190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Msd4djB5R4l+uchgtEHVjrVjZkqKDfz854vGB8wNEkM=;
        b=Ea+HdHakX3Lha9feqIfIIEJN7xlQ1oXUuNAtrtciYAX/kEOWeb/ypSvgoL0YD07uCY
         1fUbCA8iH6jb2FaRTVOo9V8pO+BXPbEgvCa/+cmfl+6P5MLL8Y5mAiBCFWod+WYOrj5Z
         kV0cs4Yr/rlED2nKdYRBL1+zI8PlXxCCBdJiO/71nhjHRjJ5so2cUOaIZGqDhkuZL7DB
         1bAn0amSD/8D25AGpMJ3OkJL2I0vKhkvknlYFUMQ7T9mtc31/LjNE6by/m/QLhKeBBBu
         KncMsfThPYuplF/QP6EFj9c3XVuI1Rpw7BWxq746FuzUtAng1FXr90CTTMES3VvKUdFS
         sgew==
X-Forwarded-Encrypted: i=1; AJvYcCU0aUziBrqLXugnjpPcG6dxmm7f3TrfpcWxUUEceZfXTk7OmcRzIEFTFfXw5kxKlUMRHv0rbyZVvA0bYYif@vger.kernel.org, AJvYcCU78BsEvdOiyfMuCbu2GlaTuLsa/Tw1TDz9+ARrq8PPapFk5jjPEdoIxafqXEpMm0QQP0fkSpB6zK5qd2lR2lmThoJ5@vger.kernel.org, AJvYcCUnBhWnzxJ7NUUdLzjoiZbVgBoeAXMhudnSSw/S+GtJc9KF+FNyDdR9rKnDCSnqUtpvmnX/9DtTNZ8sAe0aH7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyABzTWk5LYvnVxYNLylZAEebPVq74FIXvDYGx0KakoMJwSf3BX
	UMstphhoISDgDiRsLzZkQFWM0+wLxfyvh09QTmRP5fXwy4LjRGFEYCLT/Z885uR50W2GSDrg0mp
	7BwVq+MUfS0iLiHp4YWQbVExnrM4=
X-Gm-Gg: ASbGncuI3V8oIWLXYecZSJxiH1waSuk3tf04Les48PJOlN9TyQb49p8jXTbiYJkApzD
	vDP/OOTjGoeKILzcQ5DZbT8chl0WgEVuKzocdkrUOcsZJyv1p4ApW95nW+YeIcQm5QumEvnn2QT
	oquDWFkowHaqS1ug1hW+V3UabUVIj/
X-Google-Smtp-Source: AGHT+IF3awyMowLWcH8PYZtZ0QIKNGeH7GystPt3Pz6u/xIoaX7e+hcV/huIRE3IqTiua+SWdLXB5i53FCvfcvy67/g=
X-Received: by 2002:a17:907:2ce6:b0:ac3:bd68:24f0 with SMTP id
 a640c23a62f3a-ac6fae6cecemr822946266b.7.1743174389460; Fri, 28 Mar 2025
 08:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321144822.324050-1-andriy.shevchenko@linux.intel.com>
 <Z-KCNy7Qu2vFdwVx@pathway.suse.cz> <Z-apePufuwt19djQ@pathway.suse.cz>
In-Reply-To: <Z-apePufuwt19djQ@pathway.suse.cz>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 28 Mar 2025 17:05:52 +0200
X-Gm-Features: AQ5f1Jolt35aKfTTrIroDhj_MxpPPjpfJR6IiTWJztgRTkKXPo6i2wePW3zd0rc
Message-ID: <CAHp75VeZBUVhGB8mSRFFJ5i70qUxmKRgeEoJzuPtQ5YPWh-MUA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] vsprintf: Add __printf attribute to where it's required
To: Petr Mladek <pmladek@suse.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Kees Cook <kees@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 3:51=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrot=
e:
> On Tue 2025-03-25 11:15:21, Petr Mladek wrote:
> > On Fri 2025-03-21 16:40:46, Andy Shevchenko wrote:
> > > This whole series started from a simple fix (see the last patch)
> > > to make GCC (Debian 14.2.0-17) happy when compiling with `make W=3D1`
> > > (note, that CONFIG_WERROR=3Dy and all warnings break the build!)
> > > down to a rabbit hole.
> > >
> > > However starting from v2 the last patch doesn't require the first
> > > part, I prefer still to have them since the functions, while being
> > > _binary_ printf()-like, are still printf()-like. It also puts in alig=
n
> > > the tracing stuff with the rest and fixes the wrong parameter value.
> > >
> > > These first 4 patches are organised in a strict order and can't be
> > > reshuffled, otherwise it will produce a warnings in between.
> > >
> > > I believe the best route for the series is printk tree with immutable
> > > tag or branch for the others.
> > >
> > > Alternatively the first 4 patches can be applied first as they
> > > are pretty much straightforward. They also can be squashed to one
> > > (as the same topic behind), but it all is up to the respective
> > > maintainers.
> >
> > The whole series looks good to me:
> >
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> >
> > I am going to push it via the printk tree. I think about doing
> > so as a second pull request by the end of this merge window.
> >
> > Anyway, I am going to wait few more days for eventual feedback
> > or push back.
>
> JFYI, I have pushed the patchset into printk/linux.git,
> branch for-6.15-printf-attribute.
>
> I am going to send a pull request the following week
> if nothing happens in the meantime.

Thank you!
It will make us much closer to the moment when we can enable WERROR=3Dy
in the CIs for `make W=3D1` on x86 defconfigs (those that are in the
kernel source tree).

--=20
With Best Regards,
Andy Shevchenko
