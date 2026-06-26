Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B93288B8;
	Fri, 26 Jun 2026 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782465972; cv=none; b=eWklr7p7GvkkgZ5IhLuJmPj3xF4eX/08sL3BWE+brtSlMuPrCWt64f8ufcisjXQzjVRTrd1n4HN4rVjRtopkpXSYs9/lwj9I1tJlk1T9QE4Vq4XYKj27QVb9XiEU5xcI8b6onKggC6QM0Cg90VxlPXcxLjOulrD8Wlin5Kgvhn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782465972; c=relaxed/simple;
	bh=ESLUukbTyuXFhgfd0D/+0BdDSoyQJQSXwbpAwcEaCdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocrqiVUlNKnju2YNTzrQMNd+nMoKakc6UvzNtwvqBBi1JnzFawNuo1G8e2/dGBhMC1o04z5RtWMq2KsOevjH2Py17HwU3ZmSeBmvcKdTCt3a0hX2azvMj8w+cNXqkly2gm5v4WD4Nka/f4eLEGaE3a3sqcU1BMaQ2AkYF+SykdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LS6nu51m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tBCXf1Hk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LS6nu51m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tBCXf1Hk"
Date: Fri, 26 Jun 2026 11:26:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782465968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ESLUukbTyuXFhgfd0D/+0BdDSoyQJQSXwbpAwcEaCdQ=;
	b=LS6nu51mQxNJD0vxddn78QN7H3lj1LTRjQW+ORQiyipYcUwrVFwHEkibqkaEULhxParD8/
	iw9QTlFesyAoubBPzc7aRwLJNySviBG8aduI1U9oPb/I3Zj22ljHzgrzS8XKiVgamH6FdH
	6YDdv76Ew69tKZga7l0umA+ayuqnH1QuKvGRLCkMbHpa1vSWYajShZIyQ1ElTGGCKZzrkv
	R2tYve5VPiF6Tyz5SRTXG2EjxNbjZyG/l6+/AeNxusLzbUHX8PO9+B1ZKy833Ar5mPdi9R
	LClabLtuA9IyjYlro5oLQLIWq5T8OArDhTGnjc5FIz3kk8OPewoOC424w01CLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782465968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ESLUukbTyuXFhgfd0D/+0BdDSoyQJQSXwbpAwcEaCdQ=;
	b=tBCXf1HkCRueAn/IedC0QdVKzSvGp657mso2UypEf0p2lW9nxZySEbfa7NtcpMQAUYl6Cv
	Nr5yoNpBzC2jLvDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	akpm@linux-foundation.org, vbabka@kernel.org, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, david@kernel.org, ljs@kernel.org,
	liam@infradead.org, rppt@kernel.org, clrkwllms@kernel.org,
	Alexander.Krabler@kuka.com
Subject: Re: [RFC PATCH 1/3] mm/compaction: skip isolate mlocked folios when
 compact_unevictable_allowed=0
Message-ID: <20260626092606.7BgipTin@linutronix.de>
References: <20260604023812.3700316-1-chenwandun1@gmail.com>
 <20260604023812.3700316-2-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260604023812.3700316-2-chenwandun1@gmail.com>

On 2026-06-04 10:38:10 [+0800], Wandun Chen wrote:
=E2=80=A6
> Reported-by: Alexander Krabler <Alexander.Krabler@kuka.com>
> Closes: https://lore.kernel.org/all/DU0PR01MB10385345F7153F33410098188825=
9A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com/
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Link: https://lore.kernel.org/all/33275585-f2db-4779-89f0-3ae24b455a67@su=
se.cz/ [1]

Is it possible to get a Fixes tag on the final fix so that it can be
backported stable?

Sebastian
