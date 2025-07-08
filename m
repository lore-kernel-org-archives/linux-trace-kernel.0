Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37AE13959D
	for <linux-trace-kernel@vger.kernel.org>; Tue,  8 Jul 2025 03:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751945936; cv=none; b=QhAVTyAT1a+jDllAT8IMpVQrxWhjPaO8SNi85+S4vl9oWEbV7Gs7pAoyWvqNJjyYeTFL/BX9OP2EvZQKDRzyadXKjY6kZbYWPBA8WyKP4WmxQcKhijEqF5PEEnGiqx2RJAM1d4WCwt352oHUUF4IPpzaUROfmH/qQ3i1TpfQN/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751945936; c=relaxed/simple;
	bh=ngQvRTDNb77/II45kf0Htc4COiMKkjz3h+Tg9M3hNoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pyv0hypkrcpwW7+srsdXhI5O6dVCUJAWlSa/UinLsBmfJ4K7negq7FREmzyqg3+P1VseoxIOrXmTFjIHu7mDN9f10RVUiAz8TPJBTZ6R+EpQEZLW6X/u6bWnjsN8t7bNerwBQNzWRSp8LvcLol39Nb701N7autKsvqV8bJFVc4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F0XdwP33; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F0XdwP33"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae0d758c3a2so642286266b.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Jul 2025 20:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751945933; x=1752550733; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OvkINbyTdUcHfBHAuLeuJlwUIwFpUBssPFgUpHXAs88=;
        b=F0XdwP330qjiSW2gYaMj3+17vssubfP0mQkQefY0NOnH60UmvTe9Pem/6X6N3/TOss
         C6ywArj/JZcDOfXpTAUBxZMVzDZr/dQnAL9qFPsDe9oFvhBSc7viV6Gj37dnZfpRTGKk
         mO19i5swt4Mmth1hggw4Ha5ywDEe+t1CtZKxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751945933; x=1752550733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OvkINbyTdUcHfBHAuLeuJlwUIwFpUBssPFgUpHXAs88=;
        b=mb5xHPngLDIQ95hjQgVW4NfTVzrDbMe7B8jJIRZjNUPtuaztwd70mufLZYZOnrQjqg
         AV/Fw9dxLk6It+rDRkJ7Asn2mSrpX/nBn5zJSmv7ARgBWmZyZThNNPcJv1U94GGzr6W3
         3nnF6sQ1yuLJDQ3c/o7gowQ8Q35K8XmPg6ZbyIDeQUPYZQRzzNMS17YcMxSFIdwKOiVG
         KZ998g1Uok+iujbhpweTUeYqBVzWOGjcGpyIigF9dayQXvtfCRiA8NsXlL+DAquvVGzP
         25GiGzC4h+DdJ7txsDRiIJi2bjAmeNURpR46iaFeNkTuQyAPcfLOHE/3IlClDamYWMsN
         LOXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNj7eOHowqIxfeGeS2hNVZUPn5OukJWCM3S3XL2+8fRvb+BhCW1HTWcJMqk7u0C9DfrxktBIWFPNp6uIry+G2RR3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4eDyKDCuGVjCtbpitdboDhnABZ7vGYslvXaficgCbtlc0MV20
	Ey0gPJfzH5yAKiigQroQzo8PPxJE673D2ZD0HWLlZxzvTD6v2Lu0hfSFDyj2x+mMUP39p04MAQl
	VMu14OUxjzg==
X-Gm-Gg: ASbGncuqF24ddmYTvceLPbowBqmRRX+Be1YDVb0ne1EPxu4VeU0SI7D5F6KPNneu6cL
	DXWmNg8p1vyp6QoRzvW0RDmXItJieuTY2NHYurU8ZKrK7pNPW1LuCwHc+7bPpR+To8OUt253d3t
	h35e3GIeRJZnAUCBfOWJEyUUJOZZr6AGlwS/fxU/R60iTDcTCVmVPK+90sbBbmPOwqZboD0H0YW
	ezchMkXD6Bfl7mt2Soe1yHZsRkw0B3JY0WGnA6PCiskoxmfngBrB1FFci/m7dpqD4WtJ+v8O7SU
	wqnW05Gbvw8DhmVagXjnZKLt8Hll/kvjfCm7CzpirGSNG5AteYQqVbjTZs8B45pDH37I6T84xig
	NF+LBu4U22l1hnl77l1xED89Zqis9Ze1d2fem
X-Google-Smtp-Source: AGHT+IEycfPqGH3WOozMfPmagQFRlvVFcNQo7vr/wWxZCmFwJJGg67ZEn3wSASeO1gKJ1Jvj/mUhaQ==
X-Received: by 2002:a17:907:3f17:b0:ae3:bd92:e69b with SMTP id a640c23a62f3a-ae6b0b1ebbcmr138120766b.7.1751945932977;
        Mon, 07 Jul 2025 20:38:52 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f692d101sm821864966b.54.2025.07.07.20.38.51
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 20:38:51 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ade5a0442dfso629966066b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Jul 2025 20:38:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKlEVwDHliZMalk172FJ3fIsXmPsGYl9G7p+9nuVFLessS3uSBfqu0QGwNAXEIY2TuW51c1a+/aT1d6dcapu25nmM=@vger.kernel.org
X-Received: by 2002:a17:907:c89f:b0:ae0:a483:7b29 with SMTP id
 a640c23a62f3a-ae6b0e7e526mr127666166b.49.1751945931447; Mon, 07 Jul 2025
 20:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708021115.894007410@kernel.org> <20250708021200.058879671@kernel.org>
In-Reply-To: <20250708021200.058879671@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 7 Jul 2025 20:38:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=widGT2M=kJJr6TwWsMjfYSghL9k3LgxJvRard0wtiP62A@mail.gmail.com>
X-Gm-Features: Ac12FXw7XrtMv7eiXSoEnutRZCfRzsH4c97ToPOt-fI15G3BOCR69VhCXEriwaQ
Message-ID: <CAHk-=widGT2M=kJJr6TwWsMjfYSghL9k3LgxJvRard0wtiP62A@mail.gmail.com>
Subject: Re: [PATCH v8 10/12] unwind_user/sframe: Enable debugging in uaccess regions
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Jens Remus <jremus@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Jul 2025 at 19:12, Steven Rostedt <rostedt@kernel.org> wrote:
>
> From: Josh Poimboeuf <jpoimboe@kernel.org>
>
> Objtool warns about calling pr_debug() from uaccess-enabled regions, and
> rightfully so.  Add a dbg_sec_uaccess() macro which temporarily disables
> uaccess before doing the dynamic printk, and use that to add debug
> messages throughout the uaccess-enabled regions.

Please kill this patch, and stop doing stupid things.

The whole AND ONLY point of using the unsafe user access macros is
performance. You are now actively breaking the whole point of them.

If you need to add debug printouts to user accesses, just don't use
the 'unsafe' ones.

Or add the debug to after the unsafe region has finished. Not this way.

This patch is disgusting, in other words. It's wrong. STOP IT.

              Linus
