Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C667D21C9FD;
	Fri,  8 Aug 2025 06:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754634647; cv=none; b=FkXJQB1WrRcASBEQKBuJFmEOZuE7Ijhx89EeA40m1XBAls82qIUVvU/URJUIhWtpTlNbZg1ZNaTLo5IDzqVW1jTQvpb07MRB3l8XuJrDObJUSjhDN7sGxxbkPWXXZ8x+YsFSZHYlooqoD65DuXtXwGvZVpyyeuqwvB1pxoWqJqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754634647; c=relaxed/simple;
	bh=jkiWOhEyhzo/YryVRjT+5Kz54ol26kRNo11irK2vctY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z6gQYThrtnXSUSTBLHjKC5r/tkSoomcGS3X9t5htFfoxh5RyHBqANZLGJJy09IzPrfu+dhkW877nm4LTTqvZsA0nnciDxpAjvj7lz7JvNbZfEkJxcl7weKXRKWRsI63Emn2DB37mYktrR2YtXzNm9mOQUQb4tm5DKSEvL0iGVGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Ve4do3o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s03B0/yH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Ve4do3o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s03B0/yH"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754634643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jkiWOhEyhzo/YryVRjT+5Kz54ol26kRNo11irK2vctY=;
	b=3Ve4do3obONhu6h/bjEiv19h4bHIIDa2xU3UqkAGutAlLpNwFwBE85nKgCUDxzUYL8r6ln
	ioW/mXb++Tjp58tUHasfVa4XRAYYDEFvopB+x7hztmsFKf/0GV2/pQY/kLxRrE593ul1Sc
	JJnEEGesOPEB0smAzEH6T6FsC0H8G2w998+my9TFlKjlDuLu5D5IAccg1ua1Tj9/3k6WXt
	1UpKIlsKo2GHoDLZBETtMNAqC8LUWfAo8i1lUBKxSspks9iEaUbWwegCb4ijWqO0kKiMFo
	40DA0dlAIu/y7bXrUFXziVcSpeBWs9heNWvuPhdEiQD/Otf/1zNfyfjXN/CipA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754634643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jkiWOhEyhzo/YryVRjT+5Kz54ol26kRNo11irK2vctY=;
	b=s03B0/yHw2l1VJ+AUcjB3yw8i257TCxgx78KhJVpKw/Wf2gEEdgvmbZlADv8sx1dmLaivd
	CWbQAVbHavRTRaDQ==
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] verification/rvgen/ltl: Support per-cpu monitor
 generation
In-Reply-To: <0d29da11a78f8c4b67f3a590bc015ba1ff4bfcf4.camel@redhat.com>
References: <cover.1754466623.git.namcao@linutronix.de>
 <ccfa5ee80e6114b046f04dc1bf1de0c4e7a11c09.1754466623.git.namcao@linutronix.de>
 <6754c61d60fc161963d0625a4b647a241b363fc5.camel@redhat.com>
 <87o6sqpfbj.fsf@yellow.woof>
 <0d29da11a78f8c4b67f3a590bc015ba1ff4bfcf4.camel@redhat.com>
Date: Fri, 08 Aug 2025 08:30:42 +0200
Message-ID: <87cy96pbot.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Mind I don't say you should change the value passed to ltl_target_init
> nor change your logic, I only mean /online/ isn't the right word here.
>
> Does this make more sense?

Yes, thanks for the elaboration!

Nam
