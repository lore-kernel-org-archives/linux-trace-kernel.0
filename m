Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B147EEFE
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 22:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706655527; cv=none; b=hzlDuhkMoBCZF45QnkpccBQhaeFvYJiveUP2GWhvk3b5MJbGtjfIRFJR2GsB25Ln5Dw1F/cmL/u4hTg94y+zLyejYAp1cjZVEXOLPTK/4O3q6mhGjTyuCMiFH0DU4uuzDymqmULEp4U6zp+Mz+oFJFBp4Jk9/8JNxCQg6EXDQO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706655527; c=relaxed/simple;
	bh=w8/uJ+SUEqNhrF6n2qTlW5Zxi/j1BpjjVRW2sAz0Ev0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qyllZ7K4sNTAdlTX+vbm9Q/1q7sP0AnL9dLL1ySKREv+iJrlDGtvczg/4QNOT6uF3/5CC30M1ta6MrZIGyJMPL1RH4qBJJggkAF1gsOG49n2QDXr31M9WQstlzOr/mobydvhtTE6pVQnUQOkizFEo7uPLQhsPus7PFG1Usiq75E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PAS4TnT+; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PAS4TnT+"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a34c5ca2537so510183366b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706655524; x=1707260324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6u8d8IRFtua7Qk5gvgpajAZgmyBQzeYWdWgDLsMs/FA=;
        b=PAS4TnT+HqTTmhj8K/EgraHFzDqiDc5zlim3dIQ/aWgPjXcsbmdhD7fI5U+MBx3AGz
         AriMr9riGT35t3a21Uxqua9NIIZUM7QvXx4wQHuDW9w2/tC2Mjr5wfguFGWLtz3aSPUC
         q5Zakcf2Cda35esbE7Th12GMTUHLnGPa9Vfqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706655524; x=1707260324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6u8d8IRFtua7Qk5gvgpajAZgmyBQzeYWdWgDLsMs/FA=;
        b=XLfs6cjOu30F1V/YAbcgeU9WFYsr8rN3ckPgcwiIePJ4iDYJrzrun6VAboTM+g5jhi
         QZBvQt8M1Ek9VQLj6HKXc+gq2s7YTXdmIRpPMK5N96UruFMyPClb6FMn27bqXqALqHUw
         GUWQPNkkQ8Y3kEyx6+93I+Sw1VuTYqlsENmYUne4TbJjoHmrRfYjpKpDqhi+AyZefBOz
         gGUsQyA6ej9JIoHPKx4LyrBwiTBBcyF3Bz1Da+xsNuJe8WjSWmJQgIzG2v1ZQ9kJCODN
         VTtO2pGbXQiwCMAmwyGFDPzcBclsp5VHCiflcxO1fSjRFFt1fFqboj2Oylv4ZiA1aVeW
         AR8g==
X-Gm-Message-State: AOJu0YyvEjwApeTCT1JBSrGG/iv7cMTOc9lMEfadP+ZdrGMOYInz0ydb
	Y8DfnOLIJBVSJq1HDFHm8Dawe3pIeZjCLji1P7ZjJeDWQnGiNkY3odwBIH2bN02RZTsKjY+WKAW
	q200r2g==
X-Google-Smtp-Source: AGHT+IHiOEc5kbpzHf8M3nImeqMMLECxBZRx7Az7zy6vfRZYJkgw/uevNIR9tswD+EWkh8Dh/QqGdQ==
X-Received: by 2002:a17:906:13d5:b0:a35:4d7d:77af with SMTP id g21-20020a17090613d500b00a354d7d77afmr6316059ejc.8.1706655524098;
        Tue, 30 Jan 2024 14:58:44 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id vw16-20020a170907a71000b00a354f8fc19fsm4263285ejc.214.2024.01.30.14.58.43
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 14:58:43 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55eee4a042eso3765045a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:58:43 -0800 (PST)
X-Received: by 2002:a05:6402:2692:b0:55f:6f08:d75d with SMTP id
 w18-20020a056402269200b0055f6f08d75dmr227786edd.21.1706655522944; Tue, 30 Jan
 2024 14:58:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-5-torvalds@linux-foundation.org> <20240130155550.4881d558@gandalf.local.home>
 <CAHk-=whD=9qTfhYVhH+d44KbwefC_vnRAjqz-pthcSn1p5zZLA@mail.gmail.com> <20240130175603.5f686e46@gandalf.local.home>
In-Reply-To: <20240130175603.5f686e46@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 14:58:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgTKsxPYyys-U5guyEUDb63MtfTz4y+r6cgKT52zBNOpQ@mail.gmail.com>
Message-ID: <CAHk-=wgTKsxPYyys-U5guyEUDb63MtfTz4y+r6cgKT52zBNOpQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] eventfs: get rid of dentry pointers without refcounts
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 14:55, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Remember, the files don't have an ei allocated. Only directories.

Crossed emails.

> I then counted the length of the string - 7 bytes (which is the same as the
> length of the string plus the '\0' character - 8 bytes) to accommodate the
> pointer size, and it's a savings of 22KB per instance. And in actuality, I
> should have rounded to the nearest kmalloc slab size as kzalloc() isn't going to
> return 35 bytes back but 64 bytes will be allocated.

No. See my other email. The kmalloc sizes actually means that it comes
out exactly even.

             Linus
