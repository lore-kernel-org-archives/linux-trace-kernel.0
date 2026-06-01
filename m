Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0874A341AC7;
	Mon,  1 Jun 2026 07:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299594; cv=none; b=oUnZHR56ai0ulDbD1I7rTrKl6SLe6kQ06us3IDfAk2vhu32n/BRvivJ6hHrc32UHSq4a4bwViOZrK95UisKwcs4MtdNx84XpccGD0eiUqroL5r0BCZFMj8n1tEBwabp3Dfg0/EZYow7FHQ/3WgmmvUao69PZY0VSXyudyXB/FxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299594; c=relaxed/simple;
	bh=Azh5KVgLNkx7VGcLd9/1+QZj/3aESJH9+ficC2mhd0A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bsF0PkS1M40moNRWNvCNjU8f20zukDNradpvg17oKb2O/TwinRh9xaNq2cm9HDRBuYRncP1Pv7uLiylNPTpk/wUJizfaViCD4muQ9I2uh8Su/TzqrO6N8QyYOXsqHobnZnIHTHtle44gMM47gyq8IFTRvEG+BI5l17/BXDoTLBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=st/20jzq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ntcjl8yE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="st/20jzq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ntcjl8yE"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780299591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HlqIKWRgLxAzILsupXst0K+tSAC9sR6PehJ7d6jSfCY=;
	b=st/20jzqgJ/9lyH8jhHkRAHmd41ts0B2+sYGMGzd/rcvfZpzhGMeazAMtpTMGDrsn94PL1
	N3wGHs15Nx/AJAGc2kVgfj65x7zy6EB9ProtY2JwK8gLDsrlXgVK3fx/G6zSZQDUcznQK6
	a6gn6nYMQx+HyVe3Ymt9+du7Zdcd/16J1/m6ObCAIaGnUbE3GOTKrHIM7qLHYZc+lADFsw
	+XWhNdyreZTEdabpH5KQpRpmbnAhvjhLQEiBcAoPhUGdQb5v3lvhm5xrIAraSqHpSB8Ip+
	zDAGirB/rfLHKt3tvMSaXi9SSAEN5JTb/NQHqiX0Cbl5MNkFnk1rYH3JLoqAkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780299591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HlqIKWRgLxAzILsupXst0K+tSAC9sR6PehJ7d6jSfCY=;
	b=Ntcjl8yE6voFPJJFI9ctm8+2qM27QEco24Ni3FDfdRZFATw6Gbn59xITu42Heclm8EH7GU
	Wh/U+qTz7rFZrPAQ==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: Re: [PATCH v3 07/13] rv: Add automatic cleanup handlers for
 per-task HA monitors
In-Reply-To: <20260530141652.58084-8-gmonaco@redhat.com>
References: <20260530141652.58084-1-gmonaco@redhat.com>
 <20260530141652.58084-8-gmonaco@redhat.com>
Date: Mon, 01 Jun 2026 09:39:51 +0200
Message-ID: <877boiyaig.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> @@ -123,12 +144,15 @@ static int ha_monitor_init(void)
>  
>  	ha_mon_initializing = true;
>  	ret = da_monitor_init();
> +	if (ret == 0)
> +		ha_monitor_enable_hook();
>  	ha_mon_initializing = false;
>  	return ret;
>  }

What if between da_monitor_init() and ha_monitor_enable_hook(), a task
exits while a timer is still active, and then the timer callback is invoked?

Extremely rare, but I think it can be fixed easily by reordering the two functions.

>  static void ha_monitor_destroy(void)
>  {
> +	ha_monitor_disable_hook();
>  	da_monitor_destroy();
>  }

Same here, there is small window between the two function calls.

Nam
