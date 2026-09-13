Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2507536F90C;
	Sun, 13 Sep 2026 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789320745; cv=none; b=nymc47bbqVXBjd6PMZAQ5LpUdMiihJD8Q330czYz6a0Q60HgqFM1WsGyxLl/KchTBvQmbfrmvcd0dF1QlX55odsXuLWVr8wrKTC0XnBtUIhVDoT4mwzGgnypiMg0DJOY2xGpZTlwhztoiFqeGFieAXaoiUrMXsGnRU5mGwnwyiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789320745; c=relaxed/simple;
	bh=Al1A2jEJx9Ax3hjHbkwl4XDTMg8gmfAfspqn+Yo9li4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNlwQ7i66kH0KcqIhUV0O2yL62mcFF8X4jvRmDgs+vJPi+vO10gIgXYj+TVuM+nWb25w+hb5X1GMOS8Q/46lPUT27yvSEdzSTwiYEP3jB4Y9eHpp7i6xPvADDEtOdDEustQ97fD/X5xgsPkdiO8oNWrgXaPNmIWOXg8PiCBaOnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=Qkku2Nol; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="Qkku2Nol"
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 219D2160907;
	Sun, 13 Sep 2026 17:32:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 1605A17;
	Sun, 13 Sep 2026 17:32:12 +0000 (UTC)
Date: Sun, 13 Sep 2026 13:32:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix NULL dereference when copying keys for a
 field variable
Message-ID: <20260913133210.5561852b@robin>
In-Reply-To: <20260913122523.30f487d9@robin>
References: <20260912094722.3271147-1-donggeunyoo.kernel@gmail.com>
	<20260913122523.30f487d9@robin>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: hc17cpjw7kuhaz39niowb9q6posbniw1
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 1605A17
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19ogCWbzM9BgxZ0sfvYrv3PtFQRAFABtPQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=sQJR/9ahAbHC3Al6QjAsogGKhzLDVZ5ABLzCD81BeJY=; b=Qkku2Nol9sshs+MtkPJoIQ9lEbXVf9PUklH1LoBlzjfXMSOCHf1Ijdd8mK4CJPeXNDWQ2W9MRjOlijSOuj+W5A+Csxgj2nlQHI1c6aaJJveW3KwNacZ1d7z5V//44EKC4NFgv9i2yIHzpAAxFeHxjdBgYruRt/gZw92t2eDew74=
X-HE-Tag: 1789320732-294274
X-HE-Meta: U2FsdGVkX1+hdw3uIB23a6j5lHlvvixl1HSTAnZ4h8DCAkb6p/K2US0EE776tXDBJRl67XQThLVMQqYpRaLax9tc88mFKEZoGOToZpjIbvXhPhMLJEgdn9nr6aZ+yvvX8bl91fXelJtimfUbOKNcc9h47THScY2y8cSO68HBP/EfFSgUm+L4ueFOfBsf1Y85HYL8dge9iliiHEVZtNKIEIoaIpNSak/OoBaS4ONLUh/mEVlb62A13nLNhYdsV0C1zXWomi3NU0SZGZMLZGxJc/9dyNZ6KRG+ztO2jOT/lnJVAsXP/v0MYNMbYIshvm3dqwqKVhy6eVJ8QZZeuFPFQRuPYuXZoCyxScpwiH0uxGjdAdFOKMHY3zIO+pSh0I2S

On Sun, 13 Sep 2026 12:25:23 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Oh, and there's another bug here. With your example, where you used
> "prio" for sched_switch (which isn't a field), there's an error message
> created, but the command still errors out.

I meant the command still succeeds, it doesn't error out.

-- Steve

> 
> [  415.300003] hist:sched:sched_switch: error: Couldn't parse field variable
>   Command: hist:keys=stacktrace:wakeup_lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_waking).my_synth($wakeup_lat,prio)

