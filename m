Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565FB1E3DF2
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Nov 2025 01:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762391764; cv=none; b=nKbGk3hZhnhTmP/Y2pMxavMptqYWoScgDzyQBXYTPPbxLyYmLRupWzf3Kxh9/ncHLmD2GQYrw2WdIG6V0oQbBN9sF4pdid7u2TDnuif6QFL+atxUKXv2wRiQWrdVNdZgjyi5E5CNaqN3Ez1XTe7BU7zspiOCmLI+Fjz73wXgc7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762391764; c=relaxed/simple;
	bh=sScwC5J9gcWja5lx4I7NtcSR1bu3zkgvzjbBKH7PL+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SlUbYZEZocu9YgP3/2FB9fZiZI2IjauxEAG5rHSVf91OkvUEQMIT3fi6HILGripQ+pjUAzc0SOVH3fDpO5HxzNWz9GHmWCPs7kSQ9QKB5vYnEyq6y7nyObXqo22FTlpALVHu+qT8/mrTx6hTR0npaHKVX5H/a1LmBJdMFLQ+spE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzHhomhd; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzHhomhd"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso385621f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Nov 2025 17:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762391761; x=1762996561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sScwC5J9gcWja5lx4I7NtcSR1bu3zkgvzjbBKH7PL+w=;
        b=jzHhomhdlmEYwqLjhmAXzuXfkTf5v4CSwXo//4ZyBq9xVNkM9vpS9ew4ydjmLEf9B3
         d8aj9kpMsDkNgGmHARrjtdHUix3Yk6wtNOiTI4RxPtkQFlF72KWeAE15CqXRzuF8KbFU
         UTEW+BibjFbqAOZ1+eN03eR/grg0rabxwhVlQ2jo3J+zxLFfsMpovouJ1TjbQJ8wyaff
         oYueo90g+4bws/ncaFTcMngKGAyUApM3e8otzBk75txVwSmobTxHM5C6Y55Ce31IZerQ
         D0XDYNWhJzAvNpg/jw6M0N52MAyiCmdch43TKcpoPDIqwIhmx9uKWJxHmnBs1+5opBph
         Tgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762391761; x=1762996561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sScwC5J9gcWja5lx4I7NtcSR1bu3zkgvzjbBKH7PL+w=;
        b=Uf9kLJMhCjqQYNqRgR4R2MEnZ64reNazebBVESoLbrVz4G4zpHZSlc7xmXeNB6D69/
         MdTxTa5ALvXNs2T71p664dpHYszSUfKZQUsi7QKlUhy320nlmzQdoNJHTLL1RqNJMt1l
         J8tFgWg2RYy9wwxYakDsSI/hr0XyDmWUXDLy15gSdOIo7ZP6eUE2aUnsNO6BDxmwC0C3
         unUIBhqi4iV65lUjNMX359UMBrZrcUzjbljJh+Q7DSORNnT0bd8upO8dzS6oTDF4/+AE
         Gj7ecnBKAKUzqrvS3bLgrvsJEYqKgOpnwNtesFK0tMYd5pl5e2rpWU6hD1zLP9v6qODr
         ednw==
X-Forwarded-Encrypted: i=1; AJvYcCVPhOWFa8NJiBGe9XQnGPwYuYfrRZgxUU5/15+dJ2C806dlPtiq5IdjOJlRZtzY1zgC9TWAJ/zbBB8Ij9/aCf7gibo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxfn5xtalpcXXltAhDoO7NV8o3NiOpb8NuvRimZjGm24YYM/hc
	L9h9d/6COFtuwc1OeOsaCBjOpQ8hhs4hDAzQinJtpe/Uq36fwFie42gQU4IzS+BG1n0laciJk0b
	sYODmnaytsZUqlfiIXXzvg6rKyUYzb+I=
X-Gm-Gg: ASbGncvx/Du2r+3ReFDkQHCbPwAFfPoYpAOzDmZRWQ0/5EGfr1Zd82OixQm9hRFoZpu
	SGZz+rkPnymeScXFZiXzvsIHOdL7I8/qKhDQ4bW5SSRx+sXjQO9PnsQRlJvOKs9OHrri84imv4L
	Fc2j0qvfuYxhUD961S/+vC1GXM7brEIJZ1ziYR/gQe+IfFxbJcJhN7tCC6GpJGARRP5Sxl2LtBq
	Q9gwzBKO0Qy24Uujd+yd6cmmgFnfrHbrA0DQnvn54PkBCjVmcVG91ye5sOY/2dR3lmDLe5RigBV
	lNtdmlxgyYPXp4WH9w==
X-Google-Smtp-Source: AGHT+IHh2sDshLNmqDEmy7BbJ5cTdAvuAOdPqoxaY2sjpbctDzSymGzC6WNsncDo/8BxKIayC4E9em6MkxZeBSmo1Ts=
X-Received: by 2002:a05:6000:258a:b0:427:526:16aa with SMTP id
 ffacd0b85a97d-429e3311c0dmr4604870f8f.58.1762391760385; Wed, 05 Nov 2025
 17:16:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104215405.168643-1-jolsa@kernel.org> <CAADnVQJRv+2NT2TGd7nXbOtx_Cnsg=kOJuikOtL9aEdUVmwvag@mail.gmail.com>
 <20251105100359.2e6eeae5@gandalf.local.home> <20251105180436.369bef64@gandalf.local.home>
In-Reply-To: <20251105180436.369bef64@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Nov 2025 17:15:49 -0800
X-Gm-Features: AWmQ_bm6CvZzMiP5kwn6kO1G2SRE_SOftXbYCMJwbyDdpH0jhvVrL384rgUxlOc
Message-ID: <CAADnVQLHz5dwn=m5XeA7qc=jvD7Nf96drmKGDsx+o7zK9-GHWg@mail.gmail.com>
Subject: Re: [PATCHv3 0/4] x86/fgraph,bpf: Fix ORC stack unwind from return probe
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 3:04=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Wed, 5 Nov 2025 10:03:59 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > Let me run this through my tests and then I'll give you an Acked-by and=
 you
> > can take it through your tree.
>
> It passed.
>
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks. Applied.
Will send to Linus in a day or two.
