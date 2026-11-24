Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541906;
	b=j8htqVVJQPpXO6CJGkvMeAcWfVSMheGMjtQRFTeAXahDSB+LmRjqxNhJIwU8AsmX7lV6
	 6nVelypNnlNtq7+0WbqVc1RLiNpeXdI7FPMRS+GWeaLkVSzzy7LQVHz+/32kPIyfUlifp
	 ZywtEibLmNAVuU8EV5HywSB3FFsdwnO/jtsbyZFcQBiDTmwn5UTLePi5g+DPbj4YqzF+h
	 /G9gBb2LQg9lyJWkE48GVtBDQOfTY9kq/8xzVB+Ht5pJEPAS9iOBWkjb2leGExqpqZZH5
	 SoyrlkvCaIRt1M92r9VGmhMROKRwTUifLU2XZ0Laa4hGUZFBl298PhlzG55ZW6U4ZtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541906;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=Z7ZqvSQjxHguoc1FTxJ8uNaW6BCtmmOurJdgC95SiWI=;
	b=blTkikopEJ/WxnsOG08gsf9iqusfreP7bUtaUxNsABWUC+bE2gZE+VkbNvvkzsfJNKDv
	 +ZBDYHdqUu7k1wzhtufzHXxVZIf86lzUsWoD2jXcGBTr1GfZstkNK9VQ1VPxookUw7+ZO
	 KpFJwI86rVvNh3oQhR9jRiIdIoUkMzHFVIHwmbgHYhQIXA0VYOjGBHWKW1rv8BQluTO9N
	 bbUALS9/UZTtAvQl/RE4aICA6ZbAYDgAVQA569wkyosCcY30UAiQ9JlnkNQgo4S9hH+gQ
	 rEfK2Fyg8a1DLWEtDTKADcnM0nPlreLs1LgROS3iDrI9Nc74ELQPG3CouWhLCPa0myg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=vG79UtM6;
	arc=none smtp.remote-ip=216.40.44.13
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65147606A321;
	Tue, 24 Nov 2026 17:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65147606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=vG79UtM6
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 29C9740CA4;
	Tue, 24 Nov 2026 17:38:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 97A0D32;
	Tue, 24 Nov 2026 17:38:13 +0000 (UTC)
Date: Tue, 24 Nov 2026 12:38:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Waiman Long <longman@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>, Hongyan Xia <hongyan.xia@transsion.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Andrew Morton
 <akpm@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org,
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 04/13] lockdep: Use raw access for pinned hardirq
 state
Message-ID: <20261124123812.46979f5c@gandalf.local.home>
In-Reply-To: <20261028033127.82193-5-kmehltretter@gmail.com>
References: <20261028033127.82193-1-kmehltretter@gmail.com>
	<20261028033127.82193-5-kmehltretter@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 97A0D32
X-Stat-Signature: 4xbhd988e3g1csasnigwrdkcdq4qsys5
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX198MftYJKZb6cHxlY3uXfTzLYEjUtUPn2o=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=Z7ZqvSQjxHguoc1FTxJ8uNaW6BCtmmOurJdgC95SiWI=; b=vG79UtM65xVyDMhJcFJ0SJYuTRpNzihz/B5peKySpBcuvkVCkGYKYMsWF0bznW1oLEGCm6hOQr7mbFCA35ZzyhY0PViyO/owV3x//rZRGt7jTrCGtm/33B9kCAAA/LG4BT/iwvgFZwEOMLv4K1onpFbyk6J0w5qrId6JYmYbdrU=
X-HE-Tag: 1795541893-954039
X-HE-Meta: U2FsdGVkX19sulWhS/9891zS4KS5jVoQBW7ftJGYbRku5nwzwrevSJlpeohJjPhi0PGybtsZakyMexSWzlsfRQ3gW5tNzLIz0qeHXYAjlrVfZw96CfUGbT12mMbMzeFGsL/vMOuHNsc4JladTqyVibXWkNkjRE813CMxAAtPPI05Rn6zZ0GiRZfvRv3KThXKipyI+3gyetA1F4OZZ5yenvDob+pV0MF581Iv4hOJPhNf2vIL7OZLUSUqgnItiprU3NfU/sjicTkv7Yb+1aXYv2uUnzzCn5k8AKsCMQ7QO9OwXOa/firti7syKykRznECFqI2E5XsLt6OyXYVWWahbjH8CNmrS0Ed

On Wed, 28 Oct 2026 04:31:18 +0100
Karl Mehltretter <kmehltretter@gmail.com> wrote:

> On arm64, this change relies on __kern_my_cpu_offset() being forced inline
> by the earlier prerequisite patch so the call chain remains noinstr-safe.
> 
> Assisted-by: LLM

Hmm, no Signed-off-by?

-- Steve

> ---
>  arch/arm64/kernel/entry-common.c | 6 +++---
>  include/linux/irqflags.h         | 3 +++
>  kernel/entry/common.c            | 2 +-
>  kernel/locking/lockdep.c         | 6 ++++--
>  4 files changed, 11 insertions(+), 6 deletions(-)

