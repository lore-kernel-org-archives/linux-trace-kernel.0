Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E582015199C;
	Wed,  5 Feb 2025 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738754574; cv=none; b=tFUFEmBbS1sFXFUPwgLMsP0eQ4HTVUFN2zFahqs4dnPntv+q6g7laT6IHUcUvuwnh/grwp18wwvzCN5pom4vfLzFivnykRYh/GNmq8cS0u6bOIuhRmw3za0eoa/Z3KuZ7XbM8qm047hwyfcGfwd7+7ELa/2vS75Q+sjpmYLL73Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738754574; c=relaxed/simple;
	bh=QyEvI/N3ipcbkcYsMn/d6GIelXG2WQ5kG+9qYHmu/9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g/gUyd5/UljBXT/7XqM2vE1tInjLNDesNH/WvgMIXMc505dlUyvYSjuvp8HZC/PcIy3g8hNQgYB9/C7sLuurgjiZM09cX+QgxH5sXsrQ0O1TspNsXBBD4k0xlTN4fEldvGkkzxNgvTZJYGmkXfsr6GcJlVdrn/S4Ftu6pMKmLsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=tIQ7+reK; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="tIQ7+reK"
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:3f48:0:640:7695:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 8F91360AA6;
	Wed,  5 Feb 2025 14:22:40 +0300 (MSK)
Received: from kniv-nix.yandex-team.ru (unknown [2a02:6b8:b081:5::1:34])
	by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id tLjOom2IcOs0-0u7j7gwt;
	Wed, 05 Feb 2025 14:22:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1738754559;
	bh=QyEvI/N3ipcbkcYsMn/d6GIelXG2WQ5kG+9qYHmu/9I=;
	h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=tIQ7+reK7AeCN1t0TBACr0/dqTSrJaGdDKzg5hXfSy6dO7RYcojz6Lx0msEowa1TU
	 7V0VW/24VulPUKneWWidKP8RmGRqicoBB8jjLVWZSJMkoOz806c11SmYgpodz6XSqE
	 yG9MzXzZmisjRYm+ryh7uHw1if9h3llgWkNI0g6E=
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
Date: Wed,  5 Feb 2025 14:21:54 +0300
Message-Id: <20250205112154.1541872-1-kniv@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205103929.1538065-1-kniv@yandex-team.ru>
References: <20250205103929.1538065-1-kniv@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Oops, this still does not fix an overflow because of

> rec->time_square_sum += calltime * calltime;

We can't eliminate overflows easily without both using u64 and converting
ns to us prior to any squaring. I will send an appropriate patch later
if needed. Maybe we're a way too paranoid about overflows and really want
only not to divide by zero?
