Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D993B305680
	for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789320209; cv=pass; b=c1z90GTCi1PG8ndjpOK43BPMzmLlV83NJ9qLcSi0eFtatC6P2KCQds/Z3DHPTdy0Qm+npNxmMVx1QJlKvCXwqHhPDe6hF61M+KMriwnGVNnJ/bvyzjYIMhqPAKkFJ5UpnPx4HaZXpyivD9a1RAtwTrfjG71OCJa3X6hRxhvM0NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789320209; c=relaxed/simple;
	bh=BLEwIST5LDO00rmpC7KBzeJd7ltokL0w81FVqI46QfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mkqvf74nanRFvXq83cKYzq3qAajAH67qOaLIFEq+77wVsD6B6NEUgGrLuo5nnBFzuh2nQPebLkfV50vJo027lEdhf8fqOwLT5JWlQVrqBD0FCZ6QlCmGMqieZ6JEG4RutPo776519ey2iWmH5AGHMtOzIhMT3coHgkWQtYYZ7eY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=phHKbybF; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phHKbybF"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-80576d65d8eso1625210a34.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 10:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789320207; cv=none;
        d=google.com; s=arc-20260327;
        b=so9hyv5bQtyYVECDHcRTRUQHyy2nWqQrrfpvpmw+jstsrKdV+6K6EgRhgQS2biuX0K
         HCM7A9OBM3BZvWcN3VtMkk77eeh3gU1CsI/hOwf/Bg45xKNuRHCtPvOV4xSnmUXr7Hmk
         aPByIa+gsU94oYEUGpzhXaBfkuvYSq9rT8rmKgY1VVVcxqmxdY9nscCYh5hiyQ/s6S5Z
         wK8gsGvkEduPKd2w1DD3O+ibVgnvvEHmt8N9rGwaHz6d3KtiHqID+4EgOxuSwmxIYGyB
         O6ombxTXDxTjpQtVAR/6aYFeHFXJ07RaVcQ+2z0dzpoGOQnZaUEuIkAwu898Ex4Ta1pf
         3D5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=116h53yk479YgNueOJV8xZVBkZ6OS1X3DH0lCR+acgA=;
        fh=bzS4lM/aJPXUVVzM7ZXP2ar0QUo2xn/bvWtI5toWN9Y=;
        b=nUYQuLDmkfRnAjzaJZB7rIDbrudpLLeiO3etqLnqVERtEl2TSBzKc+wUFy6JXKEEuF
         +dxKxs7k7mCwS1mOK5+tQeNv7gFh7a3oruemsxls1PDCrMwJKxwaOyNf+uPqoTNmswKp
         EAlsA0v3VUDpp/ETv0/mEEwf4M7pCKGlmD98Mr6uEco62SIY86YI7uFmP4+GCeCdKDYL
         gRwViJpq4cf3yT00LBh5m9KBhxIK5g+e6epCMcyrQLjFtQUZ2wmi+DpuGk+UBD95Rvsb
         5P6ctvDbghZ7rpsTsXweDQa0DhkBYjPlfCm1mCFl0mvaZKS/tpr6LCuPJH//TFiToc7y
         1y2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789320207; x=1789925007; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=116h53yk479YgNueOJV8xZVBkZ6OS1X3DH0lCR+acgA=;
        b=phHKbybFFNf+l7D+Ra0bNUn5OZU3YEkQVjJOQc6F8zEEk70aCTp3LFJpkW3770YZ7H
         40VvOJLgp5H7V84VRI4q4Ba6u5k180f48R9D0CLXKCsT7Q+fPZ09HSMTcvzkrI/fQdDa
         7ND4l72lIjVIIRq1XJjojw/tuCreLZVjqTnKujClV7DjVsuC7H7rf+VbdjeVntXNVP+U
         X1NAgNYaaRRPyj1xkzzMNrhjb/8iqDoUOKOBxBp3CDtKsDTAASgSMbegXFs2Fm4mi2GQ
         O2WvSnyPpytYcr63FHLyoF2a3+0GC7XmXZKrfi6kl8qHln0sumxwxfp0n/jOVMzddELg
         XWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789320207; x=1789925007;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=116h53yk479YgNueOJV8xZVBkZ6OS1X3DH0lCR+acgA=;
        b=bQVqaQ9aXgpEYxdwa3WD1bSKdmvkJ+Q8CcKx9bJ36mMqRe21U8XKsfWSPAnWFxI3Gi
         TO6ylzCBIPNRFlW7S2Dy7S/JJrVYJucbfo8ZLX02/LHmH6CzndcbOw0mUEbuz3TPchKg
         00vHwoPMavWiaFkjF6Vs6gkXwBnozP9zag0f6BUhVjwv9ZUCCrvt8JBprIyCF0xxsHw/
         oySt5OdY80hsqt4Ue/1hNUzbbEQz8nOQ4nRxVrOQ7ni7E9jFYkrRznMscZIMBmKi4f4J
         0Gvg/R5G0dYYXW7n3BubUD71S7gBRe+xAHxrpJNy/hHHsSM2dn17dHz6wa1Il0yuSy3N
         nK1Q==
