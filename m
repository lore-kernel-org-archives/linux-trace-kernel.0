Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480598;
	b=fvNRAsmJNRv/NSNood4eQPYO+ErlkKKMTgjN5XxZeTgXaDR3g+20i9hKwYVmErh1oW6y
	 /xwQyrtVq+qkzAucDOxGbYAnMEa0Tz0yTrKxtq92S73j/1H7Qk3o6rIFqXD37XLvucn4v
	 mI3Xe0mn6TCviExVhDyx0+RPzaZjvNM4Vat/g8BceHn1bUj3y5k9poeN3IdWeowHILrE6
	 xvxEmBHmOR2en2EQ/n/3fxhYjfBalrbh0qYDeu2fhqTywTrujcYGWt0vblEYwTKlzC8SD
	 A+eYClKiNnqI07bE4kZtCempeAv6q6ALROKrjkuWVHiBc7C76LrUnPvHi8C1dzD3pmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480598;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=xlyHtrM/8CIMGkyqqq2BQJqRqEall6ba5k+uGkeakxY=;
	b=GDKp7QO/HIbxI+q1ME1cSpJd6uS+M4ccnHPGf+sTVDyipr86dE2LCXBp3RHCCTS2AgFK
	 L1C+BJtTQZGT7YoJVrasALfFvzFUBYR76i0PDB0Zhr0lWzmhEfl25hzR1tHI10XER/gQy
	 VW9+TAeaSHbSleDCnKyIf+ustZbY0aZiIyMRvCW8MgKzaHcFqkmctcP7uQDZ9ehsWBUCc
	 oaa+DqQWGJ+LO38Epsxcez16SI279pfBq4AqBgSZoJDy0J3ovZEAO7xc0Hw9OfAxrgJOo
	 IH9SwTi9qX/aR4KNdMEvunLTkuW77PRZQxbHBKl7IDCZpQu4lc0A13HwR4WCJ7MneYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=uPWZcocG;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D74606A327;
	Thu, 12 Nov 2026 10:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8D74606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=uPWZcocG
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id B5319A0248;
	Thu, 12 Nov 2026 10:49:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id B320720025;
	Thu, 12 Nov 2026 10:49:40 +0000 (UTC)
Date: Thu, 12 Nov 2026 05:49:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: vdonnefort@google.com, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+530af6f1e5c230588975@syzkaller.appspotmail.com
Subject: Re: [PATCH] ring-buffer: Annotate the speculative iterator event
 copy
Message-ID: <20261112054927.4f80674c@fedora>
In-Reply-To: <20261111084201.80984-1-zhujun2@cmss.chinamobile.com>
References: <20261111084201.80984-1-zhujun2@cmss.chinamobile.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: kseqsr1o1xy7qoonsqsmmwagus747irh
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: B320720025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18TZKnsSNTkFG78deU+UQllWq3qlgmV2gE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=xlyHtrM/8CIMGkyqqq2BQJqRqEall6ba5k+uGkeakxY=; b=uPWZcocG/yBDsfxuWDadakh8HoZXvnsnSl3wCb3b4BQ3DytqtibMc1qmuNQm8J3c+M6WqzCxFNcUPKM6WiEAGBHqbK6eudrncUs77mhriytKDby7XccB/dYt+pcC1raFBeAb9WRwSj9fn02/yifvi79WFejF0ptNxIllVJUuLzs=
X-HE-Tag: 1794480580-600931
X-HE-Meta: U2FsdGVkX19BmBj4eEI7nVwdGTTT7dofRZmMN3KmuSyIfVPOHdXGFfrsCWjR/Wq3uJZq0uU2usfCDKO7SQ88R6BFEa1fZY3TyvoHpoeHRTZGyH+SxniuWSXybZPQCK0pF+XVV+3e5DyEWhALcQlfyj+svs3/s0a4n/sEfXDTrp86/c4c3cPxRb4CHg4FvC7pd6EymqsX2tlku/z3V2/E7/8yWwnsMyb5RFELarU6CCLVLIE7T8ldjag/pg9E++yOwUvKLUDRxarhnSBxixDCa+Sw7sJRTsEKJ9gVkiEPYw1Olnw2b5Qy4xuqqQSMaoJPuXUKtN9Ay+CvXc1UkbVue2QP5c8iVTeN

On Wed, 11 Nov 2026 16:42:01 +0800
Zhu Jun <zhujun2@cmss.chinamobile.com> wrote:

> A non-consuming iterator can copy an event while the writer overwrites
> its page. The reader lock only excludes other readers, so KCSAN reports
> the memcpy() racing with event reservation.
> 
> The iterator already checks the page stamp and committed size after the
> copy and retries if the writer entered the page. Mark the speculative
> copy as an intentional race; only the validated private copy is used.
> 
> Fixes: 785888c544e0 ("ring-buffer: Have rb_iter_head_event() handle concurrent writer")

I agree with the change but this isn't a fix. It's just to hide a false
positive from KCSAN. You want to add a fixes tag, add the commit that
introduced KCSAN.

-- Steve
