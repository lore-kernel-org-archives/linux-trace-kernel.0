Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C01A45563B;
	Tue,  6 Oct 2026 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296085; cv=none; b=dQegfYFX1Pv3TDPxOOTLGxP+v3NDJfUC0D9A4ACC4KKctqlWbngm6eYTLNsvWn3qlcu91F5gN4RXiP40kMinsszAYckic2rty8LtEdFPDcJLnyDTMRe69lw7IuUwgKlbLArau1zwF4vjx/MZHm0ijSKzRzdXc6DkTIfNhky+HbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296085; c=relaxed/simple;
	bh=Wnkvw/PmiSIEwtzxymhqfsRqVQBcv77PR0tcXIczR4w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwPdQLGR8O/D5TqfznZBmfxrzuTYxHLizqME48sts5FR1+C2CNQt5Lpnwv6Ngp8AtHD7FnC/Kdn5XdmdRwA6DZlncudGnLf2UDdT/fYnl7JQo8xTakBeXSU3DCH6z3WGwz7dt6insii8u1V2bTTuEHXTA5/535rKV0iaj39FvRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=i+5yQQjq; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="i+5yQQjq"
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 34F2940127;
	Tue,  6 Oct 2026 14:14:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 39A786000C;
	Tue,  6 Oct 2026 14:14:32 +0000 (UTC)
Date: Tue, 6 Oct 2026 10:14:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jeff Barnes <jeffbarnes@linux.microsoft.com>
Cc: Beau Belgrave <beaub@linux.microsoft.com>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "mhiramat@kernel.org" <mhiramat@kernel.org>,
 "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "kees@kernel.org"
 <kees@kernel.org>
Subject: Re: [PATCH] tracing/user_events: Fail fork when event state
 duplication fails
Message-ID: <20261006101427.25e0f8f7@fedora>
In-Reply-To: <0499A842-AA79-49A7-AAB5-47003DD799BE@getmailspring.com>
References: <20261006083825.2bbeaef2@fedora>
	<0499A842-AA79-49A7-AAB5-47003DD799BE@getmailspring.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Stat-Signature: zxy5jkdnrzk4iyeo8by5p6yxpmcjamm5
X-Rspamd-Queue-Id: 39A786000C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19RhyJBrzcgp3fOfNPHDS4vRtVcqaJAIqk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=Wnkvw/PmiSIEwtzxymhqfsRqVQBcv77PR0tcXIczR4w=; b=i+5yQQjq4bxzYZwILnKSz/M1zCsjL5q3ec51XWWVQdS4I7SacvWtPjIdEVvwjAfUjYgC3DUktamU5j/vPSGm3if+SRKUTcOuJsuhOtfbE687aY0oTHPN/KCtEK9t2uIQR7r9q0CybkOu8crsMm3IkOJWXs0tQhrLgc8L2aPu6/I=
X-HE-Tag: 1791296072-18580
X-HE-Meta: U2FsdGVkX19qUYQ6JN7VyyT+ZigEhsnsqklDh2EP7CuUa1xaZiM0VdTBb24qabXRQ68hAsfk7gdv8NE3mSj/cUkX1ToGfehlVfjVXvOj0wnv786x07Sp8bcKHRkcYkU0kwb/7BE7sWaM6nCDz3nVZqffhuhyTYPm1idjxA+zImUYC3QxesSEy22yEh2qHE6v40OR4aD3++IIO8KlAROMFoNSlNVbU0aGwLzoA4SzKkIPBYPKzgqcjQWAeyiRapv5DkjWXb95L2287zlLEJ7PjA6f/Bp00JNqQjMxO62OjHtjH86SaFlnxxD5hTB1zX4dFkbpxmfDRYYzuxHFTtqxVnXSbkz5IzN3

On Tue, 6 Oct 2026 09:42:39 -0400
Jeff Barnes <jeffbarnes@linux.microsoft.com> wrote:

> So in this case the state being duplicated during fork() is state that
> the application itself established. That's why I think propagating the
> allocation failure back through fork() is preferable to silently
> allowing the child to lose that state.

I agree.

-- Steve
