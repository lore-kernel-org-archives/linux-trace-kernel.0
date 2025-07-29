Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ED522538F;
	Tue, 29 Jul 2025 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753781116; cv=none; b=es+U4gw6+hhq4qIjie3tSFj+dxgjo7zLvvoOZAVWupNcUc07zKIeu+avTVBmvpkejIMB2cVcLayggHPHyT+Ju92XQ8XW3p4LmnfOoYPl5Zwe4sb4civPXfmv3AodwazDOkmc2GRMHVACcyQHfcdZWhDq1in2tuYEAqDmEQTtNn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753781116; c=relaxed/simple;
	bh=zsIlyDbe/9vp13CYcPjW2VGpNqvobZLaPhl8J1jLrXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwhoWNi+6bxDoKCCoQdwmSnuh3UWwVaIc7808X75DyrdQNoR5AgcTA24Lrn6+V+S2g4oT47bH0jdnx3AfHGmJNuedueztejoF8YXhnaEGf3/jCiLBGI2njkSvoAIZN8InHpZz2G1iivFVsheJziiPYiqR5esKxZuh5ey7LcuJoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RzYNewqu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ox00Llmc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RzYNewqu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ox00Llmc"
Date: Tue, 29 Jul 2025 11:25:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753781112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pt8oWGslc5ihVf6NvVfPmMDljgiRVVmqqeymCbsYuJM=;
	b=RzYNewqu+V5/ClRv/NytaF+VuyjZE2vnP+sbqfsVry9qulHzM6XdJ7/ol32t5jvNi3Ns2h
	0nkWN8mV4Tf2cJGxBPHIp/8/myp/EeMmj3t+qu9dJ/4l7Jk1Egrv3Br3uzfGJ5vul2Krwl
	Vd2sIfCSBVTikGk4ZPPaP6J7NXOK0I9+dS7BjeCobfnG8aPh9XwA0mMORAHYoHww0ez0f2
	xlO2NZZh6E7sCyHgxskaolV9+4ZKhVciG7WEDaSxM0IxtYJPmtSkw9xHkcya04UT96QmQg
	Qkwk0YpKuwgEk7BFNeqEUe5Srobg6SrLkQU7ZjyS0WQmK6AKpfe6xg0p1YbNzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753781112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pt8oWGslc5ihVf6NvVfPmMDljgiRVVmqqeymCbsYuJM=;
	b=Ox00Llmc1oIQKjdRolyam144mAMl4pqgbFSX52S+koJsFhOFqrChF+PqVUtojhVY6PVpVL
	bzy5g1wZd/O1kuCQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v5 7/9] rv: Replace tss and sncid monitors with more
 complete sts
Message-ID: <20250729092510._Hq3RWF_@linutronix.de>
References: <20250728135022.255578-1-gmonaco@redhat.com>
 <20250728135022.255578-8-gmonaco@redhat.com>
 <20250728155332.sbkepHj7@linutronix.de>
 <76d7e572aae2ccd1699a461aded7a6146f6d8215.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="daT6BlFr6QFIQYUW"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76d7e572aae2ccd1699a461aded7a6146f6d8215.camel@redhat.com>


--daT6BlFr6QFIQYUW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jul 29, 2025 at 10:46:51AM +0200, Gabriele Monaco wrote:
> On Mon, 2025-07-28 at 17:53 +0200, Nam Cao wrote:
> > I gave this a try on riscv64 and observed some errors:
> > 
> > [  620.696055] rv: monitor sts does not allow event sched_switch on
> > state enable_to_exit
> > [  621.047705] rv: monitor sts does not allow event sched_switch on
> > state enable_to_exit
> > [  642.440209] rv: monitor sts does not allow event sched_switch on
> > state enable_to_exit
> > 
> > I tested with two user programs:
> > 
> >     int main() { asm ("unimp"); }
> >     int main() { asm ("ebreak"); }
> > 
> > The two programs are repeatedly executed:
> > 
> >     #!/bin/bash
> >     ./test1 &
> >     ./test2 &
> >     # ... repeat lots of time
> > 
> > Any idea?
> 
> Mmh I see what you're doing here..
> Those instructions are supposed to raise some sort of exception in the
> CPU which apparently disables and enables interrupts without raising an
> interrupt handler tracepoint (the discriminator for this monitor).
> This lets the monitor believe we passed the time a switch is possible
> and complain when it actually sees one.
> 
> I still couldn't reproduce it on my VM, yet I find the timing a bit
> strange: it's alright we handle the illegal instruction like this, but
> do we really end up doing that while scheduling although it doesn't
> look like an interrupt?!
> 
> Could you share a bit more about your riscv setup? It might some
> configuration/hardware specific thing.

Kernel:
  - base: ftrace/for-next
  - config: defconfig + mod2noconfig + PREEMPT_RT + monitors

Hardware:
	qemu-system-riscv64 -machine virt \
	-kernel ../linux/arch/riscv/boot/Image \
	-append "console=ttyS0 root=/dev/vda rw" \
	-nographic \
	-drive if=virtio,format=raw,file=riscv64.img \
	-smp 4 -m 4G

	riscv64.img is a Debian trixie image from debootstrap

Test:
	echo 0 > /proc/sys/debug/exception-trace
	./testall # see attached

--daT6BlFr6QFIQYUW
Content-Type: application/x-sh
Content-Disposition: attachment; filename="test.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A./illegal &=0A./unimp &=0A./illegal &=0A./unimp &=0A./illegal=
 &=0A./unimp &=0A./illegal &=0A./unimp &=0A./illegal &=0A./unimp &=0A./ille=
gal &=0A./unimp &=0A./illegal &=0A./unimp &=0A./illegal &=0A./unimp &=0A./i=
llegal &=0A./unimp &=0A./illegal &=0A./unimp &=0A./illegal &=0A./unimp &=0A=
=2E/illegal &=0A./unimp &=0A./illegal &=0A./unimp &=0A./illegal &=0A./unimp=
 &=0A./illegal &=0A./unimp &=0A
--daT6BlFr6QFIQYUW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=testall

#!/bin/bash
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &
./test.sh &

--daT6BlFr6QFIQYUW--
