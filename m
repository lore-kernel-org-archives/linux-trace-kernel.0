Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F41625A625;
	Tue,  4 Feb 2025 07:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738655188; cv=none; b=U6pM0lWE6quFW+M9I+5Ii7bAgYXdn5j/GVw8H28FCCiATk9RoYmttNNg2PU9ZQTpJeWXLgSDz1lPEkimu3z0METCEfbQS4806OlLCmJpoDqBKflVqSZJGJlR8PSqEKqWoHnuRs+Y5lbdU/lQkU0l6K1hVRfznIQvMtW9GBi/gPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738655188; c=relaxed/simple;
	bh=fI2eQKaGs02HzhXgKi8DCztkIdWj0kh0KXHO1cjUDRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kyJoyqseeP1mej4YxX4Zjtg8gdSmIoMNjhk40g85JeonmsoZPdBg865cdabnGLqryR+dfQjbOOni/f+bNyIK1f+BXv+qMIWhtUnLAxfLjwHJTWI/Ch18L0cQfMovmRhL8PVsFFsKomuhdne4u5Ri4Bgh4v0rELeKVTI1MDxFS/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=j4yyjKpJ; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="j4yyjKpJ"
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:3f48:0:640:7695:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id C40BD60F2A;
	Tue,  4 Feb 2025 10:44:36 +0300 (MSK)
Received: from kniv-nix.yandex-team.ru (unknown [2a02:6b8:b081:b493::1:2f])
	by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id FieXFK2IguQ0-TNYxjnCc;
	Tue, 04 Feb 2025 10:44:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1738655075;
	bh=TyqgI9SrKB5qLDqRd1qPo8pZTyAku+htcku5yB3DMio=;
	h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=j4yyjKpJVRLJiVKIxy+/GvEc7ep3bq5xHL1p1J/d0mXIo6E8W4L5aaMK/DZu63lRf
	 1oaH228AeB4gGUrz5wOvcgXqww+NWV3ksPCzvdItSQmmN2srp/UyAxrJgBIMQoGwkz
	 qUJzRdTQdRgmBbmMgQge456nq8Vv95sPBdz51zwk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Nikolay Kuratov <kniv@yandex-team.ru>
To: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	Wen Yang <wenyang@linux.alibaba.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	kniv@yandex-team.ru
Subject: Re: [PATCH] ftrace: Avoid potential division by zero in function_stat_show()
Date: Tue,  4 Feb 2025 10:43:02 +0300
Message-Id: <20250204074301.1427497-1-kniv@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203100603.5c00df0f@gandalf.local.home>
References: <20250203100603.5c00df0f@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for the review!

`counter > rec->counter` check does not protect us from overflows,
so this could mislead especially with the comment included.

I think we should either eliminate overflows or only protect from zero
division. To prevent overflows it is wise to split the division into
three and forget about it. But in 32-bit case overflows will still occur.

As for zero division protection, maybe this variant even more concise?

#ifdef CONFIG_FUNCTION_GRAPH_TRACER
	seq_puts(m, "    ");

	stddev = 0;
	unsigned long denom = rec->counter * (rec->counter - 1) * 1000;
	if (denom) {
		stddev = rec->counter * rec->time_squared -
			 rec->time * rec->time;
		stddev = div64_ul(stddev, denom);
	}

	trace_seq_init(&s);
	trace_print_graph_duration(rec->time, &s);

--
My last attempt to get this email into lore with git-send-email, since
no luck with mutt. Sorry if you see this message twice or thrice in your
inbox. It won't happen again.
