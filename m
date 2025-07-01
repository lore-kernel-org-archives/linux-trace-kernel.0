Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5115D149DFF
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Jul 2025 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751335832; cv=none; b=E4BGRFAO2KFXmD3QKDPVrIapBKEglvVohsMVYj/8Jq1fKhkHBhYEUqN+aLz/wmu1nSL4ogPMIB7uun9Kl1NjxWA8UuR8qciz3ibJOTFEFa/YtaeUfKRJ5V5LjJS0JcruAKJwcWJR8LiT9zDSajbXZ04r5VsLK4hrzdNLlVth4RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751335832; c=relaxed/simple;
	bh=chZSupA45hhC66A5Nbn69IBMjngEXaYkp2gQAo5xfl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TfnESKUB9PA2bnZPOHDvSvPDsgSkgk4V/9v0N2ycq8G4ul0055iZ5sGuMxrriPrf1scvolrdNCCL9iLkg89t/VPi0DXCZ/veD6mhpr4Bf+gAe75GTjQyNEWbKBL9YPr1oh1gLO2pQHLu2RnUGrbk8C3IdR/LaGg33v4AgCsqnMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MEFUQOZ+; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MEFUQOZ+"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-addda47ebeaso1088447166b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Jun 2025 19:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751335828; x=1751940628; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=//ycUvlATJpUfVbD8kzQ8AkDWoLdct992Z4BuFsvuYY=;
        b=MEFUQOZ+0WGMFGL7MXbQhVFwa2rZn+0U0qBc6Ihobd0h12Sxfm2RTM8viARA3+JD5D
         ZXuJleKmb9pD2tXYzl11QkiEb4QeSmA+80JlLKd5E2a65w9iYm2gdrlGFZwmch3Qmbgx
         qjOLN3If0QMLBQHSvwOKr/moZ3ZiU8Rcvli1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751335828; x=1751940628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//ycUvlATJpUfVbD8kzQ8AkDWoLdct992Z4BuFsvuYY=;
        b=YbZGo63aARtAWFfo/uBTsXuVTCwUz1sZmiy+wBPHuvfNN8qWNgAfOf1hA5a4lRHGh7
         8z2HPqeuSo2sYjXqF6xlBJl/eXcDOuqegYIoFJbDg4HiQIF6/iV4lKBupV5eNnVRj31B
         nAfVO+9/K/iCm9JhlYZYocJNuN3YWY1CVbT4UZ8B2LO00SLJyj9jARmHxXHcd0/iPTxy
         8ujJDEvR8Pcarcbd104tECXICzlSFLyAlRTICbbN/HXRfvEw5Ir4OWVBU/KaZJvA+Aij
         nHqQEXD57xms+3wsxFXO6cbZo6cELqwWEihe9U7sKZ8GduVqjL1avNRjM9NEYPiaLAuS
         nj/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVEFRjZ2Ixp6ayEXwk2a+phG/KrtPg8HgRdC/vQrsd53b6k6Y+k0MLO0btDscojr7GpHBou+N1SJ+NsAKdyNSxhdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvOy/pldgbhb32M2mFg9TstILbRDCM4Oe/LZ6rW+IomvD30lb2
	HLUVC0V9wG84j6QxvcId8QCZUJqD+i/bLBq1wPeMVoYgtq4Q5H9r4ipo+MlPuHWbR7A9Kievn2z
	I7SPDd0A=
X-Gm-Gg: ASbGnctNGILVeuxnwWCWHMrUcLhDNGFveK2LwWQ6fZIv8Zb4P4gkHUbNATj5AOa2gK2
	7ZWlt7gfENemnLG5ZDCJCwgUK12YfTgrV2MST/wOD01VB3t7nH+qsvDIi79MTtutufTpI8wdOZV
	d1mg3cV2NTDt8UidKgI/LEue3+8ccO/5hUgkWOcD1GwH6SZ0UZGgvrJt4CTc2XQ6nYf/aPqNdiq
	Xb5N1kWcXSfA5zGNfm+Y3DcRQqJX5wfecg9zj5afC/Rs2nCygA92zl77UL0qnU5/F9NHAoghHc9
	DNsdN6NqK5bAxi9Xe6ASBFGuR69TK4o37smzTydocxIlthHyy6IweY26NUWg7jmNAJ4fq7OB2Rb
	XvAV3Sjj52dEpYkS8wnyOQouEG4/J4gTfGqOh
X-Google-Smtp-Source: AGHT+IFC/4G0vwGxK+p2b2dkA6hM39sp0ua79k/aohafqMPjMxk+g21S07245Sjk6oaLU/nmG4x1nQ==
X-Received: by 2002:a17:907:96ab:b0:ad9:f54f:70a2 with SMTP id a640c23a62f3a-ae34fdd97e5mr1468699366b.22.1751335828282;
        Mon, 30 Jun 2025 19:10:28 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca20ddsm786691666b.172.2025.06.30.19.10.26
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 19:10:26 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60c4521ae2cso9280779a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Jun 2025 19:10:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4JpI1waQD94XaeJavRKlzMBML67CnZs1yqVx/pq2jxvR3v/7eJ6grZaDjNfRdmqZ/nmMt4KmoV7j66AfBl6tqPGo=@vger.kernel.org
X-Received: by 2002:a05:6402:90a:b0:5fd:c426:9d17 with SMTP id
 4fb4d7f45d1cf-60c88e750a8mr13090570a12.34.1751335826112; Mon, 30 Jun 2025
 19:10:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701005321.942306427@goodmis.org> <20250701005450.888492528@goodmis.org>
In-Reply-To: <20250701005450.888492528@goodmis.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 30 Jun 2025 19:10:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiWOYB4c3E-Cc=D89j0txbN4AGqm0j1dojqHq3uzJ+LqQ@mail.gmail.com>
X-Gm-Features: Ac12FXySn_pdB3lLzP12Vm5gk2T8ADap-82-V7Zr3xVfhtlJ2K8g-e3E8mi3zzI
Message-ID: <CAHk-=wiWOYB4c3E-Cc=D89j0txbN4AGqm0j1dojqHq3uzJ+LqQ@mail.gmail.com>
Subject: Re: [PATCH v12 02/14] unwind_user: Add frame pointer support
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Jens Remus <jremus@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Jun 2025 at 17:54, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> +       /* stack going in wrong direction? */
> +       if (cfa <= state->sp)
> +               goto done;

I suspect this should do a lot more testing.

> +       /* Find the Return Address (RA) */
> +       if (get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
> +               goto done;
> +
> +       if (frame->fp_off && get_user(fp, (unsigned long __user *)(cfa + frame->fp_off)))
> +               goto done;

.. and this should check the frame for validity too.  At a minimum it
should be properly aligned, but things like "it had better be above
the current frame" to avoid having some loop would seem to be a good
idea.

Maybe even check that it's the same vma?

             Linus
