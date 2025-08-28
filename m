Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BAF2765F7
	for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756406398; cv=none; b=VDmW3sB9l05IMBLmPtPMwegfrUCH7ElCaEZrCpftRg4GVDSm7pwDxKWGGYqcorv6J6tHT8wAOQwky+w5M2lw1Cgr8KZsJoZXcarOn6mJcZZt5wz0gDLd6U7UnxEPaJdAx6RUNj0LqiNkb0FmfLNctZ3HQOOX8/AFq2OSgS5SLxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756406398; c=relaxed/simple;
	bh=KHlidwqQkhRRqz68j9Qh09NEV+gPpDi3h+EEr17Y4rQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qO0hc2wMVBU6yjsOhHJIxT/2T/dK0nYmdWcuo14R+cXwwYMHciqIxJKNCd42NOHt8D+pd9mV2XPTvH+S9sYTNAZgdTR2bMYIwsnV4GmnBh/1RjXQqLKmWI+Em6LcHp6qWBl5qx0Kbiu5NbfrtGjI3Ojsge+EVhl7yQeAS4++HgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W2u4nBP7; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W2u4nBP7"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6188b7550c0so1728217a12.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756406394; x=1757011194; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zk4/XHzh8fN7NJt1U1cc1xXgNC+2AfvluqXsOt7pkrs=;
        b=W2u4nBP7hIh6uVKpD0C1cNGY+xMYhIBmzmafM/lfStC2ppooY1cT+Ufe0osk9XEOuj
         jcAPPDZCuOvSyAZTw54b8WXuav/Viwet62zntQiT1Rrxh6IiSu16RiosYr7LtCJdiNk3
         XsoG0KAi4TqddkPoeEciQYuJ8m972C7tg8sl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756406394; x=1757011194;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zk4/XHzh8fN7NJt1U1cc1xXgNC+2AfvluqXsOt7pkrs=;
        b=Ja0WAtnp/Z+qkVfNRxV7slAv6HyYA2m4xGiIMqGFs/sW7NPrmNuBW7Y+5Gu3XBDvkQ
         3cs8yn7Tinh60tlqZxIkWPlXwK2FhqIYoNT6tQQEtikeg3t1m9+jSm+ObH+7jT3wpbUP
         DtJxBcI2apb7cMgHoZbly2StWwOIlmSw8E9mesu1B5d8zBd8PaIrfd8TJq3bzKmWhLFk
         kZCtYY3SWN2VV3dgm7/1Rwx3nnb4jUfP5qcLpd3ZWmedZJhkPNMBmlCUqETZ194lL2l1
         tCV49rScWekWq8bvyPmCO8vfFVS9A6GXWg14pOSl6D5ct33uBvvEq33rUAlV1vTzKBRR
         K11g==
X-Forwarded-Encrypted: i=1; AJvYcCX/0VrRH8uF3CQ5yPbpB6EKf718EHvvX7ETgNe7tptsD4qY/b4DsJIWBARcGPJLP1UXenPiJ3VgJLNIZQbT+OdykHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNlO+JNY8XeTLs5JYaK6zRk9J/Ed93Oompw2GF4Es6KOoH127i
	QXledvbRg+61yqZhdX7reqv/G3Hnu/iqGuk19c33WHJnapwPMvrHDuWgoLvMffniP/fQ+fcm76/
	O/YV+FyA=
X-Gm-Gg: ASbGncto0DUpOfFe7jp6lEzIUgwyTxKpO9YpiAYEnyd/QyzLsZhnnBFR2yUkvpJSYfR
	7d7dRGqHR7LvFBf5eSNdIcQojOxVQyyXnsHzs/zZb4YPCR4zHgt/SMBr3LCZQI5Tm/dYbM5olUW
	REH34nHdi3cjtB9FNIvif73VgcqHaYB5nur9qzy10SSM/CDPKAjcnPSWB3YjKLm64mxw9KCmlFD
	/iheRls7y1xqKNLaK5dHDVcH4MM8sKo3Ea4hTlxPthix0HxhZxEgr1M/8JX4LYP5S3iy6aNbiYl
	FWv1sJ5rsU7xtRrsEd8s88Fmlb/CQ4NUHOMalaN0smRBcziGz4ASrFjs7ZHnTcINwZrhQxeekT7
	EFdmfTmH5dTTxlPA+9mgiDEK5CwpjNLyN9AZVTQ2Yh7zjx7AjphW6f/LZYt/zAn4gj/D8seqvmj
	kaCy8Hcv0=
X-Google-Smtp-Source: AGHT+IGDEePqSq06dbEW/w383+JOPdQmE76ivZ739uSPaEHlqytID0LR9H5MXFxF8LwZvGn8uHT5Ew==
X-Received: by 2002:a05:6402:2346:b0:61c:79f6:37f with SMTP id 4fb4d7f45d1cf-61c79f605cfmr11016530a12.20.1756406394139;
        Thu, 28 Aug 2025 11:39:54 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc214bb7sm172431a12.13.2025.08.28.11.39.52
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 11:39:52 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afebe21a1c0so199525366b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:39:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXDkHKy4bWO6gajm25j76gPdkC5COkajzDTvJ1iyhLawTtHMO0qFPfoEirfozRVPNXbwAShXvuUIjUPW3tfbliNwjA=@vger.kernel.org
X-Received: by 2002:a17:907:d8d:b0:afe:a121:c466 with SMTP id
 a640c23a62f3a-afea121c81dmr1115762266b.18.1756406392000; Thu, 28 Aug 2025
 11:39:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org>
In-Reply-To: <20250828180357.223298134@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Aug 2025 11:39:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
X-Gm-Features: Ac12FXwObny_n6wQ-ugpdD6HjGwdsHVCsiy2fjxZ8DxqXIznImh_eKBzj6tMsaI
Message-ID: <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, 
	Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 11:05, Steven Rostedt <rostedt@kernel.org> wrote:
>
> The deferred user space stacktrace event already does a lookup of the vma
> for each address in the trace to get the file offset for those addresses,
> it can also report the file itself.

That sounds like a good idea..

But the implementation absolutely sucks:

> Add two more arrays to the user space stacktrace event. One for the inode
> number, and the other to store the device major:minor number. Now the
> output looks like this:

WTF? Why are you back in the 1960's? What's next? The index into the
paper card deck?

Stop using inode numbers and device numbers already. It's the 21st
century. No, cars still don't fly, but dammit, inode numbers were a
great idea back in the days, but they are not acceptable any more.

They *particularly* aren't acceptable when you apparently think that
they are 'unsigned long'.  Yes, that's the internal representation we
use for inode indexing, but for example on nfs the inode is actually
bigger. It's exposed to user space as a u64 through

        stat->ino = nfs_compat_user_ino64(NFS_FILEID(inode));

so the inode that user space sees in 'struct stat' (a) doesn't
actually match inode->i_ino, and (b) isn't even the full file ID that
NFS actually uses.

Let's not let that 60's thinking be any part of a new interface.

Give the damn thing an actual filename or something *useful*, not a
number that user space can't even necessarily match up to anything.

              Linus
