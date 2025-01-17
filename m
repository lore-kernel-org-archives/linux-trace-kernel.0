Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6DC1ACED2;
	Fri, 17 Jan 2025 21:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737147768; cv=none; b=b0SE4M/Q/ZgcJAhvU5ppCtcYYOleo8LpbdPADGZP3+HCQTZgQeazu78xxtInQKF3oDiCR3QISLfsg4F0b9aC+K44VkoiVIo+87+iCHm2R7zZ+1YapTqjMCpoQ59Dy4kKEaW4WCmNluC9VMzqQxSPhegTRcNgpeSrHPrvJvVC9Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737147768; c=relaxed/simple;
	bh=s87ZaprngAbzkyDGjRFuOAMj/B4LIrGPHpa5+JFQka0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxRa40fBIa+HhfsbZkh+x65Kx2iaeXQrNYML6WPqut24e4UFt+KILFfFetjyuUV15uqEvXD10VQDfnurh9wrwIO8A+Hf4M2AH3v32beJEZS/UNdUEPtmjiGSffwFjT1JQ2N3qMF/fkJQCO+BoIlEAG6W6jXr8SANxGw3ao1bVVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53252C4CEDF;
	Fri, 17 Jan 2025 21:02:47 +0000 (UTC)
Date: Fri, 17 Jan 2025 16:02:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, John
 Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, Chang Yin
 <cyin@redhat.com>, Qiao Zhao <qzhao@redhat.com>
Subject: Re: [PATCH] tools/rtla: Add basic test suite
Message-ID: <20250117160254.4a366149@gandalf.local.home>
In-Reply-To: <CAP4=nvRm8Sp4n0J1oWS6D-KbzQ-KeE4eW1cw9CZ8mU-Woi78+g@mail.gmail.com>
References: <20250109133852.360122-1-tglozar@redhat.com>
	<20250116201808.3c8721c1@gandalf.local.home>
	<CAP4=nvRm8Sp4n0J1oWS6D-KbzQ-KeE4eW1cw9CZ8mU-Woi78+g@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 11:53:48 +0100
Tomas Glozar <tglozar@redhat.com> wrote:

> Maybe after enough time repeating the command I'm also going to hit
> the bug you saw.

Nevermind. The divide by zero fix went into my tools/urgent branch and I
pushed it up to Linus, but I had already started the tools/core branch for
the next merge window that I've been adding these patches to. It does not
include the fix.

The reason for that crash was because of the divide by zero bug. After
cherry-picking it for testing, it works.

Now, what I also noticed was. When it did crash and die. The osnoise tracer
no longer creates any osnoise threads. Can you take a look.

Remove the fix, and run that test:

 ~# echo osnoise > /sys/kernel/tracing/current_tracer
 ~# ps aux |grep osnois
root         942  105  0.0      0     0 ?        R    16:00   0:02 [osnoise/0]
root         943  104  0.0      0     0 ?        R    16:00   0:02 [osnoise/1]
root         944  105  0.0      0     0 ?        R    16:00   0:02 [osnoise/2]
root         945  105  0.0      0     0 ?        R    16:00   0:02 [osnoise/3]
root         946  105  0.0      0     0 ?        R    16:00   0:02 [osnoise/4]
root         947  105  0.0      0     0 ?        R    16:00   0:02 [osnoise/5]
root         948  104  0.0      0     0 ?        R    16:00   0:02 [osnoise/6]
root         949  130  0.0      0     0 ?        R    16:00   0:03 [osnoise/7]
root         953  9.0  0.0   6468  2152 pts/0    S+   16:00   0:00 grep osnois

 ~# echo nop > /sys/kernel/tracing/current_tracer
 ~# cd linux.git
 ~# git show cfff4d019b4c01 | patch -p1 -R
 ~# cd tools/tracing/rtla/
 ~# make
 ~# ./rtla timerlat hist -i 2 -c 0 -n -d 30s
 # RTLA timerlat histogram
 # Time unit is nanoseconds (ns)
 # Duration:   0 00:00:02
 Index   IRQ-000   Thr-000   Usr-000
 over:         1         0         0 
 count:        1         0         0 
 min:    1481365         -         - 
 avg:    1481365         -         - 
 max:    1481365         -         - 
 Floating point exception

 ~# rmdir /sys/kernel/tracing/instances/timerlat_aa/
 ~# rmdir /sys/kernel/tracing/instances/timerlat_hist/

 ~# echo osnoise > /sys/kernel/tracing/current_tracer
 ~# ps aux |grep osnois
root         969 11.1  0.0   6468  2244 pts/0    S+   15:54   0:00 grep osnois

So that failure puts the system into a state that can no longer run osnoise.
It takes a reboot to fix it.

That should be fixed where a reboot is not needed.

-- Steve
