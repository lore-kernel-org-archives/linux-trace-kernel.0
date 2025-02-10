Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDA417BCE;
	Mon, 10 Feb 2025 21:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739224282; cv=none; b=ZEJacuc0cVRYHbL/GT3css7wBwUh8r76xU1O339k+0azCTApqd1y3BkZqs/DwWEZb9n/Ro+dpRf4xL5rCL03qSbzIhUiL5MCYeMhlvL2pTiIbSctiVqYlxxKAQM5yQ/Mx7caTgETz/xEEb7/jN33bnW1MOvEaC5qwI4S/PeK42Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739224282; c=relaxed/simple;
	bh=0jl3t4+o+UGkvnbEfIA+i0npya4uS3/U+IEPYvFH+PI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u10hDvmCWh1jRPPQu/X89HJHJOro11a/mI4G+h8MLFG6LehomKRqG6Rv6/tYf1rfAMBGSOxN9tyqMfpgoIZuEDy4ULKz/BAGgGqR75ed836N7HbaSwDCDNTPh+z4Dr6RVDSkrrLFH5FS3FwVPjMonNyWeBfh6Sd5ILhCJiXX6fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNq6DrvA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNq6DrvA"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43934d6b155so13966965e9.1;
        Mon, 10 Feb 2025 13:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739224278; x=1739829078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EciPgnW1KEiQXxKmPrpoHQSMJwYLHiBFdZkdooJcnM=;
        b=mNq6DrvACiUd6eNNPItEZx7UXnO9nk6ERmLXxSyEmzo3A/wzAhgggoMO9MWWICER+i
         fHoGkaNsJwPdp6LnLvOSw2HPcIgeoN2Lb30S5NA2X9+7vVSkx6RHqOxQeG6fXwxoJbC0
         q0deH8B7zthVzQzHuUIt5VTUOSRVejw2ZEyKQIdLBtnf067nR+gzxAAwcDZcij+K7H5M
         6DBS3DykeU7vIZpuAZ/p/nYokmcl32tuITq+UI2flUW8nDDCHcCiYEyxy0HRzW1PFRVa
         CdOZtr6LjrNXWLvpNhN8wRxaVdNBy2PqWiymMtaRaiXK059diZlfVGEbSoluQNlqRFjd
         QNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739224278; x=1739829078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EciPgnW1KEiQXxKmPrpoHQSMJwYLHiBFdZkdooJcnM=;
        b=HjC/KSXM5Tg2waIOg3MPjjznYvXACmAW7l71qH6wxQwsZvJiRtz50CLyPDbAIVm+F7
         kqZHfaOG21ieRqY+/D/OlsYTaFUJNe5lAoW9TGodFHo5DwEBrXSTb0Zl1+GBLKGlksB6
         vBE3hYqyuC1xrRCe3JK8MXV/bThMnQo2IvUH5Rr0qeG1wHVxsyHAqTX7VVdCwwqr2HHx
         ywjoLtRAEc42ulLr09GPD3ypHAUFo1Scnc6nr+1p/EdcCSRy9bIo9HLp6xom9HeRMlhi
         8+Q3UL/zOBxKIcdIr+c2jNW4iK3HTW8gYduMoR/t0D0P6lCg2pnL+3nu+FL6qBsdp4UJ
         /vSg==
X-Forwarded-Encrypted: i=1; AJvYcCVTv6pZ+L0/yxc2O3alSOr/ckFRFIxDG+HIZsHVRQpFCnkZvifhCIT1SIUmVOxbJTafP5Ov+EAj1mmR7kg=@vger.kernel.org, AJvYcCXLrxF9/vYZSNrLBg8T6MmqFnq7okBsIwzPmFOoXIi255RYVBYjreBtloMCiGH6w8ZGoQjc9JfXBTcmsOA+rJAIH69x@vger.kernel.org
X-Gm-Message-State: AOJu0YzPkQ09ycXaNZf4buss7rqVjoiqZncO22o/Eaomk6+s/jErDg3X
	0FBKeF41Sdi9qA8AWXpZKEtA5+mQSSFMgkRZPn0Jdibpmksy8HH8
