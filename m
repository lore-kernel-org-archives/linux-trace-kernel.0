Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECA9439F75;
	Thu, 15 Oct 2026 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071736; cv=none; b=JwN22coa4kCaqwxEYpIScI0o3lPE2WKddB/SxRXevJ4G0bWRfJWy54qr1gJVTkO+rcPs4l41ZvjHF6db/y4KoMxpg6qZGdajQHRhdsa7jXnxhX5rr0UDc2rLsyKOST/6HHEauxCq3no9JFBeGUi+ocC+h4+q50fxJ5ldOze1MkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071736; c=relaxed/simple;
	bh=WoOljhDrzaqWXL8C4EqJ8uAH1+M7GGXx4yQuuvNzFag=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A+e4KIQ8gGA+/qeLaSWlL1YFZYDQZoJlPbufjnr+toIZ+B8J9isQR1AWS0sjc/q4VmvOmQKkGqPpy2y6XgtCRMC31JYA32iP+RBGZXGVMO89McyIPhtU5shwRlwTiOSllyFQbzvimy9yFeM6MgbhX7dmawXLcqcY5rbEzdMk3AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=bWjMPFP3; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="bWjMPFP3"
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id D1DF0409B5;
	Thu, 15 Oct 2026 13:42:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id CE6CC17;
	Thu, 15 Oct 2026 13:42:10 +0000 (UTC)
Date: Thu, 15 Oct 2026 09:42:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wang Haoran <haoranwangsec@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, security@kernel.org
Subject: Re: [BUG] tracing: __copy_from_user without access_ok leaks kernel
 memory in syscall fault tracing
Message-ID: <20261015094209.7177cf03@gandalf.local.home>
In-Reply-To: <b2dd26de-efd0-4b8d-8086-ee5878a5703f@gmail.com>
References: <6ad07a3c.6e2bf4e6.f29cc.dd67@mx.google.com>
	<2026101539-rinse-refocus-8203@gregkh>
	<b2dd26de-efd0-4b8d-8086-ee5878a5703f@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: CE6CC17
X-Stat-Signature: ya7drqp66bwiduh8jz81ma9956z94c9i
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX197pvCDo2faLEKYH6rTw9aPsz0l7k5kEVg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=8RwEhcvvRMhdZGdStEuZsbTIZ7b3isq36oAmV5C/gB0=; b=bWjMPFP3hwH2OQUXlqrp0TjUfblFh98xJSzYt6FeuVTr3ePtLsQU9tn4kUXLj9aOqaM6+BwXxnbMAVk0b9vRPf7Xvl9FpF985J7T/KOJOOrw0wu+G3QmZjJL/+DAH2dDNWiEDGbQiXpijVtamXn5h0OIHz/x6iWRv5//YdPSaek=
X-HE-Tag: 1792071730-759629
X-HE-Meta: U2FsdGVkX1/aqi9A9u2wTw37clTzKyD0Bje82faNDAgdKzA/4LXe9oliYYz+offoRKPMXbkV+FicQVQUUDqSxgcGh5LTXmLdHjQpiFc68gUjTsi3keAvlD0uXCgARS3n7u5cGoONvjm9aVSkmsBL/xj1SMSt9rB5d+AkSUW8L4Tn5Cr2DdGWe8PrhGqV5MbjNKqUWnt9rxlHKlxMXieLCH7/yQPCmpyddVLCQLvzplP4Hbo/7ttRWJbnH7+FlCBmJQv/xaucuYbwyXUcwrsWpLoylZxfpSWKxtJelGWE5iuV31o6FeSX080O1oex0c1mQ7mSIdsSTAzfQ1fXUy1YAn0RXXbbAlGFA3SR69N7t9zyUAswTu4wW2eXsm5NuInGTJ4+SW5xtfU=

On Thu, 15 Oct 2026 20:05:57 +0800
Wang Haoran <haoranwangsec@gmail.com> wrote:

Please send this to linux-trace-kernel@vger.kernel.org.

>  From ca4e2a6928bbd9010ebec967440517b08909b992 Mon Sep 17 00:00:00 2001
> From: Haoran Wang <haoranwangsec@gmail.com>
> Date: Thu, 15 Oct 2026 19:12:21 +0800
> Subject: [PATCH] tracing/syscalls: use copy_from_user for the faultable
>  =C2=A0syscall buffer
>=20
> Here is a working fix for the report. The leak is not strictly root
> only, so there is a security concern on systems that relax
> perf_event_paranoid.

Leave out any security details.

Simply state that the current check is missing the access_ok.

That is, this is a very trivial bug with a simple fix and a simple change
log. It could be a security concern for machines that trust perf a bit too
much.

But to go upstream, it still needs to follow the process.

Thanks,

-- Steve
