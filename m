Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E6F2475CF;
	Mon, 26 Jan 2026 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769438348; cv=none; b=QgGke8r8BABunvYo50gyzPTLUYIyYaNrqwY/Ouk/+KsoIjz59LfeSOy8X0XMdrUBhKBzmPiPO8K60r/SFn/eUCxmXzHKvDyH07ddYdNigPKEUk7zpGDRPOS02OvjJARdXFzsxvPQTl10B/X2naUUehTH/0pWRjvIJceCVWsgrBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769438348; c=relaxed/simple;
	bh=fjUOlUtti3A0+przetAX49u1G5k51hin5MwBYZEKkiI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XkEiA8oHBy7Hx1cv3QggxaxAFPVYqOTYebsFVV3ILMmclzxdemg3W512pNjnTr2qIVP5cB4vgPm6sEmoezjCNnw7wORiCkW/1qI91BrXBJ7pjCCCQI7oaI0ANV7GHJ1X2Qhy1t7jGfwvC43WrK4tO6ISDhhpl/prpBMDzYO4u1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 587F75AE15;
	Mon, 26 Jan 2026 14:38:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 86EE420027;
	Mon, 26 Jan 2026 14:38:57 +0000 (UTC)
Date: Mon, 26 Jan 2026 09:38:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: sunliming <sunliming@linux.dev>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, sunliming
 <sunliming@kylinos.cn>
Subject: Re: [PATCH] tracing: kprobe-event: Return directly when
 dyn_event_list is empty
Message-ID: <20260126093859.2fef7731@gandalf.local.home>
In-Reply-To: <78dbbd83-8de3-2031-6db7-036d0d8c11c5@linux.dev>
References: <20260123013641.23066-1-sunliming@linux.dev>
	<20260124120233.17926a82@robin>
	<01b1d5a3-8be0-4d9a-45d4-4da7c3edf746@linux.dev>
	<20260125232139.0e971011@robin>
	<78dbbd83-8de3-2031-6db7-036d0d8c11c5@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 86EE420027
X-Stat-Signature: b7zq5hk9tifdapt3s6xdm5sxxnti69no
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/SWODZaX9GP3i0ViXfcguCqtYbynyFBvU=
X-HE-Tag: 1769438337-382085
X-HE-Meta: U2FsdGVkX19VYHl17GttIfz3nDrb6UxQiqDpIoSb0/Cnedx0rrgvwlWPqdDYatUxE35fjBKxeU7cCwUwj173nVJK0IUaJE1AMVhpFBTOL9hF7hSrSSY3U1APQ5P08jjs+CdRCZewfLP0x5DVT0lJHrBN97oPpfB66DXa97zEwgzhETsIvIwn0K3TbsZr9LwRDSa9PeTHeUiT3VOxrK36FL1YS+FWdWcLyQ0HdS/smP1La+JrMnQet1zR5MIF4ugksvTuW5jd1lt7XLc/1ECbo9qZhCbwYu4gE/O4NRo1uq8pM5+18SNJbct6H0BhepdzM9vw20SpJova0cG2bHhR8aSjRX0wXmNt

On Mon, 26 Jan 2026 15:17:28 +0800
sunliming <sunliming@linux.dev> wrote:

> Alternatively, could both optimization solutions coexist (as lock 
> contention may

Yes, the two are orthogonal to each other, and can go in on their own merit.

-- Steve
