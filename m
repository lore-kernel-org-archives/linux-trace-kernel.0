Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89352E973A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Oct 2025 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761336971; cv=none; b=P2/S+DEVOryOtIumHf9IzFo+zzX3/2xmiB1Hk53ntfAk0glNdT8QSwPPzQGP74AeXT8/diQlkLPDOPnx42rUztz6WOFeYlXw0WJdmVr8ODX5J2/EIWUwuiD7G2quIRSE3rz1YstaTWqe1ZjJkS/hl21ufagz6otMp3TFnPzIL2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761336971; c=relaxed/simple;
	bh=SF4/OIGoq+SA/inWwKHrusP8hMRhNnG8aILkLhBWIt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNHRHkmU4kcCESQM7chdMpCi67BMsfybpkE22gzQN5Wir+UVzys19vlfr1DN9jipkSnGd3iyubEFXSnT07UxbNXtZKUy4wsuPkkCS2AmwzxxDu40RoNVl7zxzjt6/CVaxPx6vyT+oiW1Pwfyxn8K9vRdzI+9jZZgahFHxdquiw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sgk9NjcI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pQF3lMIU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sgk9NjcI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pQF3lMIU"
Date: Fri, 24 Oct 2025 22:16:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761336968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=InwECpYWk0gtdd4XFciQH/NgB15UGbEwuIKZwj3dGzo=;
	b=Sgk9NjcInthr/pp2b2DsPK5rFmXega96DX/VymBC3ZVcETbQkJDFtHJO8+S4hzMB+wqfoG
	EL9x9gvTJ72UL5ex5MOonWOWzgYmlShPuT0O5y6iqLy0Uu1zuHbzhsSlw1qNrBZFafQdB5
	cB/49mrzSqhxEir76lcCjMpeKuX+NBmQ+56qvBT2yfEwfXNtBhzRM0QnX63I4nzw3P6D8/
	goXKHclHHjphepJB12q+WB98sIkRnS0AoDdoQ89NO/mI4AjMQQqUKYgP1k96ALI8xhDmsM
	StClHdzSEhnc8Pt/IMzTnBY5p5lWCSmKZaNzUdFo3gcsKMd+wkEtGa9SZ3MyXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761336968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=InwECpYWk0gtdd4XFciQH/NgB15UGbEwuIKZwj3dGzo=;
	b=pQF3lMIURGecnCNhLKSduUycrl4OPJ2jjhQGDsPycKdTzd6LiBW1V64Rp3kZaeoWM+S8IC
	Z2xKNsVGJqh661Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/13] tracing: Allow syscall trace events to read
 more than one user parameter
Message-ID: <20251024201606.Oi0U3kzG@linutronix.de>
References: <20251021005233.417553389@kernel.org>
 <202510241227.GegWrQL7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202510241227.GegWrQL7-lkp@intel.com>

On 2025-10-24 12:36:07 [+0800], kernel test robot wrote:
>    kernel/trace/trace_syscalls.c:877:7: error: use of undeclared identifier '__NR_mq_timedsend'
>      877 |         case __NR_mq_timedsend:
>          |              ^
>    kernel/trace/trace_syscalls.c:898:7: error: use of undeclared identifier '__NR_access'
>      898 |         case __NR_access:
>          |              ^
>    kernel/trace/trace_syscalls.c:901:7: error: use of undeclared identifier '__NR_chown'
>      901 |         case __NR_chown:

You need to exclude those if the numbers are not available. It does not
compare about all of them, like it is fine with __NR_openat2.

Risc-V probably did not wire them all up. So they started to use
__NR_faccessat2 in favour of __NR_access. "Current" glibc probably uses
just the latest one so why bother.
x86 supported it since day one so they need to keep supporting it. The
newcomer just started with the last variant.

Sebastian
