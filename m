Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A547B7E0E8;
	Tue, 27 May 2025 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357437; cv=none; b=NRMdf8kZx3P40zTOcGWPOm8rQLCYpgTTE3QnrEw44B2jMa0gq3IMGLt1Z4QLE0bo2tKahGRCypp4U/4uJTsDH7NIZz77IHOknPgEUygx6BrQDecU5rkWNvdpeDx8/H3sqvtu3OKVIh89AAg4L+m6tBYQ2R7tsERej9J+cnpv2vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357437; c=relaxed/simple;
	bh=FEbfS+UuSSerkfHo9hXlvZXI3ZHzyKqp+ZFEEJh+akI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwSyGOxQ/BwMZ11lpwtxXAlePYQHCrfGmI/jUJuedTNFVmytv+yxH3k+d9fVAhwG3/97cQ5ZkWTH5HyLhzJDl9WYbyQJTcERdpBA2T+CsGkRl7/BhrOHWXe1jO2P+738LaGehLKuizpPWyMh04+MQoZizxOPhDoQ4m/kdhfF2sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XQg8lBZ+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xWZrCapJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XQg8lBZ+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xWZrCapJ"
Date: Tue, 27 May 2025 16:50:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748357433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6iZ7GLWczHbCwoKVC3idZCK4EPn/0CsUSuZvQby/Nyw=;
	b=XQg8lBZ+vxH7yFPMafojrv7Xiq31HBpEsvyEMW9qNBld1Op8ZpVkIoOvAU5D9yoaZ6h+MR
	OCkIyCK71Gze66CqKhUJgCeDWT2mFzU5GSVZ6dG0VsTtniTKI86chxbaTGhN3zklQsXxfE
	BHTi1pOa+fpIKOW/qkO4NNV7cwz5o/mDA52zbG5VxcswmAU69uZIrudvbAnm0foClWY24I
	TckBeS0d1VH4Fo8hx2KuILazScDjaE2og5fs4H4mNaKMEtnNK05eyD+FgDcrezwzk1wf6t
	EdQHxsApdoL6Il8TbgyPu8NMppximGSyspDicBEZTfOLhq1RTeO9Ago6oc64zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748357433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6iZ7GLWczHbCwoKVC3idZCK4EPn/0CsUSuZvQby/Nyw=;
	b=xWZrCapJs8ABU6OwpQ2Xc3CkeDsfDH3EEdtFsr/JSskcufD8rYsH/atgmjB9bLwEnSNKXl
	4Y9rEez+ancOcbCg==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>
Subject: Re: [RFC PATCH v2 12/12] rv: Add opid per-cpu monitor
Message-ID: <20250527145032.fIN-37M_@linutronix.de>
References: <20250514084314.57976-1-gmonaco@redhat.com>
 <20250514084314.57976-13-gmonaco@redhat.com>
 <20250527133712.CFW5AcNE@linutronix.de>
 <6f33e6b7ad296f4fd0e9c089ac92e53c08cfd850.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f33e6b7ad296f4fd0e9c089ac92e53c08cfd850.camel@redhat.com>

On Tue, May 27, 2025 at 04:35:04PM +0200, Gabriele Monaco wrote:
> Thanks for trying it out, and good to know about this stressor.
> Unfortunately it's a bit hard to understand from this stack trace, but
> that's very likely a problem in the model.  I have a few ideas where that
> could be but I believe it's something visible only on a physical machine
> (haven't tested much on x86 bare metal, only VM).
>
> You're running on bare metal right?

No, it's QEMU:

qemu-system-x86_64 -enable-kvm -m 2048 -smp 4 \
    -nographic \
    -drive if=virtio,format=raw,file=bookworm.img \
    -kernel /srv/work/namcao/linux/arch/x86/boot/bzImage \
    -append "console=ttyS0 root=/dev/vda rw" \

The kernel is just x86 defconfig + the monitors.

Nam