X-Gm-Gg: ASbGncuzL9GuXSGcAtezDsWQWBH2gRXk+xC5eSpeonknIzTtGmySN1TqT464NDdLs2A
	q5LHhUmuD86fGTnweIOu7iZrO7Cw+c2iaYXXHBDuGBlPS+lSM7msmlvWxisJ06Pau7ttLzpnBHI
	9hKkKR7+EDrAEuIJJ/H5BiAgDD+qK0xjFw0SnZJu9umtXwaSInI/+Ihpfgm5veisj43hNWE1Ngv
	rdSImHBLQiJX4AAp5y72rIqY3NXdTh4z2UfbcKWHDcUOaIPp82uGm9jqtHo851ZG2ntlFr5EL5j
	+Td+WshzMyJrSAfM/iJKZbcqBl163oXBzSW5bPDKNplZ8NKNuBQN5A==
X-Google-Smtp-Source: AGHT+IFrsqHcB+cYkNZ0Z8ZzR94Q5Jz+YybzaTOr4w16AUyE5Xi1pEvEMdGtDtTmFK1c6TJmIa6gXA==
X-Received: by 2002:a05:600c:1987:b0:434:fe3c:c662 with SMTP id 5b1f17b1804b1-4394ced8c52mr6946305e9.12.1739224278337;
        Mon, 10 Feb 2025 13:51:18 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390db11750sm196051665e9.40.2025.02.10.13.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 13:51:17 -0800 (PST)
Date: Mon, 10 Feb 2025 21:51:16 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, Prakash Sangappa
 <prakash.sangappa@oracle.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Ankur Arora <ankur.a.arora@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, luto@kernel.org,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
 mgorman@suse.de, jon.grimm@amd.com, bharata@amd.com,
 raghavendra.kt@amd.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Konrad Wilk <konrad.wilk@oracle.com>, jgross@suse.com,
 Andrew.Cooper3@citrix.com, Vineeth Pillai <vineethrp@google.com>, Suleiman
 Souhlal <suleiman@google.com>, Ingo Molnar <mingo@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Clark Williams
 <clark.williams@gmail.com>, bigeasy@linutronix.de, daniel.wagner@suse.com,
 Joseph Salisbury <joseph.salisbury@oracle.com>, broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250210215116.4cbf240a@pumpkin>
In-Reply-To: <20250210144432.14c50995@gandalf.local.home>
References: <EC77D83D-DD17-4CCD-9EF6-C4C39FCE16E7@oracle.com>
	<9DA1FAE6-A008-4785-BDF9-541457E29807@joelfernandes.org>
	<20250204220418.35949317@gandalf.local.home>
	<CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com>
	<20250205081635.397eacb0@gandalf.local.home>
	<CAEXW_YQY2zuU+XZjrYWLS860+PJno0nf9WAe1iPU=EyDkA7H4Q@mail.gmail.com>
	<20250206083039.0916ad24@gandalf.local.home>
	<20250210172059.07cda916@pumpkin>
	<20250210122700.3b963ff0@gandalf.local.home>
	<20250210144432.14c50995@gandalf.local.home>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 14:44:32 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 10 Feb 2025 12:27:00 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Mon, 10 Feb 2025 17:20:59 +0000
> > David Laight <david.laight.linux@gmail.com> wrote:
> >   
> > > Hmmm... you lose big-time anyway.
> > > 
> > > All you need is a lot of network traffic 'pinch' the process context until
> > > the hardware interrupt, NAPI softint code and rcu softint code completes.
> > > That can easily take several milliseconds.    
> > 
> > Not on PREEMPT_RT. All that runs as threads.
> > 
> > And this is a feature that we would like on RT for non RT tasks.  
> 
> Actually, this doesn't even need PREEMPT_RT to not hit your example. You
> can build and boot your system with interrupts as threads, and that also
> includes softirqs.

And then you lose lots of receive ethernet packets unless you change
all the thread priorities.
(I don't recall anything that makes them run at a low FIFO prioriry.)

And don't mention the mess that happens if you have hardware that is
raising an interrupt ever 10ms and really needs the ISR to run within 10ms.
Someone tried to do that into a VM, the interrupts turn up like busses.
None come for ages and then three arrive together :-)

	David
