Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF2E3D9DBF;
	Thu, 12 Mar 2026 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773330166; cv=none; b=kdtWNQUWa/IwIHn8+kdr8pLugnJi+aWORKbubn2dxHYLqO0k6fZGdNkxz9gdKN2tXYJOgOXOlDaEGgkgR4X6t/wbehaJ1tamyJNj26Q5vVIeK6Kn7vWHQvhwmw8mFRIUiY1aqIgqaVrXShCNuHkaKiWPDKhqw4jXAbIemm9qNzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773330166; c=relaxed/simple;
	bh=hoGcEXVR0bLFGASbrmSeAGPlLmiImAckP3WNgYA9Ztk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHkoDQ6mTUZrffexQ4Ht2a8ibHX2mAwizfgGeGRrrjjRClTqA0TuB4F1p2IbdptWjZForkSwaC7DYewX/DLub6Pa/5cwqJjzTtsBDNXle5uLzXTVy4EizQaar/8ZlAdZIf9D/fdtnlNJH3E0/n3ITAibT6nFqNmspc4w2VAh254=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 9A5541602BC;
	Thu, 12 Mar 2026 15:42:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 744642002D;
	Thu, 12 Mar 2026 15:42:40 +0000 (UTC)
Date: Thu, 12 Mar 2026 11:42:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Brown <broonie@kernel.org>
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>, Peter Zijlstra
 <peterz@infradead.org>, Michael Hennerich <michael.hennerich@analog.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 13/15] spi: Use trace_invoke_##name() at guarded
 tracepoint call sites
Message-ID: <20260312114254.6467c03d@gandalf.local.home>
In-Reply-To: <5d057b07-be5a-4da6-86e3-87ef4319d4b2@sirena.org.uk>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
	<20260312150523.2054552-14-vineeth@bitbyteword.org>
	<5d057b07-be5a-4da6-86e3-87ef4319d4b2@sirena.org.uk>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: wxinhqe8umhhpao4x4e5hp6kj135rsco
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 744642002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/TWQFzzTAm2EKY2g8QcsbJKGS/s7ru594=
X-HE-Tag: 1773330160-953744
X-HE-Meta: U2FsdGVkX1/R+BvAiqLZE+8ELg6vvFBWvGjr0fMLqLl00Wowq3HxnXyLJijZ5AhN1kfpmW65N0Vo/5iICn9B/JQJ6tEA4P9m5jLwyBzEYEP1IQ49vRvi3LRUd922MuJO7abGKNc8O8rjnaWGMDC+Mi1gLPpJYUDq8aKGM4An47Ym6JK0hfxMlihEFuy3ajgjRpufutiW1vOYEQJAyDKb2WwDBqo1OOde7JTKtquCUBhAYk0JYf6YaU+TWqX2xt3OcKKlFXBqOy9tRxb00Vnub327k+rf/OZu3H3XjU8xCbeKIB4MfyB3oib81a+wqdW4CJJ4prNDKdQtyZPkynhnru7lH4agz0O6

On Thu, 12 Mar 2026 15:34:20 +0000
Mark Brown <broonie@kernel.org> wrote:

> though not loving the naming here, I'll have a hard time figuring out
> what the weird call is about next time I look at that code

Would:

	trace_call__foo()

Be better?

Or do you have another name we should use?

-- Steve
