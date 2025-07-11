Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E989D20E71C;
	Fri, 11 Jul 2025 08:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222591; cv=none; b=WcFPGNPY1YE77ILSfyCGIIqt+m4KAt8XExveYT+n0HeiYm6EDjb1l5eyl+KFKkakBoyq6u9+xneL5wtdbX2wAJKgWNMQgqST0ddEVgIPGLIWEGdEU52dLeTOC2ALoI7DfmFd+4KVG/LSVfbBLPIxukH5qvlnWx4MNK+Z7r4oXZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222591; c=relaxed/simple;
	bh=uX7kAAr0Zms8GHwI2NhTf9BFEixUQXR5PTdXh5l4plk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tO4GijfdHzl0fJ8O6KRXIMzZqdLjr1TW4NB+WFtbKXd6ooZ1Cz4cA9jL81bZ6CvfetUgGvcAbMfq3PRi7LeuTwDXwtM0P6Dc12jmNdENYxRlcLMtYFTfmwGXI+yu1EmNqwltjZmg6kOFQjRQ0x64V1AF+gM7n3SURII/0d4fitA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igdZymDS; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igdZymDS"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b5e6bfb427so954957f8f.2;
        Fri, 11 Jul 2025 01:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752222588; x=1752827388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSa3YUeww4KG61axfUhT3FJetunA3Fy2YZv9Jh/Wo3U=;
        b=igdZymDSRMlCgx5npODMWFW9Y/oC9pciRRROH3NgHwa8bMAyucOL7/P2QxGma9dm8O
         XC0JqNThAsuujUKsNnKmgws5Yf+nxnCASK4GGt7cU2TjmF/NbN7pV2at4OznZLhk4mDZ
         V3iIR7Ui5Q5FwsYtb4Ia6LxypEqnpjfDGWWj4g01BHGuKkL2qSCK3iq9NNCQzk1QsgL9
         jZ61oWNwSOcdTibWTqLOjQJC4bAHtnwJq00+TXsvy3FmyGETJEuxfHf1XYOV+lkfUHaU
         uzElB+MvCNyeZhhd5k8x5JYpUCM6g3eDSNarYKBO4y6WUm0cTa41GjQijXka2ykRbo2Z
         4Wtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752222588; x=1752827388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSa3YUeww4KG61axfUhT3FJetunA3Fy2YZv9Jh/Wo3U=;
        b=mbqHVc3W/jGgOZJMdgZ64ZWWYB0ucWs5EUzTnJkpNyxlmqdVBVNiqUg6grqjtHYEyM
         XQIsXmykub5GY8t8qjsTSwGozKb1htQ3InAzO3SpB+k3YvnVuVdTeyrWxwQ7IfnUwjjS
         p57xZxMTJxj2+nxo6wqf8Ql2TXJ04++CorN+3kvGLddDRDJbzvIQyW7rzrGRzgyehUHp
         EQURdQ+Z/xBKlbBPE5xam/hPLruew2ew3YmcEjPdbqrcIwD2WhE/EMvIX8eI/cBr4gPg
         eLECUuaF+WMSGosB/pGm+BzDRSLQ9+CiPjpfAdjbziL12qqVbeuW2DdxDyyBBDi99JY8
         72CA==
X-Forwarded-Encrypted: i=1; AJvYcCWYVvVbRmT/sZZVvX6UtyXEDuKEhgeVlJLe3GnGDxOUjEqoPpQxrD1fizuQxdESi8tnQLbkgOyuiDvBTe8di20zzDJ2@vger.kernel.org, AJvYcCWr59biX5F8pP9sr+uI4JRTV7GrPZ0vpmHqrfkaf+bInpYjhgHOVCZaWlxKfj2iYmqwFuLlkle1AnIIoqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7p7Pl+PR40osPbF9j+PIFrEGjLyYRNuIKpVGDjz2kFcC1Sfzz
	PYnkxsvhk3w3k0ETQWvXBnKQUaMdNO3MoPqnL3E945AqyYoX0bkwX9Jv
