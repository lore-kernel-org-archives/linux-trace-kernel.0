Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC7935A948;
	Tue,  7 Apr 2026 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580801; cv=none; b=Azq/Q8Az8h8RXbIH46FHFrOc7Sf3hZvNe43mWUv+ynYpgD4iqJL1rqv+wX8DOVcB2Nsa6xGFrVOf8k2jx/MNt7UIJHOLmhkILINcrQXpr1QXRw90a++Hrtntx5juCX8wFjSLDnp+pCuz7HyIRgiqNFnWyxU9lDrcKgraLdlVfZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580801; c=relaxed/simple;
	bh=2Lv7HWSfDk06JcXpFH/v7BnnV8bcpLCE/WA2SofRaGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBb8fIfedoVzyiGQF9QkhgHCxcAQ/p/BB4ZrGzYI3ab2x3JF4ylWZiW4AIlO2t1shNo5Su6cC6QUNrnk6KBN2K+UL0bXfB/Dn4H8SARhz/POdu54jUhQIbgExgvPDFvls1AY1esJWAooubqcvrQ+GU+bQHjZe3oxdCDoC5p1u3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 80C0C5B39E;
	Tue,  7 Apr 2026 16:53:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 7E04620028;
	Tue,  7 Apr 2026 16:53:10 +0000 (UTC)
Date: Tue, 7 Apr 2026 12:54:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: CaoRuichuang <create0818@163.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Check exact trace_marker_raw payload
 lengths
Message-ID: <20260407125424.7c2d88ea@gandalf.local.home>
In-Reply-To: <20260407101245.78988-1-create0818@163.com>
References: <20260407101245.78988-1-create0818@163.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 94r3c4zp9psqjpid3megebhknrg1xstq
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 7E04620028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Kvom6OC3+xh4MOvxv6UEX/a/Y8sCtumw=
X-HE-Tag: 1775580790-17587
X-HE-Meta: U2FsdGVkX19BZIlxSmwngDeNcKYyk63XjNHONa/VJb7bZuKMcxQ9lvmXKkqz/LY3Z82G+J7suauesnHGDdG7Kggc+7Gu0ofbwhTF2qfFCvgvQ9vwb23QeAJ03m5j3Vebhzev2NNwzuAsc//FH3RWJZt5sJkiUFzRt6HU123XmKN66SFrCQqdqAalzGQGE+Ct7UmpASHyhGAAj7nj3Pil68ZO3fhkgDIvmBAwIQ2PYlDbDtWmpekKqNtJ3tsGcWihXf4shMuCcJJLxtQWCBnu6xFCO1pHlkWkTKAohAn2ijpEv7RXUpYz//zjty1LqVjw5cBkiH/kZWpeIv1AfYDZ2OSNF5ASl7z8

On Tue,  7 Apr 2026 18:12:45 +0800
CaoRuichuang <create0818@163.com> wrote:

> From: Cao Ruichuang <create0818@163.com>
> 
> trace_marker_raw.tc currently depends on awk strtonum() and
> assumes that the printed raw-data byte count is rounded up to four
> bytes.
> 
> That makes the test fail on systems that use mawk, and it no longer
> matches the raw_data trace output we want to validate after preserving
> true payload lengths for long records.
> 
> Rewrite the test to capture a small sequence of raw marker writes and
> check the exact number of printed payload bytes in order. While doing
> that, use od for the endian probe, switch to a fixed raw marker id so
> the test only varies payload length, and disable pause-on-trace while
> streaming trace_pipe.
> 

The tests are to validate the code and if the tests fail when the code is
working as designed, it is the test that is at fault, and the fix is to fix
the tests. Not to make the code match the test.

-- Steve
