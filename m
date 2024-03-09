Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC84437169
	for <linux-trace-kernel@vger.kernel.org>; Sat,  9 Mar 2024 20:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710016855; cv=none; b=eVJ64omiOSO0NIFg/OZYYIt6nWtuIBOaZSZSDbCldYYQnxRclD0ItU2nxWrn4lOIZQeddA1LV71XU2XSYP7JrjlSC3/fBbnSlRjUJtzEkxfPWpflVUw1zJWl1UqkXVOUHD6bSFdRv9aBmhOQIv0YP7Bxpfw/ZQPQ/cizX5eeyyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710016855; c=relaxed/simple;
	bh=uE50W8MUy4lSTRYg4NWhzIY/9N5XBckWRq+A+J3xEsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CU+KVlVNQU3nR682EPoGTAtPoKIfygLIxUVNfPqNYc5CIhaua+F9ciwB91PmE1CgmwtUCm3t4sO0XeV4X67ncxshzGzUfEYp2vTznMQIFXkvfiRKJk96B3y8QffDSsMhkNigoCISAXI6nyqsTzaXusFBgFChGAeZ4LMPiBs0tC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A81inLTu; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A81inLTu"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e4e673d9abso1277947a34.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 09 Mar 2024 12:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710016853; x=1710621653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tscT2usgPffMVegTTqmjfELkm+wIQF6i7UxyEnNlDB8=;
        b=A81inLTu9O0JRGj9yH6+ls4wHeiBTAedT6gVLKCjkN1LPr3rsOCxufCxoYHx6iY3Tc
         f7GNfiFoA4FHRT1iUBH6Cw3D0qsIta5vIy8nRMVYVumTsWFbBAXAnOhREw6jUJLY9rCJ
         lVQWT+qm7xQbXk6wG9U1jEt82gLRPGO6Ptcv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710016853; x=1710621653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tscT2usgPffMVegTTqmjfELkm+wIQF6i7UxyEnNlDB8=;
        b=qjR79NWVCoZzIoY52nQXbj650cyTW5TLj5G1Nd4BxHe6GarNn0YMUS4DBwBALNmOWm
         Kzd4JrxPk7C0+XXamfz4CQVDVrKNhvnGbK8zapBmObrEJtPbkgFvpYnzUYiUA1iww6TS
         77by+5NqMqfLgINv1dij/xZj3n4CV9UYNqLK2/GRSfiIDQCoVrkp3F+Jc5bDMStrKXof
         aP1rRIItAKiInSYFqLOirFpbKIxLovxlKqTP+luq+nTtxCUlkH2Bi7iOSFPiBgJAInpv
         DvdDpbqwjA2qtqmNL2z3+8j5OqGgGmaMNoEo/A5cSuXGk5kkxB3a0xigP/Y0eESXYNlz
         /xWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw0TMdcZjo3Uh3Wf3FnqMFg3r0EN4EeDCqBHWioAzw98RUgxwdOwZlN45xTT7HlF2KWLVu3LW8QE1pub8yoYAbDaDgaWqWQb3arwX+Vqs79LFt
X-Gm-Message-State: AOJu0YykpzXTX30yzYSl7J0hDRX5RMDRxWEeAKr7kShJQQlTdc5quu4x
	O7xibpQ5TyW7T7rHQNUZgvXiaSL5+HAnOxmtIwPSKQ7vztN7Kqlwxvy3XKbP+A==
X-Google-Smtp-Source: AGHT+IF7Luizf7uSrZ2SAOviO1ISARKjfHr7TfzwMsR7uciQGcduXiH2Ic34WPKwRdGdLC5UYxSUoQ==
X-Received: by 2002:a9d:5a05:0:b0:6e5:21f0:d028 with SMTP id v5-20020a9d5a05000000b006e521f0d028mr1375411oth.28.1710016852854;
        Sat, 09 Mar 2024 12:40:52 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k8-20020a170902c40800b001dca9b21267sm1688698plk.186.2024.03.09.12.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 12:40:52 -0800 (PST)
Date: Sat, 9 Mar 2024 12:40:51 -0800
From: Kees Cook <keescook@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, suleiman@google.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Youssef Esmat <youssefesmat@google.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/8] tracing: Persistent traces across a reboot or crash
Message-ID: <202403091234.DE25C77028@keescook>
References: <20240306015910.766510873@goodmis.org>
 <202403091016.5CDF0E2EE@keescook>
 <20240309135116.40f65cee@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240309135116.40f65cee@rorschach.local.home>

On Sat, Mar 09, 2024 at 01:51:16PM -0500, Steven Rostedt wrote:
> On Sat, 9 Mar 2024 10:27:47 -0800
> Kees Cook <keescook@chromium.org> wrote:
> 
> > On Tue, Mar 05, 2024 at 08:59:10PM -0500, Steven Rostedt wrote:
> > > This is a way to map a ring buffer instance across reboots.  
> > 
> > As mentioned on Fedi, check out the persistent storage subsystem
> > (pstore)[1]. It already does what you're starting to construct for RAM
> > backends (but also supports reed-solomon ECC), and supports several
> > other backends including EFI storage (which is default enabled on at
> > least Fedora[2]), block devices, etc. It has an existing mechanism for
> > handling reservations (including via device tree), and supports multiple
> > "frontends" including the Oops handler, console output, and even ftrace
> > which does per-cpu recording and event reconstruction (Joel wrote this
> > frontend).
> 
> Mathieu was telling me about the pmem infrastructure.

I use nvdimm to back my RAM backend testing with qemu so I can examine
the storage "externally":

RAM_SIZE=16384
NVDIMM_SIZE=200
MAX_SIZE=$(( RAM_SIZE + NVDIMM_SIZE ))
...
qemu-system-x86_64 \
	...
        -machine pc,nvdimm=on \
        -m ${RAM_SIZE}M,slots=2,maxmem=${MAX_SIZE}M \
        -object memory-backend-file,id=mem1,share=on,mem-path=$IMAGES/x86/nvdimm.img,size=${NVDIMM_SIZE}M,align=128M
\
        -device nvdimm,id=nvdimm1,memdev=mem1,label-size=1M \
	...
        -append 'console=uart,io,0x3f8,115200n8 loglevel=8 root=/dev/vda1 ro ramoops.mem_size=1048576 ramoops.ecc=1 ramoops.mem_address=0x440000000 ramoops.console_size=16384 ramoops.ftrace_size=16384 ramoops.pmsg_size=16384 ramoops.record_size=32768 panic=-1 init=/root/resume.sh '"$@"


The part I'd like to get wired up sanely is having pstore find the
nvdimm area automatically, but it never quite happened:
https://lore.kernel.org/lkml/CAGXu5jLtmb3qinZnX3rScUJLUFdf+pRDVPjy=CS4KUtW9tLHtw@mail.gmail.com/

> Thanks for the info. We use pstore on ChromeOS, but it is currently
> restricted to 1MB which is too small for the tracing buffers. From what
> I understand, it's also in a specific location where there's only 1MB
> available for contiguous memory.

That's the area that is specifically hardware backed with persistent
RAM.

> I'm looking at finding a way to get consistent memory outside that
> range. That's what I'll be doing next week ;-)
> 
> But this code was just to see if I could get a single contiguous range
> of memory mapped to ftrace, and this patch set does exactly that.

Well, please take a look at pstore. It should be able to do everything
you mention already; it just needs a way to define multiple regions if
you want to use an area outside of the persistent ram area defined by
Chrome OS's platform driver.

-Kees

-- 
Kees Cook