X-Gm-Gg: ASbGncvElcVhsY6RzGiCPBGOqmCPEfbiD/cb9pxIOEYnKFPkgekN+Ui1SXkpp35Lc1L
	GUIiXIvynBeS5kZ6fsmWszr5jyPumJ8AcX4RSfV6Wx53p6/qB8tdzEA7vgswi1tF296knWoVLrM
	9fpk6cf2T1AcUJUB+WUzBXqnh7Nx6YmJfFmA3wcoql3DSUcNs8EAIG1VxEg/jh/bRFWemnR5ar/
	n+1wXIJB5TKrh8plhZmNDlZtXVRjwg81LW131FjYWJMGPgq7Cdx/+5uBcV8Ugg/fiY6rtJycYY4
	X+tZdWtm7eM8fe8ouFwq/TqB1Ugv3kxv5p6vrsJDtS10R/vDVRpqGfqkY3lXLkknXMb3cqhARr4
	mzyem2Az3aIAX437JfzuNl1w/OsPuYMNLihEg4pfSWhvW0PHeaU9ngA==
X-Google-Smtp-Source: AGHT+IGY9EpaTi9BiyGDdjiVOG/mfSWL/Apd51kiQUUKiH+wJtv1y8Yl0GYgyopVELCC/Vmfmv4rCg==
X-Received: by 2002:adf:e7d1:0:b0:3b4:4790:8415 with SMTP id ffacd0b85a97d-3b5f18d977dmr2104752f8f.48.1752222587971;
        Fri, 11 Jul 2025 01:29:47 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d571sm3908758f8f.57.2025.07.11.01.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 01:29:47 -0700 (PDT)
Date: Fri, 11 Jul 2025 09:29:46 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, Gabriele Monaco <gmonaco@redhat.com>,
 John Ogness <john.ogness@linutronix.de>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Remove pointless memory barriers
Message-ID: <20250711092946.1bbd58ef@pumpkin>
In-Reply-To: <20250709110827.0dce4012@batman.local.home>
References: <20250626151940.1756398-1-namcao@linutronix.de>
	<20250626113520.315db641@gandalf.local.home>
	<20250626160459.soHxOROG@linutronix.de>
	<20250626123445.5b01849d@gandalf.local.home>
	<84o6uatn6i.fsf@jogness.linutronix.de>
	<564f10574f11bd7ca42fcc5fb4d6c5625dc17205.camel@redhat.com>
	<20250708074219.K7BthlGg@linutronix.de>
	<20250709110827.0dce4012@batman.local.home>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Jul 2025 11:08:27 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 8 Jul 2025 09:42:19 +0200
> Nam Cao <namcao@linutronix.de> wrote:
> 
> > So yes, smp_rmb() is only useful inbetween reads, and smp_wmb() is
> > only userful inbetween writes.  
> 
> Hmm, I wonder if barriers isn't needed but atomic values are?
> 
> That is, it looks like rv_monitoring_on() is looking to read the
> current state, where as turn_monitoring_on/off() changes the state.
> 
> Perhaps instead of barriers, it should use atomics?
> 
>  bool rv_monitoring_on(void)
>  {
> 	return atomic_read(&monitoring_on);
>  }
>  
>  static void turn_monitoring_off(void)
>  {
> 	atomic_set(&monitoring_on, 0);
>  }
>  
> 
> Doesn't atomic make sure the values are seen when they are changed?

No.
It normally just ensures the read/write aren't 'torn'.
Atomics are used for read-modify-writes to ensure two cpu don't
do read-read-modify-modify-write-write losing one of the changes.
(They can need special instructions for read and write - but normally don't.)
So here just the same as the volatile accesses READ_ONCE() and WRITE_ONCE().

	David


> 
> As this code is more about looking at state and not ordering, and I
> think that's what atomics are about.
> 
> -- Steve
> 

