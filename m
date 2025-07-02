Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193892E7BA0
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Jul 2025 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751472747; cv=none; b=MtzV4uEpHG1UnLnzQLS9o8Ro0LpG16heeO2utYZifjB2N65zpPXRv/LHXvW1negpPVRbNBSUC7xkmVn39iFThPe4JtV1QF+EhA9qptnpBF/QbeX7/8gDTs0CcTmzsPWtgxykf0ZR4Rp/OyNpPtrktYfuZ/i5YH+vcVT3EPUSkNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751472747; c=relaxed/simple;
	bh=m0eEcaCjmUCFL4JFaEiBzPDfdxn8QHFuAUdYAEKfPb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQixtMkVg6RUopWRWgm7pcY/lFr3FZfas9omuoUwR6fbQa+1TUQaeLDIZkz0En9MIuoL+k0Z8cZr9JsbK3yCYDDIEWiDIVfZZL+1RRhu7CxyWfRex/bMd7T7KPCP3J8MKwtN77jEdjSPDhDajLlLmu9d0P6/2cl+UI6n3kb83bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O95zJTfR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O95zJTfR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751472745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EUYWoR42G+SMmKsDPy2iaqrLNIu9+Nuw9et8Q6pFC+U=;
	b=O95zJTfRvtpkK4UZa6ULcWtoPUOxO8uDMYoZrtIpPwc985YLfmq7wkei+MpIGS8adFFozF
	JFXCdt+OEsIYuCRaS9VRbCHrb/cRfy3UI8GgGyY1Gh4OEkm51rSNm11JtE6HGCCeAlhUco
	HU2P7Lhhj6rWUt6QmdV4dHp1rsVqVAA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-IIHQ6-4uO4qUSjpx1R2--g-1; Wed, 02 Jul 2025 12:12:23 -0400
X-MC-Unique: IIHQ6-4uO4qUSjpx1R2--g-1
X-Mimecast-MFC-AGG-ID: IIHQ6-4uO4qUSjpx1R2--g_1751472743
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a42d650185so61058581cf.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 02 Jul 2025 09:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751472743; x=1752077543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUYWoR42G+SMmKsDPy2iaqrLNIu9+Nuw9et8Q6pFC+U=;
        b=rOGhvh1BfJ0Z7+JtKbZGV8lwgqlefMhosxaVv0r5aq3/YOPihQRVGx7XwhSuYsJDFI
         Q19ytVTiBTe1XSWy+zU9Op9r80FFNOyDvw/u38E18O5OXNzR7OBnN2DBjGz71rXl2D4r
         KOJUfMfZozIxzrv91dLq1QvtQMJzI0RsURcI5uc2GaoU2Guk9oJqkakyWwMqB/9FR5Xn
         24k2toSkqsbRYIjjY+VtjNQosXf6atneTw1vS3kzsJH3mCTim56PkvAx2V/KW24rz78I
         3DiX084+sgeT9WaXWnYv5a3RgY8es54IKn3pLZJFUJVINCfmMIf6spFuOt+LWIgEPFQC
         LMqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCaCU8idkyg6o5mfAghlQLpotpYKKlSSS0o/WkGHzynI6QVjo2GXN1Mv1cDwTeMxGgxl/hDTMow/WdTYjxy4rj5yA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrA+7RCCnDoZQ6mVDEe3mTCcVQQv9gDAwW1RvdinvqPfpn5qSa
	XHL2jfc0wWqlrIpFMJ09u09+GCh3AZPpWh9Mxm+cQlAwMb61Q3G0Nv/g8BSIDUughi+NM7w/vtl
	tcm8FuoyT8q9GP7H4KgoAxIS5Vvmm13yoks+OrYfcLTD+U4uy//m1zNq28J4moJzvkugFwgOO3m
	Yz8kjuD9TpagYyCHvvZmjONnH0KE6bg+P8O0xjKwfENxENeflp
X-Gm-Gg: ASbGncsTc0VbT20zudwg+E3dyffcQ1L3lnYHlZMy2PIulWZWAMUz9TAXAJgM1YQ+d9a
	kwgt6CW46Lm3Br3DVNQzxs1Q/kDytEZcgtIAt1iHOVdhn7aXDqCj2xB377HYlhLAlrCDck9tfYA
	9aai4u+V9Jt6uuIIt5PCVfD/vEVeNX52KAp6nF
