Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BB43CD8A8;
	Mon, 18 May 2026 07:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088684; cv=none; b=FqYWOZoCk0OuA4jzbHWZ0/Tz/CdWpxzPE0xkC/QscV7KSUk8qaKndIZCFBTyvQYqFlYUiciWqFelYHawDezdKd7vR9v2ZprqvQchLbPMiP+qHx0GIoFeu7eQBcptslFe6NlJ8F/ZNsQzsupSjRbF1ZhjV2saaXCx1vPiG6Gf4Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088684; c=relaxed/simple;
	bh=Y2p0AzQSO7GG7GfyhRpFRBV2lcOBGT4qFeDklYZ2+wI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nz2Or/ofMg5YuH3MD7EYmG5HbjkGAsg0v6mqp/kiEa24IzjY9iSZOBZL8ppKukJk0SftBdTpWb24aJLvvMCoLS47yy3so88upIhlLQeqh6wh+Xk19ZfdULHQmC905uF+rl9fWRRgPpkg4jnlKEKCD4aOPz/5YsxsL8SEF3g8mGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H3/h2Rb/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z95UD3UE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H3/h2Rb/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z95UD3UE"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779088682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HG+yq1sLRr9MBLVXkrpcq27p3Ll+Oay0QkHo11F1Kkc=;
	b=H3/h2Rb/yFvML8/0AzzJqqE4fwkZudMY9SqioucfirI97MapQ4La34KJNJSHkOagVpsuXh
	z7Kg62FthOm04ZfumqTuX02SzEbx1MPwBb/P9tTZffUlm5Rt+2U+4rbL7jWRjkSXHkuegf
	qTw5k+2JSdLyODSEBm9vCOEUqxvCuzjs2c/TQTeKpzIjKUx5CrgBtX3ps10S2EAxmJ2Mgu
	CJUfToDo4dIZfpkAv30lQ8w4q4+XjbIApai9SKVmoHgz37Lpi4IQ68/NMZTtM8AFmOSu8M
	61ECM0GH8yFqiGsGw33gHEE6Pv3728Cti5SYrZe6CQxYkQQfqabv3rvHD0F2Ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779088682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HG+yq1sLRr9MBLVXkrpcq27p3Ll+Oay0QkHo11F1Kkc=;
	b=Z95UD3UEaSwXpxwH62s9wtd4EMXkFPIR/NEuSl9JOnmZklQjqVqnxO8lKRad9kgGg9rZd5
	o8VxL66op77za2Cg==
To: Wander Lairson Costa <wander@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] verification/rvgen: Introduce a parse tree for
 automata using Lark
In-Reply-To: <agdnvQPLLiLBIxw7@wcosta-defaultstring.rmtbr.csb>
References: <cover.1777962130.git.namcao@linutronix.de>
 <050ac3d7aeb1ece12a4deb91fc173de24ad147de.1777962130.git.namcao@linutronix.de>
 <agdnvQPLLiLBIxw7@wcosta-defaultstring.rmtbr.csb>
Date: Mon, 18 May 2026 09:18:01 +0200
Message-ID: <87pl2t89ue.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wander Lairson Costa <wander@redhat.com> writes:
> On Tue, May 05, 2026 at 08:59:23AM +0200, Nam Cao wrote:
>> +    ID: /[_a-zA-Z][_a-zA-Z0-9]+/
>
> This regex rejects symbol character symbol. Is that intentional?

It wasn't intentional. This is blindly copied from the existing regex.

Let me switch to Lark's CNAME.

Nam
