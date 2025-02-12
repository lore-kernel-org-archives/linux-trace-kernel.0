Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7E224E4A8
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379187; cv=none; b=NlJLdTkL3I0QZ7msckD5SnPPPC39g8mwPIbt9z4R3heuZWc21PW/KKNRbEKIip+mEdRjKa4g0KuBUmJEqC/bFtQL2YUli0Mqg8KWYYzfGwDRPemwyN4BUwebp+nqc47/ILS6PUbJOjpI+wZyomhL8M91yAS6UC1MEh3iGJh4C+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379187; c=relaxed/simple;
	bh=AMNpujMwxEF0lqcT39JFds7LDCNGNjFeFh/KBzfjZKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJTdAVS5ONmpY2twC3aRajZ8uMYexRQfWDSZrSa8KM6w2L2wbEWLK8SXIRXoEGWRc7LPMID1jB6I4Jz4XR3kGp4RJ5BuDIVLvIZz+JKf9iPnSv/iKz2EcOGx2AubZ5hWl6PorouBXjBFSICP4h/J0qvGypc6aVmQBCqUA8uzz44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mkooxIuT; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mkooxIuT"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dec85c8bfcso903a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739379184; x=1739983984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIV7IWz0yjddKyv/beIYGjRoq6XNzByBQnMEf8PUBBs=;
        b=mkooxIuTZNDO/4grzWX7KKOLTDysqlPWw0U5bYrYw1GI2DcVW3nOrtrnGluny6v29I
         /1Yl2guKh4LYCyXIpcpOKOe6VOybo82rxUlfdl6/j1cRF0iYPHeK3GtwST40b/XynGKZ
         n2d95SY+UnDGEQl0Um4A0qW2PudLm3K20G+CjxLFqo6Gy+8YvLD1z1/T4F7T3SFQEr+J
         ZlJXdXfmRG9yhdB1BYkdDB0EE1maKUgNkSHnAHC+x1vwZocSXjDyMqnwfaGJlXOfw2No
         UzHN/8FEgDa/0g5dTiXBfVYJ+SEpJcTTlpmjRDxhLemNrpJ3YzeYvmin9X2wwKxLftYu
         FVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739379184; x=1739983984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIV7IWz0yjddKyv/beIYGjRoq6XNzByBQnMEf8PUBBs=;
        b=c8d4Ydfcpvv+/mWUUESBclbbfO/uvuXoK1vNy5fH6pjNEYO/2664rWyZqxcCko3QdE
         Pm+FYhE7n6rfIEkMluY1xegGO+mUjqbMdBLrdU7S5PYLInR4+oaEldjbYGuS7LTx1LJM
         PitzW1wOWicCoa1apQPZX0Ts8PYPWJXc+TF1saUC07+jnoyB/V3BKFDI+cjUeytKLrvV
         5fsmqOohZT6AFptvVk1qzCmE1g91LJbmwkM1zIMVvuH0MNIJASwBKuM5PLAFfUZl1twQ
         K8MSDTFAlOIaUza+qmud0gXwzV67Bm81W4MkDfsslC8Qv57PivTp5gx6+btoim8oLP4D
         yg1g==
X-Forwarded-Encrypted: i=1; AJvYcCUF8ELmH5hp33TWSvkeWJ1683sO7VRiCkLlr+PIuM+rph4NJenPayWlOB+ko6ysRs6tHxQzvZ0SGmvTwGJ64Ntr3pM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3LYnzYyKhg1hHkp1s5LSuba3rWsVcFCdG6ocQg9qRFQlGbogz
	A6d0ap1brHT+T8Udc4UTDXOwR5hQQKORBo6LJ0OvLsk+LCd3yn6rJlU5tf9LTtaDKTBBjZQZ6RA
	qeRKQG1dn/SJsJUorEjD3b3J2Af0Zisq0qnVP
X-Gm-Gg: ASbGncvPgsW5AKW8KP1XFez8O4C9YE5X4v+f0Re3a9NtLXJpH2IyCgjDmoRfJfkDUVd
	mB5DPiwbcpkACdoNiZr+wU6ro3iiK/wUlcJFZedk2M4R+EuWSLYbkExSnwxATjfNIc7rd5Q==
X-Google-Smtp-Source: AGHT+IHGz5vufPcLaUodmyGxxGtYNbNdz1AykWXGGm3hYrwe+nD3RKGRGnrjo4hwPRDJ2Dv82yKvK06Jw364LFyYOsk=
X-Received: by 2002:a50:cd5a:0:b0:5dc:5ae8:7e1 with SMTP id
 4fb4d7f45d1cf-5deaeb262camr123278a12.6.1739379183792; Wed, 12 Feb 2025
 08:53:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <173881156244.211648.1242168038709680511.stgit@devnote2>
 <20250206081225.GI7145@noisy.programming.kicks-ass.net> <20250206205449.5f83a585945ae6eb0cc15483@kernel.org>
 <20250206121328.GN7145@noisy.programming.kicks-ass.net> <20250206123307.GO7145@noisy.programming.kicks-ass.net>
 <20250207085959.b3e9d922eab33edf885368e3@kernel.org> <20250210173016.0ce79bc8@gandalf.local.home>
 <20250211100914.GA29593@noisy.programming.kicks-ass.net> <20250211105002.31b5a517@gandalf.local.home>
In-Reply-To: <20250211105002.31b5a517@gandalf.local.home>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 12 Feb 2025 08:52:27 -0800
X-Gm-Features: AWEUYZmCWP-_bDLn8AzH0F5wUOCKagIjnDD4PTtFP-tRkjvGdXKpxK7eMOGff0U
Message-ID: <CABCJKudwf11wAbv9NdKh_FN-Z+pLaupMHJxNGtRKK1-1D94hCQ@mail.gmail.com>
Subject: Re: [PATCH] ftrace: x86: Fix a compile error about get_kernel_nofault()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Gabriel de Perthuis <g2p.code@gmail.com>, Haiyue Wang <haiyuewa@163.com>, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 7:49=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 11 Feb 2025 11:09:14 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
>
> > I was aiming my patch for x86/core, but if there's a reason to expedite
> > them, I can stick it in x86/urgent I suppose.
> >
> > Just need a reason -- what's this compile error nonsense about, my
> > kernels build just fine?
>
> Masami,
>
> Do you have a config that fails to build without this fix? If so, can you
> please reply with it, and then this can go in as a quick fix.

x86 builds with both CONFIG_GENDWARFKSYMS and CONFIG_FUNCTION_TRACER
are broken without this fix. Here's how to reproduce:

$ make defconfig
$ ./scripts/config -e DEBUG_INFO -e DEBUG_INFO_DWARF5 -e MODVERSIONS
-e GENDWARFKSYMS -e FUNCTION_TRACER
$ make olddefconfig && make -j
...
In file included from ./arch/x86/include/asm/asm-prototypes.h:2,
                 from <stdin>:3:
./arch/x86/include/asm/ftrace.h: In function =E2=80=98arch_ftrace_get_symad=
dr=E2=80=99:
./arch/x86/include/asm/ftrace.h:46:21: error: implicit declaration of
function =E2=80=98get_kernel_nofault=E2=80=99 [-Wimplicit-function-declarat=
ion]
   46 |                 if (get_kernel_nofault(instr, (u32
*)(fentry_ip - ENDBR_INSN_SIZE)))
...

Sami