X-Received: by 2002:ac8:5a8e:0:b0:4a8:eba:afa with SMTP id d75a77b69052e-4a976a3727cmr65408541cf.52.1751472742503;
        Wed, 02 Jul 2025 09:12:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLnGgcGhxBcVfguvFJiZmlK/0RzO2gvvQsRBX2MAmcT2pXIrn00MLL/gJHBtybAndawS8Bg8/32exWz0tC//w=
X-Received: by 2002:ac8:5a8e:0:b0:4a8:eba:afa with SMTP id d75a77b69052e-4a976a3727cmr65407891cf.52.1751472742090;
 Wed, 02 Jul 2025 09:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612104349.5047-1-gpaoloni@redhat.com> <20250612104349.5047-3-gpaoloni@redhat.com>
 <20250701181119.7b0bc5d6@batman.local.home> <CA+wEVJarZben=F3Dw0A8_tvAAR7-qb4PrjCj0AGFoq=DH1RJwg@mail.gmail.com>
 <20250702111245.1fa23138@batman.local.home>
In-Reply-To: <20250702111245.1fa23138@batman.local.home>
From: Gabriele Paoloni <gpaoloni@redhat.com>
Date: Wed, 2 Jul 2025 18:12:11 +0200
X-Gm-Features: Ac12FXwM4LZQpznS--1r7Sy5LekmCvpoP3iwhSrFZmt-bmCIWn0LWN2GieA0ff4
Message-ID: <CA+wEVJbjhLmA4ZR5w7s6QDCfjET=Pf2J9PsFhC2wdO1nQ5YY+A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] tracing: add testable specifications for event_enable_write/read
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	acarmina@redhat.com, chuck.wolber@boeing.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vIcbsS9-FdJePzDuRp_mbv2L1F1tQBF9pcPKlHGGDHk_1751472743
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 5:12=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Wed, 2 Jul 2025 16:59:29 +0200
> Gabriele Paoloni <gpaoloni@redhat.com> wrote:
>
> > Mmm got it. What about
> >
> > * Function's expectations:
> > * - This function shall lock the global event_mutex before performing a=
ny
> > *   operation on the target event file and unlock it after all operatio=
ns on
> > *   the target event file have completed;
>
> Since 99% of the time that a lock is taken in a function it is
> released, I think that should be the default assumption here, and only
> when a lock is taken and not release, that should be explicitly called
> out.
>
> And also we should remove "This function" we know that these
> requirements are for this function.
>
>   - The global event_mutex shall be taken before performing any
>     operation on the target event.
>
> Should be good enough.
>
> If the lock can be released and taken again, that too should be
> explicit in the requirements otherwise it is assumed it is taken once
> and not released until the operation is completed.



>
> > *
> > * - This function shall format the string copied to userspace according=
 to
> > *   the status flags retrieved from the target event file:
> > *    - The first character shall be set to "1" if the enabled flag is
> > set AND the
> > *      soft_disabled flag is not set, else it shall be set to "0";
> > *    - The second character is optional and shall be set to "*" if eith=
er the
> > *      soft_disabled flag or the soft_mode flag is set;
> > *   - The string shall be terminated by a newline ("\n") and any remain=
ing
> > *      character shall be set to "0";
>
>  - The string copied to user space shall be formatted according to the
>    status flags from the target event file:
>
>    - If the enable flag is set AND the soft_disable flag is not set then
>      the first character shall be set to "1" ELSE it shall be set to "0"
>
>    - If either the soft_disable fag or the soft_mode flag is set then the
>      second character shall be set to "*" ELSE it is skipped.
>
> I think the above is easier to read and is a bit more consolidated.
> Stating the status then the effect is also easier to read.

I will add all your suggestions in v4.
Many thanks for your review!
Gab

>
> -- Steve
>
>
> > *
> > * - This function shall invoke simple_read_from_buffer() to perform the=
 copy
> > *   of the kernel space string to ubuf.
> >
> > (pls note that the check on cnt has been removed in v3 that is out alre=
ady)
>

