Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C581437206D;
	Wed, 13 May 2026 12:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778675672; cv=none; b=ObL0b0Apfve+uQa7sgl5xDGtSrIhg98osgg3jyqw3St6mOpnWdaYvc0n2T9BVD56VFl9hn7lnuf8XhVEZ3B2NjvL4HmqLzvpQB/8s0I2BeqzLCZJ+fk/Bo9pkpAdbwrILvOGSkhfDSzHaqPvRHhOfmCCMb+wLf3ZEcc5ueTdwLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778675672; c=relaxed/simple;
	bh=k7JVC7DId8bNnOTNF10IGxxe0wXVEkhYcv5WAqIBERw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=INmOzisZZVh5BitxxbjpBvjv8mqzUG3SSX+mfSM38uZV/A/VxaW4lmzE9IT7GENyhuaYaMbPt+rmnndFaYkbic6jN8IySGaWUEv408K5R4mDseuQ2CmNMjP4qxpQ1u0mpd+I9jLLMtEzG8KHhQ9oIcwUgVnhlCZugC+WfEZ15do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 3633FA06DB;
	Wed, 13 May 2026 12:34:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 3BE4580011;
	Wed, 13 May 2026 12:34:21 +0000 (UTC)
Date: Wed, 13 May 2026 08:34:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, me@brighamcampbell.com
Subject: Re: [PATCH] tracing: Switch trace_recursion_record.c code over to
 use guard()
Message-ID: <20260513083419.0b19fcdd@fedora>
In-Reply-To: <CAPfzD4kiEMFdbK36X1_f1+Vn=v3nfvUODZJuJ40sNJ_fRr9zKA@mail.gmail.com>
References: <20260502174741.39636-1-yashsuthar983@gmail.com>
	<CAPfzD4kiEMFdbK36X1_f1+Vn=v3nfvUODZJuJ40sNJ_fRr9zKA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: mypdt3um7x1f7ifwubr98r1uzzru6jyw
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 3BE4580011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/IsQabuq6bdnQI1SJzQjexlNPceESOZQg=
X-HE-Tag: 1778675661-185094
X-HE-Meta: U2FsdGVkX1+y/69OZCuxqWOpkTqS9o1CLhswa2U7Z1Ljl2oITv1nvNCcQPoWAgFo7dah6EImgIZBMvlAaAY2F1GivyG4pT6igK6aV8SFImjzMcThyFGn7ZDp7RS9JS/70UT+N3pWivlkgj68VfXWPHUyyeJGt+hDXMYPFZJVnN2hdhQRqKZ6OXLNzxlWN6sBfN/OHeeMEpwRnVkxxM8slAP/MyAjp4dE2MMMa1bhEtWHHhxvd1bukJ3eyIEmbt0YGQT6eL9KsYXxcNNcoKalrWd5GM4de7WKwT75dMJ+Bo+jFTiB09A7m7YfBjQcF6PvHT22OaVpkBnByfkeG1yz4PKB8xRngEGjN8687NtMaElVvysP5PYNxA==

On Tue, 12 May 2026 20:11:08 +0530
Yash Suthar <yashsuthar983@gmail.com> wrote:

> Gentle ping.

Hi,

What's the rush? This is just a clean up change. There's no feature here
that you need is there?

If you see it in patchwork[1], it's not lost. I just have other things
ahead of it. I usually process cleanup code last.

Thanks,

-- Steve

[1] https://patchwork.kernel.org/project/linux-trace-kernel/patch/20260502174741.39636-1-yashsuthar983@gmail.com/
