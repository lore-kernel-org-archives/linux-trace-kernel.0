Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C0C1D7E26
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Sep 2024 19:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392091; cv=none; b=nM0+9XPN2Ztf+4FRfdXU6Av9TXS2MrG57oQ7/4+3Og4oGiCIGIN1y6fTqQvCH9UbGrhAYKv/cxUJbkGPPw3mqgc+ka+ueXbO2haXrlwuPavZ+FRaHoeYqp6gj+miZ7hlagTW6Tyg+hJP4vDqzUtpT21o5muF974oN1Nn/wua//k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392091; c=relaxed/simple;
	bh=UShskrRI1DRsJKg6TMK+JzmQnbWj40zzdhGhaCwR9Kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRq8eD9WME3Anng9wccxpbNkucJpxQPnLUVtyQxjO2mcle+3MWkz7/FQTK6zcXXwAoTQb1ACMel/SNpR+cTJ9RGwD1tZlqHjj1bF1VNTLVz20lGPkw1tiom9sOKDIzb0/L8oUsydD1x8IOP0M59h05jeET5GZyTkFrCiFSJbltg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OOwAxc7x; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OOwAxc7x"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8684c31c60so654412866b.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Sep 2024 12:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725392088; x=1725996888; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J2FmMLBB3NwjKynA6ICAmca4TgXkk89mwzwmgF2OaFs=;
        b=OOwAxc7x8/e3Kf1/vtZEgeakKh3T6M9driKDVhFImzL4e0rTqdZyKOqh7gPqmxXela
         KgFr6kSwsBd01tWf3vDvWyWxupUH95NUcjYbYxUAiapZshxJUDUeHieS+ns4McLnOpF7
         3Cjh+9Hmzj8dz09JsdyOmw5WUHYxmuAHvXRaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725392088; x=1725996888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2FmMLBB3NwjKynA6ICAmca4TgXkk89mwzwmgF2OaFs=;
        b=PTyoRH633Pl1SdjgWCDV1w/kNMr3M62l+SvL0VFIyTTClHGOETjcjVdwDuu1lXyWpd
         z5zhJFFaEZbv3Bpt2fpoOn6jnjHrTea9MaalpAvqjKEL37a9ElfiE+ZdIWCJctfDPjLo
         8p0sKQURykWauYvkdT6sdREtBC4YmuxS5q1qhZC6rVJFubKGM9tqeMCK10WWjgzEGgWr
         MpzjIqM50shkgnSOEmgCUDPwJPLIhujljmAR/cnZv1dviWtsrywVSYdSURhpa0ClLbql
         JOY0L8bIomxOgYjPOuz+VZSNrUYp+XEUjZDjVlEBCaPfymGpQMGuYiVRz+jJ2DIHKTsY
         aBZw==
X-Forwarded-Encrypted: i=1; AJvYcCXmYdDgxAKV1PiDTzRLJhIWdUoFfvQy9+7MC2QO4y6OD5lCtdJe9vKsbvcsBweZTdcPDIkgigdqV8O696w0xWnYNB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7jBDGoKARA/hGMxw4sGZNgG+FHLhFvFmtPxDge/k1ASdK7NH8
	BghZDeCKY8LYbQk5J1f9h++XbVCy69VerlCNAKB6qq/+L3WWdGYop3sA/GxIXH4YonNnhwDF6v+
	Ltuz98w==
X-Google-Smtp-Source: AGHT+IFdwF+cBsJMkxMRGsytBJ4VjCs6CzvlE5dSvfF2WFt/XPZ1yDc8aLblm0mtegzgIBSCciLGpg==
X-Received: by 2002:a17:907:7f10:b0:a7a:9f0f:ab18 with SMTP id a640c23a62f3a-a897f83ad82mr1170168866b.20.1725392087931;
        Tue, 03 Sep 2024 12:34:47 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989221c55sm719619966b.194.2024.09.03.12.34.47
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 12:34:47 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c27067b81aso1062723a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Sep 2024 12:34:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDMhB0FyrWWtQYNtHtb+zCRat10dpo/eoVPoAhPMwFFim7y0P4uEe4a0hbDebljiU1Mk0qqPPwotBxMT4UOGVSHEI=@vger.kernel.org
X-Received: by 2002:a05:6402:848:b0:5c0:b33d:5fcc with SMTP id
 4fb4d7f45d1cf-5c21ed52b2amr15503716a12.20.1725392087234; Tue, 03 Sep 2024
 12:34:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
 <20240903073629.2442754-1-svens@linux.ibm.com> <20240903090843.GA17936@redhat.com>
 <CAHk-=wi=qJr4r2DTLDMDh=ryK-x9sciGEeL+ZaWExpiHGyPhiQ@mail.gmail.com> <yt9d7cbso7p8.fsf@linux.ibm.com>
In-Reply-To: <yt9d7cbso7p8.fsf@linux.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Sep 2024 12:34:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0Y+1r+0K3uD9viMU3-7oxAQubGsGQLx_ruk81b-ZdAw@mail.gmail.com>
Message-ID: <CAHk-=wg0Y+1r+0K3uD9viMU3-7oxAQubGsGQLx_ruk81b-ZdAw@mail.gmail.com>
Subject: Re: [PATCH] uprobes: use vm_special_mapping close() functionality
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Sept 2024 at 12:31, Sven Schnelle <svens@linux.ibm.com> wrote:
>
> > Either use kzalloc(), or do a proper initializer something like this:
>
> I sent a patch which does this today:

Ack, looks good.

This should probably be backported independently of the new close()
series, since the mremap issue seems to be a longstanding issue.

                     Linus