X-Gm-Message-State: AFuF++m7ft53PlVjitbOH61al+Zt1zl1417zFtvo5CAnVakaVI2VsZN/
	iFOGZhwbhiF7zV3xsEQBgG1faG1Fau76NswXL9dhd/KidbdZqpzkRPy9bcUl7UH+kli6O1KcYMw
	ivCYrRFpKCNY046NRR2Cv7iRmEIAZpksybw==
X-Gm-Gg: AYBFou0QrEqTR0Y27DkOUyl5GSNJVxLHb97lOSytXJRx6hTuEKUn+MChAcT3V1bkiIT
	sKB5GSZwdaw2BSWLcWZmKeN3fDXAngBi/2uBSqjGzbnGxCRREoeVTTMZzDb5Cf7mrcRbHvcvWG9
	msB0tLBYNzCgUEsWeRaVueO7l5hWYLgP1QaadA1q4Ksc7FPb6MZUW42ATp1jqAW7xa9CExZYtPx
	X7CV9pZp3rlFxVGP/6kSWtK0GdmJvqeRT2/DLjd9ZLiQYEIjKdFTUx1FEs4ZxJn0XdxrZQ3+KVB
	GLZYOthZySk9kwR9grxoM0c8uC8Ig+QYTgFZ+IcrLzdvvlEwNv2s0MaOZG2H6Ju4+YXKkS7CT54
	ObJsGULZLzw==
X-Received: by 2002:a05:6830:2815:b0:7fa:ac4f:784 with SMTP id
 46e09a7af769-80400c14ad7mr10314969a34.16.1789320206490; Sun, 13 Sep 2026
 10:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913133829.15307-1-devnexen@gmail.com> <20260913134906.6E8A01F000FF@smtp.kernel.org>
In-Reply-To: <20260913134906.6E8A01F000FF@smtp.kernel.org>
From: David CARLIER <devnexen@gmail.com>
Date: Sun, 13 Sep 2026 18:23:14 +0100
X-Gm-Features: AcwNN1WzO-nerU_lJU4svW-jy3jtAyomNFAZ7_LJcxUSoMWwJnch01xQbz8oPGs
Message-ID: <CA+XhMqz=DgaOjVoNxbm6BUtQ22+5JBQkqYVp6wBD2sSntuFsvg@mail.gmail.com>
Subject: Re: [PATCH] tracing: Take trace_types_lock when dropping the
 buffer_meta reference
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This time seems legit I ll prepare a v2 at some point.

On Sun, 13 Sept 2026 at 14:49, <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Reading a per-CPU buffer_meta file for an offline or unallocated=
 CPU causes a NULL pointer dereference.
> --
>
> commit f8d13605bef286fcf84c808917e1ab8eeeade189
> Author: David Carlier <devnexen@gmail.com>
>
> tracing: Take trace_types_lock when dropping the buffer_meta reference
>
> This commit fixes the error path in tracing_buffer_meta_open() by using
> trace_array_put() instead of __trace_array_put(). This ensures the
> trace_types_lock is properly held when dropping the trace array reference
> if ring_buffer_meta_seq_init() fails.
>
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -5881,7 +5881,7 @@ static int tracing_buffer_meta_open(struct inode =
*inode, struct file *filp)
> >
> >       ret =3D ring_buffer_meta_seq_init(filp, tr->array_buffer.buffer, =
cpu);
>
> [Severity: High]
> This is a pre-existing issue, but reading a per-CPU buffer_meta file for =
an
> offline or unallocated CPU causes a NULL pointer dereference.
>
> A user with privileges to read tracefs can open and read
> /sys/kernel/tracing/per_cpu/cpuX/buffer_meta where cpuX is a CPU that has
> never been online. This invokes tracing_buffer_meta_open(), which blindly
> initializes the seq_file via ring_buffer_meta_seq_init():
>
> kernel/trace/ring_buffer.c:ring_buffer_meta_seq_init() {
>         ...
>         m =3D file->private_data;
>         m->private =3D buffer->buffers[cpu];
>         ...
> }
>
> Because alloc_buffer() only dynamically allocates cpu_buffer structs for
> currently online CPUs via CPU hotplug callbacks, this pointer is NULL for
> unallocated CPUs. The subsequent read invokes rbm_start(), which immediat=
ely
> dereferences the NULL pointer:
>
> kernel/trace/ring_buffer.c:rbm_start() {
>         struct ring_buffer_cpu_meta *meta =3D cpu_buffer->ring_meta;
>         ...
> }
>
> Should there be NULL validation for buffer->buffers[cpu] before allowing
> the file to be successfully opened, or perhaps a check inside rbm_start()
> to handle it gracefully?
>
> >       if (ret < 0)
> > -             __trace_array_put(tr);
> > +             trace_array_put(tr);
> >       return ret;
> >  }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913133829.15=
307-1-devnexen@gmail.com?part=3D1
