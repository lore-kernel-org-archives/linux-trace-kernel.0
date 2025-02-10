Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A242253AB;
	Mon, 10 Feb 2025 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739193978; cv=none; b=V8I8BUmFNwgGoyqta2mDm5WC44l39U66Zxnrf1Ujg18/kkl2JEprZHqNv2useoTfJE0GgqeB5QhSDk60UPTqQFrFs472OxFfcjNR7srZxgU8DRlGnX1KH0a1xMzm/VnKnMDvj4WAiZeqQcpvRKxNDlU8xCfAUYVqCY37VxB8J6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739193978; c=relaxed/simple;
	bh=v+ySslqC6hQ61c9afr9eOiYKr5W7FK5IzbCp+h+Y07M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTfpMR3cqQF6v3XwMNZ3DQ76m/hKI/Q4EFiALWRca06x1IsVLnYKBAbK5whXv71GDv07rNxFRUUvGBisNABIa+GNlp3eWqO67XOeZWmHExdLrW9cvpEoA4S9xho04mIJPIEwlIBDqd2GxHwxcX1knkXrTDgWE1q+mHK7l631/Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWhfLUd6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWhfLUd6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53282C4CEE5;
	Mon, 10 Feb 2025 13:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739193975;
	bh=v+ySslqC6hQ61c9afr9eOiYKr5W7FK5IzbCp+h+Y07M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uWhfLUd6/ItEZmUcrqaRpnWCjLZh6/Yig7rPYsitUMOqaFqJlaZUabXspfTzIo4lN
	 mNnQI2Hdhlq1wWLYoUNXQWPV1jWeTkkYxoMhV7TQnoIRv+5Z50Nrt6D84dnzK9FKRL
	 Sl1fp8rs6CMiCd/ljFEJR4HhjcBoWJ1UEwfjAO2l0UHQUvaSVYvqOy7vnKK0qpLhWI
	 /1rcBDRW4N3GtgyjhKQOrDUgLnnHfZfuzqyKsm8HUQNH9AHOZ7gltTd59x8Vw09eGo
	 PLy3lVrM0h+tUD83Na8gNjeAKSq4B8pGDLHL0PlMph3HmrUGikKI5jo6ZJmKC+fTwM
	 FeQnJbZu4SWgQ==
Date: Mon, 10 Feb 2025 14:26:13 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: =?utf-8?Q?Micha=C5=82?= Pecio <michal.pecio@gmail.com>,
	anna-maria@linutronix.de, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	mingo@kernel.org, tglx@linutronix.de
Subject: Re: NOHZ tick-stop error: local softirq work is pending, handler
 #08!!! on Dell XPS 13 9360
Message-ID: <Z6n-dWDSxNCjROYV@localhost.localdomain>
References: <20250210124551.3687ae51@foxbook>
 <b0d55f4c-a078-42a0-a0fe-5823700f2837@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0d55f4c-a078-42a0-a0fe-5823700f2837@molgen.mpg.de>

Le Mon, Feb 10, 2025 at 12:59:42PM +0100, Paul Menzel a écrit :
> Dear Michał,
> 
> 
> Thank you for your reply.
> 
> Am 10.02.25 um 12:45 schrieb Michał Pecio:
> 
> > > > > > > > > On Dell XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022, with Linux
> > > > > > > > > 6.9-rc2+
> > 
> > > Just for the record, I am still seeing this with 6.14.0-rc1
> > 
> > Is this a regression? If so, which versions were not affected?
> 
> Unfortunately, I do not know. Right now, my logs go back until September
> 2024.
> 
>     Sep 22 13:08:04 abreu kernel: Linux version 6.11.0-07273-g1e7530883cd2
> (build@bohemianrhapsody.molgen.mpg.de) (gcc (Debian 14.2.0-5) 14.2.0, GNU ld
> (GNU Binutils for Debian) 2.43.1) #12 SMP PREEMPT_DYNAMIC Sun Sep 22
> 09:57:36 CEST 2024
> 
> > How hard to reproduce? Wasn't it during resume from hibernation?
> 
> It’s not easy to reproduce, and I believe it’s not related with resuming
> from hibernation (which I do not use) or ACPI S3 suspend. I think, I can
> force it more, when having the USB-C adapter with only the network cable
> plugged into it, and then running `sudo powertop --auto-tune`. But sometimes
> it seems unrelated.
> 
> > IRQ isuses may be a red herring, this code here is a busy wait under
> > spinlock. There are a few of those, they cause various problems.
> > 
> >                  if (xhci_handshake(&xhci->op_regs->status,
> >                                STS_RESTORE, 0, 100 * 1000)) {
> >                          xhci_warn(xhci, "WARN: xHC restore state timeout\n");
> > 			spin_unlock_irq(&xhci->lock);
> >                          return -ETIMEDOUT;
> >                  }
> > 
> > This thing timing out may be close to the root cause of everything.
> 
> Interesting. Hopefully the USB folks have an idea.

Handler #08 is NET_RX. So something raised the NET_RX on some non-appropriate
place, perhaps...

Can I ask you one more trace dump?

I need:

echo 1 > /sys/kernel/tracing/events/irq/softirq_raise/enable
echo 1 > /sys/kernel/tracing/options/stacktrace

Unfortunately this will also involve a small patch:

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index fa058510af9c..accd2eb8c927 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1159,6 +1159,9 @@ static bool report_idle_softirq(void)
 	if (local_bh_blocked())
 		return false;
 
+	trace_printk("STOP\n");
+	trace_dump_stack(0);
+	tracing_off();
 	pr_warn("NOHZ tick-stop error: local softirq work is pending, handler #%02x!!!\n",
 		pending);
 	ratelimit++;



Thanks.
